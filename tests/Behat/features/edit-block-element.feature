@javascript
Feature: Edit elements in the CMS
  As a CMS user
  I want to edit elements in the CMS
  So that I can modify elements I have used on a page

  Background:
    Given I add an extension "DNADesign\Elemental\Extensions\ElementalPageExtension" to the "Page" class
      And a "page" "Blocks Page" with a "Alice's Block" content element with "Some content" content
      And the "page" "Blocks Page" has a "Bob's Block" content element with "Some content II" content

    Given I am logged in with "ADMIN" permissions
      # Remove with 'And I click "Blocks Page" in the ".breadcrumbs-wrapper" element' once the ElementalArea refreshes,
      # See https://github.com/dnadesign/silverstripe-elemental/issues/320
      And I go to "/admin/pages/edit/show/6"
      And I wait until I see the ".element-editor__element" element
    Then I should see "Alice's Block"
      And I should see "Bob's Block"

  Scenario: I can edit a non in-line editable block
    Given content blocks are not in-line editable
      And I go to "/admin/pages/edit/show/6"
      And I wait until I see the ".element-editor__element" element
    Then I should see block 1

    Given I click on block 1
    Then I should see "Alice's Block"
      And the "HTML" HTML field should contain "Some content"

    Given I fill in "Eve's Block" for "Title"
      And I fill in "<p>New sample content</p>" for the "HTML" HTML field
      And I press the "Publish" button
    Then I should see a "Published content block" message
    When I go to "/admin/pages/edit/show/6"
      And I wait until I see the ".element-editor__element" element
      And I wait 1 second
    Then I should see "Eve's Block"
      But I should not see "Alice's Block"
