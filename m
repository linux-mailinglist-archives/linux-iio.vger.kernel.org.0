Return-Path: <linux-iio+bounces-6706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8D913228
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 07:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1386D1C21ED4
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50114A4FB;
	Sat, 22 Jun 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z26hRnAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7018BFA;
	Sat, 22 Jun 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719035818; cv=none; b=NAFW8xWmNZKHT5GzvB28xEM1430xUgrDQFKhdy6QTi87M7WbLdYelPsUeVJAMkQ7GIMoiGRqUHrrx4ULkJ7pYt8NMGtP//qMk4x3dWYHJLx7j17JFdft41+oEhTqW9Uu47LnJaBioMzvNX+22dGcFTVqXEVriEG/IsYNfR9tdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719035818; c=relaxed/simple;
	bh=8JJsl62hOZO3ko0SdWLCt6KmCn4EPgL0eaHKR+7qg8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSVWMVn7JloMRYeWRUR2SVSPK2aVjK3pki9xNiGItog4n9ne73Nh6ZD57uzozsye3mOJuihL+/4O8FQgRklOnJWRkA5TMEwijbuHWFDb7hMCpkH8AHZPuiyVSGFvDla9qUiwveVwDz2WGbDXGbMpS9WycmihgJNZT39v4xpgKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z26hRnAr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7065e31ee3cso736035b3a.0;
        Fri, 21 Jun 2024 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719035816; x=1719640616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gs6O6f04jMeghuWyfCIpI7mthyEAD7cAG4GE2WWkIig=;
        b=Z26hRnArW4sEHjY2McvRjPD+p9gt4452OJYQ1EBSFnR5BcUsnxdy0PsXEJTdZLIPxq
         VbiehyFzaAIkI/ytqtoRl527zIv3YMec9NW/pCi3MhUm7lPb/zJ/IrWpoFM3mUtjIeTk
         Ns6hxNp75LoOXjrmfLLzMx1tLKFmW5OIQok7aB/h/Wis7jW2SDfVMPFJIQ9Si51R8M99
         1L2gN1gfhoteUgJmRtTXJhtHuR/HW3EJ6VV39zXYnKg8aBHGhinZVReWYA/ym3GJPl/l
         ifKVHhZ2mQuEw4PpzuGlp3eni9kxLLwODosQAegw9tevu9Qc1ONxur47AlPeXeNkoY6n
         9YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719035816; x=1719640616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs6O6f04jMeghuWyfCIpI7mthyEAD7cAG4GE2WWkIig=;
        b=tLJre/40sHP1Z2S54FOiXSb6l0NsM2TXav7OvauznP4SYAuh5gFHOcMT4H+X3D39NF
         eN34vLsNkh40IZIZNtP6mwfpYwQXhNcO3yL5hB7jCY6zLCV4e6GU3S8y3CrUzpqlbtmm
         qzBOz93KD/qIJV70xSIgC9BGtdV0x1bBrzNt+c4Ap6o8weOkIKys776U9Y9osHGEQxMA
         MhtXJLbFwwz5osjjuTGlQq+jD4MSo1BZPUQnsICwOk7r7+CYpvTKE5OTvRKtsn0sU/on
         QWKDajN7QCLRmNlX+9TaEP+uTIDtdl+p0GZcroZRlVzKPH/5cZiEdsXBBMExJt/2yyv9
         SnZg==
X-Forwarded-Encrypted: i=1; AJvYcCUlofDWZ7R7l+ChSsrEdFveFk20k2AXcMMwyMikyPnGQbNFqQdL3c75ditaaQgrNplhy6ztD0E1NgAYuNlgegd5cXw8f4e3LIA50RJc+bPAHritHBE8MNb4F/VF0CQJzPPLsfubjbdN
X-Gm-Message-State: AOJu0YwTZ6wepqLqcGCU9MQ8xJnpnV0FB8xdLMHAhamPfSuO+XbAn18B
	N15AtyZbej+8du4kfWcgy3JP7tKq7nLXaDlMMFmky8LycTQhDzN7
X-Google-Smtp-Source: AGHT+IGJ3+53nng3c5HyZrbB4d4THj6HEuBxurSHmPafjQZYpCOssMyUXTBd64MjK4u8rB+j7+20Vw==
X-Received: by 2002:aa7:8c0b:0:b0:706:5dab:83c5 with SMTP id d2e1a72fcca58-7065dab85abmr2506240b3a.0.1719035816056;
        Fri, 21 Jun 2024 22:56:56 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066aeeaa5asm292203b3a.29.2024.06.21.22.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 22:56:55 -0700 (PDT)
Message-ID: <385a7a64-fc76-4655-bc7f-d89d00b053d5@gmail.com>
Date: Sat, 22 Jun 2024 13:56:42 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-2-65196a9020f1@gmail.com>
 <d35f5eba-abb4-4924-89d6-0beb878a0bf7@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <d35f5eba-abb4-4924-89d6-0beb878a0bf7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/6/21 18:12, Krzysztof Kozlowski wrote:

Hi ,Krzysztof
Thank you for your reply. I have some questions inline.

Best regards,
Yasin

> On 21/06/2024 09:40, Yasin Lee wrote:
>> A capacitive proximity sensor
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 115 +++++++++++++++++++++
>>   1 file changed, 115 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> new file mode 100644
>> index 000000000000..beca70ce7609
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> @@ -0,0 +1,115 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TYHX HX9023S capacitive proximity sensor
>> +
>> +maintainers:
>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>> +
>> +description: |
>> +  TYHX HX9023S proximity sensor. Datasheet can be found here:
>> +    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
>> +
>> +allOf:
>> +  - $ref: /schemas/iio/iio.yaml#
> Which part of iio.yaml binding do you use here? I cannot find anything,
> so this looks wrong.	
>

I will remove this reference.


>> +
>> +properties:
>> +  compatible:
>> +    const: tyhx,hx9023s
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description:
>> +      Generated by device to announce preceding read request has finished
>> +      and data is available or that a close/far proximity event has happened.
>> +    maxItems: 1
>> +
>> +  vdd-supply: true
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^channel@[0-4]$":
>> +    $ref: /schemas/iio/adc/adc.yaml
>> +    type: object
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 4
>> +        description: The channel number.
>> +
>> +      input-channel:
> Isn't this duplicating single-channel property?
>
> Where is this property defined (which common schema)?
>
|input-channel| is indeed intended for single-ended configuration, but I 
couldn't find a definition

or reference for |single-channel| anywhere. If possible, should I rename 
|input-channel| to |single-channel|?


>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 4
>> +        description:
>> +          Specify the input pin used in single-ended configuration.
>> +
>> +      diff-channels: true
>> +
>> +    oneOf:
>> +      - required:
>> +          - input-channel
>> +      - required:
>> +          - diff-channels
>> +
>> +    required:
>> +      - reg
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - vdd-supply
>> +  - reg
> Keep the same order as in properties.


OK, I will correct the order in the next version.


>> +
>> +unevaluatedProperties: false
>> +
>
> Best regards,
> Krzysztof
>

