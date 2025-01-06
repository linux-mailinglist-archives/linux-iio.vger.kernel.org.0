Return-Path: <linux-iio+bounces-13931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FAEA021E5
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 10:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0451F3A41FD
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C31D89FD;
	Mon,  6 Jan 2025 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw6AWsiN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF370A932;
	Mon,  6 Jan 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155951; cv=none; b=XQqm5BZZpTn3Yh2ufAWiqnUrGSNwskgFoNfIGzQjboQMOAiufC6JFXRrLa2LfpHdRyuJBAda/0U8N6x7aSnFb9u4wx4YOTiyC6iWry48YsxL1CfcHVdZTYZrB2JWxNpVjrgdNs6ch/Z+4U7eNBefFYYmS0UJO+QdhtgTJxpkZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155951; c=relaxed/simple;
	bh=UUwac4nbsybsXpAaeTY4ColDHidUWA+D7BTu2w+ltaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ck7D+N3S/5o+HS2KnT1M1jQfsLWY0JtjwS95LoiTsOGHTC6lZbufJF6CUZxW6jmUDVeQvhg0z6PfBWXwKKI0t2QG5KhgPF+11x7EGbuEwjT1PNyOlugPxmwmgkCjnTecp0556nmlAouq7XsT0sNWn9Otl5XMMzFkhbYYSMJBUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw6AWsiN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1383553066b.3;
        Mon, 06 Jan 2025 01:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736155948; x=1736760748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkorgIae98MH0Wo98cczURHUjhN8UFbBKY6DYTGXSzI=;
        b=lw6AWsiN6QwXkpAHgAKDQ7VOa7d/c7GuIk6Vj+7/6dGaieZ6loVU52Uuws8hGPwknO
         zcLdyUhZSz+6XDvuVq6lrdlC3CqvEvi9jvhzMMENlWZY0fp6Gsftpk3mhHtkMku1SBWX
         SEoZUDvdx6sWbKT8SdMNcZVVgz2ziKdmnrm8uX4RAMDkEjehyYSL0lR79Ex1xoFesqed
         sBn9jEpihkxyGKlbuLblO3LqR5BVLgVsV9Hf29R0rgEi+pqqyEbydlDB9lUXwpfmcPcD
         87+5JMIr5aje990wL8P05D5SW7PDda8j6dpHTi/MO9l4RD8JEwxKqWyG2BLCAuYUjuC1
         pVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155948; x=1736760748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkorgIae98MH0Wo98cczURHUjhN8UFbBKY6DYTGXSzI=;
        b=hbTe3KuqNRIoVtRiGYvahQQVdBLcKOSD1agy1a3cUEeWzdtvj5X6tBlaaEQk1AP6Ro
         sT7SQ2B1l95Cn6GbgW/tljMRYPOMGPvB4p0iH4vVKs6gAKWXJ6ihdB60aZOfn9n6B2E3
         k3+bkcDToVvEu/2WbH1p284FJjjqUhi1mDzOcGk0mlTyzukp2Fk1IZEWd0zOWx2jv+dC
         WW55GxVCD6mbJALHgv+kEl3rRqbqGhhJu8fhvZD8Bzi8R9e15PtD2hjzpXvW0Yp2mk5s
         B992vjQE+ThKjGOj0Dz4mrhWUDk18beTHpt+t5oJzRGSSJxfuJ7QxnVW2usELFas3+Pp
         91wg==
X-Forwarded-Encrypted: i=1; AJvYcCWJO35aJbBUwDJ7hX81jgAWPrJmQps7b7/3GczGpJJDDMrRbvc+8+1G50obsEDLWkQZ1Mzcs16Lay8/@vger.kernel.org, AJvYcCXUtWxCnLGKFh827KifZurqsw38W5FtqZyrYUmvTJZj6WZcI69VdRURhg5lzseuPWCEfDaA6K/d5WHAsm7B@vger.kernel.org, AJvYcCXw8kZ2hKXLBdBMfeeoQmd4cGiWi88u03co6htYSGpBX1znGEpHrn3ZRiVDXnS3/UCXaHQ4qgMPzldk@vger.kernel.org
X-Gm-Message-State: AOJu0YwkPAtOT6Oyn5p9nTK1MOnZhe03Y+LR/v/k3unrioeX+j0SQCqN
	pBVqXUZxTe8tYZxm4lwtcUojeSQzsvK4p6MQBY0bQUC3lTJIUZrWG0UD/bsf4oV+WNJLUF0+MOF
	/ClcL3/51R/ToQS+ddPQ7vw6G1LE=
