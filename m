Return-Path: <linux-iio+bounces-8535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8279557EA
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DE51C21435
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E1149DFA;
	Sat, 17 Aug 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOVLdH9S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC151854;
	Sat, 17 Aug 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898959; cv=none; b=lynF+tP2Bj8VJfEa4MdJ6NQs3aVBSYr6NjNC8DlVXNlmbmSaXkVMPX98jHqkQgpgnymG0MLqWFtLDFVNOtT224AZ3Qfh0Fe8XD2+CrwPmm4NmsClkvcCM9mNorR1bBc2Xa8HSLFZWfP25NewuUOGGL6YsE3AlNj91ihyDw8iBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898959; c=relaxed/simple;
	bh=+pE5SKWzlxF3fD73WKhRfKm3B6zo5OA06Nc/dkeL658=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV659riTiyWJyxFOxmoTmVxMCArok1TXuzIW9UiaNavxmquLnSpWPVAZQh17wDkQdCVKOQPgl8VKu7lRgtmDjrWnVkc51+jqqoCTj8yCmuPi0udLkLjBqSeBCKEJ+dXl+RHqQOZLMZI5DbRUMyxoP0Sb6WO2v3xRbgsSDp3ePxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOVLdH9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B1C116B1;
	Sat, 17 Aug 2024 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723898958;
	bh=+pE5SKWzlxF3fD73WKhRfKm3B6zo5OA06Nc/dkeL658=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOVLdH9S9heKEEqyUSsvrbQBm/NO/PRD2+n8hARLH2RQf0SkbirvWgRiu8sV5JjVr
	 AaTK80Hu1VY6iTuDLTT0Lcmd4nJFgNB4zjr/j9VoMIeerMOJe6k6OcCVeNXaWSIhAy
	 jGWdJo2h/MQryfP3TcSOcCd+Gt9sEeYRDO+XJkLH7uVOTRId+JNXf7hcb6soMl23pc
	 9XGQ9i7bP3gnMPTVU4DjI3jvRFI2xL0tQlBjdSzw66VIlKDCq0bSwxsvC/E1p12um/
	 KNNIpUgikqQj7MP5aPodQCMuCONDNv3QOt/5fGZkchEI8h9melw357JFlegS+uH0St
	 vCBuqwvXXc16A==
Date: Sat, 17 Aug 2024 13:49:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jagath Jog J
 <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>, Jonathan
 LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH 1/1] iio: bmi323: peripheral in lowest power state on
 suspend
Message-ID: <20240817134911.6043c798@jic23-huawei>
In-Reply-To: <20240811161202.19818-2-benato.denis96@gmail.com>
References: <20240811161202.19818-1-benato.denis96@gmail.com>
	<20240811161202.19818-2-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 18:12:02 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> The bmi323 is mounted on some devices that are powered
> by an internal battery: help in reducing system overall power drain
> while the imu is not in use by resetting it in its lowest power
> draining state.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Hi Denis.

This is rather an expensive path for runtime PM. 

Maybe mention this still only applies in s2idle.
The driver doesn't have a more sophisticated runtime pm to
bring the power down when it's simply not being used:
autosuspend etc which would need a lot more infrastructure
as we need to add when the device must be resumed + when we
are done with talking to it.

Jonathan


> ---
>  drivers/iio/imu/bmi323/bmi323.h      |   1 +
>  drivers/iio/imu/bmi323/bmi323_core.c | 183 ++++++++++++++++++++++++++-
>  drivers/iio/imu/bmi323/bmi323_i2c.c  |   8 ++
>  drivers/iio/imu/bmi323/bmi323_spi.c  |   8 ++
>  4 files changed, 194 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
> index 209bccb1f335..9fd3c5db7520 100644
> --- a/drivers/iio/imu/bmi323/bmi323.h
> +++ b/drivers/iio/imu/bmi323/bmi323.h
> @@ -204,6 +204,7 @@
>  
>  struct device;
>  int bmi323_core_probe(struct device *dev);
> +void bmi323_core_remove(struct device *dev);
>  extern const struct regmap_config bmi323_regmap_config;
>  extern const struct dev_pm_ops bmi323_core_pm_ops;
>  
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 4b2b211a3e88..edb9ce4e66a0 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -118,6 +118,24 @@ static const struct bmi323_hw bmi323_hw[2] = {
>  	},
>  };
>  
> +struct bmi323_ext_regs_settings {
> +	unsigned int reg;
> +	unsigned int val;
> +};
> +
> +struct bmi323_regs_settings {
> +	unsigned int reg;
> +	unsigned int val;
> +};

