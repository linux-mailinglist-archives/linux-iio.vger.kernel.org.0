Return-Path: <linux-iio+bounces-11391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D449B1D3E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFD11F214E4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4213AA2A;
	Sun, 27 Oct 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezBeS0EN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442340849;
	Sun, 27 Oct 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730025022; cv=none; b=Fg6TZ4AfAkl1ApdJQ6q2TWuMZkBpc+s4Jy8HnA/bCIor8KqFHxBpowosQlRSJWzKYVIrniqVMNhuuwb3ek1YjHlP4hRrjbW+6Uhm0OYPRL1M32wfJFRYaxRicqnfQ7U9Ra6+sQGFUnKd5Qr6a+73+2V2yHytfQueKZwdQuG/3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730025022; c=relaxed/simple;
	bh=7n96grImI12MhhgoEFSYkUuA3tu9WoinnlFhwCWD814=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkpwsuSX3rw4GK9TgR1mLZaya/GOoaoGTPkABJESS93vPRyPZXqR9kE/bmAqgVeq70bjltQyD4vk49oN4fqDiuogsxTDuON6VVWw9+XWN3wbdqGtvJjHZ0CnePaAFOl6YMlAnu4ENrWarfNm7Atr+F68oAMz2yOJohSSvlzVByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezBeS0EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF52C4CEC3;
	Sun, 27 Oct 2024 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730025021;
	bh=7n96grImI12MhhgoEFSYkUuA3tu9WoinnlFhwCWD814=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezBeS0ENO2Wtvy1MXJFehF8YVqzl+90F/wAAVEe0ESn1Zd2kihMFdj2WSteTYNSkd
	 8VEmARpo5zWqqdmQvLH94X+0yUvyWWX1Np2cmc/2m0twEG+IBhlyE2EYRAZxPMi83v
	 BQ8vp0BnzwRYEil71gVYtrPHafrLh7Xqqa4KTs5udlqmFsj1F7ctAH8vOrTZpw2Z6s
	 r3BC3SyJeSDKHb5SBoY/7nX7CFzb1s3KTpiuYq5almrJw/CDN8NIdN0Pl7+z2lwdSl
	 AHkv7nN2OVCHVWtTuVRW48k+MlDn54CD/dw6RfO7PikmI3EhYOLKDgBCiNyH4uDZad
	 hY9BHItFP1AXw==
Date: Sun, 27 Oct 2024 10:30:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: chemical: bme680: add power management
Message-ID: <20241027103013.06daac42@jic23-huawei>
In-Reply-To: <20241021195316.58911-14-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-14-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:16 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add runtime power management to the device. To facilitate this, add also
> a struct dev* inside the bme680_data structure to have the device
> accesible from the data structure.

Needs an update as you are now getting that from the regmap.


> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      |   2 +
>  drivers/iio/chemical/bme680_core.c | 126 +++++++++++++++++++++++++++--
>  2 files changed, 121 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index e5d82a6d5b59..74e97e35e35a 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -2,6 +2,7 @@
>  #ifndef BME680_H_
>  #define BME680_H_
>  
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  
>  #define BME680_REG_CHIP_ID			0xD0
> @@ -82,6 +83,7 @@
>  #define BME680_CALIB_RANGE_3_LEN               5
>  
>  extern const struct regmap_config bme680_regmap_config;
> +extern const struct dev_pm_ops bme680_dev_pm_ops;

You seem to have missed the changes that use this in the i2c and spi drivers.


>  static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
>  
>  static IIO_CONST_ATTR(oversampling_ratio_available,
> @@ -1091,6 +1125,39 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	pm_runtime_get_sync(dev);
> +	return 0;
> +}
> +
> +static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops bme680_buffer_setup_ops = {
> +	.preenable = bme680_buffer_preenable,
> +	.postdisable = bme680_buffer_postdisable,
> +};
> +
> +static void bme680_pm_disable(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_put_noidle(dev);
This dance is to get the device powered up on runtime pm tear down
I think?  Whilst we sometimes do this, why is it needed in this particular driver?

> +	pm_runtime_disable(dev);
> +}
> +
>  int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		      const char *name)
>  {
> @@ -1164,15 +1231,60 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
>  					      bme680_trigger_handler,
> -					      NULL);
> +					      &bme680_buffer_setup_ops);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "iio triggered buffer setup failed\n");
>  
> +	/* Enable runtime PM */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);

Take a look at what this unwinds in the devm handler. You don't need to do
as much (or possibly anything) yourself.


> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_put(dev);
> +
> +	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
>  
> +static int bme680_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bme680_data *data = iio_priv(indio_dev);
> +
> +	return regulator_bulk_disable(BME680_NUM_SUPPLIES, data->supplies);
> +}
> +
> +static int bme680_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(BME680_STARTUP_TIME_US);
> +
> +	ret = bme680_chip_config(data);
> +	if (ret)
> +		return ret;
> +
> +	return bme680_gas_config(data);
> +}
> +
> +EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
> +			  bme680_runtime_resume, NULL);
> +
>  MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
>  MODULE_DESCRIPTION("Bosch BME680 Driver");
>  MODULE_LICENSE("GPL v2");


