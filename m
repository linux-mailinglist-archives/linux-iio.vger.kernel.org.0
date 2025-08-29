Return-Path: <linux-iio+bounces-23381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF13B3BFAE
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF9A5A053D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBA321F52;
	Fri, 29 Aug 2025 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbJil1Gn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210FB1E51EA;
	Fri, 29 Aug 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482233; cv=none; b=covbQRUbHTaU3khsJXZ9eSofEPx1oPmv6Ntx+QoobfVWWJ28z/oVgztY1CA4CiN/EMtu+DsU7l6qC+KLru959E8cv6k0rQpGESjQb0UGXSuJ6FlNirIH+A1LbovEo4LFzCFwLyi0B+008b0UeDIcCp8ifvRlAgqNwKKE0oapjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482233; c=relaxed/simple;
	bh=QDQ6MyJKIFEzAKsF/RFwuy5QFqU7b1tuLbWLgamL1kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx9wtXOVQTr4hq2rvYikDGcm82Frnj60XHBIbKkuhHzYUo45gXoJm3uCRm+xE+oVZrbGu3y+Plw+F/Iu/q9YjNlGxdAUKkaUMO06+vmXlI1e2FdNooS35pFtkFP41Poargk9sBmx00y85xh7F2ckSJ03W/7+nWxJCxFFLrqa1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbJil1Gn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afec56519c4so294310466b.0;
        Fri, 29 Aug 2025 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756482229; x=1757087029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtZZzYiY2ZB8tqDqc+TvXbztBkobqhV9f4pJDnFdc70=;
        b=WbJil1Gnf2UU9cF4wOrxebsynPxR9DGRCVC+LA1FiAXNOMu/lQKfxJ4Nd8v/ajLP0b
         wBbbmt5JJZHhKOcj5v9z2wTckA45qrKm8JT1G+389m+pxFue+xOWxKabERU6Pm8J2V2G
         UDnf++CUbcpBG9kzQmRo4OKQ8pwUDJq+ocg/KKCpUYiJ6HAgSVY2rpiq0aSLh3JHibT5
         hax/4iNJLjTmC5DqXX9H4tgY1amldcI3xR+OU3jp5wWy+TQvdhprhUKal4zR1BgKEZCs
         lnBlEvf9Cmb3aWQv7QFLsK+n7Idatno+X5ARkQbo/EX3kyLxV7vHHgJ15i+IhKWK0aEp
         olLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482229; x=1757087029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtZZzYiY2ZB8tqDqc+TvXbztBkobqhV9f4pJDnFdc70=;
        b=Kh4vM6ChPz+3IgUjBXlT4Qwid9oiY5o9U7bUZrm56BHqNfrb4kLsmHgPT7Dw+0/YBf
         w81xP3Zmil5YGr73OB2VqH2Tg2bbFgYHauG+2za6a7jLSJM/22VayaFjj1tLIFC2u6iJ
         eEfG5xhoc/qnjbVgUGS+deb2kmgFY4EJD0zKcPzt2ZNu2wb5JyLAKCKW0+4vYc1bZwUL
         DWv0ZueMVcx90+7mo+FANsVDqfSzYarq1vjVOQP92VLV03kbgrkzOjV6BTKA6VlaeJns
         SiDwY3kSey0BiN2D1LiXTyAQ7pKbTOefFO6pG9arjCaiiZUAo89gO1v/JcZ/VpdU0jyN
         BjEg==
X-Forwarded-Encrypted: i=1; AJvYcCVAXYPD73GsaSQNVCHxhUIJvItAO/jkg6VdBmyI4Xw8/6q4+g45QnHVXumByYalRAXCkGGQ+mg+AWY3@vger.kernel.org, AJvYcCWUchliT368cUcdWPojFIYOTHGCwgw+ZnUkJeDY5w9AFjs013xDFDm83kibqseq2PVQCyTE8w8+mCha@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7+jgaIVJtnkfZBYUAkV3uk9IX5dnbMo4OcV8yuDTj0PKgsEp
	jlOYh0v2cPxuj+OW4WO0QSacAlbp29E3FMDlmpgCx4oWfUW69e6W9Fu9nVNvaORYrg8U6TXsCjE
	MJ1x9lENpK9AY0tpIpzBe1L/pmu3FfFs=
X-Gm-Gg: ASbGncsZ2d038M4js8rcpQvWEUSsFawBuR1iK/4ctuWWaVYfchimruaU6XfRN/Ac9Oe
	jRAH13n0HCYcW6EpCFgVKSNXw9YjRzhgJKqU9wuDUqZRLfWVa5fcx3xMHl9LODXbx5sOy2i+bZl
	ELHsN1JIa4e/kJBYd5FLe4TysmjMBsKOqTnXrdb9s3KfA13TgX++Al2RlGAc/VQNE3H3bQs4UFw
	AosWX0=
