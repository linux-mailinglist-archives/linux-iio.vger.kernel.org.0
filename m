Return-Path: <linux-iio+bounces-8481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6644D952491
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 23:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C55287FE5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A661C8241;
	Wed, 14 Aug 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLqbMs3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E420210FB;
	Wed, 14 Aug 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669986; cv=none; b=R1E9tykLlvCo2DvCdYnD5enDbdL1u/oa9IwviVDKU9cSXFZuIs+sFaK1hBq3azMPUhFLqvvMuYCOLUFmr4Ktp7ml8+L4ckWJsh5frB8gFlDAlUwT7fCJVqml+KGbiok/tTe4lz7IG+3WESqwF3l6N9ZNGJgVsHZvoxo+z9uHatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669986; c=relaxed/simple;
	bh=OWLB4A3W+IkHeRUaO3oHs3PXbpk5OuPFsN4t33tni2A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2pJveClGpKa5YamlkMz6gyt0jOfxv5TJDLCMzGiiuOYtanVn6V2Mk9YJMY22DqtfRlE0bPVpX3dbRYccOTDNfNblRok2UHrLX+uQH53VLOLHeZeL+igtKd4DZbfmQA+OlwN28hjGbsQ5jN5IuxT6A9UzePhhmeCbLdfeV07+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLqbMs3A; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db130a872fso160568b6e.2;
        Wed, 14 Aug 2024 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723669984; x=1724274784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E0PsU1V81otLoWVv/G1qLYZtjV9Tg/8agLNzDh9hSwo=;
        b=BLqbMs3ACGaIs30c0YKnkrTxV/GNz6drVNdjCxMaTTBdAfwhrgnqV5htqwcIAGooqI
         zMh09DgZ4SpPmdcx6awNYbAJPSFDfhxgtkJtY6qfFF8MorDSnrsDFBluXQudJ8xpZhei
         tChR0PgmdyEtv5EeafM8RsqrmTgnq3Op69LVKhEsMwbn52nB28mwQ3Ml1SVzc/rp7bJY
         frkn9nYk3vgmARwq6NRWMplZJ4VV/lDdoNE/5njs04ZsLTLAhJ7SULTWPKRvizpwvZbt
         6qTaGNYOPN7+s0K0akeyjG0inDUh8dWmHGyTxX5/o7TVaBFi1n1dUEcPZr0pVQDtYMpn
         EHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669984; x=1724274784;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0PsU1V81otLoWVv/G1qLYZtjV9Tg/8agLNzDh9hSwo=;
        b=gsZhXtJK0zfLDEq8PvzVnUzNC+yIMd1gFlwNZTAMPpdSZ4zmf+/m3v4qcUj3d23cpk
         3iSwsjAQdjs8WkwmdWtMxMnRFM92uf7mfodMhxZFLym5zc8ST7dbMisdog8YB+v9Ck2x
         CJLG7iNsBgbAIW1+LihLr6b6oj/AEA0Z3JiCHEj9gDwKLwIFIpig6eR1eWGrqg6OG0K8
         AqFFYeJzb/hBdc+gC6BuKNCjPLfkwpOjEQcd3+mbhfmqegaKEmcT0ZJndCa/kLnkO6Mu
         nhZn6a39wTovbiMgkByA53TTKKdOMpjMzStd6sVLiZcnKzmvfqoEhm1m/8RlQfZ7Y+iK
         dJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRSvUlsZJtDZg4OWVm3Gx7vHvqgZTfkAtOKWDulXyTYtYi2rDgGMPwYvHgdczhXw+lVnEIaqg+Hk0ybSsL8RQeKg3bi187A9y+a+VGP/8X9mY1X9oEcYinNneaIJwaPWYqLWHokBT7tFfZBDnGIeTAyKge7tmBjtnADblqKevV
X-Gm-Message-State: AOJu0Yy570hiynBrUpy61VnDgEgbVycsJ4cMWpYh91kTmxRREECva6ak
	eN/T+6N5yeblmp5wXeo2bn8g6G15jpT3tLuSwByTFuRGzRXiVK7z
