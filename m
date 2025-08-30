Return-Path: <linux-iio+bounces-23456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADAB3CB13
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A82A5E5AC4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7352253A1;
	Sat, 30 Aug 2025 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MANnYzIa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524592147E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559377; cv=none; b=gJvfFes/BwMBqKxpmFkTbCC0+O7QHFfm/+6Iet/Pxz1rgc/l0RbxIdnUNUjbMvuybVcgibT9jOnVVddwVG8z3U6gkUKcFFW0l4WQ0M9ZCx8sEedXMQIXKsCKDZ184V0X/RMtKEJ7Zg9obaJVJXyHTQzWvi9387xeIzdA1X0FFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559377; c=relaxed/simple;
	bh=E+8gaoJ2YD8eTRn2TEIvrhYnUYkXpKKcBdMxCF6j6ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD6TNOZLS9wxxuagFvQY1o8tcCMsQ9tVSNmo24EwwoKyvjD+ThYKo/VKqra9VB5NFJ9MUB1NyARh1SsA/J3w0N7IlHI3bXB/xMut7snPz3e5yld5QZdmTZf7i9jpE7ZZZVwe06qIU7X21mTLjXg5kO0OpNZayXBx2IYuGFJD/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MANnYzIa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7f52cdf6so507155e9.0
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756559373; x=1757164173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NvZr+jIhkslKZB56cSZ0aYjmrmFIErH1qN8pLQMr07w=;
        b=MANnYzIaw/jywGoOyO/2rDmg18zjyD2Vbof20/phNpxQBiYdxP2UsMkB/1bi3d47HZ
         4XYO5NWgQUpBdBQERfyNS4sx9MlWX+E0OA/pioqRCjP76TeFIznHFhYnLfLurzf8nRyP
         /kZ3E9ZQmeitxG/O9iQtLdDz57s/iOnYI/VBIYEu8vpM+2px6En8u2YZIyuRgCglQT5n
         p3oHXfOjGd30x6XC1RB8ylCxaWvvSy13VY/ygLSIjD7yyQ+FrdYZp7/3F7C8p1yYSHnf
         smpPclhSJZ0dFOoJ8j4wYKbMNZ5e5Ot/dqLyVEMBjqLW7PMuiGP5hJpUw9UxIJbDuiJ6
         0kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756559374; x=1757164174;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvZr+jIhkslKZB56cSZ0aYjmrmFIErH1qN8pLQMr07w=;
        b=H/r8pRD4HQXgAIM48jSxDab7duOOm2KursAHgK19jRbj65TaUtH7Bd+o1XJ8IhMYuM
         QSrjNdlvLwJ59La8VOzPvAUC5avoThq0UsGl5Om9cswwKX//1YgaP9Ggl1hMvIidr+Ep
         3k3/B2K9Jsmej6XHPuwq8a/q2/ntCbKEtP1Jl+BQx9qLQESKpkmlV3OM/IVDYnaWLix1
         ozfmEt2K0zrtBUdRrQIaH8mBdvYDfs1794+TEBAJMWod63LtU3LM4YT8h+UoY+MHjwvk
         t6rMzOLYCYKihWuDW8D+MRf+lkhtyZY3d6qasF83hgDYEf55Q8cLbMv1C7W1tM1RiUlG
         foaw==
X-Gm-Message-State: AOJu0Yz4jA+frgLH2yLVGdJm3n5+P79f5kYNHblC0MH5hFZ1UyUDrcC3
	C81XVLZ/9Kt3bKR6lmQYOJskGDnECWAg+MJSJKwdb/iiW1XNHOZm0G6KAbLrM7NhcRQ=
X-Gm-Gg: ASbGnct1z3L7mRXNoyGPQOX9leJKdhghSDdRzy1BFF7hKDOkk1pc1pTmVXxl01J/d1y
	A6OWI/BtbrDf36kdBrkHJ7NDhm39zfkrsUaMLUGvuTe5Avz5Hy5XHXf3+rq/GF/9st45/bESGT0
	G6kY7aYuA29p+lus3uX2LrwgTchV5foLaxTMn4vaYf0KT8WXAdUKyqT+bWEeZ/6jDLfWeRzaXdY
	6h/SZxlG5DnD+TlueFIqn74RUyhKF2sM3OnB59uiImibwwi6sPVrZQl7eKS1T+XQH567EP633Vn
	Nek39PaiUtR2xN6x83RuGNbeiisSHDg/53hQvUE6iwaHaptYUZtqJx2X0DD6wE4DVPjZZELz1vd
	tRDcqgBtl3hZ9K6/Pm1GSnuV14KvW7D+iRZ6ANOggVTA=
X-Google-Smtp-Source: AGHT+IGa11CZQ7OVZSmolgs+BRgFwXxqJG6ECjAUdkPSx7J7mhDxvu3DET96g8lfamRAEETYvSkTZw==
X-Received: by 2002:a05:600c:4f8b:b0:455:f12f:e3fc with SMTP id 5b1f17b1804b1-45b81e92f7fmr22047405e9.2.1756559373590;
        Sat, 30 Aug 2025 06:09:33 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm84593585e9.20.2025.08.30.06.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 06:09:32 -0700 (PDT)
Message-ID: <2bb6af10-c74d-450d-9932-8d161ae56a85@linaro.org>
Date: Sat, 30 Aug 2025 15:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iio: adc: exynos_adc: Drop touchscreen support
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
 <20250830-s3c-cleanup-adc-v1-2-de54dfb1d9ea@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250830-s3c-cleanup-adc-v1-2-de54dfb1d9ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2025 13:09, Krzysztof Kozlowski wrote:
> With last user of touchscreen via ADC (S3C24xx SoC) gone, drop the
> remaining code from Samsung SoC ADC driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iio/adc/exynos_adc.c | 196 +------------------------------------------
>  1 file changed, 1 insertion(+), 195 deletions(-)
> 
I need to drop also touchscreen-s3c2410.h header.

Best regards,
Krzysztof

