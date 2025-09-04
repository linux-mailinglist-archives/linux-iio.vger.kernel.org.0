Return-Path: <linux-iio+bounces-23721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37431B44494
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6608484F5D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302C3148C9;
	Thu,  4 Sep 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNU6LEWS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC63128CC
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007638; cv=none; b=YaL5+BnLkLgef9JxzVaVkr50aH62aO2hZvdka4+s51R3PwDIDyGUazVLOzdZmcujDMC7MbylU+2hi6pImyKvDKQ/8lsM+Qn9aaWYmjaYr3uHygfxQ4aZYUfcMwj3Xt523/dBFC7XtPEUW0H3LpBjXrV2mh5eeLa4ofwFl/bfc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007638; c=relaxed/simple;
	bh=5Ib02mSICBZ0DFrNNdPd9il3nIR6lxYlpt+I2GZ5RoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqfm58KHvVXaIkonT2dIFPltSEuXTEDhz1b81mHIZeLbyEGweUZiUTAnWE0U18DPA3XF9kibOnDMEBLADG7QknHsno/SuKY7ljGDl1myApOGPsiKNUeqcDv6JnWmitqyctX6vA0PF1BSrsWLC1ZrmfhzfvUIXaor/Hi/2nX6zrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CNU6LEWS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso12749875e9.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757007634; x=1757612434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz04AXZsou7Y/CjhykkE7na0Wf5VZ1/j8DYfkN8tsbs=;
        b=CNU6LEWS5PrfnLe0hJ9q1Ii8Du3PLgSAlZnbnB1LboEvr47Sh9qpFpQD3pM1WeqiF1
         HM+vLt+nCsXy/kIBOL0kWBv9BF3bRfLGJbz+hIzWunHpsgYF9ZbuZlTVvmu9eFQuz8Y1
         pEVAcgqOdoGhsB0UX5JB24oJc7+Dup+oLEtLEXlVZd8T3z2JQb8lvrJvaBQTauU5Qxm1
         kNQGQ4h+hvm5+AuKu2BV0D9/ZI46iQo8+Ppm9byLnH0mJRZ6Kq+WkfMM3OFJrIQo1JS1
         uaFMch8BSoOb9ehU8t3pUZPcNOT3pbUPWbdQ5Xmj4v15Osrp1URY0NPECQ9HT4h/LXUG
         smxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007634; x=1757612434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz04AXZsou7Y/CjhykkE7na0Wf5VZ1/j8DYfkN8tsbs=;
        b=qp9pVY8QQwUMCso7aMXoClUJeRlhQku6ZAAsM0GK9F/FY1HKWmlDAissHTIdhfTBb4
         o+b3rwq9K7rpl1xal5QnMWA8ztnCN8TEeR6VNDXJJuWL+3wtXhwhgyKHaXCqw1JMA2mo
         6Ln9tP1MhecqyYtEwJM4J/9WJIe42dkok3viSwSWbteQmV+YLkHeMd4YJn61s5fdfy1d
         JLR8iDvEjsNQyiKs4woS11qTFWhm+r703DJ4YYLF5GF3veIHkPRgnwvNOgkOs6TR6hkI
         63hXzt5wX0TwjrHRhgvhMU5WN2mOaKZbIk2SrLZj7nNHnsnGDbrh5elUxfkDGf8WYAMS
         xlsg==
X-Gm-Message-State: AOJu0YxuhTzCoTmgC5yCLmWuHcri80S5giEf3RE+RPzcliGExevhgEtz
	eElCccAh+9aX0nySLE7wWtntsH2P7P4+9UdJj149wfaCVG3iQfe7uWvyYf9gKlinqJs=
X-Gm-Gg: ASbGncuUmKAuoxpNhOGTAj/hGQpU0bx0EazAdhKaqOcq7YXoFnIWJ/j4W7i1V6vheX7
	hgUVSqChPVEY6VKsISpaaw47CaxpW0PkOcuTeilr4edSp3zVYVimtsyR+9+mSj2gTrgqBwFJKDN
	VWabRcyi4slVglg/AjWtXu+d8+jkzZSBhiEUDjxWSQwoTUpk9j2r/5EyfBx3tdmOhc20Zf56ZHO
	ZDsdr5cqt3xGkv2krTaqaeetP2nQhh9rOYof8KgFc8AUbU9y4sEu8FL7tQkuUhQ+tEgRWkJ6HAh
	8EKlFkLM2RNFJ3J+GAi4ZdNVjzMP5c63ksFlyETlKQT69GqgFRtbRn2rSw1JPANfpfoPzNciakH
	qB+2jBqlrCvrU2OzrwaNwHvKjJSsnbUHPauTxIzZhP7G0jKU5o1RpzAuEBtMxFCgRIk6jdZbBPd
	ZFP05cgaP5w3kw
X-Google-Smtp-Source: AGHT+IGZ2Wmsio2VXbNC6WWTz53FPNufeVlpIVAAIrdXxvDpJC1Ot/pEt8Y5Bcy8d6YxpikgWg0f0g==
X-Received: by 2002:a05:600c:8b51:b0:45d:d505:a1ac with SMTP id 5b1f17b1804b1-45dd505a229mr12418765e9.15.1757007634241;
        Thu, 04 Sep 2025 10:40:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1ca0:c789:48cd:e2f9? ([2a05:6e02:1041:c10:1ca0:c789:48cd:e2f9])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45d468dbf48sm57668355e9.11.2025.09.04.10.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:40:33 -0700 (PDT)
Message-ID: <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
Date: Thu, 4 Sep 2025 19:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nuno,

On 03/09/2025 13:20, Nuno Sá wrote:
> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
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
>>
>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

> The above needs some discussion at the very least. Have you considered the IIO
> DMA buffer interface? It should be extendable to accommodate any particularity
> of your usecase (or we should at least discuss it).
> 
> With it, you also gain a userspace interface where you can actually share DMA
> buffers in a zero copy fashion. You can also share these buffers with USB
> gadgets. For instance, with libiio, you would be able to fetch samples from your
> host machine (through USB) in a very fast way (zero copy between IIO and USB).
> 
> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
> to retrieve the data seems counter-productive.

I've read a bit about the DMA engine. It is unclear how to use it and 
there are very few examples in the different drivers to refer to.

This proposed driver supports the RAW, BUFFER and TRIGGERED.

Shall I create an IIO device with the modes:

indio_dev->modes =
	INDIO_DIRECT_MODE |
	INDIO_BUFFER_HARDWARE |
	INDIO_BUFFER_TRIGGERED

And then use:

devm_iio_triggered_buffer_setup()

and

devm_iio_dmaengine_buffer_setup_with_handle

?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

