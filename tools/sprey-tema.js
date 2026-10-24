    /* ---------- Sprey boya: noktacıklarla gerçek sprey izi çizer ---------- */
    (function () {
      function paint(ctx, w, h, clouds) {
        for (const cl of clouds) {
          const n = cl.n || 8000;
          const r0 = cl.r * Math.min(w, h);
          for (let i = 0; i < n; i++) {
            const a = Math.random() * Math.PI * 2;
            const over = Math.random() < 0.07 ? 1.7 : 1;
            const r = r0 * Math.pow(Math.random(), 0.7) * over;
            const px = cl.x * w + Math.cos(a) * r * (cl.sx || 1);
            const py = cl.y * h + Math.sin(a) * r * (cl.sy || 1);
            const big = Math.random() < 0.015;
            const s = big ? 1.4 + Math.random() * 2.6 : 0.5 + Math.random() * 1.1;
            ctx.globalAlpha = Math.max(0, (cl.a || 0.5) * (1 - r / (r0 * 1.8)));
            ctx.fillStyle = cl.c;
            ctx.beginPath();
            ctx.arc(px, py, s, 0, 6.2832);
            ctx.fill();
          }
        }
      }

      function image(w, h, clouds) {
        const c = document.createElement("canvas");
        c.width = w;
        c.height = h;
        paint(c.getContext("2d"), w, h, clouds);
        return `url(${c.toDataURL("image/png")})`;
      }

      const CHERRY = "#d42c4a", MUSTARD = "#f2b83b";
      const root = document.documentElement.style;
      root.setProperty("--spray-tag-cherry", image(700, 220, [{ x: 0.5, y: 0.5, r: 0.36, sx: 2.6, sy: 0.75, c: CHERRY, a: 0.6, n: 9000 }]));
      root.setProperty("--spray-tag-mustard", image(700, 220, [{ x: 0.5, y: 0.5, r: 0.36, sx: 2.6, sy: 0.75, c: MUSTARD, a: 0.55, n: 9000 }]));
      root.setProperty("--spray-cta", image(1200, 520, [
        { x: 0.18, y: 0.2, r: 0.45, sx: 1.6, c: CHERRY, a: 0.45, n: 14000 },
        { x: 0.85, y: 0.85, r: 0.4, sx: 1.5, c: MUSTARD, a: 0.3, n: 10000 }
      ]));

      /* Sayfanın arkasındaki sprey bulutları */
      const bg = document.createElement("canvas");
      bg.id = "sprayBg";
      bg.setAttribute("aria-hidden", "true");
      document.body.prepend(bg);

      function drawBg() {
        const w = bg.width = Math.min(window.innerWidth, 1800);
        const h = bg.height = Math.min(window.innerHeight, 1200);
        const ctx = bg.getContext("2d");
        ctx.clearRect(0, 0, w, h);
        paint(ctx, w, h, [
          { x: 0.08, y: 0.12, r: 0.42, sx: 1.3, c: CHERRY, a: 0.32, n: 16000 },
          { x: 0.95, y: 0.45, r: 0.36, sy: 1.2, c: MUSTARD, a: 0.18, n: 11000 },
          { x: 0.55, y: 1.02, r: 0.3, sx: 1.8, c: CHERRY, a: 0.18, n: 9000 }
        ]);
      }

      drawBg();
      let t;
      window.addEventListener("resize", () => { clearTimeout(t); t = setTimeout(drawBg, 250); });
    })();
