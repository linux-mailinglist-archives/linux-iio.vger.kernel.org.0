Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9725BBCA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgICHhh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 03:37:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50139 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICHhf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 03:37:35 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1kDjoK-0007ij-Vi
        for linux-iio@vger.kernel.org; Thu, 03 Sep 2020 07:37:33 +0000
Received: by mail-wr1-f70.google.com with SMTP id k11so735771wrw.16
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2020 00:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRT0dtyryBE1QXXJeojjJFWZBaTTGS+0c45qeRF0jaw=;
        b=dXsP8xaLcEaa0xfGPaZHvXsVTZV7pOCe8ah5XDM/UL5id61ZA7wMgQTBcCVvrMx/8a
         GuKNPL3OKtQbFLNXJ33AnFD4Zre/J0Ref+/ARc/wzNFA7+1hJDmkWhpYj65n0AjhXFuQ
         hsuwaaHbP2MScHQxLOaCGwjXZCwxUskkDu4fOdDuR5YUYKlL/gjERE2AM5MTVG6+rPkB
         aZBaCoGRumjCm7zYGx4tuMqh3bTLCNIgE0aec7r5khIJuvxcLIfFuXFzyNrLZWjTZRZH
         GAFMczxZvN7LmPZ5r3SOHKt0GpN6XEfZdbMN96Lz2YsZ07HGEr6n1+o05WzfFB8GtBYq
         FyHA==
X-Gm-Message-State: AOAM531ElaMwyPqSPEWHGK5avvRhH9OZGdk41xgmOWBl071OWywktDra
        8qVvwPre2pQQRBDFT+AX84/chdmGS9LIRMoWK53yLSlzMy6jjxWWBbDJiiktQmdUHf1XkSJZtF5
        wURxmU13qwbb8CJu0JOPNoyTlEn/xcl9hvdrp3z8ojYTY6+9GomVDTg==
X-Received: by 2002:a5d:644b:: with SMTP id d11mr872668wrw.373.1599118652366;
        Thu, 03 Sep 2020 00:37:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaud13HsnRKqjCXr+L8e7lST34HEY4peMc6uzhZYqZrFOET3triLmPLm6FpC1jqXDwXBMg3dsRdioaTQv3f8I=
X-Received: by 2002:a5d:644b:: with SMTP id d11mr872638wrw.373.1599118651996;
 Thu, 03 Sep 2020 00:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com> <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
In-Reply-To: <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 3 Sep 2020 15:37:20 +0800
Message-ID: <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000034fd5c05ae63d357"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--00000000000034fd5c05ae63d357
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I spent some time studying/reading what you wrote, but I still don't
understand how to leverage meta-acpi.

From what I understand from the following discussion in the thread,
ADS5593 could be used,
so we can keep using it and don't have to introduce PRP0001 in the table, r=
ight?

Here is the ADS5593 asl code, but I have no idea how to re-use it
after it's been modified,
the only way I know is to override the ACPI tables via initrd[1].
Could you share some examples in real cases that I can follow?
Thanks.

