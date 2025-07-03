Return-Path: <linux-iio+bounces-21295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADEAF74FF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04874E0A14
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D604B2E62DF;
	Thu,  3 Jul 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KDACpp1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315123AB86;
	Thu,  3 Jul 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547943; cv=none; b=r3yGnsbvoDCd91/BB2Rj0RDUrtEI//1qYNpXwwHD+mhvl+9wE2saS9iCZWwF/BbGQOMA94FimIULku/zkqtiVk1avExQH2Jvh+dByfTeQozfyy1HetF3VMA87WWp4sgjlF4Rg50zzdZXMfkDwQWk40BO5wz+n+aq+bnuEwjeetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547943; c=relaxed/simple;
	bh=GpN8xHP63XM+oTXtjDyjENa6zCm9aLFaBITzhIXThVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBu8OUWrQxL9zEE6oVCZWwScm7H8ze4xbGIS7qM8gwQ63BItspbe83QuCs3CC8cLkYfFaqZ4LCmbTWo7tLH7iBgl3KF8D+kgo6U1ofofsHXbdJ2Ce82dEDLi3dQjLdENtKp0eIAnuyBQactjE8y8J7gI7Ecsuqu4pM9gc0DrDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KDACpp1Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751547939;
	bh=GpN8xHP63XM+oTXtjDyjENa6zCm9aLFaBITzhIXThVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDACpp1QMNA461z1ue9x8IPlUIObuv3owwbXpsmhy/7s7y+cNE8tEQwkbHNVtAGXv
	 DX2S4cgAFcTAxMhSBQXX/G25TJZinfcgxebypD+fShb5YQeZIaRRUbEqXti4KxZud5
	 6TmA8LjhiGLj9Tf+54Dit/E/69zHbDceZIcll+NeEDzLWD1si2Dp0z+l2n+GRh5g7Q
	 nYZEzXikzlJSBgn/4TYgft7oXmhI4h2kD90EqEzPCEhkf4JxbKkWauc2FdJkMEkvGG
	 7q9LeqpcWAI56/TD50rWtCyZmux4fLksYhfgIv7OogR/cX2mGFr7V3KmSUXQYbF0DU
	 auIIAMI3Loqhg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A313717E0506;
	Thu,  3 Jul 2025 15:05:38 +0200 (CEST)
Message-ID: <183a3b40-cd06-437a-84d9-9949965bf176@collabora.com>
Date: Thu, 3 Jul 2025 15:05:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] iio: adc: mt6359: Add support for MediaTek MT6363
 PMIC AUXADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
 <20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
 <20250628170118.2bd3e68b@jic23-huawei>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250628170118.2bd3e68b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/06/25 18:01, Jonathan Cameron ha scritto:
> On Mon, 23 Jun 2025 14:00:27 +0200
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> MediaTek MT6363 is a PMIC found on MT8196/MT6991 board designs
>> and communicates with the SoC over SPMI.
>>
>> This PMIC integrates an Auxiliary ADC (AUXADC) which has a grand
>> total of 54 ADC channels: 49 PMIC-internal channels, 2 external
>> NTC thermistor channels and 2 generic ADC channels (mapped to 7
>> PMIC ADC external inputs).
>>
>> To use a generic ADC channel it is necessary to enable one of
>> the PMIC ADC inputs at a time and only then start the reading,
>> so in this case it is possible to read only one external input
>> for each generic ADC channel.
>>
>> Due to the lack of documentation, this implementation supports
>> using only one generic ADC channel, hence supports reading only
>> one external input at a time.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Hi,
> 
> A few comments that may or may not overlap with Andy's review.
> 
> thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/adc/mt6359-auxadc.c | 238 +++++++++++++++++++++++++++++---
>>   1 file changed, 217 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
>> index ae7b65f5f551..f49b0b6e78da 100644
>> --- a/drivers/iio/adc/mt6359-auxadc.c
>> +++ b/drivers/iio/adc/mt6359-auxadc.c
> 
>> +enum mtk_pmic_auxadc_flags {
>> +	MTK_PMIC_AUXADC_IS_SPMI = BIT(0),
>> +	MTK_PMIC_AUXADC_NO_RESET = BIT(1),
>> +};
> 
> With just two bits I think flags obscures what is going on over
> a pair of separate booleans.
> 

Okay, I'll change this to two booleans then!

