Return-Path: <linux-iio+bounces-9405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6582E972133
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 19:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A81C23C40
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6118A922;
	Mon,  9 Sep 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ampqhYo5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFA18A6B1
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903494; cv=none; b=P2bJy5Npo6uqUyLRsdhWlPKSnlZgkFcPdYdCy5qQcu8sU+04ygBzrD+7iowAVp8WQtUxzMpwkt/xjY0qKbs00tU8YJH8GordlBXDyU5ST/3PFJyHhUSbqjJuqaI+WvQEriNLaTyGLaE0Fhkh1X8dxaGPMNBVts+jjbEsgrTF9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903494; c=relaxed/simple;
	bh=WbWWVfRpGuhjamU1qUKt81WyI8s0sfQnhEh8cj7og34=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GUCrQbnzupXKBvy5yDryI9MWbRqaLkzardC5W29so5pFpXKTjCi87qi+fnvD2XhFQETc1oXX24DG88sMh/ZHAmv6RLGPjn/s/+9i30t8ehge2hQKX0NM4MNxyGs5lzTyygY2aWCTkiBgIe2q+YDrV7jgpnGiDZmC28Jh+GLASeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ampqhYo5; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5f24d9df8so2624630eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2024 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725903490; x=1726508290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGQ69uvIsUs2suBhED3lxyPOvEHdFXoc0/H/gcmAqkI=;
        b=ampqhYo5HvIIkeA2jVsD3FSVxYg9xfUTRDoInQIfFe5KePhX6MsjUH5QsL6OSx3f8y
         xlrvPM3zcirlGfSBnnhkqOUWo5Sopac8FUkP2mEETum4uO5mPrihPK+dSr7lAQJFMpIt
         NUkKrA6hjYUzjz8//U+Xuvv/6SWVAhp4I0hl+TTDTt3eralbfnX0oF4JKpxD2ey3oKPU
         HWooeLjyDTEiB859q/XOC2m35qkCLvSB2gXVr9+5uW05w6+rYLckHfk8h6I9hEsg9rvS
         sgZuPk14U89qxsNdzIxUwEo1Zjfa9lOHQJMAJTGogqH9iQePTgaw2MhCDhWwAUQdBaaR
         nx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903490; x=1726508290;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGQ69uvIsUs2suBhED3lxyPOvEHdFXoc0/H/gcmAqkI=;
        b=oqdTVxIWZ2b0/8pGN5ve4hUGjc7xcrtjGEb6AyGM87aXoZKZ8RZFhkoHxggnKpOXKp
         /N3I6hZY4+UgEx5xXZD7s2SNYwJjm6uF2SKyJgh6j2WLsJes1zheie11s2DHTHkPLCBz
         8zWN88j7laGMEG99ZA7LSkNd2RTeo1gL8PME/eE3EA8tJ2Q+RoShGGyHAfqo6NND4TtV
         PclLTVr/JKNyxQPHqmn84oJoqTGF9kJ5rJrS6nT98REWix0GedqSrvu69aovEpvO1l3W
         4V1mHeerSRJYZRBlWGx1El1DKersNChhMlchDdl8/E2tp5uxi3giN2NtS1y/5oBdqExC
         6gYg==
X-Forwarded-Encrypted: i=1; AJvYcCU6z6YKX7uD+fTVK55G1kkvLrNIDvh8tCbWNHK/274fZoc23jvWW1WuE1QEHcYlgNuGyqsHZccbYpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEg/udGUQ2a8jBUqiMJMTnhxgd1KuGXuuUFCK++GH8NgzWpbO
	TtT5RaHqj2om2KZXtouNyFDyTWhCKarQ2wwakhSQR099Q7Gg9vU8zLYkyCGaEiY=
X-Google-Smtp-Source: AGHT+IH/WyRKaYOd8X7b6GH/oF12KinaObeDKCQ9HSr3LpS/BoxdEXxo17+jW8sJ1n5TGyUfLl8pow==
X-Received: by 2002:a05:6870:af47:b0:27b:5abb:7def with SMTP id 586e51a60fabf-27b82e11008mr11946198fac.20.1725903490312;
        Mon, 09 Sep 2024 10:38:10 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba40b0d70sm1566578fac.44.2024.09.09.10.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 10:38:09 -0700 (PDT)
