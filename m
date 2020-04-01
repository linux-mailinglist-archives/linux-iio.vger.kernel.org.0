Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC6E19A974
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgDAKXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 06:23:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36712 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgDAKXA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 06:23:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so9447027plo.3;
        Wed, 01 Apr 2020 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sJXYD/KrXkJjDAueyAH7HsEdzJYm9FD8Z2MtDlOCrrk=;
        b=UtEUt4mbMenaSDfZ+i3oxoB6VUwNtDy/5KRhj8thR4LPppi7VQh6sM8j1nP6wjhGE9
         2kH1BD0+xnEKaD42Ohd9A4Dmzi2OW7DT8Vk/ApqUG9v4QKYrt7AZ9W1jzrwp3I8PAOWO
         SGFvKChvZw/1NxSlE3/Qu8AY0smSXBjKMK5Jhy2uPKS3DT5hx60H8uQE4Vgz+1BZprZ1
         O33Mxelnw9iGXfRITH03Z4QePDAi65XyGeK7bYI2FywCfCJ3CU2yJSDGeJ4DaDwAQCzl
         8jOdKGkX40x2V4XmYWAgW/llpHjTAhGd0hzf6w05o9mN2RuULaD8rpkqbIzZIicROrFB
         rkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJXYD/KrXkJjDAueyAH7HsEdzJYm9FD8Z2MtDlOCrrk=;
        b=Xvs4eUM7+q6oyC0riAwwCz2acsQKwzgROdeM2zgqfPQqXhXiCD7rwaRFb7jyaLB5N8
         NX9BOfAlv4KY071cEmyFfJnGV6SKiEaNnFFa6OKsWNL8F6Qxy5UTpDh76fWfdMNT/V3U
         yES6OKAjMTR0rPt7zmJ2E8KPRlJEpBKZKXiaBYTaK2Qq3IM2cGKKv4/AkvxSAOn356ow
         vhJx08MYu4/QrmnkatNODEhTVlZE78D/Sz4902KuL1XNjOn0ayHxBTPnlfBxerquWkWc
         K40tqzAJW9ZkikVmOVOvdZzROLR5SDy57NSxqIHNj6P4OqkwkhwuDXTwol+Exax3bCLd
         kU1Q==
X-Gm-Message-State: AGi0PuYhfklbofwyFss2igT6TdhTUmPvCynCC8X/LV8mDR21dPuaThP3
        Ncl5diZ37bFrA0J8Oh3j7/VJnS0dcEi3Wjt8ZDk=
X-Google-Smtp-Source: APiQypJhwdk0KJ+Lsizg8n6B6HQOSOOZMnjnlz8bonWMFGqFcS2kC5KJTEBx4N3caI1tfhW8Q1NYHmWq55WINwHyYSk=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr3889830pjb.143.1585736578573;
 Wed, 01 Apr 2020 03:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-6-nuno.sa@analog.com>
 <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com> <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 13:22:51 +0300
Message-ID: <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 1, 2020 at 10:13 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Dienstag, 31. M=C3=A4rz 2020 20:16
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; devicetree
> > <devicetree@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Ardelean,
> > Alexandru <alexandru.Ardelean@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
> > On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote=
:

...

> > > +#include <asm/unaligned.h>

> I thought we wanted alphabetic order...

Yes, but from more generic header groups to less generic. Inside each
group is alphabetical.
asm/ is less generic than linux/.

> > Usually it goes after linux/*

> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/debugfs.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> >
> > > +#include <linux/kernel.h>
> >
> > What this is for?
> >
> Yeps. Not really needed...

I think you needed it for DIV_ROUND_UP or alike macros. It also has
container_of...

> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/imu/adis.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/module.h>
> >
> > > +#include <linux/of_device.h>
> >
> > Do you really need this? Perhaps mod_devicetable.h is what you are look=
ing
> > for.
> >
>
> Yes. For ` of_device_get_match_data ``. If changed by `device_get_match_d=
ata`, then I guess
> I can drop it..

Probably change to mod_devicetable.h with property.h.

> > > +#include <linux/spi/spi.h>

...

> > > +       for (i =3D ARRAY_SIZE(adis16475_3db_freqs) - 2; i >=3D 1; i--=
) {
> >
> > Why those margins? size-2 and 1 ?
> >
>
> The -2 is needed since index 7 is not valid. The 1 I honestly don't remem=
ber why I did it
> like this. Using > 0 is the same and more "common"...

More common is >=3D 0. That's my question basically.
And if 7 is not valid why to keep it in the array at all?

> > > +               if (adis16475_3db_freqs[i] >=3D filter)
> > > +                       break;
> > > +       }

...

> > > +#define ADIS16475_GYRO_CHANNEL(_mod) \
> > > +       ADIS16475_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> > > +       ADIS16475_REG_ ## _mod ## _GYRO_L, ADIS16475_SCAN_GYRO_ ##
> > _mod, 32, \
> > > +       32)
> >
> > It's not obvious that this is macro inside macro. Can you indent better=
?
> > Ditto for the rest similar ones.
> >
>
> Honestly here I don't see any problems with indentation and it goes in co=
nformity with
> other IMU drivers already in tree. So here, as long as anyone else has a =
problem with this, I prefer
> to keep it this way...

I'm not a maintainer, not my call :-)

...

> > > +       buffer =3D (u16 *)adis->buffer;
> >
> > Why the casting is needed?
> >
> > > +       crc =3D get_unaligned_be16(&buffer[offset + 2]);
> >
> > If your buffer is aligned in the structure, you may simple use be16_to_=
cpu().
> > Same for the rest of get_unaligned*() calls.
> > Or do you have unaligned data there?
>
> This is a nice point. So, honestly I made it like this to keep conformity=
 with other drivers we have
> in our internal tree (in queue for upstream) and I also wondered about th=
is. The only justification I can
> find to use unligned calls is to keep this independent from the ADIS lib =
(not sure if it makes sense) since
> we get the pointer from the library (allocated there).
>
> Now, if Im not missing nothing obvious we can access the buffer normally =
since it's being allocated
> with kmalloc which means we have  ARCH_KMALLOC_MINALIGN (which is at leas=
t 8 if Im not mistaken).
> On top of this, the device sends the data as n 16 bits segments. So in th=
eory, I guess we can ditch the
> overhead of the *unaligned calls if any objections?

No objections from my side at least.

...

> > > +       desc =3D irq_get_irq_data(spi->irq);
> >
> > > +       if (!desc) {
> > > +               dev_err(&spi->dev, "Could not find IRQ %d\n", spi->ir=
q);
> > > +               return -EINVAL;
> > > +       }
> >
> > Is this even possible?

> I guess. If someone does not include it in device tree...

Hmm... and this function will be called anyway?

--=20
With Best Regards,
Andy Shevchenko
