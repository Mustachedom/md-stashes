<script lang="ts">
  import { config, language } from '../store/stores';
  import { fetchNui } from '../utils/fetchNui';
  import { firstMenu } from '../store/stores';
  let selectedOption = '';
  let selectedObject = '';
  
  function handleSubmit() {
    let payload;
    if (selectedOption === 'coords') {
      payload = { type: 'coords', object: false };
    } else if (selectedOption === 'object') {
      payload = { type: 'object', object: selectedObject };
    }
    console.log(JSON.stringify(payload));
    if (payload) {
      fetchNui('submitSelection', payload);
      
      firstMenu.set(false);
      fetchNui('hideUI');
    }
  }
  function handleCancel() {
    selectedOption = '';
    selectedObject = '';
  }
</script>

<div class="select-container">
  <div class="select-group">
    <label for="main-option" class="select-label">{ $language.Ui.select.header }</label>
    <div class="select-wrapper">
      <select
        id="main-option"
        bind:value={selectedOption}
        class="select-input"
      >
        <option value="" disabled selected>{ $language.Ui.select.option1head }</option>
        <option value="coords">{ $language.Ui.select.option1coords }</option>
        <option value="object">{ $language.Ui.select.option1object }</option>
      </select>
    </div>
  </div>

  {#if selectedOption === 'object'}
    <div class="select-group">
      <label for="object-option" class="select-label">{ $language.Ui.select.objHead }</label>
      <div class="select-wrapper">
        <select
          id="object-option"
          bind:value={selectedObject}
          class="select-input"
        >
          <option value="" disabled selected>{ $language.Ui.select.objDesc }</option>
          {#each $config as item}
            <option value={item.value}>{item.label}</option>
          {/each}
        </select>
      </div>
    </div>
  {/if}

  {#if selectedOption}
    <div class="button-group">
      <button on:click={handleCancel} class="btn cancel">{ $language.Ui.select.cancel }</button>
      <button
        on:click={handleSubmit}
        class="btn submit"
        disabled={selectedOption === 'object' && !selectedObject}
      >
        { $language.Ui.select.submit }
      </button>
    </div>
  {/if}
</div>

<style>
  .select-container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    padding: 24px;
    background: #1a1a1a;
    border: 1px solid #333333;
    border-radius: 16px;
    width: 19%;
    margin: 40px auto;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #f0f0f0;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.6), 0 10px 10px -5px rgba(0, 0, 0, 0.4); 
  }

  .select-group {
    margin-bottom: 20px;
  }

  .select-label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #ffffff;
    letter-spacing: 0.025em;
  }

  .select-wrapper {
    position: relative;
  }

  .select-input {
    width: 100%;
    padding: 14px 16px;
    font-size: 16px;
    border: 2px solid #333333;
    border-radius: 12px;
    background: #000000;
    color: #ffffff;
    outline: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-sizing: border-box;
  }

  .select-input:focus {
    border-color: #ffffff;
    background: #1a1a1a;
    box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.1),0 1px 3px 0 rgba(0, 0, 0, 0.3);
    transform: translateY(-1px);
  }

  .button-group {
    display: flex;
    gap: 12px;
    margin-top: 24px;
  }

  .btn {
    flex: 1;
    padding: 12px;
    font-size: 16px;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .btn.cancel {
    background: #dc2626;
    color: white;
  }

  .btn.cancel:hover {
    background: #b91c1c;
  }

  .btn.submit {
    background: rgb(64, 194, 4);
    color: white;
  }
  .btn.submit:hover {
    background: rgb(22, 163, 4);
  }



</style>