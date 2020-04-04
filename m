Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7A19E655
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDDQFR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 12:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgDDQFR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 12:05:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C01E206D4;
        Sat,  4 Apr 2020 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586016316;
        bh=HW7aE2/knhyGocfIyYeP5gXtMUPsb6H/6ETBizWYE1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvL8HCt3+Q3xraEuy+spg8tjKwYWI3osBJDAo3Dfs6rDO0q7x1XUkdVi7suwvkpVp
         xUkaqmCzn2voIMWwraDLgvqfeRbnyCrjkgbFtfzj4AO+Yom55Zc7zmKd4+iPu6s0Oq
         5tA6+BhktC+CnlSkMe/tfaBNh6Y4YhKnAOtfLQZw=
Date:   Sat, 4 Apr 2020 17:05:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
Message-ID: <20200404170511.0966b7e4@archlinux>
In-Reply-To: <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
        <20200331114811.7978-6-nuno.sa@analog.com>
        <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
        <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
        <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
        <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Apr 2020 13:27:31 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>=
 On
> > Behalf Of Andy Shevchenko
> > Sent: Mittwoch, 1. April 2020 12:23
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; devicetree
> > <devicetree@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Ardelean,
> > Alexandru <alexandru.Ardelean@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
> >=20
> > On Wed, Apr 1, 2020 at 10:13 AM Sa, Nuno <Nuno.Sa@analog.com> wrote: =20
> > > =20
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Dienstag, 31. M=C3=A4rz 2020 20:16
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-iio <linux-iio@vger.kernel.org>; devicetree
> > > > <devicetree@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > > > Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen =20
> > <lars@metafoo.de>; =20
> > > > Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring
> > > > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; =20
> > Ardelean, =20
> > > > Alexandru <alexandru.Ardelean@analog.com>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>
> > > > Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
> > > > On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> w=
rote: =20
> >=20
> > ...
> >  =20
> > > > > +#include <asm/unaligned.h> =20
> >  =20
> > > I thought we wanted alphabetic order... =20
> >=20
> > Yes, but from more generic header groups to less generic. Inside each
> > group is alphabetical.
> > asm/ is less generic than linux/.
> > =20
>=20
> Got it...
>=20
> > > > Usually it goes after linux/* =20
> >  =20
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/bitops.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/debugfs.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h> =20
> > > > =20
> > > > > +#include <linux/kernel.h> =20
> > > >
> > > > What this is for?
> > > > =20
> > > Yeps. Not really needed... =20
> >=20
> > I think you needed it for DIV_ROUND_UP or alike macros. It also has
> > container_of...
> >  =20
>=20
> Yes, DIV_ROUND_CLOSEST is defined there...
>=20
> > > > > +#include <linux/iio/buffer.h>
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/iio/imu/adis.h>
> > > > > +#include <linux/iio/sysfs.h>
> > > > > +#include <linux/iio/trigger_consumer.h>
> > > > > +#include <linux/irq.h>
> > > > > +#include <linux/module.h> =20
> > > > =20
> > > > > +#include <linux/of_device.h> =20
> > > >
> > > > Do you really need this? Perhaps mod_devicetable.h is what you are =
=20
> > looking =20
> > > > for.
> > > > =20
> > >
> > > Yes. For ` of_device_get_match_data ``. If changed by =20
> > `device_get_match_data`, then I guess =20
> > > I can drop it.. =20
> >=20
> > Probably change to mod_devicetable.h with property.h.
> >  =20
> > > > > +#include <linux/spi/spi.h> =20
> >=20
> > ...
> >  =20
> > > > > +       for (i =3D ARRAY_SIZE(adis16475_3db_freqs) - 2; i >=3D 1;=
 i--) { =20
> > > >
> > > > Why those margins? size-2 and 1 ?
> > > > =20
> > >
> > > The -2 is needed since index 7 is not valid. The 1 I honestly don't r=
emember =20
> > why I did it =20
> > > like this. Using > 0 is the same and more "common"... =20
> >=20
> > More common is >=3D 0. That's my question basically.
> > And if 7 is not valid why to keep it in the array at all? =20
>=20
> Well, I can remove the 7. I honestly took it from another driver and I gu=
ess the idea
> is to make explicit that 7 is not supported. Since this is a 3 bit field =
and the datasheet
> does not state this directly.
>=20
> As for the >=3D0, I prefer to have either as is or >0 since we don't real=
ly need to check the
> index 0. If 1 fails, then we will use 0 either way...
>=20
> > > > > +               if (adis16475_3db_freqs[i] >=3D filter)
> > > > > +                       break;
> > > > > +       } =20
> >=20
> > ...
> >  =20
> > > > > +#define ADIS16475_GYRO_CHANNEL(_mod) \
> > > > > +       ADIS16475_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> > > > > +       ADIS16475_REG_ ## _mod ## _GYRO_L, ADIS16475_SCAN_GYRO_ =
=20
> > ## =20
> > > > _mod, 32, \ =20
> > > > > +       32) =20
> > > >
> > > > It's not obvious that this is macro inside macro. Can you indent be=
tter?
> > > > Ditto for the rest similar ones.
> > > > =20
> > >
> > > Honestly here I don't see any problems with indentation and it goes i=
n =20
> > conformity with =20
> > > other IMU drivers already in tree. So here, as long as anyone else ha=
s a =20
> > problem with this, I prefer =20
> > > to keep it this way... =20
> >=20
> > I'm not a maintainer, not my call :-)
> >=20
> > ...
> >  =20
> > > > > +       buffer =3D (u16 *)adis->buffer; =20
> > > >
> > > > Why the casting is needed?
> > > > =20
> > > > > +       crc =3D get_unaligned_be16(&buffer[offset + 2]); =20
> > > >
> > > > If your buffer is aligned in the structure, you may simple use =20
> > be16_to_cpu(). =20
> > > > Same for the rest of get_unaligned*() calls.
> > > > Or do you have unaligned data there? =20
> > >
> > > This is a nice point. So, honestly I made it like this to keep confor=
mity with =20
> > other drivers we have =20
> > > in our internal tree (in queue for upstream) and I also wondered abou=
t this. =20
> > The only justification I can =20
> > > find to use unligned calls is to keep this independent from the ADIS =
lib (not =20
> > sure if it makes sense) since =20
> > > we get the pointer from the library (allocated there).

It would be very odd to get a buffer from a library dealing with this sort =
of
device that wanted at least 8 byte aligned.  I guess we could add a paranoid
check in the driver, but I think we can safely assume this is fine without =
one.

> > >
> > > Now, if Im not missing nothing obvious we can access the buffer norma=
lly =20
> > since it's being allocated =20
> > > with kmalloc which means we have  ARCH_KMALLOC_MINALIGN (which is =20
> > at least 8 if Im not mistaken). =20
> > > On top of this, the device sends the data as n 16 bits segments. So i=
n theory, =20
> > I guess we can ditch the =20
> > > overhead of the *unaligned calls if any objections? =20
> >=20
> > No objections from my side at least.
> >  =20
>=20
> I will wait to see if someone else has anything to add and if not, I will=
 change it
> to normal buffer accesses (probably using restricted types).
>=20

If it's aligned, definitely prefer that to be explicit in the driver and use
the relevant endian types.

We have had a few cases where things are oddly padded so this may be cut and
paste from one of those.

Jonathan


