Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9D25CF64
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 04:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgIDCZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 22:25:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52953 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgIDCZ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 22:25:56 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1kE1QF-000465-Ks
        for linux-iio@vger.kernel.org; Fri, 04 Sep 2020 02:25:51 +0000
Received: by mail-wr1-f71.google.com with SMTP id a12so1768951wrg.13
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2020 19:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yeayi7Osme5lO2dScotW+fbJ2ZzSBFT2bsWysJ2a0HA=;
        b=lOzyx2oBHjPNuLQGEolZRT7wRNQbX2ICzZkEiRSyaKf1JiGNi0AuFlZ4BfLRXepCL/
         TuNsFzDBGifJLheUeSh0aC5yjl8NY+/vbsgO5ZoFxdFkVPQoPoTqU/Pxl5vfqo2P1WqF
         WImENo5LO1zfmwrOmoHpuKAizho3pCnxUTHCMNu+cpgMO6M0wnCyNGwrmQ1lxK9Q63pS
         07zr2a1W+moPYBm7dX+wweWzlDTN36wSlPOT1inegrxYBZYHvFT0kgqQwOja64G5ItK9
         f3q7LEveTtV8R3bggNu5wqVDRhEXSBOKsI+vYitXte+Sh18/UHReOkdX8ZN+r9PvXgdS
         uyjw==
X-Gm-Message-State: AOAM533+XnIkvv5TBaDK5KeoyosyjSuvQCYHTJ1la2G2BDVNUZUEX62L
        8gxolhP01F5IoD1E2cJd486W0cITvgTaWzFlN012oe27XYOsct39EU2IQ/9qLKgsl3bhg7BYAkN
        +BKEDfEfqSEdxQZqYB6yC+DQuVe3Ziy8bvaADa0KQafVz8euIrmoDSw==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr5232269wmo.186.1599186351235;
        Thu, 03 Sep 2020 19:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzuiULt5pNqVjyhX5rzdZbK80+vaQIlDGS8bTuB422sjHHGUs8Z8AV9MYxTx7koF5Nz/vKSbOCTtbDI0NEHC8=
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr5232247wmo.186.1599186350858;
 Thu, 03 Sep 2020 19:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
 <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
 <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com> <CAHp75VcJp4zCxOUBgYTypv_R47vLAuAF2ZStLpA9mjFjbzWcxw@mail.gmail.com>
In-Reply-To: <CAHp75VcJp4zCxOUBgYTypv_R47vLAuAF2ZStLpA9mjFjbzWcxw@mail.gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Fri, 4 Sep 2020 10:25:39 +0800
Message-ID: <CAFv23Qnij-2ycXNqisQDbo9ix41ed1HPRJrOdRoMM2bjU407nw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: multipart/mixed; boundary="0000000000005fa81405ae7396e8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--0000000000005fa81405ae7396e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Here is the updated ads5593r.asl, but I still got some troubles when
using configfs.
The modification I made
1. add DefinitionBlock() and External()
2. align _SB.I2C1
3. set _CRS serialized

The issues I got are,
1. The ADS5593 is defined in DSDT table, but I can't compile the asl
code when define it as DSDT table
$ iasl ads5593r.asl

Intel ACPI Component Architecture
ASL+ Optimizing Compiler/Disassembler version 20190509
Copyright (c) 2000 - 2019 Intel Corporation

ads5593r.asl      5:     Scope (_SB.I2C1)
Error    6148 -                       ^ Illegal open scope on external
object from within DSDT

ASL Input:     ads5593r.asl -    7917 bytes     30 keywords    257 source l=
ines

Compilation failed. 1 Errors, 0 Warnings, 0 Remarks
No AML files were generated due to compiler error(s)

2. I got below errors in dmesg if I set it as SSDT
[  410.220993] ACPI: Host-directed Dynamic ACPI Table Load:
[  410.221013] ACPI: SSDT 0xFFFF89A4ADDE7C00 00035D (v01
ADS5593R 00000001 INTL 20190509)
[  410.221106] ACPI BIOS Error (bug): Failure creating named object
[\_SB.I2C1.I2CG], AE_ALREADY_EXISTS (20190816/dswload2-326)
[  410.221324] ACPI Error: AE_ALREADY_EXISTS, During name
lookup/catalog (20190816/psobject-220)
[  410.221468] ACPI: Skipping parse of AML opcode: Device (0x5B82)

