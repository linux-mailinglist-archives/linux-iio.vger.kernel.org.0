Return-Path: <linux-iio+bounces-9780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3BE986E5F
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 09:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEE31C21347
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F01925A5;
	Thu, 26 Sep 2024 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW47b239"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6DA18A6CC;
	Thu, 26 Sep 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337516; cv=none; b=bG0iZT20aONJt2B8L3LxZozdPLpVLi9vRyIPLcJVI9NruGXxCqqi06bpHzu2Bcbg01Q+z148NBq4FbIfVWw5ESbc9lLI7af+AIl+VGv/XSIiDmGMchhJmDuz6+3y2mrMwsm4Zhcih+NOTF3ycKxiU4w0bysCQALOS6a4pTRCYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337516; c=relaxed/simple;
	bh=fK93/LGxmG73VHNKRXwDaW/YmezZFk9nqAI6SsN2KjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTk99ytBMYLXRFxkcTvVTbMu4mssBk9EkVGXc43K6o9A7aETqPi1nX5VqR3iphZGquQy/f66x6kOsPMNzsvWRlCnngGMAkGQMpsUHtW9CD1i3fszhAcpGYAkMGDnCZqIn3Sh81I1yZ/J+EyEnOyubXEM+GIRqFb9cFwcE82S9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW47b239; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e55bca81so58915b3a.2;
        Thu, 26 Sep 2024 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727337514; x=1727942314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWzVuNeEmqHJ1u8ju7YCekIUG85QkK0qD7OXBvRvawM=;
        b=BW47b239AmsNOVfj4kntbnj336JIJyOOxd3W3rIC41xEl34nZg/Bev5Fb/f2HxToGB
         6oEBCRYCtkMIZLk5tan6Z5LI7rH5XYRiEfC12IhnllyE3Ehd4yPmrdoZLRpIaf7+UY8v
         XmSx+/ZzF5NjmSll4j9El10+kZWgxzaCVKSddAMOHF7ZpgKtMJim69GtByZGRnMZcluB
         o1LUIl0guNoJ63lTklaMpsibzGxOrPw5N1IYku8VP/5LYjcFJjWqoBE03F58yOzoUDU3
         xNc0/oMXp6aHi3DgVn2fbH8x1GmMmTASfIyfI3QUBLvuCK/vrGrUZrGHsgd+oO8U1ZMC
         NeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337514; x=1727942314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWzVuNeEmqHJ1u8ju7YCekIUG85QkK0qD7OXBvRvawM=;
        b=T84NLSAWff29O2XICtUZcfDWAQNauqi6YIF2Hnx2zQlekvVe17X3opcnHZcfPWEWGT
         toULZicfa63wlghYswO0tyDxG/xcCc2IwC9W7QrKxQkC+LhQyyO6PmRgsLqk60Lvx7ih
         B92qO62Iszl2/76Fa/AwTlISvhLv1zH2VlwR45EhbcIusCyPfUgUSxqgzJkkGekaRXkC
         Ff3bQTDk4QcWLR4I8JZ25NrHB46qKPLMCQBBzmsxAvyit2FOVxDNFXqykipceFEgzRp7
         /MIDlUex5IcSG97w45Vk7fnBbilu/gwrCPPl/4ef2uUlmjcmyst0IzsdD0DVh6r7tDap
         skig==
X-Forwarded-Encrypted: i=1; AJvYcCU2rbk8ttHvYiHuRN37A+JeE+Dr5ts4M/I+yoNBkl0Cim0qy1vUbA2beesxtrZvEITL8VyTvIPwn+MK2Hv6@vger.kernel.org, AJvYcCUv8gRVj1kbm0pq7RG4+pXBVYwM7X7Zhxeh/dytPpK2x7iMcg0BedMSADDuU59Pbj78uFLsBR0cYwnD@vger.kernel.org, AJvYcCV6S7KioTX+IjMSWDFPw28DswhLwNCRmMW4FCyV7HaiGlesgDcnsvGm0+0PjTubKfwJnGJidgUcoPZt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gFLcfsh3WeYW0Ivvdv8vpjQqOxvRx5OSJzjN2AkE00xbxNp1
	AffkrDKWwelklXJRaKxCSGNBS6T+200oh7kVvoA8pffAm880orqr