Message-ID: <e5310b63-9dc4-43af-9fbe-0cc3b604ab8b@baylibre.com>
Date: Mon, 9 Sep 2024 12:38:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
From: David Lechner <dlechner@baylibre.com>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
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
Content-Language: en-US
In-Reply-To: <66090d3e-bf6c-43ee-9dc8-7bca449d448f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/24 12:19 PM, David Lechner wrote:
> On 9/9/24 9:03 AM, Nuno Sá wrote:
>> On Mon, 2024-09-09 at 13:46 +0100, Conor Dooley wrote:
>>> On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:
>>>> On Thu, 05 Sep 2024 17:17:31 +0200
>>>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>>>
>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>
>>>>> There is a version AXI DAC IP block (for FPGAs) that provides
>>>>> a physical bus for AD3552R and similar chips. This can be used
>>>>> instead of a typical SPI controller to be able to use the chip
>>>>> in ways that typical SPI controllers are not capable of.
>>>>>
>>>>> The binding is modified so that either the device is a SPI
>>>>> peripheral or it uses an io-backend.
>>>>>
>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>>>  
>>>>>  required:
>>>>>    - compatible
>>>>> -  - reg
>>>>> -  - spi-max-frequency
>>>> Sort of feels like both reg and spi-max-frequency
>>>> are valid things to specify. 
>>>>
>>>> Maybe we have an excellent IP and dodgy wiring so want
>>>> to clamp the frequency (long term - don't need to support
>>>> in the driver today).
>>>>
>>>> Maybe we have an axi_dac IP that supports multiple
>>>> front end devices?  So maybe just keep reg?
>>>
>>> I'd like to be convinced that this incarnation of the AXI DAC IP is not
>>> a spi controller and that a ref to spi-controller.yaml is not out of
>>> place here. It may not be something that you'd ever use generally, given
>>> the "weird" interface to it, but it does seem to be one regardless.
>>>
>>
>> Agreed.. As weird as it get's, it's acting as a spi controller.
>>
>>> I'd also really like to know how this fits in with spi-offloads. It
>>> /feels/, and I'd like to reiterate the word feels, like a rather similar
>>> idea just applied to a DAC instead of an ADC.
>>
>> The offload main principle is to replay a spi transfer periodically given an
>> input trigger. I'm not so sure we have that same principle in here. In here I
>> guess we stream data over the qspi interface based on SCLK which can look
>> similar. The difference is that this IP does not need any trigger for any spi
>> transfer replay (I think). 
>>
> 
> Looking at the AD3552R from a SPI offload perspective of triggered SPI
> messages, I think it still works.
> 
> The trigger doesn't have to be a clock/PWM. In this case, the trigger would
> be whenever the IIO buffer is full and ready to send a burst of data (not
> sure if this would be a hardware or software trigger - but it works either
> way).
> 
> Also, the DAC_CUSTOM_CTRL::ADDRESS register field in the AXI DAC IP core
> acts as an offload to record and play back a SPI write transfer.
> 
> If we were using the AXI SPI Engine, this would be one SPI message with
> two xfers, one for the address write followed by one for the data write.
> The size of the data write would be the size of the IIO buffer - or in
> the case of a cyclic DMA, the size of the write data would be channel
> data size * num channels and the xfer would have a special cyclic offload
> flag set.
> 
> So I think we could make a single binding that works for the the AXI DAC
> backend/offload and the AXI SPI Engine offload. (I don't think it would
> be so easy to integrate the AXI DAC into the SPI framework on the driver
> side - and hopefully we won't have to, but the DT still could use the
> proposed SPI offload bindings.)
> 
>     axi_dac: spi@44a70000 {
>         compatible = "adi,axi-ad3225r";
>         reg = <0x44a70000 0x1000>;
>         dmas = <&dac_tx_dma_1 0>;
>         dma-names = "tx";
>         clocks = <&ref_clk>;
>         #spi-offload-cells = <0>;

One thing I forgot...

The AXI AD3552R IP core can be wired up as a loopback to pipe
data directly from some ADC instead of using DMA.

In the case of the ADC loopback, we would also have

	io-channels = <&adc1>, <&adc2>;

here in the controller.

And we would need #spi-offload-cell = <1>; to have a cell to
specify the data source.

> 
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         dac@0 {
>             compatible = "adi,ad3552r";
>             reg = <0>;
> 
>             spi-max-frequency = <30000000>;
>             spi-3-wire;
>             spi-tx-bus-width = <4>;
>             spi-rx-bus-width = <4>;
> 
>             reset-gpios = <&gpio0 92 GPIO_ACTIVE_LOW>;
>             spi-offloads = <&axi_dac>;

And then here I guess it would be:

	spi-offloads = <&axi_dac 0>, <&axi_dac 1>;
	spi-offload-names = "dma", "adc";

where 0 would select the DMA stream and 1 would select the ADC stream.

Or of the ADC part wasn't wired up, just:

	spi-offloads = <&axi_dac 0>;
	spi-offload-names = "dma";


> 
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             channel@0 {
>                 reg = <0>;
>                 adi,output-range-microvolt = <(-10000000) (10000000)>;
>             };
>         };
>     };
> 
>     axi_spi_engine: spi@44a80000 {
>         compatible = "adi,axi-spi-engine-1.00.a";
>         reg = <0x44a80000 0x1000>;
>         dmas = <&dac_tx_dma_2 0>;
>         dma-names = "offload0-tx";
>         clocks = <&ref_clk>;
>         #spi-offload-cells = <1>;
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         dac@0 {
>             compatible = "adi,ad3552r";
>             reg = <0>;
> 
>             spi-max-frequency = <30000000>;
>             spi-3-wire;
>             spi-tx-bus-width = <4>;
>             spi-rx-bus-width = <4>;
> 
>             reset-gpios = <&gpio0 92 GPIO_ACTIVE_LOW>;
>             spi-offloads = <&axi_spi_engine 0>;
> 
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             channel@0 {
>                 reg = <0>;
>                 adi,output-range-microvolt = <(-10000000) (10000000)>;
>             };
>         };
>     };
> 


