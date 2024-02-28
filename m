Return-Path: <linux-iio+bounces-3188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1A86B97C
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 21:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C4028C0DA
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 20:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242B8624E;
	Wed, 28 Feb 2024 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YDLSFNYe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE58624C
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153872; cv=none; b=uNk0mI+YAhSR3IaYTKRXaqG2lNeHSY9LCdVJILk/AL423aqkMLfV1SPv6Zar6SoPn2VSB//hB6607snir77LDVx4nk1W5UeIozNhv5zd8ppJv9gSi7bYVScqJakLaGeIH+lYUOHxGuSq1Z2VA1zGIsEGgC+f890wjVHK/ODclb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153872; c=relaxed/simple;
	bh=BWK+pvcfV2O3YEKV4oJw3LGLSCHFNN4QIpIDXt2sN9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ89/M5ro5SrHg1p5GdvBcLzsRFHNMuIB/sSXpjRtUnVgd1+RYQ86LCKxVHECg2qSeL/zpk6jEk6hmHhon00XljClcCIQG2RsRy+S0JPrOhKDRdRKsVDov87kKxPl7gzqmnEdviAU6fou6NzSRWx7g9PASOKon1x47DE+pW7mcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YDLSFNYe; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d28464c554so1929081fa.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709153868; x=1709758668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e4AfvVPSrhK1drWl8zME51ZTsz4Zd61RouuRi/BwYE=;
        b=YDLSFNYeZ2o8Li6YIKeBGjjEV1kXv9SKeZuDq5S5eAVipbpetuMbCWEnCtG+QHk7mN
         rjY+6cFF2NjPLzUuFxwszsvVtrAcdzCT2/gUE/xhEzsQT7Bo0zaMFSjaZas3fmJg3cdP
         3nlzYqqg8fMvvTrkkCdiRdZKwuIYnveoqAiEr+FVRccHeNYbVZNot0ZxL34JlLIM/+LC
         pcNy1g4BmM4j874sUSAVYSaXaiKNAQ9WVu1u6RhJ37XdusAslPOq+fxYEbnLQs23J7wt
         tI4a8VRHDWgmuA2SIEdEkEuyUtcclgoCMkE0WBAdzDvphKUGu2TGbjerOvXbBUFpmDtU
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153868; x=1709758668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e4AfvVPSrhK1drWl8zME51ZTsz4Zd61RouuRi/BwYE=;
        b=OEy3HAxJuKSD3pTSncwGJcnb409iOxBqyuWdTJXH2A2vie+PP3I1ERbhjoeAHPZMd6
         OPOCSWwuQkjlSeyXIo6MA7tBxM4a8eYJq590Tz0CufiBRGR0hfIJpcBXssoJ2N60+8v/
         aYK2T9hSIAETurcd9LES7Y7TIWMjqzh777vxLunpg9wPOCVZI7LnQ0xz7P761/tSvq/c
         jwvdsIEH6E3MUmWo0nKYdDw6rEYqloN/L+EpJg3LEiy5Gz/G9j1D7/qBtMRVM8zCC6O2
         JISNUc83qtgOptLKIo7JmX3dAkGP1hwJU6obaIl8dujLTwkNNlSg0v6h301KdMIRlPEl
         /Iyg==
X-Forwarded-Encrypted: i=1; AJvYcCXZwx1q/U29hdQHX8VP1MR8W17hmU74r80PILQxDy/fvjAgXAiRbvB1dPK3DAhPx1I+EJXSGnWwVCeKKyOCNX/VbITijZZ0qWCq
X-Gm-Message-State: AOJu0YyPcjDPj0GSNbPRjGO0gdcYcuqhrbskGM2F402mrjzGf7s8+dUB
	+Yuyj3BpgE/XL0fzSrROIRBxqRX4RqaSsI1eUrGTHFww9KkH0rXoQK0BbEJtkaewMnrw0Xdazl/
	SGHu9/RUM0WrhRmKZejStNjZxO+sGDdRtlfbjrg==
X-Google-Smtp-Source: AGHT+IEOnOOyvWjN2Iqi7AnFbpftsb9Ykrl/ECUJUwlscNtR6jsb4MdUfMY/fGs0PnTtZQ7ONz+3NPiATH7jgCyTqPQ=
X-Received: by 2002:a05:651c:14a:b0:2d2:b452:3adf with SMTP id
 c10-20020a05651c014a00b002d2b4523adfmr24174ljd.27.1709153868001; Wed, 28 Feb
 2024 12:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 14:57:36 -0600
Message-ID: <CAMknhBGj_+hw0F-g3R6iY0HEooGH1a8gfj1hYx_Laj93OQbQwQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] iio: core: Calculate alloc_size only once in iio_device_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> No need to rewrite the value, instead use 'else' branch.
> This will also help further refactoring the code later on.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/industrialio-core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index bd305fa87093..1986b3386307 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *p=
arent, int sizeof_priv)
>         struct iio_dev *indio_dev;
>         size_t alloc_size;
>
> -       alloc_size =3D sizeof(struct iio_dev_opaque);
> -       if (sizeof_priv) {
> -               alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN);
> -               alloc_size +=3D sizeof_priv;
> -       }
> +       if (sizeof_priv)
> +               alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN) + size=
of_priv;

Isn't this using alloc_size before it is assigned? Perhaps you meant this:

    alloc_size =3D ALIGN(sizeof(struct iio_dev_opaque),
IIO_DMA_MINALIGN) + sizeof_priv;


> +       else
> +               alloc_size =3D sizeof(struct iio_dev_opaque);
>
>         iio_dev_opaque =3D kzalloc(alloc_size, GFP_KERNEL);
>         if (!iio_dev_opaque)

