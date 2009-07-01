<%namespace file="../bookmark_submit.mako" name="bookmark_submit" inheritable="True"/>
<%page args="toolbox_extra"/>
<%def name="toolbox_extra_reviewer()">
    ## Defined in children
</%def>
<%def name="toolbox_extra_admin()">
    ## Defined in children
</%def>
<%
    this_url = h.url_for()
    url=h.lca_info["event_permalink"] + this_url
%>
<%def name="make_link(title, url)">
<%
      if this_url == url:
          cls=' class="selected"'
      else:
          cls=''
%>
      <li${cls | n}>${ h.link_to(title, url=url) }</li>
</%def>

  

## Toolbox links
<div class = 'yellowbox'>
  <div class="boxheader">
    <h1>Toolbox</h1>
    <ul>
% if h.auth.authorized(h.auth.has_organiser_role):
      <li><em>Organiser</em></li>
      ${ make_link('Admin', h.url_for(controller='admin')) }
      ${ make_link('Person', h.url_for(controller='person')) }
      ${ make_link('New page', h.url_for(controller='db_content', action='new')) }
%   if c.db_content and not h.url_for().endswith('/edit'):
      ${ make_link('Edit page', h.url_for(controller='db_content', action='edit', id=c.db_content.id)) }
%   endif
${ toolbox_extra_admin() }
% endif
% if h.auth.authorized(h.auth.has_reviewer_role):
      <li><em>Reviewer</em></li>
${ toolbox_extra_reviewer() }
      ${ make_link('How to review', '/help/review') }
      ${ make_link('Review proposals', h.url_for(controller='proposal', action='review_index')) }
      ${ make_link('Your reviews', h.url_for(controller='review', action='index')) }
      ${ make_link('Summary of proposals', h.url_for(controller='proposal', action='summary')) }
      ${ make_link('Reviewer summary', h.url_for(controller='review', action='summary')) }
      ${ make_link('Change proposal statuses', h.url_for(controller='proposal', action='approve')) }
      <li>List of proposals by:</li>
      <ul class="indent">
        ${ make_link('number of certain score / number of reviewers', h.url_for(controller='admin', action='proposals_by_strong_rank')) }
        ${ make_link('max score, min score then average', h.url_for(controller='admin', action='proposals_by_max_rank')) }
        ${ make_link('stream and score', h.url_for(controller='admin', action='proposals_by_stream')) }
      </ul>
% endif
${ toolbox_extra() }
% if h.signed_in_person():
      <li><em>${ h.signed_in_person().firstname }</em></li>
%   if h.lca_info["cfp_status"] == 'open':
      ${ make_link('Submit a paper', h.url_for(controller='proposal', action='new', id=None)) }
%   endif
%   if h.lca_info["cfmini_status"] == 'open':
      ${ make_link('Submit a miniconf', h.url_for(controller='miniconf_proposal', action='new', id=None)) }
%   endif
%   if len(h.signed_in_person().proposals) > 0:
      ${ make_link('My proposals', h.url_for(controller='proposal')) }
%   endif
      ${ make_link('My profile', h.url_for(controller='person', action='view', id=h.signed_in_person().id)) }
      ${ make_link('Sign out', h.url_for(controller='person', action='signout_confirm')) }
% else:
      ${ make_link('Sign in', "/person/signin") }
      ${ make_link('Sign up', "/person/new") }
% endif
    </ul>
% if not c.db_content or not c.db_content.is_news():
<div style="text-align:center;">
${ bookmark_submit.bookmark_submit(url) }
</div>
% endif
% if h.signed_in_person():
    <p class = 'more'>${h.signed_in_person().email_address}</p>
% endif
  </div>
</div>