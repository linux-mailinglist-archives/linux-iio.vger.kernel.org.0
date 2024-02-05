Return-Path: <linux-iio+bounces-2178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD58495BC
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 10:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60BB1C23E9C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3D11729;
	Mon,  5 Feb 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJQi2Nrh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197741173D
	for <linux-iio@vger.kernel.org>; Mon,  5 Feb 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123619; cv=none; b=F/6mqyBXwLzAaB25qIm2RRwvmiM1D5yLrpXrGA851HFYGjA2RzdwKz1O1jDBNxM3p86tA1y8R6g90+hMv9SDU7gGFubsa4LDg806hj7n0m6nKgJUyMPJGap91zF/n9iP8/FoRP1bgZf9THN2c6YuIgYQwe3bOsze0tcwo5Kv+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123619; c=relaxed/simple;
	bh=8XAEXMcfKyDOlyuJc+4c1+YmrhgnjUG5vVyjB5Atp+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4vm9oE/GNoy0QPSi8xdCQ9f9bnk8umf9gAYSdcsOgKsnxObUxQg8JUzYscfSo3g5PjjiVEAbfiNGDUQg7zvS81/AWHlhks4z22mPtbBlOjgIrpW5KBz/ANoG4GoFGN+FQFmE3wYKm6tbKeFKRQr8d3xqVOdvuE2bdoeUuAGFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJQi2Nrh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36597a3104so549160666b.2
        for <linux-iio@vger.kernel.org>; Mon, 05 Feb 2024 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707123616; x=1707728416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwoaikNRM2zOPoietHfOMYrjkaXPjrcL8r1/dFYYbfo=;
        b=MJQi2NrhHqyJgDcGkbXWnRernI3j6lR4e6tpFNcKrICvT8dl0ZdbX0+xnonUTVrbaD
         UkzmPlU6IyBU2M6YY3y1E7U4ZbuXLEqrmQ0Jpl5M3tQi/C33++s95iwaVy/XG9qmswWV
         5LNir3oFMeFos//b5ZrXFR80cvWCDFHNk5KRpR2X0Aa6fsCTYWO+z6SpfszAtFgv68jJ
         8qTzd8kErzhMcv6pXEJ6ko70e3EsE+52MjQKzKLo5kQH5R8RNT1o/DfpuNoibVw8WBGj
         ECfOXhSEg5Gvi4UT1+PPFp9H+15vhNAYBDkRYDE1slWM1IDa/dLT2s3+1YEGvVKITUuA
         PWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123616; x=1707728416;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwoaikNRM2zOPoietHfOMYrjkaXPjrcL8r1/dFYYbfo=;
        b=h6tKw0elZHcw+tJV2+A76UyYUsqA3IC596pGx2DtXHk3ua6no0+jdojajA4LGzRrdx
         sLSYVw11HY856PZSmrBb8D1KVeuWeh/ljadLn01Apa05gS7ecz4Xbvg0CnqCYdHq9f6k
         SdUrrs6TPRZcvXcaSF5QmnDbOfYQlCH16dZs3gH+kG3NyiMpToLPrVgvXtGBZeg5xc8f
         dBMLgQrhqj0gAqLmjaO+nXGGiN92B1Jp5rzT9Fe9OOxbVzQQ9OVHa4d7tViDjkCg5E+X
         pXfhmEdTd5jXmqZIn1T36mbRXeMIT08j+4rBzZvkm8XYC+CC/59XDmyEquxvYNwBjqWq
         AooA==
X-Gm-Message-State: AOJu0Yy5tqrM57Lyy+k+hrGRAY004lXK9d0cLILG/hpvaA+A40Kc4gxw
	pbJgCN5jR8as/qAPvMjvfPYTvdsfLYkcTQvgh9EPds3kdtf0uW8ACCj63wITd38=
X-Google-Smtp-Source: AGHT+IEpKEmcDuginPtv9rqgDD+mzeG0wluHgbLqH3q5+5WkFsYXWsIikIQVfPPVa5sncKKphEnxqg==
X-Received: by 2002:a17:906:2302:b0:a36:95cd:5e69 with SMTP id l2-20020a170906230200b00a3695cd5e69mr6743060eja.64.1707123616347;
        Mon, 05 Feb 2024 01:00:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbBoak3l+4eC+u5YWN8b1T0s9IPV60NUt35+NmM0aguGHvWBjnApoJm9A8wrknYnDYhxFF38VDGYQS5wbmBead5vkMnEMd9j/mIT9SBFCOCQiHfjA+8+C43zkCAGeD3Q41f/puC8ParBRkMlG9qEn+dGor1F4Bpa1yhRNc93fRWnwF0jYac7pQyB8GlP8H1fPhMOjBfN7nY3PMYngYGKZkvk4fYGm6TvzZr1KF1w==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vi4-20020a170907d40400b00a3702ab71f6sm3862493ejc.206.2024.02.05.01.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:00:15 -0800 (PST)
Message-ID: <254fcb89-5256-41b5-a751-4bcc8bdad5a7@linaro.org>
Date: Mon, 5 Feb 2024 10:00:13 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 robh@kernel.org
References: <cover.1706961432.git.lorenzo@kernel.org>
 <942452ec9626bc1166501cec0fa88c369e28ec6f.1706961432.git.lorenzo@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <942452ec9626bc1166501cec0fa88c369e28ec6f.1706961432.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2024 13:01, Lorenzo Bianconi wrote:
> Add device bindings for asm330lhhxg1 IMU sensor.
> The lsm6dsr supports the features and functionality provided by
> the asm330lhhxg1 via identical interfaces and so is a suitable
> fallback compatible.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


