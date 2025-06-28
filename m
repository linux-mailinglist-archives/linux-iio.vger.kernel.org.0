Return-Path: <linux-iio+bounces-21048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D4AEC871
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BAE189E3C3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005C219313;
	Sat, 28 Jun 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LphNWFEr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD22110;
	Sat, 28 Jun 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126489; cv=none; b=W5cnhD042s6S828xlP92ku8NmJuCdGJqLphuR4Sq9QXeT+nFNENM5M7P5TrfFNd+TP71vkbIG4dHDmgknyK+W6I04rMkE07ykDj1WOX2BVCWg1FoXta+h9QkM+gdFXB7T19J0JiUgizo6LDxylgTR3IvNm8va2IgB7FQxAHyKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126489; c=relaxed/simple;
	bh=QNuH3SHReMcWcui0DlPwcrn2+UCUB+hx5I5pQ/AKsOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDem2yVHFlO9hg9Jy0pe2pHqFJq1TaGQR+CPXr0mE92LDLAZAiUvdPGHemmE9BjDgNqk41Ai24Eq5xuuE0dLZxrEGG7dD++Wnj2s/ciNY1o/KQ6qP76vVWBvB/Okn5AvBT+yPznh9tx72ryIi9evlHiOafaLwSAUdH8zOzqfKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LphNWFEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F75EC4CEEA;
	Sat, 28 Jun 2025 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126489;
	bh=QNuH3SHReMcWcui0DlPwcrn2+UCUB+hx5I5pQ/AKsOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LphNWFErKGcTmeLC0pcxmr7LPO7iJdYMZVALgSVAKUC4jIMwCRTlNOhVZPEcEOTWh
	 hHxe/mXdL1CbI9HfaPQLLW7TNYdfslTWrHG6xKRAelIJZPvZZOjckwx8TMk5LReg18
	 mCvFae0T5KVUpAjX8r34Z5A6uL+jifRDxJTGr/+is2fx0jpljup9GJs1HSk5GUWZYy
	 ioqUW2iTtlhRTp/P67+q1q3AsxNAM1cnZjvagDf7hGGhTM0lEIQprp+8pXoyd/kssC
	 ci3VqVs6kcEMracx6v43N2LOyx3KJzwbRWs2sBl9F1/LvekY6VLFQIxkGvS54zErms
	 3SjitU9iXgaFw==
Date: Sat, 28 Jun 2025 17:01:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v1 4/5] iio: adc: mt6359: Add support for MediaTek
 MT6363 PMIC AUXADC
Message-ID: <20250628170118.2bd3e68b@jic23-huawei>
In-Reply-To: <20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
	<20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 14:00:27 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> MediaTek MT6363 is a PMIC found on MT8196/MT6991 board designs
> and communicates with the SoC over SPMI.
> 
> This PMIC integrates an Auxiliary ADC (AUXADC) which has a grand
> total of 54 ADC channels: 49 PMIC-internal channels, 2 external
> NTC thermistor channels and 2 generic ADC channels (mapped to 7
> PMIC ADC external inputs).
> 
> To use a generic ADC channel it is necessary to enable one of
> the PMIC ADC inputs at a time and only then start the reading,
> so in this case it is possible to read only one external input
> for each generic ADC channel.
> 
> Due to the lack of documentation, this implementation supports
> using only one generic ADC channel, hence supports reading only
> one external input at a time.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Hi,

A few comments that may or may not overlap with Andy's review.

thanks,

Jonathan

> ---
>  drivers/iio/adc/mt6359-auxadc.c | 238 +++++++++++++++++++++++++++++---
>  1 file changed, 217 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> index ae7b65f5f551..f49b0b6e78da 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c

> +enum mtk_pmic_auxadc_flags {
> +	MTK_PMIC_AUXADC_IS_SPMI = BIT(0),
> +	MTK_PMIC_AUXADC_NO_RESET = BIT(1),
> +};

