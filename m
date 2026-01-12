Return-Path: <linux-iio+bounces-27639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A1D13470
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C5C3043F34
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532226F2AD;
	Mon, 12 Jan 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HNZqkUFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4624A069
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228887; cv=none; b=MzurJ+bcIYs7dU+G74RvqGA+ozXP5Sc6SRkkiGo1LZiHcprfW0ZnGKlILK9kojeh0gxu+FTxIjRqal0N0HUaVEdXBwHikMAHigcIkJSNgXJxq8EiEP4lQv7jRoh93W6Ku1drVz72kfibCqsUIeoIXb5x+7K25Xas/N+eiHvuAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228887; c=relaxed/simple;
	bh=qZZHS1R4xLS4zgalA/gyx01MgICJsIzmaoHvIOl6qb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3VTYooho3wFulqhfilgO8vR6X3fviSCxg0IpuF5kKb/1R11jXkusl9LWw7p1M8J7Hj9Y+lebnzFZcUIec2urBz7f/CvNYB8jtHCDbRnYL5aDHrms23aUbkj1XY/LsNkqaCKIdEjbjJhFFewEQzpY87wtfNFBo6kTKUgwWeLjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HNZqkUFv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c76d855ddbso2125273a34.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768228884; x=1768833684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/sLKRuQj5vG1Kuv5GOtqiWgAZD9RPOmY06hK0FQGGQ=;
        b=HNZqkUFvm0+kLs8owPFULIQmnpmGjtRb5WDzG+N+OhdAKk/jeVswNAsvYW6T5+Ftx3
         cS5eCgSQ878aNasXUKhGMJuorobjpXBVOWW9DhT0MmWahRIfwHx+DOpBF/i3mbWU66rE
         NwzKHYQFT9NCZnem8BJF93CrTKP/WG31EhIAEvUSmh/5+dbyNqEmc2VmV8AUltHathDf
         4fxIDRsYakDh54991yvDWIF5kHdJ8x2G+/ZsyM4Ff4zssEeDcOG2Du9HgTsGE/5N3Cnh
         fQo4WTuJGtdE7h1J+snQI1NbI/QuFYcn8j0A5FUUXbG4FStJGvOOE6e5Th4C8SgIk0HO
         NBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228884; x=1768833684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/sLKRuQj5vG1Kuv5GOtqiWgAZD9RPOmY06hK0FQGGQ=;
        b=VtQMXODcfTKBptEyujQcGtDmshlIZTcbzyAFumFR/gqODvUoWrDOe7N5ET8knyq4oL
         XWagfo0/MZci3clSBsuVTHIWgNaNKVKH2KwgL92udrSPJfLYPwXk7qLqDAmIjvRT70aK
         Hdkp4X6YQwASAiEcZsgFVuztRRqOGJwdsA1qnytzW1bMqlNhPuOi3AiKjMoc8ujU4T+G
         v9pV02yU5TuPGV5Sc57KTyhNMKcHdcsybQsnRJ29XAsh6/qyTBjYm8r8Wa9mJZ46EJxb
         /x+Ya/m9SmQ/E7PFB6ndT+Gh7/5NOL6yrsXeIFbzDI6CZIJYPW1XbmJfd0fQ8lLx9UfH
         vNww==
X-Forwarded-Encrypted: i=1; AJvYcCUkR96Yq/HcFZNOOzIZh9LaGJq2WJRGdLLyaPbrKV7ff2ar0B3g97j6/65nlMqBZKTEXMvqiTkmRuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVmrncEmhe5rGGMZHwgQ+/7DUw7hQcnpgOkqg3O3U4Fdkd3+9
	L4pm0eOjKYvmW360GNo4YHxMO1FdxDbuCgQGzQ1IRk9InstNBp5a++Oz4VYX2AY1wKE=
X-Gm-Gg: AY/fxX5YRV61w5qrdBR4nPJZqRtfma07aCBB5s4kd9mu3NqGXXyZXLs+CG+AB1lkegx
	WemotZk17VdaLlyXVD8l467fNFwzazbyA8GGKaEUJYBYZnO9Gi53xd+YgXRlz7tKuuEQtbYa1mX
	qSF4CGTDlu1ljtAOfdVSt9lfEdFrfx4+Z1/V49NSiWYBXYdg2C5p2rdXYhWg1qTnoC/qWij6PQS
	rfcYQoYn4O3JfRK9mZyF8mC1e1G9Ovooev5VB6KTpcltKRweG6okCluh3NDTtfO+fJ8fQAQqICJ
	cCpjGRt58qfqNgDdBDC/3cYo+FSbThc/euErDHHIUYp20+WOy61io+e7cRiIOwIoNXvG7CrHXa0
	0bKhEfhFT5754WyLplJkeju/0lgV/mR7fYyM0o+l++hnHzdxWjNoSFwonLJMmKsjntcLToL1S2F
	/cP4GNNq/VN1o0zw2H1Bk7pSrVeHLtPIWo97aJ5Lapyt0dxwcG3ety6NsxdGKN
X-Google-Smtp-Source: AGHT+IFVkCHz/WAcMVxHenTtbJnGTGBZ0KG5evvW5KHsPZudnryOg54Lm8P0MELlXtHKRRirnnSN7A==
X-Received: by 2002:a05:6830:1cc2:b0:7c7:5a07:303e with SMTP id 46e09a7af769-7ce50ace54amr7836962a34.36.1768228883973;
        Mon, 12 Jan 2026 06:41:23 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b4b:49b3:cce5:b58f? ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478da6f6sm13113563a34.25.2026.01.12.06.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 06:41:23 -0800 (PST)
Message-ID: <8b203e02-aed7-4acf-b6fe-9b470717fce2@baylibre.com>
Date: Mon, 12 Jan 2026 08:41:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7768-1: Select GPIOLIB
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 kernel test robot <lkp@intel.com>
References: <20260111165528.284067-1-jic23@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260111165528.284067-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 10:55 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver provides a gpio chip a some related functions are not
I think you mean "chip and ..."