X-Gm-Gg: ASbGncuxueJHYqSEauyHIcGr8jYa7eupuyrioxbgZQgqPNDG/uSQxUQKgkGsE9TC4nL
	nHDlDI9I2DyjTSn2XPWdNV0e4uX4m+7/EqHPU3Q==
X-Google-Smtp-Source: AGHT+IFKHaCFlgCTzsFEnXDYUxW3e5R2VJeWtbbfDQMA1+PaVK9c4I08Ptv3RDKI3dtiiFiL8wXNhGLb54xNaKTIhhQ=
X-Received: by 2002:a17:907:c27:b0:aaf:ab71:67b6 with SMTP id
 a640c23a62f3a-aafab716801mr960090566b.31.1736155947710; Mon, 06 Jan 2025
 01:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
 <20241226055313.2841977-3-j2anfernee@gmail.com> <20241228133531.5e98357e@jic23-huawei>
In-Reply-To: <20241228133531.5e98357e@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 6 Jan 2025 17:31:51 +0800
Message-ID: <CA+4VgcKK1Hfz08paYjDCV=YL-C4bsWCNCRdH1Q8=4=hjEuYC9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: add Nuvoton NCT7201 ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	andriy.shevchenko@linux.intel.com, mitrutzceclan@gmail.com, 
	tgamblin@baylibre.com, matteomartelli3@gmail.com, alisadariana@gmail.com, 
	gstols@baylibre.com, thomas.bonnefille@bootlin.com, herve.codina@bootlin.com, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan,

Thanks for your comments.

Some questions are replied in Andy's comments.

We use FIELD_GET and FIELD_PREP to handle bit shift operations.

