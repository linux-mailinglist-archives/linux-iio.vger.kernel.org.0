Return-Path: <linux-iio+bounces-23883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0BB48D2D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 14:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F5C16201A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E62FE049;
	Mon,  8 Sep 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmKhRTm3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC012264B6
	for <linux-iio@vger.kernel.org>; Mon,  8 Sep 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333782; cv=none; b=gg86zMGWu7jT/CWFdV4uPeBFIwzqt5HtoIR7/3fnFOjffd3xaE0k5G5I/rSswNmaH9e/qLtrfJlGUaIoPnklcD0q4NEydzdD9W/hc1Z1UJ7euk5lzpN4XgqpB7L6wVBSdMba1vaxOJvhvSg5adz8W9nmoC5uPeE54IyHnGX3PsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333782; c=relaxed/simple;
	bh=4MmMtxr9FWrYk3eV+BcA70HiaflcG4yNB+x6gFP8ABU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHipuNG7SNAjbaz7ok4BQvm4hyPAOFIGhlkzQTNxiGYYAToo7C4giVpYQJHaUOs5tu+qvfrhk93HsTng+JIgC3m1OVK5zcVrcyJ0Ay+TQ/16CZHsIfv0J5rnUumxrNv6MUzriolTlybqMs2ujYL26+bs+CuYvR1prZpnNlJh6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jmKhRTm3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so35487085e9.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Sep 2025 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333779; x=1757938579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKwYvq6k8+ej97B1SVmOtFjmmFjJAHPbIxSDGQ7VhFc=;
        b=jmKhRTm3JyllAyunYNX1/lFXzcBVzwzgiBxuYeQFOtU4Dwpjm9y+2GZZKhr6/a8eus
         JehOBy/6si61qYlkh5X8MR5eVFVUjy50RaCxNfQ34KaIgVFMkkxPfiNSr6qErxCzVKRV
         /r2/JvvGV31Ufv3PCm/hdncso/XXxwrmvKBtz+FkPV+7uql7RwljY3SVBJa/aq0UNvV0
         9fkWySTd+vwSwCn8CKDtxxkeYy0ar+pfiLLL1UvIfyP5sFkhA0kPEors4nJMAhSifsTQ
         8I2+tGLbOZw+uivKhj79Ai4BcSeegXFoR/BfvPFMTxN40CS5MPfnwR61jDixwp68rGE8
         7viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333779; x=1757938579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKwYvq6k8+ej97B1SVmOtFjmmFjJAHPbIxSDGQ7VhFc=;
        b=Pl/LJD6ygRsJKLxcfAgwGMqS4NY7dvRT+j/YsCr9DGmszjjDAcagXxFPjX6713hN6P
         Waua7ZQocfqhJZ989fJ07c14C8CneABLr718crHVrUISFr18QEcoR0jtSJq4qQKO55qb
         elgJfW5qxToX4+QassKCWfplF8SNv7GuKqrSz2qBljCIKcRDKR84BUGWRmuftd+4T6gs
         lQQRQFeg7uJLPx33zpwNms9LHMUQHRqIjM1MkKecES+mwehMT/lRmFFbbZx1Zcn/jlpq
         iWSR63huwijIXStpNqL0WnLa6r3jJ0CAppppZpLvEqpNPZY1Ti2W5WD3c4zCcm1hvNaw
         8kJw==
X-Gm-Message-State: AOJu0YzeC93uSfeNXuySxRsTZhxHEq+r4PBEiauzxEj38anuecEvl8bq
	3nqZfhi6PF3j47xGUWmTLaC6Anw3F5PW/DT4x86s3mykaOcvYFW92mUAjzLt3ffjxCw=
