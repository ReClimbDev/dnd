# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

**@hello-pangea/dnd** is a React library for beautiful, accessible drag-and-drop functionality for lists. It's a community-maintained fork of react-beautiful-dnd, focused on providing powerful drag-and-drop primitives specifically for lists (vertical, horizontal, and cross-list movement).

**Key Technologies:** React, TypeScript, Redux, Rollup, Jest, Cypress, Storybook, pnpm

## Development Commands

### Package Management
- **Install dependencies:** `pnpm install`
- **Package manager:** This project uses `pnpm` (version 10.2.1)

### Building
- **Build library:** `pnpm build` (cleans and builds distribution files)
- **Build clean:** `pnpm build:clean` (removes dist directory)
- **Build distribution:** `pnpm build:dist` (creates production build with Rollup)

### Testing
- **Run all tests:** `pnpm test` 
- **Run tests with coverage:** `pnpm test:coverage`
- **Test with React 18:** `pnpm test:react-18`
- **Test with React 19:** `pnpm test:react-19`
- **Browser tests (interactive):** `pnpm test:browser`
- **Browser tests (CI):** `pnpm test:browser:ci`
- **Single test file:** `pnpm test <file-pattern>` or `jest <file-pattern>`
- **Accessibility testing:** `pnpm test:accessibility` (requires Storybook server running)

### Code Quality
- **Run all validation:** `pnpm validate` (prettier, eslint, css lint, typecheck)
- **Format code:** `pnpm prettier:write`
- **Check formatting:** `pnpm prettier:check`
- **Lint JavaScript/TypeScript:** `pnpm lint:eslint`
- **Lint CSS:** `pnpm lint:css`
- **Type checking:** `pnpm typecheck` (checks lib, test, storybook)

### Development Server
- **Start Storybook:** `pnpm storybook` (runs on port 9002)
- **Build Storybook:** `pnpm build-storybook`

### Bundle Analysis
- **Check bundle size:** `pnpm bundle-size:check`
- **Update bundle size snapshots:** `pnpm bundle-size:update`

### Release
- **Commit with conventional commits:** `pnpm commit`
- **Release (dry run):** `pnpm release:test`
- **Release:** `pnpm release`

## Architecture Overview

### Core Library Structure

**Entry Point:** `src/index.ts` - Exports main components and types

**Main Components:**
- `DragDropContext` - Root wrapper component that enables drag-and-drop for child components
- `Draggable` - Makes items draggable within lists
- `Droppable` - Defines areas where draggable items can be dropped

### Key Directories

**`src/`** - Main source code
- `types.ts` - Core TypeScript type definitions
- `view/` - React components and hooks
  - `drag-drop-context/` - Context provider logic
  - `draggable/` - Draggable component implementation  
  - `droppable/` - Droppable component implementation
  - `use-sensor-marshal/` - Input handling (mouse, touch, keyboard)
- `state/` - Redux-based state management
  - `action-creators.ts` - Redux actions
  - `reducer.ts` - Main state reducer
  - `middleware/` - Redux middleware
  - `auto-scroller/` - Auto-scrolling logic during drags

**`test/`** - Jest unit tests
- `unit/` - Component and utility tests
- `setup/` - Test environment configuration

**`cypress/`** - End-to-end browser tests

**`stories/`** - Storybook examples and documentation

### State Management Architecture

The library uses Redux for internal state management:
- **Store:** Manages drag state, positions, and animations
- **Actions:** Handle drag lifecycle events (start, update, end)
- **Middleware:** Handles side effects like auto-scrolling and accessibility announcements
- **Sensors:** Input detection system for mouse, touch, and keyboard interactions

### Build System

**Rollup Configuration:** `rollup.config.mjs`
- Creates multiple build targets: UMD, CommonJS, ESM, and TypeScript definitions
- Uses Babel for TypeScript compilation
- Generates both development and minified production builds

## React Version Support

- Supports React 18.x and 19.x
- Tests run against both versions
- React 18 dependencies aliased as `react-18` and `react-dom-18`

## Testing Strategy

**Unit Tests (Jest):**
- Component rendering and behavior
- State management logic
- Utility functions
- React version compatibility testing

**Integration Tests (Cypress):**
- Full drag-and-drop workflows
- Browser compatibility
- Accessibility compliance

**Visual Testing:**
- Storybook for component examples
- Chromatic for visual regression testing

## Development Notes

### Key Patterns
- Uses Redux for internal state management (not exposed to consumers)
- Render prop pattern for `Draggable` and `Droppable` components
- Context API for component communication
- Custom hooks for sensor handling and state management
- Memoization patterns for performance optimization

### Performance Considerations
- Uses `useMemo` and `useCallback` extensively for optimization
- Custom `memoize-one` implementation for specific use cases
- RAF (requestAnimationFrame) scheduling for smooth animations
- Efficient DOM measurements and updates

### Accessibility Features
- Screen reader support with customizable announcements
- Keyboard navigation support
- Focus management during drag operations
- ARIA attributes for assistive technologies

## Commit Conventions

This project uses **Conventional Commits** with Commitizen:
- Use `pnpm commit` for guided commit creation
- Follows semantic versioning based on commit types
- Automated changelog generation

## Important Files

- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript configuration
- `jest.config.ts` - Test configuration  
- `cypress.config.ts` - E2E test configuration
- `.storybook/main.ts` - Storybook configuration
- `rollup.config.mjs` - Build configuration
