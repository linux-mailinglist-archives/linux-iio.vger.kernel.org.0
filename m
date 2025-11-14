Return-Path: <linux-iio+bounces-26229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F46C5EDE6
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A5064E1CC7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABB3431F5;
	Fri, 14 Nov 2025 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN56Awec"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADD2DAFAE
	for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144703; cv=none; b=YdGQe2LH8n1TwZmclb08lJolY4JTDnlyHp3mPjsh1ReGWhPE38mIRZXHAh+ls3Haxmrx9l3Apt0/bxUGDHx4d2izdQVnxrraOHYZ06CktRGxEN1X5IQ2nLPJeoABssTv/6aIndl/XiosqytDPEk54gA9bZHUFV7NV7sJ+1AgYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144703; c=relaxed/simple;
	bh=gJaks/UCvgAlXCLih4Srnc070Lq8z81HWpnI4Tauz7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrqJOry74pGFXCqwbWaXabOPyG1AWkynuBzBdVj1D0JZlXKz/ryStE1Hf3oTPQvvgvw9mTubMq95zcJCs1cyLfX735qFci8T45HmQTzD1wC7cfmUh3bYk65mK0qqFhlGhZ6UffLLg/+MWJNI69jf8ceqo7xUfkSKFlj95qa/nAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN56Awec; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b70bee93dc4so324930166b.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144700; x=1763749500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOlPxByPVTPCbTo7AMY18VmB1hSsPxJmT9QGb8+o0Aw=;
        b=fN56AwecxiOpQWDyG2SpPU6VJq0OS5BrFE+pbSK+VTIhDJ8qnTT5lhmA0xcVkYLhIw
         t1cEghNwjtUqRxeecw7TDXQStmKMtWMuerMNjUW9toiN4MvMZh52rQzMCy5SP5GSFwjn
         E5OjZVxMbla1cesxr/1BHngx80m2BR7qR8UfxQdWvWaAbSIdTgaGJ2eXLTIk2Z8HobPP
         n0rll75APNIl7rDMApEY7DgDFzkXsjbZJMkI9OyNTRXEMu0a1P1CRgAVxxUl55Ir2ym+
         EbS9JDQKbWyDU1vgrIkPprDv9BIU7lGmLtTt/COXmu67PkVk0xZ3vDf7+TKWeLdM1kzP
         7yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144700; x=1763749500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOlPxByPVTPCbTo7AMY18VmB1hSsPxJmT9QGb8+o0Aw=;
        b=qjk1QkNQO6utBjZT+2FGBRw8uqeE05eewjL9RBeebVEJE6eaGxqp21LSdsKwdAwWQ9
         JJpCw92w26HNxz5gYK5pBNSxqN7Lre3e7p/z0uqDHCDV2goXbNItNVP7ikPOa1T4cxSF
         gswoiAFnx5gOt3I3g0oreRVjXwsImUA6nvDSxMRMlK6ftmXnLmkMCi/o6qeJfyOpR235
         GUBfU0VZyy2RwEoeTSxkSHRD20aCmgNu3RenzQHi5EC7iHg2xcuvv/Y36TC05x5dFYRj
         WpXS45O0SDoQqe9vVDXtR3B260pFsUSKhdV/PbSkdmSFtDyZs9WKvImGa7OLJy4JVN2Q
         7Zdg==
X-Forwarded-Encrypted: i=1; AJvYcCXwAUCF54OCzUkWn1OXjzgbaAfi9ss1Hl987q4+CLenXgS4qecKB7taZGMtAu7h5VppfqdJW5nupKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXN5VesYoQRNhuCWw6YPWYSh/b4pSvohhIX38t3zibEIIG9Zn
	EwfjdXd8RB3HTa3D6eBqkQQ85Y7FYaE3EzbmkB+EQWVUT+sY6/PmaSRzTnY8H3J/osgzpXPQife
	wbzRP9jFI0FGdEo3p1ZLfXqkPR0GrgcA=
