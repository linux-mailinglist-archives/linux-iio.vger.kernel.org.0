Return-Path: <linux-iio+bounces-18387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F75A948FE
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 21:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2912A16F01C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAC21129C;
	Sun, 20 Apr 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzj1sVPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B113BC02;
	Sun, 20 Apr 2025 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745176936; cv=none; b=MJ2sG8J3jyjmyuInrqHxkZE2Fqepjuz965RiQBNM7F+re+o9F8fpKVlvBFcPAPytvxW3Sa4v685uGSVCEIG/vJYlAkbabChn1239v3lY8i1NWHR8BZYQVAvzRrShhV4gBcr+0ygokshaxiO6Bb4z6qJKAqPxlHYbHgO570uE9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745176936; c=relaxed/simple;
	bh=Yn3Ui4BSmWrPvxM8HgP0RwD5oDibc5XZTD1yLziOZmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1qmPVA0Fq7UhcAkTjZdl41PjFOHu9hCEBEUiBel6PMf5k5esM0Wd2gcA8rsGng2ly9HmfYu3rxFCLdW3OPh3QR47jWdYQQhtGxvSvJS9AuPfOsIno7NwF6zHK/6PxHapJcQbevdvyDERf2OuWxZtM/mjicOLXZ71nKXshRmN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzj1sVPJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so5271778a12.3;
        Sun, 20 Apr 2025 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745176933; x=1745781733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMMeqm+7ovbinPtAMFN5chfs5DhVtKsfhUKKqgjctSk=;
        b=hzj1sVPJpnfSPo5/O+330LbUo7ZoOnZWqbxduZ73kdMpJVJSepS6irEp3h8SSTERlu
         nAjc2G+/Glr/eGKPWj+EwizJdaVM+ctle1OtXw61Bp+dve23SHfFm9mFXeXd8HJTu2tO
         7mY0BNajIXjj2QG8yl+ceQymXr9goCCUoGYo6VzfpCnLICNpas+zRz8kFVcS/MUGatyj
         SMwsdnB6evIElh4icx85O72LHSIhtWRXTiXg0GD4BHPEGz0iUJbEpiXQblptsgoMQCDG
         fk8Jsp7jqDf7VX3xdXCOAxqFiXatEpTxUqPqgs9SoikSF/6dZpcl5UKMDghcPcaHjIci
         WDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745176933; x=1745781733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMMeqm+7ovbinPtAMFN5chfs5DhVtKsfhUKKqgjctSk=;
        b=MfBxZLa1C2/sU9cKpky3Ll5OOBlr9XuE0MRNtPOVLG+bQgaRSfrqiTVyUR1DjdV05/
         nWkbOo7xnbSzcxEpUlsJ2V0najRVdAUSbi5JIusFx2UCIyyz0DuxMt/VY+gh7G6FC4XN
         V25eD3LeGZ1n+7/J6EN5L4HyxFQ1aYmbBHfDoHpXGfyC9CJvs6D+E/EfR4TzkD3pkghF
         BJSELArIH8LyZWv2MOIF2tSCODM0qjJhvJ+6NwKzHyin4oYuCsr5YNJ2PbbcfBV+zw6u
         p0VFFDwxJABrRgjTjD1HKPL4mhBt1+C2X4tSFgRMXDNTBoYncfHWLve9yjQaM9Iz9RS5
         SJww==
X-Forwarded-Encrypted: i=1; AJvYcCVHDi9avU9pPK01N2m0/VPTNNv57hKM3BjGgBRBiqjLHZbTAgvHfr8ThX5yX6iK6fH/gUmkkCA/FPdO@vger.kernel.org, AJvYcCX3MKYYg43fZ2jA39OTCCa5C6UCFzbklr1ojFdUeZJDd9Qj6tl9VcmiMXB6UnIjs735zbd/bNxgAQ/p@vger.kernel.org
X-Gm-Message-State: AOJu0YwlW/IvrhAcwCrPV0s+HHPtkzySU9js1ccCI27Xohmo8C9anEbY
	Z1au1jliwDp+OYOZIW7L2A5UHa8Ly5kgE+HQ9NwDz/3PvTjtT8hvm3bmLwk1lz4PUfdZL2V1W56
	O8ZDhJUqM/KanPiIg9Q9lWAdUNIUoFsA1
X-Gm-Gg: ASbGncvPGvhDLL/LqQ3K8VMGNiwIlknNkksUjUzBquB9FEqSZrURz+v3IevWk5yjjP5
	zN2CrcnHSPDx+F5ny4IPo4NTI9ujqUbGslT/wriFt8tDEUahI7HuzFxJtLlMDflIM//QGm1qnFl
	m2vOZv6Y9kDhe5OP8MwQUnTw==
