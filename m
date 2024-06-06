Return-Path: <linux-iio+bounces-5938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C608FF579
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5A21F261D1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FA61FDE;
	Thu,  6 Jun 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcA8K3P2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270A3BBCC;
	Thu,  6 Jun 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703518; cv=none; b=ZN50oPyDnY2XrHxElKJELe8zx7lHdiA5Fn6pHpFfTdoI8++6koZtcc4Lo8C4grYWRRXDIPOCctapt/ZBSkp4C4YBe4PPJfRC+oSwp5wQQisms5PAB+MnEk5WxM+pDUqo7kTRT16wo1Z4jhUbxkg8rAh5bZCKIYNxUcsKrpJVto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703518; c=relaxed/simple;
	bh=xu7fReVhspIwEelggufDE+SZLmQX8KfOFqEzfQSKoe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt2ZSHrtK3UWDX3SR77Vfq3/2AjMgQiXFi+tDohvDfGVF3n1FZff4oi/dVkx2HlGK5wAmWHE85rr9OzdpvxTmMEfV3uCMHi5JAE8DXkVpAMRL8oRZ+UO5qDWENEp6RWE1/8Ha3PFqjbVck2LJG6smErh5DZsiM2I4frwhp4RXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcA8K3P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A0C2BD10;
	Thu,  6 Jun 2024 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703518;
	bh=xu7fReVhspIwEelggufDE+SZLmQX8KfOFqEzfQSKoe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mcA8K3P2CEi+5RDNdj5rw6yJz8XiJ4zr53ZYvYsT0Zd11cYZHzQqSSwnCLKiXmRGj
	 xM3vyTNMEEDNSu8koRC+rb82Qf2NtQrWRsGWYkQx1Retdd7Ocxxb6kpGlhxP//qSic
	 uM8w7k1MTKBD9dYRZVeZt9IC+5QegUC4hGZQ1MgySITw6Hj9aKfZY1Pm3gcvQcF3xd
	 q95JEBl0Q6C+vsMMuAnw4AqxtrlhdWbwMCyhyGHR469VXwWYN0078n0DBTY//emSwV
	 HWt4ZiF1Sx6QNAvm0K3eoWC6bB/EmUYP9JN1uCONqK1ce74akUAvaBJWkCuWRaIrDv
	 rysolIHK/7loQ==
Date: Thu, 6 Jun 2024 20:51:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
Message-ID: <20240606205146.4069d23b@jic23-huawei>
In-Reply-To: <60e55919-2a8c-4d83-89a1-6e4ae156d34d@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
	<20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
	<20240602111141.0058f39e@jic23-huawei>
	<60e55919-2a8c-4d83-89a1-6e4ae156d34d@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 11:42:05 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 02/06/24 12:11, Jonathan Cameron ha scritto:
> > On Thu, 30 May 2024 11:34:08 +0200
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> >   
> >> Add a driver to support reading the Auxiliary ADC IP found in the
> >> MediaTek MT6357, MT6358 and MT6359 Power Management ICs.
> >>
> >> This driver provides multiple ADC channels for system monitoring,
> >> such as battery voltage, PMIC temperature, PMIC-internal voltage
> >> regulators temperature, and others.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>  
> > 
> > I'll leave you to answer the 'why a new driver' in response to Andy's review
> > and just assume it makes sense whilst reviewing this.
> >   
> 
> Simply, the Auxiliary ADC IP in the MT635x PMIC series is different, and handled
> differently from the others that are supported by other drivers, other than having
> a different register layout.
> 
> Adding this to any other driver, such as mt6577_auxadc (a SoC - not PMIC - auxadc
> IP driver!), would be like having two different drivers in one and wouldn't make
> any sense :-)

That's fine. I missed the PMIC bit!

