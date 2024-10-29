Return-Path: <linux-iio+bounces-11575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121219B52F7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEFF1F24060
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938122071FF;
	Tue, 29 Oct 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIb6z4VN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BE205ACD;
	Tue, 29 Oct 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231364; cv=none; b=obWtuPgimUBzFPcl65srqRj3pjvZY90ESQrFUE+FJiKzR4SCVLWiPJIzb0cQMwNQJzUpfsLW2A72MX7YwBzzuvRtH3SmszteyPEVckX79wWs+5GmZtsGhxysSyoKyhF/H/Wpiyx9x8wthMCriZ2ZmurHcMcueuDdouQwYB02hUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231364; c=relaxed/simple;
	bh=awdoH5rFFbiqcZock4aM2tIsTeFivVpQfSVpnLjh0kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soT28yoesXeJuGdG19XIVAe3atk9lp0NdXHC/kr8MOmUPivj3qS4MXYbvb7yzGvjM69mJBWBXYhLRTJ76Ov5UgH+RaeyoO3RDsa9Mv4/JtI+43FOgocQOSlOl6qvUZHCSU2lWhXvGfBPfo9JfsOi6HpUux8txAkUTBoR1tT/Pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIb6z4VN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f646ff1bso739415066b.2;
        Tue, 29 Oct 2024 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730231360; x=1730836160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvu3soGzeUup65TCa4YHvz4LZhITDevElDnbRUoM1J8=;
        b=fIb6z4VN44K5stPurnpzi53g0foWukPQ0b0YcoH3n2BO8MzMT2y6E7h2vlMiUXB99+
         v7HgYLlVZwS2TcnckCUQosn41W0eVoEiv9wppZT/S65n5cWkN8jb/YdLSX191KMNxowL
         oPo3tvH/wAwfpF/B36XW9jWP09EFaRxdfhc++d/StefWi5K1e1MPs5ndrE/+noQOlTWe
         +JOYEgMl90OxA4qopRrUk/Lo/FdwZZpqCfpdt8AwTP07AoLlprxJqSw+4E9ycWWhskyR
         nOu1oLPRZrejWPdSZfhCpz2vUrQfz5TZLynRgSnUGGT1iR77INKPzrKzoDnA1zkazHbk
         wYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730231360; x=1730836160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gvu3soGzeUup65TCa4YHvz4LZhITDevElDnbRUoM1J8=;
        b=Gnw8IN0NK5Yr6bHs2qnbVQRAjBaQ5tOj2VriLAUKjVf8qe2ItHaCOLQU9yuoePhD88
         Ds3yV427GJ/n0K2h/pOK3aJ8oAjvCGdYJuZBewz4um6bWAxqSsof8GEe1qzePpThATGA
         6YwR7LEaKxW8P6+Ksh5Fe3+oTtIfxnfz8HJ8cmlXBDojRvI6p8UVY5gBPe3ZYzAn8MFF
         BO5ceO4DIkvsGUI3bj1YN9rCLBxaCbYjBUoscaerEjjwrbqEaSE0H0sN79XAsVEj5Kix
         teBNgFYFMVXI09okfcebs0RcE+la2h/AdeMlJnV1b8foBANWvRgSr6HIHsluG6rPpDV5
         z33w==
X-Forwarded-Encrypted: i=1; AJvYcCVh/w1JVjJjgGJue5/FnJ5jkhDr1Tp2KTaaelVKLm9M9pQZuPHYv5PLn6f/vuomCC+KJpv84s52zN8qvcPu@vger.kernel.org, AJvYcCWSsAj3pfCNTTI2/NJeF3LnhYNgLCZVmopgDU+V2KgWOCy2cjBSr38sJPI9wU8ZRyy8yJoEqOF0n1wU@vger.kernel.org, AJvYcCX106WMubYhVYT3fdzB6h1pXSwCiBvXbZ/4mwqJlkrCGL/BJxED4TYDzM6BhRqOgIKvIhLc16k9nq4i@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fYztg6QkHjj6fkYH0pYIDvpJwVgiQyXxzCET6lhW0dhmOsbo
	DG+i+MnGK0Ha2Cs026UvLRfCSapuZluwwN4GohGhvV60NjalkCkBTjPOwj1eOgLr8OzjRIyyfV0
	GCnuet5y+NAFZOoYaUVThAijWrcsxZsod
X-Google-Smtp-Source: AGHT+IFkl/d3NegynTrjcdaD7515ZshkwvuLCJzsB7qoiisnKif/TjKlae2JUVKHozBuT0llM79ZvOjdmNOuPhJ9Iyg=
X-Received: by 2002:a17:907:970e:b0:a9a:2a56:91e with SMTP id
 a640c23a62f3a-a9e3a574f2cmr74443566b.6.1730231360049; Tue, 29 Oct 2024
 12:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
 <20241029-topic-input-upstream-als31300-v3-3-147926dd63b3@linaro.org>
