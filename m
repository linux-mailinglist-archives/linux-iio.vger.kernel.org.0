Return-Path: <linux-iio+bounces-16527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA4A56A69
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA975177C92
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF0121B1BC;
	Fri,  7 Mar 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Actd3/V4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBA1547C0;
	Fri,  7 Mar 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357925; cv=none; b=P25fIOA4VBxzMFzVwKiueQlU5bO5QYI9NygpZ4ItMvLacTmibyNtqk7Wvt4ppV9J0HEuVhKxSr9fUZDrgZa4Yd3MMzHhnMe3UPyiXagtWPpFHYgaCsU2uL+BUnffVMYb1FM1sIOBa9ei55bFcMAXYR+VvWbUuANCLRUrXEiW+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357925; c=relaxed/simple;
	bh=D7PjqOAh9SKjXHiL9afXsgsvVJDJHo2uy8CQAes/kWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgUB8jqtbKADklNkzz3BBlbhqZp6nvDlyu/00JJkK2beOS1SxVSs8Bu646ouwyXeDpIHl+KbgEaFCoe1h5l19nQmwQaDZo36yKmoK77IYeVDotMAu+3I6PtMV5n2eTnv5DsC52XFkwpY+8jnbEu8lONougIiX072VaL87njhIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Actd3/V4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234bec7192so5365585ad.2;
        Fri, 07 Mar 2025 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741357923; x=1741962723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkjFWxvpSWuoPGTgzoz3W9lo19IOJLxr0YDfumLq/hY=;
        b=Actd3/V4BgTMljq6BWX7sw8oRWfKeFRDdAQKEKnXIoBRjmZdQ/t8xiaVrRure2a6UT
         ftctRVbLd3Hnpo2naLRDyZQqXQ/vfzHLvJU3qLkg9V8s7iVXtHM5QjXFX+AwuoRaudV5
         OyZNGn0/mUXyLWHTjBZf3M4MQPgy2HiWtaGoqlcZKc+uZNNOP/jFVbqETyFgn+zyuKGs
         DkkDl8craKFK+LBXgHN6HGiLZ3SR3OCjWkTwqCm27qlmJ2tOAiCDFzvnK5zPxGdR7Xwb
         TTTEZMw9PBkWazBgTKqY9Aw42bwtX1526VyOA+8TJY/5WYIKTHgBwfgzw3p+YgGK9WDD
         zPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741357923; x=1741962723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkjFWxvpSWuoPGTgzoz3W9lo19IOJLxr0YDfumLq/hY=;
        b=jgf9Qdo4biNzWBoD+a3Lur+y8z65th1CXJGswxNLxuQl9a3uUuKLeCIHCyh5uKp+4N
         MfCCYGVtNxuwff2lOSvY8pb83HB2eqI8oArH8H4Br4ViePqkjKfBJuwDgEQeiyhezj1o
         4tXvrWXiOj03r81kC3m/VrwIDe06U3ZLp8Z/j/OAL7VkPj5OM1QK8zZ6IYBlUxnHvFRZ
         wdVMqi8519EKgcR/3XD51XCKWOOMJkmcI3k9djA6s0G1HFVPwuHAFHlsUnZ8MoDM/3Tj
         y4hUB1XvQBuNScVufETtd4gwoD4NJrbv5jOpTOFHbyfL4Vu9TnYgVR4gFouU5e5bsMwW
         Mylg==
X-Forwarded-Encrypted: i=1; AJvYcCU6x26alKCZob7Yfp0nFQDGH4Vk3w4vhH5UJkPZCjHMUONq+XHk5ndNI9c513z1SavFxfb3B58RrBMtww==@vger.kernel.org, AJvYcCUtq9shV7KzcYtZlluAcTklh/Ho422v3ivPaOv2sgit9HpPKEy0u+7JPzQ79R7QjgQH9f3T/4KTqWWq@vger.kernel.org, AJvYcCXdfWO/FXGlRAmMTgIOeQB1enFE5kVkaCBNjLSuGLJTityasH8A7n06hdzF7yUyq/vqp5Qp4WX3xm8xwKzl@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP/BuEWdWtchzQVQYzHHlhhg/yTlwtlTW6zYgG0TDIpkt/7Hc
	IVuEHV+0l81NfRPHcJqniiqXVIokHAsghcwW5oiAuCW0e8c1uiHG
X-Gm-Gg: ASbGncvs5bknk0/4qmCcBoq36XismmFeXh04QJnOnzIECsfgKJlziHUOcuYJiZpZ7+z
	3UixuExcogxHeS2XJHWZB5kmPGI7fxSc9MPiHycUj2MVM03Fl8ZDAHFa+HpsJNZ/tC/2GpQSdiO
	PAveGJ/yiMk+ud+MR6L9rJTyguyCDrvy/3e+stewQIQYbWQtzgiP6vGEbD4JdXJzmchFdOrGzWv
	KFyiZs1XwZBDGPIfJNLA5sxykm4B9oEEOvex7iYcXScQL1l46+rp37HKLBz+DQ4X4T+gYv0/wwo
	8HTW+zmV71L3XZFfJqtpNgsJaMoAJtSVg0ngxof7MMzEzZe1lGziDg==
