Return-Path: <linux-iio+bounces-23688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A12B42587
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6703C1A868BD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A5272E71;
	Wed,  3 Sep 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDtLapsd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E40272810
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913295; cv=none; b=S0MNEvZWmK+oPZpj7pVGqveVoLR9uPideh/1LPdSpPw8tt+OYy7U4T1foHX20lwQygQUBb0JUIj5FvAc49r9qvuSpD902/aPeWZ/Z/eYS+grjGoVDXMitPjTeZmi4C3208uXuohDgE2fqK39zuVdn/Vuiy3ZLGDn8HLgsII5lGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913295; c=relaxed/simple;
	bh=KaFGZuOlr53tA5CLbYg/3cGDK7DZ4Kb9dmPKV4O181o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8mWfHZXhIDxxbENH7YMuq2cQCW7Fn5icxkImN9zMCd5PU1vebnaeQwBvfe2oX9XzDYRzmfNsyFBNYUVHdJ0zOhtAlOOPUOm2+cjGDA12VxyMxRNSnApotzcheNM0vMQwyxrnoYgw6hkouoxBE1hOLvGil3ZRATpLsPfsdCdIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDtLapsd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so546035e9.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Sep 2025 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756913292; x=1757518092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMOYVSoK5BkxYevwHV6Cyg4/hrGKJ/HxslO02CI64SA=;
        b=WDtLapsdHESCCZFanp1DDcawP2MZOvufYZZWrp8wRW0XZ1P0cN7rrkNau66B8FkRnV
         lDp1NJUvvo2u7nYIzrCmIao3gOK4ILon9nKy3/++jZCf4JDQgc9FqJWKb4LZPFprYteY
         CrMpkE4aCCHmsH1UoUnRTNNVd4G0/CbXVkHugtH/rbAxvTF37wgnavjo9re5VWRDFkFj
         7r+zvnW/jXxJifl/VHQxy5SaboHtLinlvKZwT9WNrk6PPzbKmm++2Yjw/ImoWU+NyT+f
         Pr0BbXKjDeCMcgkiTgVDXn9U3vEXZXZaJMm3VUnKqtbGKwK6CVs4JOF3K0mR/dLIMuED
         b+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756913292; x=1757518092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMOYVSoK5BkxYevwHV6Cyg4/hrGKJ/HxslO02CI64SA=;
        b=Zn+te9qEkL5wPsLDZEJA8wwl30oF8dstN45OEEBaBnjgRAbbej8msU/FOlTztB7ejJ
         FIZRlADQiZeCbr7d78vFVXPXgzeMWHEb7Cgw64ikn7+bRDaUkVVawSm06VEybEz2W3/V
         +P4Gkq7wzXTYtAC9892FcJYRHe3Mf6GH7f4VXkPgKsH4zCKZLXP23ew7HQ9Ly5hcZMG1
         l+0kJGPJODAIKK8QcVgAtOPfcTj5YLfgZ9sFAxHGPn4pT3BHpW/4kmduvnOU4ov2ckyI
         vsRcsAyZJPxLzPMvao0poitCQDyJddmXIF12t/Dn2LPf0bnvZJ6zOSPjJ/4IGbW0YG/j
         nNQw==
X-Forwarded-Encrypted: i=1; AJvYcCV6nVwzAMkxXBmF1Smt5iTkYkvAq8ZGhm+1ovdA+f+c37omgOlKCEtfZbOSXOrtR31GBHA71/EQTq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyphzb5mUW/sBvHgfW8cFk8Xcg/QCMO/RH1bc687kRgTCP9ydmh
	cW1FnMkM3l+HpUM+IB3rwoibScio6VvcIFBbgSQres6rDpLGaNpJvHRjARByarE4d1Y=
