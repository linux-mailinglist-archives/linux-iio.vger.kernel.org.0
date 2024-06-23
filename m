Return-Path: <linux-iio+bounces-6730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3C8913719
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 02:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A50C1F2276F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0820E3;
	Sun, 23 Jun 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdO49J39"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B728EB;
	Sun, 23 Jun 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719103818; cv=none; b=dOOnteDNKUAhLAp7ltFuH5GfHotpclpshz71hx8khMcLZl10jZQZNUAF4nrIE+2dJ0SZLfwOwSqC1V6Tf7ju4WM8daz91KRAjQ/HjhSgHFvwuCLXUrCmv9fPCWG/jE+RRQrRS2oSDMnd4XfWboQXkkSYmSSWWwRWEV5kD4NZmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719103818; c=relaxed/simple;
	bh=WZD3oXNEQD6KnVSKu3IdpGaipLswzf6qmCl2awNBVL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWMOdSfONts+iOPb1dBGBGXNmEmSaCvac/pemHB4+6mcQD+6CVtZLM5V9kaphdmZA5E/gnOlAfreBTVAJNW61V8vjOjm9kTtIBuXzW6B3/u/0AI1S3F4T9kwEi0eEOkRhU/B/O7VVuio02gz6mum/U5GJiH+HEDP1cD83GOt3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdO49J39; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b53bb4bebaso1862016eaf.0;
        Sat, 22 Jun 2024 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719103816; x=1719708616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plQu2k+3AcRQXXZ9L/gcrksDp81HqnIUamR+O4Jb5js=;
        b=KdO49J39+ajPdgKdJ9jNX0TUV38uYdBvHYgKYrkcU//Z7CKMCoxwkB9YT5zsmYnL3p
         1GCF16CfR6TMDhmQu1GkckMIg15a8zbKE9BxU+q0P0fIWKar0GfJvkwJbaA/kdeuei6f
         nHWL/X4gglvt4YusvdfvFFiBRhyG366L8zoQnGiDWGWiYh7TvCk3c5uD474qr3bhGyR/
         6IwvmTF1uyZub+O40PMIrRJRFEnImg9WRTnOPTG6g6+v12edAtLQLMdQ/9T1I+Z9PmMR
         j5B+rX0pZ2w7lVTCzU0MG99cj5Ut7EZsSveqOU2qmwD1s8ohEy2O9rb188CjUIIGyKre
         5B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719103816; x=1719708616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plQu2k+3AcRQXXZ9L/gcrksDp81HqnIUamR+O4Jb5js=;
        b=VH/PoulE9ABnd2CoOjMrc6xctVOOdls6UJ9mxOUGEzt76icr2Ra1CSi9n2lBZw5YbX
         tnI5M9qvc6Z2PtwiyDrtRS9eREskKodPyOoPVZCZ2wbHxp+74+Pj0UbtDkbcAjCbO/mx
         EJ12qsbbzljnWlRrYDo11drQKdtFermwIB8IayNPkD6tCPN4j53zCuxQle4oC0N1yMDa
         0+jZx8i+3XcCSyUMeZrl751UPNjc7xQdLJMMr7JAuBUJi31yAZ7QXcjmfSopnopOHIVG
         2ghR2pg9vIM34KqD2KKQ3Xx8tAWrrEv6xgcuFBNHGdi13iLYoo7nC4WIrQLCy4aK9xnN
         NlBw==
X-Forwarded-Encrypted: i=1; AJvYcCW3PjGQw7fEQhlZdudd7Cg8nCWoDLrZi1vZPza2hhsCRGzRnyYRRo9QdfvdoUQuN78PuBbuGEWpRBEeDFzg3Ku75Ik4sn6i7pkaP49WxpgYzFCRELprql3r4gBHd+5YOO4HdJJGwOab3YpsiBVWPrh4NubXa1PDR60Ns5ah4GcfU3vIvQ==
X-Gm-Message-State: AOJu0YxGNrUMJ1UqGpPpG7staVJFEoSZqCV3oggAJccvr2uRmgm6aeMp
	/6DwwZ1nRd3M56peMCuKb4jgnYde0qsCtgLWm0/qG7w9FkbLujkWZZh4/C2kMPk=