X-Google-Smtp-Source: AGHT+IEdc9v/Rh79UA07krqpQv3EuaguJEAxDEnogniGQUeXs1GaYLbUKImVAGwG6f6PhyEIWm+61gyqBtpCJM3CFZk=
X-Received: by 2002:a17:906:4ad1:b0:acb:abff:a5b6 with SMTP id
 a640c23a62f3a-acbabffa98dmr60619666b.13.1745176932594; Sun, 20 Apr 2025
 12:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420181015.492671-1-gye976@gmail.com> <20250420181015.492671-4-gye976@gmail.com>
In-Reply-To: <20250420181015.492671-4-gye976@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 20 Apr 2025 22:21:36 +0300
X-Gm-Features: ATxdqUGOS7jaAoDUMjKVRs_bX-z1fydDzYTkTKugooCCAB5PtFxV10LPIbWhh5U
Message-ID: <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> wr=
ote:
>
> Add support for winsen MHZ19B CO2 sensor.

> The datasheet is available at
> Link: https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-c=
o2-ver1_0.pdf

Instead, just make it Datasheet: tag.

>

Should not be this blank line here.

> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

...

> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_SPS30) +=3D sps30.o
>  obj-$(CONFIG_SPS30_I2C) +=3D sps30_i2c.o
>  obj-$(CONFIG_SPS30_SERIAL) +=3D sps30_serial.o
>  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> +obj-$(CONFIG_WINSEN_MHZ19B) +=3D mhz19b.o

Preserve order.

...

> +/*
> + * mh-z19b co2 sensor driver

Please, use the marketing name of the chip and we can spell CO=E2=82=82.

> + * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
> + *
> + * Datasheet:
> + * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2=
-ver1_0.pdf
> + */

...

> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +#include <linux/unaligned.h>

Semi-baked list, see below what's missing (actually a lot). I believe
I already pointed that out.

...

> +#define MHZ19B_SERDEV_TIMEOUT msecs_to_jiffies(100)

Missing header for msec_to_jiffies().

...

> +       u8 buf_idx;

Needs types.h

...

> +       switch (cmd) {
> +       case MHZ19B_ABC_LOGIC_CMD:
> +               cmd_buf[3] =3D (arg) ? 0xA0 : 0;

Unneeded parentheses.

> +               break;
> +       case MHZ19B_SPAN_POINT_CMD:
> +               put_unaligned_be16(arg, &cmd_buf[3]);
> +               break;
> +       default:
> +               break;
> +       }

...

> +               if (st->buf[8] !=3D mhz19b_get_checksum(st->buf)) {
> +                       dev_err(dev, "checksum err");
> +                       return -EINVAL;

Needs errno.h

> +               }

...

> +       ret =3D kstrtobool(buf, &enable);

It's defined in kstrtox.h.

> +       if (ret)
> +               return ret;

...

> +/*
> + * echo 0 > calibration_forced_value            : zero point calibration
> + *     (make sure the sensor has been worked under 400ppm for over 20 mi=
nutes.)

working

> + * echo [1000 1 5000] > calibration_forced_value : span point calibratio=
n
> + *     (make sure the sensor has been worked under a certain level co2 f=
or over 20 minutes.)

working

It seems you ignored this comment from the previous review.

> + */

...

> +       if (ppm) {
> +               if (!in_range(ppm, 1000, 4001)) {

Missing minmax.h.

The second parameter is length of the range.

> +                       dev_dbg(&indio_dev->dev,
> +                               "span point ppm should be 1000~5000");

The above range check doesn't agree with this message.

> +                       return -EINVAL;
> +               }
> +
> +               cmd =3D MHZ19B_SPAN_POINT_CMD;
> +       } else
> +               cmd =3D MHZ19B_ZERO_POINT_CMD;

Have you run checkpatch? This needs {} per Coding Style.

...

> +       memcpy(st->buf + st->buf_idx, data, len);

Requires string.h.

...

> +       serdev_device_set_baudrate(serdev, 9600);

> +

Redundant blank line.

> +       serdev_device_set_flow_control(serdev, false);

...

> +       dev_set_drvdata(dev, indio_dev);

Is it really used?

...

> +       indio_dev->num_channels =3D ARRAY_SIZE(mhz19b_channels);

Needs array_size.h.

--=20
With Best Regards,
Andy Shevchenko