X-Google-Smtp-Source: AGHT+IEnrSVC7ozz8SHImJbovQmVktvO4J46R1dBWJiwyWh57BsLNa4BhRIx6P0RD/YME2d/I6pRI9MlTEMRcg/oLr8=
X-Received: by 2002:a17:907:7289:b0:afe:8af3:2ac2 with SMTP id
 a640c23a62f3a-afe8af332e8mr1596014166b.39.1756482229068; Fri, 29 Aug 2025
 08:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com> <20250827103105.2472328-2-lakshay.piplani@nxp.com>
In-Reply-To: <20250827103105.2472328-2-lakshay.piplani@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 18:43:12 +0300
X-Gm-Features: Ac12FXxwwCuzYIAyK9azvW_Zum4trtiwxIwW02Xptcq82sOJEDvbBX4h-EUVQpI
Message-ID: <CAHp75VdmJMM22DY=WGZpZ82uvXuER_dEnQL8XPx4fFCXvh17TQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
	jonathan.cameron@huawei.com, akpm@linux-foundation.org, chao@kernel.org, 
	jaegeuk@kernel.org, vikash.bansal@nxp.com, priyanka.jain@nxp.com, 
	shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 1:31=E2=80=AFPM Lakshay Piplani <lakshay.piplani@nx=
p.com> wrote:
>
> Add support for the NXP P3T175x (P3T1750/P3T1755) family of temperature
> sensor devices. These devices communicates via both I2C or I3C interfaces=
.
>
> This driver belongs under IIO because:
>   The P3T1750/P3T1755 sensors require interrupt or IBI support to handle
>   threshold events, which the hwmon subsystem does not provide. In contra=
st,
>   the IIO subsystem offers robust event handling that matches the hardwar=
e
>   capabilities of these sensors. Therefore, this driver is better suited
>   under IIO.

...

> +Date:          August 2025
> +KernelVersion: 6.17
> +Contact:       Lakshay Piplani <lakshay.piplani@nxp.com>



...

>           This driver can also be built as a module. If so, the module
>           will be called mcp9600.

Missed blank line here.

> +source "drivers/iio/temperature/p3t/Kconfig"
>
>  endmenu

...

> +config IIO_P3T1755_I2C
> +       tristate "NXP P3T1755 temprature sensor I2C driver"

temperature

> +       select IIO_P3T1755
> +       select REGMAP_I2C
> +       help
> +         Say yes here to build support for NXP P3T1755 I2C temperature
> +         sensor.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called p3t1755_i2c
> +
> +config IIO_P3T1755_I3C
> +       tristate "NXP P3T1755 temprature sensor I3C driver"

Ditto.

> +       select IIO_P3T1755
> +       select REGMAP_I3C
> +       depends on I3C
> +       help
> +         Say yes here to build support for NXP P3T1755 I3C temperature
> +         sensor.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called p3t1755_i3c

...

> +#ifndef P3T1755_H
> +#define P3T1755_H
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>

This is definitely an incorrect list of the inclusions. Follow the
IWYU principle (include what you use).

...

> +#define P3T1755_SHUTDOWN_BIT           BIT(0)
> +#define P3T1755_TM_BIT                 BIT(1)
> +#define P3T1755_POL_BIT                        BIT(2)
> +#define P3T1755_ONE_SHOT_BIT           BIT(7)

+bits.h

...

> +extern const struct p3t1755_info p3t1755_channels_info;
> +extern const struct p3t1755_info p3t1750_channels_info;

Please, move this after the actual structure type definition.

...

> +enum p3t1755_hw_id {
> +       P3T1755_ID =3D 0,
> +       P3T1750_ID,
> +};

