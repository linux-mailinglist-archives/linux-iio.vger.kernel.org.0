Return-Path: <linux-iio+bounces-15960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92655A409F9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BF217D1C2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B41F2C56;
	Sat, 22 Feb 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7TlL7dp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928611CAF;
	Sat, 22 Feb 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241352; cv=none; b=XFabtSJj922m0sILbw386vVEmNSNWeXhlxIgwBPVrm1vSbN6U1H7NxPVo2spCdByk1yXjfgnOA+3aRYqYrkF3MLZUp2ryM20/76ZtskLmK2PVt5nRsQGVkb57CIm7I3aiv3FfNVei4a4T6UM8y0es6QS+/bT0JijgkmK6N3NR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241352; c=relaxed/simple;
	bh=4pTRs+KFgZn7araHwhEkH573SIaKZW26vFq4SuYI9U8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdPkdg2J7+rf3AynVpQT3/+mgX09K+nX3npBafl4UwVnXrCAuZHVcKRhtCKU919sDaKex/ECjIvF1klUINra6FoJ/8FFA2ZzLZ/y4pbq33miEon6G+m69X0IyScAlXXr7TcedG5qufExkHi+d7N72hHKOMfTTtgj1POpzzSFje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7TlL7dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B001EC4CED1;
	Sat, 22 Feb 2025 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740241352;
	bh=4pTRs+KFgZn7araHwhEkH573SIaKZW26vFq4SuYI9U8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M7TlL7dpZAxsRjixY44nPBZsoY/7iAXAKMgmQ0fUeLEnijSfxO4Mwt5Gpqgi+YFvK
	 SPeR4rG9d+XtJq4BDOeYQ95S/42JVSwhFH8BTRm9lJ+InEdNwsDBlEfAeVkq1eGnD7
	 c536Kf5Hi2fJd3w22r6eza8r+445Ki9jrtqFMdFZx+g/3+v9RJgWepRttU2GIVqabS
	 ceehza9aQ/Ja8OY6Fv2iShgqPiXSbKgWTowNsf9Iqndgsyhd4SdLhEQqV6xX4tMLRG
	 3nyHiLmeRlFdlVD2WB+DGXCDjl7mKRRtxMlf7zrnaF7XpT0AGP9Zgh42Z2AhJUpjys
	 5xPAvLRj+sLtQ==
Date: Sat, 22 Feb 2025 16:22:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Message-ID: <20250222162224.60059025@jic23-huawei>
In-Reply-To: <20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
References: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 21:52:07 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When Wake-on-Motion is on, enable system wakeup and keep chip on for
> waking up system with interrupt.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste,

