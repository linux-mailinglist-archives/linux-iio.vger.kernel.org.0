Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7A25D795
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgIDLjL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgIDLjH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 07:39:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224EC061247
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 04:39:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so4178361pgl.10
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZsSEtXbdGZwNDe/reeEa8MB7MUmg353Vr3y9ojIlgWI=;
        b=ScZ0CL2D1WJ8tIN6dHf5oGiTx5bm0z0T0OThZIo3p/nLmu/UtA5AGYzUsFViZ/8sBA
         Y7fbQvqgZ/09PoloRkNz00rtqGi6d6fq+rHbPgEcvLwhMZq+vlPGWh0veGyFHfwQa4ER
         QwDNPyl+ER0PP05kOPsSq8NnZIhsK2tWbHtXznDtvFfmrPBF81QeHLPGQE9qzKCRw0n/
         PkEXCEwzV7yjXxXBvAzu1UU4DHCoTZC9pLlA7er5m1v1nNwxclmCnm3TAnKIdUVsgWQ9
         ktjCew9W1lDhBiZZkttQXis7m1RXPiRPgyi4RRoJIT7qs+3hCNW1bJZHwh2nVDYn+OKc
         dY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZsSEtXbdGZwNDe/reeEa8MB7MUmg353Vr3y9ojIlgWI=;
        b=FCp6aCzjXa/jc5ivdXVikJ+UIGyQZPBba0Hf2qrh9OJc+J2Li1ObZtmk0iz2UAELd0
         QyEp+RynJVz6XEQGhZNjRv+MIk43t4wKUdcPjXhao3JOc4SOPutTWDPkBCbEhowI91E1
         0ljWQYMANuqHiZsHlayyelYMsAvzV7vZPsjJUK6Fh7RtgS4PzTbC06o7VghzIFN3AkWA
         G60FzMJGutwHKbtaHeSp0fI7Za0YnPNtNbOcT5x7VfQ+P4yWhhDd0diV9ruK3bulV0FJ
         IGDLsdjijRvQtTqaBvyJU1hCXxCmLd5TtsywFtMm8z3+mOG5Ml5n0Bj2iDIOmS8yj6xS
         30Vw==
X-Gm-Message-State: AOAM533uZOk11l5+WgM/zgByNRumw8miXlrkHNtjlzq2uvYSvVs7TlXL
        RWQqOwto4iygSipl2M7CjDYAK8GGholtDEdbCO8=
X-Google-Smtp-Source: ABdhPJxnKkpY8D7A3454IwJYSUr8E2w5WX4dH+3y1iCaVPhBhMQIEaBojgixS6TlLbAhC05KRjgVBYey7vsXK7DF1IU=
X-Received: by 2002:a62:6083:0:b029:13c:1611:66c4 with SMTP id
 u125-20020a6260830000b029013c161166c4mr6564307pfb.15.1599219544435; Fri, 04
 Sep 2020 04:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
 <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
 <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com>
 <b1581dc61d584cffa2588f72b888ffa0@taipei09.ADVANTECH.CORP>
 <CAHp75Vfe525tpMuhH4Tr4U9gSMo3AzD=WWP30h-ZE6yEkdh4ZQ@mail.gmail.com> <705b481901d64d30830689f0aa541cb9@taipei09.ADVANTECH.CORP>
In-Reply-To: <705b481901d64d30830689f0aa541cb9@taipei09.ADVANTECH.CORP>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Sep 2020 14:38:47 +0300
Message-ID: <CAHp75Vd0RwDfwv3vHvcCbBhsvwSH0_f=L5aoJpU36xYeCBPd8A@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     "William.Sung" <William.Sung@advantech.com.tw>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     "Campion.Kang" <Campion.Kang@advantech.com.tw>,
        AceLan Kao <acelan.kao@canonical.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 4, 2020 at 12:09 PM William.Sung
<William.Sung@advantech.com.tw> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Friday, September 4, 2020 3:48 PM
> > To: William.Sung <William.Sung@advantech.com.tw>
> > On Fri, Sep 4, 2020 at 5:34 AM William.Sung
> > <William.Sung@advantech.com.tw> wrote:
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Thursday, September 3, 2020 6:42 PM On Thu, Sep 3, 2020 at
> > > > 10:37 AM AceLan Kao <acelan.kao@canonical.com>
> > > > wrote:

