Return-Path: <linux-iio+bounces-6835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE0915621
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A871F2041A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EE119D8B4;
	Mon, 24 Jun 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c30ZE1Us"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B825777;
	Mon, 24 Jun 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252014; cv=none; b=qmxq/1UMq6NXVmJpa94OgenQu2gvRI/JQ2XX+XCEriHxSG2wcrWUgngpbcPDU4FPApEab+qC4hreuAY7iA5QF0czgqcP1IjnttjiFGS47j+/7RYZ+JGY2LqexLtQOR1dxF3/dAEhgaVxyyo+3RjkpU0u7TZhX8Cc6l6Y38Bf9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252014; c=relaxed/simple;
	bh=0Xm/WGUC66k9/GEqPDOOSg5hqLV17cv5gz1afRf8AXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQErSBg5O9eUp3hlXw8CQihCLSJgfjF2fKeRJTg33kHYiIAzrPQj4hfdW/KUO4EvRXPNXbaa32uo03j/hsRGcUQll1n/86EdpoZHPrpGaNWJUbuzAK71ET0C+phROB47z1k+FwZm4gT7EaHd2oKjVWmxO16cprWnvMeDREjSklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c30ZE1Us; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ce01403f6so1999413e87.0;
        Mon, 24 Jun 2024 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252007; x=1719856807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtD6i1gPZY13G55JPTPLK7nPThceMJrdWR2yk0hNFPY=;
        b=c30ZE1Us+43hiGczI5Tua4ka+z5m9n7gIBHdKTg3Cz3v6a+fp4knGKSZpckSia0YkI
         i79USeK1t5Pczh5cQjn4dgcO0SQOO9afYrhRJEOKDM2cWirFFBUNNY6Z+ANeRGSj764P
         0V3lAhLZigIZt0JqHoSlooVxQctWrepYiRI2gAU4SwEdLGxp7rAjbtrk3ORv/nRd/cgt
         /tOjZtTSq4qu24y9vCg1TDva+mle5rUVcQa40A4zv+534UnFCv9mDRPzTVBOFqipaNfc
         jkRXihu6wB+8QAfh4jEK27rhd2uqTrVXVdvE+KBk4GAx5xgAElP26JPOtmlHgqDLPgTU
         ZlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252007; x=1719856807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtD6i1gPZY13G55JPTPLK7nPThceMJrdWR2yk0hNFPY=;
        b=i9Khsk9Is1Gc50q6umItuMqi2de9hyC//tJPDcMlddUgA7HWcu0u2gpnfMOg4UmmZ2
         1KNzjuSPJH9/TAC9JWQrLDTF2lVL+FxdcJNluaY3z7ubeMNxFXPpi15DgQxZjboPji0v
         Q9+sqdwrLeQ7qNdIzE6hvLx0E8JUWMdosD0QNQMIt7OznRntlP8Bngk/84wKFAvlSUp+
         Iofs1yUsh/hdNAqorzq90pupsQgIxrOjHzmrC18ZpgCVNcIOIM5qxq5n+15sEtMicuVT
         EHVLLevtXrDlvLmhwQtW4bAjl3mUPlLwDbbTClxAS+owc7Nmpu6xdsyWv/3v+aJM767q
         PvxA==
X-Forwarded-Encrypted: i=1; AJvYcCV4AZm9e+RYsMebUgGVv5JGBOD4IBObaIq2QSxaDTQ12YG97Wv8wXRrQAFV1zRkui2a11cEQ7If/orJ1LUD6hTnhNb4g0py8eVE8iyH5sXis0ji1MAjBzv67mZQQw8BzG7518orRQ==
X-Gm-Message-State: AOJu0YyZNTvOaJa5J57Cj/E+lACv08veX4+g56aH2/TEUrHOTZUGkSZi
	Ibl6SNOZVPnamkr2pZ2+6n3YFS+T4QoKqtM2RHdefXRb8CyMau5b
X-Google-Smtp-Source: AGHT+IErUQ8Qo9crMy0jN0qXELxCe3EoRxXENkV0HBOjGTSJkmBfiRo+8XnISBFWjcz33Eo4AqgAcg==
X-Received: by 2002:a05:6512:3484:b0:52c:d7cd:1fa2 with SMTP id 2adb3069b0e04-52ce1835b32mr2660561e87.26.1719252007178;
        Mon, 24 Jun 2024 11:00:07 -0700 (PDT)
