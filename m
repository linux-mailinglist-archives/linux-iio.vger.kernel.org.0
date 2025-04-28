Return-Path: <linux-iio+bounces-18758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31FCA9E8CB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D717A4CD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56211D63C5;
	Mon, 28 Apr 2025 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdWQaAo/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCE191F94;
	Mon, 28 Apr 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823902; cv=none; b=NQiVkc0hj7E3hOiGVcmA3lXXUIIyxUn8/kLVVxLeB0P2qWyB/TGgBEO8Pz78/AzBKgUlcY05pp2hEGNLUZZkY23j0XDL2EebS7uznZGlw/ZgKngCriLJ8akTncdnuxIlR7J2nfOMu/hu6QGF5ORVJVeD1SweJ7bQUCTct0Gafm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823902; c=relaxed/simple;
	bh=7NHDbXVYZkKVsgdRvpnNE6uy6uOLayDsajznmv2GS/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0qhhx/fZqt6aIqDqmCbXUFJt/9jp0Wl9Ue4nw/oQW9RbXycrUfjIHDCnC9XIO1WkazUXjkW/m9+UVIPSoaU4MIevpYUQu2ZNkCOJzWcheN6dpAxP6+/fR2zx0mYUEHAts+xrkjKp9kbn2fRskKXqpoSZBxcvA/oURCpBB6JMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdWQaAo/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac289147833so778885066b.2;
        Mon, 28 Apr 2025 00:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823899; x=1746428699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFug2l7i4RVR+IYDsgOgLdi8rZQpSCoOK9KVvixJP/I=;
        b=BdWQaAo/+I/oPSa++wRYi40UpsY1172f1vgZF7U7bhWzgfNfB1QDhGxWnnTEMds9OK
         xZ+495wgC2EC9L+cn97AduVmEtNKt4lLGVpnFJoAGx8/dR26UBFuWjQ88owqTZ7Bra1W
         zqM+La3yL0rNBDWXd9R843UDJoZzkUwFDASH4Yw8do69eo3eDuoBzcaEsmxv+WMUBc6r
         DCyUvUb3WzWRiInMJfSacZwiplo7rVk+tZ2NbO5wG69qiTSG55ptMtmzi1YxjC4QlDep
         n39YHno0jzJn7vVXUYScVq3vX9xieDn/iw1f8MWO5sLkB+FiHxc2DjpHqfFJbJm9Tuhu
         tqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823899; x=1746428699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFug2l7i4RVR+IYDsgOgLdi8rZQpSCoOK9KVvixJP/I=;
        b=BIY7QDMM49jvtdNApKIm6VIgBc6aKAsm3OMJ2lKTHYUgF9Jbjxzuk8b0776N/s6eEj
         e/BlblLrUa0xi0QyxhM7xAQvguWwrPr5jO+JZBTDvfqGLCV3rBmu/e9CBd/hdUKYJyN5
         5VV3AjDZ/Vanh7rsil4fkUcd1SLmWPIYygVse2zfwoJzIbelnQhjC2d0g9mOW//oBIFn
         m0nDQEksBH2nc3lHitWfQUA8V/6z0t3bGnjzxHVUlYCsZiRqRkpatWtHxtATxYnUzvyc
         /enlY20zrQ7PrrWFytej4F4H9gm9gTQr7FT//hBAojd1iLEITUfNXDIZZ0rZprJGape5
         3uVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJsx3lgv9ursSFWluqrAL2QvFQjhxRsrHPOQ90f9w5jQpRXWc43Dc5Wu/9Xhse1h5pmGDNpQtSnf8QeGM5@vger.kernel.org, AJvYcCWNQYCKisxjFFboo79FlPRQcsFdkMFroDinVaog5mJUE5okR3GIORP6Vggf7rX4FaOLxqKyYiyZ/r8q8g==@vger.kernel.org, AJvYcCXnGps7M2ygI5jgzxkJ7a9wQMZUm7j9dQzVdMc+xyK/FockgiP5kyE3mR/rQO/te+zQQeYD98wDy3W7@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgoByvLxOKMMitOkDg3cQh0VuYDYFRZZBYklVxh0T2yEmYi/C
	cQi7P1kiAbq7HsTAe3Vnk68kU9rTLCl70pAzCIXJLKgdylCnuiezhpOntphs2jrpbz8RRJGI/br
	JC5CCW9Ff2EgSwci0OrmO1LblWSc=
X-Gm-Gg: ASbGncsITRH0sNKZBYiCSoQOHbPysZgJw/N0AggQ/v4l4hcRz+Ey+HUmMgiSCjlUBGu
	TXAtWCpTjoTihAGqMYR06CB8bu5ZGEBtfSmi+6KJf9f+nItHVdmO5U3alARmgW+Na7dNGgzYFrf
	5gh5BKVqQhW06wbOUzBd323/vq
X-Google-Smtp-Source: AGHT+IG+BXrTALiy8ip+X07daV4bi+92ZdgkSR3MY/GK9RV0CTMTYQ+H6sJMufc7bShBSiA215YRly8Ku/rIZJVXZU8=
X-Received: by 2002:a17:907:3f0e:b0:ac8:1798:a796 with SMTP id
 a640c23a62f3a-ace84b27e18mr773066566b.54.1745823898815; Mon, 28 Apr 2025
 00:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745605382.git.Jonathan.Santos@analog.com> <c5a5376a6ffbb571d7874218494b04fd20015ee9.1745605382.git.Jonathan.Santos@analog.com>
