Return-Path: <linux-iio+bounces-26303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46991C6B0E2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 18:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 154ED3621B4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383882C236D;
	Tue, 18 Nov 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZwzGcwex"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A72AD35
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487966; cv=none; b=sddIyQ8xWm2DBBGOszjzKFskq+fkoLUXhGgdYCxi7JHMH7J7gKjFSifBwY8+gInkK4dJCGflUbCCFj/OYog8Z0B6bJ4T98se6ipHjKCID8O7iChAcmH5ImNL6Hlyx48p6jnDdptgkFWbN7hongUsrwJ2DF07rMvCDwtJdMLbX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487966; c=relaxed/simple;
	bh=IDXXPntONLtWnQ4H/+mhIZ/CKssmJVfOe9vQjmQEy+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXdi+hwsLoagYY3/IOitthdt2MuS5iFxSQzBpiHqbyPQ+8KetmzbOuol7KF4YPqkv7A5fR/FQwi7CzYq1aa3y/VdrEy1AIU/Wtbl0UgbGRlac51BR8MFYEG8gyVQIk6lmGkdu6iXM2LwstCYtbnMavu6an56Itl03o7zkVGnzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZwzGcwex; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45076d89e56so2616923b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763487962; x=1764092762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRB3SkR03cIdDSITzGw4J5oXKbUxrRLBIfPvKWW4i4Y=;
        b=ZwzGcwex5++eHc7+B8WWsnstjkfTiYsv1x0bVohUwjmyQkslQ5v+4r8nAV9m9kbu8J
         0P9j8j/U/KGuB2AnNifdK8bYARA1E96bK0kMz3b72dwM+pP50JvDX3JZWKxWulkuzL0q
         oqIS96iQJ/WBdfCltuhLVhW72PEi2hq3xdKz0cOeZOF/NHmdhrhnEAjeEPTOSDEtDzmr
         G/QMcVSuNH48WsHlXD5lUvWaVZFBnWS/glyJyvPKI42BUuRqvea9AV2ydwcDfZNLnLWX
         aoTJo4pMtZQnq0hpTfNO6k5UfdzTy499LkrwCJeZ16rMnBT6FLeoH/ZOHPcgzhIfsO/B
         T08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487962; x=1764092762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRB3SkR03cIdDSITzGw4J5oXKbUxrRLBIfPvKWW4i4Y=;
        b=UG6uC3mZ8Am65oYXwMv55U1JZaMFbSr7PermUXBjJ9xy06hDsDUMRUtydyX1VFTX02
         OIZCP7uzJwKnNmp0BIif5tch2f6vO48vZxOfxO3vJflnoqQdr9Ss/AqoTB0vQgfO1JsS
         B5rI28+Q0MVS6s9a9mnuKUAAzJZaKeXBKmhaUejLRHAsd7qFawgKzWFIBdwjmyBetcI1
         ZeUpMxxuPgT8d01Ik9jfrAqlIFGLS0lA04FYxm03mH2vydlDCUbYncnbWlMDydvxoHni
         5oufNHmppKg0bzNQuIRXKt/QfIMh6mSnUkY2aaalFXnFLYUco+Obx9VYTLN6Ccys4wgE
         1hyA==
X-Forwarded-Encrypted: i=1; AJvYcCX7VganRMpM7Ii0BjaX2Kqlr6apDAh1bLhKUP83+mB2uuG2XLu+KMBhqXAMHuSnXNjr+BPGrJXZ/5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSoFTRii2azVaBdBaQahoioOhiAG5BHBtr2P5ZK95T7UcoX4G
	nYt1jX02Dj9DqYkUy1HYTAISzvhfnRbFDDv2ipGt9/rrmdqi4a2MMD6A0xI0jIqN3Yo=
