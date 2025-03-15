Return-Path: <linux-iio+bounces-16860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495FA62CFF
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 13:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800DC7A7E6D
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5B1F8BC8;
	Sat, 15 Mar 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lps6mPH4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F61862;
	Sat, 15 Mar 2025 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043043; cv=none; b=g4VFYPbjWXhN9sRElKEhscMnOfCaisbb/WzORmta5Lib9/fnwH3slab887ghSinceRjx/Io6fgGR9Kr5qfLdexuUqLj1WRgjxvjLSiKvhcmIcghgWIcMvlVBfJXsfUP1dJ9fEXjFbaadsH5fvcw/a1JffQs3VD3rEUBdhszjH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043043; c=relaxed/simple;
	bh=EOB596Kg39pWo9it64zOXJBRApV/K8/djVobuAhtFJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBzKpTbhNbGcuqjI37DwlHwKKLaIy3NZBch0+DDwwdvO/KqK6AlzLrho5hey3nOO7OKW3p/pRFOkZZwaB2nav5LbeUQ2HFrdBVQulq2Wv+G91iX6QX63lAYRSArlKFJx81HTumnOyWI8WV3r1QMTb0HbObP0mCf+WsPIs6+e6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lps6mPH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4547C4CEE5;
	Sat, 15 Mar 2025 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742043042;
	bh=EOB596Kg39pWo9it64zOXJBRApV/K8/djVobuAhtFJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lps6mPH4T3p+8I7CrgfSf3S/rDk6jMZuIjsDXVjl8fGKQc2ArrRZmFrsS68GBUEaS
	 yd1CvnBa1dqZF4eaBXDglKWZ+WGTYTVNId18L1ujMqtl1dRkPNG+LWGv8V08PV98p9
	 lhWML1RL2g/uQ9jF5CMB8KPmezO2Z/9JdcPn3cfobzYCoopiByHKxePJHxsRd7KQZP
	 rY2LnOF8UTtY6xpFtBHhm1bsLLyFp0CxMDA7nou+qUAwQyMjlhB5PdkOGuUR5iz7zi
	 rlwIx2WuJBNUwe/D9+LkGX3WEjum4oAWhLvY71IeeTqg4+rk73LqVjtIfVjISTZa+Z
	 lnrS1zAj6x/zg==
Date: Sat, 15 Mar 2025 12:50:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Lu.Tang" <Lu.Tang@mediatek.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee
 Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean
 Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>, Sen Chu
 <shen.chu@mediatek.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 1/5] pmic: mediatek: Add pmic auxadc driver
Message-ID: <20250315125028.038fc488@jic23-huawei>
In-Reply-To: <20250314073307.25092-2-Lu.Tang@mediatek.com>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
	<20250314073307.25092-2-Lu.Tang@mediatek.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 15:32:27 +0800
Lu.Tang <Lu.Tang@mediatek.com> wrote:

> From: "Lu.Tang" <lu.tang@mediatek.com>
> 
> Add pmic mt6363 and mt6373 auxadc driver

On assumption that there is good reason to not combine this with existing
driver I'll give it a quick review.  Definitely confirm why this can't
be combined with existing driver though before looking at this.

Jonathan


> 
> Signed-off-by: Lu Tang <lu.tang@mediatek.com>
> ---
>  drivers/iio/adc/Kconfig             |  10 +
>  drivers/iio/adc/Makefile            |   1 +
>  drivers/iio/adc/mtk-spmi-pmic-adc.c | 576 ++++++++++++++++++++++++++++
>  3 files changed, 587 insertions(+)
>  create mode 100644 drivers/iio/adc/mtk-spmi-pmic-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..7c4b5f8f7209 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1039,6 +1039,16 @@ config MEDIATEK_MT6577_AUXADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mt6577_auxadc.
>  
> +config MEDIATEK_SPMI_PMIC_ADC

Clearly a history of non compatible mediatek parts so it is probably better
to just name this after one of the supported parts than it is to use
a generic name.

> +	tristate "MediaTek SPMI PMIC ADC Support"
> +	depends on MFD_MTK_SPMI_PMIC
> +	help
> +	  Say yes here to enable support for MediaTek SPMI PMIC ADC.
> +	  The driver supports multiple channels read.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called mtk-spmi-pmic-adc.
> +

