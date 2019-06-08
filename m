Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE60F39FE5
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFHN3I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfFHN3I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:29:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8851121537;
        Sat,  8 Jun 2019 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560000547;
        bh=FVfrwNl8W0tvPxxUwwFg4qUbga7KhOZB7dxWkSysKkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3nqXbFb0RcSnNmuTDvP3mPSKSdYADJntDY6+L834oFu+HmLgYTEC3EgZ3jpL4wiR
         upZfVw3ZA1s1TsPXq2+7G0+0mTCN3aU3USUAgwPMdZAIPkoV6n8J/SDY3aXewPWM4z
         o1Rgm1EZNV5DYTaqx3xMYZvPE6FyoCuBFwGcql2s=
Date:   Sat, 8 Jun 2019 14:29:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: temperature: add a driver for the temperature
 sensor found in Amlogic Meson G12 SoCs
Message-ID: <20190608142901.4f45f29e@archlinux>
In-Reply-To: <20190604144714.2009-4-glaroque@baylibre.com>
References: <20190604144714.2009-1-glaroque@baylibre.com>
        <20190604144714.2009-4-glaroque@baylibre.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  4 Jun 2019 16:47:14 +0200
Guillaume La Roque <glaroque@baylibre.com> wrote:

> The code is based on Amlogic source code. No public datasheet for this.
> Currently the G12A SoCs are supported.
> 
> Supported features:
> - possibility to set an automatic reboot temperature
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
A few comments inline.

However, I'm still of the view this is probably better as a thermal
driver than an IIO one.

Jonathan
> ---
>  drivers/iio/temperature/Kconfig         |  11 +
>  drivers/iio/temperature/Makefile        |   1 +
>  drivers/iio/temperature/meson_tsensor.c | 416 ++++++++++++++++++++++++
>  3 files changed, 428 insertions(+)
>  create mode 100644 drivers/iio/temperature/meson_tsensor.c
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 737faa0901fe..712a0062790d 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -34,6 +34,17 @@ config HID_SENSOR_TEMP
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hid-sensor-temperature.
>  
> +config MESON_TSENSOR
> +	tristate "Amlogic Meson temperature sensor Support"
> +	default ARCH_MESON
> +	depends on OF && ARCH_MESON
> +	help
> +	  If you say yess here you get support for Meson Temperature sensor
> +	  for G12 SoC Family.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called meson_tsensor.
> +
>  config MLX90614
>  	tristate "MLX90614 contact-less infrared sensor"
>  	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index baca4776ca0d..466d8c1c91d6 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>  obj-$(CONFIG_MAX31856) += max31856.o
> +obj-$(CONFIG_MESON_TSENSOR) += meson_tsensor.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/meson_tsensor.c b/drivers/iio/temperature/meson_tsensor.c
> new file mode 100644
> index 000000000000..be0a8d073ba3
> --- /dev/null
> +++ b/drivers/iio/temperature/meson_tsensor.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson Temperature Sensor
> + *
> + * Copyright (C) 2017 Huan Biao <huan.biao@amlogic.com>
> + * Copyright (C) 2019 Guillaume La Roque <glaroque@baylibre.com>
> + *
> + * Register value to celsius temperature formulas:
> + *	Read_Val	    m * U
> + * U = ---------, Uptat = ---------
> + *	2^16		  1 + n * U
> + *
> + * Temperature = A * ( Uptat + u_efuse / 2^16 )- B
> + *
> + *  A B m n : calibration parameters
> + *  u_efuse : fused calibration value, it's a signed 16 bits value
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iio/iio.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define TSENSOR_CFG_REG1			0x4
> +	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
> +	#define TSENSOR_CFG_REG1_RSET_ADC	BIT(11)
> +	#define TSENSOR_CFG_REG1_VCM_EN		BIT(10)
> +	#define TSENSOR_CFG_REG1_VBG_EN		BIT(9)
> +	#define TSENSOR_CFG_REG1_OUT_CTL	BIT(6)
> +	#define TSENSOR_CFG_REG1_FILTER_EN	BIT(5)
> +	#define TSENSOR_CFG_REG1_DEM_EN		BIT(3)
> +	#define TSENSOR_CFG_REG1_CH_SEL		GENMASK(1, 0)
> +	#define TSENSOR_CFG_REG1_ENABLE		\
> +		(TSENSOR_CFG_REG1_FILTER_EN |	\
> +		 TSENSOR_CFG_REG1_VCM_EN |	\
> +		 TSENSOR_CFG_REG1_VBG_EN |	\
> +		 TSENSOR_CFG_REG1_DEM_EN |	\
> +		 TSENSOR_CFG_REG1_CH_SEL)
> +
> +#define TSENSOR_CFG_REG2				0x8
> +	#define TSENSOR_CFG_REG2_HITEMP_EN		BIT(31)
> +	#define TSENSOR_CFG_REG2_REBOOT_ALL_EN		BIT(30)
> +	#define TSENSOR_CFG_REG2_REBOOT_TIME		GENMASK(25, 16)
> +	#define TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE	\
> +		(TSENSOR_CFG_REG2_HITEMP_EN |		\
> +		 TSENSOR_CFG_REG2_REBOOT_ALL_EN |	\
> +		 TSENSOR_CFG_REG2_REBOOT_TIME)
> +	#define TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE_MASK		\
> +		(GENMASK(31, 30) | GENMASK(25, 4))
> +	#define TSENSOR_CFG_REG2_HITEMP_REBOOT_REG_MASK			\
> +		GENMASK(15, 4)
> +	#define TSENSOR_CFG_REG2_HITEMP_REG_VAL(_reg_val)		\
> +		(FIELD_PREP(TSENSOR_CFG_REG2_HITEMP_REBOOT_REG_MASK,	\
> +			    _reg_val) |					\
> +		 TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE)
> +
> +#define TSENSOR_CFG_REG3		0xC
> +#define TSENSOR_CFG_REG4		0x10
> +#define TSENSOR_CFG_REG5		0x14
> +#define TSENSOR_CFG_REG6		0x18
> +#define TSENSOR_CFG_REG7		0x1C
> +#define TSENSOR_CFG_REG8		0x20
> +
> +#define TSENSOR_STAT0			0x40
> +
> +#define TSENSOR_STAT9			0x64
> +
> +#define TSENSOR_READ_TEMP_MASK		GENMASK(15, 0)
> +#define TSENSOR_TEMP_MASK		GENMASK(11, 0)
> +
> +#define TSENSOR_TRIM_SIGN_MASK		BIT(15)
> +#define TSENSOR_TRIM_TEMP_MASK		GENMASK(14, 0)
> +#define TSENSOR_TRIM_VERSION_MASK	GENMASK(31, 24)
> +
> +#define TSENSOR_TRIM_VERSION(_version) 	\
> +	FIELD_GET(TSENSOR_TRIM_VERSION_MASK, _version)