A few comments inline.

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h       |  2 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |  3 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c  | 89 +++++++++++++++--------
>  3 files changed, 63 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465..baf1dcd714800e84ccd21dc1d1e486849c77a9ae 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -151,6 +151,7 @@ struct inv_icm42600_apex {
>   *  @map:		regmap pointer.
>   *  @vdd_supply:	VDD voltage regulator for the chip.
>   *  @vddio_supply:	I/O voltage regulator for the chip.
> + *  @irq:		chip irq.

Maybe say a little on what the variable is used for. It's not otherwise
obvious why we need it.  Also, does this chip really only have one irq line?
Looks like there are two. So the drivers should be fixed to cope with the
only one wired being irq2  unless I've found the wrong datasheet which is
certainly possible.


>   *  @orientation:	sensor chip orientation relative to main hardware.
>   *  @conf:		chip sensors configurations.
>   *  @suspended:		suspended sensors configuration.
> @@ -168,6 +169,7 @@ struct inv_icm42600_state {
>  	struct regmap *map;
>  	struct regulator *vdd_supply;
>  	struct regulator *vddio_supply;
> +	int irq;
>  	struct iio_mount_matrix orientation;
>  	struct inv_icm42600_conf conf;
>  	struct inv_icm42600_suspended suspended;
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 8ce2276b3edc61cc1ea26810198dd0057054ec48..4240e8c576f4d07af5434e9a91dfda532f87ffb9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -1149,6 +1149,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	/* accel events are wakeup capable */
> +	device_set_wakeup_capable(&indio_dev->dev, true);
> +
>  	return indio_dev;
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2..f94bda5dc094d6cc85e3facbd480b830bfbaa3f9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -751,6 +751,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
>  	mutex_init(&st->lock);
>  	st->chip = chip;
>  	st->map = regmap;
> +	st->irq = irq;
>  
>  	ret = iio_read_mount_matrix(dev, &st->orientation);
>  	if (ret) {
> @@ -829,44 +830,56 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
>  static int inv_icm42600_suspend(struct device *dev)
>  {
>  	struct inv_icm42600_state *st = dev_get_drvdata(dev);
> +	struct device *accel_dev;
> +	bool wakeup;
> +	int accel_conf;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

As below. Pull these guard changes out as a precursor patch. That will make
it easier to spot the real changes here.

>  
>  	st->suspended.gyro = st->conf.gyro.mode;
>  	st->suspended.accel = st->conf.accel.mode;
>  	st->suspended.temp = st->conf.temp_en;
> -	if (pm_runtime_suspended(dev)) {
> -		ret = 0;
> -		goto out_unlock;
> -	}
> +	if (pm_runtime_suspended(dev))
> +		return 0;
>  
>  	/* disable FIFO data streaming */
>  	if (st->fifo.on) {
>  		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
>  				   INV_ICM42600_FIFO_CONFIG_BYPASS);
>  		if (ret)
> -			goto out_unlock;
> +			return ret;
>  	}
>  
> -	/* disable APEX features */
> -	if (st->apex.wom.enable) {
> -		ret = inv_icm42600_set_wom(st, false);
> -		if (ret)
> -			goto out_unlock;
> +	/* keep chip on and wake-up capable if APEX and wakeup on */
> +	accel_dev = &st->indio_accel->dev;
> +	wakeup = (st->apex.on && device_may_wakeup(accel_dev)) ? true : false;
> +
> +	if (!wakeup) {
> +		/* disable APEX features and accel if wakeup disabled */
> +		if (st->apex.wom.enable) {
> +			ret = inv_icm42600_set_wom(st, false);
> +			if (ret)
> +				return ret;
> +		}
> +		accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
> +	} else {
> +		/* keep accel on and setup irq for wakeup */
> +		accel_conf = st->conf.accel.mode;
> +		enable_irq_wake(st->irq);
> +		disable_irq(st->irq);
>  	}
>  
>  	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> -					 INV_ICM42600_SENSOR_MODE_OFF, false,
> -					 NULL);
> +					 accel_conf, false, NULL);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
> -	regulator_disable(st->vddio_supply);
> +	/* disable vddio regulator if chip is sleeping */
> +	if (!wakeup)
> +		regulator_disable(st->vddio_supply);
>  
> -out_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> @@ -878,13 +891,25 @@ static int inv_icm42600_resume(struct device *dev)
>  	struct inv_icm42600_state *st = dev_get_drvdata(dev);
>  	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
>  	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
> +	struct device *accel_dev;
> +	bool wakeup;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

Good change.  But separate patch as not related to most of what is going on here.


>  
> -	ret = inv_icm42600_enable_regulator_vddio(st);
> -	if (ret)
> -		goto out_unlock;
> +	/* check wakeup capability */
> +	accel_dev = &st->indio_accel->dev;
> +	wakeup = (st->apex.on && device_may_wakeup(accel_dev)) ? true : false;
> +
> +	/* restore vddio if cut off or irq state */
> +	if (!wakeup) {
> +		ret = inv_icm42600_enable_regulator_vddio(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		enable_irq(st->irq);
> +		disable_irq_wake(st->irq);
> +	}
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_active(dev);
> @@ -895,13 +920,15 @@ static int inv_icm42600_resume(struct device *dev)
>  					 st->suspended.accel,
>  					 st->suspended.temp, NULL);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
> -	/* restore APEX features */
> -	if (st->apex.wom.enable) {
> -		ret = inv_icm42600_set_wom(st, true);
> -		if (ret)
> -			goto out_unlock;
> +	/* restore APEX features if disabled */
> +	if (!wakeup) {
> +		if (st->apex.wom.enable) {
> +			ret = inv_icm42600_set_wom(st, true);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	/* restore FIFO data streaming */
> @@ -910,11 +937,11 @@ static int inv_icm42600_resume(struct device *dev)
>  		inv_sensors_timestamp_reset(&accel_st->ts);
>  		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
>  				   INV_ICM42600_FIFO_CONFIG_STREAM);
> +		if (ret)
> +			return ret;
>  	}
>  
> -out_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  /* Runtime suspend will turn off sensors that are enabled by iio devices. */
> 