Why are two types useful?

> +
> +#define EXT_SETTING_REGISTERS 12
> +#define SETTING_REGISTERS 9
> +
> +struct bmi323_regs_runtime_pm {
> +	struct bmi323_regs_settings reg_settings[SETTING_REGISTERS];
> +	struct bmi323_ext_regs_settings ext_settings[EXT_SETTING_REGISTERS];

As below. Break these part so that the register addresses are just const data
and the values are all that is stored in here. 

> +};
> +
>  struct bmi323_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -130,6 +148,7 @@ struct bmi323_data {
>  	u32 odrns[BMI323_SENSORS_CNT];
>  	u32 odrhz[BMI323_SENSORS_CNT];
>  	unsigned int feature_events;
> +	struct bmi323_regs_runtime_pm runtime_pm_status;
>  
>  	/*
>  	 * Lock to protect the members of device's private data from concurrent
> @@ -1982,7 +2001,7 @@ static int bmi323_set_bw(struct bmi323_data *data,
>  				  FIELD_PREP(BMI323_ACC_GYRO_CONF_BW_MSK, bw));
>  }
>  
> -static int bmi323_init(struct bmi323_data *data)
> +static int bmi323_init(struct bmi323_data *data, bool first_init)
>  {
>  	int ret, val;
>  
> @@ -2030,6 +2049,9 @@ static int bmi323_init(struct bmi323_data *data)
>  		return dev_err_probe(data->dev, -EINVAL,
>  				     "Sensor power error = 0x%x\n", val);
>  

Maybe better to split the function into two parts and call both in probe() 
but not in resume()

> +	if (!first_init)
> +		return 0;
> +
>  	/*
>  	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
>  	 * frequency in relation to the ODR.
> @@ -2078,9 +2100,32 @@ int bmi323_core_probe(struct device *dev)
>  	data = iio_priv(indio_dev);
>  	data->dev = dev;
>  	data->regmap = regmap;
> +	data->irq_pin = BMI323_IRQ_DISABLED;
> +	data->state = BMI323_IDLE;
> +	data->runtime_pm_status.reg_settings[0].reg = BMI323_INT_MAP1_REG;

Use a local pointer to reg_settings / ext_settings to shorten all these a lot.
Or better still separate the register addresses into a const arrays with only
the values (in a 1 D array) being changed by code.

> +	data->runtime_pm_status.reg_settings[1].reg = BMI323_INT_MAP2_REG;
> +	data->runtime_pm_status.reg_settings[2].reg = BMI323_IO_INT_CTR_REG;
> +	data->runtime_pm_status.reg_settings[3].reg = BMI323_IO_INT_CONF_REG;
> +	data->runtime_pm_status.reg_settings[4].reg = BMI323_ACC_CONF_REG;
> +	data->runtime_pm_status.reg_settings[5].reg = BMI323_GYRO_CONF_REG;
> +	data->runtime_pm_status.reg_settings[6].reg = BMI323_FEAT_IO0_REG;
> +	data->runtime_pm_status.reg_settings[7].reg = BMI323_FIFO_WTRMRK_REG;
> +	data->runtime_pm_status.reg_settings[8].reg = BMI323_FIFO_CONF_REG;
> +	data->runtime_pm_status.ext_settings[0].reg = BMI323_GEN_SET1_REG;
> +	data->runtime_pm_status.ext_settings[1].reg = BMI323_TAP1_REG;
> +	data->runtime_pm_status.ext_settings[2].reg = BMI323_TAP2_REG;
> +	data->runtime_pm_status.ext_settings[3].reg = BMI323_TAP3_REG;
> +	data->runtime_pm_status.ext_settings[4].reg = BMI323_FEAT_IO0_S_TAP_MSK;
> +	data->runtime_pm_status.ext_settings[5].reg = BMI323_STEP_SC1_REG;
> +	data->runtime_pm_status.ext_settings[6].reg = BMI323_ANYMO1_REG;
> +	data->runtime_pm_status.ext_settings[7].reg = BMI323_NOMO1_REG;
> +	data->runtime_pm_status.ext_settings[8].reg = BMI323_ANYMO1_REG + BMI323_MO2_OFFSET;
> +	data->runtime_pm_status.ext_settings[9].reg = BMI323_NOMO1_REG + BMI323_MO2_OFFSET;
> +	data->runtime_pm_status.ext_settings[10].reg = BMI323_ANYMO1_REG + BMI323_MO3_OFFSET;
> +	data->runtime_pm_status.ext_settings[11].reg = BMI323_NOMO1_REG + BMI323_MO3_OFFSET;
>  	mutex_init(&data->mutex);
>  
> -	ret = bmi323_init(data);
> +	ret = bmi323_init(data, true);
>  	if (ret)
>  		return -EINVAL;
>  
> @@ -2117,21 +2162,147 @@ int bmi323_core_probe(struct device *dev)
>  		return dev_err_probe(data->dev, ret,
>  				     "Unable to register iio device\n");
>  
> -	return 0;
> +	return bmi323_fifo_disable(data);
>  }
>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  
> +void bmi323_core_remove(struct device *dev)
> +{
> +	struct regmap *const regmap = dev_get_regmap(dev, NULL);
> +
> +	/*
> +	 * Place the peripheral in its lowest power consuming state.
> +	 */
> +	if (regmap)
> +		regmap_write(regmap, BMI323_CMD_REG, BMI323_RST_VAL);
This is happening before the userspace interfaces are removed.
Unlikely to be a good idea.  Use devm_add_action_or_reset()
to register this during probe so that it is torn down
at the correct point.

> +}
> +EXPORT_SYMBOL_NS_GPL(bmi323_core_remove, IIO_BMI323);
> +
>  #if defined(CONFIG_PM)
>  static int bmi323_core_runtime_suspend(struct device *dev)


