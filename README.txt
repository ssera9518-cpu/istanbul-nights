ISTANBUL NIGHTS — complete starter project
==========================================
Files:
- index.html        public homepage
- profile.html      individual profile page
- admin.html        private admin interface
- supabase-schema.sql  database + Storage policies
- sitemap.xml       replace YOUR-DOMAIN.example after domain connection
- robots.txt        replace YOUR-DOMAIN.example after domain connection

IMPORTANT:
1. Run supabase-schema.sql in the SQL Editor of the Istanbul Nights Supabase project.
2. Create an admin user in Supabase Authentication.
3. Put the Supabase Project URL and publishable/anon key into the three HTML files where SUPABASE_URL and SUPABASE_ANON_KEY are defined.
4. Do NOT use a service_role key in browser files.
5. The admin page is protected by Supabase Auth. It is also excluded from search engines.
6. The current profile images are temporary placeholders. Replace them with real photos through the final Storage upload flow.
7. The final production sitemap should be generated from the real public profile URLs after the domain is connected.
