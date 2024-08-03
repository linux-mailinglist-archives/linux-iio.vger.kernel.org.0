Return-Path: <linux-iio+bounces-8190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D034946966
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EAD1F2175E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669914D2B5;
	Sat,  3 Aug 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIzAaZAR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114124A2F;
	Sat,  3 Aug 2024 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683456; cv=none; b=lGJHUlGpG1ihA8QVwxMnvaFxgQMOO19UxOJ6ZDpjO4plC1uviArEDU90j/O6hD63ANaIaH1HxBEoF4vh3iVfgvSg3puHIm4hp3oJBEjhS7eTFD9cFWNwlNVO8/zsp2cJF3jSOfJMbMASQhsrFWlaF8sG0r4RG+cJQotyTjQkdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683456; c=relaxed/simple;
	bh=CV4NXj2iWykP7jEOWQLFR0DMW5+IDOIAcyP5yA3ho9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INufX6w9yulTgxXX66K03Qg3uB2vOOS6kZbmMkNf6BnrXB0C/JIvCJMKzxv4KhMsdYTT5ZMXDiyNVdZYN46CutwfvkFPb6jX94Bxiw9G7q1cYZZigH2Pj4JqAVhEuJtP9O2ouiTbcBsDnXjvGdHF54kBKQSGeJw4EPDAw73hsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIzAaZAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A6DC116B1;
	Sat,  3 Aug 2024 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722683455;
	bh=CV4NXj2iWykP7jEOWQLFR0DMW5+IDOIAcyP5yA3ho9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIzAaZAR//PQ4bKlx5rRsx7sUN4I6HtToPXAHFNiafN05+IeOe2gXscYX7sKFn/zI
	 PwfMn71bX7+72oCT+1EZxhcV+ebpGxo2cbxicvuWJ7hhYGtpyBAjldqDVd4nXytY5G
	 IoJUr8qQX406E30TVo+G3ekDRUX9Bps/Lf/07f+zdkwPte/VMr7zf+AjwPOE+GSs0q
	 pNtLhymBMWbu9WkJMV1SaRjU6bPQOdojkLMBpdVhNaj4wd3ngU7I6OchKxZhhRDbfw
	 GGLN9p+EOspnqNPfLYFn7wyMR3YZSt69JN4E/ZQZMslfQJQYff6ypCSiK6bIV5pR3O
	 L/1MNtzssE0xA==
Date: Sat, 3 Aug 2024 12:10:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
 mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 Chris Morgan <macromorgan@hotmail.com>, Philippe Simons
 <simons.philippe@gmail.com>
Subject: Re: [PATCH V2 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID: <20240803121044.20481897@jic23-huawei>
In-Reply-To: <20240802192026.446344-15-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
	<20240802192026.446344-15-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 14:20:25 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 PMIC battery charger. The AXP717 differs
> greatly from existing AXP battery chargers in that it cannot measure
> the discharge current. The datasheet does not document the current
> value's offset or scale, so the POWER_SUPPLY_PROP_CURRENT_NOW is left
> unscaled.
> 
> Tested-by: Philippe Simons <simons.philippe@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi.

A few drive by comments,

Jonathan

> ---
>  drivers/power/supply/axp20x_battery.c | 444 ++++++++++++++++++++++++++
>  1 file changed, 444 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index c903c588b361..53af4ad0549d 100644
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

Fine to match local style in this patch, but just thought I'd
comment that this driver would probably be more readable with
use of FIELD_PREP and changing convention to not shift the defined
values for contents of each field.

To change to that it would either need to be before this patch,
or done as a follow up.


>  struct axp20x_batt_ps;
>  
> @@ -143,6 +176,41 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
Could just return instead of breaking an save reader having to look to see
if anything else happens after the switch finishes.

> +}
> +
>  static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  					  int *val)
>  {
> @@ -188,6 +256,22 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>  	return 0;
>  }
>  
> +static int axp717_get_constant_charge_current(struct axp20x_batt_ps *axp,
> +					      int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_read(axp->regmap, AXP717_ICC_CHG_SET, val);
Trivial but I'd use a separate local variable for the register value.  
> +	if (ret)
> +		return ret;
> +
> +	*val &= AXP717_ICC_CHARGER_LIM_MASK;

FIELD_GET() would be much more readable here as we'd not need to go
check if LIM_MASK included bit 0 and it could be used directly inline
with the below as

	*val = FIELD_GET(AXP717_IC_CHARGER_LIM_MASK, val) * axp->data->ccc_scale;

> +
> +	*val = *val * axp->data->ccc_scale;
> +
> +	return 0;
> +}
> +
>  static int axp20x_battery_get_prop(struct power_supply *psy,
>  				   enum power_supply_property psp,
>  				   union power_supply_propval *val)
> @@ -340,6 +424,175 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
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

FIELD_GET() here would be cleaner.

> +		break;
> +
>;
> +	}
> +
> +	return 0;

As nothing to do down here, I think early returns would make things more redabel.

> +}
> +
>  static int axp20x_battery_set_prop(struct power_supply *psy,
>  				   enum power_supply_property psp,
>  				   const union power_supply_propval *val)
> @@ -492,6 +805,42 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
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
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return axp717_set_voltage_min_design(axp20x_batt, val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
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
Why bother? Just return -EINVAL here.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

