Return-Path: <linux-iio+bounces-20370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CFAD3F14
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FFA3A2252
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D424167A;
	Tue, 10 Jun 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UJOzR9DV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027B23F43C
	for <linux-iio@vger.kernel.org>; Tue, 10 Jun 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573349; cv=none; b=nZV1n2cA64rAA7aNiXL4lXYHFlu0YusAl9lF/HB4j7nlRws72HUCARTRc+pHnY3fac6svT7EBC9s0L9MOonQ5dYnYdPMsdzoXx35BVYYH2mRJoBwNTozeUGbjk88L1PQ+TXVTmuWa6iytMFcAAprRF4eAWpIXeSQYOFr5tnP/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573349; c=relaxed/simple;
	bh=BoFxGoKvLCwi0r5nMSq/smpqIiW/LFaahTEZQWqCIsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nleo1xS0apzryTKS1PIQh6CSUaBJyZwJGAPt69y1pFjRjbhCEbK8UDVTduZMNM/pqqhztfjlG+RrkmfFa+jifd78ZaotZkc2VhG13yn9o4tjdBYpJTXXKXNntfvmxhm1WhzG5TZul+nuKpN4nQe9b9fw8l+cQvZwUaKPd6iqLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UJOzR9DV; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso50192115ab.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Jun 2025 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749573347; x=1750178147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=337Fs/acVtHLrHpa6wOAa15lKx7cyXodEH1eYODanBI=;
        b=UJOzR9DVbFRsywiuXRhkMEMV+8yicgL+hiIQnlsrO4x8aoB2N69/V+oxVJX+ErFye+
         gYsMuLXm02AjmJGpppnSYcF9G5njjVo5PbWoXEbw9u3u8sJ7webEbi7uPcL34z8onkyy
         P4mAucYKRbpRi58AAFyJTE2zBzit/w/du1EkzCR50ZpUy/twToU1XJDwRgczrXk3pWhF
         6wiNbUzmJaulXdWNjSM9Ez5BwmhI7whtZrWwZpORO6iWMamLjgW5hdO25qycIskQbPO7
         616Aqk0+NI7CbRKhHVH88M1ArM3BN5gDcycylvnT9iaYZP77WWZ/QBJibvfMkEq7jQEH
         n/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573347; x=1750178147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=337Fs/acVtHLrHpa6wOAa15lKx7cyXodEH1eYODanBI=;
        b=RUlVCJhqhlitigzIXVT/tnatebhYA7eYjKXNephcKQHKhLQGGK2xHf14hiadrLJ4ap
         ZRz4NQ2yupLdUhTiOmyXbe2g3fD2DgACekd4KuHYIbe6q6gDj3nOQRkX3x7ilqOtRGYM
         LgdHjoJvchWe3vHcey0LouG4o/iDwaDKDzYISsRb57+u6bMsLnzZQeuHGTOyl5VXYYTF
         PSPR9Wzc7XbdGGjBthBs9mpN3SuxxQp9ZkA/4MvJ4UneB+bFBeYn1ccTh9G0KZrY/0j3
         IkH3jkRkv/7UE1lzbVQlmHfWa3WHS732mf/rZ2Tzi3qXjoaHyAEF+5EAUxKShCP/762m
         cQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUuZT6ws4SwkuGfpDJ8zoeliivGoJ7U0ZZYALWe1xF9Oi2P3Fx87+hczN0W8LqZlJwTVrzDXSyn/8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKbMl61hw1hgUVDzaXeZ5sG4bnQKlTVeM+gUGuP+0hJbQYAZk
	kPB5+RilwiP1rIQYvlVWWkD4TecFFAfKC0QqwVR6UwsNsYFyReJzz5ETF4iV8gL06oFv62NSgEh
	EouJ/
X-Gm-Gg: ASbGnctx9IFfi0vCrzvcszWvw5HmCkgplsNecs2sZIEAGbWeTydXcD3moWlIltxJbIr
	LEQ4miq1ZRmYUkT8u1zt6QEvf7gYRKaIOlKhkNLif4l0Dl2BwIGADskAjR29dWAK2WO0zl5N3L/
	SNggco87j8KvpJIXvFUYylCxnW2QOgvJdTWKSoD1bzmKBNzBNiY/RmnJyy0kh2bQzQ29P2FWM2f
	KccUmpDnzqJ9tNJYvIhpVCeZtdaVoqil3t86/PkKQkBaW9O58DVAuGsLBvL/2kXHwpSCbBr5+eb
	hDK0BZTrFaajYyAadfAJyjjcVpvNTKGNt4BEXNc1uGDU7Q149y5TONN3nsyf8WJABHzwzwVvZ+J
	XQHBTdS2/C4nNBJLpYiGnf2V6IYXeQnwSJNtF
