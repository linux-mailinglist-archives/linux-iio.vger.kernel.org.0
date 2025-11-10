Return-Path: <linux-iio+bounces-26155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A7C494DC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 21:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B57A3B4311
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E36D2ED175;
	Mon, 10 Nov 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDCRbUjt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8A22B8A6
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807603; cv=none; b=RFZUZgUf1nLIvbEV+5/Nt6Km/G1xoXyH6WW7z1G3MlR7Nl+OJ6aL5OpIYbOGtvm/lzGIu40aPOc/iIRlZtfj+GzC68Rf67Ts9gnx+VHTRkmro1vNfy0OMF9GXUwLg2f1b2MmrAEYhRJXPJqM/jDZSeuC8ixyVHXn0iiSBLtQ1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807603; c=relaxed/simple;
	bh=V6et8XZiJmPajNXLpjiEYmS8e1Vn5RYYti7HnWvDPFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcAQjbBPpDpP1oRpqM5naryk2h45gh2wCBOTR2/iX1dA2ipy/ONxA2+g1B1wVXaDWMXFCh1tAUHC5Rx9sy6W+YfiaDuDyxl8FpfbSR8Y1IYLt5jDJCwqsQ2s7Oaw93NtNcx4gornNeW1YgjXRBZxIBpTU/i5EaaAZbYwPIpO8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDCRbUjt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b731b176b5eso82852266b.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 12:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762807599; x=1763412399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hx+3UErOC7a4/6wBfCIV+NGBUPJoJPn9KMJFM1rAmc=;
        b=eDCRbUjtxdXCqL/poZO8/KqjwBz7KZYh47KyC0IdO17q+53irw6OhZrkJoi1oggTcI
         4JxkTgLuhG4G6xCAtZLJfXyuo2Jz2OlxzSLT62Q7ARmhuLt8oMA21prPbhdcQTcUbKv4
         6wRazD3LOcPaqd2F2itgKmuo+V5y4wHzf7NmylysAKblGSYQjIRr+c8R2I9R0DKzIw6y
         Dh61g/9u0cQbrYtlOpe8QQv4+BDWBhKvDc+x0pg+WFSyCf208bJZt7QBT7+/q+ixVIxF
         t5j8Kf0/5iKWwlcV2T4ngeqwSQAw5JQWbZFjI6vsz/ZXQbcdi9gVyUbsSmQ8f014TA4n
         FAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807599; x=1763412399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Hx+3UErOC7a4/6wBfCIV+NGBUPJoJPn9KMJFM1rAmc=;
        b=nHYAbEULe4NVyf9Ooom6wXDQtBdR+DBr015d3kqR+Pv03FTrZZf/Okt23BAB/PmJDP
         +xqozKbnDJ9Dq/UOZ5kCAMOam+rk94ZLk1tFLUjo/Pen0XYBf33oqQK1oCJGbYaNWHUr
         Wa+MFJvYTC24gGJ+xnhS+6hXNln3sDu26iqde0gZnEnP2iGzQTg6Pyg+HznACO7ml3tT
         NuzmKcId83KmQuHf/42kRZInFabZ4BeEwoNW4nNHClCx5r0h4A8Lxl6bhZPgmS0QIi2L
         LdEjbOfIMGhvQlS4HmAuFhMpz6jwIhqXaqnFfHaiaqj8wA8wEcp1FwHDgJdESi8ngIom
         A3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDvHVUkgpLM3B3udFAT2dZG4Fd95feIjG9tkq/akFVyCRh0IBpAkQNe1OV6SqDN0Fl5eKzkaDPT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGsgF3/VjHAHs0mkmcuWYVO6OTxa8MbeQUtdfon3sSdxZyevz
	oEW0prHkSgZbn77eF1l/7EjlXE/OABD0wxA9Z8KRada+O5doaMfftKgIB9/7zhH1Tc7HwOQs5RT
	jZvLoiyzUUEvTFb1+MLLYVOOhMVWQKPM=
X-Gm-Gg: ASbGncsoEqncufT85vGr7kU1dCSQKQvra/+0wswkjcc4LKMNAXgrIjOpSbbP40W3nzc
	3SBqyLTJBihhza2ObkW3nvrbOj8lIwyBPHeiyLZUQA5n51LSTHeqQsdvsbcHkAx3Re2M2yC6jyA
	1VReY+7eGUQf9vd0B00+U/E7wUun/RYIhqga5L0Sa8ZQS7vJeMrbf2rwRe/UUm/1w6h8s/JVSmv
	KzrSazyiTeT59BepnEvMzWvzlz6BU/y4QIwpcCYhSFUZlKLscyiR4MTbERniEDc+QxYwP3p
