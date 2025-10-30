Return-Path: <linux-iio+bounces-25655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D5C1EFAB
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C351F3A6FF2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847433859A;
	Thu, 30 Oct 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTVQqxHd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B333436F
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812847; cv=none; b=Dt0powMWA0s4ZIZ0ek4IQ1drIXiUv8dkEH7jQMli1hG3lpoIMwjh1NvnzKcu3R0veDTDzXB8phEWkSKoZbnR6oBixvkm7j2P69+6c60khYnknfxIagRlOwSFwBj4XJI4ZEGgZL14xfOnBLasHnvBSSz9plTe0qAL+nQsLI4u5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812847; c=relaxed/simple;
	bh=UDQb1+mEWC8Kf1gDMEyhFiMaB5sUmGPqCh+7teEp0uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuWpEza8CwPeLmtVwzx/Rn60VBE+RoTAqvSNAu+NexyMLKXc/C/c3v4C3VmLDV5YTgSENmqtWr6mfGNosnGVI1cgconUXKHEueizRNo4rT3JVS+gT5or/9HPVx56FAaY13aDNpJUR1mqYBYa2qU04iUDs29A62Io+sxNui9sk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTVQqxHd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dae5d473so5844905e9.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812843; x=1762417643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Cx0kxFaBCbR91JhvRx0ITZZstWHSbBwKql2sLDgf/c=;
        b=eTVQqxHdvR8f6FZR3vhYwHzTaOI+Iqd0AidYzy/cQ6Ctqe1GOfwMfzLV1dD+hBdKMe
         /UwURHlukUYdg5P/svRVgpEQTFajBSlJeqOa6oDt7V3Rp77Eh3olF+4NwKLVzcquCynp
         XaQYXnsOCrUYemZFQgZibun5vI0IDiZFcj4tCZC7KEf5oKhtWBvAo4LOxvr2xWcL9Q1p
         dl+Fo+Ve+5YPDy5wFmAC1s8TbRwPp94YOg/UxAg2iKlD0tGc2tyG0HN/3gl6URGWgLNv
         flCPO5ph9AKOsTfvsM65h8mcTnD37+HXivzXWB+mZ+TjwRiBA3drP9vPnEwGev3EmW8N
         /qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812843; x=1762417643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cx0kxFaBCbR91JhvRx0ITZZstWHSbBwKql2sLDgf/c=;
        b=DNLJtVLg4jk4X6ByZiAnQDrDYnEe9ld0PAx3+AviIg96xmlsl+pbLB5f2aItT2aShv
         RvSbdjiAMTdRG/k8GPJxLtpHgtg1M+SXA+rFAwP4CO2C0WHuSJq2IbxqWFoN4yapeSWC
         L6dYxLoSCNq8mwl5R7535W83ng/LgIflNHl0VVTg4vdWRhLPG47gNxotEAK1oHUMXUyw
         oZytUYiqPkjIeQsoL0X6QYKtWTMEIrIO76oAGfr3QpYRhtPRK+Em5lIcGNnrUL83LJml
         gqibJrL50G01ciCPM5E/GobjfejzZMELfSyCCrSYnlH4+rbJFONtbyQShsPf9Fgjvllo
         i/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQCmtmnrHt9jWkLmaI3XNVv6xJJ2LnNQrqXt0k64oV4cb++gWlXpge5a1W8tZN8XdbOUd2wf3O8vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDHFrm1fCYRnGe0LZY2o8FVJFAmitBzGm7ccN7FaIhcl03Yn8
	AqqOK9rITdEsC/FWU9nwcuwzbHni1OViPFQShKsyljBwBcnGC8rcyQ30/921kPXdz6o=
