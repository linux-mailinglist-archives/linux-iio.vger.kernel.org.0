Return-Path: <linux-iio+bounces-17618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20205A7C15F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4736177A7D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467D20A5E1;
	Fri,  4 Apr 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YIQ2ACEn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91D20A5E4
	for <linux-iio@vger.kernel.org>; Fri,  4 Apr 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783327; cv=none; b=UKvdvTiFLJ1WXmHndkfASBk/zez0uoE7w2KDpIDqRcdrFe23XS1jJkc3X24jH1KDnPRpin+Djb+DyZhQw1J8NnI2eqd3HQwkBamnCeK+ZbT0/BS1UrlmmpjV7IwOSRWxdpNVUJQYb9rR4DCxOzkwge+8R1wg5LOVKuWunABI0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783327; c=relaxed/simple;
	bh=no3QAYqdItguKs3ATDS0SdIbnO/7BXoObTeJnj2tz6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWaSKADtCU+7M6qIj/k72+fUhKknwJ0yKcgc2Yar3SOHVL/+1Q/lfJGT/ehdkLx/hp7hEE7ptKpP3Fkz0J0NynjRVabmJnHx4W04jxmQNICoINUSNuUYGroSV3iGhoy0kcDtrJXyfN/vppH+6mpK0F5uH8xOgDspt3ftxjvsDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YIQ2ACEn; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-601c469cce3so560987eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Apr 2025 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743783322; x=1744388122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2j3x93HYeHwY5tSNUGE91ADq/ThMEsShqde0z89gCY=;
        b=YIQ2ACEninaJ1/vaFLNAn+lUMFr/zyToNRn0usnmmLBFFNsDdePlzk/5X5IPBWg+/h
         f18bL7Axno8fcqCpvOHk+b/DNlizjab2PSyK5iOeuLdI/QZhemnyeFljivl3ZIgoK8Or
         auyrEAiiJp6QqKMA0oCoDWFolUL08SSifMz/pyUHuvMWtw3OKMs2sohtXCk1uPUkq36x
         99IryBrAy54y7cgYts/lOzgA5HSuBx1ys4FakUR2oK51Y5oE1k7OwnsjD4i3BPab6X0J
         W1Tg+521gsmyqzHYA41dwk9kpSsJpnrR2cepcJTtXit99bdOU4ENk1tSkkuGGOJe/0/h
         uCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743783322; x=1744388122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2j3x93HYeHwY5tSNUGE91ADq/ThMEsShqde0z89gCY=;
        b=Mf9SDql6pZ7XKqKB+jkwthWU1E8O7EL9zOwrSUrQxGo4sJxK16DGAC7OrzeMkX4RMj
         TUepJaxYFxCZtzJVnzDXlA0ApVc+C1Z6xHwwMtToFWu+JxDsRw6FyJwyDaXG4WF7pnlz
         0zJEwBM/NOTWgnJuvldaylJKRpmJUlUFPJ7gBUWLWgkwZ3BhTUSO5+QbQRVzorGaKgfd
         jnPjt6ucowQpPAGzBRNb3oqPp26b4C0lbSW3KdP6gXZNfw3vVZGlE5of+nTux2zes649
         6/S0Q8D5c33cVF/QJlBasubwokOXZW+Eqk7oQh0PlOaRE8+ACrsCnZ/IolZ2z7t8X9N7
         uMEA==
X-Forwarded-Encrypted: i=1; AJvYcCW5REkykR1iUHUkt8RLZ6BuhQhbRccwEeGIgI+EExy1lTDBCGN3C3owezz3hrx202CzfNDpVgY47Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRH6/jFQRLJJ5DFS5J7evxbKWDuhH57xoOMVaVQqesGKGkyy6
	9nf38PPjavGaWpf4B/28/9Pq61xcRXI1wkGaHXyUpb8TjXUASzAwJi/UBF4xw+U=
X-Gm-Gg: ASbGncviEkVWwAIds833nwbn/yvn12g2SODxRut5JLabrirsIOCdLQI8Vg/3dDV+Icq
	tMxYlr0JVa8S/hOeQ4yWZ1p70lgZpJSZc9qoJZjIebNdEsQLzdHQe6h+ZFH2S86p7rlEzAH0n83
	qIBxymhC8Ad0rBNAMN0BPo6mT3J5N1begfB4VER82t1uDnadjG7LY3jHKcUHq7FNvMirLg672VR
	IYW4GkupYZR98+M0/2LVETJ5omdYVlbOFzT5FyMlaIIxpIiXbkQ5xtGsPGQ/j1+DMSvExfjwzXq
	ghZtEuEzFy0ad99UEs/tntylIGqqkt16jNqqSc2CoEjgeoZC3osv2WZoGa6XcTmFaUu9sLBVk8l
	leLOmCw==
X-Google-Smtp-Source: AGHT+IGeD0DN5s5NpX38+vrcEe8pmX0dglCUeK/9Wn3VmmDArglW7QUf9t5hzJw6MmeVoRIoUy9CaA==
X-Received: by 2002:a05:6808:2444:b0:3f8:30c1:cca7 with SMTP id 5614622812f47-4004557f18fmr2465378b6e.8.1743783322149;
        Fri, 04 Apr 2025 09:15:22 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4003ff9be6dsm662896b6e.25.2025.04.04.09.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:15:20 -0700 (PDT)
