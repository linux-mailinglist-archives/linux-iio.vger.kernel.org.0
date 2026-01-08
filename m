Return-Path: <linux-iio+bounces-27560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BCCD043E4
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A8D30F940C
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A32DEA6F;
	Thu,  8 Jan 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G3j41mTi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554632DB7AC
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887853; cv=none; b=VLgwtHzaV85IhAhSodOSoLVe8qfhLz+53K4VJHfYUmOVqUYfrQNYa0RgGsMdNBgvwmLdgrJC6wGAjReJM/oG+Su0T7xFbRc3SbjtCUpocaXiyQ0ai6zD9H0PKnKkKBHHx6LG7DvLWgyCMutVJZDX4QsOj9gxlCCJbNNMS01OTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887853; c=relaxed/simple;
	bh=XcIRTAb5PFlqniPMsUHB2MwKn3jJ/O2F2bHm2pJVK/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCB0981+chTt2UcmyZ+MoViEdaroXeNGUk7GJXEOU0CTjUv49EPjp1ENGctlDplxfMjPWbuSjreOgf6eyYhRhDNY2RC5S97iswNd+lycAPzL50UJyLf3G1KKFLhTeLS3D6yLaJW6RY6kMqBBVNWh0zmqoQpwZvyEQTu4EqA3Jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G3j41mTi; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7c7545310b8so1821612a34.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 07:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767887850; x=1768492650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChbNYybDAN+PlLSGQ3kv1WrtIpPyDTfLMW7/iZLxLus=;
        b=G3j41mTiH9RcwOYuX7LMffkbdVh5ol8NDyZn83UCLVsWLWe05zy9ilbTAvrSd2CZvh
         t1E6eLILdeV1xwCZ8z2fPt2WPrdc3QH7zwhSbOsc8tDCLQPcoKWV0xmCjFSjDq1vEOVP
         u1RF1y66OJ1TAWDptOcak8rpW8CNUBzy3in0XoPt0nstEVSn8KcbfADWwgzxh0VFQHWu
         NdFq5NP0LXtUMNb6VQMrH74SIEw5yvJsJwIvZGkTLVJVD9jIbFvtpiasC+W6JZGNwv6m
         jwjhd5hUcz5vjI16T8zOsDoN6F+w9ljMPTtWyt2pqmHJ8xricXwxBXvsiE6x1zaBCJzx
         cqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767887850; x=1768492650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChbNYybDAN+PlLSGQ3kv1WrtIpPyDTfLMW7/iZLxLus=;
        b=QwsV1N7dQaPCkym9rADLDeTTNxJ34US35Uzbj4CNfEO7Un0m0tWkd/zerMOYKPtgmc
         eT2XPS8Me9RO6/NK9lcYLJH7AD0z2muaSVcckCfIB5NBn+5GzfzevMOHGVMQ9BQLkq1n
         EkF4RAosL35JN/3vJeECqDaywsAWHyrbgIZ8/62P0b7s9yi5Q2pWE7MNcisopxy4mihq
         dX5MEkHC0KbijWNXI9TePZvy90LJ20gFXEB81c4/OyClvm+WU7VbJ/FPgTWorLANAcrc
         /PUzrXKcKl+xoBy5/t2iL0lTxkzJOz1U1DSgtcqZpuNB7Y4guYq/o0DAdkqgzzAq2AiW
         R+dg==
X-Forwarded-Encrypted: i=1; AJvYcCUktZDTJffxo1PRU6YWZJnVmZiQCithzs5g2sGWkE4FRGyIH0oZA+eal9+/arTDQx4aEwK3rkE/iDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUJhlHuKU27CVDvV7VNdbSb+gmYpFR5J7Q5dFiiVFW3YWhazZ
	BAJoZt12xchiSxZPid4PKCC4hnA4SyatbN5WY5riK8vp7Am3I43MM55LMqOB4Bd8IZ0=
