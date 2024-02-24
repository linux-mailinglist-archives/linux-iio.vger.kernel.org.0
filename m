Return-Path: <linux-iio+bounces-3008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD1862601
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B49EB21399
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF447A6B;
	Sat, 24 Feb 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Covv1n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22814288;
	Sat, 24 Feb 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708791742; cv=none; b=r5zjJ8g8jKCM25VWj6pIx8whWmYzM318+Hjtm4o4LoJ9GlkuMsWuCD3G2tV/DuvjFPo56lVHmRgPAbFUBxJ6hoHLkdTN8/s2iw6rhfT7nyvAhQIOH78y+7hTEhDwW1j0lwvacnzlu0EoyUUZ6Yr0iOgqwW5hhuWqCC3VH/RYm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708791742; c=relaxed/simple;
	bh=KLo40E4PB52yveKuCkrscFWPGbPteMmFmLS11zYQWps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0vEFdRhGWWx8WilM7SrKAvEBSdkEmfD7ieRYFiydK1Iocy57YHTdPuiSLw9/+KZBPkuSUt5U/BeKZf30nvp4uIoy4gdP2O2FXGOxPRdFTe8jpuh29KJ+iUTal79iaZ1/Qb1LfhzF9mt5rKhy0cs5WeMAOLBzsEVEum++YAB+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Covv1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190E4C433F1;
	Sat, 24 Feb 2024 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708791741;
	bh=KLo40E4PB52yveKuCkrscFWPGbPteMmFmLS11zYQWps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U9Covv1ngc+4wHuxObler4Avp2oqEAOD2S1IwDLlhiMLD1yomxgQ1PcpfUdEUY+1m
	 U/XKQCXsZD4PwWPoq1TAVdbWDroTat3YW3v/+EGUYW7mlbTfz/Je7yT2Go+OYp3nl3
	 kqD0dFfk9bh7Dmlx+gsaobU9AO/0iaz4zBNDKyiDvLPmrJN9OaDXBGI0Q/5ENjW3+y
	 9CBHLs57HAPTDwkeLanx0qNan8THESkQLP3IJbVt5+3pTmQ7HRC2+BIwkAnrdyjWm6
	 c3decOkDdjxmh+/BlSZOkyATnbca0erddTb+ci9JPo83yQYHdm2DQJp95U6R9YO37C
	 1mdeXckZEbn0A==
Date: Sat, 24 Feb 2024 16:22:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix frequency setting when
 chip is off
Message-ID: <20240224162208.02d28bcd@jic23-huawei>
In-Reply-To: <20240219154741.90601-1-inv.git-commit@tdk.com>
References: <20240219154741.90601-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 15:47:41 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Track correctly FIFO state and apply ODR change before starting
> the chip. Without the fix, you cannot change ODR more than 1 time
> when data buffering is off.

Hi Jean-Baptiste.

I think this patch needs a little more explanation.
1) Why has state changed such that we need to update these cached values?
2) What does that have to do with ODR - or is this two unrelated fixes?

I'm sure the fix is right - I just don't fully understand the issues!
> 
> Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
> V2: add missing stable tag
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 676704f9151f..e6e6e94452a3 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -111,6 +111,7 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
>  	if (enable) {
>  		/* reset timestamping */
>  		inv_sensors_timestamp_reset(&st->timestamp);
> +		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
>  		/* reset FIFO */
>  		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
>  		ret = regmap_write(st->map, st->reg->user_ctrl, d);
> @@ -184,6 +185,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			goto error_power_off;
>  	} else {
> +		st->chip_config.gyro_fifo_enable = 0;
> +		st->chip_config.accl_fifo_enable = 0;
> +		st->chip_config.temp_fifo_enable = 0;
> +		st->chip_config.magn_fifo_enable = 0;
I think the write to actually do this is in prepare_fifo and it's not
conditional on these, so why do we care?

Are these effectively paired with inv_scan_query in the enable path?


>  		result = inv_mpu6050_prepare_fifo(st, false);
>  		if (result)
>  			goto error_power_off;
> --
> 2.34.1
> 