In-Reply-To: <20241029-topic-input-upstream-als31300-v3-3-147926dd63b3@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Oct 2024 21:48:42 +0200
Message-ID: <CAHp75VdH7bxuPW6Fx4Mcq18hQfr1sDhBYDwGn8OeurQOAar2kg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:13=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
> mainly used for 3D head-on motion sensing applications.
>
> The device is configured over I2C, and as part of the Sensor data the
> temperature core is also provided.
>
> While the device provides an IRQ gpio, it depends on a configuration
> programmed into the internal EEPROM, thus only the default mode is
> supported and buffered input via trigger is also supported to allow
> streaming values with the same sensing timestamp.
>
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss
> unit is not available from registers, thus the sensitivity is provided
> by the compatible/device-id string which is based on the part number
> as described in the datasheet page 2.

Thank you for an update, this looks more or less good. I have a few
nit-picks below. With them addressed,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +#include <linux/types.h>
> +#include <linux/units.h>

It's a bit of an unusual order. Do you mean to put them after the
regulator/*.h one?

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>

...

> +#define ALS31300_DATA_X_GET(b)         \
> +               sign_extend32(FIELD_GET(ALS31300_VOL_MSB_X_AXIS, b[0]) <<=
 4 | \
> +                             FIELD_GET(ALS31300_VOL_LSB_X_AXIS, b[1]), 1=
1)
> +#define ALS31300_DATA_Y_GET(b)         \
> +               sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Y_AXIS, b[0]) <<=
 4 | \
> +                             FIELD_GET(ALS31300_VOL_LSB_Y_AXIS, b[1]), 1=
1)
> +#define ALS31300_DATA_Z_GET(b)         \
> +               sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Z_AXIS, b[0]) <<=
 4 | \
> +                             FIELD_GET(ALS31300_VOL_LSB_Z_AXIS, b[1]), 1=
1)
> +#define ALS31300_TEMPERATURE_GET(b)    \
> +               (FIELD_GET(ALS31300_VOL_MSB_TEMPERATURE, b[0]) << 6 | \
> +                FIELD_GET(ALS31300_VOL_LSB_TEMPERATURE, b[1]))

Yeah, I have got that the data is interlaced, and it's still possible
to use the __be64, but the resulting code might be too overengineered
for this simple case (as it would require bitmap operations to remap
interlaced bits and an additional churn on top of u64 to be
represented as set of unsigned long:s).

...

> +/* The whole measure is split into 2x32bit registers, we need to read th=
em both at once */

32-bit

...

> +       /*
> +        * Loop until data is valid, new data should have the
> +        * ALS31300_VOL_MSB_NEW_DATA bit set to 1.
> +        * Max update rate is 2KHz, wait up to 1ms

Missing period at the end.

> +        */

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_PROCESSED:
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D als31300_get_measure(data, &t, &x, &y, &z);
> +               if (ret)
> +                       return ret;
> +
> +               switch (chan->address) {
> +               case TEMPERATURE:
> +                       *val =3D t;
> +                       return IIO_VAL_INT;
> +               case AXIS_X:
> +                       *val =3D x;
> +                       return IIO_VAL_INT;
> +               case AXIS_Y:
> +                       *val =3D y;
> +                       return IIO_VAL_INT;
> +               case AXIS_Z:
> +                       *val =3D z;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       /*
> +                        * Fractional part of:
> +                        *         1000 * 302 * (value - 1708)
> +                        * temp =3D ----------------------------
> +                        *             4096
> +                        * to convert temperature in millicelcius

 Missing period at the end.

> +                        */
> +                       *val =3D MILLI * 302;
> +                       *val2 =3D 4096;
> +                       return IIO_VAL_FRACTIONAL;
> +               case IIO_MAGN:
> +                       /*
> +                        * Devices are configured in factory
> +                        * with different sensitivities:
> +                        * - 500 GAUSS <-> 4 LSB/Gauss
> +                        * - 1000 GAUSS <-> 2 LSB/Gauss
> +                        * - 2000 GAUSS <-> 1 LSB/Gauss
> +                        * with translates by a division of the returned
> +                        * value to get Gauss value.
> +                        * The sensisitivity cannot be read at runtime

sensitivity

> +                        * so the value depends on the model compatible
> +                        * or device id.
> +                        */
> +                       *val =3D 1;
> +                       *val2 =3D data->variant_info->sensitivity;
> +                       return IIO_VAL_FRACTIONAL;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_OFFSET:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       *val =3D -1708;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }

> +

Seems like a stray blank line here.

> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static int als31300_set_operating_mode(struct als31300_data *data,
> +                                      unsigned int val)
> +{
> +       int ret;
> +
> +       ret =3D regmap_update_bits(data->map, ALS31300_VOL_MODE,
> +                                ALS31300_VOL_MODE_SLEEP, val);
> +       if (ret) {
> +               dev_err(data->dev, "failed to set operating mode (%pe)\n"=
, ERR_PTR(ret));
> +               return ret;
> +       }
> +
> +       /* The time it takes to exit sleep mode is equivalent to Power-On=
 Delay Time */
> +       if (val =3D=3D ALS31300_VOL_MODE_ACTIVE_MODE)
> +               usleep_range(600, 650);

fsleep() ?

> +       return 0;
> +}

...

> +       devm_mutex_init(dev, &data->mutex);

Hmm... While not critical, this may still return an error. There were
only two (out of ~15) users that ignored the error code, in v6.12
there are two more in IIO, while one is checking for it. I would like
to check for an error and bail out (and maybe I'll update the other
drivers in IIO to follow, including one GPIO module that ignores it).

--=20
With Best Regards,
Andy Shevchenko

