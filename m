Return-Path: <linux-iio+bounces-8790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20495EE6B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258671F22C71
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8E149C64;
	Mon, 26 Aug 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWVQI8OX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA781482F5;
	Mon, 26 Aug 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667828; cv=none; b=NZmdBHkeHlj/fm/aAbaDZQllvc/76rWfcU7lS3hWUY2hBHallFKvUwTPKq7vTgNgCG+bvH61c4o/u4Rc1cRRAKyvCYqpB+OhvfhQCnFTdaJ2uScciWoS13cmhbstsKOqEvuv/4c9Qveca3jrPOy6HLEJcUQxSVG+ko4SFSVYwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667828; c=relaxed/simple;
	bh=OILafryTW4ruNfaPEeEMXBE9q03CMHc6dUIyo/58e5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbuSDh4cdmXn0zpbm70WyaCQBObMCdMr1daYoDaBcf54An+mbsS8hIFjZEaI6DjAt5Sq4pPpXQyPaBDIotPAirsI+bvVF2FKFsMO1lzwKoAOCVe3j83aEeDbsGZNImMkY2wl4pEGc5OWC+6ZuwIFktcE0d/ex8msfaYNC1+nXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWVQI8OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE4C58302;
	Mon, 26 Aug 2024 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724667827;
	bh=OILafryTW4ruNfaPEeEMXBE9q03CMHc6dUIyo/58e5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KWVQI8OXsXXRSM/nD+yL+m4JJhdNFp8Pl6rMQOCeE8pNH/oSz6eFXvG6XFRb6vw/8
	 GpjW1MSaHElji9kM2SK37FG2KHD0BsKuORZR1Iv7n+hMfiJPZ99Qw/fQLJwTU8MFrD
	 uvbUW+NoV3aozZFKb/6lzJEb5MC7WjFiOTzq9CEQmULtd+yQHyxkyp3SnSVL9zmnRZ
	 ibulZd/Ot9+UhqxG1a5McIAvdhyMnmcvVwoZY4iDmZC8sYyGtLH4t1f5xHIhwnEb2p
	 B07mSQudP5ZJYUaTXBhG4P0/pvPzmzUsoXYiwtGTUUNLWdDCRfVcTd1hsvwgxjthZ9
	 zZLFU6eHQtREA==
Date: Mon, 26 Aug 2024 11:23:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Luke D . Jones" <luke@ljones.dev>, Jonathan LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH v3 1/1] iio: bmi323: peripheral in lowest power state on
 suspend
Message-ID: <20240826112336.5d9dcb93@jic23-huawei>
In-Reply-To: <20240824141122.334620-2-benato.denis96@gmail.com>
References: <20240823192921.7df291f8@jic23-huawei>
	<20240824141122.334620-1-benato.denis96@gmail.com>
	<20240824141122.334620-2-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 16:11:22 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> The bmi323 is mounted on some devices that are powered
> by an internal battery: help in reducing system overall power drain
> while the system is in s2idle or the imu driver is not loaded
> by resetting it in its lowest power draining state.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Applied with some whitespace tweaks.

> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 155 ++++++++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 4b2b211a3e88..57be22c97cb9 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -118,6 +118,38 @@ static const struct bmi323_hw bmi323_hw[2] = {
>  	},
>  };
>  
> +static const unsigned int bmi323_reg_savestate[] = {
> +	BMI323_INT_MAP1_REG,
> +	BMI323_INT_MAP2_REG,
> +	BMI323_IO_INT_CTR_REG,
> +	BMI323_IO_INT_CONF_REG,
> +	BMI323_ACC_CONF_REG,
> +	BMI323_GYRO_CONF_REG,
> +	BMI323_FEAT_IO0_REG,
> +	BMI323_FIFO_WTRMRK_REG,
> +	BMI323_FIFO_CONF_REG
> +};
> +
> +static const unsigned int bmi323_ext_reg_savestate[] = {
> +	BMI323_GEN_SET1_REG,
> +	BMI323_TAP1_REG,
> +	BMI323_TAP2_REG,
> +	BMI323_TAP3_REG,
> +	BMI323_FEAT_IO0_S_TAP_MSK,
> +	BMI323_STEP_SC1_REG,
> +	BMI323_ANYMO1_REG,
> +	BMI323_NOMO1_REG,
> +	BMI323_ANYMO1_REG + BMI323_MO2_OFFSET,
> +	BMI323_NOMO1_REG + BMI323_MO2_OFFSET,
> +	BMI323_ANYMO1_REG + BMI323_MO3_OFFSET,
> +	BMI323_NOMO1_REG + BMI323_MO3_OFFSET
> +};
> +
> +struct bmi323_regs_runtime_pm {
> +	unsigned int reg_settings[ARRAY_SIZE(bmi323_reg_savestate)];
> +	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
> +};
> +
>  struct bmi323_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -130,6 +162,7 @@ struct bmi323_data {
>  	u32 odrns[BMI323_SENSORS_CNT];
>  	u32 odrhz[BMI323_SENSORS_CNT];
>  	unsigned int feature_events;
> +	struct bmi323_regs_runtime_pm runtime_pm_status;
>  
>  	/*
>  	 * Lock to protect the members of device's private data from concurrent
> @@ -1972,6 +2005,11 @@ static void bmi323_disable(void *data_ptr)
>  
>  	bmi323_set_mode(data, BMI323_ACCEL, ACC_GYRO_MODE_DISABLE);
>  	bmi323_set_mode(data, BMI323_GYRO, ACC_GYRO_MODE_DISABLE);
> +
> +	/*
> +	 * Place the peripheral in its lowest power consuming state.
> +	 */
> +	regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
>  }
>  
>  static int bmi323_set_bw(struct bmi323_data *data,
> @@ -2030,6 +2068,13 @@ static int bmi323_init(struct bmi323_data *data)
>  		return dev_err_probe(data->dev, -EINVAL,
>  				     "Sensor power error = 0x%x\n", val);
>  
> +	return 0;
> +}
> +
> +static int bmi323_init_reset(struct bmi323_data *data)
> +{
> +	int ret;
> +
>  	/*
>  	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
>  	 * frequency in relation to the ODR.
> @@ -2078,12 +2123,18 @@ int bmi323_core_probe(struct device *dev)
>  	data = iio_priv(indio_dev);
>  	data->dev = dev;
>  	data->regmap = regmap;
> +	data->irq_pin = BMI323_IRQ_DISABLED;
> +	data->state = BMI323_IDLE;
>  	mutex_init(&data->mutex);
>  
>  	ret = bmi323_init(data);
>  	if (ret)
>  		return -EINVAL;
>  
> +	ret = bmi323_init_reset(data);
> +	if (ret)
> +		return -EINVAL;
> +
>  	if (!iio_read_acpi_mount_matrix(dev, &data->orientation, "ROTM")) {
>  		ret = iio_read_mount_matrix(dev, &data->orientation);
>  		if (ret)
> @@ -2117,7 +2168,7 @@ int bmi323_core_probe(struct device *dev)
>  		return dev_err_probe(data->dev, ret,
>  				     "Unable to register iio device\n");
>  
> -	return 0;
> +	return bmi323_fifo_disable(data);
>  }
>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  
> @@ -2125,13 +2176,113 @@ EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  static int bmi323_core_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = iio_device_suspend_triggering(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Save registers meant to be restored by resume pm callback. */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
> +		ret = regmap_read(data->regmap, bmi323_reg_savestate[i],
> +			   &savestate->reg_settings[i]);
> +		if (ret) {
> +			dev_err(data->dev, "Error reading bmi323 reg 0x%x: %d\n",
> +				  bmi323_reg_savestate[i], ret);
> +			return ret;
> +		}
> +	}
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> +		ret = bmi323_read_ext_reg(data, bmi323_reg_savestate[i],
> +			   &savestate->reg_settings[i]);
> +		if (ret) {
> +			dev_err(data->dev, "Error reading bmi323 external reg 0x%x: %d\n",
> +				  bmi323_reg_savestate[i], ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Perform soft reset to place the device in its lowest power state. */
> +	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
> +	if (ret)
> +		return ret;
>  
> -	return iio_device_suspend_triggering(indio_dev);
> +	return 0;
>  }
>  
>  static int bmi323_core_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	/*
> +	 * Perform the device power-on and initial setup once again
> +	 * after being reset in the lower power state by runtime-pm.
> +	 */
> +	ret = bmi323_init(data);
> +	if (!ret)
> +		return ret;
> +
> +	/* Register must be cleared before changing an active config */
> +	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, 0);
> +	if (ret) {
> +		dev_err(data->dev, "Error stopping feature engine\n");
> +		return ret;
> +	}
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> +		ret = bmi323_write_ext_reg(data, bmi323_reg_savestate[i],
> +			  savestate->reg_settings[i]);
> +		if (ret) {
> +			dev_err(data->dev, "Error writing bmi323 external reg 0x%x: %d\n",
> +				  bmi323_reg_savestate[i], ret);
> +			return ret;
> +		}
> +	}
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
> +		ret = regmap_write(data->regmap, bmi323_reg_savestate[i],
> +			  savestate->reg_settings[i]);
> +		if (ret) {
> +			dev_err(data->dev, "Error writing bmi323 reg 0x%x: %d\n",
> +				  bmi323_reg_savestate[i], ret);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Clear old FIFO samples that might be generated before suspend
> +	 * or generated from a peripheral state not equal to the saved one.
> +	 */
> +	if (data->state == BMI323_BUFFER_FIFO) {
> +		ret = regmap_write(data->regmap, BMI323_FIFO_CTRL_REG,
> +			   BMI323_FIFO_FLUSH_MSK);
> +		if (ret) {
> +			dev_err(data->dev, "Error flushing FIFO buffer: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = regmap_read(data->regmap, BMI323_ERR_REG, &val);
> +	if (ret) {
> +		dev_err(data->dev, "Error reading bmi323 error register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (val) {
> +		dev_err(data->dev, "Sensor power error in PM = 0x%x\n", val);
> +		return -EINVAL;
> +	}
>  
>  	return iio_device_resume_triggering(indio_dev);
>  }


