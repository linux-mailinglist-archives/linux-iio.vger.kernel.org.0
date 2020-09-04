Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14325D2A9
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDHsk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIDHsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 03:48:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435C2C061244;
        Fri,  4 Sep 2020 00:48:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s10so785315plp.1;
        Fri, 04 Sep 2020 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uPFv48QeEGFXDPsBocwFn7rcdjGA5yIBGtzHopz3DnM=;
        b=l03o4IYtYJ29LkCNQJ3kQ1p3nm/xtKz4x1P+3ClwN9ZpRxCfsdKxpx12Bj5Yxs67jD
         MEyw9sNHPXcXLU27xFlXcJo+v76XoJoDPu4XA0OtCmNJHmgxZ201lclTcv6uufxW+Mkl
         sH6YD2DMPXGYqWcttrdvgWeUOa9y2rGZQuevAKVeIe6U2/d9f+o3IsLmIiZEHXjZTSr8
         F3ROUeR1w0JeU1ukOH1okPEBTYegn7Eoz8CTtCu2unMyaHz1F16VbCyMN4igMKRI8Xtd
         TIHjJ1xEt+D0UTLf5aatLxWVqX5YeTyN/Qr+9uH5GtoTzwkkssBZKEqzacsqAFEdn5kf
         Ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uPFv48QeEGFXDPsBocwFn7rcdjGA5yIBGtzHopz3DnM=;
        b=TgaOMVDGDUK25tx5EiFwDNk/z2+Fv9RchZC4sIQRBmnD64OGbAiGWEII6ewh7H5Ry8
         giMtgSApL+hGufhGF6gYlBgOVS3A+BC4q/vzUhpa9AoTYMIm/uT8myo68bAdBB3W/ME+
         3sF7NiFs7sk3jML5HTZQMwjtUfHaDLLLKFaW6V0tzwu2iZl2fTjzppuSXP1q2oZZOrzR
         l0+R9WQsA4wfGfOprgDSOp6XTGkNK1vmWN8Z9Ig1dbTe2LR4/WNVH0ZClHjG2cpRjcLh
         cQBii57wh3Hw+WEC+apXmCtqQZqEspqMtYexHkwFm9gcncpdiVaG/Cra56KbZZhmkbvW
         7GfA==
X-Gm-Message-State: AOAM532/uwMWAcWFWq5qOY00cnstN3WG4vciLlT7NI03QhC/j5FfTlE7
        ilJhKWVKGLaygRCJnDeRd8X/7BH4+hZ9KmZ5d7gLnutHRn3xNg==
X-Google-Smtp-Source: ABdhPJwEf7xbA4WdhfuxIlqbQ9P0D5Mk3fnFUrNy/wdfGdmYLzFbLh6ELk+vyuMBVN4a20XBxIoFHbmP2m5g40r9YzU=
X-Received: by 2002:a17:90a:2ac6:: with SMTP id i6mr4218745pjg.181.1599205717733;
 Fri, 04 Sep 2020 00:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
 <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
 <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com> <b1581dc61d584cffa2588f72b888ffa0@taipei09.ADVANTECH.CORP>
In-Reply-To: <b1581dc61d584cffa2588f72b888ffa0@taipei09.ADVANTECH.CORP>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Sep 2020 10:48:20 +0300
Message-ID: <CAHp75Vfe525tpMuhH4Tr4U9gSMo3AzD=WWP30h-ZE6yEkdh4ZQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     "William.Sung" <William.Sung@advantech.com.tw>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Campion.Kang" <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 4, 2020 at 5:34 AM William.Sung
<William.Sung@advantech.com.tw> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Thursday, September 3, 2020 6:42 PM
> > On Thu, Sep 3, 2020 at 10:37 AM AceLan Kao <acelan.kao@canonical.com>
> > wrote:

...

> > > Here is the ADS5593 asl code, but I have no idea how to re-use it
> > > after it's been modified, the only way I know is to override the ACPI
> > > tables via initrd[1].
> >
> > There is also Config FS approach (like overlays) to do it at runtime.
> > That what we are using in Yocto build for Intel Edison.
> >
> > > Could you share some examples in real cases that I can follow?
> >
> > Yes, like I mentioned StackOverflow search results (maybe G will give b=
etter).
> > But let's see what you have in your ASL code first.
> >
> > On the first glance I didn't see any issues with it, but on second look=
 here is one.