X-Gm-Gg: AY/fxX61wZWSHHuxL6yG1tW2Ehoj0zgph4VK62S0V1tc406uHN9LYCxwBS8j/nygJNp
	uRLPKW6tKClwhF4/M30MYWHyR3X7biXdR6fd8pdV4GLs2WYoMcrWeBwXKugvP2yZ1Ik6ucWj/H/
	GXkJakQsk3tcfpwfwTgHe35Du5Ow7Ed2Jh0RO2t3h3HetlGi/gkzkrLxEq7CoFbVK7RENyHy/Fe
	y4TZ3GEUwjLxm3/fmU2J3vZfWKgjK/Acor6pe0tg/pln3BWrIxbDMmTMxQKQ/15gxSCHXgDnKlK
	uRDryxoLLI4f+akrsfslkDowbb9VGOSi798kIGV3bCTF0vNXXzyaI0r7jkMgnx96fBZakL6b2Wj
	dSevzw6EKsfr3ESjAFr9Wm/B0Aw5Rj8efNo5yNljaUfPhs3xTa9hYZnY0TkvOdnLM79ZQ5CjvRQ
	OlOlkm8amDIvEo+cX6j140RAeZyGiO28uuULgoT89TbAKkKoo90vGfpjlCiqXw
X-Google-Smtp-Source: AGHT+IEqkm4LvUk8v6PJn4dMOjcEAKptGcqeUy22nLPhpl6cUZVQsY3c5PT1cLF07hCu1ja1uiQnug==
X-Received: by 2002:a05:6830:6f83:b0:7b7:59c5:766c with SMTP id 46e09a7af769-7ce50bec1b5mr3163482a34.33.1767887850382;
        Thu, 08 Jan 2026 07:57:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c69c:7b5c:ce9b:24be? ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af813sm5732105a34.19.2026.01.08.07.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:57:29 -0800 (PST)
Message-ID: <97096aa2-acf1-4e4b-b03b-b538c3c1cf27@baylibre.com>
Date: Thu, 8 Jan 2026 09:57:29 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] spi: Documentation: add page on multi-lane support
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>
 <aV-lzD1BEVSkGjba@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aV-lzD1BEVSkGjba@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 6:40 AM, Marcelo Schmitt wrote:
