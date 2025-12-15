Return-Path: <linux-iio+bounces-27084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E2CBE626
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 15:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62E733011BE1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320734A79D;
	Mon, 15 Dec 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBfgKRJ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD612C15A3
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810176; cv=none; b=R2QJ6Pszqg5yyZcrKjxBKm8kKxuWAeBqJVip64K5MGMfV2nl6AnZi8sE74UGw/9kCux1aVMmlCM+NcmMFcCkY5HZh8c12rhp7zF3F7EnfGennDbx79MfrfAn509aipU2u51YVp5zwqlflB1r3/YE17s/uc1qzYC3jjWwniI+niU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810176; c=relaxed/simple;
	bh=/m+knTh0E1M2rZ0Z8fiBqCyqvapY0NF86oC76d3XA1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYlCjlL/tjs5xQuYac6hzX4O29cfM47ccGHTPGWfkwq8+45yP53+WES8i0k767jbyQA4Of2Lu4ZCC0dPbPvm/OYcb5wWsWuxrq6CFBMRhvtYIbgcZVUoV3eHMNfWPRQOUtjR4JsDxndgVXMmifu4Y1pgo8uwpcf8Yzl+dvsWZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBfgKRJ/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7f651586be1so1533016b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 06:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765810175; x=1766414975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wMsSg+3EyGIctnEV/0UUxXYttTh9TK1dkuUNFrw/h0=;
        b=aBfgKRJ/nDzY+4Oh5cv6gGFBY6XvgpwLMwzSqG2Bgzz8ecyPts8nVbwcytfpc0IeSd
         0P5+dQW5Sgrbt9wKPrt4j4g5Wpfognhgkzy0Xlsa6iK+lmBwA7eKWo6MRs+qPUaYZy4f
         Fr6yf3KdaeeL5TDX51uHlePoYJyHzuhtcWtO1JcvaJEAtKPJWZO1Sng2qsdRlL7gnCZ7
         iEU29voX4FAxkuaSanF+3ZqsNB/t5ePa1nzwDkVUALcRmLuNL1pDUuZtf/eE/6cCtm6y
         d+ga1ZP8RmDvPWzt38Q1aYr0mdbWahZ9hZEGq2+ht+zVrHCrolZf2ScsBBwsPrZIRcxq
         049Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765810175; x=1766414975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wMsSg+3EyGIctnEV/0UUxXYttTh9TK1dkuUNFrw/h0=;
        b=RZY9eLqlMIyG+EFPEWvZcupt/PqodtliHdWIW4LaLtNRvNmMRal7Oan/iM/nZMqfXo
         aor0myMMMrA2iY9ugw6be9GNZUgMDF6jTNsz5yDtBzViZb5v67pUFQnsOLBN2fY/xlv6
         n46gm6QaBZgA1SnjVfBqPpqRGdDs0yzPHbO/ik0YFH72tEKl5/myKnd/AFQL7r6lxoDX
         s5rYckegzfcMo4q766MOIdpuasoA5JcDHO0cf1u/ERv73asLVXtXHLa46lapNOruW6K2
         zuxo00I0HYp/k0iaNa0LCkyAeslztcZWR9r8GimV0QXezEmvKVdipWxGAS5fsGFVBTTd
         7SJg==
X-Forwarded-Encrypted: i=1; AJvYcCWbwX9oYb51IyDaYjuXHVDzmpPZpy6Na0teXohljMR2Ssfw7YjzkEc26xf2l+zvznWVRpo4wTWvCwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttUrJcGx+E7+DD6a7fe6q3/ZoD5CnEDhVksls/Oxt2UAxK1ct
	NkMd3HR8nSIHRqX1U6Glr7f/Fxv9flpWntjIR49rj3auzj27s0rwoDUO