About regmap_write case, we remove print an error message according to
David Lechner mentioned.
If check for errors are needed, we would recovery it.

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=889:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 26 Dec 2024 13:53:13 +0800
> Eason Yang <j2anfernee@gmail.com> wrote:
>
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> >
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up =
to
> > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins fo=
r
> > independent alarm signals, and the all threshold values could be set fo=
r
> > system protection without any timing delay. It also supports reset inpu=
t
> > RSTIN# to recover system from a fault condition.
> >
> > Currently, only single-edge mode conversion and threshold events suppor=
t.
> >
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> Hi Eason,
>
> Various minor comments in addition to what Andy has
> posted already.
>
> Jonathan
>
> > diff --git a/drivers/iio/adc/nct7201.c b/drivers/iio/adc/nct7201.c
> > new file mode 100644
> > index 000000000000..9ad4d2919461
> > --- /dev/null
> > +++ b/drivers/iio/adc/nct7201.c
> > @@ -0,0 +1,449 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for Nuvoton nct7201 and nct7202 power monitor chips.
> > + *
> > + * Copyright (c) 2024 Nuvoton Inc.
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +
> > +#define NCT7201_VIN_MAX                                      12      /=
* Counted from 1 */
> > +#define NCT7201_IN_SCALING                           4995
> > +#define NCT7201_IN_SCALING_FACTOR                    10000
> > +
> > +#define NCT7201_REG_INTERRUPT_STATUS_1                       0x0C
> > +#define NCT7201_REG_INTERRUPT_STATUS_2                       0x0D
> > +#define NCT7201_REG_VOLT_LOW_BYTE                    0x0F
> > +#define NCT7201_REG_CONFIGURATION                    0x10
> > +#define  NCT7201_BIT_CONFIGURATION_START             BIT(0)
> > +#define  NCT7201_BIT_CONFIGURATION_ALERT_MSK         BIT(1)
> > +#define  NCT7201_BIT_CONFIGURATION_CONV_RATE         BIT(2)
> > +#define  NCT7201_BIT_CONFIGURATION_RESET             BIT(7)
> > +
> > +#define NCT7201_REG_ADVANCED_CONFIGURATION           0x11
> > +#define  NCT7201_BIT_ADVANCED_CONF_MOD_ALERT         BIT(0)
> > +#define  NCT7201_BIT_ADVANCED_CONF_MOD_STS           BIT(1)
> > +#define  NCT7201_BIT_ADVANCED_CONF_FAULT_QUEUE               BIT(2)
> > +#define  NCT7201_BIT_ADVANCED_CONF_EN_DEEP_SHUTDOWN  BIT(4)
> > +#define  NCT7201_BIT_ADVANCED_CONF_EN_SMB_TIMEOUT    BIT(5)
> > +#define  NCT7201_BIT_ADVANCED_CONF_MOD_RSTIN         BIT(7)
> > +
> > +#define NCT7201_REG_CHANNEL_INPUT_MODE                       0x12
> > +#define NCT7201_REG_CHANNEL_ENABLE_1                 0x13
> > +#define  NCT7201_REG_CHANNEL_ENABLE_1_MASK           GENMASK(7, 0)
> > +#define NCT7201_REG_CHANNEL_ENABLE_2                 0x14
> > +#define  NCT7201_REG_CHANNEL_ENABLE_2_MASK           GENMASK(3, 0)
>
> As below. I'd treat these two registers as one larger register.
>
> > +static int nct7201_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int *val, int *val2, long mask)
> > +{
> > +     u16 volt;
> > +     unsigned int value;
> > +     int err;
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     guard(mutex)(&chip->access_lock);
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN(chan-=
>address), &value);
> > +             if (err < 0)
> > +                     return err;
> > +             volt =3D value;
> > +             *val =3D volt >> 3;
>
> As below, likely a FIELD_GET() is appropriate here.
>
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             /* From the datasheet, we have to multiply by 0.0004995 *=
/
> > +             *val =3D 0;
> > +             *val2 =3D 499500;
> > +             return IIO_VAL_INT_PLUS_NANO;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int nct7201_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info,
> > +                                 int *val, int *val2)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +     u16 volt;
> > +     unsigned int value;
> > +     int err;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info !=3D IIO_EV_INFO_VALUE)
> > +             return -EINVAL;
> > +
> > +     if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +             err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_L=
IMIT(chan->address), &value);
> > +             if (err < 0)
> > +                     return err;
> > +             volt =3D value;
> > +     } else {
> > +             err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_=
LIMIT(chan->address), &value);
> > +             if (err < 0)
> > +                     return err;
> > +             volt =3D value;
> > +     }
> > +
> > +     *val =3D volt >> 3;
> As Andy pointed out, likely a FIELD_GET() makes sense here.
>
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +     long v1, v2;
> > +
> > +     v1 =3D val >> 5;
> > +     v2 =3D FIELD_PREP(NCT7201_REG_VIN_LIMIT_LSB_MASK, val) << 3;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> I'd flip this to
>         if (info !=3D IIO_EV_INFO_VALUE)
>                 return -EOPNOTSUPP;
>
>         guard().
>
> > +             guard(mutex)(&chip->access_lock);
> > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LI=
MIT(chan->address), v1);
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LI=
MIT_LSB(chan->address), v2);
>
> Check for errors.
>
> > +             } else {
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_L=
IMIT(chan->address), v1);
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_L=
IMIT_LSB(chan->address), v2);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> > +
> > +static int nct7201_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   bool state)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +     unsigned int mask;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     mask =3D BIT(chan->address);
> > +
> > +     if (!state && (chip->vin_mask & mask))
> > +             chip->vin_mask &=3D ~mask;
> > +     else if (state && !(chip->vin_mask & mask))
> > +             chip->vin_mask |=3D mask;
> > +
> > +     guard(mutex)(&chip->access_lock);
> > +     regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> > +                  chip->vin_mask & NCT7201_REG_CHANNEL_ENABLE_1_MASK);
> > +     if (chip->num_vin_channels =3D=3D 12)
> > +             regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
> > +                          chip->vin_mask & NCT7201_REG_CHANNEL_ENABLE_=
2_MASK);
>
> This feels odd.  Don't you need to shift that vin_mask to get rid of chan=
nels
> that are enabled via ENABLE_1?
>

We need to right shift 8 bit chip->vin_mask and write into ENABLE_2.
> > +     if (chip->num_vin_channels =3D=3D 12)
> > +             regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
-                          chip->vin_mask & NCT7201_REG_CHANNEL_ENABLE_2_MA=
SK);
+                         FIELD_GET(GENMASK(15, 8), chip->vin_mask) &
NCT7201_REG_CHANNEL_ENABLE_2_MASK);

> > +
> > +     return 0;
> > +}
>
> > +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> > +{
> > +     u8 data[2];
> > +     unsigned int value;
> > +     int err;
> > +
> > +     regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> > +                  NCT7201_BIT_CONFIGURATION_RESET);
>
> Add a comment on why you don't check return value (or do check it if appr=
opriate).
>
> > +
> > +     /*
> > +      * After about 25 msecs, the device should be ready and then
> > +      * the Power Up bit will be set to 1. If not, wait for it.
> > +      */
> > +     mdelay(25);
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value=
);
> > +     if (err < 0)
> > +             return err;
> > +     if (!(value & NCT7201_BIT_PWR_UP))
> > +             return dev_err_probe(&chip->client->dev, -EIO, "failed to=
 power up after reset\n");
> > +
> > +     /* Enable Channel */
> > +     guard(mutex)(&chip->access_lock);
> > +     regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> > +                  NCT7201_REG_CHANNEL_ENABLE_1_MASK);
>
> Check return value.  This is over an I2C bus, not the most reliable of
> transports!
>
> Consider doing this differently and using a bulk write for the larger
> case.
>
>         if (chip->num_vin_channels <=3D 8)
>                 ret =3D regmap_write();
>         else
>                 ret =3D regmap_bulk_write();
>
> However as you read ENABLE_2 unconditionally below, can you instead just
> always use a bulk write here?
>