With just two bits I think flags obscures what is going on over
a pair of separate booleans.

>  };
> @@ -123,7 +155,9 @@ struct mtk_pmic_auxadc_chan {
>   * @desc:           PMIC AUXADC channel data
>   * @regs:           List of PMIC specific registers
>   * @sec_unlock_key: Security unlock key for HK_TOP writes
> + * @vref_mv:        AUXADC Reference Voltage (VREF) in millivolts
>   * @imp_adc_num:    ADC channel for battery impedance readings
> + * @flags:          Feature flags
>   * @read_imp:       Callback to read impedance channels
>   */
>  struct mtk_pmic_auxadc_info {
> @@ -133,22 +167,33 @@ struct mtk_pmic_auxadc_info {
>  	const struct mtk_pmic_auxadc_chan *desc;
>  	const u16 *regs;
>  	u16 sec_unlock_key;
> +	u16 vref_mv;
I'd not worry about the space saving here and instead make this a u32 so that
can avoid the casting when using this.

>  	u8 imp_adc_num;
> +	u8 flags;

As above. Pair of bool preferred.

>  	int (*read_imp)(struct mt6359_auxadc *adc_dev,
>  			const struct iio_chan_spec *chan, int *vbat, int *ibat);
>  };

>  static void mt6358_stop_imp_conv(struct mt6359_auxadc *adc_dev)
>  {
>  	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
> @@ -379,13 +488,13 @@ static int mt6359_read_imp(struct mt6359_auxadc *adc_dev,
>  	int ret;
>  
>  	/* Start conversion */
> -	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
> +	regmap_write(regmap, cinfo->regs[desc->req_idx], desc->req_mask);

Given desc->req_idx is not introduced in this patch, why is this needed now
but not previously?  Maybe this change belongs in a separate patch with
a description to explain that.

>  	ret = regmap_read_poll_timeout(regmap, cinfo->regs[desc->rdy_idx],
>  				       val, val & desc->rdy_mask,
>  				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
>  
>  	/* Stop conversion regardless of the result */
> -	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], 0);
> +	regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
>  	if (ret)
>  		return ret;
>  
> @@ -416,6 +525,7 @@ static const struct mtk_pmic_auxadc_info mt6357_chip_info = {
>  	.regs = mt6357_auxadc_regs,
>  	.imp_adc_num = MT6357_IMP_ADC_NUM,
>  	.read_imp = mt6358_read_imp,
> +	.vref_mv = 1800,
>  };
>  
>  static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
> @@ -426,6 +536,7 @@ static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
>  	.regs = mt6358_auxadc_regs,
>  	.imp_adc_num = MT6358_IMP_ADC_NUM,
>  	.read_imp = mt6358_read_imp,
> +	.vref_mv = 1800,
>  };
>  
>  static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
> @@ -436,6 +547,17 @@ static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
>  	.regs = mt6359_auxadc_regs,
>  	.sec_unlock_key = 0x6359,
>  	.read_imp = mt6359_read_imp,
> +	.vref_mv = 1800,

Add vref_mv and code using it in a precursor patch.  Not a problem that all
vref_mv will be 1800 at that point.  That way we can quickly see that it
has no affect on existing parts, and simplify what is present in this patch.

> +};
> +
> +static const struct mtk_pmic_auxadc_info mt6363_chip_info = {
> +	.model_name = "MT6363",
> +	.channels = mt6363_auxadc_channels,
> +	.num_channels = ARRAY_SIZE(mt6363_auxadc_channels),
> +	.desc = mt6363_auxadc_ch_desc,
> +	.regs = mt6363_auxadc_regs,
> +	.flags = MTK_PMIC_AUXADC_IS_SPMI | MTK_PMIC_AUXADC_NO_RESET,
> +	.vref_mv = 1840,
>  };
>  
>  static void mt6359_auxadc_reset(struct mt6359_auxadc *adc_dev)
> @@ -464,27 +586,74 @@ static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
>  	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
>  	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
>  	struct regmap *regmap = adc_dev->regmap;
> -	u32 val;
> +	u32 reg, rdy_mask, val, lval;
> +	u8 ext_sel;
>  	int ret;
>  
> +	if (desc->ext_sel_idx >= 0) {
> +		ext_sel = FIELD_PREP(MT6363_EXT_PURES_MASK, desc->ext_sel_pu);
> +		ext_sel |= FIELD_PREP(MT6363_EXT_CHAN_MASK, desc->ext_sel_ch);
> +
> +		ret = regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
> +					 MT6363_EXT_PURES_MASK | MT6363_EXT_CHAN_MASK,
> +					 ext_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* Request to start sampling for ADC channel */
>  	ret = regmap_write(regmap, cinfo->regs[desc->req_idx], desc->req_mask);
>  	if (ret)
> -		return ret;
> +		goto end;
>  
>  	/* Wait until all samples are averaged */
>  	fsleep(desc->num_samples * AUXADC_AVG_TIME_US);
>  
> -	ret = regmap_read_poll_timeout(regmap,
> -				       cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1),
> -				       val, val & PMIC_AUXADC_RDY_BIT,
> +	reg = cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1);
> +	rdy_mask = PMIC_AUXADC_RDY_BIT;
> +
> +	/*
> +	 * Even though for both PWRAP and SPMI cases the ADC HW signals that
> +	 * the data is ready by setting AUXADC_RDY_BIT, for SPMI the register
> +	 * read is only 8 bits long: for this case, the check has to be done
> +	 * on the ADC(x)_H register (high bits) and the rdy_mask needs to be
> +	 * shifted to the right by the same 8 bits.
> +	 */
> +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {

This is getting close to the point where the complexity for the IS_SPMI case
is compled enough you'd be better off just splitting the code.  I'd try that
and see if it ends up neater than this.

> +		rdy_mask >>= 8;
> +		reg += 1;
> +	}
> +
> +	ret = regmap_read_poll_timeout(regmap, reg, val, val & rdy_mask,
>  				       AUXADC_POLL_DELAY_US, AUXADC_TIMEOUT_US);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		dev_dbg(adc_dev->dev, "ADC read timeout for chan %lu\n", chan->address);
> +		goto end;
> +	}
> +
> +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {
> +		/* If the previous read succeeded, this can't fail */

As per discussion with Andy, I don't think we can ever assume that.

> +		regmap_read(regmap, reg - 1, &lval);
> +		val = (val << 8) | lval;
> +	}
>  
> -	/* Stop sampling */