Is this related to HW (like values that are read from HW? If so, make
them all to be explicitly assigned. Otherwise, drop the assignment and
sort the list.

...

> +struct p3t1755_data {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct mutex lock; /* Protects access to sensor registers */

+ mutex.h

> +       bool tm_mode;

+ types.h

> +};

> +#endif /* P3T1755_H */

The rest can be declared with forward declarations.

...

> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
> +#include <linux/device.h>
> +#include <linux/iio/events.h>

Please, keep it ordered, also move iio/* to a separate group

linux/*
...blank line...
linux/iio/*

...

> +static const struct {
> +       u8 bits;
> +       unsigned int freq_hz;
> +} p3t1755_samp_freqs[] =3D {
> +       { 0x00, 36 },
> +       { 0x01, 18 },
> +       { 0x02, 9 },
> +       { 0x03, 4 },

Is it 4 for real? To me it sounds like it should be 4.5. Also, the
bits field is redundant. Index is the same.

> +};

...

> +int p3t1755_fault_queue_to_bits(int val)
> +{
> +       int i;

Here and elsewhere why is 'i' signed?

> +       for (i =3D 0; i < ARRAY_SIZE(p3t1755_fault_queue_values); i++)
> +               if (p3t1755_fault_queue_values[i] =3D=3D val)
> +                       return i;
> +       return -EINVAL;
> +}

...

> +static int p3t1755_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *channel, int *val=
,
> +                           int *val2, long mask)
> +{
> +       struct p3t1755_data *data =3D iio_priv(indio_dev);
> +       unsigned int cfgr;
> +       __be16 be;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, =
&be, sizeof(be));

> +               if (ret < 0) {

Here and elsewhere out of a sudden the ' < 0' part. Please, remove it
where it's not needed.

> +                       dev_err(data->dev, "Failed to read temperature re=
gister\n");
> +                       return ret;
> +               }
> +               *val =3D sign_extend32(be16_to_cpu(be) >> 4, 11);
> +
> +               return IIO_VAL_INT;
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D 625;
> +               *val2 =3D 10000;
> +
> +               return IIO_VAL_FRACTIONAL;
> +
> +       case IIO_CHAN_INFO_ENABLE:
> +               ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr=
);
> +               if (ret < 0) {
> +                       dev_err(data->dev, "Failed to read configuration =
register\n");
> +                       return ret;
> +               }
> +               *val =3D !FIELD_GET(P3T1755_SHUTDOWN_BIT, cfgr);
> +
> +               return IIO_VAL_INT;
> +
> +       case IIO_CHAN_INFO_SAMP_FREQ:

> +               u8 sel;

Here and elsewhere, we usually don't allow mix definitions with the
code, only in exceptional cases (RAII, loop iterators). To fix this,
the whole case block should go in curly braces {}.

> +               ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr=
);
> +               if (ret < 0) {
> +                       dev_err(data->dev, "Failed to read configuration =
register\n");
> +                       return ret;
> +               }
> +
> +               sel =3D FIELD_GET(P3T1755_CONVERSION_TIME_BITS, cfgr);
> +               if (sel >=3D ARRAY_SIZE(p3t1755_samp_freqs))
> +                       return -EINVAL;
> +
> +               *val =3D p3t1755_samp_freqs[sel].freq_hz;
> +
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static int p3t1755_write_event_value(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir,
> +                                    enum iio_event_info info, int val,
> +                                    int val2)
> +{
> +       struct p3t1755_data *data =3D iio_priv(indio_dev);
> +       unsigned int reg;
> +       __be16 be;
> +
> +       if (type !=3D IIO_EV_TYPE_THRESH || info !=3D IIO_EV_INFO_VALUE)
> +               return -EINVAL;
> +
> +       reg =3D (dir =3D=3D IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +                                          P3T1755_REG_LOW_LIM;

> +       if (val < -2048 || val > 2047)
> +               return -ERANGE;

Logically in_range() here is better and since it's s11 type, I would
comment on this like "compare that the value is in a range of the
11-bit signed type".

> +       be =3D cpu_to_be16((u16)((val & 0xfff) << 4));

Why casting? Why not GENMASK()?

> +       return regmap_bulk_write(data->regmap, reg, &be, sizeof(be));
> +}
> +
> +static int p3t1755_trigger_one_shot(struct p3t1755_data *data)
> +{
> +       unsigned int config;
> +       int ret;
> +
> +       mutex_lock(&data->lock);

Use guard()() from cleanup.h

> +       ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, &config);
> +       if (ret)
> +               goto out;
> +
> +       if (!(config & P3T1755_SHUTDOWN_BIT)) {
> +               ret =3D -EBUSY;
> +               goto out;
> +       }
> +
> +       config |=3D P3T1755_ONE_SHOT_BIT;
> +       ret =3D regmap_write(data->regmap, P3T1755_REG_CFGR, config);
> +
> +out:
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}

...

> +       switch (iattr->address) {
> +       case P3T1755_ATTR_TRIGGER_ONE_SHOT:
> +               ret =3D kstrtobool(buf, &enable);
> +               if (ret || !enable)
> +                       return ret ? ret : -EINVAL;

Split to two conditionals of the same level

 if (ret)
  return ret;
if (...)
  return -E...

> +               ret =3D p3t1755_trigger_one_shot(data);
> +               return ret ?: count;

Ditto.

> +       default:
> +               return -EINVAL;
> +               }
> +       }

...

> +static IIO_DEVICE_ATTR(trigger_one_shot, 0200, NULL, p3t1755_attr_store,
> +                      P3T1755_ATTR_TRIGGER_ONE_SHOT);

IIO_DEVICE_ATTR_WO()

...

> +static const struct iio_event_spec p3t1755_events[] =3D {
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_RISING,
> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE)

Leave trailing comma.

> +       },
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_FALLING,
> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE)

Ditto.

> +       },
> +};

...

> +const struct p3t1755_info p3t1755_channels_info =3D {
> +       .name =3D "p3t1755",
> +       .channels =3D p3t1755_channels,
> +       .num_channels =3D ARRAY_SIZE(p3t1755_channels)

Ditto.

> +};

...

> +static struct attribute *p3t1755_attributes[] =3D {
> +       &iio_dev_attr_trigger_one_shot.dev_attr.attr,

> +       NULL,

Remove trailing comma for the terminator entry.

> +};

...

> +int p3t1755_probe(struct device *dev, const struct p3t1755_info *chip,
> +                 struct regmap *regmap, bool tm_mode, int fq_bits, int i=
rq)
> +{
> +       struct p3t1755_data *data;
> +       struct iio_dev *iio_dev;
> +       unsigned long irq_flags;
> +       int ret;
> +
> +       iio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +       if (!iio_dev)
> +               return -ENOMEM;
> +
> +       data =3D iio_priv(iio_dev);
> +       data->dev =3D dev;
> +       data->regmap =3D regmap;
> +       data->tm_mode =3D tm_mode;

> +       mutex_init(&data->lock);

devm_mutex_init()

> +       iio_dev->name =3D chip->name;
> +       iio_dev->modes =3D INDIO_DIRECT_MODE;
> +       iio_dev->info =3D &p3t1755_info;
> +       iio_dev->channels =3D chip->channels;
> +       iio_dev->num_channels =3D chip->num_channels;
> +
> +       dev_set_drvdata(dev, iio_dev);
> +
> +       ret =3D regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +                                P3T1755_TM_BIT,
> +                               (tm_mode ? P3T1755_TM_BIT : 0));

Too many parentheses.

> +       if (ret)
> +               return dev_err_probe(data->dev, ret, "Failed to update TM=
 bit\n");
> +
> +       if (fq_bits >=3D 0)
> +               regmap_update_bits(data->regmap, P3T1755_REG_CFGR, P3T175=
5_FAULT_QUEUE_MASK,
> +                                  fq_bits << P3T1755_FAULT_QUEUE_SHIFT);
> +
> +       ret =3D devm_iio_device_register(dev, iio_dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Temperature sensor failed=
 to register\n");
> +
> +       if (irq > 0) {
> +               iio_dev =3D dev_get_drvdata(dev);
> +               data =3D iio_priv(iio_dev);

> +               if (tm_mode)
> +                       irq_flags =3D IRQF_TRIGGER_FALLING;
> +               else
> +                       irq_flags =3D (IRQF_TRIGGER_RISING | IRQF_TRIGGER=
_FALLING);

As David said, we use firmware description for these.

> +               ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +                                               p3t1755_irq_handler, irq_=
flags | IRQF_ONESHOT,
> +                                               "p3t175x", iio_dev);
> +               if (ret)
> +                       dev_err_probe(dev, ret, "Failed to request IRQ: %=
d\n", ret);
> +       }
> +
> +       return 0;
> +}

...

> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>

Follow IWYU, please.

...

> +static int p3t1755_i2c_probe(struct i2c_client *client)
> +{
> +       const struct p3t1755_info *chip;
> +       struct regmap *regmap;
> +       bool tm_mode =3D false;
> +       int fq_bits =3D -1;
> +       int ret;
> +       u32 fq;
> +
> +       regmap =3D devm_regmap_init_i2c(client, &p3t1755_i2c_regmap_confi=
g);
> +       if (IS_ERR(regmap)) {
> +               return dev_err_probe(&client->dev, PTR_ERR(regmap),

With

  struct device *dev =3D &client->dev;

this and other code statements become neater.

> +                                    "regmap init failed\n");
> +       }
> +
> +       tm_mode =3D device_property_read_bool(&client->dev, "nxp,interrup=
t-mode");
> +
> +       if (!device_property_read_u32(&client->dev, "nxp,fault-queue", &f=
q)) {
> +               fq_bits =3D p3t1755_fault_queue_to_bits(fq);

> +               if (fq_bits < 0) {
> +                       return dev_err_probe(&client->dev, fq_bits,
> +                                                    "invalid nxp,fault-q=
ueue %u (1/2/4/6)\n", fq);
> +                       }

Why {} ?

> +       }
> +
> +       dev_dbg(&client->dev, "Using TM mode: %s\n",
> +               tm_mode ? "Interrupt" : "Comparator");
> +
> +       chip =3D i2c_get_match_data(client);
> +
> +       dev_dbg(&client->dev, "Registering p3t175x temperature sensor");
> +
> +       ret =3D p3t1755_probe(&client->dev, chip, regmap,
> +                           tm_mode, fq_bits, client->irq);
> +
> +       if (ret) {
> +               dev_err_probe(&client->dev, ret, "p3t175x probe failed: %=
d\n", ret);
> +               return ret;

Again, it looks like drivers are written by two or more people. Use
consistent style everywhere.

  return dev_err_probe(...);

> +       }
> +
> +       return 0;
> +}

...

> +++ b/drivers/iio/temperature/p3t/p3t1755_i3c.c

> +/*
> + * Both P3T1755 and P3T1750 share the same I3C PID (0x011B:0x152A),
> + * making runtime differentiation impossible, so using "p3t1755" as
> + * name in sysfs and IIO for I3C based instances.
> + */
> +static const struct i3c_device_id p3t1755_i3c_ids[] =3D {
> +       I3C_DEVICE(0x011B, 0x152A, &p3t1755_channels_info),
> +       { },

No comma for the terminator line.

> +};

> +

Redundant blank line.

> +MODULE_DEVICE_TABLE(i3c, p3t1755_i3c_ids);

> +static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
> +{
> +       const struct regmap_config p3t1755_i3c_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       };

Why not in the same way as in i=C2=B2c driver?

> +       const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev, p3=
t1755_i3c_ids);
> +       const struct p3t1755_info *chip;
> +       struct device *dev =3D &i3cdev->dev;
> +       struct i3c_ibi_setup ibi_setup;
> +       struct regmap *regmap;
> +       bool tm_mode =3D false;
> +       int fq_bits =3D -1;
> +       int ret;
> +       u32 fq;

