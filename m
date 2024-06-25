Return-Path: <linux-iio+bounces-6880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CD9161DE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B721FB2314C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D0F148FFB;
	Tue, 25 Jun 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKzXMMww"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A632146587;
	Tue, 25 Jun 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306371; cv=none; b=pJgqRkBvalf1JBrPHzLX75MDUzc7qy4mk8xVXKjoB9iSLWYr0hTWHHmfO5Sm7arcUpFB/reQfh9HDjv/MwO29FwKQ0536zlFhLtTRttjGiCF9VR//fm/pnK4t6z4A5xrq2GuVqkb1zG+X2fg5g/eIOnx5U2zjgGbUa4Q1NeiCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306371; c=relaxed/simple;
	bh=Knfy7pk5oCoyG732I22F7r6g+Du9zIivLnWi+ONxeQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCPIBZsHUR259vPA2WpCYfSE+2FjqyEYKWXHyaEffa454hoRwl+fNtr5i8R3zA9oDeUqEX+ZQFt6tEcN1NCRDzKwWzcItvdRCc+b97FTWizJYUz4Uy4qC4pK7gYgaAY5K19H4QsnFQ3YUD4tEKxLfQVMRsQa/1sA9vDBZo6T+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKzXMMww; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so2766269a91.1;
        Tue, 25 Jun 2024 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719306369; x=1719911169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iJpu43SeKgD/NY+VN2xJJpKQ81U6RpzTSBbiliY1DE=;
        b=iKzXMMww3N61C40BqBWh8JQnzpRu8i0iXu2XOfqIdYdvo/osjjr3PI55trfo0z8bn9
         Lcj0UkbKlhPCFE8iR/Ygo9DjKJwDehzAFzIQwmsFS+D8Q9BBMhPGsbAcwxS2vJSXpeXU
         8x0QlcjAD0NKkcPujgO3FnG1AtVuZxy9kWj7BWjxs/4HmWkJBf9JUxMvEI+lNY+s701l
         XMSRqb3AAlifBSyqmuK13rd1Nj2PmwhKUDCo0XhCl6uzwk0iu77KHcY7083fAXvgM+0b
         qeN3Aq9zTFjQk3ZcjpOxUlp+tbmfaYrQ8QZiHmwsPHMvyktixZBCNtHX5ZowhuUGXfL2
         1wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306369; x=1719911169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJpu43SeKgD/NY+VN2xJJpKQ81U6RpzTSBbiliY1DE=;
        b=hqMQMgshFcOWfo0ZRVRmqfog9eMM5gKWHNs1BowUNBjtCLYr6YHTCJj8NWztVjLZdo
         KlF8/pg4ftGP+8um10c+EoDkVW8bBmeM5xLk7qUfB7c+lBtEUmnh57WG5bENN41RF1Aj
         42y5Et39ScpARdM/HbUZWrluHAx9OPqp/UKzu08r3rvmaLCu834xcrVqT0ge9XcYb6uX
         OQ6eqzTf1u5G6uNCjBxYs3i5waxq2fzS/H0FHWiny6qALcEpH/6Qr+ADPFYb+iTDgImX
         fz+rjdvxgizCkx9P089B8Sa6esM2dw6pgPvZwXsfFxBU/AqQorkoxEAtB+ar+oz+OqLT
         +GSg==
X-Forwarded-Encrypted: i=1; AJvYcCUqtgo87dhXdh2El+84h1JDMwRZeXMp4offYREZImTRl9jzlUs+XLcjShRMHMQJkjAkC/phLHIPndJ7uC5P03fMSdaOrCNMPwGtzqFyMyaZK3D0YS5YQfwNNnh/kv/8k637xGJbmmTj
X-Gm-Message-State: AOJu0YxfBxcuyG/iPW9Q40tbXnXW2JYZXvR4tpdFUz6zCQq0ElfsZdZ1
	GodpZOUnTBoKHT4KNTgZvsoayizbllCNknnYCLwO9lpC9PNb+o7NHxUqUefRe4gQ5ptMNP8=
X-Google-Smtp-Source: AGHT+IG+BfpVKq98hBn15FXBDPyS9ohXVtM3GJzdP15+BiWM1MXbjiQzR08Usoj/c860KnLf3bDtQA==
X-Received: by 2002:a17:90b:2345:b0:2c2:d6cf:f4d2 with SMTP id 98e67ed59e1d1-2c85051a295mr6338859a91.26.1719306369475;
        Tue, 25 Jun 2024 02:06:09 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a7a557sm8289100a91.15.2024.06.25.02.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:06:08 -0700 (PDT)
Message-ID: <b704f7a4-7eca-4b49-b96e-8414b52190b1@gmail.com>
Date: Tue, 25 Jun 2024 17:05:58 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
 <d77a4777-d282-4004-895a-7809abf68130@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <d77a4777-d282-4004-895a-7809abf68130@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/25 13:48, Krzysztof Kozlowski wrote:
> On 25/06/2024 04:15, Yasin Lee wrote:
>> A capacitive proximity sensor
>>
>> Acked-by: Conor Dooley <conor@kernel.org>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> What? How did this happen? Where - provide lore links to prove it?
>
> NAK
>

My mistake.  I will remove all of them.


>> Reported-by： "Rob Herring (Arm)" <robh@kernel.org>
> No, drop.


Got it.


>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>
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
>> +      single-channel: true
>> +
>> +      diff-channels: true
>> +
>> +    oneOf:
>> +      - required:
>> +          - single-channel
>> +      - required:
>> +          - diff-channels
>> +
>> +    required:
>> +      - reg
> ... and now you should see that you duplicated adc.yaml. This should be
> just:
>
> +patternProperties:
> +  "^channel@[0-4]$":
> +    $ref: /schemas/iio/adc/adc.yaml
> +    type: object
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 4
> +        description: The channel number.
>
>
>
> Best regards,
> Krzysztof


Hi Krzysztof,

Thanks for your reply.

I have done the verification. "single-channel: true"and "diff-channels: 
true" are necessary. Removing them will cause dt_binding_check to report 
an error. Only oneOf can be removed. The de-duplicated code is as follows:

patternProperties:
   "^channel@[0-4]$":
     $ref: /schemas/iio/adc/adc.yaml
     type: object
     unevaluatedProperties: false

     properties:
       reg:
         minimum: 0
         maximum: 4
         description: The channel number.

       single-channel: true

       diff-channels: true

     required:
       - reg

     additionalProperties: false


Best regards,

Yasin