X-Google-Smtp-Source: AGHT+IHPFbvzVVdUw502MWTJGOKLHnC1j3KggFd0N+p5LyKQWM3LNqxF2J0bV4X2lPo9bjtcCBrWNw==
X-Received: by 2002:a05:6808:1789:b0:3d9:4163:654f with SMTP id 5614622812f47-3dd2997b5camr4570717b6e.32.1723669984114;
        Wed, 14 Aug 2024 14:13:04 -0700 (PDT)
Received: from neuromancer. ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd060b4e13sm2221748b6e.45.2024.08.14.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:13:03 -0700 (PDT)
Message-ID: <66bd1ddf.ca0a0220.13e5d4.8871@mx.google.com>
X-Google-Original-Message-ID: <Zr0d3U5ATHATlSaU@neuromancer.>
Date: Wed, 14 Aug 2024 16:13:01 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
	mripard@kernel.org, tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de,
	lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com,
	sre@kernel.org, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V2 14/15] power: supply: axp20x_battery: add support for
 AXP717
References: <20240802192026.446344-1-macroalpha82@gmail.com>
 <20240802192026.446344-15-macroalpha82@gmail.com>
 <20240803121044.20481897@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803121044.20481897@jic23-huawei>

On Sat, Aug 03, 2024 at 12:10:44PM +0100, Jonathan Cameron wrote:
> On Fri,  2 Aug 2024 14:20:25 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the AXP717 PMIC battery charger. The AXP717 differs
> > greatly from existing AXP battery chargers in that it cannot measure
> > the discharge current. The datasheet does not document the current
> > value's offset or scale, so the POWER_SUPPLY_PROP_CURRENT_NOW is left
> > unscaled.
> > 
> > Tested-by: Philippe Simons <simons.philippe@gmail.com>
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Hi.
> 
> A few drive by comments,
> 
> Jonathan
> 
> > ---
> >  drivers/power/supply/axp20x_battery.c | 444 ++++++++++++++++++++++++++
> >  1 file changed, 444 insertions(+)
> > 
> > diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> > index c903c588b361..53af4ad0549d 100644
> > --- a/drivers/power/supply/axp20x_battery.c
> > +++ b/drivers/power/supply/axp20x_battery.c
> > @@ -32,9 +32,19 @@
> >  #include <linux/mfd/axp20x.h>
> >  
> >  #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
> > +#define AXP717_PWR_STATUS_MASK		GENMASK(6, 5)
> > +#define AXP717_PWR_STATUS_BAT_STANDBY	(0 << 5)
> > +#define AXP717_PWR_STATUS_BAT_CHRG	(1 << 5)
> > +#define AXP717_PWR_STATUS_BAT_DISCHRG	(2 << 5)
> 
> Fine to match local style in this patch, but just thought I'd
> comment that this driver would probably be more readable with
> use of FIELD_PREP and changing convention to not shift the defined
> values for contents of each field.
> 
> To change to that it would either need to be before this patch,
> or done as a follow up.

I'll take your other comments and apply them, but if it's okay with
you I'll opt to not use FIELD_PREP/FIELD_GET for the moment, so the
style remains the same. I will make sure to use those macros for
other drivers I'm working on though as they seem handy.

