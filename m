Return-Path: <linux-iio+bounces-12519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846579D64DB
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FA616188D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BAE18593A;
	Fri, 22 Nov 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfNUTFx0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1315F40B;
	Fri, 22 Nov 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307182; cv=none; b=JZVS+F7d84h26eKQcIUeKk2j8BmQBJzIJUf6+FJeMHhnjdRffJljaiOynRk3tTlSC090poAE0SuaiX5iGr1FJaSnaac6pTVRToOsR/6HtdzjFeDsiKK30PjSo8Meo6RTgx7GGp/CS4TtNJy5y7k9Qig2A37L6VhcB7EM3+hxc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307182; c=relaxed/simple;
	bh=E6JvsfuOWkytg/BL08NLWlZySnogq/hNZzUST5r/6io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEPSlZz1/YQoTE/hGjdtMlQCyrIJTmQzRpPzOxRkAtJD5HgGOfHGPCtD008lJ2OuovRfuSzR1G0/Dkg2ymENaJ4CIk6AecK88oF38r6X4OvUxZE2XUEZ3DR1EphkvSNe9mxD39UKIxJux8C+WIU+9onWAzGdlRJfjG3REHphWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfNUTFx0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so134698066b.3;
        Fri, 22 Nov 2024 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307179; x=1732911979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6N793zfeIiA128rzFaW0HjuK8FkQ04wBcEMgsJfh9Y=;
        b=AfNUTFx02vrJfOXk3G6TLxC7byLuKdGDqs0U+7aIKRW5NhSIvNJ5CtOupxIFCb+F5n
         JZnYgq2uZKJ5mk/rER9ByuvluVNEnX8tNZZheOlE0aPgeYQaUXe+wt/I9Rgxj+n4Vb12
         cfsA9pr+3eTle90j8I3YGp/pVrYWJJeOaRigkw2d8Bl6WTdFJB7XbJkANRY4/Ax95d0y
         IAXUZPgVZ7TTyMrdXTcBnzxV+T6y51pnd1bpkKWhxiaLkUSPo3fRY64OSiOBZBCeSCNi
         ayVrGZy4BCQ+BhqneFVx/7lZmVwnMv5goOxWkAsFHaUJBUQML+nI7PGECvYVeU3GKF7v
         2s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307179; x=1732911979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6N793zfeIiA128rzFaW0HjuK8FkQ04wBcEMgsJfh9Y=;
        b=R6ydSEgC9vEfKhNkWN6mwgy5FHSy4rsuyo0e874W2HFLC6dlLYrT5hY4Cvuo+nWHc5
         OMXD3EJGV/8RxnApnmSfa6NVKwDRRc6z/MgbIoPrxXTQVsSY0ZmS7GHMP21+qgnT4f4d
         RvRbSLbqkzlRmf826qP+p2lSIzZfhcD/FaQTmcNzMM2UOq4tG1IY5ycoI9nn+1EpeC56
         9Ry79FH2+YOWadaMt8tZvazKjgj0eVYeur15Xtqe3xGDghaQvSx0M9fbTIw3aw1fZf0u
         QhjdlVdY1FQosPhKxFFneb596eXlPph2i5Tso2QRLm+WFifQ++0m80vOn07n+slSW95u
         u4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX61aNAWVsfatl4TPHtfByj/w8+Z9FnHAebCo7fAohFih/vRuETwR0hyFSmWOx7iIiqkqZKqk6jybTw@vger.kernel.org, AJvYcCXttuG6KbUXeKVQXh6sL/uGbTukAxJcVyvb/BJAKe0NncbvcUg7MeyxY2EtRsd4z78MlJkiCWd1mQYi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bWB+NeYnHvdcFv2/hIN/DNtFGvN+Kz2RVTw5PMkw02PCnlGj
	/6psTvZq/osHnTHx3rorqm9X4XBLzbthWm7l9OeR3J9zqdmZz+YTEJH+36r72ADCXm03G8sgLtE
	ObZUKoF8vMvIIuKHFrliHiCKLZN8=