I'd just use the FIELD_GET directly inline.  What it is doing
is kind of obvious from the parameter.

> +
> +#define TSENSOR_TRIM_CALIB_VALID_MASK	(GENMASK(3, 2) | BIT(7))
> +
> +#define TSENSOR_CALIB_OFFSET	1
> +#define TSENSOR_CALIB_SHIFT	4
> +
> +static const struct iio_chan_spec temperature_channel[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.channel = 0,
.channel doesn't do anything unless you set indexed.
> +		.address = 0,
.address not used...

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +/**
> + * struct meson_tsensor_soc_data
> + * @A, B, m, n: calibration parameters
> + * This structure is required for configuration of meson tsensor driver.
> + */
> +struct meson_tsensor_soc_data {
> +	int A;
> +	int B;
> +	int m;
> +	int n;
> +};
> +
> +/**
> + * struct meson_tsensor_data
> + * @u_efuse_off: register offset to read fused calibration value
> + * @soc: calibration parameters structure pointer
> + * @regmap_config: regmap config for the device
> + * This structure is required for configuration of meson tsensor driver.
> + */
> +struct meson_tsensor_data {
> +	int u_efuse_off;
> +	const struct meson_tsensor_soc_data *soc;
> +	const struct regmap_config *regmap_config;
> +};
> +
> +struct meson_tsensor {
> +	int id;
> +	const struct meson_tsensor_data *data;
> +	struct regmap *regmap;
> +	struct regmap *sec_ao_map;
> +	struct clk *clk;
> +	u32 trim_info;
> +	void __iomem *base;
> +	int reboot_temp;
> +};
> +
> +/*
> + * tsensor treats temperature as a mapped temperature code.
> + * The temperature is converted differently depending on the calibration type.
> + */
> +static u32 temp_to_code(struct meson_tsensor *priv, int temp)
> +{
> +	const struct meson_tsensor_soc_data *param = priv->data->soc;
> +	s64 divisor, factor, uefuse;
> +	u32 reg_code;
> +
> +	uefuse = priv->trim_info & TSENSOR_TRIM_SIGN_MASK ?
> +			 ~(priv->trim_info & TSENSOR_TRIM_TEMP_MASK) + 1 :
> +			 (priv->trim_info & TSENSOR_TRIM_TEMP_MASK);
> +
> +	factor = BIT(16) * (temp * 10 + param->B);
> +	factor = div_s64(factor, param->A);
> +	factor = factor + uefuse;
> +
> +	factor = factor * 100;
> +
> +	divisor = param->n * factor;
> +	divisor = div_s64(divisor, BIT(16));
> +	divisor = param->m - divisor;
> +
> +	reg_code = div_s64(factor, divisor);
> +	reg_code = ((reg_code >> TSENSOR_CALIB_SHIFT) & TSENSOR_TEMP_MASK) +
> +		   TSENSOR_CALIB_OFFSET;
> +
> +	return reg_code;
> +}
> +
> +/*
> + * Calculate a temperature value from a temperature code.
> + * The unit of the temperature is degree Celsius.
> + */
> +static int code_to_temp(struct meson_tsensor *priv, int temp_code)
> +{
> +	const struct meson_tsensor_soc_data *param = priv->data->soc;
> +	int temp;
> +	s64 factor, Uptat, uefuse;
> +
> +	uefuse = priv->trim_info & TSENSOR_TRIM_SIGN_MASK ?
> +			     ~(priv->trim_info & TSENSOR_TRIM_TEMP_MASK) + 1 :
> +			     (priv->trim_info & TSENSOR_TRIM_TEMP_MASK);
Hmm. 2's complement from unsigned + a sign bit.

uefuse = priv->trim_info & TSENSOR_TRIM_TEMP_MASK;
if (priv->trim_info & TSENSOR_TRIM_SIGN_MASK)
	uefuse *= -1;

Is probably going to do the same thing whilst being more readable.

> +
> +	factor = param->n * temp_code;
> +	factor = div_s64(factor, 100);
> +
> +	Uptat = temp_code * param->m;
Why the capital U?  Not really kernel style.
> +	Uptat = div_s64(Uptat, 100);
> +	Uptat = Uptat * BIT(16);
> +	Uptat = div_s64(Uptat, BIT(16) + factor);
> +
> +	temp = (Uptat + uefuse) * param->A;
> +	temp = div_s64(temp, BIT(16));
> +	temp = (temp - param->B) * 100;
> +
> +	return temp;
> +}
> +
> +static int meson_tsensor_initialize(struct iio_dev *indio_dev)
> +{
> +	struct meson_tsensor *priv = iio_priv(indio_dev);
> +	u32 reg_val;
> +	int ret = 0;
> +	int ver;
> +
> +	regmap_read(priv->sec_ao_map, priv->data->u_efuse_off,
> +		    &priv->trim_info);
> +
> +	ver = TSENSOR_TRIM_VERSION(priv->trim_info);
> +
> +	if ((ver & TSENSOR_TRIM_CALIB_VALID_MASK) == 0) {
> +		ret = -EINVAL;
> +		dev_err(&indio_dev->dev,
> +			"tsensor thermal calibration not supported: 0x%x!\n",
> +			ver);
> +		goto out;
return -EINVAL;
> +	}
> +
> +	/* init the ts reboot soc function */
> +	if (priv->reboot_temp) {
> +		/* register need value in celsius */
> +		reg_val = temp_to_code(priv, priv->reboot_temp / 1000);
> +		regmap_update_bits(priv->regmap, TSENSOR_CFG_REG2,
> +				   TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE_MASK,
> +				   TSENSOR_CFG_REG2_HITEMP_REG_VAL(reg_val));
> +	}
> +
return 0;
> +out:
> +	return ret;
> +}
> +
> +static int meson_tsensor_enable(struct iio_dev *indio_dev)
> +{
> +	struct meson_tsensor *priv = iio_priv(indio_dev);
> +
> +	clk_prepare_enable(priv->clk);
> +	regmap_update_bits(priv->regmap, TSENSOR_CFG_REG1,
> +			   TSENSOR_CFG_REG1_ENABLE, TSENSOR_CFG_REG1_ENABLE);
> +
> +	return 0;
Given neither this nor the follow up have any error paths,
stop them having a return value and you can drop some error handling..

> +}
> +
> +static int meson_tsensor_disable(struct iio_dev *indio_dev)
> +{
> +	struct meson_tsensor *priv = iio_priv(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, TSENSOR_CFG_REG1,
> +			   TSENSOR_CFG_REG1_ENABLE, 0);
> +	clk_disable(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int meson_tsensor_read(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	unsigned int tvalue;
> +	struct meson_tsensor *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		regmap_read(priv->regmap, TSENSOR_STAT0, &tvalue);
> +		*val = code_to_temp(priv,
> +				    tvalue & TSENSOR_READ_TEMP_MASK);
Looks to me like this will fit on one line under 80 chars.

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info meson_tsensor_iio_info = {
> +	.read_raw = &meson_tsensor_read,
> +};
> +
> +static const struct regmap_config meson_tsensor_regmap_config_g12a = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = TSENSOR_STAT9,
> +};
> +
> +static const struct meson_tsensor_soc_data meson_tsensor_g12a = {
> +	.A = 9411,
> +	.B = 3159,
> +	.m = 424,
> +	.n = 324,
> +};
> +
> +static const struct meson_tsensor_data meson_tsensor_g12a_cpu_param = {
> +	.u_efuse_off = 0x128,
> +	.soc = &meson_tsensor_g12a,
> +	.regmap_config = &meson_tsensor_regmap_config_g12a,
> +};
> +
> +static const struct meson_tsensor_data meson_tsensor_g12a_ddr_param = {
> +	.u_efuse_off = 0xF0,
> +	.soc = &meson_tsensor_g12a,
> +	.regmap_config = &meson_tsensor_regmap_config_g12a,
I'm going to guess there is support for other devices on it's way where
the regmap_config and soc are different?

If it is going to be a while I'd prefer you moved them into this param
structure only when you need to.

> +};
> +
> +static const struct of_device_id meson_tsensor_of_match[] = {
> +	{
> +		.compatible = "amlogic,meson-g12a-ddr-tsensor",

Given we don't do a match on the compatible without the type specified
g12a-tsensor, is there any reason to have that in the binding?

> +		.data = &meson_tsensor_g12a_ddr_param,
> +	},
> +	{
> +		.compatible = "amlogic,meson-g12a-cpu-tsensor",
> +		.data = &meson_tsensor_g12a_cpu_param,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, meson_tsensor_of_match);
> +
> +static int meson_tsensor_probe(struct platform_device *pdev)
> +{
> +	struct meson_tsensor *priv;
> +	struct iio_dev *indio_dev;
> +	struct resource *res;
> +
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv = iio_priv(indio_dev);
> +	priv->data = of_device_get_match_data(&pdev->dev);
> +	if (!priv->data) {
> +		dev_err(&pdev->dev, "failed to get match data\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev->channels = temperature_channel;
> +	indio_dev->num_channels = ARRAY_SIZE(temperature_channel);
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &meson_tsensor_iio_info;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->regmap = devm_regmap_init_mmio(&pdev->dev, priv->base,
> +					     priv->data->regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get clock\n");
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	if (of_property_read_u32(pdev->dev.of_node,
> +				 "amlogic,critical-temperature",
> +				 &priv->reboot_temp)) {
> +		priv->reboot_temp = 0;
> +	}
> +
> +	priv->sec_ao_map = syscon_regmap_lookup_by_phandle
> +		(pdev->dev.of_node, "amlogic,ao-secure");
> +	if (IS_ERR(priv->sec_ao_map)) {
> +		dev_err(&pdev->dev, "syscon regmap lookup failed.\n");
> +		return PTR_ERR(priv->sec_ao_map);
> +	}
> +
> +	ret = meson_tsensor_initialize(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = meson_tsensor_enable(indio_dev);
> +	if (ret)
> +		goto err;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_hw;
> +
> +	return 0;
> +
> +err_hw:
> +	meson_tsensor_disable(indio_dev);
> +err:
> +	clk_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static int meson_tsensor_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return meson_tsensor_disable(indio_dev);

Is there a missing clk_unprepare in here?
One option to think about is whether to use devm_add_action_or_reset
to move all cleanup into the device managed queue.  That way you can
drop the error handling in probe and get rid of remove entirely.

> +}
> +
> +static struct platform_driver meson_tsensor_driver = {
> +	.probe = meson_tsensor_probe,
> +	.remove = meson_tsensor_remove,
> +	.driver = {
> +			.name = "meson-tsensor",
> +			.of_match_table = meson_tsensor_of_match,
> +		},
> +};
> +
> +module_platform_driver(meson_tsensor_driver);
> +
> +MODULE_AUTHOR("Guillaume La Roque <glaroque@baylibre.com>");
> +MODULE_DESCRIPTION("Amlogic Meson Temperature Sensor Driver");
> +MODULE_LICENSE("GPL v2");