X-Google-Smtp-Source: AGHT+IFKN7q+KfnRdAYUgSFfIsNqsRvnCQQh5WKK0QN04pgRZrP7ovwBO6O0oZMuTYIpSjBWFhM7ig==
X-Received: by 2002:a05:6871:5211:b0:2c2:3eb4:e53 with SMTP id 586e51a60fabf-2ea92c312efmr418737fac.37.1749573335756;
        Tue, 10 Jun 2025 09:35:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:eb6c:30d1:632b:494? ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea073406c7sm2477362fac.36.2025.06.10.09.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 09:35:35 -0700 (PDT)
Message-ID: <9fdbcb45-ed9a-4449-9248-9bc1d5593fa9@baylibre.com>
Date: Tue, 10 Jun 2025 11:35:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
To: Marius.Cristea@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 broonie@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250606093929.100118-1-marius.cristea@microchip.com>
 <20250606093929.100118-2-marius.cristea@microchip.com>
 <92c36ad9-5f8e-4ba7-9af4-9cb640f0aa5c@baylibre.com>
 <d364524bad53f5c665071287f55a96e28dc9b231.camel@microchip.com>
 <db78ac20-9b58-49d1-ba38-cc269eaff254@baylibre.com>
 <a9902463d1f29993f13ce0bc87fcfb05472624d5.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a9902463d1f29993f13ce0bc87fcfb05472624d5.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/25 11:04 AM, Marius.Cristea@microchip.com wrote:
> On Tue, 2025-06-10 at 10:22 -0500, David Lechner wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On 6/10/25 9:46 AM, Marius.Cristea@microchip.com wrote:
>>> Hi David,
>>>
>>>    Thank you for the feedback. Please see my comments below...
>>>

...

>>>>
>>>> Using Jonathan's suggestion from v2 to just have a single
>>>> property
>>>> with 3 different
>>>> ranges to chose from seems simpler that this. It would only
>>>> require
>>>> one property
>>>> and would be self-documenting. The description could be shortened
>>>> to
>>>> just a couple
>>>> of lines.
>>>
>>> I was thinking to add the range for this property, but it looks
>>> (for me
>>> at least) more complicated from the checking point of view. The
>>> driver
>>> is supporting two family of devices that has, each, 3 different
>>> voltage
>>> range as an input.
>>>
>>
>> Usually, having a consistent binding for the same thing among similar
>> devices is more important than how easy it is to implement in the
>> driver.
>>
>> Since this seems to be a common pattern, we could probably justify an
>> iio_property_match_ranges() helper function that would simplify the
>> implementation in drivers that would need to use such a property.
>> Then
>> in each driver it would just be a matter of making a static const
>> array
>> lookup table of ranges for each device and calling the helper
>> function.
> 
> Sorry for not explaining very well. I have implemented the range into
> the driver and I was working well, but I had issues defining the range
> into the device binding and the checker was failing. That was the
> reason that I've dropped the range from the binding. Also I had some
> issues enforcing a certain "available" ranges for a particular part
> into the binding.

What did you try?

The usual way is to define all possibilities and then limit it by compatible.
I think something like this should work:

patternProperties:
  "^channel@[1-4]$":
    properties:
      microchip,input-range-microvolt:
       items:
          - enum: [-32000000, -16000000, -9000000, -4500000, 0]
          - enum: [4500000, 9000000, 16000000, 32000000]


allOf:
  - if:
      properties:
        compatible:
          pattern: "^microchip,pac194"
     then:
       patternProperties:
        "^channel@[1-4]$":
          properties:
            microchip,input-range-microvolt:
              oneOf:
                - items:
                    - const: 0
                    - const: 9000000
                - items:
                    - const: -9000000
                    - const: 9000000
                - items:
                    - const: -4500000
                    - const: 4500000
              default:
                items:
                  - const: 0
                  - const: 9000000
  - if:
      properties:
        compatible:
          pattern: "^microchip,pac195"
     then:
       patternProperties:
        "^channel@[1-4]$":
          properties:
            microchip,input-range-microvolt:
              oneOf:
                - items:
                    - const: 0
                    - const: 32000000
                - items:
                    - const: -32000000
                    - const: 32000000
                - items:
                    - const: -16000000
                    - const: 16000000
              default:
                items:
                  - const: 0
                  - const: 32000000



