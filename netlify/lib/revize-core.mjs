// Revize paneli API'sinin mantığı. Depolama dışarıdan verilir, böylece test edilebilir.

const VIDEO_RE = /^[\w-]{11}$/;
const MAX_TEXT = 2000;
const MAX_AUTHOR = 60;

const json = (data, status = 200) =>
  new Response(JSON.stringify(data), {
    status,
    headers: { "content-type": "application/json; charset=utf-8", "cache-control": "no-store" }
  });

function safeEqual(a, b) {
  if (typeof a !== "string" || typeof b !== "string" || a.length !== b.length) return false;
  let diff = 0;
  for (let i = 0; i < a.length; i++) diff |= a.charCodeAt(i) ^ b.charCodeAt(i);
  return diff === 0;
}

function roleFor(key, env) {
  if (env.adminPassword && safeEqual(key, env.adminPassword)) return "admin";
  if (env.clientPassword && safeEqual(key, env.clientPassword)) return "client";
  return null;
}

async function readNotes(store, v) {
  const { blobs } = await store.list({ prefix: `notes/${v}/` });
  const notes = await Promise.all(blobs.map(b => store.get(b.key, { type: "json" })));
  return notes.filter(Boolean).sort((a, b) => a.t - b.t);
}

async function touchProject(store, v) {
  await store.setJSON(`projects/${v}`, { v, updated: Date.now() });
}

async function readProjects(store) {
  const [{ blobs: projectBlobs }, { blobs: noteBlobs }] = await Promise.all([
    store.list({ prefix: "projects/" }),
    store.list({ prefix: "notes/" })
  ]);
  const counts = {};
  noteBlobs.forEach(b => {
    const v = b.key.split("/")[1];
    counts[v] = (counts[v] || 0) + 1;
  });
  const projects = await Promise.all(projectBlobs.map(b => store.get(b.key, { type: "json" })));
  return projects
    .filter(Boolean)
    .map(p => ({ ...p, count: counts[p.v] || 0 }))
    .sort((a, b) => b.updated - a.updated);
}

export async function handle(req, { store, env }) {
  if (!env.clientPassword) return json({ error: "REVIZE_PASSWORD ayarlanmamış." }, 500);

  const role = roleFor(req.headers.get("x-revize-key") || "", env);
  if (!role) return json({ error: "Şifre yanlış." }, 401);

  const url = new URL(req.url);

  if (req.method === "GET") {
    if (url.searchParams.has("ping")) return json({ ok: true, role });
    if (url.searchParams.has("projects")) {
      if (role !== "admin") return json({ error: "Bu liste sadece yöneticiye açık." }, 403);
      return json({ projects: await readProjects(store) });
    }
    const v = url.searchParams.get("v") || "";
    if (!VIDEO_RE.test(v)) return json({ error: "Geçersiz video." }, 400);
    return json({ notes: await readNotes(store, v) });
  }

  let body;
  try { body = await req.json(); } catch (e) { return json({ error: "Geçersiz istek." }, 400); }
  const v = body && body.v;
  if (!VIDEO_RE.test(v || "")) return json({ error: "Geçersiz video." }, 400);

  if (req.method === "POST") {
    const t = Number(body.t);
    const text = typeof body.text === "string" ? body.text.trim() : "";
    const author = typeof body.author === "string" ? body.author.trim().slice(0, MAX_AUTHOR) : "";
    if (!Number.isFinite(t) || t < 0 || t > 86400) return json({ error: "Geçersiz zaman." }, 400);
    if (!text || text.length > MAX_TEXT) return json({ error: "Not boş ya da çok uzun." }, 400);
    const id = crypto.randomUUID();
    await store.setJSON(`notes/${v}/${id}`, {
      id, t: Math.round(t * 10) / 10, text, author, done: false, created: Date.now()
    });
    await touchProject(store, v);
    return json({ notes: await readNotes(store, v) }, 201);
  }

  const id = typeof body.id === "string" ? body.id : "";
  if (!/^[\w-]{1,64}$/.test(id)) return json({ error: "Geçersiz not." }, 400);
  const key = `notes/${v}/${id}`;
  const note = await store.get(key, { type: "json" });
  if (!note) return json({ error: "Not bulunamadı." }, 404);

  if (req.method === "PATCH") {
    if ("done" in body) {
      if (role !== "admin") return json({ error: "Sadece yönetici işaretleyebilir." }, 403);
      note.done = !!body.done;
    }
    if ("text" in body) {
      const text = typeof body.text === "string" ? body.text.trim() : "";
      if (!text || text.length > MAX_TEXT) return json({ error: "Not boş ya da çok uzun." }, 400);
      note.text = text;
    }
    await store.setJSON(key, note);
    await touchProject(store, v);
    return json({ notes: await readNotes(store, v) });
  }

  if (req.method === "DELETE") {
    await store.delete(key);
    await touchProject(store, v);
    return json({ notes: await readNotes(store, v) });
  }

  return json({ error: "Desteklenmeyen istek." }, 405);
}
