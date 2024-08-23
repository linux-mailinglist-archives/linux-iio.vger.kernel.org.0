Return-Path: <linux-iio+bounces-8727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F2795D54C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D8928457F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447D1917EC;
	Fri, 23 Aug 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti7hbqxU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9813FB3B;
	Fri, 23 Aug 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437769; cv=none; b=jGYvgToBqSy5YawGxsx3+zQt9ndo64r22E16mg1m4k/VO8gGdN2AEn+DM7txfYw4t+FguBiVYF9FfOER3Xr/TABKWFXKrc+ydRL3JrBRO8VGXu2aUt3Nw7RXQ5yM3noPFyK7w++iA0BVOxcCICpFMUY++Oe3mOCneWgQBxj8ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437769; c=relaxed/simple;
	bh=LvfvuitCEiJXBywq+NBGoUONpAT7QaHXYK8H+DrHs54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgRBFFl56xcSSvMgb46DDlkdzuD0EJg55PDMeihNiPtSTId2z4eI+qHi6muKGBNbmmO7TGwAQ4Z3zXHLA2F2MIXGRJHX3EyCtxHHM0zcsIMSDEjhkNBgF8AEc273kqJyRWrObsS9aBau7IWm7/msBvT7sfPpDLo9VYswe2QP6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti7hbqxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E5CC32786;
	Fri, 23 Aug 2024 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724437768;
	bh=LvfvuitCEiJXBywq+NBGoUONpAT7QaHXYK8H+DrHs54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ti7hbqxUuCdusOQlQZxSnQBA94xAFEf7h+WfjwrqFTxvWmx6s9OWwVV4hxMUfyZbC
	 yy+F9P+Nye+s4rfrGkWX9ssNHPqTBapd8xytDNC6tHe9OY+JnGqX6wEzJC+RA1G0wE
	 WIrPaxDygqsffAyKz5+QnZyUwlTxBntzHQfcpzv8pSbcliAdAngaZAsgMvoc9gZNAo
	 N5j+8AFmgAZ2PRLzdJ5NNS6J9jhQjnVZP6YiZ4jgfgzQnlJBEeJcJa+ak75vHX1Wkg
	 OvosGDUhbuA+/8iexd5NSxZsJVAe9xil7g65sbNZ3zTvGOdhClhOkVvm+Y5t5N7xus
	 XpC5TPctVbq4g==
Date: Fri, 23 Aug 2024 19:29:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Luke D . Jones" <luke@ljones.dev>, Jonathan LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH v2] iio: bmi323: peripheral in lowest power state on
 suspend
Message-ID: <20240823192921.7df291f8@jic23-huawei>
In-Reply-To: <20240818150923.20387-2-benato.denis96@gmail.com>
References: <20240817134911.6043c798@jic23-huawei>
	<20240818150923.20387-1-benato.denis96@gmail.com>
	<20240818150923.20387-2-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 17:09:23 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> The bmi323 is mounted on some devices that are powered
