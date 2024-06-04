Return-Path: <linux-iio+bounces-5742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3DA8FAFF1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD592816BD
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA21448F1;
	Tue,  4 Jun 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ajzzr07W"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96C38B;
	Tue,  4 Jun 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497490; cv=none; b=lvI//GQ/c0GUc3O3JRt71ZTBxfoq3/befymTGp0k1RRqiOg0fhEpP9WibpXSGFKruV4rG1laMOCFzbLGy1lsGdD56CR2nDvZDbaFxTq7XNzNqjB7hGGS/i1U0TJDTs+o9MjjLCgu2gqy6MUbIDQxj7MRw74C+WlVI7Ro5MN6JSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497490; c=relaxed/simple;
	bh=83qgTD6GQKD17zryJJer2RaJbdNVFmS+NMwIUzNFP2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPEPGzohB/QDAlY4Ykknf1FzUMDCHnASRJT2jsC6LCd3V0R5Wm3h2qQrIR+fl0p7cuuVK/QZJl8iQmrM/3kAcZ2fCZpYaGm8l2pemZxQNn1DUSJ2+7rBMWtLU1ICT0ktqRIvE8AfevykpNU4Qe8NG0C/Q+YeSMaC37OL/0QJ1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ajzzr07W; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717497486;
	bh=83qgTD6GQKD17zryJJer2RaJbdNVFmS+NMwIUzNFP2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ajzzr07WHRA3SgHRuBDCGrgT90Benyyh2fvI3m5ZL1ML0Ytj8ma90RiDPSTJtxBGC
	 z614fqAVpWsLRylzPGu0BKDiOJ8IVxxF94KDPE7b16HP8VBJzeZq6oWf4NBpZdxDck
	 BHCnZjYTl5RSR8HgSSqpmLUlJtTlzUDi5532SvlyJpT7lcdNUaZfZUtF7jyqD58O4P
	 U5DgXMKmsMvhTvoGiOBz3jQ1RuWK+AwEz/1jguOV+f+Qrxh1oFSan5MXKdu0qEAUZh
	 99huVFDrNcTGrfvlY8YVotC/qdBtYL5lGMUukd6jdOQxkv5ruYz8yJYtYsmT5NmGv5
	 BRHqt/Cc1vAMA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C690937821DC;
	Tue,  4 Jun 2024 10:38:04 +0000 (UTC)
Message-ID: <84f1c58c-0a5d-4131-a16b-b76bf28862ee@collabora.com>
Date: Tue, 4 Jun 2024 12:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
 <CAHp75Vexddt1xUGogRDZA9pM1pFp2=ZtCQnCfXePahSCb+oKpg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vexddt1xUGogRDZA9pM1pFp2=ZtCQnCfXePahSCb+oKpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/05/24 15:34, Andy Shevchenko ha scritto:
> On Thu, May 30, 2024 at 12:34 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add a driver to support reading the Auxiliary ADC IP found in the
>> MediaTek MT6357, MT6358 and MT6359 Power Management ICs.
>>
>> This driver provides multiple ADC channels for system monitoring,
>> such as battery voltage, PMIC temperature, PMIC-internal voltage
>> regulators temperature, and others.
> 
>> ---
> 
> Here is no explanation on how this is differ to any of the three
> existing drivers? I.o.w. why do we need a brand new one?
> 

Not a SoC AUXADC but a PMIC AUXADC, different register layout and different
handling for configuration, reset, and reading.

So okay I'm adding a nicer text of what I just wrote to the commit description.

> ...
> 
> + bits.h
> 
>> +#include <linux/delay.h>
> 
>> +#include <linux/kernel.h>
> 
> Why?
> 

Because I forgot to cleanup the headers :-\

> + mod_devicetable.h
>> +#include <linux/module.h>
> 
>> +#include <linux/of.h>
> 
> Why?
> 

Same reason :')

...And yes that should be linux/property.h instead, for device_get_match_data().

>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
> 
> + types.h
> 
> + blank line
> 
>> +#include <linux/iio/iio.h>
> 
> + Blank line
> 
>> +#include <linux/mfd/mt6397/core.h>
> 
> ...
> 
>> +#define PMIC_RG_RESET_VAL              (BIT(0) | BIT(3))
> 
> In this form it requires a comment explaining each mentioned bit.
> 

I don't have an explanation for this, I know it's two different bits from some
reveng, but the downstream driver declares that simply as 0x9.

Should I just "mask" this as 0x9 instead?

>> +#define PMIC_AUXADC_ADCx(x)            ((x) << 1)
> 
> Seems like a useless macro, it occupies much more space than in-place shift.
> 

