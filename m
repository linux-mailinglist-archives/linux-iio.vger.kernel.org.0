Return-Path: <linux-iio+bounces-18146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C3A8A76B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465663B2546
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F523BF93;
	Tue, 15 Apr 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxQyu0TL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C323BCFA;
	Tue, 15 Apr 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743969; cv=none; b=s7QpW/8Vl9t8XhCQynX4cj+DWeocRxS/k4M9Jo0ThWpO1NTN01wu9J3pTzs/HVi7J+s9KPLEh7Y4JimuY5vMFpdUFXAKOOT/66B4IRG4+ZK3miJe8DfT64QsvVCbh7J66A1/f8yWlAHCTKICXGwlDjr3xFoD/hrfa0ODORO5RLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743969; c=relaxed/simple;
	bh=sIfmB072C5123j6+mKDJTl54rUZzETezRLzJsW8/BXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3UdhfATfaOIxW47D3OzNq7Kf3otIkwxfFvvndxEOQfToGCgFO/EB617GqtF7dtwsek4GPnX8bn7ZDOa420uymxmY3WvRt73dpDqiogcGyxY7QIXjyjzRvDOHl1pVCN2p2eIYv4B1d9lthmPM5dd6dimpySt3SpPg5RjTNkQY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxQyu0TL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so10391078a12.0;
        Tue, 15 Apr 2025 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744743966; x=1745348766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0KZTJThgYg1+MNCDs2xk85SBtEbNdZyLgg18iPamf8=;
        b=jxQyu0TL0st5RpPEsa1I35S0Y5hl5wFQWHR+pIbNhbmeLvyhy9ox8dwY6+mDQinZuX
         1HDN3WjRRnN5QUD1nNNfkHa/BpKeSc+X+XCOjESFTu0mcGEfRJAIDyN5JOmhjNKzPrZF
         na1yqwBo+u3uAX0i8iaITS/6O+P0BzvC1wJBHUuKvdPy+7jA5Eu6HiYk/Gc5rAeuGhA9
         09tuR5q6UwY/ecU6IPCselVP4RhebtbzIpk9Y3ryBH0xy7siLgFcRE6xy7FVS5BiK78Y
         foahb44kSK9OxbpEu3CYDaW8FC5vdsIABr/VGoCXSKkYn3vGAZibpabElmwHuqXK3owf
         9eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744743966; x=1745348766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0KZTJThgYg1+MNCDs2xk85SBtEbNdZyLgg18iPamf8=;
        b=d1I1V7y/mXmMQCG9UNk7kJ1s4cg57ssZyWchArqCkKDmuplklwzlpkh4PjzyysG4TE
         icIEDq09IPmVcGN3Z5WkiHUVI12t7bCGJ1iseYkaObnrIWDGZVd2eyqRR82JIm6Ua5kc
         qL9XUzddH7MdBxn6Mik2ku9AxdOq3Imj4IYhgryv0hOnpkc2OFENcHwd0XE9edSmzRno
         JDDWDRylOBgYsQL27oYiYL8LiA8G0/ZVGZJ3KvfW4Th/Mngv2rN2EQAjtDjdQuwzKVUv
         0pdCYpH7/8jUMYV1jDcVR3CoKI2AU1cP5x+RUgJShyXhqMs8RQlYN63ROH26iM5gc+RK
         l9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUtTNmDZEnwHjtOCFVpWOsG5us2CZ14Qa6o35z+Owm6Mag1NyDw9iaqdY5V/YGrArR/hAyQ1G8epblSkpH8@vger.kernel.org, AJvYcCV1V9WfQIYtXWQu6Xyzozm/qh9nO2YGljzGwFnkEIVSdgVrzYoQ2Ph3j6rk7luXvW4EFswJIxApcSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznIzOdqMElxhD22SgkvU3ki/TaQJemjgZ2e6ujy/5VJIgSCvwX
	X6kS7yxNAM75ERlMNa6knSiO2q3jEx+iD8Q7j9qOe5a0lf0k3j/nY/PXGcPU1Y402QbqrCDyRIL
	8LBUKOkHOnzBHKCHRVFxfyUCn2bU=