If you have code that ends up with an internal goto for a specific
block, that often suggests you should be factoring some code out to simplify
the flow.

I would take everything between the activiate ADC GPIO and deactivate out
as another function.  That will still need a goto to get to the stop
sampling but then we won't have the dance below where we do some
stuff from the main code flow on error and then exit (with more after
that not run).

> +end:
> +	/* Stop sampling unconditionally... */
>  	regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
>  
> +	/* ...and deactivate the ADC GPIO if previously done */
> +	if (desc->ext_sel_idx >= 0) {
> +		ext_sel = FIELD_PREP(MT6363_EXT_PURES_MASK, MT6363_PULLUP_RES_OPEN);
> +
> +		regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
> +				   MT6363_EXT_PURES_MASK, ext_sel);
> +	}
> +
> +	/* Check if we reached this point because of an error or regular flow */
> +	if (ret)
> +		return ret;
> +
> +	/* Everything went fine, give back the ADC reading */
>  	*out = val & GENMASK(chan->scan_type.realbits - 1, 0);
>  	return 0;
>  }
> @@ -505,7 +674,7 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	if (mask == IIO_CHAN_INFO_SCALE) {
> -		*val = desc->r_ratio.numerator * AUXADC_VOLT_FULL;
> +		*val = desc->r_ratio.numerator * (u32)cinfo->vref_mv;

As above.  If vref_mv was already a (u32) no need to cast here.