X-Google-Smtp-Source: AGHT+IGPBuMN+yAFnF0ZR3EjG2yEc6dIK2mrlQzy7SywuR84/WsrDdt3Or9lcOFeDlZjj4YFPbgIjGqJ7P9gvWVC3s4=
X-Received: by 2002:a17:907:d8e:b0:b6d:7f24:8428 with SMTP id
 a640c23a62f3a-b72e0587c83mr1036102966b.54.1762807599197; Mon, 10 Nov 2025
 12:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110061409.726028-1-o.rempel@pengutronix.de> <20251110061409.726028-3-o.rempel@pengutronix.de>
In-Reply-To: <20251110061409.726028-3-o.rempel@pengutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Nov 2025 22:46:02 +0200
X-Gm-Features: AWmQ_blXIxlzHMJq1NdqVVn7zUANqYXxGQTtjIxHfdA-UtT59FQKa8nuqtp1fME
Message-ID: <CAHp75Vd9WCXR_QmefqPhWO1niMnESq7LAcN=eYvSiqkWfFrNhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add TI ADS131M0x ADC driver
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Jander <david@protonic.nl>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:14=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
>
> Highlights:
> - Supports 2/3/4/6/8-channel variants with per-channel RAW and SCALE.
> - Implements device-required full-duplex fixed-frame transfers.
> - Handles both input and output CRC; uses a non-reflected CCITT (0x1021)
>   implementation because the generic crc_ccitt helper is incompatible.
>
> Note: Despite the almost identical name, this hardware is not
> compatible with the ADS131E0x series handled by
> drivers/iio/adc/ti-ads131e08.c.

(Note, my address for IIO reviews is andy@kernel.org)

...

+ array_size.h
+ bitops.h

> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>

+ dev_printk.h
+ device/devres.h

> +#include <linux/err.h>
> +#include <linux/iio/iio.h>

+ lockdep.h

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>

+ mutex.h

> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

+ string.h

> +#include <linux/unaligned.h>

+ types.h

...

> +#define ADS131M_CMD_RREG(a, n) \
> +       (0xa000 | ((u16)(a & 0x1f) << 7) | (u16)(n & 0x7f))

> +#define ADS131M_CMD_WREG(a, n) \
> +       (0x6000 | ((u16)(a & 0x1f) << 7) | (u16)(n & 0x7f))

These two suspiciously look like a reinvention of proper unaligned
getters with the specific shift / GENMASK().

...

> +/* 1.2V internal reference, in millivolts, for IIO_VAL_FRACTIONAL_LOG2 *=
/
> +#define ADS131M_VREF_INTERNAL_MV       1200

_mV

...

> +/* 24-bit resolution */
> +#define ADS131M_RESOLUTION_BITS                24
> +/* Divisor is 2^(Res - 1) for signed 2's complement */
> +#define ADS131M_SCALE_DIVISOR          (1UL << (ADS131M_RESOLUTION_BITS =
- 1))

Why not BIT() here?

...

> +struct ads131m_configuration {

Running `pahole` might give some hints on optimisation of the layout.

> +       const struct iio_chan_spec *channels;
> +       u8 num_channels;
> +       u16 reset_ack;
> +       bool supports_extref;
> +       bool supports_xtal;
> +       const char *name;
> +};

...

> +static inline u16 ads131m_crc_ccitt_byte(u16 crc, u8 data)
> +{
> +       int i;
> +
> +       crc ^=3D ((u16)data << 8);
> +       for (i =3D 0; i < 8; i++) {
> +               if (crc & 0x8000)
> +                       crc =3D (crc << 1) ^ 0x1021;
> +               else
> +                       crc =3D (crc << 1);
> +       }
> +
> +       return crc & 0xFFFF;
> +}
> +
> +/**
> + * ads131m_crc_calculate - Calculate CRC-16-CCITT over a buffer
> + * @buffer: The data buffer to process
> + * @len: The length of the buffer
> + *
> + * This function processes a buffer with the CCITT algorithm required
> + * by the device, using the 0xFFFF seed.
> + *
> + * Return: The final 16-bit CRC.
> + */
> +static u16 ads131m_crc_calculate(const u8 *buffer, size_t len)
> +{
> +       u16 crc =3D 0xFFFF;
> +       size_t i;
> +
> +       for (i =3D 0; i < len; i++)
> +               crc =3D ads131m_crc_ccitt_byte(crc, buffer[i]);
> +
> +       return crc;
> +}

