command: "ps axro \"pid, %cpu, ucomm\" | awk 'FNR>1' | head -n 5 | awk '{ printf \"%5.1f%%,%s,%s\\n\", $2, $3, $1}'"

refreshFrequency: 2000

style: """
  // Align the widget contents left or right
  widget-align = left

  // Position the widget on your screen
  bottom 100px
  left 15px

  // Change the style of the widget
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 5px
  border-radius 5px

  .container
    width: 353px
    text-align: widget-align
    position: relative
    clear: both

  .widget-title
    text-align: widget-align

  .stats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold

  .app-name
    font-size 8px
    text-transform uppercase
    font-weight bold
    
  .pid
    font-size 8px
    text-transform uppercase
"""

render: -> """
  <div class="container">
    <div class="widget-title">Processes</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class="cpu-0"></span></td>
        <td class="cpu-1"></td>
        <td class="cpu-2"></td>
        <td class="cpu-3"></td>
        <td class="cpu-4"></td>
      </tr>
      <tr>
        <td class="app-name app-name-0"></td>
        <td class="app-name app-name-1"></td>
        <td class="app-name app-name-2"></td>
        <td class="app-name app-name-3"></td>
        <td class="app-name app-name-4"></td>
      </tr>
      <tr>
        <td class="pid pid-0"></td>
        <td class="pid pid-1"></td>
        <td class="pid pid-2"></td>
        <td class="pid pid-3"></td>
        <td class="pid pid-4"></td>
      </tr>
    </table>
  </div>
"""

update: (output, domElement) ->
  
  processes = output.split('\n')

  updateStat = (sel, cpu, name, pid) ->
    $(domElement).find(".cpu-#{sel}").text cpu
    $(domElement).find(".app-name-#{sel}").text name
    $(domElement).find(".pid-#{sel}").text pid

  for process, i in processes
    args = process.split(',')
    updateStat i, args[0], args[1], args[2]