X-Google-Smtp-Source: AGHT+IFLOhWZU7G8EXAx1qAOb0VWfAM83eWttkRY5go0vsHS6idkSuR6eHJPS7sHJItzPYDA6MGAvg==
X-Received: by 2002:a05:6a00:23c4:b0:718:e49f:137a with SMTP id d2e1a72fcca58-71b0acb74d7mr3289396b3a.6.1727337514020;
        Thu, 26 Sep 2024 00:58:34 -0700 (PDT)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc93fed7sm3772045b3a.126.2024.09.26.00.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 00:58:33 -0700 (PDT)
Message-ID: <13e92a64-5921-46ad-b685-87b98807208d@gmail.com>
Date: Thu, 26 Sep 2024 15:58:28 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
 <20240926-add-performance-tuning-configuration-v2-1-fdbb654f5767@gmail.com>
 <mzymeyslfhnxpnmiqtmmavn2tyx4mm67f5oy6m5pw7sogcuqn4@uexouiqfkdeb>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <mzymeyslfhnxpnmiqtmmavn2tyx4mm67f5oy6m5pw7sogcuqn4@uexouiqfkdeb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/26/24 14:53, Krzysztof Kozlowski wrote:
> On Thu, Sep 26, 2024 at 12:40:17AM +0800, Yasin Lee wrote:
>> When hardware design introduces significant sensor data noise,
>> performance can be improved by adjusting register settings.
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   .../bindings/iio/proximity/tyhx,hx9023s.yaml          | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> index 64ce8bc8bd36..0673c40472bd 100644
>> --- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> @@ -28,6 +28,18 @@ properties:
>>   
>>     vdd-supply: true
>>   
>> +  tyhx,performance-tuning:
>> +    description:
>> +      Optional, When hardware design introduces significant sensor data noise,
>> +      performance can be improved by adjusting register settings, including
>> +      but not limited to sample integration time and average sample count.
>> +      Performance tuning parameters represented as register address-value pairs.
>> +      The array consists of 8-bit values, where each pair represents a register
>> +      address followed by the value to be written to that register.
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> I think you wanted here in such case uint8-matrix with one dimension set
> to two and other 256 or whatever.
>
> I also wonder why do allow any register to be tuned. To me "tuning"
> sounds like improving or tweaking the configuration, so for example I
> would not expect to change some control-like registers, e.g. interrupts,
> enable/disable, reset etc.
>
>
>> +    minItems: 2
>> +    maxItems: 512
>> +
>>     "#address-cells":
>>       const: 1
>>   
>> @@ -65,6 +77,13 @@ examples:
>>           interrupt-parent = <&pio>;
>>           interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>>           vdd-supply = <&pp1800_prox>;
>> +        tyhx,performance-tuning = [00 00
> This above is clearing entirely the GLOBAL_CTRL0 register, which is not
> tuning.
>
> You are basically avoiding hardware description as properties in DT and
> just dump a blob.
>
>
> Best regards,
> Krzysztof
Hi Krzysztof,

Thank you for your feedback.

You're absolutely right about the operation on the 00 register. That was 
indeed a mistake on my part, and it was not my intention to clear the 
GLOBAL_CTRL0 register. It was only meant to serve as an example.

I also now understand that importing a data block in this manner doesn't 
align with the design philosophy of device trees. Moving forward, I will 
abstract each possible tuning configuration into separate properties. 
Since there are quite a few properties to handle, this will result in a 
larger codebase.

Given the additional work required, I will take a few more days to 
revise the patch and resubmit it.

Thank you again for your valuable input.

Best regards,
Yasin Lee