Why CRC16 library can't be used here (crc_ccitt() one perhaps)?

...

> +static int ads131m_write_reg_unlocked(struct ads131m_priv *priv, u8 reg,
> +                                     u16 val)

I would go with a single line here.

...

> +               dev_err_ratelimited(dev,
> +                                   "SPI error on WREG (cycle 1)\n");

Ditto.

...

> +               dev_err_ratelimited(dev,
> +                                   "SPI error on WREG ACK (cycle 2)\n");

Ditto.

...

> +       /*
> +        * Cycle 3: Check STATUS for Input CRC error.
> +        * This is necessary even if ACK was wrong, to clear the CRC_ERR =
flag.
> +        */
> +       ret =3D ads131m_check_status_crc_err(priv);
> +
> +       return ret < 0 ? ret : ret_crc_err;

Use standard way of checking:

  ret =3D ...(...);
  if (ret)
    return ret;

  return ret_crc_err;

...

> +static int ads131m_rmw_reg(struct ads131m_priv *priv, u8 reg, u16 clear,
> +                          u16 set)

One line.

> +{
> +       u16 old_val, new_val;
> +       int ret;
> +
> +       guard(mutex)(&priv->lock);
> +
> +       ret =3D ads131m_read_reg_unlocked(priv, reg, &old_val);
> +       if (ret < 0)
> +               return ret;
> +
> +       new_val =3D (old_val & ~clear) | set;

> +

Unneeded blank line.

> +       if (new_val =3D=3D old_val)
> +               return 0;
> +
> +       return ads131m_write_reg_unlocked(priv, reg, new_val);
> +}

...

> +       /*
> +        * The received 16-bit CRC is MSB-aligned in the last 24-bit word=
.
> +        * We extract it from the first 2 bytes (BE) of that word.
> +        */
> +       received_crc =3D get_unaligned_be16(&priv->rx_buffer[data_len]);

> +

Unneeded blank line.

> +       if (calculated_crc !=3D received_crc) {
> +               dev_err_ratelimited(dev,
> +                                   "Output CRC error. Got %04x, expected=
 %04x\n",
> +                                   received_crc, calculated_crc);
> +               return -EIO;
> +       }

...

> +       struct device *dev =3D &priv->spi->dev;
> +       int vref_uv;

_uV

> +       int ret;

...

> +#define ADS131M_VOLTAGE_CHANNEL(num)   \
> +       { \
> +               .type =3D IIO_VOLTAGE, \
> +               .indexed =3D 1, \
> +               .channel =3D (num), \
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +                       BIT(IIO_CHAN_INFO_SCALE) \

Leave trailing commas for non-terminating entries.

> +       }

...

> +       /*
> +        * Get the optional external reference. This schedules regulator_=
put()
> +        * automatically.
> +        */
> +       priv->refin_supply =3D devm_regulator_get_optional(dev, "refin");
> +       if (IS_ERR(priv->refin_supply)) {
> +               /* -ENODEV is fine, it just means we'll use the internal =
ref */
> +               if (PTR_ERR(priv->refin_supply) =3D=3D -ENODEV)
> +                       priv->refin_supply =3D NULL;
> +               else
> +                       return dev_err_probe(dev, PTR_ERR(priv->refin_sup=
ply),
> +                                            "failed to get refin regulat=
or\n");
> +       }

Can be untangled to

  ... =3D devm_regulator_get_...
  ret =3D PTR_ERR_OR_ZERO(...);
  if (ret =3D=3D -ENODEV)
    ... =3D NULL;
  else if (ret)
    return dev_err_probe(...);

...

> +               if (priv->config->supports_xtal) {
> +                       if (!is_xtal) /* "clkin" */
> +                               clk_set |=3D ADS131M_CLOCK_XTAL_DIS;
> +               }

if (foo) { if (bar) {...} } =3D=3D if (foo && bar) { ... }

> +               if (priv->config->supports_extref) {
> +                       if (!IS_ERR_OR_NULL(priv->refin_supply))
> +                               clk_set |=3D ADS131M_CLOCK_EXTREF_EN;
> +                       else
> +                               clk_clear |=3D ADS131M_CLOCK_EXTREF_EN;

Why not a positive check?

> +               }

...

> +       ret =3D device_property_read_string(dev, "clock-names", &clock_na=
me);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret,
> +                                    "device property 'clock-names' not f=
ound\n");
> +       is_xtal =3D (strcmp(clock_name, "xtal") =3D=3D 0);

Hmm... We have device_property_match_string().


--=20
With Best Regards,
Andy Shevchenko