X-Gm-Gg: ASbGnctAo28vh9opsqiKHRGcdYAIirMyWrS7Pj3SyEy+rUoICy87Vm4SX4BDNS3ldRI
	xQu0HKEdNvo/l29JX3p35Q4b6vJKT4RX4zkRuwbzNewEPScOyUv1gYFbaUVMAEPoeB/FT2k2GBb
	craycCAw+KHdJcDXt5Rr6mYZhiHcrkepwfFG6WT/rSMo6WMNwSGaT6wWdQ129L6sVJTgtcQU/Vx
	lJshxRaO9y6vjcw1Y/hCTp+a6WTuGOXB2Et8kub5/Bz17zXAJHKlL+R19XnerkJ6SlmKi4ab2l1
	ARf9Y53wU4xNyOEe6Wsbl1Mhx1/eV4L9c22OGhjGhFRoqR6hRpA5euvLZx96UfPDMSCY75aJjCS
	KW0wz1QCq+K9aeEgXTGKSQq8ILxbjy14K/OvntUI64dkL7eZwKcuu4FxFj0kXcf8eQcdTnU5pps
	XAHlH5MT5Oz4JyNZIeGIsIz+Q=
X-Google-Smtp-Source: AGHT+IEuh6crD5+Cf4a9xDtCrUUELdcNnUdyzt4VPPB76Nxw/zsI9NCkM8/M+S5XzWuIb/KHOg3KzA==
X-Received: by 2002:a05:600c:470b:b0:45b:90fc:1ede with SMTP id 5b1f17b1804b1-45c8e725fbdmr34472765e9.6.1756913291411;
        Wed, 03 Sep 2025 08:28:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2a30:223c:d73b:565a? ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm24499827f8f.13.2025.09.03.08.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:28:10 -0700 (PDT)
Message-ID: <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
Date: Wed, 3 Sep 2025 17:28:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Andy,

thank you for the review


On 03/09/2025 13:48, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:
>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>
>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>> register (SAR) ADC. Two instances are available, each providing 8
>> multiplexed input channels with 12-bit resolution. The conversion rate
>> is up to 1 Msps depending on the configuration and sampling window.
>>
>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>> in both single-shot and continuous conversion modes, with optional
>> hardware triggering through the cross-trigger unit (CTU) or external
>> events. An internal prescaler allows adjusting the sampling clock,
>> while per-channel programmable sampling times provide fine-grained
>> trade-offs between accuracy and latency. Automatic calibration is
>> performed at probe time to minimize offset and gain errors.
>>
>> The driver is derived from the BSP implementation and has been partly
>> rewritten to comply with upstream requirements. For this reason, all
>> contributors are listed as co-developers, while the author refers to
>> the initial BSP driver file creator.
>>
>> All modes have been validated on the S32G274-RDB2 platform using an
>> externally generated square wave captured by the ADC. Tests covered
>> buffered streaming via IIO, trigger synchronization, and accuracy
>> verification against a precision laboratory signal source.
> 
> ...
> 
>> +#include <linux/circ_buf.h>
> 
> Why not kfifo?

Are you suggesting to use kfifo instead of the circular buffer in the code ?

>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
> 
> + match.h and more are missing...
> 
>> +#include <linux/module.h>
> 
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
> 
> Misuse of headers, and please make driver agnostic. There is none OF specifics
> in the code AFAICT.
> 
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
> 
> ...
> 
>> +/* Main Configuration Register */
>> +#define REG_ADC_MCR(__base)		(__base)
> 
> Useless macro. Perhaps (looking the others) this should be
> ((__base) + 0x00) which makes much more sense.

Sure

>> +#define REG_ADC_MCR_NRSMPL_32		BIT(11)
>> +#define REG_ADC_MCR_NRSMPL_128		BIT(12)
>> +#define REG_ADC_MCR_NRSMPL_512		(BIT(11) | BIT(12))
> 
> These are not bits, please use them in a form of 0, 1, 2, 3 and why not using
> bitfield.h?
>
> ...
> 
>> +#define NXP_SAR_ADC_CONV_TIMEOUT_MS	100
>> +#define NXP_SAR_ADC_CAL_TIMEOUT_US	100000
> 
> (100 * USEC_PER_MSEC)
> 
>> +#define NXP_SAR_ADC_WAIT_US		2000
> 
> (2 * USEC_PER_MSEC)

Why is this more understandable than the raw value ?

> 
>> +#define NXP_SAR_ADC_DMA_BUFF_SZ		(PAGE_SIZE * NXP_SAR_ADC_DMA_SAMPLE_SZ)
> 
> Oh, PAGE_SIZE is not good to use. I believe this HW is not tolerant to any page size.
> (Note, we made similar mistake in Intel IPU3 camera driver, which is now fixed)

Is it acceptable to put a hardcoded 4096 value ?