> diff --git a/drivers/iio/adc/mtk-spmi-pmic-adc.c b/drivers/iio/adc/mtk-spmi-pmic-adc.c
> new file mode 100644
> index 000000000000..61e062bc8cf5
> --- /dev/null
> +++ b/drivers/iio/adc/mtk-spmi-pmic-adc.c
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 MediaTek Inc.

Update?

> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/mt6363/registers.h>
> +#include <linux/mfd/mt6373/registers.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
These shouldn't be used.
> +#include <linux/property.h>
only this should be so the of includes should be dropped.
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/syscore_ops.h>
> +
> +#include <dt-bindings/iio/mt635x-auxadc.h>


> +
> +#define AUXADC_RDY_BIT			BIT(15)
> +
> +#define AUXADC_DEF_R_RATIO		1
> +#define AUXADC_DEF_AVG_NUM		32
> +
> +#define AUXADC_AVG_TIME_US		10
> +#define AUXADC_POLL_DELAY_US		100
> +#define AUXADC_TIMEOUT_US		32000
These aren't really magic values so the only benefit in a define
would be to put a comment giving a spec reference next to them.
If not consider just putting the values inline.

> +#define VOLT_FULL			1840

Prefix all defines with something related to the driver.
MT8195_AUXADC_xx
That avoid potential aliasing that can occur with generic names.

> +
> +#define IMP_VOLT_FULL			18400
> +#define IMIX_R_MIN_MOHM			100
> +#define IMIX_R_CALI_CNT			2
> +
> +#define EXT_THR_PURES_SHIFT		3
> +#define EXT_THR_SEL_MASK		0x1F
> +
> +#define DT_CHANNEL_CONVERT(val)		((val) & 0xFF)
> +#define DT_PURES_CONVERT(val)		(((val) & 0xFF00) >> 8)
> +
> +struct pmic_adc_device {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex lock;
All locks must have comment describing the scope of data they protect.
> +	struct iio_chan_spec *iio_chans;

Looks like some of these only exist to avoid passing more variables
into the dt parsing function.  Make them local to the caller of that
and pass them in.  We should not have them in here.

> +	unsigned int nchannels;
> +	const struct auxadc_info *info;
> +	struct regulator *isink_load;
> +	int imix_r;
> +	int imp_curr;
> +	int pre_uisoc;
> +};
> +
> +static struct pmic_adc_device *imix_r_dev;
> +
> +/*

Make this correct kernel-doc. It nearly is already!

> + * @ch_name:	HW channel name
> + * @res:	ADC resolution
> + * @r_ratio:	resistance ratio, represented by r_ratio[0] / r_ratio[1]
> + * @avg_num:	sampling times of AUXADC measurements then average it
> + * @regs:	request and data output registers for this channel
> + */
> +struct auxadc_channels {
> +	enum iio_chan_type type;

Random things aren't documented. Document all structure elements.

> +	long info_mask;
> +	/* AUXADC channel attribute */
> +	const char *ch_name;
> +	unsigned char res;
> +	unsigned char r_ratio[2];
> +	unsigned short avg_num;
> +	const struct auxadc_regs *regs;
> +};
> +
> +#define AUXADC_CHANNEL(_ch_name, _res)	\
> +	[AUXADC_##_ch_name] = {				\
> +		.type = IIO_VOLTAGE,			\
> +		.info_mask = BIT(IIO_CHAN_INFO_RAW) |		\
> +			     BIT(IIO_CHAN_INFO_PROCESSED),	\

We almost never allow both raw and processed. There are a few exceptions
to that rule though. Why does it make sense here?

> +		.ch_name = __stringify(_ch_name),	\
> +		.res = _res,				\
> +	}
> +
> +/*
> + * The array represents all possible AUXADC channels found
> + * in the supported PMICs.
> + */
> +static struct auxadc_channels auxadc_chans[] = {
> +	AUXADC_CHANNEL(BATADC, 15),
> +	AUXADC_CHANNEL(VCDT, 12),
> +	AUXADC_CHANNEL(BAT_TEMP, 12),
> +	AUXADC_CHANNEL(CHIP_TEMP, 12),
> +	AUXADC_CHANNEL(VCORE_TEMP, 12),
> +	AUXADC_CHANNEL(VPROC_TEMP, 12),
> +	AUXADC_CHANNEL(VGPU_TEMP, 12),
> +	AUXADC_CHANNEL(ACCDET, 12),
> +	AUXADC_CHANNEL(HPOFS_CAL, 15),
> +	AUXADC_CHANNEL(VTREF, 12),
> +	AUXADC_CHANNEL(VBIF, 12),
> +	AUXADC_CHANNEL(IMP, 15),
> +	[AUXADC_IMIX_R] = {
> +		.type = IIO_RESISTANCE,
> +		.info_mask = BIT(IIO_CHAN_INFO_RAW),
> +		.ch_name = "IMIX_R",
> +	},
> +	AUXADC_CHANNEL(VSYSSNS, 15),
> +	AUXADC_CHANNEL(VIN1, 15),
> +	AUXADC_CHANNEL(VIN2, 15),
> +	AUXADC_CHANNEL(VIN3, 15),
> +	AUXADC_CHANNEL(VIN4, 15),
> +	AUXADC_CHANNEL(VIN5, 15),
> +	AUXADC_CHANNEL(VIN6, 15),
> +	AUXADC_CHANNEL(VIN7, 15),
> +};
> +
> +struct auxadc_regs {
> +	unsigned int enable_reg;
> +	unsigned int enable_mask;
> +	unsigned int ready_reg;
> +	unsigned int ready_mask;
> +	unsigned int value_reg;
> +	unsigned int ext_thr_sel;
> +	u8 src_sel;
> +};
> +
> +#define AUXADC_REG(_ch_name, _chip, _enable_reg, _enable_mask, _value_reg) \
> +	[AUXADC_##_ch_name] = {				\
> +		.enable_reg = _chip##_##_enable_reg,	\
> +		.enable_mask = _enable_mask,		\
> +		.ready_reg = _chip##_##_value_reg,	\
> +		.ready_mask = AUXADC_RDY_BIT,		\
> +		.value_reg = _chip##_##_value_reg,	\
> +	}						\
Should be no \ on last line.