X-Google-Smtp-Source: AGHT+IEGhrQ335K3XW6S574DK86uaSTUMYHRtvp9Cj7tim0GA1sP3eT0MXM02+TNiSPz6pbU1kJPUA==
X-Received: by 2002:a05:6a21:6d97:b0:1e1:e2d9:7f0a with SMTP id adf61e73a8af0-1f544c60385mr7121808637.34.1741357923419;
        Fri, 07 Mar 2025 06:32:03 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af28126dc75sm2593446a12.50.2025.03.07.06.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:32:02 -0800 (PST)
Date: Fri, 7 Mar 2025 11:32:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 11/17] iio: adc: ad7768-1: add regulator to control
 VCM output
Message-ID: <Z8sDlsOX0Elauabg@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <40c586006b5cee0570ae577db2b58e6e7e36a6e6.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c586006b5cee0570ae577db2b58e6e7e36a6e6.1741268122.git.Jonathan.Santos@analog.com>

Looks ok. One minor commnet inline.

On 03/06, Jonathan Santos wrote:
> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> ---
> v4 Changes:
> * Added iio_device_claim_direct_mode() to regulator callbacks to avoid register access
>   while in buffered mode.
> * Changed regulator name to "ad7768-1-vcm".
> * When regulator enable is called, it will set the last voltage selector configured.
> * Disabled regulator before configuring it.
> * Adressed other nits.
> 
> v3 Changes:
> * Register VCM output via the regulator framework for improved flexibility
>   and external integration.
> 
> v2 Changes:
> * VCM output support is now defined by a devicetree property, instead of 
>   and IIO attribute.
> ---
>  drivers/iio/adc/Kconfig    |   1 +
>  drivers/iio/adc/ad7768-1.c | 181 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a2fdb7e03a66..d8f2ed477ba7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -277,6 +277,7 @@ config AD7766
>  config AD7768_1
>  	tristate "Analog Devices AD7768-1 ADC driver"
>  	depends on SPI
> +	select REGULATOR
>  	select REGMAP_SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGER
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index e88e9431bb7a..2a6317f5b582 100644
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

Should we enforce macro argument evaluation here?
#define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, (x))

> +
>  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
>  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
>  
> +#define AD7768_VCM_OFF			0x07
> +
>  enum ad7768_conv_mode {
>  	AD7768_CONTINUOUS,
>  	AD7768_ONE_SHOT,
> @@ -160,6 +168,8 @@ struct ad7768_state {
>  	struct regmap *regmap;
>  	struct regmap *regmap24;
>  	struct regulator *vref;
> +	struct regulator_dev *vcm_rdev;
> +	unsigned int vcm_output_sel;
>  	struct clk *mclk;
>  	unsigned int mclk_freq;
>  	unsigned int samp_freq;
> @@ -644,6 +654,172 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
>  					       &ad7768_buffer_ops);
>  }
>  
> +static int ad7768_vcm_enable(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, regval;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* To enable, set the last selected output */
> +	regval = AD7768_REG_ANALOG2_VCM(st->vcm_output_sel + 1);
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, regval);
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_vcm_disable(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	ret = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) != AD7768_VCM_OFF;
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	unsigned int regval = AD7768_REG_ANALOG2_VCM(selector + 1);
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, regval);
> +	iio_device_release_direct_mode(indio_dev);
> +	st->vcm_output_sel = selector;
> +
> +	return ret;
> +}
> +
> +static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val);
> +	ret = clamp(val, 1, (int)rdev->desc->n_voltages) - 1;
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
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
> +	.name = "ad7768-1-vcm",
> +	.of_match = of_match_ptr("vcm-output"),
> +	.regulators_node = of_match_ptr("regulators"),
> +	.n_voltages = ARRAY_SIZE(vcm_voltage_table),
> +	.volt_table = vcm_voltage_table,
> +	.ops = &vcm_regulator_ops,
> +	.type = REGULATOR_VOLTAGE,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int ad7768_register_regulators(struct device *dev, struct ad7768_state *st,
> +				      struct iio_dev *indio_dev)
> +{
> +	struct regulator_config config = {
> +		.dev = dev,
> +		.driver_data = indio_dev,
> +	};
> +	int ret;
> +
> +	/* Disable the regulator before registering it */
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
> +	if (ret)
> +		return -EINVAL;
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
> @@ -708,6 +884,11 @@ static int ad7768_probe(struct spi_device *spi)
>  	indio_dev->info = &ad7768_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	/* Register VCM output regulator */
> +	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = ad7768_setup(st);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "AD7768 setup failed\n");
> -- 
> 2.34.1
> 

