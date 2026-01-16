Return-Path: <linux-iio+bounces-27883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D9D38639
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C6EE301EFE4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E3B3939A4;
	Fri, 16 Jan 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tczLMmrH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346B33986D;
	Fri, 16 Jan 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592997; cv=none; b=O6C5yncsZhB95vycG2ORTkDUp70GxZBG8mL719UDzZNErihQjkZE83gsBymPsUVwatoo1c8RBwBXzGbKe87YHBxhzwBsBlEbp35WQwiGtMTEAr7yaqX9UCj65bv1Bn8ln/ZA2VYW/2U5XJuO052BTwrau2ZDSadUCGalSSVOAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592997; c=relaxed/simple;
	bh=/XegAy4XAf205nJWs9wRyRqB0yg4+ui/YIB4W8fekBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghg6RRIDfbgfcHrC1K2CRUf48fxPETQs5DyLPlX4UfyzLpE9lXW9vycixkRr9Pq4AO+VlCN+fJ1ksybKeZ1cqNtqYSBbCi5O8siyytTQnO62uRVqWUPxeTFsxJzvM6s7w4kXmUrDBQUJzxFTFmvwvbIvJ0a6hqWprGAsOPW/RH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tczLMmrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34711C116C6;
	Fri, 16 Jan 2026 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768592997;
	bh=/XegAy4XAf205nJWs9wRyRqB0yg4+ui/YIB4W8fekBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tczLMmrH54rgkLK/xdm/Lo65QRGJ60yrpm/El9Qj3nl1gNDtmBhd4KH1oUU9cNo8w
	 LSjWmBQe6UoOX6G56s0C5OH8ui7UmE2LCFQoNKkVvjvvcba4RJXcPWhK94ywGkTZsJ
	 2UDlulyDl6OHlFdL4Fwmny5SDLMXvdg+RCYXTZJS00/r/pxXIPdPw25xHkI9BCduy8
	 okQbKszIZgq7oCVE8L1Mo4zGL3c9vJ7gydVCN8JDD0q06Z1P3+IEfa+vzM/UKoWDWD
	 b1EQyMuVsz2MMh8TGgMbEpvJnFBxPkMKhHtqa/40dbndbG169xLo7PRDkENV4RrXur
	 QYGG1LCpHlU0w==
Date: Fri, 16 Jan 2026 19:49:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: imu: st_lsm6dsx: Set buffer sampling
 frequency for accelerometer only
Message-ID: <20260116194949.06b7b204@jic23-huawei>
In-Reply-To: <20260115122431.1014630-3-flavra@baylibre.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
	<20260115122431.1014630-3-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 13:24:30 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
> writes the buffer sampling frequency sysfs attribute, calls
> st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> `sensor->id`; since this array is only 2 entries long, an access for any
> sensor type other than accelerometer or gyroscope is an out-of-bounds
> access.
> 
> To prevent userspace from triggering an out-of-bounds array access, and to
> support the only use case for which FIFO sampling frequency values
> different from the sensor sampling frequency may be needed (which is for
> keeping FIFO data rate low while sampling acceleration data at high rates
> for accurate event detection), do not create the buffer sampling frequency
> attribute for sensor types other than the accelerometer.

If we are going to do this, I'd like a little more discussion of why this
matters for accelerometer events and not gyroscope ones.
(see follow up on v1 discussion I posted earlier today).

Thanks,

Jonathan

> 
> Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 1ee2fc5f5f1f..cde29b2e6f34 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  	int i, ret;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		const struct iio_dev_attr **attrs;
> +
>  		if (!hw->iio_devs[i])
>  			continue;
>  
> +		/*
> +		 * For the accelerometer, allow setting FIFO sampling frequency
> +		 * values different from the sensor sampling frequency, which
> +		 * may be needed to keep FIFO data rate low while sampling
> +		 * acceleration data at high rates for accurate event detection.
> +		 */
> +		attrs = (i == ST_LSM6DSX_ID_ACC) ? st_lsm6dsx_buffer_attrs : NULL;
>  		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
>  						      &st_lsm6dsx_buffer_ops,
> -						      st_lsm6dsx_buffer_attrs);
> +						      attrs);
>  		if (ret)
>  			return ret;
>  	}


