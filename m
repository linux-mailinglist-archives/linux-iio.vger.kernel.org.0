Return-Path: <linux-iio+bounces-690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAE807B23
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AB71F21958
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 22:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0025639F;
	Wed,  6 Dec 2023 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="REaAz1a/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A7ED5E
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 14:09:33 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so166681fa.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701900571; x=1702505371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPLi72DrwGpZS6X50iR/SynyhA4/ZwCwJLQ1wQu+AcM=;
        b=REaAz1a/SWQ4wAcDrusqu0lkUNcvp1Z0mJ/r7YuZDrNVe/VnhuWyBqQQBYwvHN8TVO
         /cBMnlYD+zM+YhT5lpVqZDlhloG0iiItwpkcloqXfyQTpHatSMq316eujEGpe09tDEw7
         stgHZa4cRms98Cp3R51Nk3yivB2rt1DfK/G6hLGd69n+0u8y8u554XhyD7i1cCHpS9EY
         IhWMnZU9loxhSSiGCmHpqjCtBR/680WoMJaI/b7ccI7Ii04o5iZyfTYgR1Vl72dYbPmM
         zYi8l4FoMI1E4pkIekwXwUjooCeSzIHh66d5mxJ6tHtHW1LkE5Dbkl/mAI2aMYi7RDVt
         EtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900571; x=1702505371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPLi72DrwGpZS6X50iR/SynyhA4/ZwCwJLQ1wQu+AcM=;
        b=vaY+0hZeU2v3lZFB93aEg3GPsdGH/IlXUweUaCYVqLpo1SjgTPoPFc8gNltyWOAZri
         hhYxa2odYw4FH9OmM5iN1sUgvsyVZcPqOX4op4euHr9In2KDefCZ71gyQaiHNQ2q685H
         OqwlUMpLu978NAAluOdadpKm3q0bBAXhEOv0u8fvLL375QWt4uyZaLXnlBRyyD/Us73z
         CodtbRUZrCHJbidiq4m1DPVJEjnsyKDlliSsLoepR6ixYFXPplN14yYy8Lixe2iaFmpw
         ZOzD2admmbtaLRwQ0pKpSyHuIxzuQtEg3syZrN0mYIXsj19+rElxatOBWIiBosqx9IiA
         2Sjg==
X-Gm-Message-State: AOJu0YxQMKykbC6DhKkszE91MqsAmn856VWcCJsVFa69OWWKhKG0uLLC
	BTWf8OMcnBa0TyDq2GhZMhuSSxgJKRQvyBD/GyGbBQ==
X-Google-Smtp-Source: AGHT+IHpcz20OhnYwTFzdJ3R6EIA8XydE/P9y2gqCkAG/L0mCgLqdduFWPuUMCVUWsijne23c+vvEGeiGboIkxGHaVc=
X-Received: by 2002:a2e:87d3:0:b0:2c9:e494:4673 with SMTP id
 v19-20020a2e87d3000000b002c9e4944673mr1017249ljj.78.1701900571250; Wed, 06
 Dec 2023 14:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-1-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-1-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 16:09:20 -0600
Message-ID: <CAMknhBEgk_o9TqV4E6EDtg3JS5V8fZUx5JgrfcD+eQxHcqffnA@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ad9467: fix reset gpio handling
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> The reset gpio was being requested with GPIOD_OUT_LOW which means, not
> asserted. Then it was being asserted but never de-asserted which means
> the devices was left in reset. Fix it by de-asserting the gpio.
>
> While at it, moved the handling to it's own function and dropped
> 'reset_gpio' from the 'struct ad9467_state' as we only need it during
> probe. On top of that, refactored things so that we now request the gpio
> asserted (i.e in reset) and then de-assert it. Also note that we now use
> gpiod_set_value_cansleep() instead of gpiod_direction_output() as we
> already request the pin as output.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 39eccc28debe..5ecf486bf5d1 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -121,7 +121,6 @@ struct ad9467_state {
>         unsigned int                    output_mode;
>
>         struct gpio_desc                *pwrdown_gpio;
> -       struct gpio_desc                *reset_gpio;
>  };
>
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -378,6 +377,23 @@ static int ad9467_preenable_setup(struct adi_axi_adc=
_conv *conv)
>         return ad9467_outputmode_set(st->spi, st->output_mode);
>  }
>
> +static int ad9467_reset(struct device *dev)
> +{
> +       struct gpio_desc *gpio;
> +
> +       gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(gpio))
> +               return PTR_ERR(gpio);
> +       if (!gpio)
> +               return 0;

same comment as before about replacing two ifs with one:

        if (IS_ERR_OR_NULL(gpio))
                return PTR_ERR_OR_ZERO(gpio);


> +
> +       fsleep(1);
> +       gpiod_set_value_cansleep(gpio, 0);
> +       fsleep(10 * USEC_PER_MSEC);
> +
> +       return 0;
> +}
> +
>  static int ad9467_probe(struct spi_device *spi)
>  {
>         const struct ad9467_chip_info *info;
> @@ -408,18 +424,9 @@ static int ad9467_probe(struct spi_device *spi)
>         if (IS_ERR(st->pwrdown_gpio))
>                 return PTR_ERR(st->pwrdown_gpio);
>
> -       st->reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
> -                                                GPIOD_OUT_LOW);
> -       if (IS_ERR(st->reset_gpio))
> -               return PTR_ERR(st->reset_gpio);
> -
> -       if (st->reset_gpio) {
> -               udelay(1);
> -               ret =3D gpiod_direction_output(st->reset_gpio, 1);
> -               if (ret)
> -                       return ret;
> -               mdelay(10);
> -       }
> +       ret =3D ad9467_reset(&spi->dev);
> +       if (ret)
> +               return ret;
>
>         conv->chip_info =3D &info->axi_adc_info;
>
>
> --
> 2.43.0
>
>

With the suggested change above:

Reviewed-by: David Lechner <dlechner@baylibre.com>