> 
> > What are IMP channels?
> >   
> 
> Honestly? Well, it's called like that. I don't have any clear description of that
> and not even datasheets are unrolling the meaning of "IMP". So.. I don't know.
> 
> What I know is what I wrote in the driver, and this is:
> * IMP has IBAT and VBAT ADCs
> * It needs different handling from the other ADCs, as shown.
> 
> ...and nothing else :-(

This is where kernel developers are rescued by sarcasm.

/* IMP - A small type of devil maybe? */
Let your creativity run wild ;)
Joking really. Just add a note to say that we have no idea what it means.

> 
> > A few additional comments inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >> index edb32ce2af02..da7d4452b1e0 100644
> >> --- a/drivers/iio/adc/Makefile
> >> +++ b/drivers/iio/adc/Makefile
> >> @@ -79,6 +79,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
> >>   obj-$(CONFIG_MCP3422) += mcp3422.o
> >>   obj-$(CONFIG_MCP3564) += mcp3564.o
> >>   obj-$(CONFIG_MCP3911) += mcp3911.o
> >> +obj-$(CONFIG_MEDIATEK_MT6359_AUXADC) += mt6359-auxadc.o
> >>   obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
> >>   obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
> >>   obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
> >> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> >> new file mode 100644
> >> index 000000000000..0481bd3f0144
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/mt6359-auxadc.c
> >> @@ -0,0 +1,598 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * MediaTek MT6359 PMIC AUXADC IIO driver
> >> + *
> >> + * Copyright (c) 2021 MediaTek Inc.
> >> + * Copyright (c) 2024 Collabora Ltd
> >> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> + */
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/mfd/mt6397/core.h>
> >> +
> >> +#include <dt-bindings/iio/adc/mediatek,mt6357-auxadc.h>
> >> +#include <dt-bindings/iio/adc/mediatek,mt6358-auxadc.h>
> >> +#include <dt-bindings/iio/adc/mediatek,mt6359-auxadc.h>  
> > 
> > So I 'guess' these headers are dt-bindings because you want
> > to consume them from other drivers?  That's fine, but if so please
> > add info on that to the DT binding patch.
> >   
> 
> ...consume from devicetrees. And the purpose of including those headers is to
> index the channels as per the bindings, of course.
> That was a *very* light explanation, but I really don't think that I have to
> expand at all...