Do you have any suggestions?
We may have a chance to convince BIOS to move ADS5593 to the SSDT
table, do you think it's a good idea?
BTW, the driver set the channels mode while probing, I'm not sure if
configfs will make the driver probe again when new table is loaded
If we can't use configfs, is there any other way we could try?
Thanks.

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=
=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Sep 3, 2020 at 1:42 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Sep 3, 2020 at 10:37 AM AceLan Kao <acelan.kao@canonical.com> w=
rote:
>
> Couple additional notes.
>
> ...
>
> > > I spent some time studying/reading what you wrote, but I still don't
> > > understand how to leverage meta-acpi.
> >
> > meta-acpi is a Yocto layer to support provided ACPI tables for the
> > build. My point here is to have it as a collection of ASL examples.
> > It's what you asked for below in this email.
>
> > Also we can collect your ASL example under board (presumably new) folde=
r.
>
> Actually it seems Baytrail, so, minnowboard-max is good enough.
>
> ...
>
> > On the first glance I didn't see any issues with it, but on second
> > look here is one. Look into this [5] example.
> > If you noticed it uses the same path in Scope and in the reference in
> > I2cSerialBus() while in your ASL they are different.
>
> Also there is an _ADR value wrong for the second channel (I'm not sure
> if it affects anyhow the rest).
>
> > Do you have issues with loading it (as is and after above addressed)?
> >
> > [5]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-=
tables/samples/edison/ft6236.asli
>
> Also a link [6] to our Buildroot repository which allows to create an
> initramfs with ASL compiled. Maybe used as a reference how we created
> initramfs and compile ASLs.
>
> [6]: https://github.com/andy-shev/buildroot/tree/intel/board/intel/common
> ...
>
> > > > One more useful link is SO answers on the topic:
> > > > https://stackoverflow.com/search?tab=3Dnewest&q=3Dprp0001
> > > >
> > > > > [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/e=
numeration.html#device-tree-namespace-link-device-id
> > > > > [2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentati=
on/devicetree/bindings/iio/dac/ad5592r.txt
> > > > > [3]: https://github.com/westeri/meta-acpi
> > > > > [4]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp=
/acpi-tables/samples
>
> > > > > > 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9=
df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c
>
>
>
> --
> With Best Regards,
> Andy Shevchenko

--0000000000005fa81405ae7396e8
Content-Type: application/octet-stream; name="ads5593.asl"
Content-Disposition: attachment; filename="ads5593.asl"
Content-Transfer-Encoding: base64
Content-ID: <f_kenm8jxl0>
X-Attachment-Id: f_kenm8jxl0

RGVmaW5pdGlvbkJsb2NrICgiYWRzNTU5M3IuYW1sIiwgIlNTRFQiLCAxLCAiIiwgIkFEUzU1OTNS
IiwgMSkKewogICAgRXh0ZXJuYWwgKFxfU0IuSTJDMSwgRGV2aWNlT2JqKQoKICAgIFNjb3BlIChf
U0IuSTJDMSkKICAgIHsKICAgICAgICBEZXZpY2UgKEkyQ0cpCiAgICAgICAgewogICAgICAgICAg
ICBOYW1lIChfSElELCAiQURTNTU5MyIpICAvLyBfSElEOiBIYXJkd2FyZSBJRAogICAgICAgICAg
ICBEZXZpY2UgKElPUDApCiAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgIE5hbWUgKF9BRFIs
IFplcm8pICAvLyBfQURSOiBBZGRyZXNzCiAgICAgICAgICAgICAgICBOYW1lIChfRFNELCBQYWNr
YWdlICgweDAyKSAgLy8gX0RTRDogRGV2aWNlLVNwZWNpZmljIERhdGEKICAgICAgICAgICAgICAg
IHsKICAgICAgICAgICAgICAgICAgICBUb1VVSUQgKCJkYWZmZDgxNC02ZWJhLTRkOGMtOGE5MS1i
YzliYmY0YWEzMDEiKSAvKiBEZXZpY2UgUHJvcGVydGllcyBmb3IgX0RTRCAqLywgCiAgICAgICAg
ICAgICAgICAgICAgUGFja2FnZSAoMHgwMykKICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAgICAgICAgICAgIHsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyZWciLCAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFplcm8KICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAg
ICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiYWRpLG1vZGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDgKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAgICAg
ICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiYWRpLG9mZi1zdGF0ZSIsIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWmVybwogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAg
fQogICAgICAgICAgICAgICAgfSkKICAgICAgICAgICAgfQoKICAgICAgICAgICAgRGV2aWNlIChJ
T1AxKQogICAgICAgICAgICB7CiAgICAgICAgICAgICAgICBOYW1lIChfQURSLCBaZXJvKSAgLy8g
X0FEUjogQWRkcmVzcwogICAgICAgICAgICAgICAgTmFtZSAoX0RTRCwgUGFja2FnZSAoMHgwMikg
IC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBEYXRhCiAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgVG9VVUlEICgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJmNGFhMzAx
IikgLyogRGV2aWNlIFByb3BlcnRpZXMgZm9yIF9EU0QgKi8sIAogICAgICAgICAgICAgICAgICAg
IFBhY2thZ2UgKDB4MDMpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
ICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAicmVnIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBPbmUK
ICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAgICAgICAgICBQYWNr
YWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiYWRpLG1vZGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDMKICAg
ICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAgICAgICAgICBQYWNrYWdl
ICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiYWRpLG9mZi1zdGF0ZSIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgWmVybwog
ICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAg
ICAgICAgfSkKICAgICAgICAgICAgfQoKICAgICAgICAgICAgRGV2aWNlIChJT1AyKQogICAgICAg
ICAgICB7CiAgICAgICAgICAgICAgICBOYW1lIChfQURSLCAweDAyKSAgLy8gX0FEUjogQWRkcmVz
cwogICAgICAgICAgICAgICAgTmFtZSAoX0RTRCwgUGFja2FnZSAoMHgwMikgIC8vIF9EU0Q6IERl
dmljZS1TcGVjaWZpYyBEYXRhCiAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAg
VG9VVUlEICgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJmNGFhMzAxIikgLyogRGV2aWNl
IFByb3BlcnRpZXMgZm9yIF9EU0QgKi8sIAogICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4
MDMpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICBQYWNrYWdl
ICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAicmVnIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAyCiAgICAgICAgICAg
ICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikK
ICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgImFk
aSxtb2RlIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAyCiAgICAgICAgICAgICAg
ICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAg
ICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgImFkaSxv
ZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8KICAgICAgICAgICAg
ICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0pCiAg
ICAgICAgICAgIH0KCiAgICAgICAgICAgIERldmljZSAoSU9QMykKICAgICAgICAgICAgewogICAg
ICAgICAgICAgICAgTmFtZSAoX0FEUiwgMHgwMykgIC8vIF9BRFI6IEFkZHJlc3MKICAgICAgICAg
ICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKDB4MDIpICAvLyBfRFNEOiBEZXZpY2UtU3BlY2lm
aWMgRGF0YQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIFRvVVVJRCAoImRh
ZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJiZjRhYTMwMSIpIC8qIERldmljZSBQcm9wZXJ0aWVz
IGZvciBfRFNEICovLCAKICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAzKQogICAgICAg
ICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAg
ICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlZyIs
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMwogICAgICAgICAgICAgICAgICAgICAg
ICB9LCAKCiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAg
ICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhZGksbW9kZSIsIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgT25lCiAgICAgICAgICAgICAgICAgICAgICAgIH0s
IAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAgICAgICAgICAgICAg
ICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgImFkaSxvZmYtc3RhdGUiLCAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8KICAgICAgICAgICAgICAgICAgICAgICAg
fQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0pCiAgICAgICAgICAgIH0K
CiAgICAgICAgICAgIERldmljZSAoSU9QNCkKICAgICAgICAgICAgewogICAgICAgICAgICAgICAg
TmFtZSAoX0FEUiwgMHgwNCkgIC8vIF9BRFI6IEFkZHJlc3MKICAgICAgICAgICAgICAgIE5hbWUg
KF9EU0QsIFBhY2thZ2UgKDB4MDIpICAvLyBfRFNEOiBEZXZpY2UtU3BlY2lmaWMgRGF0YQogICAg
ICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIFRvVVVJRCAoImRhZmZkODE0LTZlYmEt
NGQ4Yy04YTkxLWJjOWJiZjRhYTMwMSIpIC8qIERldmljZSBQcm9wZXJ0aWVzIGZvciBfRFNEICov
LCAKICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAzKQogICAgICAgICAgICAgICAgICAg
IHsKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAgICAgICAgICAgICAg
ICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlZyIsIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMHgwNAogICAgICAgICAgICAgICAgICAgICAgICB9LCAKCiAgICAg
ICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAgICAgICAgICAg
IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhZGksbW9kZSIsIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMHgwOAogICAgICAgICAgICAgICAgICAgICAgICB9LCAKCiAgICAgICAg
ICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAgICAgICAgICAgIHsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhZGksb2ZmLXN0YXRlIiwgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBaZXJvCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAg
ICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9KQogICAgICAgICAgICB9CgogICAgICAgICAg
ICBEZXZpY2UgKElPUDUpCiAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgIE5hbWUgKF9BRFIs
IDB4MDUpICAvLyBfQURSOiBBZGRyZXNzCiAgICAgICAgICAgICAgICBOYW1lIChfRFNELCBQYWNr
YWdlICgweDAyKSAgLy8gX0RTRDogRGV2aWNlLVNwZWNpZmljIERhdGEKICAgICAgICAgICAgICAg
IHsKICAgICAgICAgICAgICAgICAgICBUb1VVSUQgKCJkYWZmZDgxNC02ZWJhLTRkOGMtOGE5MS1i
YzliYmY0YWEzMDEiKSAvKiBEZXZpY2UgUHJvcGVydGllcyBmb3IgX0RTRCAqLywgCiAgICAgICAg
ICAgICAgICAgICAgUGFja2FnZSAoMHgwMykKICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAgICAgICAgICAgIHsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyZWciLCAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4MDUKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAg
ICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiYWRpLG1vZGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDMKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAgICAg
ICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiYWRpLG9mZi1zdGF0ZSIsIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWmVybwogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAg
fQogICAgICAgICAgICAgICAgfSkKICAgICAgICAgICAgfQoKICAgICAgICAgICAgRGV2aWNlIChJ
T1A2KQogICAgICAgICAgICB7CiAgICAgICAgICAgICAgICBOYW1lIChfQURSLCAweDA2KSAgLy8g
X0FEUjogQWRkcmVzcwogICAgICAgICAgICAgICAgTmFtZSAoX0RTRCwgUGFja2FnZSAoMHgwMikg
IC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBEYXRhCiAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgVG9VVUlEICgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJmNGFhMzAx
IikgLyogRGV2aWNlIFByb3BlcnRpZXMgZm9yIF9EU0QgKi8sIAogICAgICAgICAgICAgICAgICAg
IFBhY2thZ2UgKDB4MDMpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
ICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAicmVnIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDA2
CiAgICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFj
a2FnZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImFkaSxtb2RlIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAyCiAg
ICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2Fn
ZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImFkaSxvZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8K
ICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAg
ICAgICAgIH0pCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIERldmljZSAoSU9QNykKICAgICAg
ICAgICAgewogICAgICAgICAgICAgICAgTmFtZSAoX0FEUiwgMHgwNykgIC8vIF9BRFI6IEFkZHJl
c3MKICAgICAgICAgICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKDB4MDIpICAvLyBfRFNEOiBE
ZXZpY2UtU3BlY2lmaWMgRGF0YQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
IFRvVVVJRCAoImRhZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJiZjRhYTMwMSIpIC8qIERldmlj
ZSBQcm9wZXJ0aWVzIGZvciBfRFNEICovLCAKICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgw
eDAzKQogICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2Fn
ZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgInJlZyIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwNwogICAgICAgICAg
ICAgICAgICAgICAgICB9LCAKCiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIp
CiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJh
ZGksbW9kZSIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgT25lCiAgICAgICAgICAgICAg
ICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAg
ICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgImFkaSxv
ZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8KICAgICAgICAgICAg
ICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0pCiAg
ICAgICAgICAgIH0KCiAgICAgICAgICAgIE1ldGhvZCAoX0NSUywgMCwgU2VyaWFsaXplZCkgIC8v
IF9DUlM6IEN1cnJlbnQgUmVzb3VyY2UgU2V0dGluZ3MKICAgICAgICAgICAgewogICAgICAgICAg
ICAgICAgTmFtZSAoUkJVRiwgUmVzb3VyY2VUZW1wbGF0ZSAoKQogICAgICAgICAgICAgICAgewog
ICAgICAgICAgICAgICAgICAgIEkyY1NlcmlhbEJ1c1YyICgweDAwMTAsIENvbnRyb2xsZXJJbml0
aWF0ZWQsIDB4MDAwNjFBODAsCiAgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NpbmdNb2Rl
N0JpdCwgIlxcX1NCLkkyQzEiLAogICAgICAgICAgICAgICAgICAgICAgICAweDAwLCBSZXNvdXJj
ZUNvbnN1bWVyLCAsIEV4Y2x1c2l2ZSwKICAgICAgICAgICAgICAgICAgICAgICAgKQogICAgICAg
ICAgICAgICAgfSkKICAgICAgICAgICAgICAgIFJldHVybiAoUkJVRikgLyogXF9TQl8uSTJDMS5J
MkNHLl9DUlMuUkJVRiAqLwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQo=
--0000000000005fa81405ae7396e8--
