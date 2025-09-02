Return-Path: <linux-iio+bounces-23657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F4B40A29
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AD81A81AA3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A134334372;
	Tue,  2 Sep 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="auDW1mT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA06311C1E
	for <linux-iio@vger.kernel.org>; Tue,  2 Sep 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829409; cv=none; b=EpGyfF9QYjiuPx14wB42NaclZDL2frJpZd78nAXUBN0mG7EMdYVu+4heHnPLI/5D3Lq6G1RQzlwVpYBX5qkaCXIf8LhDnSn+oUixcyN8BnrvDQqHk0AaceafpeWrOf5z97DeWJNsY5w2zokx6LdkqqyBsUAPyS6SZ1znZ52g9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829409; c=relaxed/simple;
	bh=VrSQSITn9gd9lscxj+R2V/u4A3x4Is4GeujBk9+skZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aopSr/gMbjGQ8YHE71LSuDhe1iXs0JNRtZOTMMrx6TEabqz38h55fl8lwbxzgqUhXqm+8qwHaKP9jXTBpPczcBVfph5KuI9gCezgAVGTI3QTCCA3Wzim8qX7sf9kw7pPxsXIozcrvZeVDu3hZkUC06Bt0fxbIv0WfkueiIZHMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=auDW1mT3; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce5be7d0so2313734fac.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756829405; x=1757434205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1b2HBJLNyTHgHAemvhv7VSSr8vGG9gIZU3t67hKMHJo=;
        b=auDW1mT3OtaOt61wVvByNPhtnR7bdjL5+0xhF+mmGS/nf+IL+64r/Rgk/tfAlORyuZ
         rsyWqpUC4afDdpjiIWwihkYy1RjbqW4D/2HOVBabPbt2zieAHtiX51OtfTa/i0TMwNfH
         bWWuibWZNGyw8Wvg3aMRkBPrL4rczuOSWcCipnf0ELP5Hio3G/CHWi/CsxErJIrYXsYA
         5oH2hqavktPFFA5Vr2TShuaYpXr0QxtifcceuN6TcyHg4tvH9sQ4b5c2sfU7ngfI2UZl
         f1HQtc6F0Hs7rJt1pjbhT6SzWoMWp4LDB+IswiZiJoe7s76d/eQjiSLhTZlWkwCzbasl
         xnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829405; x=1757434205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1b2HBJLNyTHgHAemvhv7VSSr8vGG9gIZU3t67hKMHJo=;
        b=r42PRn3/Ro6xu/qVS3QFXdH4UVddZV/okUwEBMixiRYLkZG0riMFJsLTUwPY50fp7T
         PQ3Af29p4/UMnRKnRn6QD03mXsrwzbAm1EbcWugq/Yro3sCDpymis9BIQgawjxOLLl2G
         HwGzj40AKtIQGJI92+r5V2bae12vsWeDsRahrdHJ6L9gYj5GAb5EpdaWgk8wZWk8ujhA
         enbemNg+C83EzltYt0XNzOhyPIFGr9Z3V8sYADyS2aGK6i5Cb/x0uwqA56qpbSmdFhAB
         cTmhNBzqqod//Ya9LU4TF1oeVaginkTCDy/fTKiWvxRhgCwsjrbT9boPHXPg3BbzrCxD
         2qLg==
X-Forwarded-Encrypted: i=1; AJvYcCX2QAcQBoxZxH0OC9hGTy6ZlgBEdR6B9oXXBkcRsbB11xxlbw75V3T7sQasMccLnKw53aRrzV6QpoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQDFnNTcLPCe0YElIyQq0TY1oRF9X4r2l47PV70DEsAstBKPJ
	L1vDFpQ93HoedLwFX3vsgBDMQK9bhZ0PLDuO32sDr/FDIbroFqgzPRKEhKYQ+x9Smcg=
X-Gm-Gg: ASbGncvhp/bItXmvNHEjBcqMU5Ky0RJqJf91CgsWeTsVY9OSkUKveboMqaf1dZYxDcX
	RlzE549Aj49St5pZY/+Yd2zgFXpoul4wj45oe6pLCEQzZguCWDHYiGPqNDjHZ6/7EhzNIooulKx
	PKgFfDTKNufhAjjIvKUi7lUNCBx4M4wDh+EXjifHRchlb7yeN3BH81YMcxItvq1uxjLR6hNy9OR
	GwI35b7Oq/rlH2Bm+XFL+eQJV4hWFS+xnIuAUAy9zMaYVvc2UpqD84VxVte1edg1G+DifPkRxxT
	aermDJE6M7OqiMyDs5hddWVrij1A3ZbFxg6+sejeiH1Mo7Y33NNeDkRF2qxu1yPMhLbDXJ5oVX0
	U6GSwFroZSapBY1sF8vkXbhdHaJVvyTayfZ+slvwvjsCrSJa1goRzu0RF6Tt/z2Ozi2Wlv79U
X-Google-Smtp-Source: AGHT+IGCpDnc9d4PjivPmjMidb+t/OFLW+acaBEBwQEHGbDKfC55P2vhw0JnuNYoQRu6pKg0KePVow==
X-Received: by 2002:a05:6870:f626:b0:30b:cd02:297c with SMTP id 586e51a60fabf-319633cc746mr5946257fac.35.1756829405500;
        Tue, 02 Sep 2025 09:10:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b60c5240sm567642fac.32.2025.09.02.09.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:10:05 -0700 (PDT)