That's fine. Stick it in the patch description for patch 1.
> 
> >> +/**
> >> + * struct mt6359_auxadc - Main driver structure
> >> + * @dev:           Device pointer
> >> + * @regmap:        Regmap from SoC PMIC Wrapper
> >> + * @pdata:         PMIC specific platform data
> >> + * @lock:          Mutex lock for AUXADC reads  
> > 
> > Expand on this mutex comment.  What is it protecting?
> > I think it's about ensuring they are serialized to ensure configuration
> > is not changed during the read sequence.
> >   
> 
> Yes, exactly that.
> 
> "Mutex to serialize AUXADC reading vs configuration"
> Looks good? :-)
Mutex is obvious - so perhaps.

Serialize multi access AUXADC reading against configuration changes.

> 
> >> + * @timed_out:     Signals whether the last read timed out
> >> + */
> >> +struct mt6359_auxadc {
> >> +	struct device *dev;
> >> +	struct regmap *regmap;
> >> +	const struct mtk_pmic_auxadc_pdata *pdata;
> >> +	struct mutex lock;
> >> +	bool timed_out;
> >> +};
> >> +  
> >   
> >> +/**
> >> + * struct mtk_pmic_auxadc_pdata - PMIC specific platform data  
> > 
> > I'm not sure this is conventionally what we think of as platform
> > data.  This is chip specific stuff. Platform data tends to be
> > more about how things are wired up etc.  A common term for this
> > stuff is chip_info.
> >   
> 
> Alright, I can do...
> 
> /**
>   * struct mtk_pmic_auxadc_info - PMIC specific chip info
> ......
> struct mtk_pmic_auxadc_info {
> 	members;
> }
> 
> 
> struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
> 
> "cinfo" because otherwise it's going to impact code readability later on
> 
> >> + * @channels:       IIO specification of ADC channels
> >> + * @num_channels:   Number of ADC channels
> >> + * @desc:           PMIC AUXADC channel data
> >> + * @regs:           List of PMIC specific registers
> >> + * @sec_unlock_key: Security unlock key for HK_TOP writes
> >> + * @imp_adc_num:    ADC channel for IMP readings
> >> + * @read_imp:       Callback to read PMIC IMP channels
> >> + */
> >> +struct mtk_pmic_auxadc_pdata {
> >> +	const struct iio_chan_spec *channels;
> >> +	int num_channels;
> >> +	const struct mtk_pmic_auxadc_chan *desc;
> >> +	const u16 *regs;
> >> +	u16 sec_unlock_key;
> >> +	u8 imp_adc_num;
> >> +	int (*read_imp)(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat);
> >> +};
> >> +  
> >   
> >> +
> >> +static const struct mtk_pmic_auxadc_chan mt6359_auxadc_ch_desc[] = {
> >> +	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 7, 2),
> >> +	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 5, 2),
> >> +	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, 8, 3, 2),
> >> +	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 5, 2),
> >> +	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, 8, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, 8, 1, 1),
> >> +	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, 8, 1, 1),
> >> +
> >> +	/* IMP channels */  
> > What are these? Expand IMP perhaps!
> >   
> 
> Yeah, well.. it's... "imp"... can't do anything about that, sorry. :-(

It's growing horns and it's definitely a red one...

> 
> >> +	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
> >> +	MTK_PMIC_ADC_CHAN(IBAT, 0, 0, 128, 7, 2),
> >> +};  
> > 
> >   
> >> +static int mt6359_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
> >> +{
> >> +	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
> >> +	struct regmap *regmap = adc_dev->regmap;
> >> +	int val_v, val_i, ret;
> >> +	u32 val;
> >> +
> >> +	/* Start conversion */
> >> +	regmap_write(regmap, pdata->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
> >> +	ret = regmap_read_poll_timeout(regmap, pdata->regs[PMIC_AUXADC_IMP1],
> >> +				       val, !!(val & MT6359_IMP1_IRQ_RDY),  
> > 
> > The condition is just as true or false without the !! so drop those.
> >   
> 
> Heh yes, I forgot to clean that up before sending, thanks for catching that!
> 
> >> +				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
> >> +
> >> +	/* Stop conversion regardless of the result */
> >> +	regmap_write(regmap, pdata->regs[PMIC_AUXADC_IMP0], 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* If it succeeded, wait for the registers to be populated */
> >> +	usleep_range(IMP_STOP_DELAY_US, IMP_STOP_DELAY_US + 50);
> >> +
> >> +	ret = regmap_read(regmap, pdata->regs[PMIC_AUXADC_IMP3], &val_v);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regmap_read(regmap, pdata->regs[PMIC_FGADC_R_CON0], &val_i);
> >> +	if (ret)
> >> +		return ret;  
> > 
> > Why read them both if only one is wanted?  Do you need to read the data
> > for some reason - i.e. to allow for fresh reads or clear some status bit
> > or similar?  If so add a comment.  Otherwise easy to do
> >   
> 
> Yeah, the state machine inside of the AUXADC IP starts the conversion, takes as
> many samples as you allow it to take, then stores an average of those in those
> registers that I'm reading here.
> 
> Reading the registers resets the state machine, so the next time you start it
> you won't start averaging current reads versus old ones...

Ah ok. Comment please on need to read to reset the register.
Everyone loves read to clear registers... *Sigh*

> 
> > 	if (vbat) {
> > 		int val_v;
> > 		ret = regmap_read(regmap, pdata->regs[PMIC_AUXADC_IMP3], &val_v);
> > 		if (ret)
> > 			return ret;
> > 		*vbat = val_v;
> > 	}
> > etc
> > 
> >   
> >> +
> >> +	*vbat = val_v;
> >> +	*ibat = val_i;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct mtk_pmic_auxadc_pdata mt6357_pdata = {
> >> +	.channels = mt6357_auxadc_channels,
> >> +	.num_channels = ARRAY_SIZE(mt6357_auxadc_channels),
> >> +	.desc = mt6357_auxadc_ch_desc,
> >> +	.regs = mt6357_auxadc_regs,
> >> +	.imp_adc_num = MT6357_IMP_ADC_NUM,
> >> +	.read_imp = mt6358_read_imp,
> >> +};
> >> +
> >> +static const struct mtk_pmic_auxadc_pdata mt6358_pdata = {
> >> +	.channels = mt6358_auxadc_channels,
> >> +	.num_channels = ARRAY_SIZE(mt6358_auxadc_channels),
> >> +	.desc = mt6358_auxadc_ch_desc,
> >> +	.regs = mt6358_auxadc_regs,
> >> +	.imp_adc_num = MT6358_IMP_ADC_NUM,
> >> +	.read_imp = mt6358_read_imp,
> >> +};
> >> +
> >> +static const struct mtk_pmic_auxadc_pdata mt6359_pdata = {
> >> +	.channels = mt6359_auxadc_channels,
> >> +	.num_channels = ARRAY_SIZE(mt6359_auxadc_channels),
> >> +	.desc = mt6359_auxadc_ch_desc,
> >> +	.regs = mt6359_auxadc_regs,
> >> +	.sec_unlock_key = 0x6359,
> >> +	.read_imp = mt6359_read_imp,
> >> +};
> >>  
> >   
> >> +
> >> +static int mt6359_auxadc_read_label(struct iio_dev *indio_dev,
> >> +				    const struct iio_chan_spec *chan, char *label)
> >> +{
> >> +	return sysfs_emit(label, "%s\n", chan->datasheet_name);
> >> +}
> >> +
> >> +static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
> >> +				  const struct iio_chan_spec *chan,
> >> +				  int *val, int *val2, long mask)
> >> +{
> >> +	struct mt6359_auxadc *adc_dev = iio_priv(indio_dev);
> >> +	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
> >> +	const struct mtk_pmic_auxadc_chan *desc = &pdata->desc[chan->scan_index];
> >> +	int ret;
> >> +
> >> +	if (mask == IIO_CHAN_INFO_SCALE) {
> >> +		*val = desc->r_numerator * AUXADC_VOLT_FULL;
> >> +
> >> +		if (desc->r_denominator > 1) {
> >> +			*val2 = desc->r_denominator;
> >> +			return IIO_VAL_FRACTIONAL;
> >> +		}
> >> +
> >> +		return IIO_VAL_INT;
> >> +	}
> >> +
> >> +	mutex_lock(&adc_dev->lock);
> >> +
> >> +	switch (chan->scan_index) {
> >> +	case PMIC_AUXADC_CHAN_IBAT:
> >> +		ret = adc_dev->pdata->read_imp(adc_dev, val2, val);  
> > 
> > This is very odd. Why reverse the parameters between the IBAT and VBAT
> > channels?  I suspect you want to throw away a parameter. That's fine but
> > don't use val2 for it. Either make that function handle NULL pointers
> > or add a local int temp or similar for this purpose.
> >   
> 
> I honestly prefer to have a simple variable swap instead of adding handling
> for NULL pointers, even though it's just a "if NULL don't use me".
> 
> But okay, I also understand why you don't want me to use val2 as a "waste bin"...
Indeed not!

> 
> I will add NULL pointer handling in the read_imp callback, as that's the shortest
> and lightest option that I have here.
> 
> 	case PMIC_AUXADC_CHAN_IBAT:
> 		ret = adc_dev->pdata->read_imp(adc_dev, NULL, val);
> 		break;
> 	case PMIC_AUXADC_CHAN_VBAT:
> 		ret = adc_dev->pdata->read_imp(adc_dev, val, NULL);

that works, or just use a locally defined variable to dump the value you don't
want in if  you prefer.  int garbage; or similar.

> 		break;
> 
> read_imp
> {
> 	....
> 
> 	if (vbat)
> 		*vbat = val_v;
> 	if (ibat)
> 		*ibat = val_i;
> 
> 	return 0;
> }
> 
> >> +		break;
> >> +	case PMIC_AUXADC_CHAN_VBAT:
> >> +		ret = adc_dev->pdata->read_imp(adc_dev, val, val2);
> >> +		break;
> >> +	default:
> >> +		ret = mt6359_auxadc_read_adc(adc_dev, chan, val);
> >> +		break;
> >> +	}
> >> +
> >> +	mutex_unlock(&adc_dev->lock);
> >> +
> >> +	if (ret) {
> >> +		/*
> >> +		 * If we get more than one timeout, it's possible that the
> >> +		 * AUXADC is stuck: perform a full reset to recover it.
> >> +		 */
> >> +		if (ret == -ETIMEDOUT) {
> >> +			if (adc_dev->timed_out) {
> >> +				dev_warn(adc_dev->dev, "Resetting stuck ADC!\r\n");
> >> +				mt6359_auxadc_reset(adc_dev);
> >> +			}
> >> +			adc_dev->timed_out = true;
> >> +		}
> >> +		return ret;
> >> +	}
> >> +	adc_dev->timed_out = false;
> >> +
> >> +	return IIO_VAL_INT;
> >> +}
> >> +
> >> +static const struct iio_info mt6359_auxadc_info = {
> >> +	.read_label = mt6359_auxadc_read_label,
> >> +	.read_raw = mt6359_auxadc_read_raw,
> >> +};
> >> +
> >> +static int mt6359_auxadc_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *mt6397_mfd_dev = pdev->dev.parent;
> >> +	struct mt6359_auxadc *adc_dev;
> >> +	struct iio_dev *indio_dev;
> >> +	struct regmap *regmap;
> >> +	int ret;
> >> +
> >> +	/* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
> >> +	regmap = dev_get_regmap(mt6397_mfd_dev->parent, NULL);
> >> +	if (!regmap)
> >> +		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get regmap\n");
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	adc_dev = iio_priv(indio_dev);
> >> +	adc_dev->regmap = regmap;
> >> +	adc_dev->dev = &pdev->dev;
> >> +
> >> +	adc_dev->pdata = device_get_match_data(&pdev->dev);
> >> +	if (!adc_dev->pdata)
> >> +		return -EINVAL;
> >> +
> >> +	mutex_init(&adc_dev->lock);
> >> +
> >> +	mt6359_auxadc_reset(adc_dev);
> >> +
> >> +	indio_dev->dev.parent = &pdev->dev;  
> > No need to set that, the IIO core does it for you in
> > devm_iio_device_alloc()  
> 
> Ah, cool, thank you!
> 
> >> +	indio_dev->name = dev_name(&pdev->dev);  
> > 
> > This tends to be fragile at best.  The name should be the part number, best
> > way to reliably get that is either to query a whoami type register if there
> > is one or put it in your pdata.
> >   
> 
> Okay. I don't want to deal with unknown revision IDs and such, as the auxadc
> IP is always the same between all of them and I don't have a clear list of
> numbers here, so I'll just throw in the MT6357 MT6358 MT6359 names in the
> chip_info and call it a day :-)

ok. I think.  Note we should allow for the mess of fallback compatibles with
at most an info print if we can tell something is different from expected.
Not sure that is relevant here though.
> 
> Thanks for the review btw!
np

Jonathan

> 
> Cheers,
> Angelo
> 
> 