Received: from [192.168.1.18] (175.131-179-91.adsl-dyn.isp.belgacom.be. [91.179.131.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724b5545desm192978066b.112.2024.06.24.11.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:00:06 -0700 (PDT)
Message-ID: <b46cc0bc-144d-44e5-bce4-8a309761e091@gmail.com>
Date: Mon, 24 Jun 2024 20:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] power: supply: axp20x_usb_power: Add support for
 AXP717
To: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, broonie@kernel.org, lee@kernel.org,
 samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org,
 wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-7-macroalpha82@gmail.com>
Content-Language: en-US
From: Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <20240617220535.359021-7-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

sysfs correctly reports presence of USB power and voltages, tested on
RG35XX-H (H700)

Tested-by: Philippe Simons <simons.philippe@gmail.com>

On 18/06/24 00:05, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add support for the AXP717 PMIC. The AXP717 PMIC allows for detection
> of USB type like the AXP813, but has little in common otherwise with
> the other AXP PMICs. The USB charger is able to provide between
> 100000uA and 3250000uA of power, and can measure the VBUS input in mV
> with up to 14 bits of precision.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   drivers/power/supply/axp20x_usb_power.c | 350 +++++++++++++++++++++---
>   1 file changed, 314 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index dae7e5cfc54e..c442dd005831 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -30,8 +30,13 @@
>   #define AXP20X_PWR_STATUS_VBUS_PRESENT	BIT(5)
>   #define AXP20X_PWR_STATUS_VBUS_USED	BIT(4)
>   
> +#define AXP717_PWR_STATUS_VBUS_GOOD	BIT(5)
> +
>   #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
>   
> +#define AXP717_PMU_FAULT_VBUS		BIT(5)
> +#define AXP717_PMU_FAULT_VSYS		BIT(3)
> +
>   #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
>   #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
>   #define AXP20X_VBUS_VHOLD_OFFSET	3
> @@ -39,12 +44,20 @@
>   #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
>   #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
>   
> +#define AXP717_INPUT_VOL_LIMIT_MASK	GENMASK(3, 0)
> +#define AXP717_INPUT_CUR_LIMIT_MASK	GENMASK(5, 0)
> +#define AXP717_ADC_DATA_MASK		GENMASK(14, 0)
> +
> +#define AXP717_ADC_EN_VBUS_VOLT		BIT(2)
> +
>   /*
>    * Note do not raise the debounce time, we must report Vusb high within
>    * 100ms otherwise we get Vbus errors in musb.
>    */
>   #define DEBOUNCE_TIME			msecs_to_jiffies(50)
>   
> +struct axp20x_usb_power;
> +
>   struct axp_data {
>   	const struct power_supply_desc	*power_desc;
>   	const char * const		*irq_names;
> @@ -58,6 +71,10 @@ struct axp_data {
>   	struct reg_field		usb_bc_det_fld;
>   	struct reg_field		vbus_disable_bit;
>   	bool				vbus_needs_polling: 1;
> +	void (*axp20x_read_vbus)(struct work_struct *work);
> +	int (*axp20x_cfg_iio_chan)(struct platform_device *pdev,
> +				   struct axp20x_usb_power *power);
> +	int (*axp20x_cfg_adc_reg)(struct axp20x_usb_power *power);
>   };
>   
>   struct axp20x_usb_power {
> @@ -74,6 +91,7 @@ struct axp20x_usb_power {
>   	struct iio_channel *vbus_v;
>   	struct iio_channel *vbus_i;
>   	struct delayed_work vbus_detect;
> +	int max_input_cur;
>   	unsigned int old_status;
>   	unsigned int online;
>   	unsigned int num_irqs;
> @@ -136,6 +154,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
>   		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
>   }
>   
> +static void axp717_usb_power_poll_vbus(struct work_struct *work)
> +{
> +	struct axp20x_usb_power *power =
> +		container_of(work, struct axp20x_usb_power, vbus_detect.work);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &val);
> +	if (ret)
> +		return;
> +
> +	val &= AXP717_PWR_STATUS_VBUS_GOOD;
> +	if (val != power->old_status)
> +		power_supply_changed(power->supply);
> +
> +	power->old_status = val;
> +}
> +
>   static int axp20x_get_usb_type(struct axp20x_usb_power *power,
>   			       union power_supply_propval *val)
>   {
> @@ -281,6 +317,84 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>   	return 0;
>   }
>   
> +static int axp717_usb_power_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +	unsigned int v;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +		ret = regmap_read(power->regmap, AXP717_PMU_FAULT_VBUS, &v);
> +		if (ret)
> +			return ret;
> +
> +		v &= (AXP717_PMU_FAULT_VBUS | AXP717_PMU_FAULT_VSYS);
> +		if (v) {
> +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +			regmap_write(power->regmap, AXP717_PMU_FAULT_VBUS, v);
> +		}
> +
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = regmap_read(power->regmap, AXP717_INPUT_CUR_LIMIT_CTRL, &v);
> +		if (ret)
> +			return ret;
> +
> +		/* 50ma step size with 100ma offset. */
> +		v &= AXP717_INPUT_CUR_LIMIT_MASK;
> +		val->intval = (v * 50000) + 100000;
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &v);
> +		if (ret)
> +			return ret;
> +		val->intval = !!(v & AXP717_PWR_STATUS_VBUS_GOOD);
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return axp20x_get_usb_type(power, val);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		ret = regmap_read(power->regmap, AXP717_INPUT_VOL_LIMIT_CTRL, &v);
> +		if (ret)
> +			return ret;
> +
> +		/* 80mv step size with 3.88v offset. */
> +		v &= AXP717_INPUT_VOL_LIMIT_MASK;
> +		val->intval = (v * 80000) + 3880000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
> +			ret = iio_read_channel_processed(power->vbus_v,
> +							 &val->intval);
> +			if (ret)
> +				return ret;
> +
> +			/*
> +			 * IIO framework gives mV but Power Supply framework
> +			 * gives uV.
> +			 */
> +			val->intval *= 1000;
> +			return 0;
> +		}
> +
> +		ret = axp20x_read_variable_width(power->regmap,
> +						 AXP717_VBUS_V_H, 16);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = (ret % AXP717_ADC_DATA_MASK) * 1000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +}
> +
>   static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>   					    int intval)
>   {
> @@ -307,16 +421,40 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>   	return -EINVAL;
>   }
>   
> +static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> +					    int intval)
> +{
> +	int val;
> +
> +	/* Minimum value of 3.88v and maximum of 5.08v. */
> +	if (intval < 3880000 || intval > 5080000)
> +		return -EINVAL;
> +
> +	/* step size of 80ma with 3.88v offset. */
> +	val = (intval - 3880000) / 80000;
> +	return regmap_update_bits(power->regmap,
> +				  AXP717_INPUT_VOL_LIMIT_CTRL,
> +				  AXP717_INPUT_VOL_LIMIT_MASK, val);
> +}
> +
>   static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
>   						    int intval)
>   {
> -	int ret;
> +	int ret, val;
>   	unsigned int reg;
>   	const unsigned int max = power->axp_data->curr_lim_table_size;
>   
>   	if (intval == -1)
>   		return -EINVAL;
>   
> +	if (power->max_input_cur && (intval > power->max_input_cur)) {
> +		val = power->max_input_cur;
> +		dev_warn(power->dev,
> +			 "reqested current %d clamped to max current %d\n",
> +			 intval, power->max_input_cur);
> +	} else
> +		val = intval;
> +
>   	/*
>   	 * BC1.2 detection can cause a race condition if we try to set a current
>   	 * limit while it's in progress. When it finishes it will overwrite the
> @@ -331,15 +469,39 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
>   	}
>   
>   	for (reg = max - 1; reg > 0; reg--)
> -		if (power->axp_data->curr_lim_table[reg] <= intval)
> +		if (power->axp_data->curr_lim_table[reg] <= val)
>   			break;
>   
>   	dev_dbg(power->dev, "setting input current limit reg to %d (%d uA), requested %d uA",
> -		reg, power->axp_data->curr_lim_table[reg], intval);
> +		reg, power->axp_data->curr_lim_table[reg], val);
>   
>   	return regmap_field_write(power->curr_lim_fld, reg);
>   }
>   
> +static int axp717_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
> +						    int intval)
> +{
> +	int val, tmp;
> +
> +	/* Minimum value of 100mA and maximum value of 3.25A*/
> +	if (intval < 100000 || intval > 3250000)
> +		return -EINVAL;
> +
> +	if (power->max_input_cur && (intval > power->max_input_cur)) {
> +		val = power->max_input_cur;
> +		dev_warn(power->dev,
> +			 "reqested current %d clamped to max current %d\n",
> +			 intval, power->max_input_cur);
> +	} else
> +		val = intval;
> +
> +	/* Minimum value of 100mA with step size of 50mA. */
> +	tmp = (val - 100000) / 50000;
> +	return regmap_update_bits(power->regmap,
> +				  AXP717_INPUT_CUR_LIMIT_CTRL,
> +				  AXP717_INPUT_CUR_LIMIT_MASK, tmp);
> +}
> +
>   static int axp20x_usb_power_set_property(struct power_supply *psy,
>   					 enum power_supply_property psp,
>   					 const union power_supply_propval *val)
> @@ -366,6 +528,26 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
>   	return -EINVAL;
>   }
>   
> +static int axp717_usb_power_set_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return axp717_usb_power_set_input_current_limit(power, val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return axp717_usb_power_set_voltage_min(power, val->intval);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
>   					   enum power_supply_property psp)
>   {
> @@ -385,6 +567,64 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
>   	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
>   }
>   
> +static int axp717_usb_power_prop_writeable(struct power_supply *psy,
> +					   enum power_supply_property psp)
> +{
> +	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> +	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> +}
> +
> +static int axp20x_configure_iio_channels(struct platform_device *pdev,
> +					 struct axp20x_usb_power *power)
> +{
> +	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> +	if (IS_ERR(power->vbus_v)) {
> +		if (PTR_ERR(power->vbus_v) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(power->vbus_v);
> +	}
> +
> +	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
> +	if (IS_ERR(power->vbus_i)) {
> +		if (PTR_ERR(power->vbus_i) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(power->vbus_i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int axp717_configure_iio_channels(struct platform_device *pdev,
> +					 struct axp20x_usb_power *power)
> +{
> +	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> +	if (IS_ERR(power->vbus_v)) {
> +		if (PTR_ERR(power->vbus_v) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(power->vbus_v);
> +	}
> +
> +	return 0;
> +}
> +
> +static int axp20x_configure_adc_registers(struct axp20x_usb_power *power)
> +{
> +	/* Enable vbus voltage and current measurement */
> +	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> +				  AXP20X_ADC_EN1_VBUS_CURR |
> +				  AXP20X_ADC_EN1_VBUS_VOLT,
> +				  AXP20X_ADC_EN1_VBUS_CURR |
> +				  AXP20X_ADC_EN1_VBUS_VOLT);
> +}
> +
> +static int axp717_configure_adc_registers(struct axp20x_usb_power *power)
> +{
> +	/* Enable vbus voltage measurement  */
> +	return regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
> +				  AXP717_ADC_EN_VBUS_VOLT,
> +				  AXP717_ADC_EN_VBUS_VOLT);
> +}
> +
>   static enum power_supply_property axp20x_usb_power_properties[] = {
>   	POWER_SUPPLY_PROP_HEALTH,
>   	POWER_SUPPLY_PROP_PRESENT,
> @@ -403,6 +643,16 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
>   	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>   };
>   
> +static enum power_supply_property axp717_usb_power_properties[] = {
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
>   static enum power_supply_property axp813_usb_power_properties[] = {
>   	POWER_SUPPLY_PROP_HEALTH,
>   	POWER_SUPPLY_PROP_PRESENT,
> @@ -439,6 +689,18 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
>   	.set_property = axp20x_usb_power_set_property,
>   };
>   
> +static const struct power_supply_desc axp717_usb_power_desc = {
> +	.name = "axp20x-usb",
> +	.type = POWER_SUPPLY_TYPE_USB,
> +	.properties = axp717_usb_power_properties,
> +	.num_properties = ARRAY_SIZE(axp717_usb_power_properties),
> +	.property_is_writeable = axp717_usb_power_prop_writeable,
> +	.get_property = axp717_usb_power_get_property,
> +	.set_property = axp717_usb_power_set_property,
> +	.usb_types = axp813_usb_types,
> +	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
> +};
> +
>   static const struct power_supply_desc axp813_usb_power_desc = {
>   	.name = "axp20x-usb",
>   	.type = POWER_SUPPLY_TYPE_USB,
> @@ -505,6 +767,9 @@ static const struct axp_data axp192_data = {
>   	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
>   	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
>   	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
> +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
>   };
>   
>   static const struct axp_data axp202_data = {
> @@ -516,6 +781,9 @@ static const struct axp_data axp202_data = {
>   	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
>   	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
>   	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
> +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
>   };
>   
>   static const struct axp_data axp221_data = {
> @@ -526,6 +794,9 @@ static const struct axp_data axp221_data = {
>   	.curr_lim_table_size = ARRAY_SIZE(axp221_usb_curr_lim_table),
>   	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
>   	.vbus_needs_polling = true,
> +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
>   };
>   
>   static const struct axp_data axp223_data = {
> @@ -536,6 +807,23 @@ static const struct axp_data axp223_data = {
>   	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
>   	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
>   	.vbus_needs_polling = true,
> +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
> +};
> +
> +static const struct axp_data axp717_data = {
> +	.power_desc     = &axp717_usb_power_desc,
> +	.irq_names      = axp22x_irq_names,
> +	.num_irq_names  = ARRAY_SIZE(axp22x_irq_names),
> +	.curr_lim_fld   = REG_FIELD(AXP717_INPUT_CUR_LIMIT_CTRL, 0, 5),
> +	.usb_bc_en_bit  = REG_FIELD(AXP717_MODULE_EN_CONTROL_1, 4, 4),
> +	.usb_bc_det_fld = REG_FIELD(AXP717_BC_DETECT, 5, 7),
> +	.vbus_mon_bit   = REG_FIELD(AXP717_ADC_CH_EN_CONTROL, 2, 2),
> +	.vbus_needs_polling = false,
> +	.axp20x_read_vbus = &axp717_usb_power_poll_vbus,
> +	.axp20x_cfg_iio_chan = axp717_configure_iio_channels,
> +	.axp20x_cfg_adc_reg = axp717_configure_adc_registers,
>   };
>   
>   static const struct axp_data axp813_data = {
> @@ -549,6 +837,9 @@ static const struct axp_data axp813_data = {
>   	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
>   	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
>   	.vbus_needs_polling = true,
> +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
>   };
>   
>   #ifdef CONFIG_PM_SLEEP
> @@ -590,36 +881,6 @@ static int axp20x_usb_power_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(axp20x_usb_power_pm_ops, axp20x_usb_power_suspend,
>   						  axp20x_usb_power_resume);
>   
> -static int configure_iio_channels(struct platform_device *pdev,
> -				  struct axp20x_usb_power *power)
> -{
> -	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> -	if (IS_ERR(power->vbus_v)) {
> -		if (PTR_ERR(power->vbus_v) == -ENODEV)
> -			return -EPROBE_DEFER;
> -		return PTR_ERR(power->vbus_v);
> -	}
> -
> -	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
> -	if (IS_ERR(power->vbus_i)) {
> -		if (PTR_ERR(power->vbus_i) == -ENODEV)
> -			return -EPROBE_DEFER;
> -		return PTR_ERR(power->vbus_i);
> -	}
> -
> -	return 0;
> -}
> -
> -static int configure_adc_registers(struct axp20x_usb_power *power)
> -{
> -	/* Enable vbus voltage and current measurement */
> -	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> -				  AXP20X_ADC_EN1_VBUS_CURR |
> -				  AXP20X_ADC_EN1_VBUS_VOLT,
> -				  AXP20X_ADC_EN1_VBUS_CURR |
> -				  AXP20X_ADC_EN1_VBUS_VOLT);
> -}
> -
>   static int axp20x_regmap_field_alloc_optional(struct device *dev,
>   					      struct regmap *regmap,
>   					      struct reg_field fdesc,
> @@ -640,6 +901,18 @@ static int axp20x_regmap_field_alloc_optional(struct device *dev,
>   	return 0;
>   }
>   
> +/* Optionally allow users to specify a maximum charging current. */
> +static void axp20x_charger_parse_dt_property(struct device *dev,
> +					     struct axp20x_usb_power *power)
> +{
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "input-current-limit-microamp",
> +				       &power->max_input_cur);
> +	if (ret)
> +		dev_dbg(dev, "%s() no input-current-limit specified\n", __func__);
> +}
> +
>   static int axp20x_usb_power_probe(struct platform_device *pdev)
>   {
>   	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> @@ -676,6 +949,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>   	if (IS_ERR(power->curr_lim_fld))
>   		return PTR_ERR(power->curr_lim_fld);
>   
> +	axp20x_charger_parse_dt_property(&pdev->dev, power);
> +
>   	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
>   						 axp_data->vbus_valid_bit,
>   						 &power->vbus_valid_bit);
> @@ -707,7 +982,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
> -					   axp20x_usb_power_poll_vbus);
> +					   axp_data->axp20x_read_vbus);
>   	if (ret)
>   		return ret;
>   
> @@ -718,9 +993,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>   			return ret;
>   
>   		if (IS_ENABLED(CONFIG_AXP20X_ADC))
> -			ret = configure_iio_channels(pdev, power);
> +			ret = axp_data->axp20x_cfg_iio_chan(pdev, power);
>   		else
> -			ret = configure_adc_registers(power);
> +			ret = axp_data->axp20x_cfg_adc_reg(power);
>   
>   		if (ret)
>   			return ret;
> @@ -778,6 +1053,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
>   	}, {
>   		.compatible = "x-powers,axp223-usb-power-supply",
>   		.data = &axp223_data,
> +	}, {
> +		.compatible = "x-powers,axp717-usb-power-supply",
> +		.data = &axp717_data,
>   	}, {
>   		.compatible = "x-powers,axp813-usb-power-supply",
>   		.data = &axp813_data,