> > Look into this [5] example.
> > If you noticed it uses the same path in Scope and in the reference in
> > I2cSerialBus() while in your ASL they are different.
> >
> > Do you have issues with loading it (as is and after above addressed)?
> >
>
> Maybe I can explain it.
> In the beginning, I set I2C1 to both scope and reference in I2cSerialBus =
but it
> doesn't work. Then I check the probe progress of the i2c controller and f=
ound that
> the fwnode of i2c controller has replaced by \\_SB.PCI0.D022. After modif=
ying the reference
> path to it, the ad5593r driver works.

Okay, so do I understand this right that you now have working case?

About the reference node. Can I see DSDT (you may send it privately if
you consider it not for others)?
And can you elaborate a bit about I=C2=B2C host controllers on your
platform and how they got enumerated (ACPI / PCI)?

As I explained AceLan in previous reply the ADS5593 should be a child
node of the host controller node in DSDT.

> I also did the different tests by switching the path of scope and referen=
ce between
> I2C1 and PCI0.D022, and the result seems like only the reference path of =
I2cSerialBus
> would impact to the ad5593r.

Because we have a workaround in the kernel to find all I2cSerialBus()
resources over the ACPI namespace. It *does not* mean you can leave it
like this. You basically need to understand device hierarchy in your
DSDT. It seems that actual controller is defined as D022 under PCI0 in
SB (System Bus) scope.

> I will fix it on the same path for consistency and also preventing to hav=
e doubts about these.
>
> About the second _ADR value wrong, from now on the second channel can be =
set to the proper
> mode. But it still needs to be fixed since it was a typo wrong.

Basically the ACPI way is to use _ADR, but DT uses 'reg' property for
that. I hope at some point we will get some unification between those
two in Linux kernel to have common API.


> > [5]:
> > https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-table=
s/sa
> > mples/edison/ft6236.asli
> >
> > > Thanks.
> > >
> > > 1. Documentation/admin-guide/acpi/initrd_table_override.rst
> > >
> > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2020=E5=B9=B48=
=E6=9C=8831=E6=97=A5 =E9=80=B1
> > =E4=B8=80 =E4=B8=8B=E5=8D=888:48=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Mon, Aug 31, 2020 at 3:45 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao
> > <acelan.kao@canonical.com> wrote:
> > > > > > This patch is mainly for Advantech's UNO-420[1] which is a x86-=
based
> > platform.
> > > > > > This platform is more like a development platform for customers
> > > > > > to customize their products, so, specify the channel modes in
> > > > > > ACPI table is not generic enough, that's why William submit thi=
s
> > > > > > patch.
> > > > > >
> > > > > > Are there other ways to specify or pass values to the module
> > > > > > without using module parameters?
> > > > > > It's good if we can leverage sysfs, but I don't know if there i=
s
> > > > > > one for this scenario.
> > > > >
> > > > > Can we provide DT bindings for that and use then in ACPI? ACPI ha=
s
> > > > > a possibility to reuse DT properties and compatible strings [1].
> > > > > As far as I can see the driver uses fwnode API, so it supports
> > > > > ACPI case already [2]. So, what prevents you to utilize 'adi,mode=
'
> > property?
> > > > >
> > > > > Also, we accept examples of ASL excerpt in meta-acpi project [3].
> > > > > It has already plenty of examples [4] how to use PRP0001 for DIY =
/
> > > > > development boards.
> > > > >
> > > > > So, take all together I think this patch is simple redundant.
> > > >
> > > > One more useful link is SO answers on the topic:
> > > > https://stackoverflow.com/search?tab=3Dnewest&q=3Dprp0001
> > > >
> > > > > [1]:
> > > > > https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumer=
a
> > > > > tion.html#device-tree-namespace-link-device-id
> > > > > [2]:
> > > > > https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/de=
v
> > > > > icetree/bindings/iio/dac/ad5592r.txt
> > > > > [3]: https://github.com/westeri/meta-acpi
> > > > > [4]:
> > > > > https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi=
-
> > > > > tables/samples
> > > > >
> > > > > P.S. Jonathan, it seems this driver has artificial ACPI HID. We
> > > > > probably have to remove it. However, ADS is indeed reserved for
> > > > > Analog Devices in PNP registry. Can we have AD's official answer =
on this?
> > > > > Cc'ing additional AD people.
> > > > >
> > > > > > 1.
> > > > > > https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df9=
0
> > > > > > a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c

--=20
With Best Regards,
Andy Shevchenko
