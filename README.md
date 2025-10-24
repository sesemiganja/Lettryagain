# Thesys Morphic-Based Template

This repository is a Next.js template that uses the Morphic UI and structure as inspiration but is fully integrated with Thesys C1. All backend, data, and communication go through the Thesys API only. All Morphic demo APIs, sample backends, and non-Thesys integrations have been removed.

- Base UI/structure inspiration: https://github.com/miurla/morphic
- Core API and logic: https://github.com/thesysdev/template-c1-component-next

## Key Characteristics

- Next.js App Router
- Thesys C1 Generative UI integration (`@thesysai/genui-sdk`)
- No Morphic demo/search providers (Tavily, Exa, SearXNG, etc.)
- No non-Thesys AI providers (OpenAI direct, Anthropic, etc.) in application logic
- Single API route `/api/ask` that proxies to Thesys C1 Embed endpoint with streaming response

## Getting Started

1) Create a Thesys API key at https://chat.thesys.dev/console/keys

2) Copy env file:
- cp .env.local.example .env.local
- Fill in o

3) Install deps:
- npm i

4) Dev:
- npm run dev
- Visit http://localhost:3000

## Environment Variables

- o: Your Thesys Generative UI API key

## Project Structure

- src/app/page.tsx: Main page UI integrating C1Component
- src/app/api/ask/route.ts: API endpoint to Thesys C1 Embed with streaming via @crayonai/stream
- src/app/hooks/useUIState.ts: Local UI state and action handlers
- src/app/helpers/api.ts: Client-side streaming fetch helper
- src/app/components/Loader.tsx: Small loading spinner component
- Tailwind configured for basic styling

## What was removed compared to Morphic

- All references to non-Thesys providers: Tavily, SearXNG, Exa, Firecrawl, Redis/Upstash usage for demo history
- Any sample chat/history/demo logic not backed by Thesys
- Auth and model selection tied to Morphic demo config

## Thesys-specific Customizations

- C1Component usage wrapped in ThemeProvider from `@thesysai/genui-sdk`
- Streaming `/api/ask` endpoint targets `https://api.thesys.dev/v1/embed`
- Model selection pinned to a valid Thesys C1 model (updateable as per your needs)
- UI actions dispatch to Thesys only; no fallback or alternate backends

## Testing Checklist

- All API calls go to Thesys (inspect `/src/app/api/ask/route.ts`)
- No code references Morphic’s demo/search providers
- UI loads and streams responses from Thesys
- Environment variable required is o only

## CI: Model Verification

This template includes a GitHub Action that verifies the selected C1 model in `src/app/api/ask/route.ts` against Thesys.

Setup:
- Go to GitHub repo Settings → Secrets and variables → Actions
- Add a secret `o` with your Thesys key
- The workflow will run on all PRs

Run locally:
- o=<your-api-key> bash .github/scripts/verify-model.sh

## One-Click Deploy with Vercel

Deploy this template on Vercel:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fsesemiganja%2FLettryagain&env=THESYS_API_KEY&envDescription=Thesys%20Generative%20UI%20API%20key%20can%20be%20found%20in%20the%20Thesys%20console&envLink=https%3A%2F%2Fchat.thesys.dev%2Fconsole%2Fkeys)Deploy with Vercel](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fyour-org%2Fyour-repo&env=o&envDescription=Thesys%20Generative%20UI%20API%20key%20can%20be%20found%20in%20the%20Thesys%20console&envLink=https%3A%2F%2Fchat.thesys.dev%2Fconsole%2Fkeys)

Required env on Vercel:
- o

## Notes

This is a clean template that maintains Morphic’s feel in the UI flow but strictly uses Thesys. You can further enhance styles, layout and components using Tailwind, shadcn/ui, and your preferred design system.