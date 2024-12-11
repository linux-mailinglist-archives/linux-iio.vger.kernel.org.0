Return-Path: <linux-iio+bounces-13334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D79ED4B0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A763166C64
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E096202F9B;
	Wed, 11 Dec 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/4wvE6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4891AF0B4;
	Wed, 11 Dec 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941592; cv=none; b=mB6X1iCYJEYj7ZUzakVcTgaSEek9TUr4bh6Z9JgxYE3a3NlVGZZGe+wofIYNa6Kis5uOc2OYv/03YWFQXshhoi2Cxjxi38KAg1n6eDTLgHfFHLkWTqB0riCpRsKTKQpoyOrV7sTp6zhBFt+nWf/r3bbzSy5rYvuAV9OqjkA0sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941592; c=relaxed/simple;
	bh=Ssn19T29xjJ7/hr2Fcdh0xWuXACJai3gIq7Kjzvg0I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/aRfqL7h/hz8gHmNuhiRbsVfopGMv029K+8ijVFNX0pP7Fq1MbGbVnW36pWWa+2Nwk9Iis+IdxY1Zk0LpLMVhcEgadYf+HQU2Qv5K0wJ+lw0WiG82z1/ThSklBZ/RrJa5+7AkMuAAUYiMgJMY3wk/bzWSckuJYIQ13r16LRv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/4wvE6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A450CC4CED4;
	Wed, 11 Dec 2024 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941591;
	bh=Ssn19T29xjJ7/hr2Fcdh0xWuXACJai3gIq7Kjzvg0I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c/4wvE6i4vp+cB1YUEx31nXAv5SDIwrAXFunbOagzSontpwjd5igSetTXWnTAR/vv
	 s2qu5MeE7poS9ZSghTdjLDaUQGPvS186AlwnhNpRZL6OiHY+Kg9YgVBw9f5jDy5Pb3
	 JIdgMvScGqMuI+urq4hoVZ3ySZ5yGgQ/LVTtj1N751UdJ82+CXvt50kz9vv5aHmoMF
	 nFcO7uHunGVhye57haAaEpO7AdURbR8ut0WA11gX1XMI+VmHjfAzZwAvtEYcnB5xv7
	 3JoFpQEAAL4wXbjhnjcZtjr1QpWhdgoOf8pOortMppj2VQB+KjwrsbOqkUPOScI3k6
	 mIp8dpHo/X55g==
Date: Wed, 11 Dec 2024 18:26:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <20241211182615.356623a3@jic23-huawei>
In-Reply-To: <CA+4Vgc+veFb6hCP4A7mPH_uiUCnmbsa=guWySRekYj660osQyg@mail.gmail.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
	<20241203091540.3695650-3-j2anfernee@gmail.com>
	<20241208172236.18441e64@jic23-huawei>
	<CA+4Vgc+veFb6hCP4A7mPH_uiUCnmbsa=guWySRekYj660osQyg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 13:38:20 +0800
Yu-Hsian Yang <j2anfernee@gmail.com> wrote:

> Dear Jonathan Cameron,
>=20
> Thanks for your comment.
>=20
> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:22=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Tue,  3 Dec 2024 17:15:40 +0800
> > Eason Yang <j2anfernee@gmail.com> wrote:
> > =20
> > > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> > >
> > > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and u=
p to
> > > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins =
for
> > > independent alarm signals, and the all threshold values could be set =
for
> > > system protection without any timing delay. It also supports reset in=
put
> > > RSTIN# to recover system from a fault condition.
> > >
> > > Currently, only single-edge mode conversion and threshold events supp=
ort.
> > >
> > > Signed-off-by: Eason Yang <j2anfernee@gmail.com> =20
> > Hi Eason,
> >
> > Given you have some good reviews already I only took a very quick glance
> > through.  A few things inline
> >
> > Jonathan
> > =20
> > > diff --git a/drivers/iio/adc/nct720x.c b/drivers/iio/adc/nct720x.c
> > > new file mode 100644
> > > index 000000000000..b28b5f4d7d70
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/nct720x.c =20
> > =20
> > > +
> > > +static int nct720x_write_event_value(struct iio_dev *indio_dev,
> > > +                                  const struct iio_chan_spec *chan,
> > > +                                  enum iio_event_type type,
> > > +                                  enum iio_event_direction dir,
> > > +                                  enum iio_event_info info,
> > > +                                  int val, int val2)
> > > +{
> > > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > > +     int index, err =3D 0;
> > > +     long v1, v2, volt;
> > > +
> > > +     index =3D nct720x_chan_to_index[chan->address];
> > > +     volt =3D (val * NCT720X_IN_SCALING_FACTOR) / NCT720X_IN_SCALING;
> > > +     v1 =3D volt >> 5;
> > > +     v2 =3D (volt & REG_VIN_LIMIT_LSB_MASK) << 3;
> > > +
> > > +     if (chan->type !=3D IIO_VOLTAGE)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> > > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > > +                     guard(mutex)(&chip->access_lock); =20
> >
> > Might as well move this up one level as it is called in both legs.
> > =20
>=20
> I would remove guard(mutex) up one level.
A small process thing.  There is no need to reply to parts of a review
where you agree.  It just means more to read for everyone!

I assume if you didn't comment you are fine with the feedback.
Just crop down to the bits where discussion is needed.

>=20
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_LOW_=
LIMIT[index], v1);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_LOW_LIMIT\n",
> > > +                                     index + 1);
> > > +
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_LOW_=
LIMIT_LSB[index], v2);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_LOW_LIMIT_LSB\n",
> > > +                                     index + 1);
> > > +
> > > +             } else {
> > > +                     guard(mutex)(&chip->access_lock);
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_HIGH=
_LIMIT[index], v1);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_HIGH_LIMIT\n",
> > > +                                     index + 1);
> > > +
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_HIGH=
_LIMIT_LSB[index], v2);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_HIGH_LIMIT_LSB\n",
> > > +                                     index + 1);
> > > +             }
> > > +     }
> > > +     return err;
> > > +} =20
> > =20
> > > +
> > > +static const struct iio_info nct720x_info =3D {
> > > +     .read_raw =3D nct720x_read_raw,
> > > +     .read_event_config =3D nct720x_read_event_config,
> > > +     .write_event_config =3D nct720x_write_event_config,
> > > +     .read_event_value =3D nct720x_read_event_value,
> > > +     .write_event_value =3D nct720x_write_event_value, =20
> >
> > Given you are supporting with and without interrupts, should probably p=
ick between
> > versions of this that have the event config part and one that doesn't.
> > =20
>=20
> Sorry, could you give some examples for us to refer.
Sure, something like:

static const struct iio_info nct720x_info =3D {
     .read_raw =3D nct720x_read_raw,
     .read_event_config =3D nct720x_read_event_config,
     .write_event_config =3D nct720x_write_event_config,
     .read_event_value =3D nct720x_read_event_value,
     .write_event_value =3D nct720x_write_event_value, =20
};

static const struct iio_info nct720x_info_no_irq =3D {
     .read_raw =3D nct720x_read_raw,
};

if (irq)
	indio_dev->info =3D nct720x_info;
else
	indio_dev->info =3D nct720x_info_no_irq;

It isn't strictly necessary I think, but it is cleaner to not provide
callbacks that should not be called.
   }
> > > +
> > > +     guard(mutex)(&chip->access_lock);
> > > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value=
);
> > > +     if (err < 0)
> > > +             return err;
> > > +     data[0] =3D (u8)value;
> > > +
> > > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value=
);
> > > +     if (err < 0)
> > > +             return err; =20
> >
> > Here I think you can use a bulk read as the registers are next to each =
other.
> > =20
>=20
> Generally, registers with 8 bits support Byte format, and registers
> with more than 8 bits support Word format.
> If transmission a Word command to a register that supports Byte
> format, the second byte will get 0xFF.
> Here, if we use regmap_bulk_read(), we would get first byte correct
> and second byte is wrong 0xff.
> I use i2ctransfer to demo it.
> root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r1
> 0xff
> root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x14 r1
> 0x0f

As your regmap for these registers is 8 bit one the function here:
https://elixir.bootlin.com/linux/v6.12.4/source/drivers/base/regmap/regmap-=
i2c.c#L306
should have picked you a regmap bus config that only does 8 bit reads.

Thus when you use a regmap_bulk_read() it should issue two of those to neig=
hbouring
registers, not use a word read.  So that should work in this specific case.


Thanks,

Jonathan