> ...
> 
>> +	/* Protect circular buffers access. */
>> +	spinlock_t lock;
> 
> + spinlock.h
> 
>> +	/*
>> +	 * Save and restore context
>> +	 */
>> +	u32 inpsamp;
>> +	u32 pwdn;
> 
> + types.h
> 
> ...
> 
>> +		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3U));
> 
> + delay.h
> 
> Actually + math64.h (no need to include math.h which I mentioned elsewhere).
> 
> ...
> 
>> +static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
>> +{
>> +	u32 msr, ret;
>> +
>> +	ret = read_poll_timeout(readl, msr, !(msr & REG_ADC_MSR_CALBUSY),
> 
> Why not readl_poll_timeout()?
> 
>> +				NXP_SAR_ADC_WAIT_US,
>> +				NXP_SAR_ADC_CAL_TIMEOUT_US,
>> +				true, REG_ADC_MSR(base));
>> +	if (ret)
>> +		return ret;
> 
>> +	if (!(msr & REG_ADC_MSR_CALFAIL))
>> +		return 0;
> 
> I would expect standard pattern — "errors first", but here either works.

Does it mean this chunk of code can be preserved or do you prefer an 
error block followed with a return 0 ?

>> +	/*
>> +	 * If the calibration fails, the status register bit must be
>> +	 * cleared
>> +	 */
>> +	msr &= ~REG_ADC_MSR_CALFAIL;
>> +
>> +	writel(msr, REG_ADC_MSR(base));
>> +
>> +	return -EAGAIN;
>> +}
> 
> ...
> 
>> +{
>> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
>> +	int i, ret;
> 
> Why is 'i' signed?
> 
>> +
>> +	for (i = 0; i < info->channels_used; i++) {
>> +		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
>> +		if (ret < 0) {
>> +			nxp_sar_adc_read_notify(info);
>> +			return;
>> +		}
>> +
>> +		info->buffer[i] = ret;
>> +	}
>> +
>> +	nxp_sar_adc_read_notify(info);
>> +	iio_push_to_buffers_with_timestamp(indio_dev,
>> +					   info->buffer,
>> +					   iio_get_time_ns(indio_dev));
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +}
> 
> ...
> 
>> +	/*
>> +	 * On disable, we have to wait for the transaction to finish.
>> +	 * ADC does not abort the transaction if a chain conversion
>> +	 * is in progress.
>> +	 * Wait for the worst case scenario - 80 ADC clk cycles.
>> +	 */
>> +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);
> 
> Could it possible go wrong and with low rate clocks (kHz:ish) this will go into
> lo-o-o-o-ng *atomic* delay?

It is the ADC clock where we need to wait for 80 cycles. The lowest 
clock rate is 40MHz, but on this platform it is 80MHz IIRC. This routine 
is called only when the capture finishes. Except I'm missing something, 
this scenario should not happen.

>> +}
> 
> ...
> 
>> +		nxp_sar_adc_channels_enable(info, 1 >> chan->channel);
> 
> 1 >> ?!? Did you want BIT(channel)? Or simply channel != 0?

Yeah, BIT(chan->channel) is better

