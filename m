Return-Path: <linux-iio+bounces-26814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF4BCA964B
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 22:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C59F30A0327
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 21:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED73238C36;
	Fri,  5 Dec 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PhTdc+4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A670217722
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764970435; cv=none; b=cO4YNWrbdrW6GCobXTpCEklDHnDWh78ChkirCflDEfQZ8Ebw2D4jt5WleELdmqn84YHXLR14UMkr3upZznHeJJYzs80Ry8JB1okiTp6qNY5OdKAn01Dv8M2Fr4xvO0z9aMLGDlyCOJUksmb1Rgcty9mdX3ZzLz7IuEO7ddaDfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764970435; c=relaxed/simple;
	bh=DTNDsXrW3gYqlTtoxsahE8mUn4joQC1m2klKrNZaWOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlEWVQ10p2ytzp4AhcdgH/FW40LJIySatyYesm+4eJSPoX2SzQYyEySynGBgEtLEOLOtCS7UTFNYFSJHJXHRVQeI8xj6E5efNBdbZhh5b+Ow+sAt9ALiAQiQJIFuQvQG8FcLDrcGWxxB8xQMHFYbJwnNFiRsZf03Q8sRndMIIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PhTdc+4J; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c78d30649aso2268722a34.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764970431; x=1765575231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4TWcVAz2uSF1QmLkHSsv7lRqF+S1rsR8130wzcX2HU=;
        b=PhTdc+4Jyt9Wzp7xbme6dTvz/zP0gufVJ/94B6lIWYlwYkPecUrv3o7JXoAxR4lJ0j
         ynfIgzZjNaJiEAFgyux1tzn05eAltS+LICTOwzxp4Kdb95Af8YumkNzUcIZck26zAi4Z
         PsHZL7EjY3Ie168I2fLmN1mQOCWPbki8O/VzsK2wCZwhLGujOfY1GZdrCiYababLOo4R
         MKOaU9WIarPGMFcvg+VdNxjcFTOTUJVoqRnzmj0JjrpW50WiiJlZ/OHPVGXSsOBIj+/w
         UiZBBQVdkst7qn37ukSXzkqM33q2W9lceDmxHgskQHnHogASY+0iIWQIPszcFqOp41vm
         N8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764970431; x=1765575231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4TWcVAz2uSF1QmLkHSsv7lRqF+S1rsR8130wzcX2HU=;
        b=Y7P7tYbjiH97WzwaKKpGybo6+uZpK0dEXJ2CwqilzthPMKL4kSIpK7agRHTI9G+za7
         5sfCKkVfH/4rwXJSFie2GUSL5wMAozBKh3wu2/o3oDcbjxUfFkxMYaLp3/qSnSs8xnNL
         mftI3ihZUt/qE7Ci8wrOHeh3pEs9CA/HKeNIwepP/34qWJnXt1GQ60icJStS45va9JuC
         FuQlEkPsu1p8hN2OdUZYpJPszjkfFccfWJJoXNnETCYKQHTTG5OZXktIAGaOI8fKzmC9
         CXje5LdYaMIFlxkofGOUsZVex9KekCdbo/Z/VgffJ7dfJ4VV/u31SZeCyrTAa8HK+y1r
         WEXg==
X-Forwarded-Encrypted: i=1; AJvYcCXoaKCg1W1G02vBahP8l+fnO2C+yDoqg85a3YOnosiAAMI221HxmQzkLw3uZJx2KQma1KAo2IGbc1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5mgXlp0cqf0elRc/ticrqj07dDjaVLlpMXISJz4HDTAjH5BL
	jWv0rbHj2wFp473c8InnXr9E7SgM22d+jW7rrk2C3+bIL/uHCQE6INN7IotVEMjpdWc=
X-Gm-Gg: ASbGncsphxIjBhNGURnGDup0XxW98iovt36sICdgz8cDY5v9ARqaTVsysneaZHHlRxJ
	HOORNK/UlVkXzmtHaFCLJuWst5Tob/ypevNTd22Zyi01smO9aFQPf3w3lStb4bQxDCJFMDjBF+q
	G2HUL6T13oXq1FbEtwdmn70gSns3KBpL3WHzGYqgULKoq9TkE5RW8BakMKy7bwaZRE68CFubkJi
	pFHmWVT3H3XShbtxjsxeb8It0z+izCk54IOB7amut57dEjgKglP/mUiaNWfClIki078M0EMfXJv
	s26In8Aw21opdeZwqYLWlnsG8Wy39yFnjmpxOcIeG2K3WGpNPOb5rXG8LnBJA7SwVzyk4R0AOo4
	rDiaybOuTgI75KVpMhtsxnWX2wj6ShX4DWxj1jr/H6XXkIvLWLx3hwEji8ULFA/KFOc/QYk8lWd
	u3WogXzg1+TgexXKovknCQhSaQUr5tXDRoHYTE99UtQ61cm7IoU2WtRxwCbD/dCB/LUw==