> +
> +#define TIA_ADC_REG(_src_sel, _chip)	\
> +	[AUXADC_VIN##_src_sel] = {			\
> +		.enable_reg = _chip##_AUXADC_RQST1,	\
> +		.enable_mask = BIT(4),			\
> +		.ready_reg = _chip##_AUXADC_ADC_CH12_L,	\
> +		.ready_mask = AUXADC_RDY_BIT,		\
> +		.value_reg = _chip##_AUXADC_ADC_CH12_L,	\
> +		.ext_thr_sel = _chip##_SDMADC_CON0,	\
> +		.src_sel = _src_sel,			\
> +	}						\
same here.

> +
> +static const struct auxadc_regs mt6363_auxadc_regs_tbl[] = {
> +	AUXADC_REG(BATADC, MT6363, AUXADC_RQST0, BIT(0), AUXADC_ADC0_L),
> +	AUXADC_REG(BAT_TEMP, MT6363, AUXADC_RQST0, BIT(3), AUXADC_ADC3_L),
> +	AUXADC_REG(CHIP_TEMP, MT6363, AUXADC_RQST0, BIT(4), AUXADC_ADC4_L),
> +	AUXADC_REG(VCORE_TEMP, MT6363, AUXADC_RQST3, BIT(0), AUXADC_ADC38_L),
> +	AUXADC_REG(VPROC_TEMP, MT6363, AUXADC_RQST3, BIT(1), AUXADC_ADC39_L),
> +	AUXADC_REG(VGPU_TEMP, MT6363, AUXADC_RQST3, BIT(2), AUXADC_ADC40_L),
> +	AUXADC_REG(VTREF, MT6363, AUXADC_RQST1, BIT(3), AUXADC_ADC11_L),
> +	[AUXADC_IMP] = {
> +		.enable_reg = MT6363_AUXADC_IMP0,
> +		.enable_mask = BIT(0),
> +		.ready_reg = MT6363_AUXADC_IMP1,
> +		.ready_mask = BIT(7),
> +		.value_reg = MT6363_AUXADC_ADC42_L,
> +	},
> +	AUXADC_REG(VSYSSNS, MT6363, AUXADC_RQST1, BIT(6), AUXADC_ADC_CH14_L),
> +	TIA_ADC_REG(1, MT6363),
> +	TIA_ADC_REG(2, MT6363),
> +	TIA_ADC_REG(3, MT6363),
> +	TIA_ADC_REG(4, MT6363),
> +	TIA_ADC_REG(5, MT6363),
> +	TIA_ADC_REG(6, MT6363),
> +	TIA_ADC_REG(7, MT6363),
> +};
> +
> +static const struct auxadc_regs mt6373_auxadc_regs_tbl[] = {
> +	AUXADC_REG(CHIP_TEMP, MT6373, AUXADC_RQST0, BIT(4), AUXADC_ADC4_L),
> +	AUXADC_REG(VCORE_TEMP, MT6373, AUXADC_RQST3, BIT(0), AUXADC_ADC38_L),
> +	AUXADC_REG(VPROC_TEMP, MT6373, AUXADC_RQST3, BIT(1), AUXADC_ADC39_L),
> +	AUXADC_REG(VGPU_TEMP, MT6373, AUXADC_RQST3, BIT(2), AUXADC_ADC40_L),
> +	TIA_ADC_REG(1, MT6373),
> +	TIA_ADC_REG(2, MT6373),
> +	TIA_ADC_REG(3, MT6373),
> +	TIA_ADC_REG(4, MT6373),
> +	TIA_ADC_REG(5, MT6373),
> +};
> +
> +struct auxadc_info {
> +	const struct auxadc_regs *regs_tbl;
> +};
> +
> +static const struct auxadc_info mt6363_info = {
> +	.regs_tbl = mt6363_auxadc_regs_tbl,
> +};
> +
> +static const struct auxadc_info mt6373_info = {
> +	.regs_tbl = mt6373_auxadc_regs_tbl,
> +};
> +
> +#define regmap_bulk_read_poll_timeout(map, addr, val, val_count, cond, sleep_us, timeout_us) \

