export const config = {
  matcher: "/admin/:path*",
};

export default function middleware(request) {
  const auth = request.headers.get("authorization");

  if (auth) {
    const [scheme, encoded] = auth.split(" ");
    if (scheme === "Basic" && encoded) {
      const decoded = atob(encoded);
      const [user, pass] = decoded.split(":");
      if (user === process.env.ADMIN_USER && pass === process.env.ADMIN_PASS) {
        return;
      }
    }
  }

  return new Response("Authentication required", {
    status: 401,
    headers: { "WWW-Authenticate": 'Basic realm="thewittyswan admin"' },
  });
}