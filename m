Return-Path: <linux-iio+bounces-24252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF24B84A35
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C8B1B27B03
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A0303A32;
	Thu, 18 Sep 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I5NSZtqG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217779DA
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199508; cv=none; b=Yf5f59lM1OnJl3O19MoqcEHXfe8uFpmnvoFHGXapLQCWwZO1GBAW95BEI7dnjzMStKU4pLOrSjpEXAM1B9kRBcxddBA5Qy9re/SEwiyZq9C/fTQ1zKMMRDxDPn6PcTppNC1xPoVgE1/NLMWLLVhrnOAuDGxCeMNg6iJjeji+WuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199508; c=relaxed/simple;
	bh=2r2DqH4kvoOqNFyWz3gLh5tGZx1qsaQVdjaRa4xm2C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSzFuA3pKJPNkrJoP8GfR7VPzPnYIIofALDGRg5++BnHKpSYqt9Gv9DsNuTIZvxvNF709sTmcmxgks6jcfPsqs/z2BZcwHh1s6J3smaD43nmPGhkkqPYOiScuX7vgYfOfiw7lG7Mqs1RdgPxaGyqD+8CAWnVszyRWdPLNOcWG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I5NSZtqG; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce5be7d0so384435fac.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758199505; x=1758804305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrHcbBVSV/CFq3OKJf1oeKcQfVMH96LOSkAo4pIa4YM=;
        b=I5NSZtqG2AD+0MACfQ0bN5pt1qTLK9h6jm7CrjLSY0yDfcH5RtDr+ehepqmUirorgY
         NiaCzu2FrrgljS6TlbFgoAIb5FOpbnmrRJRYExqisM6sABy6CIwDsyoZhOvRWIAqVS0Q
         GakqnnfKLDftZq584JXUK57fN6Icj0Glsf/71fT7/TgLOy/L5lydGf8djXxBoZmvlcdW
         p4dtSgwhRKOFOLLSCtt8H2teOjQYuy748QOvR4S890D3aoSb6O2AN3CrHVfZRw7JwXgk
         17FjZKPC18UJxaXnmzfiLks0/2X9IHzTRhGiLG4zulY3GGXYvIwgUJHrlibfLm9JyOZe
         9CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199505; x=1758804305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrHcbBVSV/CFq3OKJf1oeKcQfVMH96LOSkAo4pIa4YM=;
        b=p4RJ4MUOEkpZG0NJe++A/BkP3WiubriFORD4Q3KqLx0zerKHCj/MorLHFUKm3l2u+g
         Z13cSZn1sJ7N3V6wY2/8mBkPYSIr+udF13yPTNuTU+zvZExxdo6gV4pI8VXGIzVlanNw
         8easOqEEm7DOcPDdwaRKrgogKpA41QTDOwkAGsY5M0sxg7rX1pzqGYCJydxMkx7bFidY
         5Rrtk451xdes6PxDhcRwxdH3XkC0G1XWqFlmKe+d/fytFIsVZxMkxBLDTt7E6qqjUO9f
         abqBAm+S2jE6II5IesADMulqD+kqYS9H//4hsCIlmdPo67sEjlgPmnC3UWxpBpnUi1tK
         bTow==
X-Forwarded-Encrypted: i=1; AJvYcCUHjXtq6M5nmbA5CFeD90EY4D1jamYf3w2BFwgjhhMLZFSdRLQ7TXSSYXnU9j+z7htBfx9Dtu+EzWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEqUIqNadS/M3kzDmCqIakq4PxRJ+ro4S2e++i43EIMZzq5MR
	6Qd6u2NhcgK1rIFuNLN6RKaQ+fAWSLs4ErfUBl+BpVevr1kIuHSUB5ZRPapIIXqCY4923KMVUVS
	FNr6UATY=
X-Gm-Gg: ASbGnct/xsA8L7Shb48rjnbQXMLHPWCoUX0lj/Wduu6GjLfsyD15+9CSPgvc5tFif2/
	cgGBaQpyBhhittzzKEeWkHblgtacxuURs9ACGkV3W+oh8TapNuyonTDhjcWjcwG9MJUovsU2aMx
	C4WWVlyMfNNO4Q8uVNYBH3jJIiKDGKyisTzqm6H/i2ZZylFoAJOhflMkkDoNXp67003umVKKLZW
	6Wquhiy+f7zleBH+uP/4B2yKgHl7GuY5jfFVm7jYv6JnUUbgb2h7Ev2bfwLOuvspaNJID2SckhO
	QmMrv39KkoPYEvN2HFoHt3wjJcUSsd3YNunJVQ+5067fVouX3Xdy+xJrWGHsQhWWaf8bmNpRW3n
	a97hktDm4PGf2WIpCxqFquUMbA47GM51BShz5co/W50FI6lG44omLNWxy53qK+m5Qx3bwr2sbpM
	NfSNMwh6Jkx2TqfVNu+g==
X-Google-Smtp-Source: AGHT+IG70b8bbYjlcdip/AFDOzCWeuKNJgx5mvzujZIIYrYwil+TyN5Ijt1aBQfWNQl1ClewrC8Uig==
X-Received: by 2002:a05:6870:9e0b:b0:31e:1def:1e0e with SMTP id 586e51a60fabf-335bf200f56mr2999250fac.25.1758199504895;
        Thu, 18 Sep 2025 05:45:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e637cad3sm1393268fac.29.2025.09.18.05.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:45:04 -0700 (PDT)
Message-ID: <c18d6200-3f42-4a84-bc15-627d1a4174f1@baylibre.com>
Date: Thu, 18 Sep 2025 07:45:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: rtq6056: Correct the sign bit index
To: cy_huang@richtek.com, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Hsu <andy_ya_hsu@wiwynn.com>
References: <7e43ad09f814d63b570ab6b2b9fe3fe17775d22d.1758164614.git.cy_huang@richtek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7e43ad09f814d63b570ab6b2b9fe3fe17775d22d.1758164614.git.cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 10:10 PM, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The vshunt/current reported register is a signed 16bit integer. The
> sign bit index should be '15', not '16'.
> 
> Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
> Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


