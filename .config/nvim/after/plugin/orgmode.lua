local status_ok, configs = pcall(require, "orgmode")
if not status_ok then
  return
end

configs.setup_ts_grammar()

-- config options available:
--https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md#settings
configs.setup({
  -- org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/gtd/refile.org',
  org_agenda_files = {
    '~/gtd/**/*',
    -- '~/my-orgs/**/*'
  },
  org_todo_keywords = {
    'TODO(t)', 'PROGRESS(p)', '|', 'FINISHED(f)', 'DELEGATED(d)'
  },
  win_split_mode = 'vertical',
  org_todo_keyword_faces = {
    WAITING = ':foreground blue :weight bold',
    DELEGATED = ':background #FFFFFF :slant italic :underline on',
    TODO = ':background #000000 :foreground red', -- overrides builtin color for `TODO` keyword
  },
  org_hide_leading_stars = true,
  org_ellipsis = '...',
  org_highlight_latex_and_related = 'entities',
  org_indent_mode = 'indent',
  org_edit_src_content_indentation = 0,
  org_custom_exports = {},

  --
  -- Agenda settings
  --
  org_deadline_warning_days = 14,
  org_agenda_span = 'week', -- options: day, week, month, year
  org_agenda_start_on_weekday = 1, -- ISO weekday, 1 is Monday. Applies only to week and number span. If set to false, starts from today
  org_capture_templates = {
    -- if you don't want your deadlines to be in an activate format (i.e it pops up in your agenda as true deadline)
    -- you can use the %U instead of a %T. Then it will be in an inactive format
    r = {
      description = 'Refile',
      template = '* TODO %^{Todo topic} :%^{tag}:\n  DEADLINE: %u',
      target='~/gtd/refile.org'
      -- [[file:/home/user/projects/myfile.txt +2]]
    },
    R = {
      description = 'Refile',
      template = '* TODO %^{Todo topic} :%^{tag}:\n  DEADLINE: %T',
      target='~/gtd/refile.org'
    },
    t = {
      description = 'Personal todo',
      template = '* TODO %^{Todo topic} :personal:%^{tag}:',
      target = '~/gtd/personal_todo.org',
    },
    T = {
      description = 'Personal todo',
      template = '* TODO %^{Todo topic} :personal:%^{tag}:\n  DEADLINE: %T',
      target = '~/gtd/personal_todo.org',
    },
    w = {
      description = 'Work todo',
      template = '* TODO %^{Todo topic} :work:%^{tag}:\n  DEADLINE: %u',
      target = '~/gtd/work_todo.org',
    },
    W = {
      description = 'Work todo',
      template = '* TODO %^{Todo topic} :work:%^{tag}:\n  DEADLINE: %T',
      target = '~/gtd/work_todo.org',
    },
    c = {
      description = 'Clipboard',
      template = '* [[%x][%?]]',
      target = '~/gtd/urls.org',
    },
  },
  org_priority_highest = 'A',
  org_priority_default = 'B',
  org_priority_lowest = 'C',
  org_agenda_skip_scheduled_if_done = true,
  org_agenda_skip_deadline_if_done = true,
  org_agenda_text_search_extra_files = {'agenda-archives'},

  --
  -- Tags settings
  --
  org_use_tag_inheritance = true,
  mappings = {
    global = {
      org_agenda = '<Leader>oa',
      org_capture = '<Leader>oc',
    },
    agenda = {
      org_agenda_later = 'f',
      org_agenda_earlier = 'b',
      org_agenda_goto_today = {'.', 'T'},
      org_agenda_day_view = 'vd',
      org_agenda_week_view = 'vw',
      org_agenda_month_view = 'vm',
      org_agenda_year_view = 'vy',
      org_agenda_quit = 'q',
      org_agenda_switch_to = '<CR>',
      org_agenda_goto = "{'<TAB>'}",
      org_agenda_goto_date = 'J',
      org_agenda_redo = 'r',
      org_agenda_todo = 't',
      org_agenda_clock_in = 'I',
      org_agenda_clock_out = 'O',
      org_agenda_clock_cancel = 'X',
      org_agenda_clock_goto = '<Leader>oxj',
      org_agenda_clockreport_mode = 'R',
      org_agenda_priority = '<Leader>o,',
      org_agenda_priority_up = '+',
      org_agenda_priority_down = '-',
      org_agenda_archive = '<Leader>o$',
      org_agenda_toggle_archive_tag = '<Leader>oA',
      org_agenda_set_tags = '<Leader>ot',
      org_agenda_deadline = '<Leader>oid',
      org_agenda_schedule = '<Leader>ois',
      org_agenda_filter = '/',
      org_agenda_show_help = '?',
    },
    capture = {
      org_capture_finalize = 'q',
      org_capture_refile = '<Leader>or',
      org_capture_kill = '<Leader>ok',
      org_capture_show_help = '?',
    },
    org = {
      org_refile = '<Leader>or',
      org_timestamp_up = '<C-+>',
      org_timestamp_down = '<C-->',
      -- org_timestamp_down = '<C-x>',
      -- org_timestamp_up_day = '<S-UP>',
      org_timestamp_up_day = '<ciR>',
      org_timestamp_down_day = '<cir>',
      org_change_date = 'cid',
      org_priority = '<Leader>o,',
      org_priority_up = '<S-UP>',
      org_priority_down = '<S-DOWN>',
      org_todo = 'cit',
      org_todo_prev = 'ciT',
      org_toggle_checkbox = '<C-Space>',
      org_toggle_heading = '<Leader>o*',
      org_open_at_point = '<Leader>oo',
      org_edit_special = '<Leader>o',
      org_cycle = '<TAB>',
      org_global_cycle = '<S-TAB>',
      org_archive_subtree = '<Leader>o$',
      org_set_tags_command = '<Leader>ot',
      org_toggle_archive_tag = '<Leader>oA',
      org_do_promote = '<<',
      org_do_demote = '>>',
      org_promote_subtree = '<s',
      org_demote_subtree = '>s',
      org_meta_return = '<Leader><CR>',
      org_insert_heading_respect_content = '<Leader>oih',
      org_insert_todo_heading = '<Leader>oiT',
      org_insert_todo_heading_respect_content = '<Leader>oit',
      org_move_subtree_up = '<Leader>oK',
      org_move_subtree_down = '<Leader>oJ',
      org_export = '<Leader>oe',
      org_next_visible_heading = '}',
      org_previous_visible_heading = '{',
      org_forward_heading_same_level = ']]',
      org_backward_heading_same_level = '[[',
      outline_up_heading = 'g{',
      org_deadline = '<Leader>oid',
      org_schedule = '<Leader>ois',
      org_time_stamp = '<Leader>oi.',
      org_time_stamp_inactive = '<Leader>oi!',
      org_clock_in = '<Leader>oxi',
      org_clock_out = '<Leader>oxo',
      org_clock_cancel = '<Leader>oxq',
      org_clock_goto = '<Leader>oxj',
      org_set_effort = '<Leader>oxe',
      org_show_help = '?',
    },
    org_edit_special = {
      org_edit_src_abort = '<Leader>ok',
      org_edit_src_save= '<Leader>ow',
      org_edit_src_show_help = '?',
    },
    text_objects = {
      inner_heading = 'ih',
      around_heading = 'ah',
      inner_subtree = 'ir',
      around_subtree = 'ar',
      inner_heading_from_root = 'Oh',
      around_heading_from_root = 'OH',
      inner_subtree_from_root = 'Or',
      around_subtree_from_root = 'OR',
    },
  }
})