>>   };
>> @@ -123,7 +155,9 @@ struct mtk_pmic_auxadc_chan {
>>    * @desc:           PMIC AUXADC channel data
>>    * @regs:           List of PMIC specific registers
>>    * @sec_unlock_key: Security unlock key for HK_TOP writes
>> + * @vref_mv:        AUXADC Reference Voltage (VREF) in millivolts
>>    * @imp_adc_num:    ADC channel for battery impedance readings
>> + * @flags:          Feature flags
>>    * @read_imp:       Callback to read impedance channels
>>    */
>>   struct mtk_pmic_auxadc_info {
>> @@ -133,22 +167,33 @@ struct mtk_pmic_auxadc_info {
>>   	const struct mtk_pmic_auxadc_chan *desc;
>>   	const u16 *regs;
>>   	u16 sec_unlock_key;
>> +	u16 vref_mv;
> I'd not worry about the space saving here and instead make this a u32 so that
> can avoid the casting when using this.
> 

Okay, will do.

>>   	u8 imp_adc_num;
>> +	u8 flags;
> 
> As above. Pair of bool preferred.
> 
>>   	int (*read_imp)(struct mt6359_auxadc *adc_dev,
>>   			const struct iio_chan_spec *chan, int *vbat, int *ibat);
>>   };
> 
>>   static void mt6358_stop_imp_conv(struct mt6359_auxadc *adc_dev)
>>   {
>>   	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
>> @@ -379,13 +488,13 @@ static int mt6359_read_imp(struct mt6359_auxadc *adc_dev,
>>   	int ret;
>>   
>>   	/* Start conversion */
>> -	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
>> +	regmap_write(regmap, cinfo->regs[desc->req_idx], desc->req_mask);
> 
> Given desc->req_idx is not introduced in this patch, why is this needed now
> but not previously?  Maybe this change belongs in a separate patch with
> a description to explain that.
> 

Oh wow, many many many... many thanks for catching this!!!!

This change was not supposed to be in this commit, as I had implemented both
the IBAT and VBAT "IMP" for the 6363 but then left them out because I was in
doubt whether to add them here or if they are read from the fuel gauge chip
transparently and in firmware; I wouldn't even be able to test that on the
MT8196 Chromebook that I'm bringing up, because the battery is managed by EC
instead, unlike smartphones.

I have to remove that from mt6359_read_imp, the addition was unintentional;
only mt6359_auxadc_read_adc() should use it (and already did before this commit).

>>   	ret = regmap_read_poll_timeout(regmap, cinfo->regs[desc->rdy_idx],
>>   				       val, val & desc->rdy_mask,
>>   				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
>>   
>>   	/* Stop conversion regardless of the result */
>> -	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], 0);
>> +	regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -416,6 +525,7 @@ static const struct mtk_pmic_auxadc_info mt6357_chip_info = {
>>   	.regs = mt6357_auxadc_regs,
>>   	.imp_adc_num = MT6357_IMP_ADC_NUM,
>>   	.read_imp = mt6358_read_imp,
>> +	.vref_mv = 1800,
>>   };
>>   
>>   static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
>> @@ -426,6 +536,7 @@ static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
>>   	.regs = mt6358_auxadc_regs,
>>   	.imp_adc_num = MT6358_IMP_ADC_NUM,
>>   	.read_imp = mt6358_read_imp,
>> +	.vref_mv = 1800,
>>   };
>>   
>>   static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
>> @@ -436,6 +547,17 @@ static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
>>   	.regs = mt6359_auxadc_regs,
>>   	.sec_unlock_key = 0x6359,
>>   	.read_imp = mt6359_read_imp,
>> +	.vref_mv = 1800,
> 
> Add vref_mv and code using it in a precursor patch.  Not a problem that all
> vref_mv will be 1800 at that point.  That way we can quickly see that it
> has no affect on existing parts, and simplify what is present in this patch.
> 

Right, I agree. I'll move that addition to a separate patch.

>> +};
>> +
>> +static const struct mtk_pmic_auxadc_info mt6363_chip_info = {
>> +	.model_name = "MT6363",
>> +	.channels = mt6363_auxadc_channels,
>> +	.num_channels = ARRAY_SIZE(mt6363_auxadc_channels),
>> +	.desc = mt6363_auxadc_ch_desc,
>> +	.regs = mt6363_auxadc_regs,
>> +	.flags = MTK_PMIC_AUXADC_IS_SPMI | MTK_PMIC_AUXADC_NO_RESET,
>> +	.vref_mv = 1840,
>>   };
>>   
>>   static void mt6359_auxadc_reset(struct mt6359_auxadc *adc_dev)
>> @@ -464,27 +586,74 @@ static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
>>   	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
>>   	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
>>   	struct regmap *regmap = adc_dev->regmap;
>> -	u32 val;
>> +	u32 reg, rdy_mask, val, lval;
>> +	u8 ext_sel;
>>   	int ret;
>>   
>> +	if (desc->ext_sel_idx >= 0) {
>> +		ext_sel = FIELD_PREP(MT6363_EXT_PURES_MASK, desc->ext_sel_pu);
>> +		ext_sel |= FIELD_PREP(MT6363_EXT_CHAN_MASK, desc->ext_sel_ch);
>> +
>> +		ret = regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
>> +					 MT6363_EXT_PURES_MASK | MT6363_EXT_CHAN_MASK,
>> +					 ext_sel);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	/* Request to start sampling for ADC channel */
>>   	ret = regmap_write(regmap, cinfo->regs[desc->req_idx], desc->req_mask);
>>   	if (ret)
>> -		return ret;
>> +		goto end;
>>   
>>   	/* Wait until all samples are averaged */
>>   	fsleep(desc->num_samples * AUXADC_AVG_TIME_US);
>>   
>> -	ret = regmap_read_poll_timeout(regmap,
>> -				       cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1),
>> -				       val, val & PMIC_AUXADC_RDY_BIT,
>> +	reg = cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1);
>> +	rdy_mask = PMIC_AUXADC_RDY_BIT;
>> +
>> +	/*
>> +	 * Even though for both PWRAP and SPMI cases the ADC HW signals that
>> +	 * the data is ready by setting AUXADC_RDY_BIT, for SPMI the register
>> +	 * read is only 8 bits long: for this case, the check has to be done
>> +	 * on the ADC(x)_H register (high bits) and the rdy_mask needs to be
>> +	 * shifted to the right by the same 8 bits.
>> +	 */
>> +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {
> 
> This is getting close to the point where the complexity for the IS_SPMI case
> is compled enough you'd be better off just splitting the code.  I'd try that
> and see if it ends up neater than this.
> 

That was the first thing I did... but it's not so many changes... I'd be ending
up almost completely duplicating this driver for no reason.

I'm mostly sure that there won't be any more spmi-specific differences in the
AuxADC, but if one day turns out I'm wrong, I guess we can always split the
driver in two and move the SPMI platforms away... but again, I'm mostly sure
that won't happen.

>> +		rdy_mask >>= 8;
>> +		reg += 1;
>> +	}
>> +
>> +	ret = regmap_read_poll_timeout(regmap, reg, val, val & rdy_mask,
>>   				       AUXADC_POLL_DELAY_US, AUXADC_TIMEOUT_US);
>> -	if (ret)
>> -		return ret;
>> +	if (ret) {
>> +		dev_dbg(adc_dev->dev, "ADC read timeout for chan %lu\n", chan->address);
>> +		goto end;
>> +	}
>> +
>> +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {
>> +		/* If the previous read succeeded, this can't fail */
> 
> As per discussion with Andy, I don't think we can ever assume that.
> 

I'll add all the checks around :-)

>> +		regmap_read(regmap, reg - 1, &lval);
>> +		val = (val << 8) | lval;
>> +	}
>>   
>> -	/* Stop sampling */
> 
> If you have code that ends up with an internal goto for a specific
> block, that often suggests you should be factoring some code out to simplify
> the flow.
> 
> I would take everything between the activiate ADC GPIO and deactivate out
> as another function.  That will still need a goto to get to the stop
> sampling but then we won't have the dance below where we do some
> stuff from the main code flow on error and then exit (with more after
> that not run).
> 

