Return-Path: <linux-iio+bounces-15579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FEA37575
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032C83B0212
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085F19992E;
	Sun, 16 Feb 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+FO5G5J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EC9450;
	Sun, 16 Feb 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722275; cv=none; b=VUWSwxmgVu1BkmKjXnuZIsiNvjNovS609hht1H8BE4YruGs7Aqr7g2UHB2YIW3DKpZWD6pBVPYmdsIgEPPUX2xHT3dLlkx/c9fYbZwglr3hL05+cH4e1J+5XHW9bHzEV39ByJRplyh0Fv9yBkVnKwzgbqLqcsPPzzL4NC5jTccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722275; c=relaxed/simple;
	bh=XAWrhCGN45tpx8caT486P0l1EH8KLKqSD6UCAFLSjD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKPYO1mFKg/9x8itpbg/xLZTZQcns7GQBgWegbrov3KgNDS0MEY+Jmj7h4BcoNzoGGzLcscXeSo+u8kfIrjR7jvJ9QFgO3DrzTWyKzYVjgq+drr8G0bEvvLV0CpN3rXcHy/1hIBV1VlwDFV8yoKz6Mxl/X7/BvQ8jfFesVNIIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+FO5G5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4230BC4CEDD;
	Sun, 16 Feb 2025 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722274;
	bh=XAWrhCGN45tpx8caT486P0l1EH8KLKqSD6UCAFLSjD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+FO5G5Jy8Z63jYTLIS2u16jOeAiFAQWfW3POycL3MvrWLEIFChboyu7Yy8Qtb3z4
	 IuASHVAzileRUt/5gX9NSqmT/3ZEIsarK4s/StP9sLQsH8JWODjZsdUAahn9wM4syc
	 9x/6Zz1ijPnMu6/5bCu3clFbM/lW4v3Rk3u7z2IyhmUNGJzWSJ6tyVwsJJoqy/fCog
	 yi4iIpgFP3XkzjwNiPEEUzo9gSKe6G2MODxu+XncLuAqnWqiaNAJRKuINvXwTVK6Sk
	 EedHznWUWjlJlf+BoKH7YwdgqHQQVwO5Mwx0DLmXi36L+C8+1f3DcnUrzZWt3SflNF
	 sJYIOr59G0iGQ==
Date: Sun, 16 Feb 2025 16:11:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH RESEND v3 11/17] iio: adc: ad7768-1: add regulator to
 control VCM output
Message-ID: <20250216161103.13e03d6d@jic23-huawei>
In-Reply-To: <3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:17:54 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Whilst this is a pretty simple regulator driver, I would still +CC
the maintainers for regulators in same way you would for
a standalone regulator driver.

+CC Liam and Mark


> ---
> v3 Changes:
> * Register VCM output via the regulator framework for improved flexibility
>   and external integration.
> 
> v2 Changes:
> * VCM output support is now defined by a devicetree property, instead of 
>   and IIO attribute.
> ---
>  drivers/iio/adc/ad7768-1.c | 138 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 378245bce199..a359cd8fceca 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -12,8 +12,10 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regulator/driver.h>
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
>  
> @@ -80,9 +82,15 @@
>  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
>  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
>  
> +/* AD7768_REG_ANALOG2 */
> +#define AD7768_REG_ANALOG2_VCM_MSK	GENMASK(2, 0)
> +#define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, x)
> +
>  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
>  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
>  
> +#define AD7768_VCM_OFF			0x08
> +
>  enum ad7768_conv_mode {
>  	AD7768_CONTINUOUS,
>  	AD7768_ONE_SHOT,
> @@ -160,6 +168,7 @@ struct ad7768_state {
>  	struct regmap *regmap;
>  	struct regmap *regmap24;
>  	struct regulator *vref;
> +	struct regulator_dev *vcm_rdev;
>  	struct clk *mclk;
>  	unsigned int mclk_freq;
>  	unsigned int samp_freq;
> @@ -643,6 +652,130 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
>  					       &ad7768_buffer_ops);
>  }
>  
> +static int ad7768_vcm_enable(struct regulator_dev *rdev)
> +{
> +	struct ad7768_state *st = rdev_get_drvdata(rdev);
> +	int ret, val;
> +
> +	if (!st)
> +		return -EINVAL;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* if regulator is off, turn it on */
> +	if (FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) == AD7768_VCM_OFF)
> +		return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +					  AD7768_REG_ANALOG2_VCM_MSK, 0x00);
> +
> +	return 0;
> +}
> +
> +static int ad7768_vcm_disable(struct regulator_dev *rdev)
> +{
> +	struct ad7768_state *st = rdev_get_drvdata(rdev);
> +
> +	if (!st)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				  AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
> +}
> +
> +static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct ad7768_state *st = rdev_get_drvdata(rdev);
> +	int ret, val;
> +
> +	if (!st)
> +		return -EINVAL;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) == AD7768_VCM_OFF)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int ad7768_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	unsigned int regval = AD7768_REG_ANALOG2_VCM(selector + 1);
> +	struct ad7768_state *st = rdev_get_drvdata(rdev);
> +
> +	if (!st)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				  AD7768_REG_ANALOG2_VCM_MSK, regval);
> +}
> +
> +static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct ad7768_state *st = rdev_get_drvdata(rdev);
> +	int ret, val;
> +
> +	if (!st)
> +		return -EINVAL;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) - 1;
> +	val = clamp(val, 0, 8);
> +
> +	return val;
> +}
> +
> +static const struct regulator_ops vcm_regulator_ops = {
> +	.enable = ad7768_vcm_enable,
> +	.disable = ad7768_vcm_disable,
> +	.is_enabled = ad7768_vcm_is_enabled,
> +	.list_voltage = regulator_list_voltage_table,
> +	.set_voltage_sel = ad7768_set_voltage_sel,
> +	.get_voltage_sel = ad7768_get_voltage_sel,
> +};
> +
> +static const unsigned int vcm_voltage_table[] = {
> +	2500000,
> +	2050000,
> +	1650000,
> +	1900000,
> +	1100000,
> +	900000,
> +};
> +
> +static const struct regulator_desc vcm_desc = {
> +	.name = "vcm_output",
> +	.of_match = of_match_ptr("vcm_output"),
> +	.regulators_node = of_match_ptr("regulators"),
> +	.n_voltages = ARRAY_SIZE(vcm_voltage_table),
> +	.volt_table = vcm_voltage_table,
> +	.ops = &vcm_regulator_ops,
> +	.type = REGULATOR_VOLTAGE,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int ad7768_register_regulators(struct device *dev, struct ad7768_state *st)
> +{
> +	struct regulator_config config = {
> +		.dev = dev,
> +		.driver_data = st,
> +	};
> +
> +	st->vcm_rdev = devm_regulator_register(dev, &vcm_desc, &config);
> +	if (IS_ERR(st->vcm_rdev))
> +		return dev_err_probe(dev, PTR_ERR(st->vcm_rdev),
> +				     "failed to register VCM regulator\n");
> +
> +	return 0;
> +}
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
> @@ -707,6 +840,11 @@ static int ad7768_probe(struct spi_device *spi)
>  	indio_dev->info = &ad7768_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	/* Register VCM output regulator */
> +	ret = ad7768_register_regulators(&spi->dev, st);
> +	if (ret)
> +		return ret;
> +
>  	ret = ad7768_setup(st);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "AD7768 setup failed\n");