>> +static void nxp_sar_adc_dma_cb(void *data)
>> +{
>> +	struct nxp_sar_adc *info = iio_priv((struct iio_dev *)data);
>> +	struct iio_dev *indio_dev = data;
>> +	struct dma_tx_state state;
>> +	struct circ_buf *dma_buf;
>> +	struct device *dev_dma;
>> +	unsigned long flags;
>> +	u32 *dma_samples;
>> +	s64 timestamp;
>> +	int idx, ret;
>> +
>> +	dma_buf = &info->dma_buf;
>> +	dma_samples = (u32 *)dma_buf->buf;
>> +	dev_dma = info->dma_chan->device->dev;
> 
>> +	spin_lock_irqsave(&info->lock, flags);
> 
> Why not guard()() from cleanup.h?

sure

>> +	dmaengine_tx_status(info->dma_chan,
>> +			    info->cookie, &state);
> 
> Perfectly one line. No return check?

Ok, will see if the IIO DMA API has an impact on this portion of code 
before checking the return code. However, the status is often ignored in 
the other drivers.

[ ... ]

>> +/*
>> + * The documentation describes the reset values for the
>> + * registers. However some registers do not have these values after a
>> + * reset. It is a not desirable situation. In some other SoC family
>> + * documentation NXP recommend to not assume the default values are
>> + * set and to initialize the registers conforming to the documentation
>> + * reset information to prevent this situation. Assume the same rule
>> + * applies here as there is a discrepancy between what is read from
>> + * the registers at reset time and the documentation.
>> + */
>> +static void nxp_sar_adc_set_default_values(struct nxp_sar_adc *info)
>> +{
>> +	const u32 mcr_default	= 0x00003901;
>> +	const u32 msr_default	= 0x00000001;
>> +	const u32 ctr_default	= 0x00000014;
>> +	const u32 cimr_default	= 0x00000000;
>> +	const u32 ncmr_default	= 0x00000000;
> 
> What is the purpose of having these constant to be temporary variables in the
> code?

The purpose is to group everything in a single function. As the default 
values are only used in this function, creating the macros where we have 
to roll up and down to check their values seemed to me pointless. But if 
you prefer macros, it is fine I can convert them.

>> +	writel(mcr_default, REG_ADC_MCR(info->regs));
>> +	writel(msr_default, REG_ADC_MSR(info->regs));
>> +	writel(ctr_default, REG_ADC_CTR0(info->regs));
>> +	writel(ctr_default, REG_ADC_CTR1(info->regs));
>> +	writel(cimr_default, REG_ADC_CIMR0(info->regs));
>> +	writel(cimr_default, REG_ADC_CIMR1(info->regs));
>> +	writel(ncmr_default, REG_ADC_NCMR0(info->regs));
>> +	writel(ncmr_default, REG_ADC_NCMR1(info->regs));
>> +}
> 
> ...
> 
>> +static int nxp_sar_adc_probe(struct platform_device *pdev)
>> +{
>> +	const struct nxp_sar_adc_data *data;
>> +	struct nxp_sar_adc *info;
>> +	struct iio_dev *indio_dev;
>> +	struct resource *mem;
>> +	struct device *dev = &pdev->dev;
>> +	int irq;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct nxp_sar_adc));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	info = iio_priv(indio_dev);
> 
>> +	data = of_device_get_match_data(dev);
> 
> We have an agnostic alternative in property.h.
> 
>> +	info->vref = data->vref;
> 
> vref_uV / vref_mV in both cases?

Good suggestion, it makes sense

>> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
>> +	if (IS_ERR(info->regs))
>> +		return dev_err_probe(dev, PTR_ERR(info->regs),
>> +				     "failed to get and remap resource");
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
> 
>> +		return dev_err_probe(dev, irq, "no irq resource\n");
> 
> No need, it prints message if fails.
> 
>> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
>> +			       dev_name(dev), indio_dev);
>> +	if (ret < 0)
>> +		dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
>> +
>> +	info->regs_phys = mem->start;
>> +	spin_lock_init(&info->lock);
>> +
>> +	info->clk = devm_clk_get_enabled(dev, "adc");
>> +	if (IS_ERR(info->clk))
>> +		return dev_err_probe(dev, PTR_ERR(info->clk),
>> +				     "failed to get the clock\n");
> 
>> +	platform_set_drvdata(pdev, indio_dev);
> 
>> +	init_completion(&info->completion);
>> +
>> +	indio_dev->name = dev_name(dev);
>> +	indio_dev->info = &nxp_sar_adc_iio_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>> +	indio_dev->channels = nxp_sar_adc_iio_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
>> +
>> +	nxp_sar_adc_set_default_values(info);
>> +
>> +	ret = nxp_sar_adc_calibration(info);
>> +	if (ret) {
>> +		dev_err(dev, "Calibration failed: %d\n", ret);
>> +		return ret;
> 
> Be consistent. It looks like driver is written by 2+ people who do not
> communicate with each other.

Indeed ... :)

>> +	}
>> +
>> +	ret = nxp_sar_adc_dma_probe(dev, info);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to initialize the dma\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> +					      &iio_pollfunc_store_time,
>> +					      &nxp_sar_adc_trigger_handler,
>> +					      &iio_triggered_buffer_setup_ops);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Couldn't initialise the buffer\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret) {
>> +		dev_err(dev, "Couldn't register the device.\n");
>> +		return ret;
>> +	}
> 
>> +	dev_info(dev, "Device initialized successfully.\n");
> 
> Noise. This should be dropped.

Ok, thanks again for the review

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