X-Gm-Gg: ASbGnct72pEe48O+E8x12pwoXPHWbS6jxVlYOk/PtW1q6vm51yY9+xL8mGin0KedCtD
	0yMTUsBqHIP/dNKeNkvrC7QZYAyQaRdlatWZ4UWP2HpOIKR2HPgjJZZ2sMfpEmAJSlhZbGAO5wS
	LXFrfP34FWHbCF7nbRvYGsxSazNG/qATdc
X-Google-Smtp-Source: AGHT+IGKniU4oKRv1UGrVx/vh2xs0P/nHU0RmWqbpWFkSY+GUpJmUiQXF+ZespHwTWUVDPCZI3h4xCUjhYXKM+SDADo=
X-Received: by 2002:a17:907:3f23:b0:ac1:ecb5:7207 with SMTP id
 a640c23a62f3a-acb3830eb19mr16753666b.29.1744743965459; Tue, 15 Apr 2025
 12:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415132623.14913-1-victor.duicu@microchip.com> <20250415132623.14913-3-victor.duicu@microchip.com>
In-Reply-To: <20250415132623.14913-3-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Apr 2025 22:05:29 +0300
X-Gm-Features: ATxdqUE6os5mjgADI06Hqdu1mqFsIWu8L19pfCkC0qNtNH8fKnGiwHxEGG9ja-Q
Message-ID: <CAHp75VdzVzNV1k8RqG6Rxsg06Oqu_p1o-4QFeT10xBjrFOEZHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: temperature: add support for MCP998X
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:27=E2=80=AFPM <victor.duicu@microchip.com> wrote:
>
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Monitor Family.

...

> +KernelVersion: 6.14

This boat is already sailing, it should be v6.16 at bare minimum.

> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               This attribute controls the number of samples for the
> +               running average window applied to External Channel 1.
> +               Using this method the temperature spikes are reduced.
> +               X is the IIO index of the device.

...

> +KernelVersion: 6.14

Ditto.

> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Reading returns a list with the possible number of sample=
s used
> +               in the running average window. The window can be composed=
 of 1,
> +               4 or 8 previous samples. X is the IIO index of the device=
.

...

> +/*
> + * IIO driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive Te=
mperature Monitor Family
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Victor Duicu <victor.duicu@microchip.com>
> + *
> + * Datasheet can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Produ=
ctDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf

> + *

Redundant blank line

> + */

...

> +#include <linux/bitfield.h>

+ bits.h
+ err.h
> +#include <linux/i2c.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/irq.h>
> +#include <linux/limits.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

Please, make sure you follow the IWYU principle.

...

> +#define MCP9982_INT_HIGH_BYTE_ADDR(index)      (2 * (index))
> +#define MCP9982_INT_LOW_BYTE_ADDR(index)       (2 * (index) + 1)

Why? Can't you use __be16 everywhere and bulk IO?

...

> +#define MCP9982_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)

Useless macro that makes code harder to read.

...

> +#define MCP9982_CHAN(index, si, __address) ({ \
> +       struct iio_chan_spec __chan =3D { \
> +               .type =3D IIO_TEMP, \
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_=
SAMP_FREQ), \
> +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
, \
> +               .channel =3D index, \
> +               .address =3D __address, \
> +               .scan_index =3D si, \
> +               .scan_type =3D { \
> +                       .sign =3D 'u', \
> +                       .realbits =3D 8, \
> +                       .storagebits =3D 8, \
> +                       .endianness =3D IIO_CPU \
> +               }, \
> +               .indexed =3D 1, \
> +       }; \
> +       __chan; \

Why in this form and not as a compound literal?

> +})

...

> +/*
> + * struct mcp9982_features - features of a mcp9982 instance
> + * @phys_channels:     number of physical channels supported by the chip
> + * @name:              chip's name
> + */
> +struct mcp9982_features {
> +       u8              phys_channels;
> +       const char      *name;

Have you run `pahole`? Has it found a room to improve?

> +};

...

> +/**
> + * struct mcp9992_priv - information about chip parameters
> + * @client:                    the i2c-client attached to the device
> + * @regmap:                    device register map
> + * @iio_info                   iio_info
> + * @iio_chan                   specifications of channels
> + * @num_channels               number of physical channels
> + * @lock                       synchronize access to driver's state memb=
ers
> + * @running_avg                        number of samples in the running =
average window
> + * @hysteresis                 value of temperature hysteresis
> + * @temp_range_code            coded value representing the set temperat=
ure range
> + * @labels                     labels of the channels
> + * @chip_name                  name of the chip present
> + * @beta_user_value            value given by the user for beta on chann=
el 1 and 2
> + * @apdd                       state of anti-parallel diode mode
> + * @recd12                     state of REC on channels 1 and 2
> + * @recd34                     state of REC on channels 3 and 4
> + * @ideality_user_value                values given by user to ideality =
factor for all channels
> + */

