 # Copy-Item "" -Destination "" -Verbose

#$path = ""
#$dest = ""


$files = Get-ChildItem $path

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null;

$form = New-Object System.Windows.Forms.Form
$form.Text = 'File Copier'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'


$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.Add_Click( 
{
            $path = $textBox.Text + "\*"
            $dest = $textBox2.Text
   
            $counter = ""
            Foreach($file in $files){                
             $status = "Copy files {0} on {1}: {2}" -f $counter,$files.Count,$file.Name
             Write-Progress -Activity "Copy data" $status -PercentComplete ($counter / $files.count*100)
             $restpath = $file.fullname.replace($path,"")
           
    Copy-Item $restpath $dest -recurse -Force -Verbose
          
            $counter 
            }

             If ($Counter = $files.Count)
             {[System.Windows.Forms.MessageBox]::Show("Copy Finished!.")}
})

$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter where files are located:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)


$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,80)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = 'Please enter destination:'
$form.Controls.Add($label2)

$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(10,100)
$textBox2.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox2)

$form.Topmost = $true
$Form.icon                       = "main.ico"

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()




           
