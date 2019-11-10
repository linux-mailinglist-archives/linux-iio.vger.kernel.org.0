Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF6F69AD
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKJPbW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:31:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfKJPbV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:31:21 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F356E20818;
        Sun, 10 Nov 2019 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573399880;
        bh=UztXM8ShL4PmEpfWnj8q6bHUnpj2qjXDwcqfBgHkOGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bztF040k6mX36MiVWNW25Apy00yVe5wdd5PD0uy659MGncCqgGEyzQeB0snEXshUB
         AzmDfvMaQeC/Ts/yj3MywFLxAuygzL8zvtFSBtJkKk2GyrNCK4qpmbRTkq9SHudi/g
         RI7qs3kwjdvjndMpLO+1Q8EIIQ5iDq0VpYLK//rM=
Date:   Sun, 10 Nov 2019 15:31:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: mpu6050: Add support for vdd-supply
 regulator
Message-ID: <20191110153114.687ce6fb@archlinux>
In-Reply-To: <20191107184342.20361-2-stephan@gerhold.net>
References: <20191107184342.20361-1-stephan@gerhold.net>
        <20191107184342.20361-2-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  7 Nov 2019 19:43:42 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> MPU6050 has two power supply pins: VDD and VLOGIC, but the
> mpu6050 driver only supports enabling one of them at the moment.
> In some cases, they may need to be enabled separately.
> 
> Add an additional "vdd-supply" that stays enabled for as long as
> the driver is loaded. We cannot turn off the VDD regulator during
> suspend as this would cause register settings (FSR, sampling rate, ...)
> to be lost.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke it.

Thanks

Jonathan

> ---
> Changes in v2:
>   - Keep "vdd-supply" enabled during suspend to prevent register
>     settings from getting lost.
>   - Revert convertion to bulk regulator API (does not work well
>     when regulators need to be enabled/disabled separately)
> 
> v1: https://lore.kernel.org/linux-iio/20191106183536.123070-2-stephan@gerhold.net/
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 43 +++++++++++++++++-----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 +-
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 354030e9bed5..661a829478f5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1140,14 +1140,14 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	return result;
>  }
>  
> -static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
> +static int inv_mpu_core_enable_regulator_vddio(struct inv_mpu6050_state *st)
>  {
>  	int result;
>  
>  	result = regulator_enable(st->vddio_supply);
>  	if (result) {
>  		dev_err(regmap_get_device(st->map),
> -			"Failed to enable regulator: %d\n", result);
> +			"Failed to enable vddio regulator: %d\n", result);
>  	} else {
>  		/* Give the device a little bit of time to start up. */
>  		usleep_range(35000, 70000);
> @@ -1156,21 +1156,29 @@ static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
>  	return result;
>  }
>  
> -static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)
> +static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
>  {
>  	int result;
>  
>  	result = regulator_disable(st->vddio_supply);
>  	if (result)
>  		dev_err(regmap_get_device(st->map),
> -			"Failed to disable regulator: %d\n", result);
> +			"Failed to disable vddio regulator: %d\n", result);
>  
>  	return result;
>  }
>  
>  static void inv_mpu_core_disable_regulator_action(void *_data)
>  {
> -	inv_mpu_core_disable_regulator(_data);
> +	struct inv_mpu6050_state *st = _data;
> +	int result;
> +
> +	result = regulator_disable(st->vdd_supply);
> +	if (result)
> +		dev_err(regmap_get_device(st->map),
> +			"Failed to disable vdd regulator: %d\n", result);
> +
> +	inv_mpu_core_disable_regulator_vddio(st);
>  }
>  
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> @@ -1239,6 +1247,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return -EINVAL;
>  	}
>  
> +	st->vdd_supply = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(st->vdd_supply)) {
> +		if (PTR_ERR(st->vdd_supply) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vdd regulator %d\n",
> +				(int)PTR_ERR(st->vdd_supply));
> +
> +		return PTR_ERR(st->vdd_supply);
> +	}
> +
>  	st->vddio_supply = devm_regulator_get(dev, "vddio");
>  	if (IS_ERR(st->vddio_supply)) {
>  		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
> @@ -1248,9 +1265,17 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return PTR_ERR(st->vddio_supply);
>  	}
>  
> -	result = inv_mpu_core_enable_regulator(st);
> -	if (result)
> +	result = regulator_enable(st->vdd_supply);
> +	if (result) {
> +		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
>  		return result;
> +	}
> +
> +	result = inv_mpu_core_enable_regulator_vddio(st);
> +	if (result) {
> +		regulator_disable(st->vdd_supply);
> +		return result;
> +	}
>  
>  	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
>  				 st);
> @@ -1352,7 +1377,7 @@ static int inv_mpu_resume(struct device *dev)
>  	int result;
>  
>  	mutex_lock(&st->lock);
> -	result = inv_mpu_core_enable_regulator(st);
> +	result = inv_mpu_core_enable_regulator_vddio(st);
>  	if (result)
>  		goto out_unlock;
>  
> @@ -1370,7 +1395,7 @@ static int inv_mpu_suspend(struct device *dev)
>  
>  	mutex_lock(&st->lock);
>  	result = inv_mpu6050_set_power_itg(st, false);
> -	inv_mpu_core_disable_regulator(st);
> +	inv_mpu_core_disable_regulator_vddio(st);
>  	mutex_unlock(&st->lock);
>  
>  	return result;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 52fcf45050a5..4fcf683b9c63 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -130,7 +130,8 @@ struct inv_mpu6050_hw {
>   *  @chip_period:	chip internal period estimation (~1kHz).
>   *  @it_timestamp:	timestamp from previous interrupt.
>   *  @data_timestamp:	timestamp for next data sample.
> - *  @vddio_supply	voltage regulator for the chip.
> + *  @vdd_supply:	VDD voltage regulator for the chip.
> + *  @vddio_supply	I/O voltage regulator for the chip.
>   *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
>   *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
>   *  @magn_orient:       magnetometer sensor chip orientation if available.
> @@ -154,6 +155,7 @@ struct inv_mpu6050_state {
>  	s64 chip_period;
>  	s64 it_timestamp;
>  	s64 data_timestamp;
> +	struct regulator *vdd_supply;
>  	struct regulator *vddio_supply;
>  	bool magn_disabled;
>  	s32 magn_raw_to_gauss[3];

