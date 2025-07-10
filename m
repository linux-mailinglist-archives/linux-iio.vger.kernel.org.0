Return-Path: <linux-iio+bounces-21548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F7B00E6B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250A91CA0D83
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672862949F3;
	Thu, 10 Jul 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Brg2Gko"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005D28C86D
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185020; cv=none; b=uKcso66W60lZ4qMbkVrcw2/74UqMLGws8wmom5/+XzH2iIZGW+TNMmEilP2sc0Rm+ZqD9tt7mowvCzEvX+P+gVt3Iesh1AsWXaPUiNGZ6EWUmaMfjcHW7yeHKLYCMZtSKbVVxZW+8LnHsv3VOCLr70smEmQMbUjaQaPLJwJI/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185020; c=relaxed/simple;
	bh=GBGFOa3OG0bj7emHNsuxL3vym81UWq+35MLYq0J6UwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gK1Mj7I/PZwi3zC9faty1aYA/+4138I/2AEPByZcWM4n1c4yFmnLauFY2wJWzjo/Gclg3xe81mJ9Rci5LRmiXOyvgETURlGl4vZag19z2uODcVxuRgrZ9XhGpBM3WPmlNTRUNvXr+Mhpy1oU3z0zgUaA0OgBvu3EdRCD11aDpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Brg2Gko; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2ea080f900cso315378fac.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752185016; x=1752789816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9izK7SdU2Zvx1a/5FWB+N7ETLSUOq+w/2KQJDcsSTjI=;
        b=0Brg2GkouhovksBn0FMuw1GLVrlcwjw7QNsGCWpbEjXNt6Ww/7sCdWE3gN51sYe13T
         s7USSqnGhoS/ezRN7p9GOJ6n/yFUKbN57iQukt94ZuCE6RIM+Nn7SzmnYrBVDgrhBG/q
         3TrVx5Vgq+z8wiwPPrUr7xFwVNXtiyvAMH8x0PVx4mnc4eeo0ZluYfH20LRkB91yJsam
         KE+8coJjmCx9hZdW3QmEsaPXOvPrMNj2+9xdNVZGV7Fq79InYR/qOLeEO8k/dbv12P3m
         +TD6OPSLefgMm5NyfoSqy+2vfj0cd4o85gcDmrkNexpj8k6IbMDZy10vuUS0WJn0Aiv+
         kaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752185016; x=1752789816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9izK7SdU2Zvx1a/5FWB+N7ETLSUOq+w/2KQJDcsSTjI=;
        b=Y6+d0ngZlGZnMGi7bH9BqrjZpd7OZXtdpdr/CIi/Ivj8nQfcvc7MsmSCUqI0CWc6Ro
         vDSfhmFDqaW+McPxEnf01sgL6GA5Sxs3TokHaNT/11YYrwcw0ji7ubUmzdxpUD6vNYyo
         chkUqwatZ9KtoztM/wQeFEKrG9VoIZN4Z8fNmqQnTMdQnbL4Epekcrq6rf+C3M5oqjwb
         zN4i9dEi5fPuGBUDkyp1KkM9fNutHsV8SSgEPCUE7AHUGHqwCkhP8okoMLQJJ8mw1ijq
         Ged2ExNiU+uwVLTsfCVOWNkvdM9kTCw6BANFDs1b5j/+Bhq8VJZGzhKeuYvYIuMTKBY4
         SaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXvhKCYHavQ5N3YR7I/ir2IrXIuuXbzIf+2JMLp7VIoyqywg2OPLJmzt6G2w2k9EjEMsblxv+T1vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypM8df/zSNi+MjzHe9nQ2FWaL7NKdTR9jMgpam6r48hengz26Z
	fhjNsiFiZvH+Boi2ktBN2SYFAxFM/CSVkqq89mLr8YCk31z8aNjH3KHM+ZXmgjlSrEQ=
X-Gm-Gg: ASbGnctIjrTc6b36s/r6yrWqm/I7bkHj5AzF+bKp5xJ+UOliLXqGsXQp0V5Nj+TZkBo
	LxAGqZ8jntq+++anCbwbmaX0Q41z256KU9jFYdANcr4wsxq79fpTRlSTMZVmMy8MYti40e/K0Mm
	WWY9wBwwAnXHLa1NJaszS7LOXh+Ah6ZDFyzDMYsDUyfQvj8WfWO1xDzpROGeNKo6mLuC2PfeaWF
	YpK1xUpTgqdUOjcgCKSXhl0DSAjW0o4jPz0JkkbW/X/SFy4KAFKHFndLNU+FZ3H5os7UJjw3bJg
	mEYhjWcJj2KqEmxZjkE+Tku/lbeb33Db6X3yBELVUsgzH2EDgfiiyA99TrCKDv1PYRzwMcpX69K
	OqmsGP0o9KNfFWS2bMsjxbz8RwAK+y+OziFTWNgY=
X-Google-Smtp-Source: AGHT+IF918+idn8XbuYk1pxJjyhR11cy74s8+fiiK+vUPWZIkXXrlhRZQhgtsrdlFHaUc64rxkaPlA==
X-Received: by 2002:a05:6871:5293:b0:2ef:14cc:caa8 with SMTP id 586e51a60fabf-2ff2683c72bmr674426fac.3.1752185015594;
        Thu, 10 Jul 2025 15:03:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7? ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12725d2sm350520a34.32.2025.07.10.15.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 15:03:35 -0700 (PDT)
Message-ID: <8c599d2e-a5bb-46e9-9f6f-781a6933fe1b@baylibre.com>
Date: Thu, 10 Jul 2025 17:03:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7313: fix calibration channel
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guillaume Ranquet
 <granquet@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com>
 <75b46712867097cbe7a4e7bf070730d5c524149f.camel@gmail.com>
 <20250709165819.1015259e@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250709165819.1015259e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/25 10:58 AM, Jonathan Cameron wrote:
> On Wed, 09 Jul 2025 10:33:32 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Tue, 2025-07-08 at 20:38 -0500, David Lechner wrote:
>>> Fix the channel index values passed to ad_sd_calibrate() in
>>> ad7173_calibrate_all().
>>>
>>> ad7173_calibrate_all() expects these values to be that of the CHANNELx
>>> register assigned to the channel, not the datasheet INPUTx number of the
>>> channel. The incorrect values were causing register writes to fail for
>>> some channels because they set the WEN bit that must always be 0 for
>>> register access and set the R/W bit to read instead of write. For other
>>> channels, the channel number was just wrong because the CHANNELx
>>> registers are generally assigned in reverse order and so almost never
>>> match the INPUTx numbers.
>>>
>>> Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---  
>>
>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
>>
> Applied to the fixes-togreg branch of iio.git.
> 
Just noticed a typo in the subject. Should be ad7173, not ad7313.