> 
> 
> >  struct axp20x_batt_ps;
> >  
> > @@ -143,6 +176,41 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> >  	return 0;
> >  }
> >  
> > +static int axp717_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> > +					  int *val)
> > +{
> > +	int ret, reg;
> > +
> > +	ret = regmap_read(axp20x_batt->regmap, AXP717_CV_CHG_SET, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (reg & AXP717_CHRG_CV_VOLT_MASK) {
> > +	case AXP717_CHRG_CV_4_0V:
> > +		*val = 4000000;
> > +		break;
> > +	case AXP717_CHRG_CV_4_1V:
> > +		*val = 4100000;
> > +		break;
> > +	case AXP717_CHRG_CV_4_2V:
> > +		*val = 4200000;
> > +		break;
> > +	case AXP717_CHRG_CV_4_35V:
> > +		*val = 4350000;
> > +		break;
> > +	case AXP717_CHRG_CV_4_4V:
> > +		*val = 4400000;
> > +		break;
> > +	case AXP717_CHRG_CV_5_0V:
> > +		*val = 5000000;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> Could just return instead of breaking an save reader having to look to see
> if anything else happens after the switch finishes.

Acknowledged.

> 
> > +}
> > +
> >  static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> >  					  int *val)
> >  {
> > @@ -188,6 +256,22 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
> >  	return 0;
> >  }
> >  
> > +static int axp717_get_constant_charge_current(struct axp20x_batt_ps *axp,
> > +					      int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_read(axp->regmap, AXP717_ICC_CHG_SET, val);
> Trivial but I'd use a separate local variable for the register value.  

Will do.

> > +	if (ret)
> > +		return ret;
> > +
> > +	*val &= AXP717_ICC_CHARGER_LIM_MASK;
> 
> FIELD_GET() would be much more readable here as we'd not need to go
> check if LIM_MASK included bit 0 and it could be used directly inline
> with the below as
> 

Nack, if that's okay (as mentioned above). If it's not let me know and
I'll go back and redo this driver.

> 	*val = FIELD_GET(AXP717_IC_CHARGER_LIM_MASK, val) * axp->data->ccc_scale;
> 
> > +
> > +	*val = *val * axp->data->ccc_scale;
> > +
> > +	return 0;
> > +}
> > +
> >  static int axp20x_battery_get_prop(struct power_supply *psy,
> >  				   enum power_supply_property psp,
> >  				   union power_supply_propval *val)
> > @@ -340,6 +424,175 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
> >  	return 0;
> >  }
> >  
> > +static int axp717_battery_get_prop(struct power_supply *psy,
> > +				   enum power_supply_property psp,
> > +				   union power_supply_propval *val)
> > +{
> > +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> > +	int ret = 0, reg;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +	case POWER_SUPPLY_PROP_ONLINE:
> > +		ret = regmap_read(axp20x_batt->regmap, AXP717_ON_INDICATE,
> > +				  &reg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		val->intval = !!(reg & AXP717_PWR_OP_BATT_PRESENT);
> 
> FIELD_GET() here would be cleaner.
> 
> > +		break;
> > +
> >;
> > +	}
> > +
> > +	return 0;
> 
> As nothing to do down here, I think early returns would make things more redabel.
> 

Will do.

> > +}
> > +
> >  static int axp20x_battery_set_prop(struct power_supply *psy,
> >  				   enum power_supply_property psp,
> >  				   const union power_supply_propval *val)
> > @@ -492,6 +805,42 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
> >  	}
> >  }
> >  
> > +static int axp717_battery_set_prop(struct power_supply *psy,
> > +				   enum power_supply_property psp,
> > +				   const union power_supply_propval *val)
> > +{
> > +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		return axp717_set_voltage_min_design(axp20x_batt, val->intval);
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> > +		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
> > +
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> > +		return axp717_set_constant_charge_current(axp20x_batt,
> > +							  val->intval);
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		switch (val->intval) {
> > +		case POWER_SUPPLY_STATUS_CHARGING:
> > +			return regmap_update_bits(axp20x_batt->regmap,
> > +						  AXP717_MODULE_EN_CONTROL_2,
> > +						  AXP717_CHRG_ENABLE,
> > +						  AXP717_CHRG_ENABLE);
> > +
> > +		case POWER_SUPPLY_STATUS_DISCHARGING:
> > +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
> > +			return regmap_update_bits(axp20x_batt->regmap,
> > +						  AXP717_MODULE_EN_CONTROL_2,
> > +						  AXP717_CHRG_ENABLE, 0);
> > +		}
> > +		fallthrough;
> Why bother? Just return -EINVAL here.
> 

Will do.

> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +

Thank you for your review,
Chris

