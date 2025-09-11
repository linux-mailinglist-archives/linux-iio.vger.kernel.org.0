Return-Path: <linux-iio+bounces-24002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F5CB53EEF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CBA442251
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F22F5328;
	Thu, 11 Sep 2025 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlSxrOTs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD00635
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631792; cv=none; b=Wp/GHE15ij9oCtPNX0hPEW8mCRgiQa/ttOzxaxnmn1vHH/6B3fHm/fjpMM+r+Xubx7lpSjNp/iTqKOLs0te5ZR8B3gfiT7JuX/DAAWwA6uZSQp3fitiUsxQmycXkxaDpfeGd7+UC6Hq40ko6xYVj8X1R/4rLIQruLYtT2u7JY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631792; c=relaxed/simple;
	bh=PfTc/ccwQ6K/zS8xQrsXGQdefoBPLwPnjCNhwd8J/3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEQ/ZZkThGHRb0oyrT+XrScJE/WTw7QCPMBWPzrrGNzrfkF2Bq7Qd5PLhbsU+nrUZVHqzoceQgA/KZXnFusbx80ghepdrR3rSKw5M3SJ6LqN2fEv/mKACoSMu81GvuynAvPnqWRRKXQztrzcFFhuFZLhkDX0Y9WSc6wG/1r8v68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlSxrOTs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so11942345e9.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757631788; x=1758236588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhP2GRvv9+0r6euJBGjNP04WaNqTND/5RjCo6pMURDQ=;
        b=zlSxrOTsLyiIq6GTZ9bCDxz/5UAESKECXy7OMa6HfqP4wVYEh3mwyNkggCELC8pa0h
         a1d0lfTRNQKnS8bBmuSbibBuMSn0ZbooS7Sqdq9Lc/RGIwD687OseJgyZ2WZ7fSeyc6q
         7SapTKibrQZYCN9T9LRustgpIyhUkGbhMOfwkuZLFkpbT/HHFyRUCnSkVt+lKIHrolYG
         OaWmK2lDPeC13pY9oRLftgine56nP2neE98NV7hF0el+VSc0IgMKk8y9P4ph6tFF/Cqg
         KzqKXxxM3rsmX1XJWgADZq3CPmjsI8975hlS8bCLMsSmN+3Ja47VQiu/vizHp3R2VpDt
         R26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757631788; x=1758236588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhP2GRvv9+0r6euJBGjNP04WaNqTND/5RjCo6pMURDQ=;
        b=VuNM4KHKcGIZ2cbzRzuKwTqhVvrHRbHltMNliE8tTXqMwMmUML3QY2n11+ImwXp+D6
         dYZ8AZg/Zdwmn9c5SUP81KpTru4vtkpwKXX+w+FIPUh3GtvJ0OsWcvaf2fdvmuIsJlcb
         5dn1+L7798QuQPNDmSiMeAbtm9HuUINGmMl96Mpp3Esf25tIHTvCh2ET59ikzqKSYiQJ
         UjbLBmXDkVF7yooNJiDjmzXQkGLHnHqdc8Vqo8nw/9X1EwdFhLNjBAtitBa4MG8rVdqT
         dMZElt95azydDVRRzAxkG/8PRf4xNFa5cxgXIVR0cBh0CjkC1feD5Qzr7Ofhox2BUgc+
         6hBw==
X-Gm-Message-State: AOJu0YxGUP+8TA/ZvR05l/v9ASZ74dQfXwNLo+Oqz7gnxsjNMa0S6iEA
	zLAfz25B3b8YS692u6KV8zOoOi/tp4BffRSSHWgvpC/79tvDUl5JDhHiLItBplIQ0Gc=
X-Gm-Gg: ASbGncsrcNxnmEsHYMq+GyJSx+nY5O1K/V0iDHs2XCHkoOtLsKssNtoqYAl4uTvmNqu
	2f28FgF8/0KJ5fx1BWoZbrbZmso4hIB1qDlOcbk7Bv99LlfIauSxL6Hw2VmdBbcXnJ9Kn1ArP3P
	zVpPFSUNqFFhectgqMjT9ZzvVpsMh5B1Iz/YTyjEyIJR9hyRUqkxKUbeY9fW3/m7T8dB8OIYnjN
	CVWqXWnDYLb2hsQlxl/6FjFGxdpyme9TPO60xUHQlCC7/5/80n0zWKPgCUGb8y9lhUoQnGjXwxE
	4hUdOqO9pAMet9l2B60MQDXM6ksbC2vYJmI9A1Lmw9e3QVD92N8l1qzdDgigjuIHdwpAhw0Y2im
	pGoe1gh3LZ/F4IU0WGOk/ENshE567/Wbsdx01UXcLqMsLvYZN6Z4/2SISbnkTBMp3Ro6KkyHaeS
	U69A==
X-Google-Smtp-Source: AGHT+IFxG/sLLp6AjM85wD6RJFn9gMCD9nscjdrLR58ul1ypLPeTftAA7eaLcpeDO3f385SMbDEOUQ==
X-Received: by 2002:a05:600c:228c:b0:45e:77cf:af9 with SMTP id 5b1f17b1804b1-45f211ccb37mr7075745e9.1.1757631788460;
        Thu, 11 Sep 2025 16:03:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d521:838e:7c69:f457? ([2a05:6e02:1041:c10:d521:838e:7c69:f457])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e0159c27csm21731545e9.8.2025.09.11.16.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 16:03:08 -0700 (PDT)
Message-ID: <ea57a466-97b3-49d4-8d1c-142fd49a0da2@linaro.org>
Date: Fri, 12 Sep 2025 01:03:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
 <20250910155759.75380-3-daniel.lezcano@linaro.org>
 <d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi David,


On 11/09/2025 22:10, David Lechner wrote:
> On 9/10/25 10:57 AM, Daniel Lezcano wrote:

[ ... ]

>> +		/* iio_push_to_buffers_with_timestamp should not be called
>> +		 * with dma_samples as parameter. The samples will be smashed
>> +		 * if timestamp is enabled.
>> +		 */
>> +		timestamp = iio_get_time_ns(indio_dev);
>> +		ret = iio_push_to_buffers_with_timestamp(indio_dev,
>> +							 info->buffer,
>> +							 timestamp);
> 
> Is it OK to call this with spinlock held? It looks like it can call
> devm_krealloc() which may sleep.
> 

It should be ok, devm_krealloc is in the code path of 
iio_push_to_buffers_with_ts_unaligned(), not in 
iio_push_to_buffers_with_timestamp()

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
>> +
>> +	data = device_get_match_data(dev);
>> +
>> +	info->vref_mV = data->vref_mV;
>> +
>> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
>> +	if (IS_ERR(info->regs))
>> +		return dev_err_probe(dev, PTR_ERR(info->regs),
>> +				     "failed to get and remap resource");
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
>> +			       dev_name(dev), indio_dev);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
>> +
>> +	info->regs_phys = mem->start;
>> +	spin_lock_init(&info->lock);
>> +
>> +	info->clk = devm_clk_get_enabled(dev, "adc");
> 
> clock-names was dropped from bindings, so name should be NULL.

Right, I found it when I removed the clock-names from the DT :)

> 
>> +static const struct nxp_sar_adc_data s32g2_sar_adc_data = { .vref_mV = 1800 };
> 
> Why have this if there is only one option?

There will be the ADC model name/variant in V3.

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