Actually, I have removed the goto as well - I moved everything but the write
to stop the sampling to a new function; I'm calling it, then stopping the
sampling unconditionally, as was already done before.

To let you understand, this is the description:
/**
  * mt6359_auxadc_sample_value() - Start ADC channel sampling and read value
  * @adc_dev: Main driver structure
  * @out:     Preallocated variable to store the value read from HW
  *
  * This function starts the sampling for an ADC channel, waits until all
  * of the samples are averaged and then reads the value from the HW.
  *
  * Note that the caller must stop the ADC sampling on its own, as this
  * function *never* stops it.
  *
  * Return:
  * Negative number for error;
  * Upon success returns zero and writes the read value to *out.
  */

...you can imagine the rest, or anyway I'm sending a v2 shortly :-)

>> +end:
>> +	/* Stop sampling unconditionally... */
>>   	regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
>>   
>> +	/* ...and deactivate the ADC GPIO if previously done */
>> +	if (desc->ext_sel_idx >= 0) {
>> +		ext_sel = FIELD_PREP(MT6363_EXT_PURES_MASK, MT6363_PULLUP_RES_OPEN);
>> +
>> +		regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
>> +				   MT6363_EXT_PURES_MASK, ext_sel);
>> +	}
>> +
>> +	/* Check if we reached this point because of an error or regular flow */
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Everything went fine, give back the ADC reading */
>>   	*out = val & GENMASK(chan->scan_type.realbits - 1, 0);
>>   	return 0;
>>   }
>> @@ -505,7 +674,7 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
>>   	int ret;
>>   
>>   	if (mask == IIO_CHAN_INFO_SCALE) {
>> -		*val = desc->r_ratio.numerator * AUXADC_VOLT_FULL;
>> +		*val = desc->r_ratio.numerator * (u32)cinfo->vref_mv;
> 
> As above.  If vref_mv was already a (u32) no need to cast here.

Changed!

Cheers,
Angelo