I think we may return to mailing list now (I slightly censored your
reply to me just in case).

...

> > > > > Here is the ADS5593 asl code, but I have no idea how to re-use it
> > > > > after it's been modified, the only way I know is to override the
> > > > > ACPI tables via initrd[1].
> > > >
> > > > There is also Config FS approach (like overlays) to do it at runtim=
e.
> > > > That what we are using in Yocto build for Intel Edison.
> > > >
> > > > > Could you share some examples in real cases that I can follow?
> > > >
> > > > Yes, like I mentioned StackOverflow search results (maybe G will gi=
ve
> > better).
> > > > But let's see what you have in your ASL code first.
> > > >
> > > > On the first glance I didn't see any issues with it, but on second =
look here is
> > one.
> > > > Look into this [5] example.
> > > > If you noticed it uses the same path in Scope and in the reference
> > > > in
> > > > I2cSerialBus() while in your ASL they are different.
> > > >
> > > > Do you have issues with loading it (as is and after above addressed=
)?
> > >
> > > Maybe I can explain it.
> > > In the beginning, I set I2C1 to both scope and reference in
> > > I2cSerialBus but it doesn't work. Then I check the probe progress of
> > > the i2c controller and found that the fwnode of i2c controller has
> > > replaced by \\_SB.PCI0.D022. After modifying the reference path to it=
, the
> > ad5593r driver works.
> >
> > Okay, so do I understand this right that you now have working case?
> >
> > About the reference node. Can I see DSDT (you may send it privately if =
you
> > consider it not for others)?
>
> The attachment is out original DSDT except ADS5593.

Thank you, it's very helpful!

> And the section of ADS5593 is what
> we got, and we do a little modification such as i2c bus reference
> and mode setting to fix our platform. After adding the part of ADS5593, w=
e could successfully
> probe up ad5593r with the driver in the current upstream source code.
>
> > And can you elaborate a bit about I=C2=B2C host controllers on your pla=
tform and
> > how they got enumerated (ACPI / PCI)?
>
> I'm sorry that I don't clearly know how the I2C host controller to be enu=
merated in our platform.
> The things I know getting from our BIOS team is that they implement in PC=
I mode (not ACPI mode).
> And the messages I got from dmesg show something like:
>         ACPI: bus type PCI registered
>         pci 0000:00:18.1 [8086:0f41] type 00 class 0x0c8000  // the i2c c=
ontroller we used.
> After catting the ADR from the fwnode of I2C controller, I got "0x0018000=
1", so I do know it reference
> to D022. But I do have no idea how it can be done.

This is almost it, only one little part is missed in above is the ACPI
ASL code, i.e.
           Device (D022)
           {
               Name (_ADR, 0x00180001)  // _ADR: Address
           }
that's how you got your firmware node for certain I=C2=B2C host controller
and that's why you need that device node.

So, it means that your Scope should also point to this node.
And if you wish you may consider ADS5593 code to be part of DSDT (just
defined somewhere after D022).

> > As I explained AceLan in previous reply the ADS5593 should be a child n=
ode of
> > the host controller node in DSDT.
> >
>
> Yes, you're right.
>
> > > I also did the different tests by switching the path of scope and
> > > reference between
> > > I2C1 and PCI0.D022, and the result seems like only the reference path
> > > of I2cSerialBus would impact to the ad5593r.
> >
> > Because we have a workaround in the kernel to find all I2cSerialBus()
> > resources over the ACPI namespace. It *does not* mean you can leave it =
like
> > this. You basically need to understand device hierarchy in your DSDT. I=
t seems
> > that actual controller is defined as D022 under PCI0 in SB (System Bus)=
 scope.
> >
> > > I will fix it on the same path for consistency and also preventing to=
 have
> > doubts about these.
> > >
> > > About the second _ADR value wrong, from now on the second channel can
> > > be set to the proper mode. But it still needs to be fixed since it wa=
s a typo
> > wrong.
> >
> > Basically the ACPI way is to use _ADR, but DT uses 'reg' property for t=
hat. I
> > hope at some point we will get some unification between those two in Li=
nux
> > kernel to have common API.

> May I know more about it?

Sure.