>  
>  static int bmi323_core_runtime_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *const indio_dev = dev_get_drvdata(dev);

Whilst true that it's const, do we care? I'd drop this
modification.

> +	struct bmi323_data *const data = iio_priv(indio_dev);
Likewise, unlikely the const really helps us.

> +
> +	int ret = 0;

Always set, so don't initialize here.

> +
> +	guard(mutex)(&data->mutex);
> +
> +	/*
> +	 * Perform the device power-on and initial setup once again
> +	 * after being reset in the lower power state by runtime-pm.
> +	 */
> +	ret = bmi323_init(data, false);
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
> +	/*
> +	 * Restore external registers saved by suspend pm callback.
> +	 */
> +	for (unsigned int i = 0; i < EXT_SETTING_REGISTERS; ++i) {

i++ preferred. It's more common and doesn't matter here.

I'd use a local variable for a pointer to data->runtime_pm_status.ext_settings[i]
to make these more readable. Same for other similar cases.

> +		ret = bmi323_write_ext_reg(data,
> +			data->runtime_pm_status.ext_settings[i].reg,
> +			data->runtime_pm_status.ext_settings[i].val);
> +		if (ret) {
> +			dev_err(data->dev, "Error writing bmi323 external reg 0x%x: %d\n",
> +				data->runtime_pm_status.ext_settings[i].reg, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Restore registers saved by suspend pm callback.
> +	 */
> +	for (unsigned int i = 0; i < SETTING_REGISTERS; ++i) {
> +		ret = regmap_write(data->regmap,
> +			data->runtime_pm_status.reg_settings[i].reg,
> +			data->runtime_pm_status.reg_settings[i].val);
> +		if (ret) {
> +			dev_err(data->dev, "Error writing bmi323 reg 0x%x: %d\n",
> +				data->runtime_pm_status.reg_settings[i].reg, ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (data->state == BMI323_BUFFER_FIFO) {
> +		ret = regmap_write(data->regmap, BMI323_FIFO_CTRL_REG,
> +			   BMI323_FIFO_FLUSH_MSK);
> +		if (ret) {
> +			dev_err(data->dev, "Error flushing FIFO buffer: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	unsigned int val;
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

> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> index 9de3ade78d71..f42c49c471c1 100644
> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> @@ -64,6 +64,13 @@ static int bmi323_spi_probe(struct spi_device *spi)
>  	return bmi323_core_probe(dev);
>  }
>  
> +static void bmi323_spi_remove(struct spi_device *spi)
> +{
> +	struct device *const dev = &spi->dev;
> +
> +	bmi323_core_remove(dev);
Register anything that needs doing with devm_add_action_or_reset()
after whatever is undoing is first done in probe().

There shouldn't be a need for a remove function and it is very
likely to have ordering issues given driver previously didn't
have one.

> +}
> +
>  static const struct spi_device_id bmi323_spi_ids[] = {
>  	{ "bmi323" },
>  	{ }
> @@ -83,6 +90,7 @@ static struct spi_driver bmi323_spi_driver = {
>  		.of_match_table = bmi323_of_spi_match,
>  	},
>  	.probe = bmi323_spi_probe,
> +	.remove = bmi323_spi_remove,
>  	.id_table = bmi323_spi_ids,
>  };
>  module_spi_driver(bmi323_spi_driver);


