Return-Path: <linux-iio+bounces-26944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD771CADB5E
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 17:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89323300F712
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3C2D839B;
	Mon,  8 Dec 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YOgOZ+f4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B62D3EF2
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210480; cv=none; b=QPRt5fuDMoQBDXoOdKcfiuEZJNCoyNZB1U7txjryiWgY9CJpvhocs/NAQRdvup7KM/faSVTYVoJeazAYrqKO8vXDa4JwvFBwk1mRZCcWOm9cNxH4XsusTJcfvOhyR+L1LaKQ3WznYehdE4/xskDw5xVCpJnlT/w0/XfZtYPrZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210480; c=relaxed/simple;
	bh=nXy23Bdwi535Yx2EL8Hh3oZzCDTv7/Wa0MPKypdO2Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWfAdOCY8kVfZB3hyOY1lDvLEMf7FtzPdUd4b7XnzCXZMymeNII0Hy7N8OGaEzvs2A3YA4zOt3dSV0HAhlJkcz5jYNdZQgvcKdxonsepyoE1vPsm/heGeaRmzFUIph27H2v+n0oWYfun1GcZFnfJdNC3gHKQfUgrhXvU9so7ZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YOgOZ+f4; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c704bf2d9eso2864446a34.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765210478; x=1765815278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60jz7VvJKPdvGdgnAs8DXOx0sg5E/usMxjrlgYTUYQk=;
        b=YOgOZ+f4BR3m/4kqoulK52zKbyj/1pVtV6540/D7BIlbs9CPYqJKa//oOdZRxIlkG5
         2zBbqZpufS+h+eCb/rNwpgR+ijM3oauM7n27q79khswvmMVn8jrJ1g4ao7fNQPI7qGja
         ZVhPX8OGKqEHLSAzhc3c62ok7bZLBywjHO/JcKjFxK22Ba+yEAY1IOJPTGhW7Ugst9bO
         DH8UFRqYZbce+54310JAtVYKt6X23BJ8/FpZ3OSrM37Qe8amdL3wTLHzVKsWrLl/W+5p
         TMUNwByawsVWkEkretrrMI1X76lKQYCX2FGe3u5Bg76SZOmJdzfapclyHHT21XxgzIm7
         UNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210478; x=1765815278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60jz7VvJKPdvGdgnAs8DXOx0sg5E/usMxjrlgYTUYQk=;
        b=BpmV/kvOmETNCs0v1LK/gMstdajYNUKirPrtNdfKA1SN7MMpjHIZwPAA5rLu7aLmZl
         Jp1P2loU4wg3GPxnek/YkQy7ICorJVbG73BTsJGxsBb98nkD9AHO+M5M5DINCgjkuwQ0
         XhCpo52jr9oJDTFcoCOWCaIrF/zgYnnlJrqCId+GGNshFC/FB0ZlGJqZd0Cddye4qEEA
         LkkACY/UcrES24+fE+ul9lcCjTf8fCldTv4lgBw1IFXJhJ5yRA2QvTL0gQLkcVH5FQyH
         kKayI+sDr1IxquawE7lnNfbn6k3cZqBAU/xMRJCLXSHpYW+kR6jybu/QsxIWqh4UBdpr
         V3ew==
X-Forwarded-Encrypted: i=1; AJvYcCVRYJ/HkFpW/MI3zL6xGlHtHhl+mUoUi8BZSYIBMY6QpHAKNkqbyjsxtzn5Azoj9LFrDJKJqdlFWPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtKCBVMsqMrfcKQahtsTmd4bKQ3nPkOLza7jLaDA3/MjjcsJs
	Ux3Gw+t/lB5aXbyxjZYmLqw3jqid/XrQXXOmPTDZ1igk87ZLJ32nTT1MQreJmwafJno=
