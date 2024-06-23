Return-Path: <linux-iio+bounces-6736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E07891380C
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 07:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C71280FA7
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAD717597;
	Sun, 23 Jun 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VToYTW1R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997892C95;
	Sun, 23 Jun 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719122150; cv=none; b=TUjrygkgkeAiom2/FfNaHX65DGq7PGdXu/dL07mb9pWoKlTIZkJXMzCuIaTzgIA5V7KkzLyvCFZNGdQ5z1WLVZ1O28x7EqYIfsNPhTRanTJj0coeDdd+IQng622ILCOyjDhz6HjmeQfWCSVcwdXkpAXCsMnv1eA77H8sx4MA7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719122150; c=relaxed/simple;
	bh=jizTlnCcapFY7MjmhFOPCJB6ArAdUYcPGOk5OsMXqt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlXOQhPenwXXJJh0qkxwGMpN7gvByJf6wO8qyjZsyZjZOUr28G7ihDPq+1uNOTJBX1f7rYj02f4mfjteDxhRKr9nZk+hoSC14zBS0onz66LZ+5J1TJUSLcQSKGdZZ3l48/E76gs2MqqkABJ/OP6bolL/zpC/0w9KAytGLHTapU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VToYTW1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA78C2BD10;
	Sun, 23 Jun 2024 05:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719122150;
	bh=jizTlnCcapFY7MjmhFOPCJB6ArAdUYcPGOk5OsMXqt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VToYTW1RMP1F5fPb+sEQ06RXZsd6zI/PZGRiT34ZD3EGr4thkoskgs2YcrNPuYO0T
	 d2poUz9fesjgd/WBLatIEVDmlgH0/v8EE6LwGqvE0nvU7sHO/QK1Bik6EVrG5wxecc
	 6S4lsFufmM68yEWfDZU3LmIV9KhAPT1wcWawKDpqMhRtDGOvZtU5jM6o2nzOVodNRb
	 6kF8umg87twQMZTPOtPmlvnD15oHwQ1pfcB0Iqc4qjKguqwsRLVfS4xBPczghsvmJz
	 fmR8kpOOwDKZzMsq2zkctT1nkB4x15uIDm/JTgWN0ScJ4pbG7rrMMhD31jwbkDTD4U
	 /olLllJhsgvtw==
Received: by wens.tw (Postfix, from userid 1000)
	id 6AB145FA33; Sun, 23 Jun 2024 13:55:47 +0800 (CST)
Date: Sun, 23 Jun 2024 13:55:47 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 4/8] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
Message-ID: <Zne448xSH-aSfT8S@wens.tw>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220535.359021-5-macroalpha82@gmail.com>

On Mon, Jun 17, 2024 at 05:05:31PM -0500, Chris Morgan wrote:
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

I suggest you rebase your patches on to linux-next. The boost regulator
isn't merged yet, and it will probably hold back your patch series.

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

Perhaps it would make sense to add VBUS fault and VBUS overvoltage?

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
>  
>  static const struct resource axp288_adc_resources[] = {
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 20bef3971fec..a8e91d9d028b 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -837,7 +837,7 @@ static const struct regulator_desc axp717_regulators[] = {
>  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(4)),
>  	AXP_DESC(AXP717, BOOST, "boost", "vin1", 4550, 5510, 64,
>  		 AXP717_BOOST_CONTROL, AXP717_BOOST_V_OUT_MASK,
> -		 AXP717_MODULE_EN_CONTROL, BIT(4)),
> +		 AXP717_MODULE_EN_CONTROL_2, BIT(4)),
>  };
>  
>  /* DCDC ranges shared with AXP813 */

As mentioned above, please rebase onto linux-next and drop this hunk.

The rest look correct.


Thanks
ChenYu

> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 5e86b976c4ca..f4dfc1871a95 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -115,8 +115,16 @@ enum axp20x_variants {
>  #define AXP313A_IRQ_STATE		0x21
>  
>  #define AXP717_ON_INDICATE		0x00
> -#define AXP717_MODULE_EN_CONTROL	0x19
> +#define AXP717_PMU_STATUS_2		0x01
> +#define AXP717_BC_DETECT		0x05
> +#define AXP717_PMU_FAULT		0x08
> +#define AXP717_MODULE_EN_CONTROL_1	0x0b
> +#define AXP717_MIN_SYS_V_CONTROL	0x15
> +#define AXP717_INPUT_VOL_LIMIT_CTRL	0x16
> +#define AXP717_INPUT_CUR_LIMIT_CTRL	0x17
> +#define AXP717_MODULE_EN_CONTROL_2	0x19
>  #define AXP717_BOOST_CONTROL		0x1e
> +#define AXP717_VSYS_V_POWEROFF		0x24
>  #define AXP717_IRQ0_EN			0x40
>  #define AXP717_IRQ1_EN			0x41
>  #define AXP717_IRQ2_EN			0x42
> @@ -127,6 +135,9 @@ enum axp20x_variants {
>  #define AXP717_IRQ2_STATE		0x4a
>  #define AXP717_IRQ3_STATE		0x4b
>  #define AXP717_IRQ4_STATE		0x4c
> +#define AXP717_ICC_CHG_SET		0x62
> +#define AXP717_ITERM_CHG_SET		0x63
> +#define AXP717_CV_CHG_SET		0x64
>  #define AXP717_DCDC_OUTPUT_CONTROL	0x80
>  #define AXP717_DCDC1_CONTROL		0x83
>  #define AXP717_DCDC2_CONTROL		0x84
> @@ -147,6 +158,19 @@ enum axp20x_variants {
>  #define AXP717_CLDO3_CONTROL		0x9d
>  #define AXP717_CLDO4_CONTROL		0x9e
>  #define AXP717_CPUSLDO_CONTROL		0x9f
> +#define AXP717_BATT_PERCENT_DATA	0xa4
> +#define AXP717_ADC_CH_EN_CONTROL	0xc0
> +#define AXP717_BATT_V_H			0xc4
> +#define AXP717_BATT_V_L			0xc5
> +#define AXP717_VBUS_V_H			0xc6
> +#define AXP717_VBUS_V_L			0xc7
> +#define AXP717_VSYS_V_H			0xc8
> +#define AXP717_VSYS_V_L			0xc9
> +#define AXP717_BATT_CHRG_I_H		0xca
> +#define AXP717_BATT_CHRG_I_L		0xcb
> +#define AXP717_ADC_DATA_SEL		0xcd
> +#define AXP717_ADC_DATA_H		0xce
> +#define AXP717_ADC_DATA_L		0xcf
>  
>  #define AXP806_STARTUP_SRC		0x00
>  #define AXP806_CHIP_ID			0x03
> -- 
> 2.34.1
> 

