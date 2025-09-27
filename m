Return-Path: <linux-iio+bounces-24494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930DBA613E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A783F3BB393
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C32E1F00;
	Sat, 27 Sep 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+h28he7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3582D4816;
	Sat, 27 Sep 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988504; cv=none; b=I+YuuyE34R5SS346GFyQXfxd6yeVkGUkE0BDPa1Yde0caZ/iAjOahCDr4/5ucee3c12z5lzoDz/sEw3cC0W0brTuJ7OoNYYqBZ3Uaex12dob4KdzxB3RAras7d4gWPXsXiTqMpG/MF1+mO02xtEPh1V2PhPp4TqX6S0JHCg+cDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988504; c=relaxed/simple;
	bh=tRYU9gXBqMmI1zon6Xla2H7/hd9DYtM8/t6hN3x9NVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLno2OyUTvg010X4Q3k+RZsukdoDCM3UMnUrv8JG9EtinEjHe5hPxgi/TLmCMpAfs5jcWkgHEFe4SN1I2pc0rir2ayhm1XX9z5AT5tMMO7NHqu2vk1afKHj9egJFLLDO8emiIDv3gUtOdD0e6BO8fI5OqV9YnftJl9isDpzrfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+h28he7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3912C4CEE7;
	Sat, 27 Sep 2025 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758988504;
	bh=tRYU9gXBqMmI1zon6Xla2H7/hd9DYtM8/t6hN3x9NVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+h28he71P5Quv2/v38iVz7pPJXl/hNMpb2u8KAbHzzKXXkak/DgDMe+MWvOH1p1P
	 cRFvxexxX1fJl6v2oZvxxvUDhzITQj38G83bIySl3S3Qi7lXaZVMuLKqSVP7i9+U9Z
	 h16o/6yTdNBRqgazn37OT3vwVeGaXklp/1KN4csj/HvgMykwfolNIttB/l35f7qoHu
	 ukWhYABzrr2qr8jROmjZgLWnT7rVC6rX+L/SIL7M5OOUqAMjKGTS9twiHJf8Xa21CT
	 m9WLNuhH1hhZoLTP/yt/j3+xemw6rFHtA09IfzYak3yjuYy4TGjYC1cAmeynfr3T08
	 BcMPEqJqEvyWA==
Date: Sat, 27 Sep 2025 16:54:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Angelo Dureghello
 <adureghello@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: fix SPI offload trigger rate
Message-ID: <20250927165455.19ebefd5@jic23-huawei>
In-Reply-To: <20250919-iio-adc-ad7380-fix-sampling-frequency-for-single-ended-chips-v1-1-7b2d761766cf@baylibre.com>
References: <20250919-iio-adc-ad7380-fix-sampling-frequency-for-single-ended-chips-v1-1-7b2d761766cf@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 15:50:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a special case to double the SPI offload trigger rate when all
> channels of a single-ended chip are enabled in a buffered read.
> 
> The single-ended chips in the AD738x family can only do simultaneous
> sampling of half their channels and have a multiplexer to allow reading
> the other half. To comply with the IIO definition of sampling_frequency,
> we need to trigger twice as often when the sequencer is enabled to so
> that both banks can be read in a single sample period.
> 
> Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to my temporary fixes branch (always fun at this point in cycle).
It'll become the normal fixes branch after rc1.

J
> ---
> There was some unresolved discussion about this when we were adding
> SPI offload support to the ad7380 driver, but it turns out that handling
> the sampling frequency correctly for single-ended chips is actually
> quite simple.
> ---
>  drivers/iio/adc/ad7380.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index fa251dc1aae6ab0a0d36792fa37b2cc22b99dfe6..bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1227,6 +1227,14 @@ static int ad7380_offload_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * When the sequencer is required to read all channels, we need to
> +	 * trigger twice per sample period in order to read one complete set
> +	 * of samples.
> +	 */
> +	if (st->seq)
> +		config.periodic.frequency_hz *= 2;
> +
>  	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
>  	if (ret)
>  		spi_unoptimize_message(&st->offload_msg);
> 
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250919-iio-adc-ad7380-fix-sampling-frequency-for-single-ended-chips-05bbfea8891c
> 
> Best regards,


