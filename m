Return-Path: <linux-iio+bounces-6737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629D691384C
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 08:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14031F22645
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B27376E4;
	Sun, 23 Jun 2024 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixw+Ad+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCAF374DD;
	Sun, 23 Jun 2024 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719123575; cv=none; b=RGgMvSyv+jQlpJTc69KoO8Nnb72gL/tMXTAjxiK8IWh5AOE+v54d5WIuwSwn6ixj/fflnALA5+HzdEsNINpoI24Ws77ABxIjZHDpvvpEnlgk/IgwcWhshGq+QteUl2yxb7Si5LMAnOj/+s3LXBRt5VPewrDVZe2tv+twCI4Yh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719123575; c=relaxed/simple;
	bh=PyWz14lICtcNstzD0lj725o67jSg/mpp7SPnKA0lpO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFOetWzA3Xxm1tZorQaY0qbkO/NwAZ63MP6wXePkzjSgFJA+OfAYHq3n2QqVbMSjxQfdQDuhcHDseX9TLPlo7lhz07dkNon2Mu/zcR/buaypZailX1OrbFMaNshxxPImNibhxv/Oos8NHxtwI7cOuyLhDPc5HeeYPiHTQ7fxV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixw+Ad+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F02C2BD10;
	Sun, 23 Jun 2024 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719123575;
	bh=PyWz14lICtcNstzD0lj725o67jSg/mpp7SPnKA0lpO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ixw+Ad+4qHsDPSQ6g7jfpIoc5csq/dg73hRiT7/qyGeg80eD0FoKK9NSDEYetR4xe
	 nZ/Mvf2USnw5l0dGoCp/p/Oser35NrIBdlgbEikqu35KCl5TLjxRWQMNuPKBaASadd
	 eq3UC8oUzqv8TEmd2WrJmLVguJAW4D3SvmPwRImAv48h2PtociZS7wctD4qMxZu9by
	 VlmlWzh583/r7BcYoFOXKrEyHke6ETDkYkHy2dyze0StM//RMO7/00WbErBZ1Ob+iM
	 zlPfBwTp1jBtksgM9anAEM84QKDv3xR0f3hcavMo+X3HZxGUO8AQ0+vZKIc2QbuQlr
	 8w050gD0y3H2w==
Received: by wens.tw (Postfix, from userid 1000)
	id 1F6AC5FA33; Sun, 23 Jun 2024 14:19:32 +0800 (CST)
Date: Sun, 23 Jun 2024 14:19:32 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] power: supply: axp20x_battery: add support for AXP717
Message-ID: <Zne-dClfoIH533BU@wens.tw>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-8-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220535.359021-8-macroalpha82@gmail.com>

On Mon, Jun 17, 2024 at 05:05:34PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 PMIC battery charger. The AXP717 differs
> greatly from existing AXP battery chargers in that it cannot measure
> the discharge current. The datasheet does not document the current
> value's offset or scale, so the POWER_SUPPLY_PROP_CURRENT_NOW is left
> unscaled.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 580 +++++++++++++++++++++++---
>  1 file changed, 531 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 6ac5c80cfda2..f09a56948642 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -32,9 +32,19 @@
>  #include <linux/mfd/axp20x.h>
>  
>  #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
> +#define AXP717_PWR_STATUS_MASK		GENMASK(6, 5)
> +#define AXP717_PWR_STATUS_BAT_STANDBY	(0 << 5)
> +#define AXP717_PWR_STATUS_BAT_CHRG	(1 << 5)
> +#define AXP717_PWR_STATUS_BAT_DISCHRG	(2 << 5)
>  
>  #define AXP20X_PWR_OP_BATT_PRESENT	BIT(5)
>  #define AXP20X_PWR_OP_BATT_ACTIVATED	BIT(3)
> +#define AXP717_PWR_OP_BATT_PRESENT	BIT(3)
> +
> +#define AXP717_BATT_PMU_FAULT_MASK	GENMASK(2, 0)
> +#define AXP717_BATT_UVLO_2_5V		(1 << 2)
> +#define AXP717_BATT_OVER_TEMP		(1 << 1)
> +#define AXP717_BATT_UNDER_TEMP		(1 << 0)
>  
>  #define AXP209_FG_PERCENT		GENMASK(6, 0)
>  #define AXP22X_FG_VALID			BIT(7)
> @@ -49,20 +59,50 @@
>  #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
>  #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
>  
> +#define AXP717_CHRG_ENABLE		BIT(1)
> +#define AXP717_CHRG_CV_VOLT_MASK	GENMASK(2, 0)
> +#define AXP717_CHRG_CV_4_0V		0
> +#define AXP717_CHRG_CV_4_1V		1
> +#define AXP717_CHRG_CV_4_2V		2
> +#define AXP717_CHRG_CV_4_35V		3
> +#define AXP717_CHRG_CV_4_4V		4
> +/* Values 5 and 6 reserved. */
> +#define AXP717_CHRG_CV_5_0V		7
> +
>  #define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
>  
>  #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
> +#define AXP717_ICC_CHARGER_LIM		GENMASK(5, 0)

