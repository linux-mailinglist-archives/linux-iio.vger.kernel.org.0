Return-Path: <linux-iio+bounces-7619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F98930FCA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42171C20753
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8718562E;
	Mon, 15 Jul 2024 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWO/uaC0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E91850AE
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032173; cv=none; b=RtGUwOZ4hWXDdtJAcbPPRRbxZgY/5NufaLEY0DIVxop60D6NkolCIsnEg4tDZeoKEVpZcSmaMsHWAVtlfbB/oLKRtZ6yDroa12JN5FVVRbzOiAH3YQch11THVFjQ5U4Eu7Q2p0uB1zxRFAbiEaFq02iuGxw3SKwW2PhIvWnTfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032173; c=relaxed/simple;
	bh=+5lkUx8+mk/uDe8jRuEOjYyNBwIjwxrOZjU46E/SB/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dtjkxmem7sFVUR1twDinZsVUCqp8uugkOTZcwCNu1MQuUbvfO3ug1g9DY75hoHIAf5HOg4m+OQD7MmzxueV7VVO29YHjiJynkoxswQoh53/2rwHkuKPxBtIIAZmqK5PXUAc1iRuZ7/RawuknOcYBWxfekQ8uDp/7cGJqn/zQxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWO/uaC0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so7491653a12.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721032170; x=1721636970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mLwLwOZkzvKFgw0aI85tugrfuqDFIADceOO8TgNb4Ws=;
        b=wWO/uaC0iYIDrxslZxsA2EnFnJVa1jXN091/42mrv9l2wuK0l2Ex4sdiqTaXPwien0
         Qt5E3OjzYaGKEE7puVPrfwjRMO8Qb1bynvYmfO6E0KtixPScKZ7k9vYontTAyr/zbXuC
         jlNXokUxHu3pbhCyoWuEYDijZH4s4Um2pTJ60x4TVNsU8GBa7RlIvvDXOuEjtkDad8eC
         VOpz7Gos+71D/L1uhIbWlh80y6c6Fb3YI7avQDVg511lAFon/ql4aQV3ULGMMVNB5DaM
         xYXKI5iyo/Rrs7x/ZucYZfztgJJMUDvHni8iDkJkQsF97ZnED5ywqFmfXWIAHAMGvCGD
         gJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721032170; x=1721636970;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLwLwOZkzvKFgw0aI85tugrfuqDFIADceOO8TgNb4Ws=;
        b=weffl4/auvZHNvnvmcw8+WAIHEkfBzz8r5wvRkzu85khUObm1YJrfQOb8tiX8+orR3
         eQSChKw22Z/Fmzv4w7JM05AAqscNHQhEJnNUJJkJ0o0bI4bMkihLbS+ZWNwbU3JTIxwS
         4K8en0QQVnGadPFE3MQXea2k7/GS+Pfs2ON3TqNl9Bt9Gl8RPwePBQNMKZGzEw7+FRk4
         2NGHIg49a3RRG+c9MQaJtD4Flk/wB4/lQikpk8DHckMUj1f/9f5JibVZhp8wVJLxlj7Q
         wh/D9+4YDH69lCKwYuEhH09jPYxYI+BQc/oOSfkrt/WFbv6l4+NBmOREFxe60dvjpGKc
         wDWA==
X-Forwarded-Encrypted: i=1; AJvYcCUQNiITOmRF7nwWC4LI8SRHti/7bWGJW/TzzkYEKCl/7zFUHjDfpdh14GmP0p1Q4WhVMQ1nwtwdyB62HrX8hYjPGAoluOI9bo9v
X-Gm-Message-State: AOJu0YzxtnMRo7su3hRplSJBgNCHtbWGREXrlR7P6M6FYf9aFCd2JKxr
	gNKLizu/pMti8G7BPIHtGOs0dGVMDkyI49lGwgw6oHOM3qOc2D7ftcJWNNORuls=
X-Google-Smtp-Source: AGHT+IFCQ23rjoVs9aGME4gMn1H3EOor3OSdkK43tb2BphIs3M0bnKJ3hC1TalhfJV44PKeWreNDLw==
X-Received: by 2002:a17:906:d9ca:b0:a6f:20e0:1d1a with SMTP id a640c23a62f3a-a799d3a3a0cmr510710866b.33.1721032169465;
        Mon, 15 Jul 2024 01:29:29 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3560sm192390066b.4.2024.07.15.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:29:29 -0700 (PDT)
Message-ID: <27af0c83-21f8-411f-923e-d9adcd4c17a7@linaro.org>
Date: Mon, 15 Jul 2024 10:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: msm8226-microsoft-common: Add
 inertial sensors
To: Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 Robert Yang <decatf@gmail.com>, Rob Herring <robh@kernel.org>,
 Sean Rhodes <sean@starlabs.systems>
References: <20240714173431.54332-1-rayyan@ansari.sh>
 <20240714173431.54332-4-rayyan@ansari.sh>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240714173431.54332-4-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.07.2024 7:33 PM, Rayyan Ansari wrote:
> Add nodes for the Asahi Kasei AK09911 magnetometer and the Kionix
> KX022-1020 accelerometer, both of which are connected over i2c2, in the
> common device tree for msm8x26 Lumias.
> 
> Moneypenny (Lumia 630) does not have a magnetometer, and so the node is
> deleted.
> Tesla's (Lumia 830's) magnetometer is currently unknown.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

