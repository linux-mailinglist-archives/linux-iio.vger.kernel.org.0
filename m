Return-Path: <linux-iio+bounces-2781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF6185A59A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F131F22549
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706C374D9;
	Mon, 19 Feb 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDMB9dgf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6983715E;
	Mon, 19 Feb 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352164; cv=none; b=inOJ28kHLYrqiuWQL9yCSZmEehUALLm/60ooAquGekseztDKYbBQ+ZIzesY12JtGLh9/IKaEK7Csa+Vh07F2hoxYARprObKDpHSsFqGhn1OaG/uI6TP+AoPWV3ih4yYx4KuY/DcVoInJes/cjQIfEGDGg6r+co7Ud081hKpWofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352164; c=relaxed/simple;
	bh=Mz6+cTwJd0PXWMHvfHiaHQTydZtPgoGdga0eybV2k/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdpfCAgZaeqdJjV216KF+WgLnBmAkrdv2eGe5+eF2//7g+qXCr8cgCauhEfKgR/9up3i1eWzuAS89nqRwxUqi2va98pVm/Ew6KP0HzWHbZuLhO0SMGn5cdS8xRvk6cm5AD/WbJcoCKFsSsxBRAQwWJyXbRSKDdnTHJTyzwhgS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDMB9dgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD95C433F1;
	Mon, 19 Feb 2024 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708352163;
	bh=Mz6+cTwJd0PXWMHvfHiaHQTydZtPgoGdga0eybV2k/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDMB9dgfKHkQgGSOUmHTYYnsBxr0qVhgh+oU4IBFovEJ5bFwG2GrZK+PKapwPK6ZI
	 0mOsUiONZc2g6Q/Fub+BwvE+QODYw/t3jT5/N303YonNisRPJfsccuZH0rca6in5cV
	 0Gr8IrOsLn1yk0YpE7E8TD3LDQgcNQyZoL3aPufc=
Date: Mon, 19 Feb 2024 15:16:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: inv.git-commit@tdk.com
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix frequency setting when chip
 is off
Message-ID: <2024021953-gem-student-d304@gregkh>
References: <20240219104901.88743-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219104901.88743-1-inv.git-commit@tdk.com>

On Mon, Feb 19, 2024 at 10:49:01AM +0000, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Track correctly FIFO state and apply ODR change before starting
> the chip. Without the fix, you cannot change ODR more than 1 time
> when data buffering is off.
> 
> Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
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
>  		result = inv_mpu6050_prepare_fifo(st, false);
>  		if (result)
>  			goto error_power_off;
> --
> 2.34.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