Message-ID: <dfcdaf9a-1980-4059-9268-2e9ae96831e8@baylibre.com>
Date: Tue, 2 Sep 2025 11:10:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] Add MAX14001/MAX14002 support
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1756816682.git.marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/25 8:14 AM, Marilene Andrade Garcia wrote:
> Hello everyone,
> 
> Thank you for your input on how to handle the situation with the driver code. 
> Kim, I also apologize for the unexpected situation involving your previous 
> code.
> 
> Based on the suggestions, I applied my v1 code changes to v9 of Kim’s code, 
> resulting in this v10 version that combines both. 
> Compared to v9, the updates are:
> 
> - Added support for max14002.
> - Added a function to write a single register, since the write enable 
> register must be updated before writing to any others and updated again 
> afterward.
> - Renamed the init function to better reflect its purpose, which is to 
> disable the memory verification fault. I also replaced the one-by-one 
> handling of registers verification values with a loop, since they are in 
> sequential ascending order.
> - Replaced the old regulator APIs with the new ones.
> - Updated the device tree documentation to align with the datasheet 
> nomenclature for voltage suppliers.
> - Used IIO_CHAN_INFO_AVERAGE_RAW to return the filtered average of ADC 
> readings.
> 
> One of the reviews I received about my v1 version suggested using a custom 
> regmap. I attempted to implement that, but I feel that most of the default 
> regmap functions (e.g., regmap_update_bits) would need to be overridden 

Usually, you only need to implement one read and one write function for
a custom regmap bus and the core code regmap code will use those for
all of it's function calls. Since you already have a read and write
function, it shouldn't be too hard to adapt them to the regmap bus
callback signatures.

> because of the unique way this device handles communication, such as 
> inverting bits before sending a message, updating the write enable register 
> before writing any other register, and updating it again afterward. However, 
> as I am still new to the IIO kernel code, I may be missing something. If you 
> could provide further explanation or an example, I would be grateful.
> 
> Regarding locking, Kim’s original code implemented it, and it remains in 
> the driver.
> 
> I still have a question about using _mean_raw (IIO_CHAN_INFO_AVERAGE_RAW) 
> to read the register containing the latest filtered average ADC readings. 
> Should I create a v11 version with a patch to include in_voltageY_mean_raw 
> in the file /linux/Documentation/ABI/testing/sysfs-bus-iio? 

There is already "/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw" which
I think is intended to cover that.

> The idea is to use in_voltageY_mean_raw to return the filtered average and 
> also to set how many ADC readings (0, 2, 4, or 8) are included in the mean 
> calculation. Any feedback on using IIO_CHAN_INFO_AVERAGE_RAW this way would 
> be appreciated.
> 
> The v10 changes were tested on a Raspberry Pi 5 using a modified kernel 
> (rpi-6.12). The MAX14001PMB evaluation board, which contains two MAX14001 
> devices, was used for testing. One device measures current, and the other 
> measures voltage. The evaluation board introduces an offset to allow 
> measuring negative values. These board-specific characteristics were not 
> included in the driver code (neither the offset nor the current channel 
> capability), but they were considered in the calculation of the values read 
> by the devices. Should the code that applies these board configuration 
> parameters be added as an additional driver file inside the IIO subsystem, 
> or should it remain only in a user application?

These features are provided by extra analog frontend (AFE) circuitry
so the are outside of the scope of this driver.

There is an iio/afe/iio-rescale.c driver that can be used to handle this
kind of circuitry. It has "current-sense-amplifier" and "current-sense-shunt".
I didn't look at the eval board schematic in detail to see which one is
the right one for this case. There isn't one for the voltage offset case
though. So if you have some extra time, you could consider adding that.

You will need to add #io-cells to the DT bindings for the MAX chips
so that we can connect it in the devcie tree to the frontend.

    amplifier {
        compatible = "current-sense-amplifier";
        io-channels = <&eval_adc_1>;

        sense-resistor-micro-ohms = <?>;
        sense-gain-mult = <?>;
    };

> 
> I plan to continue sending patches to cover all the features of the device. 
> This includes adding interrupt handling for faults and for when the signal 
> exceeds the upper or lower threshold, implementing the inrush current 
> feature, and completing the filtered average reading functionality by 
> adding the ability to set the number of readings used in the mean 
> calculation.
> 
> And I would like to thank again my GSoC mentors Marcelo Schmitt, Ceclan 
> Dumitru, Jonathan Santos and Dragos Bogdan for their help with the code.
> 
> Thank you for your time,
> Best regards,
> Marilene Andrade Garcia.
> 
> Marilene Andrade Garcia (2):
>   dt-bindings: iio: adc: add max14001
>   iio: adc: max14001: New driver
> 
>  .../bindings/iio/adc/adi,max14001.yaml        |  79 ++++
>  MAINTAINERS                                   |   9 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/max14001.c                    | 355 ++++++++++++++++++
>  5 files changed, 454 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
>  create mode 100644 drivers/iio/adc/max14001.c
> 
> 
> base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b


