Return-Path: <linux-iio+bounces-27410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A8CE64FB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A834230081BE
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F728135D;
	Mon, 29 Dec 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpwtjptd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D406252900
	for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001230; cv=none; b=omP7v+YCWb+TlI9cB+jQ8Mh8+BEtj31z+3SxiFOLFe7WjIznZbcIxLFQ5T7QwmjPP2Q9uvy8U9ckDY4nMmYva2LelgGZ/4szoJxBIZfXf6m8xiF5AXltVa7gnQVbCAKXawVtywy6y8dX7E7UQfGaPKPsmjD+eUmJcIk8cl6Hz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001230; c=relaxed/simple;
	bh=WnJ2tC4zepAuYUdnYjJVNb6K4dEj4f7sCT4B+Rwp7bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX+uYTfFSIISDxJUwaU+gVaNoukjCfavTPY5GognUn+KdFacpqFtfQHZIomKJsmIKfB4Fhn18Bvkt/s5MGEiOE2TY400rnZ2ebWR7d2JkMzwSgvYy00w8XQVnHqq+RWlKKGUviWv6fke68kM68LKePQLWGFBdjI6MhrlNu6Fr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpwtjptd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b728a43e410so1676046966b.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767001227; x=1767606027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIiSQ+H4iozlL1RZCBDSnCB5yNmXDQlTJYU7HFVKRIA=;
        b=GpwtjptdlnY9m9B51e7YR6fpVRodCfgZtoYdEGds8KBvwBpic4ViyoPV9VYFvGKK0n
         RH+QXo3k/3MPNyk8uvjmxxA339iFl0g7hMwpoUemJibiU4rSknVUt7noLcyTyFZ5iGGn
         rKQPVQkdH5a57jhmos/0kCckxDSfFoFkhwKW9rfTGNf0LPEcSvbBCHbAzo2xwFyA/a4M
         xw9cBf30lQ5Skf/QrXL5jxgl0mESz+scC3uTQXUeeQiq3B/YAcjJ0bEiKGieWNweTkTW
         UBLPeK0eUME4sm/0t6YGLEYoJgCK5B04VozxFa+t0JlCswWqOFQcajavITCnXtyUzQDH
         HsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001227; x=1767606027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sIiSQ+H4iozlL1RZCBDSnCB5yNmXDQlTJYU7HFVKRIA=;
        b=Pt66BCBp0QgU7AgQBhbFFtG6bjCcTRmfP6TS1smgDcrMFrQWSonCnER8pjLimmhxLN
         mUwbAaktG+HbgAn/Nl8H8HwNDrotXhh3smR0YtR/vHfjMe19TO8YKgB5iIVquCGJBIme
         xxUoRKKmeIUnUXSJjEaW3YvZX+J8W+4VQMLM67/IArdbkpYrHbIMB2C2SI1m5yMi2T8Y
         ekNYrkarT3GmbkxOCw+eZNTyLnnTh4uYd+Do3hTPIjmrg2Vdz1Q0Pg8KJa3QwCTzZaBx
         p3voT+CiBsxqsGgX8bbJMROH70+zfloVxzupVEGBYGCbKIDC6MasE37u36v9Vzt1eXlS
         cg9g==
X-Forwarded-Encrypted: i=1; AJvYcCUZvvq7fAEQ3eiEDEvtxCb+X9tRQY+aHhFdx4gkx79xvMfCrqq5wR6ARv5ypo+EzJZzbLtWm0yqTjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ONwOSQElgk/ApWg23CBocQf35R3BRin1CdvC4n+qLTuUCfod
	y1yOSHp7WWvoFtV5suLp80Y1gfx619ISJkqVJt1/3mchEW25mVOZdFJXe/gpKyiz69rEQPeTRMD
	9wf5yhybY2x5/jSQ0q9R3Xcbj5mvamdI=
X-Gm-Gg: AY/fxX6DppgjtGTQYD0OWnXSUGYonn/Xuckd43SnWljOjCpaHvScs+eGnJXUSoT8/UF
	QY1wxiGPWYoDQWmVbOwWOgQkMROhlQHe75LNVifZDmcem5kAcXxecCUSj+22gw1iyTqdu5d8BXf
	WKpoJKxk5WE3JkXKDve39Ajg3AS2TLixYtf9vn9LBcKFMvaYfd4rkpw0sMJgpamstrYE28di4XC
	m2m/FyhdRpbh0Jk4KqVD6IFSLCnSCUuLcSJ/SQ/ykDVqJfyHLmDmpsDM3ri7UsOCS3jaWzqLC0M
	GqewejCzM2CbkX8St+7Zb+w4m905IVD2SsuuUsIzHl+8eTOwje4zAQEXnK+1RdgVeZudlcQ=
X-Google-Smtp-Source: AGHT+IF+DgFNPkINf3LkL7IgAP5Ss98RBe1Y/rMetdZObpY5qXdwT+IPbDR+z8ZQU1FR4VUuazyt9Qi1KWf67/a6B60=
X-Received: by 2002:a17:906:c154:b0:b72:5e2c:9e97 with SMTP id
 a640c23a62f3a-b8037051e8cmr3016256966b.36.1767001227274; Mon, 29 Dec 2025
 01:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com> <20251223155534.220504-3-maxime.chevallier@bootlin.com>
In-Reply-To: <20251223155534.220504-3-maxime.chevallier@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 29 Dec 2025 11:39:51 +0200
X-Gm-Features: AQt7F2ow0LXkeOk1f5InDRvxm9TqnTni9CKevOTaW_8CqwwHCYej-mmXag9PBLs
Message-ID: <CAHp75VdtPnDABykge4z2=74zPhGQbfZkiQR30QPvyam4eYE83Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528 adc
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello <adureghello@baylibre.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Eason Yang <j2anfernee@gmail.com>, 
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz, 
	herve.codina@bootlin.com, Rodolfo Giometti <giometti@enneenne.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 5:55=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.
>
> Add a very simple driver for it, allowing reading raw values for each
> channel.

...

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/consumer.h>

Follow IWYU. Here are missing headers, such as bits.h, mutex.h, types.h.

...

> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D tla2528->vref_uv / 1000;

(MICRO/MILLI) ?

> +               *val2 =3D 12;
> +
> +               return IIO_VAL_FRACTIONAL_LOG2;



> +       tla2528->vref_uv =3D devm_regulator_get_enable_read_voltage(&clie=
nt->dev,
> +                                                                 "vref")=
;

With

  struct device *dev =3D &client->dev;

at the top of the function this will be one line and others also can
be shortened.

> +       if (tla2528->vref_uv < 0)
> +               return tla2528->vref_uv;

...

> +       /* Set all inputs as analog */
> +       ret =3D tla2528_write_reg(tla2528->client, TLA2528_PIN_CFG_ADR, 0=
x00);

Why not simply use the "client"?

> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D tla2528_write_reg(tla2528->client, TLA2528_DATA_CFG_ADR,
> +                               TLA2528_DATA_CFG_APPEND_STATUS);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Set manual mode */
> +       ret =3D tla2528_write_reg(tla2528->client, TLA2528_SEQUENCE_CFG_A=
DR, 0x00);
> +       if (ret < 0)
> +               return ret;

Ditto.

...

> +static const struct i2c_device_id tla2528_id[] =3D {
> +       { "tla2528", 0 },

No ', 0' part.

> +       { }
> +};

...

> +static const struct of_device_id tla2528_of_match[] =3D {
> +       { .compatible =3D "ti,tla2528", },

No inner comma.

> +       {  },

No trailing comma.

> +};

--=20
With Best Regards,
Andy Shevchenko