X-Gm-Gg: ASbGnctaQSO7YOxhls9+/HY0Y8vwLqmwYZCJ/ddRO+t36o41x0xOGtdnlCIXBaP4O1c
	AJtnG/QIy178r4p6UtowrKP95oclkowTMH1dK4PgSQ8xH+mgbe138PXVb7pJ64+CAT5bc6UOlyJ
	VziPRkgb61Fq5j63fgn33tMFfJoXPr4TOWlhX19zHv9KHbsdlKFtVq3x1fuGsUhndMBhUrMThWN
	F3YcUGSnNb+v4mks/0klX3gLTKDsCtxGZcIKLTeXaUTIpWzdyUdmxPAjbrQpw==
X-Google-Smtp-Source: AGHT+IHooFAx39vbTH14kY2vkzUUNpCSYRss1/mwUR7nsY81OVmVVvb4tRt71ZKJsCxS1Y/sfm0rX/p9bYgSlzoQFyc=
X-Received: by 2002:a17:907:a4c:b0:b72:d001:7653 with SMTP id
 a640c23a62f3a-b736780c141mr411429466b.19.1763144699443; Fri, 14 Nov 2025
 10:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092000.4058978-1-o.rempel@pengutronix.de> <20251114092000.4058978-3-o.rempel@pengutronix.de>
In-Reply-To: <20251114092000.4058978-3-o.rempel@pengutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 14 Nov 2025 20:24:23 +0200
X-Gm-Features: AWmQ_bkzDCK-qXNyHUrYcmb0FM-3ZSN52nNcYrFmhBRlsvWdBHMMQo35fe5RytA
Message-ID: <CAHp75Vcjv=XerYsunKO7h_e_jBMQuaKvkvRAuPLAXLqevM4jMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS131M0x ADC driver
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Jander <david@protonic.nl>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:20=E2=80=AFAM Oleksij Rempel <o.rempel@pengutron=
ix.de> wrote:
>
> From: David Jander <david@protonic.nl>
>
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
>
> Highlights:
> - Supports 2/3/4/6/8-channel variants with per-channel RAW and SCALE.
> - Implements device-required full-duplex fixed-frame transfers.
> - Handles both input and output CRC
>
> Note: Despite the almost identical name, this hardware is not
> compatible with the ADS131E0x series handled by
> drivers/iio/adc/ti-ads131e08.c.

...

> +config TI_ADS131M02
> +       tristate "Texas Instruments ADS131M02"
> +       depends on SPI && COMMON_CLK && REGULATOR

Hmm... The COMMON_CLK looks strange here. Why?

> +       select CRC_ITU_T

Btw, why does it not use regmap?

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/crc-itu-t.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>

> +#include <linux/device.h>

Is it used? I haven't found what API or data structure is required from her=
e.

> +#include <linux/device/devres.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/lockdep.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

...

> +#define ADS131M_CMD_RREG_OP            0xa000
> +#define ADS131M_CMD_WREG_OP            0x6000

These two have bit 13 always set. What is the meaning of that bit?

> +#define ADS131M_CMD_RREG(a, n) \
> +       (ADS131M_CMD_RREG_OP | \
> +        FIELD_PREP(ADS131M_CMD_ADDR_MASK, a) | \
> +        FIELD_PREP(ADS131M_CMD_NUM_MASK, n))
> +#define ADS131M_CMD_WREG(a, n) \
> +       (ADS131M_CMD_WREG_OP | \
> +        FIELD_PREP(ADS131M_CMD_ADDR_MASK, a) | \
> +        FIELD_PREP(ADS131M_CMD_NUM_MASK, n))

...

> +/**
> + * ads131m_tx_frame_unlocked - Sends a command frame with Input CRC
> + * @priv: Device private data structure.
> + * @command: The 16-bit command to send (e.g., NULL, RREG, RESET).
> + *
> + * This function sends a command in Word 0, and its calculated 16-bit
> + * CRC in Word 1, as required when Input CRC is enabled.
> + *
> + * Return: 0 on success, or a negative error code from spi_sync.

spi_sync()

But I would drop it as it makes dependency on the code changes and it
will deviate easily if code grows and something else becomes a call
that returns an error, also this simply doesn't scale: are you going
to list whole bunch of APIs in the kernel doc? (rhetorical Q) Ditto
for other similar cases.

> + */

