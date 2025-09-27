import { debugData } from './debugData';
import { isEnvBrowser } from './misc';
import { config, language, defaults} from '../store/stores';
import DevControls from '../components/DevControls.svelte';

export const mockStashData = [
  { 
    id: 1, 
    name: "police_locker", 
    loc: JSON.stringify({ x: 461.8, y: -985.3, z: 30.7 }), 
    data: JSON.stringify({ object: false }),
    job: "police" 
  },
  { 
    id: 2, 
    name: "gang_stash", 
    loc: JSON.stringify({ x: 123.4, y: -456.7, z: 28.1 }), 
    data: JSON.stringify({ object: "prop_container_01a" }),
    gang: "ballas" 
  },
  { 
    id: 3, 
    name: "personal_safe", 
    loc: JSON.stringify({ x: -789.1, y: 234.5, z: 15.2 }), 
    data: JSON.stringify({ object: "prop_ld_int_safe_01" }),
    password: true 
  }
];

export const mockConfig = [
  { value: "prop_container_01a", label: "Small Container" },
  { value: "prop_container_01b", label: "Medium Container" },
  { value: "prop_ld_int_safe_01", label: "Safe" },
  { value: "prop_toolchest_01", label: "Tool Chest" },
  { value: "prop_locker_01", label: "Locker" },
  { value: "prop_crate_01a", label: "Wooden Crate" }
];

export const mockLanguage = {
  Ui: {
    create: {
      header: "Create Stash",
      name: "Stash Name",
      job: "Job",
      jobRank: "Job Rank",
      gang: "Gang",
      gangRank: "Gang Rank",
      item: "Required Item",
      identifier: "Identifier",
      weight: "Max Weight",
      slots: "Slots",
      password: "Password",
      submit: "Create Stash",
      reset: "Reset",
      cancel: "Cancel"
    },
    select: {
      header: "Select Stash Type",
      option1head: "Choose an option",
      option1coords: "Create at coordinates",
      option1object: "Create on object",
      objHead: "Select Object",
      objDesc: "Select an object",
      submit: "Confirm Selection",
      cancel: "Cancel"
    },
    edit: {
      header: "Edit Stash",
      id: "ID",
      obj: "Object",
      coords: "Coordinates",
      del: "Delete",
      go2: "Go To",
      changeLoc: "Change Location",
      edit: "Edit"
    }
  }
};

export const mockDefaults = {
  maxWeight: 100000,
  slots: 50
};

/**
 * Initialize development browser environment
*/
export const initDevEnvironment = (): void => {
  if (isEnvBrowser()) {
    debugData([
      {
        action: 'setVisible',
        data: true,
      },
    ]);

    config.set(mockConfig);
    language.set(mockLanguage);
    defaults.set(mockDefaults);

    new DevControls({
      target: document.body
    });
    
    if (typeof window !== 'undefined') {
      (window as any).showSelectMenu = () => {
        debugData([
          { action: 'setVisible', data: true },
          { action: 'firstMenu', data: true }
        ], 100);
      };
      
      (window as any).showEditMenu = () => {
        debugData([
          { action: 'setVisible', data: true },
          { action: 'editMenu', data: mockStashData }
        ], 100);
      };
      
      (window as any).showCreateStash = () => {
        debugData([
          { action: 'setVisible', data: true },
          { action: 'firstMenu', data: false },
          { action: 'editMenu', data: false }
        ], 100);
      };
      
      (window as any).hideAll = () => {
        debugData([
          { action: 'setVisible', data: false },
          { action: 'firstMenu', data: false },
          { action: 'editMenu', data: false }
        ], 100);
      };
    }
  }
};