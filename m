Return-Path: <linux-iio+bounces-22541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5AB2014E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A539A189E4ED
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C32DBF51;
	Mon, 11 Aug 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFl7uuKH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAB204863;
	Mon, 11 Aug 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899549; cv=none; b=MfXbD+reQnxNHM8wECgwIIAcrv3q1ZPl/KPcn6dqDv2hjx1niZbXD8l8nB4zs2sfOFrJvAnOq8tbwsGXQ+3Xah1RteAYsxWV2IawcLUWuG2YhsJa+WYTBvdJ0H+ZCXMdrVJz5O9kn4KGYvjT+wqsuSeVIY/FXI4F30XsUxFoT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899549; c=relaxed/simple;
	bh=4uTNPfkVS5zLEnq7NQb8aRygOSI+7Ca7zKwbd+fJKS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3UzaeLgGDKzXBrARGuMWpIY0TPBX3V3qnJljw1I5/e3GQ+IlASCgoZknBwf5l0oKenllJvCh4SOlrtm0X85ls16IaTgs62UZBsk1Nt2iM1oXMp9EDHbBamKjZGfVOjcgRkUDML7+8T1HGqc4PVn0rqCeLuVNwqW4xkWu/dGJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFl7uuKH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-332464a08b8so29369131fa.1;
        Mon, 11 Aug 2025 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899545; x=1755504345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eW6y+UNOvvAMVQOqHdBQUNKwdtVuFl7txNft8++BOc=;
        b=JFl7uuKHkRr9dbfQAwP5DWbsiXxbjpgHx+vexXM6pj2yGEWyMm4x3xTGvtR4LARhKm
         kGBfyfdDRXs10ufyfC+vAz9vFYfswdxt1OOXgz81vIbNToKSCenVKrvAcCw6cf3tssvs
         +uEl3LiwkdUxMSgWr0dLXi7nQ+UANSec9XpjaJu6ekn8dkboLWTDKNy7zYOKaTXLhKhq
         Zt11UfzIzynv4mPMS0grvPiz1mxCeHfLnSuJgoh+OhvYgurAZrD6skodQOec+W7AOxnQ
         ZM06QOBEvrQXwQOIG+/qQ44je7pV/8S1kISsd0hbVpTIFV/vF0A4wdH4zIN7tSyAVRkL
         6JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899545; x=1755504345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eW6y+UNOvvAMVQOqHdBQUNKwdtVuFl7txNft8++BOc=;
        b=CxMf5IBdtKQfM66kMjOO0lsuxrp1Pq4cKaCLNhOcf7IWMZgNtlWIIMV6WMJqEwynw/
         X+seD+t01TzJZrAMQiIRAPgJAezDMzG8LYmIR5V6k72nIXXv4joRq+a5vYEl6LdgAZjh
         ZqZR4IkQs8RGluOgmsP52zYXJWelofoROW49clztubagYZigJocSw694vI4FXFVTUtmp
         mwH7FahKbNEYI4LI+410FFr56k1hxmxZBGvdQ/EUF/7bYxVtI3i7NSkNW1JsMc2crEt7
         N/XdpQWAB/ZhbzcxCKRQdYERiOnujLcejlB26RZ+gxKyW5If+Z3r/Xm7JyxfMvSSxXXw
         Aq4w==
X-Forwarded-Encrypted: i=1; AJvYcCUx5QpgF3qNZc7EUGmTyZXGHGJzTiGg0ZFhcebdtMaochX3ZMeSlC8YW7/eB/2znHm4Zgz0cgZAr9mTfIHa@vger.kernel.org, AJvYcCVoPRpkKaIBu8Omabz6/mNRCEv0ez5iL80GgoYk7kReo+CbzxNtx+qH3ZIqDDdZ1FwLeCB2Vvb2rkA1@vger.kernel.org, AJvYcCWZ7SQSHrzzisJY8urUFiQaJRPr8Zo8qHwk36oKm5++NI/GUqxwUdNndcd/A4QtK6wTS2FVwrtZUj48@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKQyLBmai3zuxNrl8oArDd1lS3bzfVaP2Ya2KyNz2UwX6nvhV
	WHbyKXMhQPPoEbYStO+qbJ/KfkeP7uPlP0zIXZUfVALqp5GtTGsEEV/O