This looks generic so shouldn't be in a driver.  Either propose it
for the regmap core, or give it a non generic driver specific name.

> +({ \
> +	u64 __timeout_us = (timeout_us); \
> +	unsigned long __sleep_us = (sleep_us); \
> +	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> +	int __ret; \
> +	might_sleep_if(__sleep_us); \
> +	for (;;) { \
> +		__ret = regmap_bulk_read((map), (addr), (u8 *) &(val), val_count); \
> +		if (__ret) \
> +			break; \
> +		if (cond) \
> +			break; \
> +		if ((__timeout_us) && \
> +		    ktime_compare(ktime_get(), __timeout) > 0) { \
> +			__ret = regmap_bulk_read((map), (addr), (u8 *) &(val), val_count); \
> +			break; \
> +		} \
> +		if (__sleep_us) \
> +			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +	} \
> +	__ret ?: ((cond) ? 0 : -ETIMEDOUT); \
> +})
> +
> +/*
For this sort of text make it all kernel-doc style and run the script
on the file to make sure no warnings / errors.

> + * @adc_dev:	 pointer to the struct pmic_adc_device
> + * @auxadc_chan: pointer to the struct auxadc_channels, it represents specific
> +		 auxadc channel
> + * @val:	 pointer to output value
> + */
> +static int get_auxadc_out(struct pmic_adc_device *adc_dev,
> +			  int channel, int channel2, int *val)

For example these parameters are different from the docs and
the kernel-doc script would point that out for you.

