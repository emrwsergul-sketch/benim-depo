// Revize paneli API'si: /api/revize
// Netlify panelinde şu ortam değişkenleri tanımlanmalı:
//   REVIZE_PASSWORD        → müşterilerin kullanacağı şifre
//   REVIZE_ADMIN_PASSWORD  → senin şifren (tüm projeleri görür, notları "yapıldı" işaretler)
import { getStore } from "@netlify/blobs";
import { handle } from "../lib/revize-core.mjs";

export default async req =>
  handle(req, {
    store: getStore({ name: "revize", consistency: "strong" }),
    env: {
      clientPassword: Netlify.env.get("REVIZE_PASSWORD"),
      adminPassword: Netlify.env.get("REVIZE_ADMIN_PASSWORD")
    }
  });

export const config = { path: "/api/revize" };
