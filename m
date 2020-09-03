Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6011625BF37
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICKmc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 06:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICKma (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 06:42:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49402C061244;
        Thu,  3 Sep 2020 03:42:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so1994348pfb.6;
        Thu, 03 Sep 2020 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFbz9SK9Nrxa2E9LPeezB4X58SZviUfZBi06Rq535T4=;
        b=TNxli9wcYSXAitaIux7dlyj6o9b0i5BIFNGEG3WBdSpc7QMvfBrz5/ym4DS/NF9lzp
         3ntNgkPTB4MXzDHxyX3ZJPeosICb0OC+0HJYboWvKkJZhg4KayQgZZgSgb88ifk5dJXQ
         KQhCDiPM+m5yZ+cuejw0rcs00+21FgaOHOwjEpyjYyDDQ96Gncq1cdw92FhPGdAv7uaO
         gN4n+7wqr6/kH/z+/hfrtNZWeNf7ifzGudUx41CtTNvgMHSzYm3XqOraIzzOoTk5DW57
         ebH/IdXssnSiunfBjigxUvm+pk16cfTS/w3hfSywa9GHU2MfynXMuQPNDOVZ2s6JT0DM
         dBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFbz9SK9Nrxa2E9LPeezB4X58SZviUfZBi06Rq535T4=;
        b=ZvzPdARGyp+pn4+S2bPo4j/vKKkBrjN7qQgRhqeDqn+CcNZlGXCW4YbY6BEahUAEBY
         3hIh4PinqZaYxk7y6E40ydruMqpPojSdNF+Mi2kWgcL89GzDt6Px9c3TTJA2r2jLfBZx
         U0hGFr8Qn7DktmQWZqfW7/66Hjsaq91id7Hnrm4DC9J6vVw6UhaSCze8Y6hPzogzaKf8
         vuMfMiWWTdZrw9LneZJdtkAMOQkKJAi85Bi52Umz+aFk8HFkVyinkGZa+Hh7rpA1iPQD
         Q2DrrpY9FxeAcdWmwzzPtUncjWzXvIJA//IqIc5gvz9qvgrj15AS/SB0cVBrpIZX6FRr
         ZRFg==
X-Gm-Message-State: AOAM530A9SLn0S5MuxmOLOzG9Z4ijl9q24/9B7dC/5rmotlIgVFuvBm2
        2jproj1tEW7dheLIGNAd8B9BisXNMMHeSAcWH0A=
X-Google-Smtp-Source: ABdhPJwtSn3K2Nh6ROlIa21YvBJsgbVbZCQWpsd99PVLh3WwsqV59mgkNASfA43mjqR6Gqb4tjLzmgU4QEiv4AECoew=
X-Received: by 2002:aa7:942a:: with SMTP id y10mr2235033pfo.68.1599129749735;
 Thu, 03 Sep 2020 03:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com> <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
In-Reply-To: <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 13:42:12 +0300
Message-ID: <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     AceLan Kao <acelan.kao@canonical.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 10:37 AM AceLan Kao <acelan.kao@canonical.com> wrote=
:
>
> Hi Andy,
>
> I spent some time studying/reading what you wrote, but I still don't
> understand how to leverage meta-acpi.

meta-acpi is a Yocto layer to support provided ACPI tables for the
build. My point here is to have it as a collection of ASL examples.
It's what you asked for below in this email.
Also we can collect your ASL example under board (presumably new) folder.

> From what I understand from the following discussion in the thread,
> ADS5593 could be used,
> so we can keep using it and don't have to introduce PRP0001 in the table,=
 right?

Precisely!

> Here is the ADS5593 asl code, but I have no idea how to re-use it
> after it's been modified,
> the only way I know is to override the ACPI tables via initrd[1].

There is also Config FS approach (like overlays) to do it at runtime.
That what we are using in Yocto build for Intel Edison.

> Could you share some examples in real cases that I can follow?

Yes, like I mentioned StackOverflow search results (maybe G will give bette=
r).
But let's see what you have in your ASL code first.

On the first glance I didn't see any issues with it, but on second
look here is one. Look into this [5] example.
If you noticed it uses the same path in Scope and in the reference in
I2cSerialBus() while in your ASL they are different.

Do you have issues with loading it (as is and after above addressed)?

[5]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tabl=
es/samples/edison/ft6236.asli

> Thanks.
>
> 1. Documentation/admin-guide/acpi/initrd_table_override.rst
>
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=
=9C=8831=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:48=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > On Mon, Aug 31, 2020 at 3:45 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao <acelan.kao@canonical.com>=
 wrote:
> > > > This patch is mainly for Advantech's UNO-420[1] which is a x86-base=
d platform.
> > > > This platform is more like a development platform for customers to
> > > > customize their products,
> > > > so, specify the channel modes in ACPI table is not generic enough,
> > > > that's why William submit this patch.
> > > >
> > > > Are there other ways to specify or pass values to the module withou=
t
> > > > using module parameters?
> > > > It's good if we can leverage sysfs, but I don't know if there is on=
e
> > > > for this scenario.
> > >
> > > Can we provide DT bindings for that and use then in ACPI? ACPI has a
> > > possibility to reuse DT properties and compatible strings [1]. As far
> > > as I can see the driver uses fwnode API, so it supports ACPI case
> > > already [2]. So, what prevents you to utilize 'adi,mode' property?
> > >
> > > Also, we accept examples of ASL excerpt in meta-acpi project [3]. It
> > > has already plenty of examples [4] how to use PRP0001 for DIY /
> > > development boards.
> > >
> > > So, take all together I think this patch is simple redundant.
> >
> > One more useful link is SO answers on the topic:
> > https://stackoverflow.com/search?tab=3Dnewest&q=3Dprp0001
> >
> > > [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enume=
ration.html#device-tree-namespace-link-device-id
> > > [2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/d=
evicetree/bindings/iio/dac/ad5592r.txt
> > > [3]: https://github.com/westeri/meta-acpi
> > > [4]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acp=
i-tables/samples
> > >
> > > P.S. Jonathan, it seems this driver has artificial ACPI HID. We
> > > probably have to remove it. However, ADS is indeed reserved for Analo=
g
> > > Devices in PNP registry. Can we have AD's official answer on this?
> > > Cc'ing additional AD people.
> > >
> > > > 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90=
a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c



--=20
With Best Regards,
Andy Shevchenko
