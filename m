Return-Path: <linux-iio+bounces-6717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78A9133F6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23799B23181
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3316DEBB;
	Sat, 22 Jun 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtQ90NQf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255014B97A;
	Sat, 22 Jun 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719059754; cv=none; b=Ic3s5QEfjYI2f/WwmVCR0bGtf+3x5OXUkupqCAE+L0KkP6dROTikzWH9QXr11F2ljQeUC6Hh1R1CPAe5021B4IhIGINSPw07acwUI5cekI7RdIBdHwZuJBm5MgZM1eSSTodclycAOjbEZjdr/AN27vGUJxo8CC/iQgQMSyBXH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719059754; c=relaxed/simple;
	bh=UoCLhhSoEs7Xsh66F990Erh/cs3xganzhl/LZol97io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf63cFJx0Zfqo994gg7m8pCPC8ZQWkN9YFfzNNJ5CRvV+/m3k45S0Azd1LNBTDtBupjgF5ChrKswO3Vy5NpqMAledCtepVSK9IxrsJrg/P4855iYM7Jw6wCuHbILoBO+lAnqdPWMLXj3q6KyXULarKMY7GnlF/EfeaJTp3R8mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtQ90NQf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-70df213542bso2073239a12.3;
        Sat, 22 Jun 2024 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719059752; x=1719664552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1xc+TtnYIYIMppoIZtFnZo/BDI1KVIzOo/Vvnsq9yw=;
        b=KtQ90NQfv5xCXmzYACgfQ06EZ1bYDqsgJLd7/o8Xnch0ENPyV8eSVOEfoAb9HzcRxU
         t6GZ+wT3q9RvqsSE/LNb966a7Lkh6S3ZnuK/x+rbApdqvwXJViOx6BCHuh6mAzGNuZpO
         cwMCY6jro0O3RijCJdK45hIMgjtTJACK8GRd9io+o2AyKGn51IaiFWYSwmsXcXnCHtBT
         J+vTKvtfu8N/n/1+VQEqgV2jm3qW/Yw4FeAQzEjHZ/EoLzsqpAKJwDnNWP4m5jCH7QFI
         1mYkOhKcSZerY3eiKft8557gesRp4tLQmF6P2C5Q+gDj5LLFM+/+tpCr3y4LFKT562nh
         0GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719059752; x=1719664552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1xc+TtnYIYIMppoIZtFnZo/BDI1KVIzOo/Vvnsq9yw=;
        b=SyllPrQFjgr45Pxj7cz7lX8JNKRN1CWpUZh3MDUvGFEd6MEn+Y7dNwZ6dVLB4mSAeV
         TRM+JRmHRF8pG5WTySjRn6Dp/yMhbt3zhO2wHGHXK2eCNtyB46L9HR8bPgxszomuzXLN
         WvPs4pBfmkN7bDvx6BlFwW4p6WXGuL/bqJVw7uIR/hwUPVw1V1pvQ3bOspDZNQEiYXuZ
         UM8TCf/racKjsmdCJCuLCmaQKYmsPxjucLUe5Cp4XKgzsbyt5mv/2sPWlCcrvlqEEslB
         z45fD39W0fzzEaYe21cyRT8eVNrUmGdnjV/74dPBDrMD8S04as5LLjgUJ/0VEcLoqOfF
         DMJw==
X-Forwarded-Encrypted: i=1; AJvYcCUITsDpfdI5ZUFowU07ygDLu9GikVlMJkS08zUBOraafKpHK17R5iwESaJCD559zHliP4cCHY6XbFS+HNqtdibz9CBOiFCW8hr0wCy6Rr9xwwnrH42ac1SwXEvh4pewyUsukNHhFSFdAXc3mBF9E9Z/FIIzYNBYhDo/elnoxMr9XW8cmA==
X-Gm-Message-State: AOJu0Yynn2CUCKS8ipm+edTqWsu+Z303bJZngtfqJknnY442YFrwlIYd
	awLt5GKAfWT7dgOpwon3zN12f9JBByRk4Jjg9Nu30Hk22qEH1SG/
X-Google-Smtp-Source: AGHT+IGLBRP+PAayAeSE/5IwGuRJFMtD8w0U3b/DjMbel8NOE8coq2EuYXpkzwEEH3fzSn/GB/ZkMg==
X-Received: by 2002:a05:6a21:1a1:b0:1b6:dae0:5531 with SMTP id adf61e73a8af0-1bcbb5c9c1bmr13189827637.46.1719059752043;
        Sat, 22 Jun 2024 05:35:52 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb31f669sm30300055ad.63.2024.06.22.05.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 05:35:51 -0700 (PDT)
Message-ID: <26db1f7b-bde9-43a5-8c9b-4323ccfc59cf@gmail.com>
Date: Sat, 22 Jun 2024 20:35:41 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-2-65196a9020f1@gmail.com>
 <d35f5eba-abb4-4924-89d6-0beb878a0bf7@kernel.org>
 <385a7a64-fc76-4655-bc7f-d89d00b053d5@gmail.com>
 <20240622-superjet-dusk-cfd19f899cc2@spud>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20240622-superjet-dusk-cfd19f899cc2@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/22 18:51, Conor Dooley wrote:
> On Sat, Jun 22, 2024 at 01:56:42PM +0800, Yasin Lee wrote:
>> On 2024/6/21 18:12, Krzysztof Kozlowski wrote:
>>
>> Hi ,Krzysztof
>> Thank you for your reply. I have some questions inline.
>>
>> Best regards,
>> Yasin
>>
>>> On 21/06/2024 09:40, Yasin Lee wrote:
>>>> A capacitive proximity sensor
>>>>
>>>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>>>> ---
>>>>    .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 115 +++++++++++++++++++++
>>>>    1 file changed, 115 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>> new file mode 100644
>>>> index 000000000000..beca70ce7609
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>> @@ -0,0 +1,115 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: TYHX HX9023S capacitive proximity sensor
>>>> +
>>>> +maintainers:
>>>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>>>> +
>>>> +description: |
>>>> +  TYHX HX9023S proximity sensor. Datasheet can be found here:
>>>> +    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/iio/iio.yaml#
>>> Which part of iio.yaml binding do you use here? I cannot find anything,
>>> so this looks wrong.	
>>>
>> I will remove this reference.
>>
>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: tyhx,hx9023s
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    description:
>>>> +      Generated by device to announce preceding read request has finished
>>>> +      and data is available or that a close/far proximity event has happened.
>>>> +    maxItems: 1
>>>> +
>>>> +  vdd-supply: true
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 1
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 0
>>>> +
>>>> +patternProperties:
>>>> +  "^channel@[0-4]$":
>>>> +    $ref: /schemas/iio/adc/adc.yaml
>>>> +    type: object
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        minimum: 0
>>>> +        maximum: 4
>>>> +        description: The channel number.
>>>> +
>>>> +      input-channel:
>>> Isn't this duplicating single-channel property?
>>>
>>> Where is this property defined (which common schema)?
>>>
>> |input-channel| is indeed intended for single-ended configuration, but I
>> couldn't find a definition
>>
>> or reference for |single-channel| anywhere. If possible, should I rename
>> |input-channel| to |single-channel|?
> Single-channel is new, it should be the next branch of the iio tree and
> in linux-next.

Hi Conor，

Thank you for informing me. I plan to temporarily add a prefix to this 
attribute to distinguish it and update it in the future. Is this the 
correct approach?

-       single-channel:

+      tyhx,single-channel:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 4
         description:
           Specify the input pin used in single-ended configuration.


Best regards，

Yasin