X-Gm-Gg: ASbGnctKDQB2RdgPgiIILA1csBlRJtp0/fdz2HjQTZn1v1C6aqn0P7b7laXqQx7QOvx
	t2Exxikl5SA7SYFfB0w5L3MljTtdZlYLdutr5hwE/NDOEdRByL85PJnNiJ/xywNmcjU2t2PsP1d
	GESdqlHypv8Xyn5ynKze2zFbfg6OC1lKuHhrd6XiMuGSdrG2v40ZITBr9rx5SGmXBGzuH8tZsNC
	izHu5VElb5YCA93wtGj9FjavtoCf6P8qCNx0zOAR+Ek8hv8tZLpSo/ZYlcXgAurEoRok1AiDcQV
	YiZXy2KHTzRnzXZyMce07x+JyZOyJJEX4pzoxRFUFinayFc5BM51WOI0+8Kur1TI7Ytwo2aoMY4
	tCyfPpjcRLqXSknTHM4G3Ez2b8pKVfxZq1TYC+EnTdz2G5yhL2yjFTDVdq3IIdIp97jZHhxodqq
	bz878=
X-Google-Smtp-Source: AGHT+IE6GDKtjfUoIVAPoxnLJtN4ebZaRytbQ0UJzacmzYh5M9pc71AAFOPgwxe/7pCtFx2fcdrANg==
X-Received: by 2002:a2e:bea8:0:b0:333:b1c4:4d96 with SMTP id 38308e7fff4ca-333b1c45029mr21468271fa.6.1754899545104;
        Mon, 11 Aug 2025 01:05:45 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333a17b4e10sm13245301fa.10.2025.08.11.01.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:05:44 -0700 (PDT)
Message-ID: <c236bb5e-dd46-4caa-81b1-9af1550feef3@gmail.com>
Date: Mon, 11 Aug 2025 11:05:42 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754641960.git.mazziesaccount@gmail.com>
 <cc5cfa7540caae4bcb7448a59602421d54353ecc.1754641960.git.mazziesaccount@gmail.com>
 <20250809202106.59d405c5@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250809202106.59d405c5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2025 22:21, Jonathan Cameron wrote:
> On Fri, 8 Aug 2025 11:54:25 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
>> pin used to start the ADC conversion. Other than the 'CONVSTART', there
>> are 3 supply pins (one used as a reference), analog inputs, ground and
>> communication pins. It's worth noting that the pin somewhat confusingly
>> labeled as 'DIN', is a pin which should be used as a chip-select. The IC
>> does not have any writable registers.
>>
>> The device is designed so that the output pin can, in addition to
>> outputting the data, be used as a 'data-ready'-IRQ. This, however, would
>> require the IRQ to be masked from host side for the duration of the data
>> reads - and it wouldn't also work when the SPI is shared. (As access to
>> the other SPI devices would cause data line changes to be detected as
>> IRQs - and the BD79105 provides no means to detect if it has generated
>> an IRQ).
>>
>> Hence the device-tree does not contain any IRQ properties.
> 
> Commit message needs an update as it now allows for IRQ properties.

Ah, true. Thanks :)

> 
>>
>> Add a compatible for the bd79105.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v2 => :
>>   - No changes
>>
>>   v1 => v2:
>>   - BD79105 can provide data-ready IRQ (or GPIO) via DOUT-pin.
>> ---
>>   .../bindings/iio/adc/adi,ad7476.yaml          | 54 +++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
>> index d0cb32f136e5..c411a7467651 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
>> @@ -41,6 +41,7 @@ properties:
>>                 - adi,ad7910
>>                 - adi,ad7920
>>                 - adi,ad7940
>> +              - rohm,bd79105
>>                 - ti,adc081s
>>                 - ti,adc101s
>>                 - ti,adc121s
>> @@ -55,6 +56,11 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  interrupts:
>> +    description:
>> +      The data-ready interrupt. Provided via DOUT pin.
>> +    maxItems: 1
>> +
>>     vcc-supply:
>>       description:
>>         Main powersupply voltage for the chips, sometimes referred to as VDD on
>> @@ -75,6 +81,10 @@ properties:
>>       description: A GPIO used to trigger the start of a conversion
>>       maxItems: 1
>>   
>> +  rdy-gpios:
>> +    description: A GPIO for detecting the data-ready.
>> +    maxItems: 1
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -82,6 +92,20 @@ required:
>>   allOf:
>>     - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>   
>> +# Devices with an IRQ
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - rohm,bd79105
>> +    then:
>> +      properties:
>> +        interrupts: true
> 
> It's been a while since I wrote one of these, but do we need
> the true bit given we have already specified the interrupts
> property.  I think we only need to do the setting to false
> on an if: not:

I think you're right. I just used same approach that had already been 
used throughout this binding. I'll try dropping the 'true'-branches, but 
then also the other 'true'-branches should be dropped from the binding.

I'll just do that and send v4. Let's see what Rob/Krzk/Conor have to say :)

Yours,
	-- Matti

