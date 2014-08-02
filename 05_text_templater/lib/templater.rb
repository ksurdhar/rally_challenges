def string_templater(hash, template)
  words = template.split(" ")
  variables = words.select {|word| word.scan(/\${.*\}/).length > 0}
  variables.map! {|var| innermost_variable(var)}

  variables.each do |variable|
    variable_assigned = false
    var_no_brackets = variable[2..-2]
    
    hash.each do |key, val|
      if key == var_no_brackets || val == var_no_brackets
        template.gsub!(variable, val)
        variable_assigned = true
      end 
    end

    return "Variable Missing!" if !variable_assigned
  end

  template
end

def innermost_variable(var)
  innermost = false
  until innermost
    innermost = true
    if var[0..1] == "${" && var[-1] == "}"
      var = var[2..-2]
      innermost = false
    else
      return "${" + var + "}"
    end
  end
end

hash = {"day" => "Thursday", "name" => "Billy"}
string = "${name} has an appointment on ${Thursday}"
p string_templater(hash, string)