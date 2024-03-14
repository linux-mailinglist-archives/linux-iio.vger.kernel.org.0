Return-Path: <linux-iio+bounces-3515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188887BF53
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53823B20AA5
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F971721;
	Thu, 14 Mar 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVtfir6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206026FE10
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427964; cv=none; b=hee/jY5hIzKg00gm3RBoaMNdtXgpnYkEgpQ0N3dcXMRWD9+nfAl0h3mXoZYQEKtMUYwJHYMkw3Ix7cq1x+9KrdZRZhR7AbXlmRDt6XYyoDqzYA1f1IWB/UCL5j0t5FNiPgeej4N89DI04jn6D/elO6C21mGk6YSuGjru9jVDCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427964; c=relaxed/simple;
	bh=FSqclAYgvUoGSJxP+QJ/8b/TVESmyssFQ7AqdsOeZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mstrcbMBEEEmhi+SEX2yWy7Q9tYqr9GYFjhItxN7ZBdNNH+NOWSRPch6XsjwgQFUedJD/8Yc9nH5uhfKsHZxy7krdiC3wANH84Ky6GPBl7VvQ+nadbveiWzg+5hEDVwvszeIvQa5znLs9XhCHvQVS8O7MMz/4EB/I3DYhqzvFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVtfir6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED24C433C7;
	Thu, 14 Mar 2024 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427963;
	bh=FSqclAYgvUoGSJxP+QJ/8b/TVESmyssFQ7AqdsOeZYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVtfir6DrIJ93cUTo4bCimTbO9kWol9LmQhNuHfpA6lLVkVVx9fewWOhi1rtnt/SJ
	 8UKKs1CONeA9Bq1Ssb1IG2pzHECiJz26vyztZwKM9wliT0n7AT1Wc4CsTg15ZVRA4w
	 cZHUOdjitCr65/bSuJRs0ubpH++0dAbBQN3g/L9SVAeKPTGcPtSnJnJKFBXJQiUBA1
	 SFXUM+UamkaFW3zfENjWkZ484Oj7YblG/kteQxdnxgywQOPcx1W73hH+GOKFtzvTza
	 JPOWi/wUiLvKYd5s9xHxGuEGqbnNRHvDycjgEMfmdolfIfbBfnjigkOVMa5tkX7Jai
	 +lAfXBLZjA9uw==
Date: Thu, 14 Mar 2024 14:52:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup
 with low-power mode
Message-ID: <20240314145230.4fb5fc86@jic23-huawei>
In-Reply-To: <20240308151023.379705-5-inv.git-commit@tdk.com>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
	<20240308151023.379705-5-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 15:10:23 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add wakeup from suspend for WoM when enabled and put accel in
> low-power mode when suspended. Requires rewriting pwr_mgmt_1
> register handling and factorize out accel LPF settings.
> Use a low-power rate similar to the chip sampling rate but always
> lower for a best match of the sampling rate while saving power
> and adjust threshold to follow the required roc value.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
A few comments inline, but nothing significant that needs changes.
Not sure why this didn't send the other day - just found it still open :(

Jonathan

> ---

> +
> +static int inv_mpu6050_set_wom_lp(struct inv_mpu6050_state *st, bool on)

You could just split this given almost nothing shared between the two branches.