We can't use regmap_bulk_write() due to the chip's limit.
regmap_bulk_write(chip->regmap, ..., ..., 2) ,
the first byte is well written, but the second byte don't changed.


> > +     if (chip->num_vin_channels =3D=3D 12)
> > +             regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
> > +                          NCT7201_REG_CHANNEL_ENABLE_2_MASK);
> > +
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, &=
value);
> > +     if (err < 0)
> > +             return err;
> > +     data[0] =3D value;
> > +
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2, &=
value);
> > +     if (err < 0)
> > +             return err;
> > +     data[1] =3D value;
>
> Why does reading these back make sense?  Is there a reason the write
> above might not work if the I2C transfer is Acked?
>
> If this is part of discovery protocol for how many channels are there, th=
en
> add comments.
>

We remove read back enable registers, just assign data value after
regmap_write() successfully.
Like,
    err =3D regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
             NCT7201_REG_CHANNEL_ENABLE_1_MASK);
    if (err) {
        dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_1\n=
");
        return err;
    }
    data[0] =3D NCT7201_REG_CHANNEL_ENABLE_1_MASK;

> > +
> > +     value =3D get_unaligned_le16(data);
> > +     chip->vin_mask =3D value;
> > +
> > +     /* Start monitoring if needed */
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &val=
ue);
> > +     if (err < 0) {
> > +             dev_err_probe(&chip->client->dev, -EIO, "Failed to read R=
EG_CONFIGURATION\n");
> > +             return value;
>
> Why return value if an error occurred?
>                 retuen dev_err_probe();
>
> > +     }
> > +
> > +     value |=3D NCT7201_BIT_CONFIGURATION_START;
> > +     regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION, value);
>
> regmap_set_bits()
>

-     value |=3D NCT7201_BIT_CONFIGURATION_START;
-     regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION, value);
+     regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
NCT7201_BIT_CONFIGURATION_START);

> > +
> > +     return 0;
> > +}
> > +
> > +static const struct regmap_config nct7201_regmap8_config =3D {
> > +     .name =3D "vin-data-read-byte",
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D 0xff,
> > +};
> > +
> > +static const struct regmap_config nct7201_regmap16_config =3D {
> > +     .name =3D "vin-data-read-word",
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 16,
> > +     .max_register =3D 0xff,
> > +};
> > +
> > +static int nct7201_probe(struct i2c_client *client)
> > +{
> > +     const struct nct7201_adc_model_data *model_data;
> > +     struct nct7201_chip_info *chip;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     model_data =3D i2c_get_match_data(client);
> > +     if (!model_data)
> > +             return -EINVAL;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +     chip =3D iio_priv(indio_dev);
> > +
> > +     chip->regmap =3D devm_regmap_init_i2c(client, &nct7201_regmap8_co=
nfig);
> > +     if (IS_ERR(chip->regmap))
> > +             return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> > +                     "Failed to init regmap\n");
> > +
> > +     chip->regmap16 =3D devm_regmap_init_i2c(client, &nct7201_regmap16=
_config);
> > +     if (IS_ERR(chip->regmap16))
> > +             return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16=
),
> > +                     "Failed to init regmap16\n");
> > +
> > +     chip->num_vin_channels =3D model_data->num_vin_channels;
> > +
> > +     ret =3D devm_mutex_init(&client->dev, &chip->access_lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     chip->client =3D client;
> > +
> > +     ret =3D nct7201_init_chip(chip);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     indio_dev->name =3D model_data->model_name;
> > +     indio_dev->channels =3D model_data->channels;
> > +     indio_dev->num_channels =3D model_data->num_channels;
> > +     if (client->irq)
> > +             indio_dev->info =3D &nct7201_info;
> > +     else
> > +             indio_dev->info =3D &nct7201_info_no_irq;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> > +}

