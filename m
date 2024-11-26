Return-Path: <linux-iio+bounces-12688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F79D9B7C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263E8B2A88B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917E1D6DB7;
	Tue, 26 Nov 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaNJUPm0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F551D63C5;
	Tue, 26 Nov 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637805; cv=none; b=PR3JZo+O/KMTX6JY4Wg7JtxxU9+R3tymCOFdiTe7RDzg7ABphyaI1a8hcC2IrQDDVtrqBLAhKr3mF0pKCkrEbDEwI46xa7lW866P8zs5qaQKPeOF8x07w8EbIGU5fRLFn8dpl/PfbhSVM1SjijWXz23MWKcc/5BSzYSbbzRoGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637805; c=relaxed/simple;
	bh=Dbyw7U5sqrgbYNScLc4DjI9NTlFG+sAGSpwI5sWsaSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7nkoMpcQFjaohdaejzuneuICr93mJHT6ePIpXkD8+CweeHeC80hC5l80GNQ+n3vrIi6O+0eWHVhNdmFVyYq7VoW19GVqVpINKc5Daz491KaPiFYXtub+8QcRiF6RaEIqu1ASlXgemv5vudJgtkGL6PuQLZbWVTiPd/q3M8HN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaNJUPm0; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e387ad888baso929088276.2;
        Tue, 26 Nov 2024 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732637803; x=1733242603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVXUwfpRCmIBduUQWVjFg3vyB+Y4BDopksHA87CHiQA=;
        b=NaNJUPm02wPrAWEqIXaetzB8ea9Pnv06FA4vNILCXPQjYqVss/D0bB+az4tJJd1NfL
         6RoFooLpQOcW/2DXoxU0x5YUz/H4NZDa+K5xq6MdQYh+0b+j+LZEVjUIJ+qTP3Do+T38
         xH9Q6qwH0YvA1mki9pZlLaBCS+/anZJDMKq9KPEHuvlhRnn0ZAXtk9w8b56qClktyhch
         MW5eBgM9c+xoM4mPE+UHJgEEldKRpOm9k0D6U85y8LPqnOAK+jIottfAkS5n/aRLe6KI
         nta3s1eUe/Z9egPX3Zli+Yv321AKRDLqIZxCQDLObNcpPbTjiN0J//WohqyLzvc8IOqp
         tDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732637803; x=1733242603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVXUwfpRCmIBduUQWVjFg3vyB+Y4BDopksHA87CHiQA=;
        b=nju0/6b1CjxtKUwZ39zPM8JILU20v9GA+IROpQenyuKikCesrzUGxYeZ0dL34y9IRe
         TzRLasCzp5jk3hUu0AsyPqtw25lEH7NPK5uLNdZX0Y4HeXkizU1SWq7nYQfvqd4d0Q6W
         IWRSEOH3P2pSNexG+yDCLmOchx9iq3QldVQ+yxD+sDnenke1V4bekdgp1mC91A5SNw6b
         hJJYxLnZ5FCKy7/KEypC313/Ks1J/F+xJOpTJKwuN/TuHh0szk74YuojC5rdNEmhYako
         Q5eZBCX3rCZEN903XOjMfoxhd1/qcbHkszPz6/Qism8ZciPAHY/Jjd32KdD3Fe93PUBv
         ZElw==
X-Forwarded-Encrypted: i=1; AJvYcCVN5YeoqZWmwyjK195w8nBMzRI0qaL61kweQK6CEUtmdXjZJ3v0l0SXz7JRnhlSSHuIPlW4/n4aDx0=@vger.kernel.org, AJvYcCX8Jqajs+5z9aihMFzdMawJjsY6S18Ia9QSXOYsngWvypU/xeTYQeprpTxhzhpxJhP6+z1F2iiQ2uPYPh7W@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdu/a+sZmtBtk6ONVQhRRE0Ld3b/QVO1J1hPqwns6qXQSB7ZmY
	5LJvoewMte29SqYDR8a0fkzeK4Lu+/SNKU79JxlyCytydenx3yZl6oSxFtv+9ky6lQZVuu/cFdb
	iHJOvW2gWyWE3gCfw+ICfb3ZFmX0=
X-Gm-Gg: ASbGnctMeGi62Zh2R3qcDrGxgKUIoZYLh96mXPsv/x3A6dgFE4p5lQtzgbxMhfZ1N2h
	BIlzoClm8UgF+pRX91n2rEzGggUuj4XE=
X-Google-Smtp-Source: AGHT+IEtg5/CqQiGFcs/5tqwlgT8SGILbVeougiak7zpXf8sV76zeqsR23e8stO1Uk3NDs24P0qRtrI2H+YJenPBXQw=
X-Received: by 2002:a05:690c:fc5:b0:6ee:eebc:2663 with SMTP id
 00721157ae682-6ef2282c6d9mr20068487b3.6.1732637803055; Tue, 26 Nov 2024
 08:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117182651.115056-1-l.rubusch@gmail.com> <20241117182651.115056-8-l.rubusch@gmail.com>
 <20241124181428.59b85176@jic23-huawei>
