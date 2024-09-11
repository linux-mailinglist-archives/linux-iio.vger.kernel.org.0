Return-Path: <linux-iio+bounces-9442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B70C974D02
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 10:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04411C24D25
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31252F9E;
	Wed, 11 Sep 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oVxEF3mn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C331537C9
	for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044406; cv=none; b=YeClggDpx6lHLsyv6Zp6afaLZJI03BDijdiU9Y+DLqY+Ikc0nyUs005Uy/8JLYJYHy7vVIODTLtPrW3EQo3pPraUHp1xrbHlXzrFimXxyLSlMdYElS9yr+misDIj/9AykzjX29OWJzcPmFZj9glBJyykFXKcFA/PjO0L33uR434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044406; c=relaxed/simple;
	bh=VsJ9AHTmARvYlzSXySTeo7ymug5ss/CGxuO45BanAJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnbVqzXs7+z1ScTtfVo5YLRhvWUYl0qzppAzI9kciRdVLpMxdOHqG5JhTkpp8zqLmUwHbbpsI0D56EUnwIe1dyvs37oMmcggfaa8VifAoqkpFVxq2soDNsZzuh+H0uvWpJjj0mL6m85YFaSzBoawOQGfLnpH1nJbNKzdhUFB2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oVxEF3mn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c7d14191so387574f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2024 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726044401; x=1726649201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eQgNaVzjnox2dQ7aNQ/KQoNn0cQNVbxER3t17wy2HM=;
        b=oVxEF3mnDVOr42N2WsSf49jm/6cKclAN1wEgxoeLHrFJLMKVmv5SlA1jecjt7+tofC
         KwAatPxw/Bmn/jw8Z5JqoKjD33ROgFEMSqGauZFcCr7hRrCvMSuS4s0rJoh7yWFLhLZg
         SetHm6xGaZ2eE+cNSgp/ym60scDd0ySF4wNFfSSB3aR0TQzBn28VhXM1LwS/jJb7eur2
         jqqI2KPPyG85Ae/n1wjM6lsXzzhAzjWaT2Q7DGHdxGvMIf6fsNkV8TY5oUs4RI09kknm
         SDjsvCMSlcuTTola2fHxJ2gcRhDK4GHDBpaYwcqcQIDhLEjURJ9EhUsiZFZnanzlSsdd
         JS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044401; x=1726649201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eQgNaVzjnox2dQ7aNQ/KQoNn0cQNVbxER3t17wy2HM=;
        b=AMWtsww9pgp3XWVGtlO23eDUguy0Xbp0B8P5tEggrN4C3h3iq+DTVW3sUcN8vkdAZY
         BmfYWnjh6OZz42dcT2GqPsuh8KEkGNZ5LEitPvYF5Cm1pzReA4/ODsF7/JxTHT9FYjXB
         krabAiRejj3J4GLuVfo3pa1uAlnOZuw9oRpINX8/Hf2sw/vVy/Wjg+1Qhz5v0QgiUNVJ
         NkzL1qu7JIWgE/SQws7PDbj5zUvTvG9s/kncLrdAlDpXCXWQu6jDN87GI6OqfVhPVs9V
         H+wVXw2Z3cDZ6AGxS5wGSnBQjts0fUgS55mCPLSO7uWCQOiodMcZMcEfM5bROr15zPyn
         bUOA==
X-Forwarded-Encrypted: i=1; AJvYcCVzZxdX6BKFBrWLpDHaXwnQ7cBqN4K9IjBx+ghiw5TE5FLOqwk4segCUbB3/5MwaJOlEKghOktmMAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdnhVyxviOyvu8SpzRgJxZfWBu8IQC93kUVoIo/lZICF4QNew
	xjrqL70ZWfKGPO9H58gOmj42MwXD85FWPYuydw/s/Fsdp2GDuBmMgvqQDJlKs5Q=
X-Google-Smtp-Source: AGHT+IGeeBURNIMwTcUQkDjdbYySnc2dsPBnkxWzH4v5PoGgCqR3Ffw7WTvhM/YEBSafmRXnqy4+dw==
X-Received: by 2002:a5d:4ec9:0:b0:374:c4c2:5ad5 with SMTP id ffacd0b85a97d-378a8a792fcmr3709547f8f.27.1726044400255;
        Wed, 11 Sep 2024 01:46:40 -0700 (PDT)