X-Google-Smtp-Source: AGHT+IE6SplIWQi3JIjMjst1N12JyTJpXFKtMRkSPLMxy3BlUHUCG5ZkOfRgys5fxbhvd8OKC90NVw==
X-Received: by 2002:a05:6359:7b12:b0:1a2:3952:470f with SMTP id e5c5f4694b2df-1a239524b13mr145160455d.11.1719103815645;
        Sat, 22 Jun 2024 17:50:15 -0700 (PDT)
Received: from [192.168.50.11] ([123.139.251.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e0760sm5953358a91.20.2024.06.22.17.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 17:50:15 -0700 (PDT)
Message-ID: <bf328875-2ccf-4fcd-ad6f-685a1800f13c@gmail.com>
Date: Sun, 23 Jun 2024 08:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-2-65196a9020f1@gmail.com>
 <d35f5eba-abb4-4924-89d6-0beb878a0bf7@kernel.org>
 <385a7a64-fc76-4655-bc7f-d89d00b053d5@gmail.com>
 <20240622-superjet-dusk-cfd19f899cc2@spud>
 <26db1f7b-bde9-43a5-8c9b-4323ccfc59cf@gmail.com>
 <3541cd63-882b-4b91-871a-7d0385e12957@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <3541cd63-882b-4b91-871a-7d0385e12957@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/23 02:04, Krzysztof Kozlowski wrote:
> On 22/06/2024 14:35, Yasin Lee wrote:
>> On 2024/6/22 18:51, Conor Dooley wrote:
>>> On Sat, Jun 22, 2024 at 01:56:42PM +0800, Yasin Lee wrote:
>>>> On 2024/6/21 18:12, Krzysztof Kozlowski wrote:
>>>>
>>>> Hi ,Krzysztof
>>>> Thank you for your reply. I have some questions inline.
>>>>
>>>> Best regards,
>>>> Yasin
>>>>
>>>>> On 21/06/2024 09:40, Yasin Lee wrote:
>>>>>> A capacitive proximity sensor
>>>>>>
>>>>>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>>>>>> ---
>>>>>>     .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 115 +++++++++++++++++++++
>>>>>>     1 file changed, 115 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..beca70ce7609
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>>>> @@ -0,0 +1,115 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: TYHX HX9023S capacitive proximity sensor
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  TYHX HX9023S proximity sensor. Datasheet can be found here:
>>>>>> +    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/iio/iio.yaml#
>>>>> Which part of iio.yaml binding do you use here? I cannot find anything,
>>>>> so this looks wrong.	
>>>>>
>>>> I will remove this reference.
>>>>
>>>>
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: tyhx,hx9023s
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  interrupts:
>>>>>> +    description:
>>>>>> +      Generated by device to announce preceding read request has finished
>>>>>> +      and data is available or that a close/far proximity event has happened.
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  vdd-supply: true
>>>>>> +
>>>>>> +  "#address-cells":
>>>>>> +    const: 1
>>>>>> +
>>>>>> +  "#size-cells":
>>>>>> +    const: 0
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "^channel@[0-4]$":
>>>>>> +    $ref: /schemas/iio/adc/adc.yaml
>>>>>> +    type: object
>>>>>> +
>>>>>> +    properties:
>>>>>> +      reg:
>>>>>> +        minimum: 0
>>>>>> +        maximum: 4
>>>>>> +        description: The channel number.
>>>>>> +
>>>>>> +      input-channel:
>>>>> Isn't this duplicating single-channel property?
>>>>>
>>>>> Where is this property defined (which common schema)?
>>>>>
>>>> |input-channel| is indeed intended for single-ended configuration, but I
>>>> couldn't find a definition
>>>>
>>>> or reference for |single-channel| anywhere. If possible, should I rename
>>>> |input-channel| to |single-channel|?
>>> Single-channel is new, it should be the next branch of the iio tree and
>>> in linux-next.
>> Hi Conor，
>>
>> Thank you for informing me. I plan to temporarily add a prefix to this
>> attribute to distinguish it and update it in the future. Is this the
>> correct approach?
> No, because there is no need. You are supposed to work on maintainer
> tree (linux-next works usually as well).
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Understood, Thank you for the reply, I will reference single-channel 
directly as I do with diff-channel.

Best regards，

Yasin


