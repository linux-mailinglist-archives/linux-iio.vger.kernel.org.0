Return-Path: <linux-iio+bounces-6637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD14910E70
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402211F23163
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30CF1B3F28;
	Thu, 20 Jun 2024 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhaQSAL5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE91B3F11;
	Thu, 20 Jun 2024 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904365; cv=none; b=SJ7ckFfJqOIZrSganmi2+tZnOcAVC5vwHIuIC7D+WURfaAKOeAuKYKlCuC7vg0VnuuTNgnVtDL1MnltOvJn018fAN9ihd0GW9k/2Cqbo0GqTXFAmZ1xELzyjijbd3z13+acOUnfLtZsCUbqugxqHx9H/yu6ivQ0+5N53+LfkLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904365; c=relaxed/simple;
	bh=/R9ChJDF9sqWGPt6Eu8s/uknHOOVvufDfRsy7wCwPUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyLa01sD5F0MVAbTQyLUjsJ1ITJrlz9FtE6/jjFtzOgo8Cts9HDFCk2MTXMyLHTkBlyBPoaG1T2+v5lHEzIgTVFTi8EQULjWTO7q+7qQS6x8TabmW1Z8sMc5wHZ/rrt5LlLm8CbEpmyi0BVQyLw7yG5M66pTTdpEKyiBU8N7aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhaQSAL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6A1C4AF09;
	Thu, 20 Jun 2024 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718904365;
	bh=/R9ChJDF9sqWGPt6Eu8s/uknHOOVvufDfRsy7wCwPUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhaQSAL5s0wKyT6zkq/C9Df7HWSxsDSwe1JgssP5EFJ9k0QCX+Rt4GDnsQfC5urjc
	 J6+eTfSV8OJOx5KmmTostZzvwhBcuuFpd9ddFDSoDnZ59wWkoyvT14FDAfhovbVcBf
	 Z6DRHnSTIdnE6/hSRDi2bPTdgxre4v6+bzrhX6j4rf0FYoTjDh/euFCgRcs+GfSVga
	 GvHDFw85qSDWpMIjtIs9Dc1lMPbjCscKFBg1pEyJpVLDfm6DT7wrJNOFVQ/bpuqYJA
	 cYca+V9BBG8cZ5Fi3P0NpiGYzPp+SEYCRFNKPQ5cZ2QlCs+8WEArxQOti27UU2FgYn
	 1vaEE/Y7gvWww==
Date: Thu, 20 Jun 2024 18:25:59 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com,
	sre@kernel.org, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 4/8] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
Message-ID: <20240620172559.GZ3029315@google.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617220535.359021-5-macroalpha82@gmail.com>

On Mon, 17 Jun 2024, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 PMIC to utilize the ADC (for reading
> voltage, current, and temperature information from the PMIC) as well
> as the USB charger and battery.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/mfd/axp20x.c                 | 30 +++++++++++++++++++++++++---
>  drivers/regulator/axp20x-regulator.c |  2 +-
>  include/linux/mfd/axp20x.h           | 26 +++++++++++++++++++++++-
>  3 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 609e7e149681..07db4a11acbc 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -209,15 +209,23 @@ static const struct regmap_access_table axp313a_volatile_table = {
>  };
>  
>  static const struct regmap_range axp717_writeable_ranges[] = {
> -	regmap_reg_range(AXP717_MODULE_EN_CONTROL, AXP717_MODULE_EN_CONTROL),
> -	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
> +	regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
> +	regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
> +	regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
>  	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
>  	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
> +	regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
>  	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
> +	regmap_reg_range(AXP717_ADC_CH_EN_CONTROL, AXP717_ADC_CH_EN_CONTROL),
> +	regmap_reg_range(AXP717_ADC_DATA_SEL, AXP717_ADC_DATA_SEL),
>  };
>  
>  static const struct regmap_range axp717_volatile_ranges[] = {
> +	regmap_reg_range(AXP717_ON_INDICATE, AXP717_PMU_FAULT),
>  	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
> +	regmap_reg_range(AXP717_BATT_PERCENT_DATA, AXP717_BATT_PERCENT_DATA),
> +	regmap_reg_range(AXP717_BATT_V_H, AXP717_BATT_CHRG_I_L),
> +	regmap_reg_range(AXP717_ADC_DATA_H, AXP717_ADC_DATA_L),
>  };
>  
>  static const struct regmap_access_table axp717_writeable_table = {
> @@ -310,6 +318,11 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>  };
>  
> +static const struct resource axp717_usb_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  /* AXP803 and AXP813/AXP818 share the same interrupts */
>  static const struct resource axp803_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> @@ -424,7 +437,7 @@ static const struct regmap_config axp717_regmap_config = {
>  	.val_bits = 8,
>  	.wr_table = &axp717_writeable_table,
>  	.volatile_table = &axp717_volatile_table,
> -	.max_register = AXP717_CPUSLDO_CONTROL,
> +	.max_register = AXP717_ADC_DATA_L,
>  	.cache_type = REGCACHE_MAPLE,
>  };
>  
> @@ -1026,6 +1039,17 @@ static struct mfd_cell axp313a_cells[] = {
>  static struct mfd_cell axp717_cells[] = {
>  	MFD_CELL_NAME("axp20x-regulator"),
>  	MFD_CELL_RES("axp20x-pek", axp717_pek_resources),
> +	{
> +		.name		= "axp717-adc",
> +		.of_compatible	= "x-powers,axp717-adc",
> +	},
> +	MFD_CELL_OF("axp20x-usb-power-supply",
> +		    axp717_usb_power_supply_resources, NULL, 0, 0,
> +		    "x-powers,axp717-usb-power-supply"),
> +	{
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp717-battery-power-supply",
> +	},
>  };

Please refrain from mixing and matching:

MFD_CELL_OF() for both.

-- 
Lee Jones [李琼斯]