> by an internal battery: help in reducing system overall power drain
> while the system is in s2idle or the imu driver is not loaded
> by resetting it in its lowest power draining state.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 225 ++++++++++++++++++++++++++-
>  1 file changed, 223 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 4b2b211a3e88..5d383fffe083 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -118,6 +118,84 @@ static const struct bmi323_hw bmi323_hw[2] = {
>  	},
>  };
>  
> +struct bmi323_reg_runtime_pm {
> +	unsigned int reg;
> +};
> +
> +static const struct bmi323_reg_runtime_pm bmi323_reg_savestate[] = {
Not useful to have a structure. Just use an array of unsigned int
or maybe even size them to match as u8

static const u8 bmi_regs_tosave[] = {
	BMI323_INT_MAP1_REG,
	...
};
> +	{
> +		.reg = 
> +	},
> +	{
> +		.reg = BMI323_INT_MAP2_REG
> +	},
> +	{
> +		.reg = BMI323_IO_INT_CTR_REG
> +	},
> +	{
> +		.reg = BMI323_IO_INT_CONF_REG
> +	},
> +	{
> +		.reg = BMI323_ACC_CONF_REG
> +	},
> +	{
> +		.reg = BMI323_GYRO_CONF_REG
> +	},
> +	{
> +		.reg = BMI323_FEAT_IO0_REG
> +	},
> +	{
> +		.reg = BMI323_FIFO_WTRMRK_REG
> +	},
> +	{
> +		.reg = BMI323_FIFO_CONF_REG
> +	}
> +};
> +
> +static const struct bmi323_reg_runtime_pm bmi323_ext_reg_savestate[] = {
Similar, just use a u8 array.

> +	{
> +		.reg = BMI323_GEN_SET1_REG
> +	},
> +	{
> +		.reg = BMI323_TAP1_REG
> +	},
> +	{
> +		.reg = BMI323_TAP2_REG
> +	},
> +	{
> +		.reg = BMI323_TAP3_REG
> +	},
> +	{
> +		.reg = BMI323_FEAT_IO0_S_TAP_MSK
> +	},
> +	{
> +		.reg = BMI323_STEP_SC1_REG
> +	},
> +	{
> +		.reg = BMI323_ANYMO1_REG
> +	},
> +	{
> +		.reg = BMI323_NOMO1_REG
> +	},
> +	{
> +		.reg = BMI323_ANYMO1_REG + BMI323_MO2_OFFSET
> +	},
> +	{
> +		.reg = BMI323_NOMO1_REG + BMI323_MO2_OFFSET
> +	},
> +	{
> +		.reg = BMI323_ANYMO1_REG + BMI323_MO3_OFFSET
> +	},
> +	{
> +		.reg = BMI323_NOMO1_REG + BMI323_MO3_OFFSET
> +	}
> +};

>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  
> @@ -2125,13 +2222,137 @@ EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  static int bmi323_core_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
> +
> +	int ret;
>  
> -	return iio_device_suspend_triggering(indio_dev);
> +	guard(mutex)(&data->mutex);
> +
> +	ret = iio_device_suspend_triggering(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Save registers meant to be restored by resume pm callback.
Single line comment syntax fine here.

> +	 */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
> +		const unsigned int reg_addr = bmi323_reg_savestate[i].reg;
Once this is array of u8 I'd just use it in the two places and not bother with
local variable.
> +		unsigned int *reg_val = &savestate->reg_settings[i];

I'd just use &savestate->reg_settings[i] inline and skip the local variable.

> +
> +		ret = regmap_read(data->regmap, reg_addr, reg_val);
> +		if (ret) {
> +			dev_err(data->dev, "Error reading bmi323 reg 0x%x: %d\n",
> +				  reg_addr, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Save external registers meant to be restored by resume pm callback.
> +	 */
As above, single line comment fine, if anything.  Fairly obvious what is going on.

> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> +		const unsigned int ext_reg_addr = bmi323_reg_savestate[i].reg;
> +		unsigned int *ext_reg_val = &savestate->reg_settings[i];
Likewise, local variable doesn't add thing much.
> +
> +		ret = bmi323_read_ext_reg(data, ext_reg_addr, ext_reg_val);
> +		if (ret) {
> +			dev_err(data->dev, "Error reading bmi323 external reg 0x%x: %d\n",
> +				  ext_reg_addr, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Perform soft reset to place the device in its lowest power state.
> +	 */
> +	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
>  }
>  
>  static int bmi323_core_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
> +
No blank line here. Doesn't add any value.

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
> +	/*
> +	 * Restore external registers saved by suspend pm callback.
Single line comment
> +	 */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> +		const unsigned int ext_reg_addr = bmi323_reg_savestate[i].reg;
> +		const unsigned int ext_reg_val = savestate->reg_settings[i];
comments above apply here as well.

> +
> +		ret = bmi323_write_ext_reg(data, ext_reg_addr, ext_reg_val);
> +		if (ret) {
> +			dev_err(data->dev, "Error writing bmi323 external reg 0x%x: %d\n",
> +				  ext_reg_addr, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Restore registers saved by suspend pm callback.
> +	 */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
> +		const unsigned int reg_addr = bmi323_reg_savestate[i].reg;
> +		const unsigned int reg_val = savestate->reg_settings[i];
> +
> +		ret = regmap_write(data->regmap, reg_addr, reg_val);
> +		if (ret) {
> +			dev_err(data->dev, "Error writing bmi323 reg 0x%x: %d\n",
> +				  reg_addr, ret);
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
> +	unsigned int val;

Variable declarations still in old school c style, so at the top of the scope.

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


