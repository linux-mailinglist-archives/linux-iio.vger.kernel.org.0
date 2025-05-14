Return-Path: <linux-iio+bounces-19508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0DAB64A0
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C27C16324C
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E752063F3;
	Wed, 14 May 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR0x2Ndv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0C201000;
	Wed, 14 May 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208336; cv=none; b=tfHyzt0scQwFLPn6GUdlOWb4ueRT3Ww9OtFBuX2FdOP8LPenDJWJCEsL6Mbt34L1BM2I6qBvgKPuCbmSp/OUywdESr5cOYe8F/ZfNzTMT51jkP+g2e72G+YU9UjwL1W9GGFC6ajVhzlg/VjecwP+zrAv/iZ+u6zk6pXT2Y8uZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208336; c=relaxed/simple;
	bh=DAa0sPr6fSEL4SZEc1d5IQPpRRilOwr3M/fzcxF22J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVyZ/RRokr+ZNdfJdzuLXZOOpQdbIzYkpxeiz0gA2SzrO4csk+s6QzbbYjMNyhLLNTF13URyCREAtKVnIR3tE+R+Gw9hNoPkJ9+S8tU9caVsR32go9HefT0goI87vP6SHeBKJtuy+qowmB0mjpi6W2gf8sADhY+r07XJi3fcbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR0x2Ndv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54fd1650b83so4528853e87.2;
        Wed, 14 May 2025 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747208333; x=1747813133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSZQqrU1+NqS1LGWUsRKBqTCHpMrM862CoPR7rZXn/g=;
        b=HR0x2NdvOqvI1erFNpXkpthYmD1idwSPAjbGNcaKXzXXxoO11fR7XBvnVtjHrVqMkj
         DWYWwS4NZiqIiW/VRyOxxzl5ebSZeXw9/iz9q3E0DySWVzeuD+TMjwXL56iVdR9olq10
         uT8oxMmZ9IGrymNJ687t+oY5uqbX4rEfRwVQOqk3Y9ShoujMNPP85FjHTMNmCiiPVg95
         3/Y/63nS9ouG9FG0I8Sh1PXtDydv+1U58LvzVqyWuqgD9zgHVehQKRt5G6DqrjZZQMib
         hmiBLSZpN/UFHQHnGAddTDmCJJ+DrgKBEtdCNVTko9H4cXr/4VtA/qtdZvaed8bBT14g
         CXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747208333; x=1747813133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSZQqrU1+NqS1LGWUsRKBqTCHpMrM862CoPR7rZXn/g=;
        b=N2SkIgiJSGmjozJsXVMKgMjkWWykWqASHLv6aDouHUEg+XZYd/pYhlUqWV7PH54bv/
         V/XazwR87+91FF/6mZBX9DYPajMLoxqtSR8zneZTAMmcbihH5S+PFDUvRyJTJzyDaOcL
         4oJLuu08lFtf1yQqxbUeQpz8Sm9qTP+0hQ+jin6rBAnVmpEa2HUzlcItaEjw1BhT666m
         /69+bnJ5DhljXwpcfw34nigxLKS7NcR2XZNILzS/dZ62HHDI72GULovWLpwh/WKUI3ld
         yHW4zGrHTsFx/45tc2SHaAL/roKdllQxPy4J+oN86iOKMchIiXZS6HkvJhNpcannwGLB
         N1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUoLXgh6x7X4BLmJYR3ghAAfj0frluAXPTKczighA5jT9ofd9S7VcTkl8Xu0W3W6FrbYZ8h0mm2J21o@vger.kernel.org, AJvYcCVsv3jMziCZXlwcJSefG9+XAUnF1KUoYJ6JxZJ/QeQfPC1Cq+VyN+QWtwHuFpeQ2Xh6S21gR7IyLIe46IlG@vger.kernel.org, AJvYcCXeRJLvaNAa/neIaJc8vVWtRbusZ/JzVMjFm7MjvhL7DoZV0Pi+BoW30PUiDBGKRCL4q9Ak+gY8YWSD@vger.kernel.org
X-Gm-Message-State: AOJu0YwSM3Y8sJszIru+OJ3nnfZncCV3WjLUqOOZ5iZyFTU59A9iR+xe
	9/86z1ermLJzok3jSsKO5Go2cZw9obHW+X2AaeaYxN2oUsJOYpUA8Fdjjw==
X-Gm-Gg: ASbGncsU/96S/0aQ09tNdMI61Rh5feMJsVoumxxb21I+UuAfCyEEEORO6GfwI42U8Zu
	5i5SW6bHMYlIoE9Hn8XKmdaZnAYyIM5sO4AhFra8/6q0Qs/c8+0Gs81XZLBeFQ3ARjD8lXqT6u3
	QH5Azr+eUHPsqMZjFmb1UzSP3YA7KeYIeSGlKFBxSvT+eWGNsn1YT4e8tjAXPIe1Rk36iTAbNpn
	zUh2R296hVhWsMtjnCdjWBE7e+tHTjCURu1fB79lXvyPTWX355zUX3nTvidDxwLUcn5UHd7vP0r
	GGdKK7QInykV0q5xnl289SH01QJUgxRB/zretUj1t4KqTKyYNXco9oBGaGtFnurp+iHX26jIhIv
	L2JZn4xYBfvjBYqSarf/G1Mc05gCSyPn+nhEvy5WTiZs=
X-Google-Smtp-Source: AGHT+IEsW3F7MzRRZH2lLovN2Ar1so/QTSe2OlLS1zaD0S/Gkt6PiiSFjFDYvcUtOXHH8EDdR2thKQ==
X-Received: by 2002:a05:6512:e9a:b0:548:de7f:b3be with SMTP id 2adb3069b0e04-550d5fa89e1mr826482e87.21.1747208332836;
        Wed, 14 May 2025 00:38:52 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64bf81dsm2128384e87.195.2025.05.14.00.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 00:38:51 -0700 (PDT)
Message-ID: <5f36c304-ed09-4a13-b22d-ceb5924c3739@gmail.com>
Date: Wed, 14 May 2025 10:38:50 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad7476: Support ROHM BU79100G
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1747123883.git.mazziesaccount@gmail.com>
 <a6d84a4c9cdd961fbda38182501983f26cceadc9.1747123883.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <a6d84a4c9cdd961fbda38182501983f26cceadc9.1747123883.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 11:26, Matti Vaittinen wrote:
> ROHM BU79100G is a 12-bit, single channel ADC. Support reading ADC
> measurements using the ad7476.c
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   drivers/iio/adc/ad7476.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

For anyone who might hit this mail thread later:

Conor made me realize that, for now, the BU79100G looks identical to the 
ads7866. Thus, these code-changes aren't needed at the moment, and this 
patch can be dropped. For those who wish to use BU79100G, please 
introduce it as

compatible = "rohm,bu79100g", "ti,ads7866";

having the ads7866 as a fallback. This should allow us to introduce 
driver side differences later, should they be needed.

V2: 
https://lore.kernel.org/all/4907a096eee1f54afae834213cf721b551382d4e.1747203712.git.mazziesaccount@gmail.com/
drops the driver changes and adds only the fallback compatible to the 
bindings.