> +{
> +	int ret;
> +	u16 buf = 0;
> +	const struct auxadc_channels *auxadc_chan = &auxadc_chans[channel];
> +
> +	if (!auxadc_chan->regs)
> +		return -EINVAL;

Why would that happen?  Don't defend against things that can't occur.

> +
> +	if (auxadc_chan->regs->ext_thr_sel) {
> +		buf = (channel2 << EXT_THR_PURES_SHIFT)
> +			| auxadc_chan->regs->src_sel;

FIELD_PREP plus use appropriate mask not shift.  Also apply
FIELD_PREP() for the src_sel.

Avoids anyone needing to check values are in range or where the
various register fields are.

> +		ret = regmap_update_bits(adc_dev->regmap,
> +					 auxadc_chan->regs->ext_thr_sel,
> +					 EXT_THR_SEL_MASK, buf);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	regmap_write(adc_dev->regmap,
Check for errors.

> +		     auxadc_chan->regs->enable_reg,
> +		     auxadc_chan->regs->enable_mask);
> +	usleep_range(auxadc_chan->avg_num * AUXADC_AVG_TIME_US,
> +		     (auxadc_chan->avg_num + 1) * AUXADC_AVG_TIME_US);
> +
> +	ret = regmap_bulk_read_poll_timeout(adc_dev->regmap,
> +					    auxadc_chan->regs->value_reg,
> +					    buf, 2,

buf should be u16 and use sizeof(buf) for that 2.

> +					    (buf & AUXADC_RDY_BIT),
brackets add nothing.
> +					    AUXADC_POLL_DELAY_US,
> +					    AUXADC_TIMEOUT_US);
> +	*val = buf & (BIT(auxadc_chan->res) - 1);
> +	if (ret)
> +		dev_err(adc_dev->dev, "%s ret error code:%d!\n", auxadc_chan->ch_name, ret);
> +
> +	/* set PURES to OPEN after measuring done */
> +	if (auxadc_chan->regs->ext_thr_sel) {
> +		buf = (ADC_PURES_OPEN << EXT_THR_PURES_SHIFT)
> +			| auxadc_chan->regs->src_sel;
FIELD_PREP() for both of those.

> +		ret = regmap_update_bits(adc_dev->regmap,
> +					 auxadc_chan->regs->ext_thr_sel,
> +					 EXT_THR_SEL_MASK, buf);

Overwrite the earlier error potentially which is not something we normally
want to do as can make debugging harder.

> +	}
> +
> +	return ret;
> +}
> +
> +static int gauge_get_imp_ibat(void)
> +{
> +	struct power_supply *psy;
> +	union power_supply_propval prop;
> +	int ret;
> +
> +	psy = power_supply_get_by_name("mtk-gauge");
> +	if (!psy)
> +		return 0;
> +
> +	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &prop);
> +	if (ret)
> +		return ret;
> +
> +	power_supply_put(psy);
> +	return prop.intval;
> +}
> +
> +static int get_imp_out(struct pmic_adc_device *adc_dev, int *val)
> +{
> +	int ret;
> +	unsigned int buf = 0;
> +	const struct auxadc_channels *auxadc_chan = &auxadc_chans[AUXADC_IMP];
> +
> +	if (!auxadc_chan->regs)
> +		return -EINVAL;
> +
> +	regmap_write(adc_dev->regmap,

Probably worth a local variable for the regmap to shorten some lines.

> +		     auxadc_chan->regs->enable_reg,
> +		     auxadc_chan->regs->enable_mask);

Check for errors.

> +	ret = regmap_read_poll_timeout(adc_dev->regmap, auxadc_chan->regs->ready_reg,
> +					   buf, buf & auxadc_chan->regs->ready_mask,
> +					   AUXADC_POLL_DELAY_US,
> +					   AUXADC_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(adc_dev->dev, "%s %s ret error code:%d!\n",
> +			__func__, auxadc_chan->ch_name, ret);
No need for the __func__ in here.  Say what failed in the error message.
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(adc_dev->regmap, auxadc_chan->regs->value_reg, (u8 *) &buf, 2);

Why cast to u8 *?  It takes a void * and you never need to cast to that.
However, you also shouldn't be doing a 2 byte read into a integer.  Use a u16
and get the size with appropriate sizeof()



> +	if (ret)
> +		return ret;
> +	*val = buf & (BIT(auxadc_chan->res) - 1);
> +	adc_dev->imp_curr = gauge_get_imp_ibat();
> +
> +	regmap_write(adc_dev->regmap,
> +		     auxadc_chan->regs->enable_reg, 0);

Check for errors.

> +
> +	return 0;
> +}
> +
> +static int pmic_adc_read_raw(struct iio_dev *indio_dev,

All functions should be prefixed with driver name. Avoids
potential clashes if generic stuff ends up in headers later.

> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct pmic_adc_device *adc_dev = iio_priv(indio_dev);
> +	const struct auxadc_channels *auxadc_chan;
> +	int auxadc_out = 0;
> +	int ret = 0;
> +
> +	mutex_lock(&adc_dev->lock);
consider pushing the lock down into the various implementations.
> +	switch (chan->channel) {
> +	case AUXADC_IMP:
> +		ret = get_imp_out(adc_dev, &auxadc_out);
> +		break;
> +	case AUXADC_IMIX_R:
> +		auxadc_out = adc_dev->imix_r;
> +		break;
> +	default:
> +		ret = get_auxadc_out(adc_dev,
> +				     chan->channel, chan->channel2,
> +				     &auxadc_out);
> +		break;
> +	}
> +	mutex_unlock(&adc_dev->lock);
> +
> +	if (ret && ret != -ETIMEDOUT)
> +		return ret;

Why would you carry on if it timed out?

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		auxadc_chan = &auxadc_chans[chan->channel];
> +		*val = auxadc_out * auxadc_chan->r_ratio[0] * VOLT_FULL;
> +		*val = (*val / auxadc_chan->r_ratio[1]) >> auxadc_chan->res;
This looks linear - in which case why not leave the maths to userspace
and provide IIO_CHAN_INFO_SCALE + _RAW

> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_RAW:

Why provide this at all if you are providing processed output.

> +		*val = auxadc_out;
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (chan->channel == AUXADC_IMP) {
> +		*val2 = adc_dev->imp_curr;
> +		ret = IIO_VAL_INT_MULTIPLE;
> +	}
> +
> +	return ret;
> +}

> +
> +static const struct iio_info pmic_adc_info = {
> +	.read_raw = &pmic_adc_read_raw,
> +	.fwnode_xlate = &pmic_adc_fwnode_xlate,
> +};
> +
> +static int auxadc_init_imix_r(struct pmic_adc_device *adc_dev,
> +			      struct device_node *imix_r_node)
> +{
> +	unsigned int val = 0;
> +	int ret;
> +
> +	if (!adc_dev)
> +		return -EINVAL;
> +
> +	adc_dev->isink_load = devm_regulator_get_exclusive(adc_dev->dev, "isink_load");
> +	if (IS_ERR(adc_dev->isink_load)) {
> +		dev_err(adc_dev->dev, "Failed to get isink_load regulator, ret=%d\n",
> +			(int)PTR_ERR(adc_dev->isink_load));
> +		return PTR_ERR(adc_dev->isink_load);

Use dev_err_probe() which will also pretty print the return value so remember to
drop that bit.

> +	}
> +
> +	imix_r_dev = adc_dev;
> +	if (imix_r_dev->imix_r)
> +		return 0;
> +
> +	ret = of_property_read_u32(imix_r_node, "val", &val);
> +	if (ret)
> +		dev_notice(imix_r_dev->dev, "no imix_r, ret=%d\n", ret);
> +	imix_r_dev->imix_r = (int)val;
> +	imix_r_dev->pre_uisoc = 101;
> +	return 0;
> +}
> +
> +static int auxadc_get_data_from_dt(struct pmic_adc_device *adc_dev,

from_fw() and use the generic property.h accessors, not the dt specific ones.

> +				   struct iio_chan_spec *iio_chan,
> +				   struct device_node *node)
> +{
> +	struct auxadc_channels *auxadc_chan;
> +	unsigned int channel = 0;
> +	unsigned int value = 0;
> +	unsigned int val_arr[2] = {0};
> +	int ret;
> +
> +	ret = of_property_read_u32(node, "channel", &channel);

That doesn't looks like a standard dt binding. why do you need it
vs what is in adc.yaml?  Probably just reg is enough.


> +	if (ret) {
> +		dev_err(adc_dev->dev, "invalid channel in node:%s\n",
> +			   node->name);

use return dev_err_probe() for all error prints that are part of probe.
Gives prettier printing and other benefits in some cases.

> +		return ret;
> +	}
> +	if (channel > AUXADC_CHAN_MAX) {
> +		dev_err(adc_dev->dev, "invalid channel number %d in node:%s\n",
> +			   channel, node->name);
> +		return -EINVAL;
> +	}
> +	if (channel >= ARRAY_SIZE(auxadc_chans)) {
> +		dev_err(adc_dev->dev, "channel number %d in node:%s not exists\n",
> +			   channel, node->name);
> +		return -EINVAL;
> +	}
> +	iio_chan->channel = channel;
> +	iio_chan->datasheet_name = auxadc_chans[channel].ch_name;
> +	iio_chan->info_mask_separate = auxadc_chans[channel].info_mask;
> +	iio_chan->type = auxadc_chans[channel].type;
> +	iio_chan->extend_name = node->name;

No. This is almost never used in a modern driver as it makes for really nasty
userspace ABI.  Use label if you need to mark a channel as something specific.

> +	ret = of_property_read_u32(node, "pures", &value);

I have no idea what this one is or why you'd put anything in channel2 for
a single ended ADC channel with no modifier.


> +	if (!ret)
> +		iio_chan->channel2 = value;
> +
> +	if (channel == AUXADC_IMIX_R)
> +		return auxadc_init_imix_r(adc_dev, node);
> +
> +	auxadc_chan = &auxadc_chans[channel];
> +	auxadc_chan->regs = &adc_dev->info->regs_tbl[channel];
> +
> +	ret = of_property_read_u32_array(node, "resistance-ratio", val_arr, 2);

Interesting but not standard DT binding. In general this seems to have no connect
to the dt bindings in this seris.

> +	if (!ret) {
> +		auxadc_chan->r_ratio[0] = val_arr[0];
> +		auxadc_chan->r_ratio[1] = val_arr[1];
> +	} else {
> +		auxadc_chan->r_ratio[0] = AUXADC_DEF_R_RATIO;
> +		auxadc_chan->r_ratio[1] = 1;
> +	}
> +
> +	ret = of_property_read_u32(node, "avg-num", &value);

Also not a standing binding and rarely found in DT because it
is usually a policy decision on noise vs sampling rate and exposed as
oversampling control to userspace.

> +	if (!ret)
> +		auxadc_chan->avg_num = value;
> +	else
> +		auxadc_chan->avg_num = AUXADC_DEF_AVG_NUM;
> +
> +	return 0;
> +}
> +
> +static int auxadc_parse_dt(struct pmic_adc_device *adc_dev,

parse_fw() as you'll be using generic accessors thoughout.

> +			   struct device_node *node)
> +{
> +	struct iio_chan_spec *iio_chan;
> +	struct device_node *child;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	adc_dev->nchannels = of_get_available_child_count(node);

Use generic property accessors, not of specific ones (property.h)

> +	if (!adc_dev->nchannels)
> +		return -EINVAL;
> +
> +	adc_dev->iio_chans = devm_kcalloc(adc_dev->dev, adc_dev->nchannels,
> +		sizeof(*adc_dev->iio_chans), GFP_KERNEL);
> +	if (!adc_dev->iio_chans)
> +		return -ENOMEM;
> +	iio_chan = adc_dev->iio_chans;
> +
> +	for_each_available_child_of_node(node, child) {
> +		ret = auxadc_get_data_from_dt(adc_dev, iio_chan, child);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +		iio_chan->indexed = 1;
> +		iio_chan->address = index++;
> +		iio_chan++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pmic_adc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct pmic_adc_device *adc_dev;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc_dev = iio_priv(indio_dev);
> +	adc_dev->dev = &pdev->dev;
> +	adc_dev->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	mutex_init(&adc_dev->lock);
In new drivers I prefer to see
	ret = devm_mutex_init()
	if (ret)
		return ret;

Brings only a minor debug benefit, but the cost of getting that is
low so it is a nice thing to have!

> +	adc_dev->info = of_device_get_match_data(&pdev->dev);
> +
> +	ret = auxadc_parse_dt(adc_dev, node);
> +	if (ret) {
> +		dev_notice(&pdev->dev, "auxadc_parse_dt fail, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->dev.parent = &pdev->dev;

No need for that - it's done the IIO core.

> +	indio_dev->name = dev_name(&pdev->dev);

This needs to be the part number, not come from the device name which can
be very different depending on how the device is created etc.
So just hard code the part number in the info structure and set it here.


> +	indio_dev->info = &pmic_adc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adc_dev->iio_chans;
> +	indio_dev->num_channels = adc_dev->nchannels;
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_notice(&pdev->dev, "failed to register iio device!\n");
dev_err() given if you manage to hit here you definitely have an error.
Same for other error paths.

> +		return ret;
> +	}
> +
> +	dev_dbg(&pdev->dev, "probe done\n");
No purpose in this one.  It is very easy to see if probe succeeded without it.
> +
> +	return 0;
> +}


