import { writable } from "svelte/store";

/** Returns boolean value of if the resource is visible or not */
export const visibility = writable(false);
export const config = writable<any>(null);
export const language = writable<any>(null);
export const firstMenu = writable<any>(null);
export const editMenu = writable<any>(null);
export const editable = writable<any>(null);
export const defaults = writable<any>(null);