Message-ID: <25b34e60-5392-4bfb-b994-49212dfbdb22@baylibre.com>
Date: Fri, 4 Apr 2025 11:15:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: stm32: add oversampling support
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250403162358.1257370-1-olivier.moysan@foss.st.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250403162358.1257370-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 11:23 AM, Olivier Moysan wrote:
> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
> 
> The current support of the oversampling feature aims at increasing
> the data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution,
> a right shift is applied to keep initial resolution.

Why do we not want the extra bits too? I guess if we wanted the extra bits
in the future we could make the in_voltage_scale attribute writable to
select the resolution.

> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2exp(n) ratio <=> n right shift)
> 
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
> 
> Oversampling can be configured using IIO ABI:
> - in_voltage_oversampling_ratio_available
> - in_voltage_oversampling_ratio

This would require info_mask_shared_by_type but the patch uses
info_mask_shared_by_all, so the attributes will be:

- oversampling_ratio
- oversampling_ratio_available

I guess currently it doesn't matter which one gets used if there are only
voltage channels, but it could make a difference, e.g. if a temperature
channel was ever added.

In any case, the description should match what is actually implemented.

> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> ---
> Changes in v2:
> - Remove useless header files
> - Use FIELD_PREP macro
> - Reorder stm32_adc_write_raw() function

Link to v1? (for the lazy reviewer :-p)

> ---
>  drivers/iio/adc/stm32-adc-core.h |  14 ++++
>  drivers/iio/adc/stm32-adc.c      | 137 +++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 73b2c2e91c08..bfd42c5456bf 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -91,6 +91,7 @@
>  #define STM32H7_ADC_IER			0x04
>  #define STM32H7_ADC_CR			0x08
>  #define STM32H7_ADC_CFGR		0x0C
> +#define STM32H7_ADC_CFGR2		0x10
>  #define STM32H7_ADC_SMPR1		0x14
>  #define STM32H7_ADC_SMPR2		0x18
>  #define STM32H7_ADC_PCSEL		0x1C
> @@ -160,6 +161,13 @@
>  #define STM32H7_DMNGT_SHIFT		0
>  #define STM32H7_DMNGT_MASK		GENMASK(1, 0)
>  
> +/* STM32H7_ADC_CFGR2 bit fields */
> +#define STM32H7_OVSR_MASK		GENMASK(25, 16) /* Correspond to OSVR field in datasheet */

nit: Comment seems obvious and can be left out.

> +#define STM32H7_OVSR(v)			FIELD_PREP(STM32H7_OVSR_MASK, v)
> +#define STM32H7_OVSS_MASK		GENMASK(8, 5)
> +#define STM32H7_OVSS(v)			FIELD_PREP(STM32H7_OVSS_MASK, v)
> +#define STM32H7_ROVSE			BIT(0)
> +

...

> +static const unsigned int stm32h7_adc_oversampling_avail[] = {
> +1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024

Normal style is to have 1 tab indent here.

> +};
> +
> +static const unsigned int stm32mp13_adc_oversampling_avail[] = {
> +1, 2, 4, 8, 16, 32, 64, 128, 256

And here.

>  };
>  

...

> @@ -889,6 +912,41 @@ static void stm32mp13_adc_start_conv(struct iio_dev *indio_dev, bool dma)
>  	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
>  }
>  
> +static void stm32h7_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 ovsr_bits, bits, msk;
> +
> +	msk = STM32H7_ROVSE | STM32H7_OVSR_MASK | STM32H7_OVSS_MASK;
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
> +
> +	if (!ovs_idx)
> +		return;
> +
> +	ovsr_bits = (1 << ovs_idx) - 1;
> +	bits = STM32H7_ROVSE | STM32H7_OVSS(ovs_idx) | STM32H7_OVSR(ovsr_bits);
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
> +}
> +
> +static void stm32mp13_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 bits, msk;
> +
> +	msk = STM32H7_ROVSE | STM32MP13_OVSR_MASK | STM32MP13_OVSS_MASK;
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
> +
> +	if (!ovs_idx)
> +		return;
> +
> +	bits = STM32H7_ROVSE | STM32MP13_OVSS(ovs_idx);
> +	if (ovs_idx - 1)
> +		bits |= STM32MP13_OVSR(ovs_idx - 1);
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
> +}


Some comments in these functions could be useful to avoid needing the
datasheet to understand all the different things that are happening here
and more importantly, why it was decided to do it this way when there are
many other possibilities (i.e. repeat the bit from commit message about
always using 12-bit output).

> @@ -1461,6 +1519,69 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int stm32_adc_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	int nb = adc->cfg->adc_info->num_ovs;
> +	u32 idx;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2)
> +			return -EINVAL;
> +
> +		for (idx = 0; idx < nb; idx++)
> +			if (adc->cfg->adc_info->oversampling[idx] == val)
> +				break;
> +
> +		if (idx >= nb)
> +			return -EINVAL;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;

We've been replacing this everywhere with:

		if (!iio_device_claim_direct(indio_dev))
			return -EBUSY;

See: https://lore.kernel.org/linux-iio/20250331121317.1694135-1-jic23@kernel.org/

> +
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			goto err;
> +
> +		adc->cfg->set_ovs(indio_dev, idx);
> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +
> +		adc->ovs_idx = idx;
> +
> +err:
> +		iio_device_release_direct_mode(indio_dev);

		iio_device_release_direct(indio_dev);

> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

