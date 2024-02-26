Return-Path: <linux-iio+bounces-3089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FC86755C
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D59288206
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62927F7DE;
	Mon, 26 Feb 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDdyAzHZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42067F7D0
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951346; cv=none; b=B0xy4J8pq76mi1XtDTvvs2/h9Xp3//AB93inzxvwvPgcB02p1t1PuJjn0g7nAbMxSk8BBXoOC4nHCQ0pe881wh3pnPldEl6sf+XP/l6nX8k/K6BuoyrwAn0nzm/PvcpkgjGqKfuNwCBoOl/76E/JGZF+T2QEvJC06R6w4E2lAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951346; c=relaxed/simple;
	bh=iK0pc9/o4qPy2MF+4qVH/jaVBhhheQRx/oHhwarLJJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgdyHaKdtNwTB3bUJj9YRVq5iE9MI96eWn5gYXI8Iqoj2Y5DTwtRvUzbso3f71+Iqadp/rUvExIkPV9xKdQOt2BZaZOp74YXBQDF7JaDC2UcwAVeOolqx7mUcJEHPx1c1tQfhh3d0Kjx/3wJA+Fw27Cu2/Zi2KtLk/MfukWKOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDdyAzHZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564e4df00f3so3835078a12.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 04:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708951343; x=1709556143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8DHJsu3a8iuvwFkA7p3y2llhbLihbwINAFhLWQK3ys=;
        b=KDdyAzHZdx5yJH2/3rNgX8DDCZtMuKTROk0kLJXYSVwMjuE6plYbINSpz1PrSqYY8x
         4Z9rxBOC3ggp/96WT0qkEFg4PuBnH39CNlgvx3rBhP1yvjgOfCgDgAUXKTZfPgA3CvRf
         jiA+nCYtNf3ReLL6OHgXFjQCkfnF+nTAlOZbhjbe6z8yX0iNNTaSyQ+sPm+ncVC2Jx1y
         f2w4F/uwpaSgdrgxm9et13rsBdSaM43/vz7iUFQuepFZSW16gHzMEjrGJSMrOrWrNyG/
         48kxyUcn0hv/agQ2KsyJXWcGAP/Py2imQxERfWfSD7kSjTFtzV9z1BKUHeOW+NG1VDSM
         9TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708951343; x=1709556143;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8DHJsu3a8iuvwFkA7p3y2llhbLihbwINAFhLWQK3ys=;
        b=Vb1UDIauZA07ws7qVP8ewCe8v5LXHhsWRj2Jm5xgKYE4hqkJyx4IR6i38QdtwVxCYg
         kjmbSaASvxkKNW/uNEdh0la3SgJCiqJmaRyPyDZuii54o6CMArzGjy6f17pAY0TOkzYP
         Wz1+6IzZEgT3U7JyxsNDdI6iyds1SHH4jad1b9HulNH2lJRANTUBY9C3uCGDg935ndIz
         4hq8PUvI9CqYg0gycVOd9vxuG//bMOdrU1VpyBtjRFgKrgdqmwcI8hp/NEnxKbH9akht
         +hpAjg4D16gkU+F5lqsC35pWudKPCjru7kCFQrIp0Hn37Ob/6Q8bL7SFFkY3RScONRkW
         8kvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKWDCXSVdE6uJrnJdo6rnuBXjO0/imY9kZ3jXAOOJmELN2jIUMyYPfdITp1omBJzAkTI/RnyFtQwZw4bB3GzGzyCdnjLqplXCQ
X-Gm-Message-State: AOJu0YxMFkpyru8v/6A6cM+pyyEj0sruuXezkzA7VEgokFT+GmwFmeA2
	y6mpbe/4uvmzIfDp0UHN0a8CBIXLn7b10am9txjC0mpSGK+/Vbtnx0TyhS1oBog=
X-Google-Smtp-Source: AGHT+IEXFJfAeWP0vTf6kRL2dq7bUv/fdef3FkLB7jkozzsXfpKBEMYxD6469aiAi4j9MXCdpauccA==
X-Received: by 2002:aa7:d4c3:0:b0:565:ed50:8ba7 with SMTP id t3-20020aa7d4c3000000b00565ed508ba7mr1792722edr.26.1708951343108;
        Mon, 26 Feb 2024 04:42:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id p24-20020aa7cc98000000b00564da28dfe2sm2290778edt.19.2024.02.26.04.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:42:22 -0800 (PST)
Message-ID: <09f4b87e-8344-4051-aa69-5117f6c5e481@linaro.org>
Date: Mon, 26 Feb 2024 13:42:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: ti,tmp117: add optional label binding
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20240223162042.2658620-1-m.felsch@pengutronix.de>
 <e6bb70fc-81ed-4775-8d3e-4bf177c6f22f@linaro.org>
 <20240226102323.6awrkxrdfq7j3ymj@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226102323.6awrkxrdfq7j3ymj@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 11:23, Marco Felsch wrote:
> On 24-02-26, Krzysztof Kozlowski wrote:
>> On 23/02/2024 17:20, Marco Felsch wrote:
>>> Add the support to provide an optional label like we do for ADC
>>> channels to identify the device more easily.
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>> Hi,
>>>
>>> patchset [1] should be applied first to avoid merge conflicts.
>>>
>>> [1] https://lore.kernel.org/all/20240219131114.134607-1-m.felsch@pengutronix.de/#t
>>>
>>> Regards,
>>>   Marco
>>>
>>>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
>>> index 33f2e9c5bd81..f00c1cb89acd 100644
>>> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
>>> @@ -27,6 +27,10 @@ properties:
>>>    vcc-supply:
>>>      description: provide VCC power to the sensor.
>>>  
>>> +  label:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>
>> Drop ref. Did you take it from any existing binding?
> 
> I used Documentation/devicetree/bindings/iio/adc/adc.yaml as reference.

I'll fix it there.

Anyway, label comes from iio schema in dtschema, so this should be just
"true".

Best regards,
Krzysztof


