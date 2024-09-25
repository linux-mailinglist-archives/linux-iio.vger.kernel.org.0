Return-Path: <linux-iio+bounces-9774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA29864F1
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 18:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763151F25E93
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A244084E;
	Wed, 25 Sep 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBuE9aZw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A317C6C;
	Wed, 25 Sep 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282324; cv=none; b=rEerLmpBqe9K1rET4Qq1KjjWdZ1Qh4GBok9GZiwZySpBBKTliLTPg9ZktjO6kbHgUIJ5KK2BDfgSt1urUQ0N/DC9RnVZFxwG2QxP/Z0RXmgbshOwDQpnKTfnphsGsYv1tNOME2yt670MquJZ8eESuzYcBCRQ56OYvStYoEA2pyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282324; c=relaxed/simple;
	bh=AWnsj1qmPS/m6isTX9M3B7IZEnxlL916R1MIHdxfq3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NioJ1gl3BITEyimtHzeMTC9E7Oh5bezgJWkxTAK3XEP2wRolClzvVb4VAu1L6ZPZC9+hkQDZIk56LSbb3zBx4Rn0lrofF0M9ec/7oKlUqa+Kb1d2a4x9T10w2GQfnaMm5YazLhUeO7xl+mknF+GaAy4CHFzpfAQ+cBHY2hzdTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBuE9aZw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b05ba4192so674715ad.1;
        Wed, 25 Sep 2024 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727282322; x=1727887122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PK2m3Ze63qRkSazwclcAjByMVHVEVpFHvdModCOxYo=;
        b=mBuE9aZwF8iXsJN6zB72tZeBNY/I7gvYvkxw3cU9bCZWTu2SiPNFrE+cnPEFWqfDFu
         vMoqleV/lvNrydUN8rL9f+GboN7A+/xKWDWsZqEQ1VtGiDPQ5o+p+METKzf2A8odYdRw
         cgRZEHefz0AgImuzPX7l9kHc6Ow5URSEFx2u1E5/LtG1d12Kk1N4WIQCwaI3IlOYhvRH
         DUFekIndIn1EvtpAZvE554gFrptsO2aoDSvnYZ6rE/C9rDlXr2gDNWDWKMDflMMxLBOS
         /gXRC4yb7xMFfy8/c83Pc2dfZa+Lm2F4z4OD9DILa/YYgSKzsoY/a/kYyVYl8iqbr5TH
         f+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282322; x=1727887122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PK2m3Ze63qRkSazwclcAjByMVHVEVpFHvdModCOxYo=;
        b=KMYyxdZ+IpNgKeEUeSvtRfEeg6dHl/FKnJHGbe9QK8SGGq9iIPCd7v2FPPsEuMZ5r/
         roKQOlKm10O64+vix4ju6Qi+KXaFHJifYTpQIaAHsi+dOli+/8rIzacsrx/uOR4hsoBf
         FG+ywQuy1G2MChP3j7ZHGm+O2bsOjDeCsG7CGnrCIsP4PXGjjqWKcF0rt5BthSQJuHc0
         8ms1AQcanH/2fUu5SbFvxpPDvlE+PPKsnNUeTTRIRFr2o36BDw+KzPOFnvPY+OLec4+V
         MaahvMzgfAROBG79dMDblVXJWHp1FUyC8VWTaK5SXBh0I1HTgJAP4wWKChxI3LeVmjtU
         42pw==
X-Forwarded-Encrypted: i=1; AJvYcCXFK71dAJJrbu+pBBBFEUmeAyEvcgNGXuDTA+YebL+tnu3Fx5Kergz4g6gwDVd51fAOZrWkBc1H0UdU@vger.kernel.org, AJvYcCXv3BCA4/vwRRj/Q+BxMkNkafLpln7eEFaGfdIlSAKxN/eJChXw2zPUxff6UBjAC2XQWBsjh/dQTAlx@vger.kernel.org, AJvYcCXzubIK3nJqaZX0yzr70qamOEUeSKwRcPiKx3oKybaUCfMNhMTiH2kAYK44DsdPzxESUSzHk6qH+uuYOeOl@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8ZWGdUa2fYIGBgpvvQLwVevIpmcr87bWcMJwLOqimW5dYxN0
	ixNZ9awzuSKnTD9txnpbWQPAXk0oWVXYKrV45Pa0pE+nQkET/pU7hBhXNfhl
X-Google-Smtp-Source: AGHT+IG7u6OiLVb7b0zYZ1RAnRCZKp7t7FjbLFYBGhUZUARkL5hQevdWnRq3/E4qbCOgpdV4D8dgBg==
X-Received: by 2002:a17:903:183:b0:207:14b3:11a7 with SMTP id d9443c01a7336-20afc6a1d36mr21038375ad.14.1727282321908;
        Wed, 25 Sep 2024 09:38:41 -0700 (PDT)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e1813sm26367245ad.144.2024.09.25.09.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:38:41 -0700 (PDT)
Message-ID: <bd02cd8f-fdb0-420e-8c3d-f050b1298a24@gmail.com>
Date: Thu, 26 Sep 2024 00:38:31 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
 <20240923-add-performance-tuning-configuration-v1-1-587220c8aece@gmail.com>
 <20240924215912.GA363446-robh@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20240924215912.GA363446-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/25/24 05:59, Rob Herring wrote:
> On Mon, Sep 23, 2024 at 09:16:10AM +0800, Yasin Lee wrote:
>> When hardware design introduces significant sensor data noise,
>> performance can be improved by adjusting register settings.
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   .../devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml    | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> index 64ce8bc8bd36..417fbc0bb205 100644
>> --- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>> @@ -28,6 +28,13 @@ properties:
>>   
>>     vdd-supply: true
>>   
>> +  tyhx,performance-tuning:
>> +    description:
>> +      Optional, When hardware design introduces significant sensor data noise,
>> +      performance can be improved by adjusting register settings, including
>> +      but not limited to sample integration time and average sample count.
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> 1 byte is valid? What about 10000? Add some constraints on the array
> size and the values if possible
>
Hi Rob,

Thank you for your feedback.

In the next version, I've added constraints on the number of elements in 
the tyhx,performance-tuning array, limiting it to between 2 and 512 
elements. Additionally, I updated the description to clarify that the 
number of elements must be even, as each pair represents a register 
address followed by a value.

Best regards,
Yasin Lee
>> +
>>     "#address-cells":
>>       const: 1
>>   
>> @@ -65,6 +72,13 @@ examples:
>>           interrupt-parent = <&pio>;
>>           interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>>           vdd-supply = <&pp1800_prox>;
>> +        tyhx,performance-tuning = [00 00
>> +        02 17
>> +        0D 44
>> +        0E 44
>> +        0F 04
>> +        1F 65
>> +        21 65];
>>   
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>>
>> -- 
>> 2.43.0
>>