> In ads5592r-base.c, it parse the properties by:
>         device_for_each_child_node(st->dev, child) {
>                 ret =3D fwnode_property_read_u32(child, "reg", &reg);
>                 if (ret || reg >=3D ARRAY_SIZE(st->channel_modes))
>                         continue;
>
>                 ret =3D fwnode_property_read_u32(child, "adi,mode", &tmp)=
;
>                 if (!ret)
>                         st->channel_modes[reg] =3D tmp;
>
>                 fwnode_property_read_u32(child, "adi,off-state", &tmp);
>                 if (!ret)
>                         st->channel_offstate[reg] =3D tmp;
>         }
> In my understanding, it looks like ad5592r-base parse the properties no m=
atter what
> he ADR value is. Is there a proper way that we could use ADR value instea=
d?

What I meant here is some API instead of
                 ret =3D fwnode_property_read_u32(child, "reg", &reg);
do something like
                 ret =3D fwnode_property_get_child_address(child, &reg);
and behind the scenes it will try 'reg' property followed by _ADR evalution=
.

> > > > [5]:
> > > > https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-t=
a
> > > > bles/sa
> > > > mples/edison/ft6236.asli
> > > >
> > > > > Thanks.
> > > > >
> > > > > 1. Documentation/admin-guide/acpi/initrd_table_override.rst
> > > > >
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2020=E5=B9=
=B48=E6=9C=8831=E6=97=A5
> > =E9=80=B1
> > > > =E4=B8=80 =E4=B8=8B=E5=8D=888:48=E5=AF=AB=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Mon, Aug 31, 2020 at 3:45 PM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao
> > > > <acelan.kao@canonical.com> wrote:
> > > > > > > > This patch is mainly for Advantech's UNO-420[1] which is a
> > > > > > > > x86-based
> > > > platform.
> > > > > > > > This platform is more like a development platform for
> > > > > > > > customers to customize their products, so, specify the
> > > > > > > > channel modes in ACPI table is not generic enough, that's
> > > > > > > > why William submit this patch.
> > > > > > > >
> > > > > > > > Are there other ways to specify or pass values to the modul=
e
> > > > > > > > without using module parameters?
> > > > > > > > It's good if we can leverage sysfs, but I don't know if
> > > > > > > > there is one for this scenario.
> > > > > > >
> > > > > > > Can we provide DT bindings for that and use then in ACPI? ACP=
I
> > > > > > > has a possibility to reuse DT properties and compatible strin=
gs [1].
> > > > > > > As far as I can see the driver uses fwnode API, so it support=
s
> > > > > > > ACPI case already [2]. So, what prevents you to utilize 'adi,=
mode'
> > > > property?
> > > > > > >
> > > > > > > Also, we accept examples of ASL excerpt in meta-acpi project =
[3].
> > > > > > > It has already plenty of examples [4] how to use PRP0001 for
> > > > > > > DIY / development boards.
> > > > > > >
> > > > > > > So, take all together I think this patch is simple redundant.
> > > > > >
> > > > > > One more useful link is SO answers on the topic:
> > > > > > https://stackoverflow.com/search?tab=3Dnewest&q=3Dprp0001
> > > > > >
> > > > > > > [1]:
> > > > > > > https://www.kernel.org/doc/html/latest/firmware-guide/acpi/en=
u
> > > > > > > mera tion.html#device-tree-namespace-link-device-id
> > > > > > > [2]:
> > > > > > > https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentatio=
n
> > > > > > > /dev icetree/bindings/iio/dac/ad5592r.txt
> > > > > > > [3]: https://github.com/westeri/meta-acpi
> > > > > > > [4]:
> > > > > > > https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/=
a
> > > > > > > cpi-
> > > > > > > tables/samples
> > > > > > >
> > > > > > > P.S. Jonathan, it seems this driver has artificial ACPI HID.
> > > > > > > We probably have to remove it. However, ADS is indeed reserve=
d
> > > > > > > for Analog Devices in PNP registry. Can we have AD's official=
 answer
> > on this?
> > > > > > > Cc'ing additional AD people.
> > > > > > >
> > > > > > > > 1.
> > > > > > > > https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-=
9
> > > > > > > > df90
> > > > > > > > a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c

--=20
With Best Regards,
Andy Shevchenko