> +{
> +	unsigned int lp_div;
> +	int result;
> +
> +	if (on) {
> +		/* set low power ODR */
> +		result = inv_mpu6050_set_lp_odr(st, INV_MPU6050_FREQ_DIVIDER(st), &lp_div);
> +		if (result)
> +			return result;
> +		/* disable accel low pass filter */
> +		result = inv_mpu6050_set_accel_lpf_regs(st, INV_MPU6050_FILTER_NOLPF);
> +		if (result)
> +			return result;
> +		/* update wom threshold with new low-power frequency divider */
> +		result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold, lp_div);
> +		if (result)
> +			return result;
> +		/* set cycle mode */
> +		result = inv_mpu6050_pwr_mgmt_1_write(st, false, true, -1, -1);
> +	} else {
> +		/* disable cycle mode */
> +		result = inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, -1);
> +		if (result)
> +			return result;
> +		/* restore wom threshold */
> +		result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold,
> +						       INV_MPU6050_FREQ_DIVIDER(st));
> +		if (result)
> +			return result;
> +		/* restore accel low pass filter */
> +		result = inv_mpu6050_set_accel_lpf_regs(st, st->chip_config.lpf);
> +	}
> +
> +	return result;
> +}
> +
>  static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
>  {
>  	struct device *pdev = regmap_get_device(st->map);
> @@ -1847,6 +1933,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  			irq_type);
>  		return -EINVAL;
>  	}
> +	device_set_wakeup_capable(dev, true);
>  
>  	st->vdd_supply = devm_regulator_get(dev, "vdd");
>  	if (IS_ERR(st->vdd_supply))
> @@ -2012,16 +2099,27 @@ static int inv_mpu_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	bool wakeup;
>  	int result;
>  
>  	mutex_lock(&st->lock);
A very good case for using guard(mutex)(&st->lock); but that can be a future series.

> -	result = inv_mpu_core_enable_regulator_vddio(st);
> -	if (result)
> -		goto out_unlock;
>  
> -	result = inv_mpu6050_set_power_itg(st, true);
> -	if (result)
> -		goto out_unlock;
> +	wakeup = device_may_wakeup(dev) && st->chip_config.wom_en;
> +
> +	if (wakeup) {
> +		enable_irq(st->irq);
> +		disable_irq_wake(st->irq);
> +		result = inv_mpu6050_set_wom_lp(st, false);
> +		if (result)
> +			goto out_unlock;
> +	} else {
> +		result = inv_mpu_core_enable_regulator_vddio(st);
> +		if (result)
> +			goto out_unlock;
> +		result = inv_mpu6050_set_power_itg(st, true);
> +		if (result)
> +			goto out_unlock;
> +	}
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_active(dev);
> @@ -2031,7 +2129,7 @@ static int inv_mpu_resume(struct device *dev)
>  	if (result)
>  		goto out_unlock;
>  
> -	if (st->chip_config.wom_en) {
> +	if (st->chip_config.wom_en && !wakeup) {
>  		result = inv_mpu6050_set_wom_int(st, true);
>  		if (result)
>  			goto out_unlock;
...

> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index e97a63ad2c31..6ba9d42b2537 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -304,6 +304,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
>  #define INV_MPU6050_BIT_H_RESET             0x80
>  #define INV_MPU6050_BIT_SLEEP               0x40
> +#define INV_MPU6050_BIT_CYCLE               0x20
>  #define INV_MPU6050_BIT_TEMP_DIS            0x08

Side note but why don't we use BIT(x) for these?

>  #define INV_MPU6050_BIT_CLK_MASK            0x7
>  
> @@ -335,6 +336,7 @@ struct inv_mpu6050_state {
>  /* mpu6500 registers */
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
>  #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
> +#define INV_MPU6500_REG_LP_ODR              0x1E
>  #define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
>  #define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
>  #define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
> @@ -451,6 +453,18 @@ enum inv_mpu6050_filter_e {
>  	NUM_MPU6050_FILTER
>  };
>  
> +enum inv_mpu6050_lposc_e {
> +	INV_MPU6050_LPOSC_4HZ = 4,
> +	INV_MPU6050_LPOSC_8HZ,
> +	INV_MPU6050_LPOSC_16HZ,
> +	INV_MPU6050_LPOSC_31HZ,
> +	INV_MPU6050_LPOSC_62HZ,
> +	INV_MPU6050_LPOSC_125HZ,
> +	INV_MPU6050_LPOSC_250HZ,
> +	INV_MPU6050_LPOSC_500HZ,
> +	NUM_MPU6050_LPOSC,

Trivial but no comma needed on a NUM type last entry as we'll never
add anything after it.

> +};
> +
>  /* IIO attribute address */
>  enum INV_MPU6050_IIO_ATTR_ADDR {
>  	ATTR_GYRO_MATRIX,