X-Gm-Gg: AY/fxX71S4RSt5kiBrsv7nk4bDZT4boVufzwwTCswZmDtaWmSAtehogODc87SgzIb5c
	3p/o8R5X+9so/Oqgn+nPcdE9Y6cIXj7mZ4HNHWG55FZI46zqLKZerAyrdEA1RPHP0kYQz0MldRK
	g/OfQcdgf0iCY8ruLgAl/hSBsjDhvzP/BD4yiucW5BLHh7R0VOAHc6mK2UiZbawjjpPYNOC5gnN
	nI+FLDC9ds3Bf+K+X2meWCqCrHtBMzqM930DLMBh/nH+bmMFslfjxxw0tdqP0hmeHEnpdCbNG7J
	JGEUt+6Hzqb7k7zHQDZMOUnWYbJdAacY+c/kjt5xGt9NRjVfgH5VCO3B5b9EV9/FEpXzwi9h/Cd
	UVlq8xICoV692SRvjIYlSc7bnt101KRPdwIkPcobuy8ZLB9RVjJqRTlUszx16HURHDVqgbDOkey
	xB+Fxo252T2oJdXjpmXsBbaMNwlC1CRXExGNpas29xuk3/j9pDI3jv94VgIdpfslEvbidB3uGRT
	g==
X-Google-Smtp-Source: AGHT+IGW1vL32/koMdZGp73rOzt+sAsrioh2S+qAIg+6TbUn3VCos+ZSPJ+Ot3qZlswrzqKctOrZHg==
X-Received: by 2002:a05:6a20:12c2:b0:35f:5fc4:d892 with SMTP id adf61e73a8af0-369aa15fb58mr10832984637.19.1765810174507;
        Mon, 15 Dec 2025 06:49:34 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:50bc:8636:2ee8:5158? ([2402:e280:21d3:2:50bc:8636:2ee8:5158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5663dsm13293460a12.17.2025.12.15.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 06:49:34 -0800 (PST)
Message-ID: <d25b91b2-20c2-492a-b056-bf3bdaf4494a@gmail.com>
Date: Mon, 15 Dec 2025 20:19:27 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add TI ADS1120 binding
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-2-ajithanandhan0406@gmail.com>
 <20251115183144.15b3e236@jic23-huawei>
 <5cb6243e-f47b-48dc-9f43-299cde632e08@baylibre.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <5cb6243e-f47b-48dc-9f43-299cde632e08@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 5:49 AM, David Lechner wrote:
> On 11/15/25 12:31 PM, Jonathan Cameron wrote:
>> On Sun,  9 Nov 2025 19:41:18 +0530
>> Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:
>>
>>> Add device tree binding documentation for the Texas Instruments
>>> ADS1120.
>>>
>>> The binding defines required properties like compatible, reg, and
>>> SPI configuration parameters.
>>>
>>> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
>>> ---
>>>   .../bindings/iio/adc/ti,ads1120.yaml          | 109 ++++++++++++++++++
>>>   1 file changed, 109 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>> new file mode 100644
>>> index 000000000..2449094af
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>>
>>> +
>>> +  vref-supply:
>>> +    description: |
>>> +      Optional external voltage reference. Can be connected to either
>>> +      REFP0/REFN0 or REFP1/REFN1 pins. If not supplied, the internal
>>> +      2.048V reference is used.
>> How do you know which set of inputs is used?  Looks like a register
>> needs to be programmed to pick between them.
> I would just make two supply properties for this, ref0-supply and ref1-supply


Hi Jonathan and David Thanks for the review,

That makes sense! I'll change the binding to use two separate properties:

        - ref0-supply: for REFP0/REFN0 pins

        - ref1-supply: for REFP1/REFN1 pins


>>> +
>>> +  ti,avdd-is-ref:
>>> +    type: boolean
>>> +    description: |
>>> +      If present, indicates that the AVDD supply voltage is of sufficient
>>> +      quality and stability to be used as the voltage reference instead of
>>> +      the internal reference. This allows the driver to select AVDD as the
>>> +      reference source for potentially better performance.
>> This one is interesting as I don't recall anyone arguing this made
>> sense before.  In what way better performance?  Are their boards out
>> there where this definitely makes sense to do?
>>
> Seems harmless to have the property even if no one ever uses it. But I would
> be curious to know the answers to those questions too.


I included this property based on the datasheet mentioning AVDD as a 
possible reference source, butit doesn't claim this provides better 
performance, and I don't currently have a specific use case or hardware 
design that requires it.

How to proceed ? Need your valuable suggestions.


BR,

Ajith.

>