In-Reply-To: <20241124181428.59b85176@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 26 Nov 2024 17:16:07 +0100
Message-ID: <CAFXKEHbLg9COcKkv2AX-TfdW+-RO7CpJjMLQ3YJtcNbnXcs9xA@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] iio: accel: adxl345: initialize IRQ number
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 7:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 17 Nov 2024 18:26:36 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the possibility to claim an interrupt and init the state structure
> > with interrupt number and interrupt line to use. The adxl345 can use
> > two different interrupt lines, mainly to signal FIFO watermark events,
> > single or double tap, activity, etc. Hence, having the interrupt line
> > available is crucial to implement such features.
>
> If there are two interrupt lines, you need to be more clever.
> Imagine only one of them is wired. How do you know which one it is?
>
> The query needs to be done by name.  When there are multiple interrupts
> the ones found in spi and i2c structures could be anything, so don't use
> those.
>
> See fwnode_irq_get_by_name()

One of my bigger question marks is this here: The sensor has two
possible interrupt lines, INT1 or INT2, on which it will notify. But,
only one is connected. Hence, the irq passed e.g. by SPI will
automatically refer to the used one. Only this one is going to be
configured as irq. Or, am I getting this wrong? Alternatively, no
interrupt line is connected. This was the initial driver setup. In
this case, it's generally BYPASS-mode for the FIFO and any further
feature is not possible due to a lack of notification.

My questions now arise, when it comes to configure the IRQ line in the
sensor registers. The sensor needs to be configured, that the used
interrupt line for notifiction is INT1 or INT2. In the later patch of
this series - "set interrupt line to INT1" - I init it with "INT1".
But, this actually then can be configured. I can think of yet another
/sysfs handle (could be dynamically changed at runtime, I'm not sure
if this makes sense); by an additional devicetree binding (currently
my preferred idea, I'd default to INT1, but let it configure to INT1
or INT2 - or better default to bypass mode?), or is there an IIO way
of configuring it to INT1/2, or a better way? I rather tend to DT. But
this is still not part of this patch set.

Do I miss a point here and should still apply the
fwnode_irq_get_by_name()? This looks a bit like the DT approach, isn't
it?

Lothar

> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h      | 1 +
> >  drivers/iio/accel/adxl345_core.c | 6 ++++++
> >  drivers/iio/accel/adxl345_i2c.c  | 2 +-
> >  drivers/iio/accel/adxl345_spi.c  | 8 ++++++--
> >  4 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 3d5c8719db..cf4132715c 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -62,6 +62,7 @@ struct adxl345_chip_info {
> >  };
> >
> >  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > +                    int irq,
> >                      int (*setup)(struct device*, struct regmap*));
> >
> >  #endif /* _ADXL345_H_ */
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 81688a9eaf..902bd3568b 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/units.h>
> > +#include <linux/interrupt.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -18,6 +19,7 @@
> >  #include "adxl345.h"
> >
> >  struct adxl34x_state {
> > +     int irq;
> >       const struct adxl345_chip_info *info;
> >       struct regmap *regmap;
> >  };
> > @@ -196,12 +198,14 @@ static const struct iio_info adxl345_info =3D {
> >   *                        also covers the adxl375 and adxl346 accelero=
meter
> >   * @dev:     Driver model representation of the device
> >   * @regmap:  Regmap instance for the device
> > + * @irq:     Interrupt handling for async usage
>
> This is an integer, not a handling.   See if you can come up with clearer=
 comment.
>
> >   * @setup:   Setup routine to be executed right before the standard de=
vice
> >   *           setup
> >   *
> >   * Return: 0 on success, negative errno on error
> >   */
> >  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > +                    int irq,
> >                      int (*setup)(struct device*, struct regmap*))
> >  {
> >       struct adxl34x_state *st;
> > @@ -224,6 +228,8 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >
> >       st =3D iio_priv(indio_dev);
> >       st->regmap =3D regmap;
> > +
> > +     st->irq =3D irq;
> >       st->info =3D device_get_match_data(dev);
> >       if (!st->info)
> >               return -ENODEV;
> > diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl34=
5_i2c.c
> > index 4065b8f7c8..604b706c29 100644
> > --- a/drivers/iio/accel/adxl345_i2c.c
> > +++ b/drivers/iio/accel/adxl345_i2c.c
> > @@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *clien=
t)
> >       if (IS_ERR(regmap))
> >               return dev_err_probe(&client->dev, PTR_ERR(regmap), "Erro=
r initializing regmap\n");
> >
> > -     return adxl345_core_probe(&client->dev, regmap, NULL);
> > +     return adxl345_core_probe(&client->dev, regmap, client->irq, NULL=
);
> >  }
> >
> >  static const struct adxl345_chip_info adxl345_i2c_info =3D {
> > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl34=
5_spi.c
> > index 61fd9a6f5f..39e7d71e1d 100644
> > --- a/drivers/iio/accel/adxl345_spi.c
> > +++ b/drivers/iio/accel/adxl345_spi.c
> > @@ -39,9 +39,13 @@ static int adxl345_spi_probe(struct spi_device *spi)
> >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error i=
nitializing regmap\n");
> >
> >       if (spi->mode & SPI_3WIRE)
> > -             return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_=
setup);
> > +             return adxl345_core_probe(&spi->dev, regmap,
> > +                                       spi->irq,
> > +                                       adxl345_spi_setup);
> Very early wrap. I think spi->irq fits on the line above.
>
> >       else
> > -             return adxl345_core_probe(&spi->dev, regmap, NULL);
> > +             return adxl345_core_probe(&spi->dev, regmap,
> > +                                       spi->irq,
> > +                                       NULL);
> >  }
> >
> >  static const struct adxl345_chip_info adxl345_spi_info =3D {
>