X-Gm-Gg: ASbGncuRzVpaJDDBwLDbvDAl9k2jl8lKwkVUjgTYxsUBVSVC6q6fL3opDOx82U1pP25
	mEwp5fg//DTqSDdF1phdzfTtdLk47MYs=
X-Google-Smtp-Source: AGHT+IHNoLErVCnXFDgdXxpjT8Hxew2lejnSXOBqbPpbfeiwp1CBgaKlS8lgj8UOA07IbqTW+Z+quKbnMqhgQiIx19k=
X-Received: by 2002:a17:906:d511:b0:a9a:76d:e86c with SMTP id
 a640c23a62f3a-aa509d79295mr307958266b.49.1732307179582; Fri, 22 Nov 2024
 12:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com> <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Nov 2024 22:25:43 +0200
Message-ID: <CAHp75VfX7Rtx96mY8V_9M+m1y_zwuoz+VGcmoF75YTjoT9NF8g@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during probe
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> A driver that silently fails to probe is annoying and hard to debug. So
> add messages in the error paths of the probe function.

...

> +/* Only called during probe, so dev_err_probe() can be used */

It's a harmless comment, but I think dev_err_probe() name is good
enough to give such a hint.

...

> +/* Only called during probe, so dev_err_probe() can be used */

Ditto.

...

>         do {
>                 ret =3D ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readva=
l);
>                 if (ret < 0)
> -                       return ret;
> +                       return dev_err_probe(&st->sd.spi->dev, ret, "Erro=
r reading status register\n");
>
>                 if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
>                         return 0;

>                 usleep_range(100, 2000);

Side note 1: fsleep() ?

>         } while (--timeout);

Side note 2: maybe using read_poll_timeout() from iopoll.h makes this
better looking?

...

>  static int ad7124_check_chip_id(struct ad7124_state *st)

>         ret =3D ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
>         if (ret < 0)
> -               return ret;
> +               return dev_err_probe(&st->sd.spi->dev, ret,
> +                                    "Failure to read ID register\n");

Why not temporary for the struct device, will be the same LoCs now,
but might help in the future if more callers will need this parameter.

>
>         chip_id =3D AD7124_DEVICE_ID_GET(readval);
>         silicon_rev =3D AD7124_SILICON_REV_GET(readval);
>
> -       if (chip_id !=3D st->chip_info->chip_id) {
> -               dev_err(&st->sd.spi->dev,
> -                       "Chip ID mismatch: expected %u, got %u\n",
> -                       st->chip_info->chip_id, chip_id);
> -               return -ENODEV;
> -       }
> +       if (chip_id !=3D st->chip_info->chip_id)
> +               return dev_err_probe(&st->sd.spi->dev, -ENODEV,
> +                                    "Chip ID mismatch: expected %u, got =
%u\n",
> +                                    st->chip_info->chip_id, chip_id);
>
> -       if (silicon_rev =3D=3D 0) {
> -               dev_err(&st->sd.spi->dev,
> -                       "Silicon revision empty. Chip may not be present\=
n");
> -               return -ENODEV;
> -       }
> +       if (silicon_rev =3D=3D 0)
> +               return dev_err_probe(&st->sd.spi->dev, -ENODEV,
> +                                    "Silicon revision empty. Chip may no=
t be present\n");
>
>         return 0;
>  }

...

>         ret =3D ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_c=
ontrol);
>         if (ret < 0)
> -               return ret;
> +               return dev_err_probe(dev, ret, "Failed to setup CONTROL r=
egister\n");
>
>         return ret;

Side note 3: return 0;

...

>         ret =3D ad7124_soft_reset(st);
>         if (ret < 0)

> +               /* ad7124_soft_reset() already emitted an error message *=
/

To me it looks like an almost useless comment.

>                 return ret;
>
>         ret =3D ad7124_check_chip_id(st);
>         if (ret)
> +               /* ad7124_check_chip_id() already emitted an error messag=
e */
>                 return ret;
>
>         ret =3D ad7124_setup(st);
>         if (ret < 0)
> +               /* ad7124_setup() already emitted an error message */
>                 return ret;

Ditto.

--=20
With Best Regards,
Andy Shevchenko