> Hi David,
> 
> Thanks for adding a doc for the multi-lane stuff.
> Two minor comments inline.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> On 12/19, David Lechner wrote:
>> Add a new page to Documentation/spi/ describing how multi-lane SPI
>> support works. This is uncommon functionality so it deserves its own
>> documentation page.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> v4 changes:
>> * New patch in v4.
>> ---
>>  Documentation/spi/index.rst               |   1 +
>>  Documentation/spi/multiple-data-lanes.rst | 217 ++++++++++++++++++++++++++++++
>>  2 files changed, 218 insertions(+)
>>
>> diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
>> index 824ce42ed4f0..2c89b1ee39e2 100644
>> --- a/Documentation/spi/index.rst
>> +++ b/Documentation/spi/index.rst
>> @@ -9,6 +9,7 @@ Serial Peripheral Interface (SPI)
>>  
>>     spi-summary
>>     spidev
>> +   multiple-data-lanes
>>     butterfly
>>     spi-lm70llp
>>     spi-sc18is602
>> diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
>> new file mode 100644
>> index 000000000000..b267f31f0bc8
>> --- /dev/null
>> +++ b/Documentation/spi/multiple-data-lanes.rst
>> @@ -0,0 +1,217 @@
>> +====================================
>> +SPI devices with multiple data lanes
>> +====================================
>> +
>> +Some specialized SPI controllers and peripherals support multiple data lanes
>> +that allow reading more than one word at a time in parallel. This is different
>> +from dual/quad/octal SPI where multiple bits of a single word are transferred
>> +simultaneously.
>> +
>> +For example, controllers that support parallel flash memories have this feature
>> +as do some simultaneous-sampling ADCs where each channel has its own data lane.
>> +
>> +---------------------
>> +Describing the wiring
>> +---------------------
>> +
>> +The ``spi-tx-bus-width`` and ``spi-rx-bus-width`` properties in the devicetree
>> +are used to describe how many data lanes are connected between the controller
>> +and how wide each lane is. The number of items in the array indicates how many
>> +lanes there are, and the value of each item indicates how many bits wide that
>> +lane is.
>> +
>> +For example, a dual-simultaneous-sampling ADC with two 4-bit lanes might be
>> +wired up like this::
> At first, I thought calling these '4-bit lanes' was a bit confusing. I was
> thinking about suggesting '4-wire lanes' but I guess 4-bit is more generic in
> case we ever see a setup where data navigates through something besides wires.
> 
>> +
>> +    +--------------+    +----------+
>> +    | SPI          |    | AD4630   |
>> +    | Controller   |    | ADC      |
>> +    |              |    |          |
>> +    |          CS0 |--->| CS       |
>> +    |          SCK |--->| SCK      |
>> +    |          SDO |--->| SDI      |
>> +    |              |    |          |
>> +    |        SDIA0 |<---| SDOA0    |
>> +    |        SDIA1 |<---| SDOA1    |
>> +    |        SDIA2 |<---| SDOA2    |
>> +    |        SDIA3 |<---| SDOA3    |
>> +    |              |    |          |
>> +    |        SDIB0 |<---| SDOB0    |
>> +    |        SDIB1 |<---| SDOB1    |
>> +    |        SDIB2 |<---| SDOB2    |
>> +    |        SDIB3 |<---| SDOB3    |
>> +    |              |    |          |
>> +    +--------------+    +----------+
>> +
>> +It is described in a devicetree like this::
>> +
>> +    spi {
>> +        compatible = "my,spi-controller";
>> +
>> +        ...
>> +
>> +        adc@0 {
>> +            compatible = "adi,ad4630";
>> +            reg = <0>;
>> +            ...
>> +            spi-rx-bus-width = <4>, <4>; /* 2 lanes of 4 bits each */
>> +            ...
>> +        };
>> +    };
>> +
>> +In most cases, lanes will be wired up symmetrically (A to A, B to B, etc). If
>> +this isn't the case, extra ``spi-rx-bus-width`` and ``spi-tx-bus-width``
>> +properties are needed to provide a mapping between controller lanes and the
>> +physical lane wires.
>> +
>> +Here is an example where a multi-lane SPI controller has each lane wired to
>> +separate single-lane peripherals::
>> +
>> +    +--------------+    +----------+
>> +    | SPI          |    | Thing 1  |
>> +    | Controller   |    |          |
>> +    |              |    |          |
>> +    |          CS0 |--->| CS       |
>> +    |         SDO0 |--->| SDI      |
>> +    |         SDI0 |<---| SDO      |
>> +    |        SCLK0 |--->| SCLK     |
>> +    |              |    |          |
>> +    |              |    +----------+
>> +    |              |
>> +    |              |    +----------+
>> +    |              |    | Thing 2  |
>> +    |              |    |          |
>> +    |          CS1 |--->| CS       |
>> +    |         SDO1 |--->| SDI      |
>> +    |         SDI1 |<---| SDO      |
>> +    |        SCLK1 |--->| SCLK     |
>> +    |              |    |          |
>> +    +--------------+    +----------+
>> +
>> +This is described in a devicetree like this::
>> +
>> +    spi {
>> +        compatible = "my,spi-controller";
>> +
>> +        ...
>> +
>> +        thing1@0 {
>> +            compatible = "my,thing1";
>> +            reg = <0>;
>> +            ...
>> +        };
>> +
>> +        thing2@1 {
>> +            compatible = "my,thing2";
>> +            reg = <1>;
>> +            ...
>> +            spi-tx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for tx wire */
>> +            spi-rx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for rx wire */
> In this example, even though lane 0 is not used by thing2, it is being used by
> thing1, right?

Yes, I can improve the comments to make it more clear.

> Just checking I understand it correctly.
> 
>> +            ...
>> +        };
>> +    };
>> +


