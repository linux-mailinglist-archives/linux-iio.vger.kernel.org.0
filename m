Return-Path: <linux-iio+bounces-692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C33807B52
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDC81F211C6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E5563B4;
	Wed,  6 Dec 2023 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lF2WaoMw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE312F
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 14:27:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca09601127so327761fa.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 14:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701901663; x=1702506463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3gXWUTICTWzGftkSkqdceIG5gsc9+Hsyqc6DgtE138=;
        b=lF2WaoMwNZCxWLmilJR0gB04viil9kzZge3777A3LStABwTWBsXsb6QJfkxIcLi+yy
         JxNKUSJVAn6NvIMp19XrOKCejAiZdwZq0zyQbBP6u7eXyFZttRIWyYfRjBMPMGvA8ss+
         U0p1dBrreq0G7Xvf1DEQnxbuSurjaoFSp81k5a61gJeqD6dxoYKGAssU9gHvM57LsJMg
         hIof64paNcVyO+ooU2N0GBTkHWMkwX8CXD4ZLOLkPoek1kzOfqCqbmH/oo9mXN4hW9TP
         LYk4cK+hnQzC7+jYHdunftUCF7g46Y+LW5e7sy1PTXTlhKfpxttxZfA0fVzqLbBTia28
         oqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901663; x=1702506463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3gXWUTICTWzGftkSkqdceIG5gsc9+Hsyqc6DgtE138=;
        b=wyinLLfmJ5Bq3WEm3wNedxO/oGNN7+hykLq4aQGu4ImAyFm8iy6fYgviubEtYnhCrg
         bXisib71UnPlw7lXliq0EpRVS6YMKUzY9bsGDGUzMc27liqajlTtQHbAIefn1oregCry
         ScNaCRR4aA5s3jD3Ee9NLRUdZR0lgRdQio4fqUUoE5uImGDZul6yLiwJWjoMIYOt/yxF
         gX0xQ3844BPwJBavi1ZlXkkae0gfVq+2QTmvf2PFf8c8lUexTYsdfjlS7bslotUlIGHa
         LQXyE5f1R6OHWRfe+qvfvcMEPmBaxxpEz9p1ZKdU11KT7h5aWRJh12PEnxI+Dl5YvpRz
         CLyw==
X-Gm-Message-State: AOJu0Yy5o9cddzxfRf977vEuede+mjyhZ1hSc0b9iICKFbGVoul0KR42
	PqNiOlPFCSwq5InUxlrqSImMKmSYB/Lclo6tM+ao9wmJHMia5XIna0g=
X-Google-Smtp-Source: AGHT+IGgk96p7Y57ol11hJxJJNjo6OoqjBDnVQFCZ3x5KyGtrpHw5QWQvHBfPsu4Wg41ltVcVxxynkxcd4mJuXwzt8Q=
X-Received: by 2002:a2e:7a15:0:b0:2ca:1d16:8c23 with SMTP id
 v21-20020a2e7a15000000b002ca1d168c23mr994264ljc.67.1701901663018; Wed, 06 Dec
 2023 14:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-3-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-3-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 16:27:32 -0600
Message-ID: <CAMknhBEEqnTRQBLzeXuNSLzSgZB=x_jASSWVZDjpo3YVS5wq3A@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: adc: ad9467: add mutex to struct ad9467_state
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
> When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> are done which means we need to properly protect the whole operation so
> we are sure we will be in a sane state if two concurrent calls occur.


ad9467_outputmode_set() also has multiple calls to ad9467_spi_write().
Does it need similar protection?

>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 0f2dce730a0a..badbef2ce9f8 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -4,8 +4,9 @@
>   *
>   * Copyright 2012-2020 Analog Devices Inc.
>   */
> -
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -121,6 +122,8 @@ struct ad9467_state {
>         unsigned int                    output_mode;
>
>         struct gpio_desc                *pwrdown_gpio;
> +       /* ensure consistent state obtained on multiple related accesses =
*/
> +       struct mutex                    lock;
>  };
>
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -161,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv =
*conv, unsigned int reg,
>         int ret;
>
>         if (readval =3D=3D NULL) {
> +               guard(mutex)(&st->lock);
>                 ret =3D ad9467_spi_write(spi, reg, writeval);
>                 if (ret)
>                         return ret;
> @@ -310,6 +314,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *=
conv, int val, int val2)
>                 if (scale_val[0] !=3D val || scale_val[1] !=3D val2)
>                         continue;
>
> +               guard(mutex)(&st->lock);

Why is the guard inside of the for loop instead of outside?

__ad9467_get_scale() called in this loop calls ad9467_spi_read() too,
but since this is not a read-modify-write, I guess I can see why that
might not be inside of the gurad.

>                 ret =3D ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
>                                        info->scale_table[i][1]);
>                 if (ret < 0)
>
> --
> 2.43.0
>
>

