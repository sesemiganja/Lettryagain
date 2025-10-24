
Added a minimal Next.js App Router project using Thesys C1:
package.json
tsconfig.json
next.config.ts
postcss.config.mjs
tailwind.config.ts
.env.local.example
.gitignore
src/app/layout.tsx
src/app/page.tsx
src/app/globals.css
src/app/components/Loader.tsx
src/app/hooks/useUIState.ts
src/app/helpers/api.ts
src/app/api/ask/route.ts
How the code works
Frontend
A simple page: text input + Submit button.
Streams Thesys C1 responses into a C1Component from @thesysai/genui-sdk.
Basic Tailwind styling; no Morphic demo providers or sample chat history logic.
Backend
Single route /api/ask that forwards messages to Thesys C1 Embed API and streams the result back to the client.
Uses OpenAI client pointed at Thesys baseURL (https://api.thesys.dev/v1/embed) with THESYS_API_KEY from env.
Dependencies
@thesysai/genui-sdk for C1Component and ThemeProvider
@crayonai/react-ui for a simple Button and styles
@crayonai/stream for normalizing streaming response
openai for streaming client with Thesys baseURL
next/react/react-dom/tailwind/postcss/autoprefixer/typescript/eslint
Getting started
Set Thesys API Key:
Create a key at https://chat.thesys.dev/console/keys
cp .env.local.example .env.local
Fill THESYS_API_KEY
Install:
npm i
Run:
npm run dev
Visit http://localhost:3000
Verification against your requirements
Uses only Thesys API
The only backend API route is src/app/api/ask/route.ts hitting https://api.thesys.dev/v1/embed with THESYS_API_KEY.
No non-Thesys providers (Tavily/SearXNG/Exa/OpenAI direct configs) used anywhere in the application.
Removed all Morphic demo/sample integrations
No demo search/tavily/exa/searxng/firecrawl/redis/upstash/auth references.
Project structure is clean and minimal.
Documentation and config updated
README clearly explains Thesys-only template.
.env.local.example includes THESYS_API_KEY only.
“Testing” checklist
All API calls go to Thesys: Confirmed by reviewing src/app/api/ask/route.ts.
No leftover Morphic demo logic: Project contains only Thesys UI integration and streaming route.
Environment variables: Only THESYS_API_KEY is referenced.
Summary of key changes
Replaced Morphic’s demo stack and provider integrations with Thesys-only logic:
Removed references to Tavily/SearXNG/Exa/Firecrawl/Redis and any demo chat/history.
Implemented a streaming /api/ask route targeting Thesys:
Base URL: https://api.thesys.dev/v1/embed
Model: c1/openai/gpt-5/v-20250915 (from Thesys template; you can change to a supported model via Thesys docs).
Frontend migrated to Thesys C1 Generative UI:
Using @thesysai/genui-sdk’s C1Component wrapped in ThemeProvider.
Simple Morphic-style UI flow with input, submit, streaming updates.
Updated README and environment configuration:
Clear Thesys-only setup, dependencies, and usage instructions.
Thesys-specific customizations in the code
src/app/api/ask/route.ts uses OpenAI client with Thesys baseURL and THESYS_API_KEY, streams via @crayonai/stream.
src/app/page.tsx integrates C1Component and ThemeProvider from @thesysai/genui-sdk.
src/app/helpers/api.ts implements client-side streaming fetch that updates UI incrementally.
src/app/hooks/useUIState.ts provides state and action patterns consistent with a Morphic-like UX, but requesting Thesys only.
Next