X-Gm-Gg: ASbGncu/UdfYRAPBFoZBGjUnL+Mb2qkVyFBdp2oER44lGvNp59W7iG20ARITeUFS3B8
	L7Ti99ejeVYdXkETVdreQlW4LWwaqJb3DnO9wTYriuYDi6sZdlzL3vrGpVDyz5jpDeH1vcQVeId
	XKhsRgOL91rzeaNz2d5JAMOv3LYS7HotJXKpn81RBLjw/JyDhgX2Htv/KMnZ2LCoQyMnWsJTeAu
	irwZSassmxje1OCLE1FR3jHqYppOGnw6zvC+rIRhHvHmBAzhVo9j09bU3a6lQPBFNaKhnca/jOu
	Q+FmooEVISs/iHEWFLSeXwTlVd0w0L21tN1BSH3sfWMrXcIgce+72HnkOVC9DkJh47/xNm6YIJr
	s3IFKROy/p6a/R2WwuapydbC9ei8LoYNi6rFTYsCZWiuvB9WokI1BYSQZT1LQkSlmG8Ww3i31F3
	NFJMaZho5IDVMynw5qN4Mi/dXoC4X4cbhKC1P2jLwsmpI5CpSKe+N7YGA=
X-Google-Smtp-Source: AGHT+IEpOqqQd6suUlzGZQizli8cmv6trmiqjxQtOiZEhtbP++rOooGf2lSVBQRYJvEyQY/YzRO1Ig==
X-Received: by 2002:a05:600c:4e52:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47726009fe6mr20555685e9.21.1761812843457;
        Thu, 30 Oct 2025 01:27:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7e89:8fed:3647:15c8? ([2a05:6e02:1041:c10:7e89:8fed:3647:15c8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289e7fd2sm28493615e9.16.2025.10.30.01.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:27:22 -0700 (PDT)
Message-ID: <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
Date: Thu, 30 Oct 2025 09:27:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aPP0uVZu1T7tTQGo@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Andy,

On 10/18/25 22:12, Andy Shevchenko wrote:
> On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:
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

I'm sorry but I don't get your comment.

Do you mean why not use kfifo.h or use kfifo API and change all the code 
using the circ_buf by the kfifo ?
> ...
> 
>> +#define NXP_SAR_ADC_IIO_BUFF_SZ		(NXP_SAR_ADC_NR_CHANNELS + (sizeof(u64) / sizeof(u16)))
> 
> Hmm... Don't we have some macros so we can avoid this kind of hard coding?

I don't find such a macro, do you have a pointer ?

> ...
> 
>> +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);
> 
> Do you need those 'U':s? clk_get_rate() already returns unsigned value of the
> same or higher rank than int. No?

May be not needed, but harmless. I can remove them if you want

>> +static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
>> +{
>> +	u32 mcr;
>> +
>> +	mcr = readl(NXP_SAR_ADC_MCR(info->regs));
>> +
>> +	FIELD_MODIFY(NXP_SAR_ADC_MCR_NSTART, &mcr, 0x1);
>> +	FIELD_MODIFY(NXP_SAR_ADC_MCR_MODE, &mcr, !raw);
> 
> !raw, which is boolean, as a parameter to FIELD_MODIFY() seems a bit odd to me,
> perhaps simple
> 
> 	raw ? 0 : 1
> 
> would work better?

Sure
> (Note, optimizer of the complier will avoid any branching)
> 
>> +	writel(mcr, NXP_SAR_ADC_MCR(info->regs));
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +	dma_samples = (u32 *)dma_buf->buf;
> 
> Is it aligned properly for this type of casting?

TBH, I don't know the answer :/

How can I check that ?

>> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> 
> No return value check?

The return value is not necessary here because the caller of the 
callback will check with dma_submit_error() in case of error which 
covers the DMA_ERROR case and the other cases are not useful because the 
residue is taken into account right after.

It could be written differently with the DMA_COMPLETE check but the 
result will be the same. I prefer to keep the current implementation 
which has been tested.

>> +static const struct nxp_sar_adc_data s32g2_sar_adc_data = {
>> +	.vref_mV = 1800,
>> +	.model = "s32g2-sar-adc"
> 
> Keep a trailing comma as here it's not a termination member.
Ok, I'll add it

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