> +       chip =3D id ? id->data : NULL;

Can i3c code gain or may already have the analogue of
device_get_match_data() as i=C2=B2c has?


> +       regmap =3D devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_confi=
g);
> +       if (IS_ERR(regmap)) {
> +               return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +                                    "Failed to register I3C regmap %ld\n=
", PTR_ERR(regmap));
> +       }
> +
> +       tm_mode =3D device_property_read_bool(dev, "nxp,interrupt-mode");

> +       if (!device_property_read_u32(dev, "nxp,fault-queue", &fq)) {
> +               fq_bits =3D p3t1755_fault_queue_to_bits(fq);
> +               if (fq_bits < 0) {
> +                       return dev_err_probe(&i3cdev->dev, fq_bits,
> +                                            "invalid nxp,fault-queue %u =
(1/2/4/6)\n", fq);
> +               }
> +       }

Isn't it the same as in i=C2=B2c? Make it part of the core probe instead.

> +       dev_dbg(&i3cdev->dev, "Using TM mode: %s\n", tm_mode ? "Interrupt=
" : "Comparator");

Ditto. Also why is this message detached from the above
device_property_read_bool()?

> +       ret =3D p3t1755_probe(dev, chip, regmap, tm_mode, fq_bits, 0);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "p3t175x probe failed: %d\=
n", ret);
> +
> +       if (!tm_mode) {
> +               dev_warn(&i3cdev->dev, "IBI not supported in comparator m=
ode, skipping IBI registration\n");
> +               return 0;
> +       }
> +
> +       ibi_setup =3D (struct i3c_ibi_setup) {
> +               .handler =3D p3t1755_ibi_handler,
> +               .num_slots =3D 4,
> +               .max_payload_len =3D 0,
> +       };
> +
> +       ret =3D i3c_device_request_ibi(i3cdev, &ibi_setup);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to request IBI\n")=
;
> +
> +       ret =3D i3c_device_enable_ibi(i3cdev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable IBI\n");
> +
> +       ret =3D devm_add_action_or_reset(dev, p3t1755_disable_ibi, i3cdev=
);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register IBI di=
sable action\n");
> +
> +       ret =3D devm_add_action_or_reset(dev, p3t1755_free_ibi, i3cdev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register IBI fr=
ee action\n");

> +       dev_dbg(&i3cdev->dev, "IBI successfully registered\n");

Noise, remove.

> +       return 0;
> +}


--
With Best Regards,
Andy Shevchenko