AXP717_ICC_CHARGER_LIM_MASK

> +
> +#define AXP717_ITERM_CHG_LIM		GENMASK(3, 0)

AXP717_ITERM_CHG_LIM_MASK

> +#define AXP717_ITERM_CC_STEP		64000
>  
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> +#define AXP717_V_OFF_MASK		GENMASK(6, 4)
> +
> +#define AXP717_BAT_VMIN_MIN_UV		2600000
> +#define AXP717_BAT_VMIN_MAX_UV		3300000
> +#define AXP717_BAT_VMIN_STEP		100000
> +#define AXP717_BAT_CV_MIN_UV		4000000
> +#define AXP717_BAT_CV_MAX_UV		5000000
> +#define AXP717_BAT_CC_MIN_UA		0
> +#define AXP717_BAT_CC_MAX_UA		3008000
>  
>  struct axp20x_batt_ps;
>  
>  struct axp_data {
> -	int	ccc_scale;
> -	int	ccc_offset;
> -	bool	has_fg_valid;
> +	int		ccc_scale;
> +	int		ccc_offset;
> +	bool		has_fg_valid;
> +	const struct	power_supply_desc *bat_ps_desc;
>  	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>  	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> +	int	(*cfg_iio_chan)(struct platform_device *pdev,
> +				struct axp20x_batt_ps *axp_batt);
> +	void	(*set_bat_info)(struct platform_device *pdev,
> +				struct axp20x_batt_ps *axp_batt,
> +				struct power_supply_battery_info *info);
> +	int	(*get_constant_chg_cur)(struct axp20x_batt_ps *axp, int *val);

Instead of adding a callback that is half different, probably just add
fields for the CCC register offset and mask values to generalize the
existing function.

Please split out changes that generalize the driver from the axp717
specific changes.

>  };
>  
>  struct axp20x_batt_ps {
> @@ -135,6 +175,41 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  	return 0;
>  }
>  
> +static int axp717_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +					  int *val)
> +{
> +	int ret, reg;
> +
> +	ret = regmap_read(axp20x_batt->regmap, AXP717_CV_CHG_SET, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg & AXP717_CHRG_CV_VOLT_MASK) {
> +	case AXP717_CHRG_CV_4_0V:
> +		*val = 4000000;
> +		break;
> +	case AXP717_CHRG_CV_4_1V:
> +		*val = 4100000;
> +		break;
> +	case AXP717_CHRG_CV_4_2V:
> +		*val = 4200000;
> +		break;
> +	case AXP717_CHRG_CV_4_35V:
> +		*val = 4350000;
> +		break;
> +	case AXP717_CHRG_CV_4_4V:
> +		*val = 4400000;
> +		break;
> +	case AXP717_CHRG_CV_5_0V:
> +		*val = 5000000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  					  int *val)
>  {
> @@ -180,6 +255,22 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>  	return 0;
>  }
>  
> +static int axp717_get_constant_charge_current(struct axp20x_batt_ps *axp,
> +					      int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_read(axp->regmap, AXP717_ICC_CHG_SET, val);
> +	if (ret)
> +		return ret;
> +
> +	*val &= AXP717_ICC_CHARGER_LIM;
> +
> +	*val = *val * axp->data->ccc_scale;
> +
> +	return 0;
> +}
> +
>  static int axp20x_battery_get_prop(struct power_supply *psy,
>  				   enum power_supply_property psp,
>  				   union power_supply_propval *val)
> @@ -332,6 +423,178 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static int axp717_battery_get_prop(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> +	int ret = 0, reg;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = regmap_read(axp20x_batt->regmap, AXP717_ON_INDICATE,
> +				  &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = !!(reg & AXP717_PWR_OP_BATT_PRESENT);
> +		break;

The battery could be present but not online if some fault were to
happen. Please differentiate the two.

> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_STATUS_2,
> +				  &reg);
> +		if (ret)
> +			return ret;
> +
> +		switch (reg & AXP717_PWR_STATUS_MASK) {
> +		case AXP717_PWR_STATUS_BAT_STANDBY:
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			break;
> +
> +		case AXP717_PWR_STATUS_BAT_CHRG:
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +
> +		case AXP717_PWR_STATUS_BAT_DISCHRG:
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +			break;
> +
> +		default:
> +			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +		}
> +
> +		break;
> +
> +	/*
> +	 * If a fault is detected it must also be cleared; if the
> +	 * condition persists it should reappear (This is an
> +	 * assumption, it's actually not documented). A restart was

Can you test and confirm your assumption?


Thanks
ChenYu


> +	 * not sufficient to clear the bit in testing despite the
> +	 * register listed as POR.
> +	 */
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_FAULT,
> +				  &reg);
> +		if (ret)
> +			return ret;
> +
> +		switch (reg & AXP717_BATT_PMU_FAULT_MASK) {
> +		case AXP717_BATT_UVLO_2_5V:
> +			val->intval = POWER_SUPPLY_HEALTH_DEAD;
> +			regmap_update_bits(axp20x_batt->regmap,
> +					   AXP717_PMU_FAULT,
> +					   AXP717_BATT_UVLO_2_5V,
> +					   AXP717_BATT_UVLO_2_5V);
> +			break;
> +
> +		case AXP717_BATT_OVER_TEMP:
> +			val->intval = POWER_SUPPLY_HEALTH_HOT;
> +			regmap_update_bits(axp20x_batt->regmap,
> +					   AXP717_PMU_FAULT,
> +					   AXP717_BATT_OVER_TEMP,
> +					   AXP717_BATT_OVER_TEMP);
> +			break;
> +
> +		case AXP717_BATT_UNDER_TEMP:
> +			val->intval = POWER_SUPPLY_HEALTH_COLD;
> +			regmap_update_bits(axp20x_batt->regmap,
> +					   AXP717_PMU_FAULT,
> +					   AXP717_BATT_UNDER_TEMP,
> +					   AXP717_BATT_UNDER_TEMP);
> +			break;
> +
> +		default:
> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +		}
> +
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret = axp717_get_constant_charge_current(axp20x_batt,
> +							 &val->intval);
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		/*
> +		 * The offset of this value is currently unknown and is
> +		 * not documented in the datasheet. Based on
> +		 * observation it's assumed to be somewhere around
> +		 * 450ma. I will leave the value raw for now.
> +		 */
> +		ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
> +		if (ret)
> +			return ret;
> +		/* IIO framework gives mA but Power Supply framework gives uA */
> +		val->intval *= 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		/* When no battery is present, return capacity is 100% */
> +		ret = regmap_read(axp20x_batt->regmap, AXP717_ON_INDICATE,
> +				  &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (!(reg & AXP717_PWR_OP_BATT_PRESENT)) {
> +			val->intval = 100;
> +			return 0;

Maybe return an error instead? 100 percent on an imaginary battery
doesn't make sense.

> +		}
> +
> +		ret = regmap_read(axp20x_batt->regmap,
> +				  AXP717_BATT_PERCENT_DATA, &reg);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Fuel Gauge data takes 7 bits but the stored value seems to be
> +		 * directly the raw percentage without any scaling to 7 bits.
> +		 */
> +		val->intval = reg & AXP209_FG_PERCENT;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		return axp20x_batt->data->get_max_voltage(axp20x_batt,
> +							  &val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		ret = regmap_read(axp20x_batt->regmap,
> +				  AXP717_VSYS_V_POWEROFF, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = AXP717_BAT_VMIN_MIN_UV + AXP717_BAT_VMIN_STEP *
> +			(reg & AXP717_V_OFF_MASK);
> +		break;

These should probably be POWER_SUPPLY_PROP_VOLTAGE_{MIN,MAX}.
POWER_SUPPLY_PROP_VOLTAGE_{MIN,MAX}_DESIGN should be the values
specified in the battery device node with the
voltage-{min,max}-design-microvolt properties.

The former are configurable limits for the charger, while the latter
are physical limits of the battery.

Could you also fix the existing values?

> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = iio_read_channel_processed(axp20x_batt->batt_v,
> +						 &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		/* IIO framework gives mV but Power Supply framework gives uV */
> +		val->intval *= 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = regmap_read(axp20x_batt->regmap,
> +				  AXP717_ITERM_CHG_SET, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = (reg & AXP717_ITERM_CHG_LIM) * AXP717_ITERM_CC_STEP;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int axp22x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  					  int val)
>  {
> @@ -388,6 +651,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
>  }
>  
> +static int axp717_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +					  int val)
> +{
> +	switch (val) {
> +	case 4000000:
> +		val = AXP717_CHRG_CV_4_0V;
> +		break;
> +
> +	case 4100000:
> +		val = AXP717_CHRG_CV_4_1V;
> +		break;
> +
> +	case 4200000:
> +		val = AXP717_CHRG_CV_4_2V;
> +		break;
> +
> +	default:
> +		/*
> +		 * AXP717 can go up to 4.35, 4.4, and 5.0 volts which
> +		 * seem too high for lithium batteries, so do not allow.
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(axp20x_batt->regmap,
> +				  AXP717_CV_CHG_SET,
> +				  AXP717_CHRG_CV_VOLT_MASK, val);
> +}
> +
>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
>  					      int charge_current)
>  {
> @@ -404,6 +696,24 @@ static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
>  				  AXP20X_CHRG_CTRL1_TGT_CURR, charge_current);
>  }
>  
> +static int axp717_set_constant_charge_current(struct axp20x_batt_ps *axp,
> +					      int charge_current)
> +{
> +	int val;
> +
> +	if (charge_current > axp->max_ccc)
> +		return -EINVAL;
> +
> +	if (charge_current > AXP717_BAT_CC_MAX_UA || charge_current < 0)
> +		return -EINVAL;
> +
> +	val = (charge_current - axp->data->ccc_offset) /
> +		axp->data->ccc_scale;
> +
> +	return regmap_update_bits(axp->regmap, AXP717_ICC_CHG_SET,
> +				  AXP717_ICC_CHARGER_LIM, val);
> +}
> +
>  static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
>  						  int charge_current)
>  {
> @@ -448,6 +758,19 @@ static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
>  				  AXP20X_V_OFF_MASK, val1);
>  }
>  
> +static int axp717_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
> +					 int min_voltage)
> +{
> +	int val1 = (min_voltage - AXP717_BAT_VMIN_MIN_UV) / AXP717_BAT_VMIN_STEP;
> +
> +	if (val1 < 0 || val1 > AXP717_V_OFF_MASK)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(axp_batt->regmap,
> +				  AXP717_VSYS_V_POWEROFF,
> +				  AXP717_V_OFF_MASK, val1);
> +}
> +
>  static int axp20x_battery_set_prop(struct power_supply *psy,
>  				   enum power_supply_property psp,
>  				   const union power_supply_propval *val)
> @@ -484,6 +807,42 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
>  	}
>  }
>  
> +static int axp717_battery_set_prop(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   const union power_supply_propval *val)
> +{
> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		return axp717_set_voltage_min_design(axp20x_batt, val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return axp717_set_constant_charge_current(axp20x_batt,
> +							  val->intval);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		switch (val->intval) {
> +		case POWER_SUPPLY_STATUS_CHARGING:
> +			return regmap_update_bits(axp20x_batt->regmap,
> +						  AXP717_MODULE_EN_CONTROL_2,
> +						  AXP717_CHRG_ENABLE,
> +						  AXP717_CHRG_ENABLE);
> +
> +		case POWER_SUPPLY_STATUS_DISCHARGING:
> +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
> +			return regmap_update_bits(axp20x_batt->regmap,
> +						  AXP717_MODULE_EN_CONTROL_2,
> +						  AXP717_CHRG_ENABLE, 0);
> +		}
> +		fallthrough;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static enum power_supply_property axp20x_battery_props[] = {
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_ONLINE,
> @@ -498,6 +857,20 @@ static enum power_supply_property axp20x_battery_props[] = {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  };
>  
> +static enum power_supply_property axp717_battery_props[] = {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +};
> +
>  static int axp20x_battery_prop_writeable(struct power_supply *psy,
>  					 enum power_supply_property psp)
>  {
> @@ -508,7 +881,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
>  	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
>  }
>  
> -static const struct power_supply_desc axp20x_batt_ps_desc = {
> +static int axp717_battery_prop_writeable(struct power_supply *psy,
> +					 enum power_supply_property psp)
> +{
> +	return psp == POWER_SUPPLY_PROP_STATUS ||
> +	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
> +	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
> +	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
> +}
> +
> +static const struct power_supply_desc axp209_batt_ps_desc = {
>  	.name = "axp20x-battery",
>  	.type = POWER_SUPPLY_TYPE_BATTERY,
>  	.properties = axp20x_battery_props,
> @@ -518,27 +900,159 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
>  	.set_property = axp20x_battery_set_prop,
>  };
>  
> +static const struct power_supply_desc axp717_batt_ps_desc = {
> +	.name = "axp20x-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = axp717_battery_props,
> +	.num_properties = ARRAY_SIZE(axp717_battery_props),
> +	.property_is_writeable = axp717_battery_prop_writeable,
> +	.get_property = axp717_battery_get_prop,
> +	.set_property = axp717_battery_set_prop,
> +};
> +
> +static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
> +				       struct axp20x_batt_ps *axp_batt)
> +{
> +	axp_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
> +	if (IS_ERR(axp_batt->batt_v)) {
> +		if (PTR_ERR(axp_batt->batt_v) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp_batt->batt_v);
> +	}
> +
> +	axp_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
> +							"batt_chrg_i");
> +	if (IS_ERR(axp_batt->batt_chrg_i)) {
> +		if (PTR_ERR(axp_batt->batt_chrg_i) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp_batt->batt_chrg_i);
> +	}
> +
> +	axp_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
> +							   "batt_dischrg_i");
> +	if (IS_ERR(axp_batt->batt_dischrg_i)) {
> +		if (PTR_ERR(axp_batt->batt_dischrg_i) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp_batt->batt_dischrg_i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int axp717_bat_cfg_iio_channels(struct platform_device *pdev,
> +				       struct axp20x_batt_ps *axp_batt)
> +{
> +	axp_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
> +	if (IS_ERR(axp_batt->batt_v)) {
> +		if (PTR_ERR(axp_batt->batt_v) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp_batt->batt_v);
> +	}
> +
> +	axp_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
> +							"batt_chrg_i");
> +	if (IS_ERR(axp_batt->batt_chrg_i)) {
> +		if (PTR_ERR(axp_batt->batt_chrg_i) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp_batt->batt_chrg_i);
> +	}
> +
> +	return 0;
> +}
> +
> +static void axp209_set_battery_info(struct platform_device *pdev,
> +				    struct axp20x_batt_ps *axp_batt,
> +				    struct power_supply_battery_info *info)
> +{
> +	int vmin = info->voltage_min_design_uv;
> +	int ccc = info->constant_charge_current_max_ua;
> +
> +	if (vmin > 0 && axp20x_set_voltage_min_design(axp_batt, vmin))
> +		dev_err(&pdev->dev,
> +			"couldn't set voltage_min_design\n");
> +
> +	/* Set max to unverified value to be able to set CCC */
> +	axp_batt->max_ccc = ccc;
> +
> +	if (ccc <= 0 || axp20x_set_constant_charge_current(axp_batt, ccc)) {
> +		dev_err(&pdev->dev,
> +			"couldn't set ccc from DT: fallback to min value\n");
> +		ccc = 300000;
> +		axp_batt->max_ccc = ccc;
> +		axp20x_set_constant_charge_current(axp_batt, ccc);
> +	}
> +}
> +
> +static void axp717_set_battery_info(struct platform_device *pdev,
> +				    struct axp20x_batt_ps *axp_batt,
> +				    struct power_supply_battery_info *info)
> +{
> +	int vmin = info->voltage_min_design_uv;
> +	int vmax = info->voltage_max_design_uv;
> +	int ccc = info->constant_charge_current_max_ua;
> +	int val;
> +
> +	if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
> +		dev_err(&pdev->dev,
> +			"couldn't set voltage_min_design\n");
> +
> +	if (vmax > 0 && axp717_battery_set_max_voltage(axp_batt, vmax))
> +		dev_err(&pdev->dev,
> +			"couldn't set voltage_max_design\n");
> +
> +	axp717_get_constant_charge_current(axp_batt, &val);
> +	axp_batt->max_ccc = ccc;
> +	if (ccc <= 0 || axp717_set_constant_charge_current(axp_batt, ccc)) {
> +		dev_err(&pdev->dev,
> +			"couldn't set ccc from DT: current ccc is %d\n",
> +			val);
> +	}
> +}
> +
>  static const struct axp_data axp209_data = {
>  	.ccc_scale = 100000,
>  	.ccc_offset = 300000,
> +	.bat_ps_desc = &axp209_batt_ps_desc,
>  	.get_max_voltage = axp20x_battery_get_max_voltage,
>  	.set_max_voltage = axp20x_battery_set_max_voltage,
> +	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
> +	.set_bat_info = axp209_set_battery_info,
> +	.get_constant_chg_cur = axp20x_get_constant_charge_current,
>  };
>  
>  static const struct axp_data axp221_data = {
>  	.ccc_scale = 150000,
>  	.ccc_offset = 300000,
>  	.has_fg_valid = true,
> +	.bat_ps_desc = &axp209_batt_ps_desc,
>  	.get_max_voltage = axp22x_battery_get_max_voltage,
>  	.set_max_voltage = axp22x_battery_set_max_voltage,
> +	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
> +	.set_bat_info = axp209_set_battery_info,
> +	.get_constant_chg_cur = axp20x_get_constant_charge_current,
> +};
> +
> +static const struct axp_data axp717_data = {
> +	.ccc_scale = 64000,
> +	.ccc_offset = 0,
> +	.bat_ps_desc = &axp717_batt_ps_desc,
> +	.get_max_voltage = axp717_battery_get_max_voltage,
> +	.set_max_voltage = axp717_battery_set_max_voltage,
> +	.cfg_iio_chan = axp717_bat_cfg_iio_channels,
> +	.set_bat_info = axp717_set_battery_info,
> +	.get_constant_chg_cur = axp717_get_constant_charge_current,
>  };
>  
>  static const struct axp_data axp813_data = {
>  	.ccc_scale = 200000,
>  	.ccc_offset = 200000,
>  	.has_fg_valid = true,
> +	.bat_ps_desc = &axp209_batt_ps_desc,
>  	.get_max_voltage = axp813_battery_get_max_voltage,
>  	.set_max_voltage = axp20x_battery_set_max_voltage,
> +	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
> +	.set_bat_info = axp209_set_battery_info,
> +	.get_constant_chg_cur = axp20x_get_constant_charge_current,
>  };
>  
>  static const struct of_device_id axp20x_battery_ps_id[] = {
> @@ -548,6 +1062,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
>  	}, {
>  		.compatible = "x-powers,axp221-battery-power-supply",
>  		.data = (void *)&axp221_data,
> +	}, {
> +		.compatible = "x-powers,axp717-battery-power-supply",
> +		.data = (void *)&axp717_data,
>  	}, {
>  		.compatible = "x-powers,axp813-battery-power-supply",
>  		.data = (void *)&axp813_data,
> @@ -561,6 +1078,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
>  	struct power_supply_config psy_cfg = {};
>  	struct power_supply_battery_info *info;
>  	struct device *dev = &pdev->dev;
> +	int ret;
>  
>  	if (!of_device_is_available(pdev->dev.of_node))
>  		return -ENODEV;
> @@ -572,29 +1090,6 @@ static int axp20x_power_probe(struct platform_device *pdev)
>  
>  	axp20x_batt->dev = &pdev->dev;
>  
> -	axp20x_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
> -	if (IS_ERR(axp20x_batt->batt_v)) {
> -		if (PTR_ERR(axp20x_batt->batt_v) == -ENODEV)
> -			return -EPROBE_DEFER;
> -		return PTR_ERR(axp20x_batt->batt_v);
> -	}
> -
> -	axp20x_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
> -							"batt_chrg_i");
> -	if (IS_ERR(axp20x_batt->batt_chrg_i)) {
> -		if (PTR_ERR(axp20x_batt->batt_chrg_i) == -ENODEV)
> -			return -EPROBE_DEFER;
> -		return PTR_ERR(axp20x_batt->batt_chrg_i);
> -	}
> -
> -	axp20x_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
> -							   "batt_dischrg_i");
> -	if (IS_ERR(axp20x_batt->batt_dischrg_i)) {
> -		if (PTR_ERR(axp20x_batt->batt_dischrg_i) == -ENODEV)
> -			return -EPROBE_DEFER;
> -		return PTR_ERR(axp20x_batt->batt_dischrg_i);
> -	}
> -
>  	axp20x_batt->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	platform_set_drvdata(pdev, axp20x_batt);
>  
> @@ -603,8 +1098,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
>  
>  	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
>  
> +	ret = axp20x_batt->data->cfg_iio_chan(pdev, axp20x_batt);
> +	if (ret)
> +		return ret;
> +
>  	axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
> -						       &axp20x_batt_ps_desc,
> +						       axp20x_batt->data->bat_ps_desc,
>  						       &psy_cfg);
>  	if (IS_ERR(axp20x_batt->batt)) {
>  		dev_err(&pdev->dev, "failed to register power supply: %ld\n",
> @@ -613,33 +1112,16 @@ static int axp20x_power_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
> -		int vmin = info->voltage_min_design_uv;
> -		int ccc = info->constant_charge_current_max_ua;
> -
> -		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
> -							      vmin))
> -			dev_err(&pdev->dev,
> -				"couldn't set voltage_min_design\n");
> -
> -		/* Set max to unverified value to be able to set CCC */
> -		axp20x_batt->max_ccc = ccc;
> -
> -		if (ccc <= 0 || axp20x_set_constant_charge_current(axp20x_batt,
> -								   ccc)) {
> -			dev_err(&pdev->dev,
> -				"couldn't set constant charge current from DT: fallback to minimum value\n");
> -			ccc = 300000;
> -			axp20x_batt->max_ccc = ccc;
> -			axp20x_set_constant_charge_current(axp20x_batt, ccc);
> -		}
> +		axp20x_batt->data->set_bat_info(pdev, axp20x_batt, info);
> +		power_supply_put_battery_info(axp20x_batt->batt, info);
>  	}
>  
>  	/*
>  	 * Update max CCC to a valid value if battery info is present or set it
>  	 * to current register value by default.
>  	 */
> -	axp20x_get_constant_charge_current(axp20x_batt,
> -					   &axp20x_batt->max_ccc);
> +	axp20x_batt->data->get_constant_chg_cur(axp20x_batt,
> +						&axp20x_batt->max_ccc);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