> +

Redundant blank line.

...

> +struct mcp9982_priv {
> +       struct i2c_client *client;

For what do you need a client? Wouldn't struct device *dev suffice?
And if so, can't it be retrieved from regmap when needed?

> +       struct regmap *regmap;
> +       struct iio_info iio_info;
> +
> +       struct iio_chan_spec *iio_chan;
> +       u8 num_channels;
> +
> +       /*
> +        * Synchronize access to private members, and ensure
> +        * atomicity of consecutive regmap operations.
> +        */
> +       struct mutex lock;
> +
> +       int running_avg;
> +       int hysteresis;
> +       int temp_range_code;
> +       char *labels[MCP9982_MAX_NUM_CHANNELS];
> +       char *chip_name;
> +       int beta_user_value[2];
> +       int apdd;
> +       int recd12;
> +       int recd34;
> +       int ideality_user_value[4];
> +};

...

> +static int mcp9982_read_raw(struct iio_dev *indio_dev, struct iio_chan_s=
pec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       int ret, val3, HIGH_BYTE, LOW_BYTE;

No way we name variables in the capital letters. And use __be16.

> +
> +       /* Write in ONESHOT register to take a new reading */
> +       ret =3D regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +       if (ret)
> +               return ret;
> +
> +       guard(mutex)(&priv->lock);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               HIGH_BYTE =3D MCP9982_INT_HIGH_BYTE_ADDR(chan->channel);
> +               LOW_BYTE =3D MCP9982_INT_LOW_BYTE_ADDR(chan->channel);
> +
> +               ret =3D regmap_read(priv->regmap, HIGH_BYTE, val);
> +               if (ret)
> +                       return ret;
> +
> +               if (priv->temp_range_code)
> +                       *val -=3D MCP9982_TEMP_OFFSET;
> +
> +               ret =3D regmap_read(priv->regmap, LOW_BYTE, val2);
> +               if (ret)
> +                       return ret;
> +
> +               *val2 =3D mcp9982_fractional_values[*val2 >> 5];
> +
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               ret =3D regmap_read(priv->regmap, MCP9982_CONV_ADDR, &val=
3);
> +               if (ret)
> +                       return ret;
> +
> +               *val =3D mcp9982_conv_rate[val3][0];
> +               *val2 =3D mcp9982_conv_rate[val3][1];
> +
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +       return sprintf(label, "%s\n", priv->labels[chan->channel]);

+ sprintf.h

...

> +static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_=
spec const *chan,
> +                            int val, int val2, long mask)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       struct device *dev =3D &priv->client->dev;
> +       int i;

Why signed?

> +       int status =3D 0;

Why not boolean?

> +       guard(mutex)(&priv->lock);
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               for (i =3D 0; i < ARRAY_SIZE(mcp9982_conv_rate); i++) {

+ array_size.h

> +                       if (val =3D=3D mcp9982_conv_rate[i][0] &&
> +                           val2 =3D=3D mcp9982_conv_rate[i][1]){
> +                               status =3D 1;
> +                               break;
> +                       }
> +               }
> +               if (!status)
> +                       return dev_err_probe(dev, -EINVAL, "Sampling Freq=
uency is invalid\n");
> +
> +               return regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static ssize_t mcp9982_running_average_window_show(struct device *dev,
> +                                                  struct device_attribut=
e *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%u sample(s)\n", priv->running_avg);

Please, read the documentation about this. s*printf() must not be used
here (in ->show() callbacks). There are special APIs.

...

> +static ssize_t mcp9982_running_average_window_store(struct device *dev,
> +                                                   struct device_attribu=
te *attr,
> +                                                   const char *buf, size=
_t count)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       int val, ret, reg_val;
> +
> +       if (kstrtouint(buf, 10, &val)) {

Do not shadow the actuall error code.

> +               dev_err(dev, "Value is not a number\n");
> +               return -EINVAL;
> +       }
> +
> +       switch (val) {
> +       case 1:
> +               reg_val =3D 0;
> +               break;
> +       case 4:
> +               reg_val =3D 1;
> +               break;
> +       case 8:
> +               reg_val =3D 3;
> +               break;
> +       default:
> +               dev_err(dev, "Value is invalid\n");
> +               return -EINVAL;
> +       }
> +
> +       guard(mutex)(&priv->lock);
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, reg_=
val);

How ret is being used?

I think I have a d=C3=A9j=C3=A0 vu about this code... I think I commented t=
his
or something like this already and there seems to be no reaction...

> +       priv->running_avg =3D val;
> +
> +       return count;
> +}