Well that was done to enhance human readability, but okay I will just use an
in-place shift.

> ...
> 
>> +#define MT6358_IMP0_CLEAR              (BIT(14) | BIT(7))
> 
> As per above.
> 

Same, I don't have any explanation for that.

If you prefer, I can define this as 0x4080, but honestly I prefer keeping
it as-is since I am sure it's not a magic number but really two bits to flip
in a register.

> ...
> 
>> +/**
>> + * struct mtk_pmic_auxadc_chan - PMIC AUXADC channel data
>> + * @req_idx:       Request register number
>> + * @req_mask:      Bitmask to activate a channel
>> + * @num_samples:   Number of AUXADC samples for averaging
>> + * @r_numerator:   Resistance ratio numerator
>> + * @r_denominator: Resistance ratio denominator
>> + */
>> +struct mtk_pmic_auxadc_chan {
>> +       u8 req_idx;
>> +       u16 req_mask;
>> +       u16 num_samples;
> 
>> +       u8 r_numerator;
>> +       u8 r_denominator;
> 
> Can you add struct u8_fract to the math.h and use it? I will Ack/R the
> respective patch.
> 

Yeah, I did that exactly because u8_fract wasn't there and I didn't want
to waste more bits, but since you just asked for it... well, I'm happier :-)

>> +};
> 
> ...
> 
>> +struct mtk_pmic_auxadc_pdata {
>> +       const struct iio_chan_spec *channels;
>> +       int num_channels;
> 
> Why signed?
> 

Yeah, that doesn't make any sense, that's going to be u8.

>> +       const struct mtk_pmic_auxadc_chan *desc;
>> +       const u16 *regs;
>> +       u16 sec_unlock_key;
>> +       u8 imp_adc_num;
>> +       int (*read_imp)(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat);
>> +};
> 
> ...
> 
>> +static const u16 mt6357_auxadc_regs[] = {
>> +       [PMIC_HK_TOP_RST_CON0]  = 0xf90,
> 
> Can we use the fixed-width values so all of them will look nice and
> easy to parse?
> 

We obviously can, let's do that.

>> +       [PMIC_AUXADC_DCM_CON]   = 0x122e,
>> +       [PMIC_AUXADC_ADC0]      = 0x1088,
>> +       [PMIC_AUXADC_IMP0]      = 0x119c,
>> +       [PMIC_AUXADC_IMP1]      = 0x119e,
>> +       [PMIC_AUXADC_RQST0]     = 0x110e,
>> +       [PMIC_AUXADC_RQST1]     = 0x1114,
>> +};
> 
> ...
> 
>> +static const u16 mt6358_auxadc_regs[] = {
> 
> Ditto.
> 
>> +       [PMIC_HK_TOP_RST_CON0]  = 0xf90,
>> +       [PMIC_AUXADC_DCM_CON]   = 0x1260,
>> +       [PMIC_AUXADC_ADC0]      = 0x1088,
>> +       [PMIC_AUXADC_IMP0]      = 0x1208,
>> +       [PMIC_AUXADC_IMP1]      = 0x120a,
>> +       [PMIC_AUXADC_RQST0]     = 0x1108,
>> +       [PMIC_AUXADC_RQST1]     = 0x110a,
>> +};
> 
> ...
> 
>> +static const u16 mt6359_auxadc_regs[] = {
> 
> Ditto.
> 
>> +       [PMIC_FGADC_R_CON0]     = 0xd88,
>> +       [PMIC_HK_TOP_WKEY]      = 0xfb4,
>> +       [PMIC_HK_TOP_RST_CON0]  = 0xf90,
>> +       [PMIC_AUXADC_RQST0]     = 0x1108,
>> +       [PMIC_AUXADC_RQST1]     = 0x110a,
>> +       [PMIC_AUXADC_ADC0]      = 0x1088,
>> +       [PMIC_AUXADC_IMP0]      = 0x1208,
>> +       [PMIC_AUXADC_IMP1]      = 0x120a,
>> +       [PMIC_AUXADC_IMP3]      = 0x120e,
>> +};
> 
> ...
> 
>> +       ret = regmap_read_poll_timeout(adc_dev->regmap, pdata->regs[PMIC_AUXADC_IMP0],
>> +                                      val, !!(val & MT6358_IMP0_IRQ_RDY),
>> +                                      IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
>> +       if (ret) {
>> +               mt6358_stop_imp_conv(adc_dev);
> 
>> +               return ret;
>> +       }
>> +
>> +       return 0;
> 
>    if (ret)
>      foo()
> 
>    return ret;
> 
> 
> ...
> 
>> +       int val_v, ret;
> 
> Why is val_v signed?
> 
> ...
> 
>> +       int val_v, val_i, ret;
> 
> Ditto for all val_*.
> 

Yup, changed to u32.

> ...
> 
>> +       /* If it succeeded, wait for the registers to be populated */
>> +       usleep_range(IMP_STOP_DELAY_US, IMP_STOP_DELAY_US + 50);
> 
> fsleep() ?
> 

Okay

> ...
> 
>> +       /* Assert ADC reset */
>> +       regmap_set_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMIC_RG_RESET_VAL);
> 
> No required delay in between?
> 