1. Documentation/admin-guide/acpi/initrd_table_override.rst

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8831=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, Aug 31, 2020 at 3:45 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao <acelan.kao@canonical.com> w=
rote:
> > > This patch is mainly for Advantech's UNO-420[1] which is a x86-based =
platform.
> > > This platform is more like a development platform for customers to
> > > customize their products,
> > > so, specify the channel modes in ACPI table is not generic enough,
> > > that's why William submit this patch.
> > >
> > > Are there other ways to specify or pass values to the module without
> > > using module parameters?
> > > It's good if we can leverage sysfs, but I don't know if there is one
> > > for this scenario.
> >
> > Can we provide DT bindings for that and use then in ACPI? ACPI has a
> > possibility to reuse DT properties and compatible strings [1]. As far
> > as I can see the driver uses fwnode API, so it supports ACPI case
> > already [2]. So, what prevents you to utilize 'adi,mode' property?
> >
> > Also, we accept examples of ASL excerpt in meta-acpi project [3]. It
> > has already plenty of examples [4] how to use PRP0001 for DIY /
> > development boards.
> >
> > So, take all together I think this patch is simple redundant.
>
> One more useful link is SO answers on the topic:
> https://stackoverflow.com/search?tab=3Dnewest&q=3Dprp0001
>
> > [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumera=
tion.html#device-tree-namespace-link-device-id
> > [2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/dev=
icetree/bindings/iio/dac/ad5592r.txt
> > [3]: https://github.com/westeri/meta-acpi
> > [4]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi-=
tables/samples
> >
> > P.S. Jonathan, it seems this driver has artificial ACPI HID. We
> > probably have to remove it. However, ADS is indeed reserved for Analog
> > Devices in PNP registry. Can we have AD's official answer on this?
> > Cc'ing additional AD people.
> >
> > > 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90a3=
952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c
>
> --
> With Best Regards,
> Andy Shevchenko

--00000000000034fd5c05ae63d357
Content-Type: text/x-dsl; charset="US-ASCII"; name="ads5593.dsl"
Content-Disposition: attachment; filename="ads5593.dsl"
Content-Transfer-Encoding: base64
Content-ID: <f_kemhi4hk0>
X-Attachment-Id: f_kemhi4hk0

ICAgIFNjb3BlIChfU0IuSTJDMSkKICAgIHsKICAgICAgICBEZXZpY2UgKEkyQ0cpCiAgICAgICAg
ewogICAgICAgICAgICBOYW1lIChfSElELCAiQURTNTU5MyIpICAvLyBfSElEOiBIYXJkd2FyZSBJ
RAogICAgICAgICAgICBEZXZpY2UgKElPUDApCiAgICAgICAgICAgIHsKICAgICAgICAgICAgICAg
IE5hbWUgKF9BRFIsIFplcm8pICAvLyBfQURSOiBBZGRyZXNzCiAgICAgICAgICAgICAgICBOYW1l
IChfRFNELCBQYWNrYWdlICgweDAyKSAgLy8gX0RTRDogRGV2aWNlLVNwZWNpZmljIERhdGEKICAg
ICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICBUb1VVSUQgKCJkYWZmZDgxNC02ZWJh
LTRkOGMtOGE5MS1iYzliYmY0YWEzMDEiKSAvKiBEZXZpY2UgUHJvcGVydGllcyBmb3IgX0RTRCAq
LywgCiAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMykKICAgICAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAg
ICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyZWciLCAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFplcm8KICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAg
ICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWRpLG1vZGUiLCAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDB4MDgKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAg
ICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWRpLG9mZi1zdGF0ZSIsIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgWmVybwogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAg
ICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfSkKICAgICAgICAgICAgfQoKICAgICAgICAg
ICAgRGV2aWNlIChJT1AxKQogICAgICAgICAgICB7CiAgICAgICAgICAgICAgICBOYW1lIChfQURS
LCBaZXJvKSAgLy8gX0FEUjogQWRkcmVzcwogICAgICAgICAgICAgICAgTmFtZSAoX0RTRCwgUGFj
a2FnZSAoMHgwMikgIC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBEYXRhCiAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgVG9VVUlEICgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEt
YmM5YmJmNGFhMzAxIikgLyogRGV2aWNlIFByb3BlcnRpZXMgZm9yIF9EU0QgKi8sIAogICAgICAg
ICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDMpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAg
ICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAicmVnIiwgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBPbmUKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAg
ICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiYWRpLG1vZGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDMKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAgICAgICAgICAgICAg
ICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiYWRpLG9mZi1zdGF0ZSIsIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWmVybwogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAg
fQogICAgICAgICAgICAgICAgfSkKICAgICAgICAgICAgfQoKICAgICAgICAgICAgRGV2aWNlIChJ
T1AyKQogICAgICAgICAgICB7CiAgICAgICAgICAgICAgICBOYW1lIChfQURSLCAweDAyKSAgLy8g
X0FEUjogQWRkcmVzcwogICAgICAgICAgICAgICAgTmFtZSAoX0RTRCwgUGFja2FnZSAoMHgwMikg
IC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBEYXRhCiAgICAgICAgICAgICAgICB7CiAgICAgICAg
ICAgICAgICAgICAgVG9VVUlEICgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJmNGFhMzAx
IikgLyogRGV2aWNlIFByb3BlcnRpZXMgZm9yIF9EU0QgKi8sIAogICAgICAgICAgICAgICAgICAg
IFBhY2thZ2UgKDB4MDMpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
ICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAicmVnIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAy
CiAgICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFj
a2FnZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImFkaSxtb2RlIiwgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAyCiAg
ICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2Fn
ZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImFkaSxvZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8K
ICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAg
ICAgICAgIH0pCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIERldmljZSAoSU9QMykKICAgICAg
ICAgICAgewogICAgICAgICAgICAgICAgTmFtZSAoX0FEUiwgMHgwMykgIC8vIF9BRFI6IEFkZHJl
c3MKICAgICAgICAgICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKDB4MDIpICAvLyBfRFNEOiBE
ZXZpY2UtU3BlY2lmaWMgRGF0YQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
IFRvVVVJRCAoImRhZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJiZjRhYTMwMSIpIC8qIERldmlj
ZSBQcm9wZXJ0aWVzIGZvciBfRFNEICovLCAKICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgw
eDAzKQogICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2Fn
ZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgInJlZyIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMwogICAgICAgICAg
ICAgICAgICAgICAgICB9LCAKCiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIp
CiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJh
ZGksbW9kZSIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgT25lCiAgICAgICAgICAgICAg
ICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAg
ICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgImFkaSxv
ZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8KICAgICAgICAgICAg
ICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0pCiAg
ICAgICAgICAgIH0KCiAgICAgICAgICAgIERldmljZSAoSU9QNCkKICAgICAgICAgICAgewogICAg
ICAgICAgICAgICAgTmFtZSAoX0FEUiwgMHgwNCkgIC8vIF9BRFI6IEFkZHJlc3MKICAgICAgICAg
ICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKDB4MDIpICAvLyBfRFNEOiBEZXZpY2UtU3BlY2lm
aWMgRGF0YQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIFRvVVVJRCAoImRh
ZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJiZjRhYTMwMSIpIC8qIERldmljZSBQcm9wZXJ0aWVz
IGZvciBfRFNEICovLCAKICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAzKQogICAgICAg
ICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKICAg
ICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlZyIs
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwNAogICAgICAgICAgICAgICAgICAgICAg
ICB9LCAKCiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAg
ICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhZGksbW9kZSIsIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwOAogICAgICAgICAgICAgICAgICAgICAgICB9
LCAKCiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAg
ICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhZGksb2ZmLXN0YXRlIiwg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICBaZXJvCiAgICAgICAgICAgICAgICAgICAgICAg
IH0KICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9KQogICAgICAgICAgICB9
CgogICAgICAgICAgICBEZXZpY2UgKElPUDUpCiAgICAgICAgICAgIHsKICAgICAgICAgICAgICAg
IE5hbWUgKF9BRFIsIDB4MDUpICAvLyBfQURSOiBBZGRyZXNzCiAgICAgICAgICAgICAgICBOYW1l
IChfRFNELCBQYWNrYWdlICgweDAyKSAgLy8gX0RTRDogRGV2aWNlLVNwZWNpZmljIERhdGEKICAg
ICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICBUb1VVSUQgKCJkYWZmZDgxNC02ZWJh
LTRkOGMtOGE5MS1iYzliYmY0YWEzMDEiKSAvKiBEZXZpY2UgUHJvcGVydGllcyBmb3IgX0RTRCAq
LywgCiAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMykKICAgICAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAg
ICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyZWciLCAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4MDUKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAg
ICAgICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWRpLG1vZGUiLCAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDB4MDMKICAgICAgICAgICAgICAgICAgICAgICAgfSwgCgogICAgICAg
ICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWRpLG9mZi1zdGF0ZSIsIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgWmVybwogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAg
ICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfSkKICAgICAgICAgICAgfQoKICAgICAgICAg
ICAgRGV2aWNlIChJT1A2KQogICAgICAgICAgICB7CiAgICAgICAgICAgICAgICBOYW1lIChfQURS
LCAweDA2KSAgLy8gX0FEUjogQWRkcmVzcwogICAgICAgICAgICAgICAgTmFtZSAoX0RTRCwgUGFj
a2FnZSAoMHgwMikgIC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBEYXRhCiAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgVG9VVUlEICgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEt
YmM5YmJmNGFhMzAxIikgLyogRGV2aWNlIFByb3BlcnRpZXMgZm9yIF9EU0QgKi8sIAogICAgICAg
ICAgICAgICAgICAgIFBhY2thZ2UgKDB4MDMpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAg
ICAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAyKQogICAgICAgICAgICAgICAgICAgICAgICB7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAicmVnIiwgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAweDA2CiAgICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAg
ICAgICAgICAgUGFja2FnZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImFkaSxtb2RlIiwgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAweDAyCiAgICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAg
ICAgICAgUGFja2FnZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgImFkaSxvZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFplcm8KICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAg
IH0KICAgICAgICAgICAgICAgIH0pCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIERldmljZSAo
SU9QNykKICAgICAgICAgICAgewogICAgICAgICAgICAgICAgTmFtZSAoX0FEUiwgMHgwNykgIC8v
IF9BRFI6IEFkZHJlc3MKICAgICAgICAgICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKDB4MDIp
ICAvLyBfRFNEOiBEZXZpY2UtU3BlY2lmaWMgRGF0YQogICAgICAgICAgICAgICAgewogICAgICAg
ICAgICAgICAgICAgIFRvVVVJRCAoImRhZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJiZjRhYTMw
MSIpIC8qIERldmljZSBQcm9wZXJ0aWVzIGZvciBfRFNEICovLCAKICAgICAgICAgICAgICAgICAg
ICBQYWNrYWdlICgweDAzKQogICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAg
ICAgICAgUGFja2FnZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgInJlZyIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgw
NwogICAgICAgICAgICAgICAgICAgICAgICB9LCAKCiAgICAgICAgICAgICAgICAgICAgICAgIFBh
Y2thZ2UgKDB4MDIpCiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJhZGksbW9kZSIsIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgT25lCiAg
ICAgICAgICAgICAgICAgICAgICAgIH0sIAoKICAgICAgICAgICAgICAgICAgICAgICAgUGFja2Fn
ZSAoMHgwMikKICAgICAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImFkaSxvZmYtc3RhdGUiLCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFplcm8K
ICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAg
ICAgICAgIH0pCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIE1ldGhvZCAoX0NSUywgMCwgTm90
U2VyaWFsaXplZCkgIC8vIF9DUlM6IEN1cnJlbnQgUmVzb3VyY2UgU2V0dGluZ3MKICAgICAgICAg
ICAgewogICAgICAgICAgICAgICAgTmFtZSAoUkJVRiwgUmVzb3VyY2VUZW1wbGF0ZSAoKQogICAg
ICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIEkyY1NlcmlhbEJ1c1YyICgweDAwMTAs
IENvbnRyb2xsZXJJbml0aWF0ZWQsIDB4MDAwNjFBODAsCiAgICAgICAgICAgICAgICAgICAgICAg
IEFkZHJlc3NpbmdNb2RlN0JpdCwgIlxcX1NCLlBDSTAuRDAyMiIsCiAgICAgICAgICAgICAgICAg
ICAgICAgIDB4MDAsIFJlc291cmNlQ29uc3VtZXIsICwgRXhjbHVzaXZlLAogICAgICAgICAgICAg
ICAgICAgICAgICApCiAgICAgICAgICAgICAgICB9KQogICAgICAgICAgICAgICAgUmV0dXJuIChS
QlVGKSAvKiBcX1NCXy5JMkMxLkkyQ0cuX0NSUy5SQlVGICovCiAgICAgICAgICAgIH0KICAgICAg
ICB9CiAgICB9Cg==
--00000000000034fd5c05ae63d357--