...

> +/**
> + * ads131m_check_status_crc_err - Checks for an Input CRC error.
> + * @priv: Device private data structure.
> + *
> + * Sends a NULL command to fetch the STATUS register and checks the
> + * CRC_ERR bit. This is used to verify the integrity of the previous
> + * command (like RREG or WREG).
> + *
> + * Return: 0 on success, -EIO if CRC_ERR bit is set.

Note, this kernel-doc line is good as it doesn't rely on the code,
rather on the HW programming flow.

> + */

...

> +static int ads131m_rmw_reg(struct ads131m_priv *priv, u8 reg, u16 clear,=
 u16 set)
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
> +       if (new_val =3D=3D old_val)
> +               return 0;
> +
> +       return ads131m_write_reg_unlocked(priv, reg, new_val);
> +}

...

> +static int ads131m_hw_reset(struct ads131m_priv *priv)
> +{
> +       struct device *dev =3D &priv->spi->dev;
> +       int ret;
> +
> +       /* Datasheet: Hold /RESET low for > 2 f_CLKIN cycles. 1us is ampl=
e. */
> +       ret =3D gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to assert reset GP=
IO\n");


> +       fsleep(1);

Hmm... Is it needed? I think the GPIO is slow enough to avoid delays
like this, but okay.

> +       ret =3D gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to deassert reset =
GPIO\n");
> +
> +       /* Wait t_REGACQ (5us) for registers to be accessible */
> +       fsleep(ADS131M_RESET_DELAY_US);
> +
> +       return 0;
> +}

Can you use the reset-gpio driver instead of a custom approach?

...

> +       /*
> +        * Get the optional external reference. This schedules regulator_=
put()
> +        * automatically.
> +        */
> +       priv->refin_supply =3D devm_regulator_get_optional(dev, "refin");
> +       ret =3D PTR_ERR_OR_ZERO(priv->refin_supply);
> +       if (ret =3D=3D -ENODEV)
> +               priv->refin_supply =3D NULL;
> +       else if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to get refin regul=
ator\n");

So, will the refin_supply be ever an error pointer? I think no, hence
why IS_ERR_OR_NULL() in the user somewhere above in the code?

...

> +static int ads131m_parse_clock(struct ads131m_priv *priv, bool *is_xtal)
> +{
> +       struct device *dev =3D &priv->spi->dev;
> +       int ret;
> +
> +       priv->clk =3D devm_clk_get_enabled(dev, NULL);
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk), "clk get en=
abled failed\n");
> +
> +       ret =3D device_property_match_string(dev, "clock-names", "xtal");
> +       if (ret =3D=3D 0) {
> +               if (!priv->config->supports_xtal)
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "'xtal' clock not supported =
on this device");

> +               *is_xtal =3D true;
> +
> +               return 0;

This...

> +       } else if (ret > 0) {
> +               return dev_err_probe(dev, -EINVAL, "'xtal' must be the on=
ly or first clock name");

> +       } else if (ret =3D=3D -ENODATA) {
> +               *is_xtal =3D false;
> +
> +               return 0;
> +       }
> +
> +       return dev_err_probe(dev, ret, "failed to read 'clock-names' prop=
erty");

...and this can be deduplicated, so the first one becomes just a check
for !supports_xtal.

  if (ret =3D=3D 0) && !supports_xtal)
    return dev_err_probe(...);
  else if (ret > 0)
    return dev_err_probe(...);

This one will be modified to

  else if (ret !=3D -ENODATA)
    return dev_err_probe(...);

  *is_xtal =3D !ret;
  return ret;

> +}

...

> +       config =3D spi_get_device_match_data(spi);

> +       if (!config)
> +               return dev_err_probe(dev, -EINVAL, "No device configurati=
on data found\n");

Without this code will crash, right? So, I consider this check is
redundant because any support of any new chip requires this, and if
one didn't add the driver data, means it wasn't tested (which is a
good trap on itself during code review).

...

> +       { } /* Fixed sentinel */

No comment needed.

--=20
With Best Regards,
Andy Shevchenko