X-Gm-Gg: ASbGncuTXKtVTTKH/A5k2Gh8d+2skO25kov8NWlQT1ihpLA2gHWdyQTCuoJg51SjPqm
	OJwRM+VmXwFuOq+DBBe0bYPyOa8PwPIxDGPdTDl6hPXlS0k1ScocU0DvgIki573DWWwC4j1n8nM
	75jnWqCYb0elJZyiFdCf/XLGa7/pFUaU3CTcVUvBbVWJUkqPDFMijZUi/EYNwSkUPeCX4AGYa0Z
	gAPcpBMAxKLmTykmG92ZbkZr11tOyPr+0l1OmsMC+8laoDYv1c0sw6zSbN3LF4jnpd5vdB8BsfO
	X192u3Hh4CzO7TGdSMUzAUO3ntNR0LGI1Bpn0glQ/7hE3p9hFuG2Hry7c11RfHtNnuBPE4wo2MX
	pgeDUfp6BW1+sled3HXbpcOOVx1tQd7e2/Qicp/b5xst59fntzvRwdpzQdFcKpQl2G+q+/12N6r
	3MpdTAJsXlzUd4oxc+oH4S/nFCKDpDhwiIXdX6aYO5tsPjnewTbmROnyN/7gR5
X-Google-Smtp-Source: AGHT+IF2+UF58msdLPJbF7PQNjrhfGMeUdPJGh8VjdYwvDauAVt9b5rfmVUVo9CC6z5nGZ4+Xw1WWg==
X-Received: by 2002:a05:6830:6001:b0:7c7:10ca:bf with SMTP id 46e09a7af769-7c9707510b0mr4668447a34.10.1765210477611;
        Mon, 08 Dec 2025 08:14:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:532a:767c:1f4d:c31a? ([2600:8803:e7e4:500:532a:767c:1f4d:c31a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac85170sm10003530a34.15.2025.12.08.08.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 08:14:36 -0800 (PST)
Message-ID: <b31f9e88-a078-47f4-8d6c-359a0394ef7e@baylibre.com>
Date: Mon, 8 Dec 2025 10:14:36 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes
 property
To: Rob Herring <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
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
 <0cf78f84-01e7-4507-abf9-2f82f98206b2@baylibre.com>
 <221d5ed6-51da-4dce-b8a7-58b4d2423101@baylibre.com>
 <20251206004757.GA980619-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251206004757.GA980619-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/25 6:47 PM, Rob Herring wrote:
> On Fri, Dec 05, 2025 at 05:43:31PM -0600, David Lechner wrote:
>> On 12/5/25 3:33 PM, David Lechner wrote:
>>> On 12/5/25 3:12 PM, Marcelo Schmitt wrote:
>>>> On 12/04, Rob Herring wrote:
>>>>> On Mon, Dec 01, 2025 at 08:20:45PM -0600, David Lechner wrote:
>>>>>> Add data-lanes property to specify the number of data lanes used on the
>>>>>> ad463x chips that support reading two samples at the same time using
>>>>>> two data lanes with a capable SPI controller.
>>>>>>
>>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>>> ---
>>>>>> v3 changes: new patch
>>>>>>
>>>>>> I added this one to give a real-world use case where spi-rx-bus-width
>>>>>> was not sufficient to fully describe the hardware configuration.
>>>>>>
>>>>>> spi-rx-bus-width = <4>; alone could be be interpreted as either:
>>>>>>
>>>>>> +--------------+    +----------+
>>>>>> | SPI          |    | AD4630   |
>>>>>> | Controller   |    | ADC      |
>>>>>> |              |    |          |
>>>>>> |        SDIA0 |<---| SDOA0    |
>>>>>> |        SDIA1 |<---| SDOA1    |
>>>>>> |        SDIA2 |<---| SDOA2    |
>>>>>> |        SDIA3 |<---| SDOA3    |
>>>>>> |              |    |          |
>>>>>> |        SDIB0 |x   | SDOB0    |
>>>>>> |        SDIB1 |x   | SDOB1    |
>>>>>> |        SDIB2 |x   | SDOB2    |
>>>>>> |        SDIB3 |x   | SDOB3    |
>>>>>> |              |    |          |
>>>>>> +--------------+     +---------+
>>>>>>
>>>>>> or
>>>>>>
>>>>>> +--------------+    +----------+
>>>>>> | SPI          |    | AD4630   |
>>>>>> | Controller   |    | ADC      |
>>>>>> |              |    |          |
>>>>>> |        SDIA0 |<---| SDOA0    |
>>>>>> |        SDIA1 |<---| SDOA1    |
>>>>>> |        SDIA2 |x   | SDOA2    |
>>>>>> |        SDIA3 |x   | SDOA3    |
>>>>>> |              |    |          |
>>>>>> |        SDIB0 |<---| SDOB0    |
>>>>>> |        SDIB1 |<---| SDOB1    |
>>>>>> |        SDIB2 |x   | SDOB2    |
>>>>>> |        SDIB3 |x   | SDOB3    |
>>>>>> |              |    |          |
>>>>>> +--------------+     +---------+
>>>>>>
>>>>>> Now, with data-lanes having a default value of [0] (inherited from
>>>>>> spi-peripheral-props.yaml), specifying:
>>>>>>
>>>>>>     spi-rx-bus-width = <4>;
>>>>>>
>>>>>> is unambiguously the first case and the example given in the binding
>>>>>> documentation is the second case:
>>>>>>
>>>>>>     spi-rx-bus-width = <2>;
>>>>>>     data-lanes = <0>, <1>;
>>>>>
>>>>> I just reviewed this and all, but what if you just did:
>>>>>
>>>>> spi-rx-bus-width = <2>, <2>;
>>>>>
>>>>> So *-bus-width becomes equal to the number of serializers/channels.
>>>>
>>>> Unless I'm missing something, I think that would also describe the currently
>>>> possible use cases as well. To me, it actually seems even more accurate than
>>>> data-lanes. The data-lanes property only describes the SPI controller input
>>>> lines/lanes, no info is given about the output lanes.
>>>
>>> It describes both directions.
>>>
>>>> Well yeah, that would only> be a problem for a device with multiple input serializers and multiple output
>>>> serializers. Still, the *-bus-width = <N>, <N>, ... <N>; notation looks clearer,
>>>> IMHO.
>>>>
>>>>>
>>>>> Rob
>>>>>
>>>
>>> It think it complicates Sean's use case though where such
>>> a controller is being used as basically two separate SPI
>>> buses.
>>>
>>> For that case, we want to be able to do:
>>>
>>> spi {
>>> 	...
>>>
>>> 	thing@0 {
>>> 		compatible = ...;
>>> 		reg = <0>;
>>> 		/* (implicit) data-lanes = <0>; */
>>> 	};
>>>
>>> 	thing@1 {
>>> 		compatible = ...;
>>> 		reg = <1>;
>>> 		data-lanes = <1>;
>>> 	};
>>> };
>>>
>>> Meaning:
>>>
>>> +--------------+    +----------+
>>> | SPI          |    | Thing 1  |
>>> | Controller   |    |          |
>>> |              |    |          |
>>> |          CS0 |--->| CS       |
>>> |         SDI0 |<---| SDO      |
>>> |         SDO0 |--->| SDI      |
>>> |        SCLK0 |--->| SCLK     |
>>> |              |    |          |
>>> |              |    +----------+
>>> |              |                
>>> |              |    +----------+
>>> |              |    | Thing 2  |
>>> |              |    |          |
>>> |          CS1 |--->| CS       |
>>> |         SDI1 |<---| SDO      |
>>> |         SDO1 |--->| SDI      |
>>> |        SCLK1 |--->| SCLK     |
>>> |              |    |          |
>>> +--------------+    +----------+
>>>
>>> (I don't remember if SCLKs are shared or separate, but I don't
>>> think that is relevant anyway).
>>>
>>>
>>> I guess we could write it like this?
>>>
>>> spi {
>>> 	...
>>>
>>> 	thing@0 {
>>> 		compatible = ...;
>>> 		reg = <0>;
>>> 	};
>>>
>>> 	thing@1 {
>>> 		compatible = ...;
>>> 		reg = <1>;
>>> 		spi-tx-bus-width = <0>, <1>;
>>> 		spi-rx-bus-width = <0>, <1>;
>>> 	};
>>> };
> 
> I forget the details on that, but just looking at the above I think 
> something like that should have 2 SPI bus nodes under the controller. 
> Unless CS0 and CS1 can't be asserted at the same time and they aren't 
> really independent.

It is the case that they aren't really independent. Only one "bus"
can operate at a time.

> 
> But would be good to wait for Sean's comments here.
> 
>>
>> I started down this road. Before I do the working of changing the
>> whole series, this is what it will probably look like. Is this really
>> what we want?
>>
>> There is one issue I see with this. If we allow <0> to mean that a lane
>> isn't wired up on the controller, then we can't constrain the length of
>> the array in peripheral bindings. For example, the ad403x chips can only
>> have one lane and the ad463x chips can have one or two lanes. But I
>> don't see a way to express that in the binding if <0> at any index
>> doesn't count towards the number of lanes that are actually wired up.
> 
> That's fine I think. How many entries is primarily a controller 
> property. We set the length in the controller binding. The device just 
> sets the maximum width per channel.
> 
>>
>> This is e.g. why the binding in sitronix,st7789v.yaml is
>>
>> 	items:
>> 	  enum: [0, 1]
>>
>> rather than
>>
>> 	items:
>> 	  - enum: [0, 1]
>>
>> ---
>> commit 049b9508b1b0190f87a4b35fe3ed8a9f3d0d3c50
>> Author: David Lechner <dlechner@baylibre.com>
>> Date:   Fri Dec 5 16:09:08 2025 -0600
>>
>>     spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
>>     
>>     Change spi-rx-bus-width and spi-tx-bus-width properties from single
>>     uint32 values to arrays of uint32 values. This allows describing SPI
>>     peripherals connected to controllers that have multiple data lanes for
>>     receiving or transmitting two or more words at the same time.
>>     
>>     Bindings that make use of this property are updated in the same commit
>>     to avoid validation errors. Bindings that used minimum/maximum are
>>     changed to use enum instead to be consistent with the base property
>>     definition.
>>     
>>     The adi,ad4030 binding has an example added now that we can fully
>>     describe the peripheral's capabilities.
>>     
>>     Converting from single uint32 to array of uint32 does not break .dts/
>>     .dtb files since there is no difference between specifying a single
>>     uint32 value and an array with a single uint32 value in devicetree.
>>     
>>     Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---   
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
>> index 0ce2ea13583d..23b33dcd5ed4 100644
>> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
>> @@ -34,8 +34,8 @@ properties:
>>    spi-cpol: true
>>  
>>    spi-rx-bus-width:
>> -    minimum: 0
>> -    maximum: 1
>> +    items:
>> +      enum: [0, 1]
>>  
>>    dc-gpios:
>>      maxItems: 1
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
>> index 54e7349317b7..6052a44b04de 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
>> @@ -37,7 +37,8 @@ properties:
>>      maximum: 102040816
>>  
>>    spi-rx-bus-width:
>> -    enum: [1, 2, 4]
>> +    items:
>> +      enum: [1, 2, 4]
> 
> We'd need to allow 0 here, right?

To avoid binding check failures, yes, I suppose so. All of the
`const: 1` would need to be changed to `enum: [0, 1]` as well.

Although since the controller also could have limitations maybe
we should have the controller use `enum` and have the peripheral
use `maximum`?

Then, if we have a controller with:

patternProperties:
  "@[0-9a-f]+$":
      # controller has 2 lanes with 2 lines per lane
      spi-rx-bus-width:
	maxItems: 2
        items:
          enum: [0, 1, 2]

And a peripheral with:

properties:
  spi-rx-bus-width:
    items:
      maximum: 4

The controller limit would be in effect and cause a binding check error
if attempting to use bus width of 4.

But if the controller was enum: [0, 1, 2, 4, 8], then the peripheral
maximum would be the limiting factor if attempting to use bus width of 8.

> 
> What we really want to say is there is exactly 1 entry of 1, 2, or 4. I

Not sure this is what we want. For the ADC cases, we want 2 or 4 items
in the array to be the same value.
 
> can't think of a concise way to say that. The closest is something like 
> this:
> 
> uniqueItems: true
> items:
>   enum: [0, 1, 2, 4]
> contains:
>   enum: [1, 2, 4]
> 
> That implicitly limits the length to 4, but does allow [0, 1, 2, 4] and 
> other ordering. More generally, if the device supports fewer channels 
> than the host, then we can't constrain that. Oh well, we can't check 
> everything (we hardly check values within reg, interrupts, clocks, and 
> on and on). But most controllers are going to limit the length to 1 
> entry, so it should end up with the same constraints most of the time.
> 
> Are these updates all of them or just a sampling.

This is everything currently in linux-next.

> If the latter and 
> there's a lot more, then we may want to split spi-controller.yaml into 
> 2 (3 really with a common part). Make spi-controller.yaml define single 
> channel SPI controllers which keeps the length of spi-[rt]x-bus-width at 
> 1 entry and then define a spi-multi-chan-controller.yaml which doesn't 
> constrain it. 
> 
> Rob