Received: from [192.168.0.2] (host-79-54-235-146.retail.telecomitalia.it. [79.54.235.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789556aa7dsm11278134f8f.0.2024.09.11.01.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 01:46:39 -0700 (PDT)
Message-ID: <a30d4887-c118-4997-8e84-4a269b58b371@baylibre.com>
Date: Wed, 11 Sep 2024 10:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
 <20240908132925.331c5175@jic23-huawei>
 <20240909-dwelled-specimen-949f44c8d04d@wendy>
 <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>
 <66090d3e-bf6c-43ee-9dc8-7bca449d448f@baylibre.com>
 <f54646877c2a68d01e15db31ae21224053f87439.camel@gmail.com>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <f54646877c2a68d01e15db31ae21224053f87439.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/09/24 10:16 AM, Nuno Sá wrote:
> On Mon, 2024-09-09 at 12:19 -0500, David Lechner wrote:
>> On 9/9/24 9:03 AM, Nuno Sá wrote:
>>> On Mon, 2024-09-09 at 13:46 +0100, Conor Dooley wrote:
>>>> On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:
>>>>> On Thu, 05 Sep 2024 17:17:31 +0200
>>>>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>>>>
>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>
>>>>>> There is a version AXI DAC IP block (for FPGAs) that provides
>>>>>> a physical bus for AD3552R and similar chips. This can be used
>>>>>> instead of a typical SPI controller to be able to use the chip
>>>>>> in ways that typical SPI controllers are not capable of.
>>>>>>
>>>>>> The binding is modified so that either the device is a SPI
>>>>>> peripheral or it uses an io-backend.
>>>>>>
>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>   
>>>>>>   required:
>>>>>>     - compatible
>>>>>> -  - reg
>>>>>> -  - spi-max-frequency
>>>>> Sort of feels like both reg and spi-max-frequency
>>>>> are valid things to specify.
>>>>>
>>>>> Maybe we have an excellent IP and dodgy wiring so want
>>>>> to clamp the frequency (long term - don't need to support
>>>>> in the driver today).
>>>>>
>>>>> Maybe we have an axi_dac IP that supports multiple
>>>>> front end devices?  So maybe just keep reg?
>>>> I'd like to be convinced that this incarnation of the AXI DAC IP is not
>>>> a spi controller and that a ref to spi-controller.yaml is not out of
>>>> place here. It may not be something that you'd ever use generally, given
>>>> the "weird" interface to it, but it does seem to be one regardless.
>>>>
>>> Agreed.. As weird as it get's, it's acting as a spi controller.
>>>
>>>> I'd also really like to know how this fits in with spi-offloads. It
>>>> /feels/, and I'd like to reiterate the word feels, like a rather similar
>>>> idea just applied to a DAC instead of an ADC.
>>> The offload main principle is to replay a spi transfer periodically given an
>>> input trigger. I'm not so sure we have that same principle in here. In here
>>> I
>>> guess we stream data over the qspi interface based on SCLK which can look
>>> similar. The difference is that this IP does not need any trigger for any
>>> spi
>>> transfer replay (I think).
>>>
>> Looking at the AD3552R from a SPI offload perspective of triggered SPI
>> messages, I think it still works.
>>
>> The trigger doesn't have to be a clock/PWM. In this case, the trigger would
>> be whenever the IIO buffer is full and ready to send a burst of data (not
>> sure if this would be a hardware or software trigger - but it works either
>> way).
>>
> Right... That's what we already have for DACs with HW buffering.
>
>> Also, the DAC_CUSTOM_CTRL::ADDRESS register field in the AXI DAC IP core
>> acts as an offload to record and play back a SPI write transfer.
>>
>> If we were using the AXI SPI Engine, this would be one SPI message with
>> two xfers, one for the address write followed by one for the data write.
> Just a nipick comment. At least from the current implementation the address is
> only writen once before starting to stream. So I guess we would not want to
> replay that xfer for every sample.
>
>> The size of the data write would be the size of the IIO buffer - or in
>> the case of a cyclic DMA, the size of the write data would be channel
>> data size * num channels and the xfer would have a special cyclic offload
>> flag set.
>>
>> So I think we could make a single binding that works for the the AXI DAC
>> backend/offload and the AXI SPI Engine offload. (I don't think it would
>> be so easy to integrate the AXI DAC into the SPI framework on the driver
>> side - and hopefully we won't have to, but the DT still could use the
>> proposed SPI offload bindings.)
>>
> Hopefully not...

As of now, i am proposing to stay in the simpler node as possible for the
current case, like:


     axi_dac: spi@44a70000 {
         compatible = "adi,axi-ad3552r";
         reg = <0x44a70000 0x1000>;
         dmas = <&dac_tx_dma 0>;
         dma-names = "tx";
         #io-backend-cells = <0>;
         clocks = <&ref_clk>;

         #address-cells = <1>;
         #size-cells = <0>;

         dac@0 {
             reg = <0>;
             compatible = "adi,ad3552r";
             reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
             io-backends = <&axi_dac>;

             #address-cells = <1>;
             #size-cells = <0>;

             channel@0 {
                 reg = <0>;
                 adi,output-range-microvolt = <(-10000000) (10000000)>;
             };
         };
     };


and extend things later on, in case.
SPI lines and other info are all obtained from the compatible.

What do you think ?


>
> - Nuno Sá

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