X-Gm-Gg: ASbGncuHGklUmBHNtZyFnFt/nxxOBpKSxHcZcsTNqMbUcceHCc4w4PU4HlhydvvzbIR
	sDX/QyVrSoNOQc9k4JqhC4+G+LO+VsuFZG3H9xfCO5LT1eKZ6OTNFQyAdjZYvqDhmToqL9rEfRn
	DIQez4behW2paM6MS6OBqxv7l+RiUTWGQrS4Tq1R0ds2t6eVh6wkIb7p+l9AnWRKp+LdAIBfkxE
	k0AUXj63GtqMDWbB4q62Rh0YJvH55mW+O6/H8CBhPvoGyF6ri3l7g0MvkMZKX5lHRCMXEQqJbby
	uIJ945YqBkn/i0JdOoqOOW2WCJEBxmUFP8s1no+B9r7YmZzHLLqT4d8TcHly+3Uf8vcJmM/YYU8
	Dgew4m+tjiJYs5Mb+8C5sqrgI8wqHOsPg5Z2cVPYbB4gKBxHYVDrZ4g/kNKQRYytIOvmapKEWBi
	aY27XGf+ETb2Kc
X-Google-Smtp-Source: AGHT+IHHaHG9f3JfZZVt+d1nycXZY2xvo779V3OBu/mIAiQ09/Gn1pehlQ1lC70/JTuVl0j5hESIAQ==
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr73119825e9.12.1757333778815;
        Mon, 08 Sep 2025 05:16:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9b6a:7b16:fb30:a294? ([2a05:6e02:1041:c10:9b6a:7b16:fb30:a294])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45de15de318sm86864365e9.13.2025.09.08.05.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:16:18 -0700 (PDT)
Message-ID: <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
Date: Mon, 8 Sep 2025 14:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
 <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
 <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
 <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 23:54, David Lechner wrote:
> On 9/5/25 3:58 PM, Daniel Lezcano wrote:
>> On 05/09/2025 17:25, David Lechner wrote:
>>> On 9/5/25 4:44 AM, Daniel Lezcano wrote:
>>>> On 04/09/2025 19:49, David Lechner wrote:
>>>>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>> Taking a step back, what sort of real-world uses cases do you need to support?
>>> Or are you just trying to implement everything that the ADC can do? The latter
>>> can be a bit risky because you might end making something where you can't do
>>> a buffered read and a single channel read at the same time, but later find out
>>> you have a real-world application that needs to do this.
>>>
>>> It looks like it would be possible to implement buffered reads in lots of ways.
>>> IIO devices can have more than one buffer per device so we can add more in the
>>> future if we need to. So I would just drop the DMA part of the implementation
>>> for now and implement the basic triggered buffer using MCR[NSTART] and ECH
>>> (End of Chain) interrupt request and just reading data from the ICDR registers.
>>>
>>> I would wait to have a real-world application that requires DMA to decide the
>>> best way to implement that. There are lots of possibilities, like does it need
>>> an external trigger or is continuous mode good enough? Does it need to be cyclic
>>> (something the IIO subsystem doesn't really support yet) or not. Is exact sample
>>> timing important or do we just need a big buffer? These questions we can't
>>> really answer without a specific application to use it.
>>
>> In the case of this IP, the use cases are in the automotive context. The system running on the APU is supposed to monitor at high rate (or not) the different channels which can be connected to any device the integrator choose to use.
>>
>> For this reason, the driver should be able to support the different modes because the integrator of the car computer can decide to monitor the devices connected to the different channels differently.
>>
>> Said differently, we need these modes because the capture depends on what the integrator decide to connect to the different channels.
> ...
>> We just know all these use cases exist.


The submitted driver supports the three modes.

Nuno asked to use the IIO dma engine API.

However there is few information and examples with the API and I failed 
to use the devm_iio_dmaengine_buffer_setup_with_handle() function.

AFAICT, devm_iio_dmaengine_buffer_setup_ext() can not be used because 
dma_slave_config() is not called, thus the src_addr is not set.

Is there any example somewhere, documentation or guidance to use the API?

Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

