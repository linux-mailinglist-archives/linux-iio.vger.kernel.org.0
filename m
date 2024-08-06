Return-Path: <linux-iio+bounces-8292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB89495B3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D2F1F229C9
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6540858;
	Tue,  6 Aug 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaKBnsTf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33262C697
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962411; cv=none; b=Rva+UnQAyOhB772njwU3lhypJxtsA+wnJTCDvkyjhTuWLcSYBsvSrcEsx0WsUimYIk1fJwSrApVD3+b6hZaRfa8TnbYpspduz2pr9hEdtdRcOWxBU5MI9i99Ui9+jzoVj1ch4VGBQJuXItgRVAaA3ti/Cyo/4vzph6PGHrm7tDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962411; c=relaxed/simple;
	bh=dYdFE/dwvoAPoZ6iM1wT1diF2Sl+VF42xn+CojNilcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aysRa+6KVeZrD7peZe1kTShVeVJeBh3D1MaJP3550ll/VfNg458cQ56BEJT3dkN/D4wx78THf/wqq0uwzgyypzTgARgyiLCdxP+W6JPWkrDnuiFwuqmI6UQo8iikFyT9F72pnyX6T0i1u5QhZwr8muxaAiavFE60+bZ4zmlIFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HaKBnsTf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1171393a12.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Aug 2024 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722962408; x=1723567208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Alci1thNEq1YcGmCv0/p12gUk65iFv7MOBENpGrzHXk=;
        b=HaKBnsTfztzUGxQmrZb8Dxk0RqmU56xhCS+2kPIZwa88NCq2ZudXbhnz6By8JRlUV8
         qhGYr5drzkvXoU94xnpVkvYHsbHKulXR1U+DIzdgb/dG2pgZ2BMbYfIjdOpWiwfC/BPh
         AGjkmhP+C/7vStO0fdoGboxmJV0iTjqxfHkA0NNWy+S3t+h1Sn4D12kymdMlnADjRL89
         pbv1DT1jgcGqiWlgLnrfFIp0Pt3iXEeVyDykoDUFgxaWixeyZxolxjeYZodFgaatdUNF
         vkQ3r4AOJ6fE8CZABkYxMUdVI7xAY7ODg95l+CLYzgLsEv58kK5iYeJOZJBZtrfTWiWq
         WxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962408; x=1723567208;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Alci1thNEq1YcGmCv0/p12gUk65iFv7MOBENpGrzHXk=;
        b=h6gcXvN3fshZowRFaP6ZWKHNOUsze2BvSizJ/gJJATEFILB8jShTKHY5PZi9wID7I4
         bJW2lInY79Y083/tDHtj5jmlXByie/7xiisjNHSK2MbLccztnfhm2c8lYH+fGK41WFF8
         jDVNq6g3jVrziba7507tSzYQVkAuPg/qfGHSMSmbMGCpKbD9o8caWTP+I0LLIuknAuoH
         jG3Tq1bELgOHSjakC2vQtJdQ7DBOLGdAzDWlBf2UmYe1roSRK6PRrt9wzJbeehR6fpSB
         axlKg3OMGoZrtgfKqqdLyDzkFwgf7kZKU0W6+cnKSrDNZ9vwcUeQcPK9QHR52Amvaf+S
         offg==
X-Forwarded-Encrypted: i=1; AJvYcCWtTM1SF6nJuzOn4lbOAR+OX81O/5O83PLiMiubsABuy/q+c3laDEb5bRw22itYCuQh7UjQrI8o3zt+ufHyMLaQ0IIW+HLuUpTc
X-Gm-Message-State: AOJu0YzapufQKBsUXnDchyVdVw8fXG75Oo7+vTb3qU5UZ3RadjF5qNQu
	5ix7rVdp/jnpu60OqVTnenUbuhnfbOjLsv4T28JrRtgI5kYwmnIlhxQTaWsyI1U=
X-Google-Smtp-Source: AGHT+IHLVSRxCicPSh+8thSt9hNaJRdhbAullG/+SpHN3cAeVhOG/sF1aCmQ1D1o0M7PTQu96i92EA==
X-Received: by 2002:a17:907:e8c:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a7dc50a4646mr1217743066b.43.1722962408269;
        Tue, 06 Aug 2024 09:40:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9d95sm566872766b.10.2024.08.06.09.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:40:07 -0700 (PDT)
Message-ID: <0d7b2c67-d16a-4662-9d98-1e55e70c3205@linaro.org>
Date: Tue, 6 Aug 2024 18:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: asahi-kasei,ak8975: drop incorrect
 AK09116 compatible
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806053016.6401-1-krzysztof.kozlowski@linaro.org>
 <20240806053016.6401-2-krzysztof.kozlowski@linaro.org>
 <20240806-unlocked-womankind-f9e5e1d19055@spud>
 <20240806171113.0cf9b992@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240806171113.0cf9b992@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 18:11, Jonathan Cameron wrote:
> On Tue, 6 Aug 2024 17:02:49 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Tue, Aug 06, 2024 at 07:30:16AM +0200, Krzysztof Kozlowski wrote:
>>> All compatibles in this binding without prefixes were deprecated, so
>>> adding a new deprecated one after some time is not allowed, because it
>>> defies the core logic of deprecating things.
>>>
>>> Drop the AK09916 vendorless compatible.
>>>
>>> Fixes: 76e28aa97fa0 ("iio: magnetometer: ak8975: add AK09116 support")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Offending commit did not even bother to Cc devicetree mailing list and
>>> DT maintainers... Lovely. Let's ignore submitting patches and
>>> maintainers just to sneak my important patch into the kernel.
>>
>> :/
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Let's assume mistake rather than malicious.
> I should have noticed this :(

You have enough of patches going through your hands, so I did not want
to say that it was your job to notice.

It was job of submitter to follow the process - run get_maintainers.pl...

Best regards,
Krzysztof