No, as strange as it may look, there is no delay required in between: this is
because the register R/W is behind the PMIC Wrapper as much as all of the other
MediaTek PMIC (sub)devices, so, missing delays was intentional here, yes.

>> +       /* De-assert ADC reset */
>> +       regmap_clear_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMIC_RG_RESET_VAL);
> 
> ...
> 
>> +       /* Wait until all samples are averaged */
>> +       usleep_range(desc->num_samples * AUXADC_AVG_TIME_US,
>> +                    (desc->num_samples + 1) * AUXADC_AVG_TIME_US);
> 
> fsleep()
> 
> ...
> 
>> +       ret = regmap_read_poll_timeout(regmap,
>> +                                      (pdata->regs[PMIC_AUXADC_ADC0] +
>> +                                       PMIC_AUXADC_ADCx(chan->address)),
> 
> Drop unneeded parentheses and possibly make it one line.
> 
>> +                                      val, (val & PMIC_AUXADC_RDY_BIT),
> 
> Unneeded parentheses.
> 

Yeah, forgot those there during cleanup, whoops!

>> +                                      AUXADC_POLL_DELAY_US, AUXADC_TIMEOUT_US);
>> +       if (ret)
>> +               return ret;
> 
> ...
> 
>> +       mutex_lock(&adc_dev->lock);
> 
> Why not use cleanup.h?
> 

I want to unlock the mutex immediately right after executing read_imp() or
mt6359_auxadc_read_adc(), and I don't want the reset to be done while a mutex
is being held, as that makes no sense for this driver.

Besides, I find the macros in cleanup.h to be cryptic - in my opinion, they
require better documentation as, for example, I don't understand when the
guard(mutex)(my_mutex) is supposed to acquire the lock and when it's supposed
to release it.


> ...
> 
>> +static int mt6359_auxadc_probe(struct platform_device *pdev)
>> +{
> 
>    struct device *dev = &pdev->dev;

Yeah without that it simply looked more "beautiful" to read, but okay, added.

> 
>> +       struct device *mt6397_mfd_dev = pdev->dev.parent;
> 
>    ... = dev->parent;
> 
>> +       struct mt6359_auxadc *adc_dev;
>> +       struct iio_dev *indio_dev;
>> +       struct regmap *regmap;
>> +       int ret;
>> +
>> +       /* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
>> +       regmap = dev_get_regmap(mt6397_mfd_dev->parent, NULL);
>> +       if (!regmap)
>> +               return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get regmap\n");
>> +
>> +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
>> +       if (!indio_dev)
>> +               return -ENOMEM;
>> +
>> +       adc_dev = iio_priv(indio_dev);
>> +       adc_dev->regmap = regmap;
>> +       adc_dev->dev = &pdev->dev;
>> +
>> +       adc_dev->pdata = device_get_match_data(&pdev->dev);
>> +       if (!adc_dev->pdata)
>> +               return -EINVAL;
>> +
>> +       mutex_init(&adc_dev->lock);
>> +
>> +       mt6359_auxadc_reset(adc_dev);
>> +
>> +       indio_dev->dev.parent = &pdev->dev;
>> +       indio_dev->name = dev_name(&pdev->dev);
>> +       indio_dev->info = &mt6359_auxadc_info;
>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>> +       indio_dev->channels = adc_dev->pdata->channels;
>> +       indio_dev->num_channels = adc_dev->pdata->num_channels;
>> +
>> +       ret = devm_iio_device_register(&pdev->dev, indio_dev);
>> +       if (ret < 0)
> 
> Why  ' < 0' ?
> 

Uuuuuh.. well... I have no idea why this "< 0" is in there, I must have gremlins
living inside my keyboard, secretly inserting those checks when I'm not looking.

Must definitely be that.

Jokes apart, thanks for the review!
...a v2 will come asap, along with the math.h change :-)

Cheers!
Angelo



