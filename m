Return-Path: <linux-iio+bounces-27575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1DD0A90B
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 15:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 170C1307D46E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40535E521;
	Fri,  9 Jan 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK90metz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC535CB60
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967693; cv=none; b=AVTv2RaCj89kV28TgZvUdmVjhI6dLtnd3tax078cOYJ2FuLA/sthGJqWFzUlXZY43BrBD/+PslFZboBqx+XhAk8o1M1KQC1yNNTZ1N0YyRSiOBqpy5/mRBVZ4uMxR+5ad2ydpXEtDErD/lH+JBJP3wQoiXkcsYsZAYh32DBOtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967693; c=relaxed/simple;
	bh=qM4OzjmvdOSaKgv3mmsNcBVzz2Wq5zOBOAGMLzUa3hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MO2v2TubbunPl3dAvfOP4FkePBrnRb1Xu2ODCJX56JwjhVf0cBU6hVbZnu7GsW18BuOow/NpU/g2E69xushubrIEdrLrOaUAH0l8BIU/Og+MO1vE6YjAeEQqbxwUnxQ9xYhQ6rkkGddru5h7ey9AOspPq0Fast/HkoWGgpJCYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK90metz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so44177665e9.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767967690; x=1768572490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMdtktVPYLQdp20i3sGMyB8hcMRTbHonc8uUiEXE1Ps=;
        b=PK90metzIaFqXFBmFQU0RDVGAm1K5o04smnpr8ikxSAk/7pqrpN8vkkgW3TGwwoXNl
         yA6HUx1vH7huw1uRsRHqnl6rhWskI4r9jVCX0masj6ie1Yob7oilHIz0M0py9X3Eyrv5
         35E6HjO5bde1YjVU7ZUlfLaNIj2cKKmUXFydSFmGA1Hs+D8+Wsg6cGGmDOa96tDZ4hoM
         DmxEqCy4ovrATJuE9pTvOdD9bepTrgUXQ8sss/HO+NRl1vVMy5IETC3RJ3ziaUg/xn/S
         5o7tyR1dz2oU78FnyoN0uwUIpmnmlM0LeLW4HsYEXVPEnwgGOZC2H85F0HYIZ/5U+d8R
         5D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967690; x=1768572490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMdtktVPYLQdp20i3sGMyB8hcMRTbHonc8uUiEXE1Ps=;
        b=ph3xSM3VIXJqLyo42tKjxnL8g2LqKyqnzA8+9X8GMsYpZ1axu8Qhttvd/kPYJk/Qtb
         izyTNpiH9TGpll59PcdPoYKueI9W0mijLfPGVLNwCplaojYm6aOG1ZduUz8n2rm6JZpM
         N1+C7kv98Beu6JCVXCASh9/jxGcaeF8il2yuXIGTUFIeyMzNQ2vz/0RUHDYHOmTkElky
         v0IhG/75j/29djJVd2WT2Px0YZchqg7ouUjFSYaLhVu/4jTipbgWIIZGRoo+lreT3zox
         vETwrIEia6xwxJHlNN7FVLm9t032+JNS0KncdBH8SWnFOkF7dS5yjBOXSCmXJtaoXom7
         MXjg==
X-Forwarded-Encrypted: i=1; AJvYcCXuVUb39sTCyBo5zqpkHQd9bP3VFZDNOiYlm+3Z9xKf1M60h5TjnFEVAENk6jddymEyvlqoFuqtPww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVAjC3wBQ0hpUEaI0TiyC3QoLq+pVApbKEpLtt8Hyo8cKIG6F
	y19B9rU5U+ottmtXCEvsdU7cdxeQHqdEcMkeDHc1GBbOSyNFsxcxW+LN
X-Gm-Gg: AY/fxX6YlFSjUkkb2GiI6mbDkRU+CUgcms+p+01Z1Q5FVLVVa5t/aJphqdm3CpZ/W/n
	8C7Wyxa3SfVEYdUN3wZwV3/2vZweFqT+Xgqw5H+i2RKue6iB4AqWbtx54wrVUbEXwKAZ6Uz5OS2
	mf4bj+SYcgz/2UARBeRrK8O3AD9GHsKlM3gV+I1X9Ix1oRLLb/CPmX0EC3GOT3q/Lcr23NBz3f6
	3+v0P6jn7XkA7iI05yZEz4gUKci8EZLvymedeCZRzE0gUdLk2d9Rpk0MrxNb2HXimf34tE+U7qD
	+McHAu8gRyJMgYedx6Lms4gy0UOYhKDAZRiNucIa/rkZzTjvc8l5qulwuSfxzlJn0VwzjLte7xb
	ldxpHmTEpfxrXFnb6gX8kpYWPuB2caEaM3MBuvnOj6P32He5WXx8yIUuK8qwdNkdICcJCiqbIny
	/cheBiWUwaJS1IyUU=
X-Google-Smtp-Source: AGHT+IEW1P2FdJb52OHGZMAf1KlZ/qNCYOV/Vkk/nXNZ0uETDqC9KRFPngmTvu01WHkiH0xdVBiioA==
X-Received: by 2002:a05:600c:83c9:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47d84b3b650mr111945045e9.26.1767967689454;
        Fri, 09 Jan 2026 06:08:09 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c61sm212023925e9.10.2026.01.09.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 06:08:09 -0800 (PST)
Message-ID: <cd918f27-3939-4987-ab5c-3d88572e6e0e@gmail.com>
Date: Fri, 9 Jan 2026 15:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add max22007
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, jan.sun97@gmail.com
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
 <20260108-max22007-dev-v2-1-2506c738784f@analog.com>
 <aWD4LA7Y1fl3yvh-@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <aWD4LA7Y1fl3yvh-@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

Thank you for the suggestion.
However, reusing the output-range-microamp and output-range-microvolt properties might mislead the users into thinking that they can configure the DAC output range, which the device does not support. The adi,ch-func fits better here.

On 1/9/26 13:44, Marcelo Schmitt wrote:
> Hi Janani,
>
> One extra comment in addition to Krzysztof's.
>
> On 01/08, Janani Sunil wrote:
>> Devicetree bindings for MAX22007 4-channel 12-bit DAC that drives a
>> voltage or current output on each channel
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
> ...
>> +
>> +patternProperties:
>> +  "^channel@[0-3]$":
>> +    $ref: /schemas/iio/dac/dac.yaml#
>> +    type: object
>> +    description:
>> +      Represents the external channels which are connected to the DAC.
>> +
>> +    properties:
>> +      reg:
>> +        description: Channel number
>> +        items:
>> +          minimum: 0
>> +          maximum: 3
>> +
>> +      adi,ch-func:
>> +        description:
>> +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
>> +          output or CH_FUNC_CURRENT_OUTPUT for current output.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [1, 2]
> adi,ad74413r.yaml has many possibilities for the channel output type.
> max22007 is only either voltage or current.
> Can't we do this with output-range-microamp and output-range-microvolt from dac.yaml?
> Figure out the channel type from the output-range- property?
>
>> +
>> +    required:
>> +      - reg
>> +      - adi,ch-func
>> +
>> +    unevaluatedProperties: false
> With best regards,
> Marcelo

Best Regards,
Janani Sunil


