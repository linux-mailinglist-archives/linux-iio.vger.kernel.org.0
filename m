Return-Path: <linux-iio+bounces-27610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B75D0EF53
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 275CC300F5A0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033133C50F;
	Sun, 11 Jan 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip/e2mh1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5033122E;
	Sun, 11 Jan 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137296; cv=none; b=a4LUZYbXjU1KLLNTEm4nia9/5uwGkHxE0hj4LbXXZz61gwxOrwGNgdNw+gKjcDHiLIJWBR5OgwXDSNKX6OuhDzTv+yh+iMP+kTmARXDn5dq1dElP3oKQFnnOl+J4A85NHI9r0w9hLb9sVNIbWteK3sVMkuaO/EtiTo2FBGVKOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137296; c=relaxed/simple;
	bh=MA7WclqKrs/0+T7D2D8fju/Y19IeEHKbYArPN0tiMQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPYY2iKdhkZjgUZA+Mo+Bb3NsDsV0Ut1xMOsx96HT/JTmUYomiNMXqqFlT/o8DHYSEAe4y34nK2gL8wbmErMhkmuwQFMOjAgIqqcRJOsO55Nm0ZhQ2IH5ZUwiH3NXXS/lsgD0pY7TJsS5qnmRRdL8nvvg9Qo4oJon6cQRGmfnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip/e2mh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B0C4CEF7;
	Sun, 11 Jan 2026 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768137296;
	bh=MA7WclqKrs/0+T7D2D8fju/Y19IeEHKbYArPN0tiMQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ip/e2mh1lzFozUogLYa6yVqGXcfGYXBoa5Z5N2LB56bCuKFuyHsYhaNWWCnFnGawM
	 0RSksRTT3dKzzpMwMJKB0+0ePBKAHdxyMUgSaRsnTufzpD6A6ZVDgeyF3NMcr7oUwZ
	 DKz+aDM90mZu9QmHdC9UExaWLDocFaogQDD9bcgbkXNIiTbp/IcFEhTl1OZVmLnfuH
	 tdDjPwDTvHrPkhMQr/6Q4vsCgaFqyRbIR49cbfxF5fCoCcwnZQHzXID7iaANhn4jNS
	 sjMyxVbdHer3Ef+qYKFAVuLdVVYaTF7xj0y1KVqBj80PgSoIkJwwVC+TWoiwAorlXy
	 6VY6Ll6nSvxUA==
Date: Sun, 11 Jan 2026 13:14:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: adxl380: Optimize reading of FIFO
 entries in interrupt handler
Message-ID: <20260111131435.6460d968@jic23-huawei>
In-Reply-To: <20260106193627.3989930-3-flavra@baylibre.com>
References: <20260106193627.3989930-1-flavra@baylibre.com>
	<20260106193627.3989930-3-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 20:36:27 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In order to minimize the time required for transferring FIFO data from the
> sensor to the host machine, perform the read from the FIFO in a single call
> to regmap_bulk_read().
> This allows reading acceleration data for all 3 axes at 16 kHz
> sampling frequency using a 1MHz I2C bus frequency.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/accel/adxl380.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 9f6c0e02575a..ce3643c5deb8 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -950,14 +950,12 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
>  		return IRQ_HANDLED;
>  
>  	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
> -	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> -		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
> -					&st->fifo_buf[i],
> -					2 * st->fifo_set_size);
> -		if (ret)
> -			return IRQ_HANDLED;
> +	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
> +				&st->fifo_buf, 2 * fifo_entries);

Whilst we are here can we replace that 2 with sizeof(*st->fifo_buf)?

Otherwise, Antoniu, can you take a look at these change.
Seem reasonable to me.  Given we are fairly late in the cycle I'll
probably merge them both for the next merge window and we'll have
to wait until after that for the fix to make it to stable.

Jonathan


> +	if (ret)
> +		return IRQ_HANDLED;
> +	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
>  		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> -	}
>  
>  	return IRQ_HANDLED;
>  }


