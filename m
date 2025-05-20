Return-Path: <linux-iio+bounces-19725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFBABCF7D
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 08:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697E717DC2E
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832A25D1E3;
	Tue, 20 May 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvT6na5Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091F25D1E1;
	Tue, 20 May 2025 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722985; cv=none; b=YPBGfO0ZOPeTlxyOWMthHaSU7NTFVrAlrpSKG5UhDUg2FCINsAelTau9c4jIEUW3qI/f6kJj4qfsKmr1mo10F/1ymy4j61LeD5+U+2xl1gtXnR0c5c1xaJiZyAibWHwITfq3I+XAk4kYfgduZNpv5Z9Hclu5oDtAK9/l2mrsn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722985; c=relaxed/simple;
	bh=lwvr/JhuXS8kDgUe+4nM5sElfmlxS4kkUG7fRk1l+Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2Za3B5b3KuGyWhOMZNeXZ1XCgjHVtAnQtmqwx5c6EF3IdnkuUxiW/uSBgEtQyfTiKXMtCQeJylOqjV6LAyU9ETe8f6i4Yw9ikTmzC1jpB/9aqQQJHqOI3WdqLNBPCcvpLgM3g0eQpcTdwyDVDltwPc15YRS5NxuzMDEGL65/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvT6na5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF828C4CEE9;
	Tue, 20 May 2025 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747722985;
	bh=lwvr/JhuXS8kDgUe+4nM5sElfmlxS4kkUG7fRk1l+Sg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tvT6na5YRKQ+QffnS07tx1Pnvr3XS3xn1xYfb5btT9HRtHBxtsiezWuI2Kz26Q39a
	 aqWRw5i8/IWFciAt3//kTXH+ibPcshwSoKzutWeUvZYraiEafYw+Mif+kWIQQiNEnH
	 XHKGp49s60aX29NePKOOrv2oLm0BsCesJ33AHZ9woprDs7v0jfgWGfIRRxV9I3J2PW
	 aCYDnmK8cKmuWw8Mqu4hR+gw22hNcPUI1CpMTbE5UdzkvtBO5zJs2/ASXFKlD6fEk5
	 J5bVd0waoS/Xh/i0ZAcOtzKQlyb4IAZh4f570AAKC/2Y3OrjKZ2RnurB2rkdX5tbpy
	 ViRwdkblnSfmA==
Message-ID: <98bd3e50-c379-4229-bdb0-ee4ff491c451@kernel.org>
Date: Tue, 20 May 2025 08:36:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR
 sensor
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c57675d505e93549bfca5f9909d67822ab304a44.1746802541.git.waqar.hameed@axis.com>
 <02b0dbc2-e8fd-419a-b546-5910b3fd0e0c@kernel.org> <pndtt5kiij9.fsf@axis.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <pndtt5kiij9.fsf@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 19:15, Waqar Hameed wrote:
> On Fri, May 09, 2025 at 17:06 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 09/05/2025 17:03, Waqar Hameed wrote:
>>> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
>>> raw data measurements and detection notification. The communication
>>> protocol is custom made and therefore needs to be GPIO bit banged.
>>>
>>> Add devicetree bindings requiring the compatible string and the various
>>> GPIOs needed for operation. Some of the GPIOs have multiple use-cases
>>> depending on device state. Describe these thoroughly.
>>
>>
>> Drop redundant parts of description. Describe the hardware. 
> 
> I'll reformulate and incorporate some information of the pins and how it
> is used in the hardware.
> 
>> Entire last paragraph is pretty pointless.
> 
> I'll remove it then. (Some sub-system maintainers want a description of
> what the patch does, in imperative form. But I can see why it might not
> add any value when it comes to dt-bindings.)
> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nicera,d3323aa
>>> +
>>> +  vdd-gpio:
>>> +    maxItems: 1
>>> +    description:
>>> +      GPIO for supply voltage (1.8 to 5.5 V).
>>
>> This is not how pins are represented in the kernel. Either you have here
>> regulator (supply) or reset gpios. 
> 
> I'll change it to `vdd-supply`.
> 
>> Plus 'gpio' suffix is not valid, btw.
> 
> I actually `grep`ed before writing this to see if there were other
> dt-bindings with this suffix. Because the GPIO framework supports both
> `gpio` and `gpios` as suffixes (see `gpio_suffixes[]` in `gpiolib.c`).
> However, since `-gpios` are clearly in majority, we should go for that.


One is deprecated. It is always, always gpios.

> 
> [...]
> 
>>> +      This GPIO will be driven low by the driver in order to cut the supply and
>>> +      reset the device (driving it then back to high to power it on).
>>> +
>>> +  clk-vout-gpio:
>>
>> No, for the similar reasons. Which pin is this?
> 
> This pin is a little weird actually. As described below, right after
> power on, it is used as an interrupt to signal "ready for
> configuration". Then, it used as a bit banged clock signal for
> configuration. Finally, it is back as interrupt pin for threshold PIR
> sensor detections.
> 
> So, I'm not really sure what to call this (just opted for what it's
> called in the data sheet: "Vout (CLK)"). Just `clk-gpios` wouldn't be
> correct either, right? Should we prefix it with the vendor `nicera,`? Or
> any other suggestions?

Call it by the name of pin, so vout-clk-gpios. I guess from SoC/CPU side
this cannot be anything else than GPIO.

> 
>>
>>> +    maxItems: 1
>>> +    description:
>>> +      GPIO for clock and detection.
>>> +      After reset, the device signals with two falling edges on this pin that it
>>> +      is ready for configuration (within 1.2 s), which the driver listens for as
>>> +      interrupts.
>>> +      During configuration, it is used as clock for data reading and writing (on
>>> +      data-gpio). The driver drives this pin with the frequency of 1 kHz (bit
>>> +      banging).
>>> +      After all this, the device is now in operational mode and signals on this
>>> +      pin for any detections. The driver listens for this as interrupts.
>>> +
>>> +  data-gpio:
>>
>> There is no such pin.
> 
> You mean to change it to `data-gpios`? (There are some using that, e.g.
> `sensirion,sht15.yaml`).

No, I meant I opened datasheet and found no such pin. Unless you meant
DO, but then mention in description the actual name of the pin, if you
are using some more descriptive property name for it.

> 
>>
>>> +    maxItems: 1
>>> +    description:
>>> +      GPIO for data reading and writing.
>>> +      During configuration, configuration data will be written and read back
>>> +      with bit banging (together with clk-vout-gpio as clock).
>>> +      After this, during operational mode, the device will output serial data on
>>> +      this GPIO. However, the driver currently doesn't read this.

BTW, drop all references to driver here and in other places. If driver
change, you will change binding? If my driver behaves differently, why
binding would be claiming something else?


Best regards,
Krzysztof