X-Google-Smtp-Source: AGHT+IFxF5VC5KzeWcB4vwCXW1FOtwPl/+NS36oienP8ntXVr57qTkc5B8eWdfpBnotJKNuVvN0ogA==
X-Received: by 2002:a05:6830:4413:b0:7b4:f1e6:4957 with SMTP id 46e09a7af769-7c970826792mr299405a34.20.1764970431246;
        Fri, 05 Dec 2025 13:33:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c301:de6:97d:1492? ([2600:8803:e7e4:500:c301:de6:97d:1492])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac85170sm4474274a34.15.2025.12.05.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 13:33:50 -0800 (PST)
Message-ID: <0cf78f84-01e7-4507-abf9-2f82f98206b2@baylibre.com>
Date: Fri, 5 Dec 2025 15:33:49 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes
 property
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>
 <20251204213348.GA2198382-robh@kernel.org>
 <aTNKyaWAEjVJixMI@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aTNKyaWAEjVJixMI@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/25 3:12 PM, Marcelo Schmitt wrote:
> On 12/04, Rob Herring wrote:
>> On Mon, Dec 01, 2025 at 08:20:45PM -0600, David Lechner wrote:
>>> Add data-lanes property to specify the number of data lanes used on the
>>> ad463x chips that support reading two samples at the same time using
>>> two data lanes with a capable SPI controller.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>> v3 changes: new patch
>>>
>>> I added this one to give a real-world use case where spi-rx-bus-width
>>> was not sufficient to fully describe the hardware configuration.
>>>
>>> spi-rx-bus-width = <4>; alone could be be interpreted as either:
>>>
>>> +--------------+    +----------+
>>> | SPI          |    | AD4630   |
>>> | Controller   |    | ADC      |
>>> |              |    |          |
>>> |        SDIA0 |<---| SDOA0    |
>>> |        SDIA1 |<---| SDOA1    |
>>> |        SDIA2 |<---| SDOA2    |
>>> |        SDIA3 |<---| SDOA3    |
>>> |              |    |          |
>>> |        SDIB0 |x   | SDOB0    |
>>> |        SDIB1 |x   | SDOB1    |
>>> |        SDIB2 |x   | SDOB2    |
>>> |        SDIB3 |x   | SDOB3    |
>>> |              |    |          |
>>> +--------------+     +---------+
>>>
>>> or
>>>
>>> +--------------+    +----------+
>>> | SPI          |    | AD4630   |
>>> | Controller   |    | ADC      |
>>> |              |    |          |
>>> |        SDIA0 |<---| SDOA0    |
>>> |        SDIA1 |<---| SDOA1    |
>>> |        SDIA2 |x   | SDOA2    |
>>> |        SDIA3 |x   | SDOA3    |
>>> |              |    |          |
>>> |        SDIB0 |<---| SDOB0    |
>>> |        SDIB1 |<---| SDOB1    |
>>> |        SDIB2 |x   | SDOB2    |
>>> |        SDIB3 |x   | SDOB3    |
>>> |              |    |          |
>>> +--------------+     +---------+
>>>
>>> Now, with data-lanes having a default value of [0] (inherited from
>>> spi-peripheral-props.yaml), specifying:
>>>
>>>     spi-rx-bus-width = <4>;
>>>
>>> is unambiguously the first case and the example given in the binding
>>> documentation is the second case:
>>>
>>>     spi-rx-bus-width = <2>;
>>>     data-lanes = <0>, <1>;
>>
>> I just reviewed this and all, but what if you just did:
>>
>> spi-rx-bus-width = <2>, <2>;
>>
>> So *-bus-width becomes equal to the number of serializers/channels.
> 
> Unless I'm missing something, I think that would also describe the currently
> possible use cases as well. To me, it actually seems even more accurate than
> data-lanes. The data-lanes property only describes the SPI controller input
> lines/lanes, no info is given about the output lanes.

It describes both directions.

> Well yeah, that would only> be a problem for a device with multiple input serializers and multiple output
> serializers. Still, the *-bus-width = <N>, <N>, ... <N>; notation looks clearer,
> IMHO.
> 
>>
>> Rob
>>

It think it complicates Sean's use case though where such
a controller is being used as basically two separate SPI
buses.

For that case, we want to be able to do:

spi {
	...

	thing@0 {
		compatible = ...;
		reg = <0>;
		/* (implicit) data-lanes = <0>; */
	};

	thing@1 {
		compatible = ...;
		reg = <1>;
		data-lanes = <1>;
	};
};

Meaning:

+--------------+    +----------+
| SPI          |    | Thing 1  |
| Controller   |    |          |
|              |    |          |
|          CS0 |--->| CS       |
|         SDI0 |<---| SDO      |
|         SDO0 |--->| SDI      |
|        SCLK0 |--->| SCLK     |
|              |    |          |
|              |    +----------+
|              |                
|              |    +----------+
|              |    | Thing 2  |
|              |    |          |
|          CS1 |--->| CS       |
|         SDI1 |<---| SDO      |
|         SDO1 |--->| SDI      |
|        SCLK1 |--->| SCLK     |
|              |    |          |
+--------------+    +----------+

(I don't remember if SCLKs are shared or separate, but I don't
think that is relevant anyway).


I guess we could write it like this?

spi {
	...

	thing@0 {
		compatible = ...;
		reg = <0>;
	};

	thing@1 {
		compatible = ...;
		reg = <1>;
		spi-tx-bus-width = <0>, <1>;
		spi-rx-bus-width = <0>, <1>;
	};
};



