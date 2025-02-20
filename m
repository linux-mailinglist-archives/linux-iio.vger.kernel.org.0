Return-Path: <linux-iio+bounces-15903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED12A3E768
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DB042223E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED02139D4;
	Thu, 20 Feb 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sBJ5I6Ei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1421323F
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090056; cv=none; b=Q8NMDK+FmNhDQCoE/qZCfznLYTRiBOPxfKiXxEtbkSD6t4uaDinjm9bHgVjCYCE2+CQ74iC+8Q47lZCOaNcSZcUS0rFMjNMQN1g/V36Ea+xgOczW+LRXderPyOC178l5d4Ys8seAsbUSIWk0BBxAIUQZ3ULIzSgVru422WrQ7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090056; c=relaxed/simple;
	bh=PvZPfATyzGF1tVyo/MZSWBFBHWCB9OQhB2o1jTc8GJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+Y3sUkIhbJrldx1QqiUOh0VB5469m5LTk8BdeyPOz+ee4BD8Dvym7LzZMrqNR7ISLkv1V+HbYOLxvH+tAEJx4n1NC7MIkZizjevzIGPV9qb7lH4qYKpn4+z3w9U5IGYWLAKXlzwaTuVajcwTM/H96cyzfaec3q/Ch8xLYMQJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sBJ5I6Ei; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2addd5053c0so860158fac.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 14:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740090053; x=1740694853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l3YRo0sHIKd5+q1opgKK8wbmOtDjari2OwXIj19kio=;
        b=sBJ5I6EiEI44JiPU+7tMCE9ArxxGTocX/Q58iy1C4q9mXpbJLHxIF1An1CQVTUbm1L
         v521tCYcN7j2W6adNqfNShMUN3YdLnYKSAe1pEHaN145DzkV4KZ7+vCZ5ljF221eUhYA
         JOrqDcuGdqe6FGGx/zsw+2U3CG4jaJeJCIhXWz/t7Gvk+LBG4Wt9sqpXaDmSELV9SKd5
         qgfV0i5JJFvjKeTeaV2pU0oG+HCLKL9rpSEfcB3g+veZ5Ozj5sZ6IdFtIoKalqIP8tyE
         xloADgsfkcSLAMYS5hU0yit0vKEIoOl2o0pAskAbjdDLST9NXa6gqIlFtQy4eN0dYBu6
         BPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090053; x=1740694853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9l3YRo0sHIKd5+q1opgKK8wbmOtDjari2OwXIj19kio=;
        b=FDK+/DtcmWfYEIBVcxtXHNExMRvak8qf0pkPhgRLxUb2e3b9DQTD1glhbP7srKL3BA
         1tyJqO6sDicBagRs3C+sri3tgyKww1KsKfxyCpePKOnHJ2gAWeT40FX/dKHg0ZCajrpW
         HLkUuWpPm6CBt5rlBpZv7qvwd5Ggb7Dn72dmXkY/YplmOl+sV80I9NEY3t7OFOS8MMQM
         fHXUqO4icTyhS9yHdhpBnUk5y6sNNqVeRybHHHz5iyEi+mCpqn/+NdcbOuTYjzw9PUH7
         YM+8+qy9dMfx5JPrdn68aBJ2bnUtMbHVImBitVDNber3O9rPHWrgepKgsOqh+C61ksmi
         uWsw==
X-Forwarded-Encrypted: i=1; AJvYcCXsEjcRichpw5neoh+xLkl2dOUEUTnuS5hs23R1I0o/9PY6uTaiTmhH2p9GgkkuSgXn5Teoh1+r89A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ci+ZSOeYYmIvMpmyFy4gCD8stJ8SHvxnChKmEJd7ib5Pldwf
	B1BT72iSKlE2txRQ66b5N3PRhdFRgH36IFWgy4tI9vqokB85mJKzp6z/QUqJTx4hv/2vTrAcxMt
	C
X-Gm-Gg: ASbGncvn7WCR0gYeGdmrour/W7v8H3pjva9IKUlb+V9r8kRxqo3UVkN4LxEV+t41ewr
	PPGBg/Se8dBd/H7pRHGfudp8tOFY+sO3hqpyCd5CnHfaHFA482NQgJb8pvQaN01E25JRKnAIyCK
	U35nK4+qEogHi6wkbtbQc92z9vDtii+LAqNlB9KyXurtajk++jdbbduEel0XP2VmEQtu2rK+Tyn
	g9jqgLYjf64VdHpbvby2PGNkvf9vDge9N6WRi/8P7QPd4OJi0IYkmBjJparY8OycWDnVIXjvYEI
	9le6d2WJwr7mGoVDsRwU/UOezusx0+Sbc8uuGjgrh7CidYsP1/xB
X-Google-Smtp-Source: AGHT+IFLprTqXD6AwHy0OPaYFNoGmTsAOzA9ewOyAfm2dF8T++sTHcgNv9F8unuvzoRTHlN4VzoNnA==
X-Received: by 2002:a05:6870:46a5:b0:29e:5ffa:b769 with SMTP id 586e51a60fabf-2bd50f3729emr799439fac.29.1740090052911;
        Thu, 20 Feb 2025 14:20:52 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272737d70dsm2434883a34.42.2025.02.20.14.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 14:20:52 -0800 (PST)
Message-ID: <2bc93cdf-e6d0-4879-a637-04db0bfe45aa@baylibre.com>
Date: Thu, 20 Feb 2025 16:20:51 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 11/17] iio: adc: ad7768-1: add regulator to
 control VCM output
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:17 PM, Jonathan Santos wrote:
> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
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

Do we need iio_device_claim_direct_mode() here to prevent accessing
registers on the ADC during a buffered read?

Same applies to other functions too.

> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* if regulator is off, turn it on */
> +	if (FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) == AD7768_VCM_OFF)

regmap_update_bits() already does this sort of check internally, so
open-coding it here is redundant.

> +		return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +					  AD7768_REG_ANALOG2_VCM_MSK, 0x00);

Can be simplified with regmap_clear_bits().

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

Could skip the if and just return directly.

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

It looks like this is typically a datasheet name, like

"AD7768-1 VCM"

> +	.of_match = of_match_ptr("vcm_output"),

"vcm-output" as in DT bindings review.

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


