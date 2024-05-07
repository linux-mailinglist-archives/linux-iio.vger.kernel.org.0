Return-Path: <linux-iio+bounces-4867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514838BEEF2
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 23:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF7B2230D
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E575818;
	Tue,  7 May 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tlppkD/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D3745E4
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118214; cv=none; b=Yws946AFpXkKpdBe+lQk5/YZqVtdAyvzxSTmI/CV8en3fVfepP5VlKe65FjEoke6sKZlM5xr8s934E6j92rXJRMiUU6x7SrYnyqDBvvTr4dIOK5QFjcADmPJ3fMg7cQw7jUVvkthpkxMKqcOaHQflfaTj5Flu64wVLZesKiji/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118214; c=relaxed/simple;
	bh=mh2FEnFIN9JQ/UIdNq/amsZYL/uuVp0D7pjlXxLGvMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrcM3fMiT47XEZ4hODdrjUq+gxOB/M3RZy1e+Hk5ozG2ioQa6MM9yiD/+4rm4bFxGXM5OMDC7PR0d2PFC2L3RMfHQOYlHq/l8qcO/79lnCLmnRtRFz1H7APh2cBFvvOGd+CxRh2z5+4IcquN4o12u6YUJHY/0yaCeNPmenXfnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tlppkD/7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so21946391fa.0
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715118209; x=1715723009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyAEj4trsf106C373mKnquVnwuGp8XMYAfGirP9Fmts=;
        b=tlppkD/7mJRpV4xxgFqdN4UMSgnS2Ifm7ePqzyVq9GuCmWl8Y/zKtaP1+NWOlJz3o7
         LThltT1IcftMxoFquESwKfuMwkJaV5iJZLe/vwoNlS54NXIcglypc/w4Zk7XFkEwElOG
         pzWVmlOUzz/EQVttDe/uWvj+PMgNX/cpfiaW/H9/8qgXWIhHos23r6AYp/4C0V2bq8iO
         8do3Jhht8IkG6SSouG94nL4GBtYQVvn63cbe3PkYsmowhvr5ITC+PiDRAwmZ2EjJARIC
         RFazgr5xQuTuyf7gvHir6enzdylDQcKoETirggqhVFvM3eZh3Lbpj+Wy2NkpfMueL+Xd
         /Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118209; x=1715723009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyAEj4trsf106C373mKnquVnwuGp8XMYAfGirP9Fmts=;
        b=qVcxtaf9RjCGwSRBcCq0DamAsgEG5Nj1gFtQp2svhifM5yu0nt7sUIvRFWwCXZwIAd
         naI4N6uIVhIxDqcPOVWh76awHPUfDZ10tmk6IOb0JjfPbFwMhAHVpeHFZAZEb8tNw2uJ
         vTbPPuUlsNTwPBi1K9ywMWU5Jq4s+kxD9zP2SVli1MIyaMcerCS/An3X+QrzbqZd2VFA
         cTPTVUDxNBcUIX7zJ5jJxesuvl1jku1FP5SReyLdukmWcStHSyjX78BJkHF+xvBKv9Hm
         2f0yYfr/lR5s2mRQD5NN+6JdukToDsPrYw1bVunX/iVh2D8Rsyr14mSYckXqiisP+2aZ
         tZqA==
X-Gm-Message-State: AOJu0Yx+mFP23K9M8BQnRTfhnYdtww9Ya/XnfieYxyr+FaYEMu2BBVnW
	BXq3T/yfThNk9OuO+zLuC+aS94jqNwBQwMtCg3mA1QXUHpOlAUzGy0BkOt7PvuOnipgGeTu8Zjn
	nKGYTkS2rNLUBz5nIhsPnnu9yRjDfduznV4MtFA==
X-Google-Smtp-Source: AGHT+IFkTAeasJ7o/puO72sjy2GQ1su+mSjOHqpiHj0Xjj7kstnmpZh5piHYs40zLfMcP/mWwyF8g2epovPoK9zSR2A=
X-Received: by 2002:a2e:82cf:0:b0:2e0:3f37:5af1 with SMTP id
 38308e7fff4ca-2e4475a1420mr3964731fa.33.1715118209451; Tue, 07 May 2024
 14:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-dev-ad9467-dma-v1-1-e5c31b464e8f@analog.com>
In-Reply-To: <20240506-dev-ad9467-dma-v1-1-e5c31b464e8f@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 7 May 2024 16:43:18 -0500
Message-ID: <CAMknhBHf5f_z9iG89sfHOZ5F_q+Ho+zKDXA0M10U3BBMuSUh0w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad9467: use DMA safe buffer for spi
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:55=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Make sure we use a DMA safe buffer (IIO_DMA_MINALIGN) for all the spi
> transfers.
>
> Note that as we noe use a shared buffer, lock guards had to be added

s/noe/now

> accordingly.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 87 ++++++++++++++++++++++++------------------=
------
>  1 file changed, 44 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index e85b763b9ffcb..368546b032891 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -141,55 +141,55 @@ struct ad9467_state {
>         struct gpio_desc                *pwrdown_gpio;
>         /* ensure consistent state obtained on multiple related accesses =
*/
>         struct mutex                    lock;
> +       union {
> +               u8 buf[3];
> +               u8 tbuf[2];
> +               u8 rbuf[1];
> +       } __aligned(IIO_DMA_MINALIGN);
>  };
>
> -static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> +static int ad9467_spi_read(struct ad9467_state *st, unsigned int reg)
>  {
> -       unsigned char tbuf[2], rbuf[1];
>         int ret;
>
> -       tbuf[0] =3D 0x80 | (reg >> 8);
> -       tbuf[1] =3D reg & 0xFF;
> +       st->tbuf[0] =3D 0x80 | (reg >> 8);
> +       st->tbuf[1] =3D reg & 0xFF;
>
> -       ret =3D spi_write_then_read(spi,
> -                                 tbuf, ARRAY_SIZE(tbuf),
> -                                 rbuf, ARRAY_SIZE(rbuf));
> +       ret =3D spi_write_then_read(st->spi, st->tbuf, ARRAY_SIZE(st->tbu=
f),
> +                                 st->rbuf, ARRAY_SIZE(st->rbuf));

spi_write_then_read() copies the buffers, so technically we don't need
to change this one.

>
>         if (ret < 0)
>                 return ret;
>
> -       return rbuf[0];
> +       return st->rbuf[0];
>  }
>