In-Reply-To: <c5a5376a6ffbb571d7874218494b04fd20015ee9.1745605382.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 10:04:22 +0300
X-Gm-Features: ATxdqUHFAFmL9ZTtZPxBtKZFjukTHC9F3xQuY99Q83kaUvbAzsd5GjhbSlsQk3A
Message-ID: <CAHp75VdNymzseF7Dt9kL8GBPLM0MGBQg-YQabKUKxEryM8nxOQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com, 
	dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:14=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to SYNC_IN pin.

to the SYNC_IN

> Use trigger-sources property to enable device synchronization over SPI
> and multi-device synchronization, as an alternative to adi,sync-in-gpios
> property.

...

> +static int ad7768_send_sync_pulse(struct ad7768_state *st)
> +{
> +       if (st->en_spi_sync)
> +               return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x=
00);

> +       if (st->gpio_sync_in) {

Dup check, the following have already it.

> +               gpiod_set_value_cansleep(st->gpio_sync_in, 1);

Yes, I see the original code, but still the Q is why no delay. Perhaps
a comment explaining that the GPIO op is slow enough (?) to add.

> +               gpiod_set_value_cansleep(st->gpio_sync_in, 0);
> +       }
> +
> +       return 0;
> +}

...

> +static struct gpio_desc *ad7768_trigger_source_get_gpio(struct device *d=
ev,
> +                                                       struct fwnode_han=
dle *fwnode)
> +{
> +       const char *value;
> +       int ret;
> +
> +       ret =3D fwnode_property_read_string(fwnode, "compatible", &value)=
;
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       if (strcmp("gpio-trigger", value))
> +               return ERR_PTR(-EINVAL);

Reinvention of fwnode_device_is_compatible().

> +       return devm_fwnode_gpiod_get_index(dev, fwnode, NULL, 0,
> +                                          GPIOD_OUT_LOW, "sync-in");
> +}

...

> +static int ad7768_trigger_sources_get_sync(struct device *dev,
> +                                          struct ad7768_state *st)
> +{
> +       struct fwnode_reference_args args;
> +       struct fwnode_handle *fwnode =3D NULL;

Redundant assignment AFAICS.

> +       int ret;
> +
> +       /*
> +        * The AD7768-1 allows two primary methods for driving the SYNC_I=
N pin
> +        * to synchronize one or more devices:
> +        * 1. Using an external GPIO.
> +        * 2. Using a SPI command, where the SYNC_OUT pin generates a
> +        *    synchronization pulse that drives the SYNC_IN pin.
> +        */
> +       if (!device_property_present(dev, "trigger-sources")) {
> +               /*
> +                * In the absence of trigger-sources property, enable sel=
f
> +                * synchronization over SPI (SYNC_OUT).
> +                */
> +               st->en_spi_sync =3D true;
> +               return 0;
> +       }
> +
> +       ret =3D fwnode_property_get_reference_args(dev_fwnode(dev),

In this case the above is better to be also fwnode_property_present().
You save a double call to dev_fwnode().

> +                                                "trigger-sources",
> +                                                "#trigger-source-cells",
> +                                                0,
> +                                                AD7768_TRIGGER_SOURCE_SY=
NC_IDX,
> +                                                &args);
> +       if (ret)
> +               return ret;
> +
> +       fwnode =3D args.fwnode;
> +       /*
> +        * First, try getting the GPIO trigger source and fallback to
> +        * synchronization over SPI in case of failure.
> +        */
> +       st->gpio_sync_in =3D ad7768_trigger_source_get_gpio(dev, fwnode);
> +       if (IS_ERR(st->gpio_sync_in)) {
> +               /*
> +                * For this case, it requires one argument, which indicat=
es the
> +                * output pin referenced.
> +                */
> +               if (args.nargs < 1)
> +                       goto err_not_supp;
> +
> +               if (args.args[0] !=3D AD7768_TRIGGER_SOURCE_SYNC_OUT)
> +                       goto err_not_supp;
> +
> +               /*
> +                * Only self trigger is supported for now, i.e.,
> +                * external SYNC_OUT is not allowed.
> +                */
> +               if (fwnode->dev =3D=3D dev) {

?!?! What is this?!

For the reference:
https://elixir.bootlin.com/linux/v6.15-rc3/source/include/linux/fwnode.h#L5=
1

> +                       st->en_spi_sync =3D true;
> +                       goto out_put_node;
> +               }
> +
> +               goto err_not_supp;
> +       }
> +
> +       goto out_put_node;
> +
> +err_not_supp:
> +       ret =3D dev_err_probe(dev, -EOPNOTSUPP,
> +                           "Invalid synchronization trigger source");

Missing \n, and can be one line anyway (we don't complain about long
strings ending with string literals for ages, way before the 100
character limit).

> +out_put_node:
> +       fwnode_handle_put(args.fwnode);
> +       return ret;
> +}

--=20
With Best Regards,
Andy Shevchenko

