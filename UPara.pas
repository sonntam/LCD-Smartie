unit UPara;
{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /cvsroot/lcdsmartie/lcdsmartie/Attic/UPara.pas,v $
 *  $Revision: 1.5 $ $Date: 2005/01/04 20:13:04 $
 *****************************************************************************}

interface

uses Forms, StdCtrls, Spin, Controls, Classes;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Button1: TButton;
    AltAddressing: TCheckBox;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses USetup;

{$R *.DFM}

procedure TForm6.Button1Click(Sender: TObject);
begin
  form6.visible := false;
  form2.enabled := true;
  form2.BringToFront;
end;

end.
