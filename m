Return-Path: <linux-iio+bounces-13749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70939FA785
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77FD1886FDE
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F6188CC9;
	Sun, 22 Dec 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyqPxXXr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056512B17C;
	Sun, 22 Dec 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734890843; cv=none; b=PWlt2JjpWS88PUXVZ1Nm3a4MeeY46BGa/fnhaBwOvBS+oF0UbUUtbt9HOa1Ag/dO2ri6IBYjfzbJQz2NZBLsW6v8ypAJrzBiVgo3GlunfWAzc/r3SYeQSqlarff9CNrV3iVSeZ4EVzeyK0e/DI6S99Fp+bjhjIujGIdyd9oShm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734890843; c=relaxed/simple;
	bh=L9kFGUCLB2E6GEnN77Qe+tRgv/r9Esyhg+Wv1RGtX+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ja7Wzsy6fGNUQBdfSJY7fN7hznIHd5wLwZH5ZmGsr0IoQgiDZlJMHWQV/4YqV4iuAITRNoLOdDcz1DKPYF8qoBzVDCs68wvfLUKk7YFlccxzzVwWxR/qoJSX/EKcuW2jqIbO+VcVb1CP9ZO0i+msD7fANWkkJZwQX/m4DhonSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyqPxXXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902AAC4CECD;
	Sun, 22 Dec 2024 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734890842;
	bh=L9kFGUCLB2E6GEnN77Qe+tRgv/r9Esyhg+Wv1RGtX+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kyqPxXXrmrlaskEN4gV/sn85d+cg0NpYM7X3DdJOir81BqA24ayRCSVWmPsJ1g9sH
	 YocszyRMLOZJSMLT/kWtWrfFcu31OvIyQzoy1iSWrxcO3LWeaj1OSvDcOeMnVlzMhB
	 oOsSOTDw+WxFeLlxiwhtd3Siy9A+pmYYNqtfAZtkXaRhfLfQR9kumN09CZkXoygmyB
	 ynxr6chXxU9R7E/TObtiyzwCOy6DsL6Z0joGp17LVudH7h3OwQHJrUecI5ddxbdDTl
	 3X+IzkcizuGcvT976smNFe+3ihjqoLWVN9Bbyu8ZwjGypKevMiOqFaCIu1cvVCr4bp
	 e3IZwsMK2UM5Q==
Date: Sun, 22 Dec 2024 18:07:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] iio: adc: ad_sigma_delta: Add CS assert function
Message-ID: <20241222180713.64f27040@jic23-huawei>
In-Reply-To: <20241221155926.81954-2-alisa.roman@analog.com>
References: <20241221155926.81954-1-alisa.roman@analog.com>
	<20241221155926.81954-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 17:56:00 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Some sigma-delta ADCs, such as AD7191 and AD7780, have no registers and
> start conversion when CS is asserted. Add helper function to support
> this use case by allowing devices to assert CS without performing
> register operations.
Hi Alisa-Dariana,

I had a look at the ad7191 datasheet. Given this description,
I was expecting to see it do a pre pulse of the chip select to trigger
the acquisition.  However, what I see is a power down line (which is more
or less a chip select) but it just has a specified t1 delay before the
DOUT will change to the state for the first bit and the host
can start driving the clock.

That can be done by setting spi_device->cs_setup to whatever delay is
needed.  The text is spi_device docs are a little vague,
but I'd take it as t1 + t2 (maybe t3 to be safe).

That is going to be more reliable than trying to hold the cs across
messages / spi_sync() calls, particularly if the bus might not be
locked (which the code below suggests).

Jonathan


> 
> This function can be used by drivers through their set_mode callback.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 24 ++++++++++++++++++++++++
>  include/linux/iio/adc/ad_sigma_delta.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 0f355dac7813..c0f33d4baddf 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -48,6 +48,30 @@ void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm)
>  }
>  EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, "IIO_AD_SIGMA_DELTA");
>  
> +/**
> + * ad_sd_assert_cs() - Assert chip select line
> + *
> + * @sigma_delta: The sigma delta device
> + *
> + * Returns 0 on success, an error code otherwise.
> + **/
> +int ad_sd_assert_cs(struct ad_sigma_delta *sigma_delta)
> +{
> +	struct spi_transfer t = {
> +		.len = 0,
> +		.cs_change = sigma_delta->keep_cs_asserted,
> +	};
> +	struct spi_message m;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);
> +
> +	if (sigma_delta->bus_locked)
> +		return spi_sync_locked(sigma_delta->spi, &m);
> +	return spi_sync(sigma_delta->spi, &m);
> +}
> +EXPORT_SYMBOL_NS_GPL(ad_sd_assert_cs, IIO_AD_SIGMA_DELTA);
> +
>  /**
>   * ad_sd_write_reg() - Write a register
>   *
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 417073c52380..99ab56d04793 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -178,6 +178,7 @@ static inline int ad_sigma_delta_postprocess_sample(struct ad_sigma_delta *sd,
>  }
>  
>  void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm);
> +int ad_sd_assert_cs(struct ad_sigma_delta *sigma_delta);
>  int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  	unsigned int size, unsigned int val);
>  int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,