X-Gm-Gg: ASbGnct/NYeJax71K4fDxz0eacVwb+X1FPRtdCPxO3aSiOaMxo3Uc5Q365h74XB/kbW
	OtEQ+WqJ6UXz4zsC2vB/OM0i9ZGDxSTKEm7A9yNKkjgdNsQ+NZJyxRQ53azV95kd9g3SAy6dQxu
	k+lvcJursNqxOXt/veLTj/g4KGSebjT/HAn4wgr9vqsFzw1Aqz/CDykMJWuPiEjJUfq42TuOW12
	FVab397QApL0j5lo6l4ATqMKptG1j1oeiuSMDWyUOmr9+nXUuUUrFxIOo5TkId1Tpqt1+/k4v6l
	Km1D5UTx7eaVnUtRA6gdAoHrSuffssfqZljxuL87R6sksuBMHsp+DTApAWTaZfTqGBtfe1bgyLQ
	E3Db7L4Kpac4ldDX3wUns75rzkiRf5Y0d4CqfXRs7oH9INyQt4LVGBCHpwMerrwQbjdyZT/m+Bc
	Y88DbkCipp9EMAFdRpPivrGOyoz4voBNPyZkuyVsPdwyV5q4vgtbM9assnRaKN
X-Google-Smtp-Source: AGHT+IEyXv7o8silWSWiXUwK16E7SzqW9ae9uZ2yQok+gwbaS1AMF/9TQObjEohC0ILlJFcIzyAJfQ==
X-Received: by 2002:a05:6808:8955:b0:450:c877:fd5e with SMTP id 5614622812f47-450c878022cmr4423732b6e.19.1763487962096;
        Tue, 18 Nov 2025 09:46:02 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e86:179b:44b8:cc2b? ([2600:8803:e7e4:500:8e86:179b:44b8:cc2b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65724cb873dsm5554288eaf.4.2025.11.18.09.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 09:46:01 -0800 (PST)
Message-ID: <97c6b55d-9505-4091-8f0b-317dcbd70838@baylibre.com>
Date: Tue, 18 Nov 2025 11:46:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
 <20251118155905.GB3236324-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251118155905.GB3236324-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 9:59 AM, Rob Herring wrote:
> On Fri, Nov 07, 2025 at 02:52:51PM -0600, David Lechner wrote:
>> Add spi-buses property to describe how many SDO lines are wired up on
>> the ADC. These chips are simultaneous sampling ADCs and have one SDO
>> line per channel, either 2 or 4 total depending on the part number.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
>> index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fbc345f58c5b09083385 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
>> @@ -62,6 +62,10 @@ properties:
>>    spi-cpol: true
>>    spi-cpha: true
>>  
>> +  spi-data-buses:
>> +    minItems: 1
>> +    maxItems: 4
>> +
> 
> As the property is not required, what's the default?

spi-perepheral-props.yaml defines:

	default: [0]

Do I need to repeat that here?

> 
>>    vcc-supply:
>>      description: A 3V to 3.6V supply that powers the chip.
>>  
>> @@ -245,6 +249,22 @@ allOf:
>>        patternProperties:
>>          "^channel@[0-3]$": false
>>  
>> +  # 2-channel chip can only have up to 2 buses
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - adi,ad7380
>> +            - adi,ad7381
>> +            - adi,ad7386
>> +            - adi,ad7387
>> +            - adi,ad7388
>> +            - adi,ad7389
>> +    then:
>> +      properties:
>> +        spi-data-buses:
>> +          maxItems: 2
>> +
>>  examples:
>>    - |
>>      #include <dt-bindings/interrupt-controller/irq.h>
>> @@ -260,6 +280,7 @@ examples:
>>              spi-cpol;
>>              spi-cpha;
>>              spi-max-frequency = <80000000>;
>> +            spi-data-buses = <0>, <1>;
>>  
>>              interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>>              interrupt-parent = <&gpio0>;
>> @@ -284,6 +305,7 @@ examples:
>>              spi-cpol;
>>              spi-cpha;
>>              spi-max-frequency = <80000000>;
>> +            spi-data-buses = <0>, <1>, <2>, <3>;
> 
> An example that doesn't look like a 1 to 1 mapping would be better. 
> Otherwise, it still looks to me like you could just define the bus 
> width.

I'm not sure we could do that on this chip since it doesn't have
the possibility of more than one line per channel. I can add a
patch with a binding for a different chip though that can have
such an example.

> 
>>  
>>              interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>>              interrupt-parent = <&gpio0>;
>>
>> -- 
>> 2.43.0
>>