...

> +static int mcp9982_prep_custom_attributes(struct mcp9982_priv *priv, str=
uct iio_dev *indio_dev)
> +{
> +       struct attribute **mcp9982_custom_attr;
> +       struct attribute_group *mcp9982_group;
> +       struct device *dev =3D &priv->client->dev;
> +
> +       mcp9982_group =3D devm_kzalloc(dev, sizeof(*mcp9982_group), GFP_K=
ERNEL);

+ device/devres.h

> +       if (!mcp9982_group)
> +               return -ENOMEM;
> +
> +       mcp9982_custom_attr =3D devm_kzalloc(dev, MCP9982_NR_CUSTOM_ATTR =
*
> +                                          sizeof(*mcp9982_group) + 1, GF=
P_KERNEL);

No, use devm_kcalloc() and I'm not sure you have got the size correctly her=
e.

> +       if (!mcp9982_custom_attr)
> +               return -ENOMEM;
> +
> +       mcp9982_custom_attr[0] =3D MCP9982_DEV_ATTR(running_average_windo=
w);
> +       mcp9982_custom_attr[1] =3D MCP9982_DEV_ATTR(running_average_windo=
w_available);
> +
> +       mcp9982_group->attrs =3D mcp9982_custom_attr;
> +       priv->iio_info.attrs =3D mcp9982_group;
> +
> +       return 0;
> +}


> +       if (device_property_present(dev, "microchip,beta-channel1")) {

...

> +                       return dev_err_probe(dev, -EINVAL, "Beta 1 value =
is higher than max\n");

+ dev_printk.h

...

> +       priv->iio_chan =3D devm_kzalloc(dev, priv->num_channels * sizeof(=
*priv->iio_chan),
> +                                     GFP_KERNEL);

kcalloc()

> +       if (!priv->iio_chan)
> +               return -ENOMEM;

...

> +       device_for_each_child_node_scoped(dev, child) {
> +               ret =3D fwnode_property_read_u32(child, "reg", &reg_nr);

How is ret being used?

> +               if (reg_nr >=3D mcp9982_chip_config[i].phys_channels)
> +                       return dev_err_probe(dev, -EINVAL,
> +                                    "The index of the channels does not =
match the chip\n");
> +
> +               if (fwnode_property_present(child, "microchip,ideality-fa=
ctor")) {
> +                       ret =3D fwnode_property_read_u32(child, "microchi=
p,ideality-factor",
> +                                                      &priv->ideality_us=
er_value[reg_nr - 1]);
> +                       if (priv->ideality_user_value[reg_nr - 1] > MCP99=
82_IDEALITY_MAX_VALUE)
> +                               return dev_err_probe(dev, -EINVAL,
> +                                    "The ideality value is higher than m=
aximum\n");
> +               } else {
> +                       priv->ideality_user_value[reg_nr - 1] =3D MCP9982=
_IDEALITY_FACTOR_DEFAULT;
> +               }
> +
> +               ret =3D fwnode_property_read_string(child, "label",
> +                                                 (const char **)&priv->l=
abels[reg_nr]);

Ditto.

Why casting?

> +               priv->iio_chan[iio_idx++] =3D MCP9982_CHAN(reg_nr, reg_nr=
,
> +                                                        MCP9982_INT_HIGH=
_BYTE_ADDR(reg_nr));
> +       }
> +
> +       return 0;
> +}

...

> +       i2c_set_clientdata(client, indio_dev);

How is this being used?

...

> +static struct i2c_driver mcp9982_driver =3D {
> +       .driver  =3D {
> +               .name =3D "mcp9982",
> +               .of_match_table =3D mcp9982_of_match,
> +       },
> +       .probe =3D mcp9982_probe,
> +       .id_table =3D mcp9982_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(mcp9982_driver);

--=20
With Best Regards,
Andy Shevchenko

