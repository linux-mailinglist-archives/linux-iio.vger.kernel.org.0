Return-Path: <linux-iio+bounces-18292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3CA93E24
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B994F8A5B38
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25922CBF8;
	Fri, 18 Apr 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UGPpn5Tq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE09208A7
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003349; cv=none; b=eozpb3Gp+2qISqPFIAx4uHg0Wcxt28vPJl6wVmhuiaKfKct73+XGx1frrDvKJEG6I1E0RJffsaM8giKTaY9XppvNg87AltIQgyqL5ti3BihrxO9JRD8WbeNyqmkZc9NUxz8f7SOucWHhDZbGGJzomxzWP3Vk0VAg/7qPV14uxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003349; c=relaxed/simple;
	bh=N3mqmqfcODct2AexTU3blKtP+e5GHWSpg1sAN4RdBIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMzBvmMDWyImg5GG5aZCzABUWB6nrwfFxwkkNoevHrvHNLv5Z4+G3gI5JobxBYDgmWcR51JA7YZRVfdY0yIS52Rvt3ETpi3Q3ewddYMXk8Csl5Xc7S3sCiDscsJL9NOPY7/EkNRYycNWenobq9etSgCUNz03GL3A5a4VWmqARbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UGPpn5Tq; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f8df49e75fso429991b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745003347; x=1745608147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pG1Bxch6x3OgorYiiEYLNmcSoJ8xuGTKE7oUjof+wN4=;
        b=UGPpn5TqJRVZw95WO1yjvenBFuG8ug1tPfIjdf7WuDI4zD7zgob8LcYE6Btd5ylANd
         Mb3E1+Mem4b8dFDfymkHRoXaAqOANnZfbEX8a46r/7v5OYI5XGsj6F1TsKvob5EVLJ5k
         c+dci0ygUboCV2Hnt0+c8RGoocIAmgyMU9RzFZwAkU6pc2kDeiVl5ccHz39F5szAcNqh
         Rois1EWtiSRa1ywLhe4FFbtcUhvuzsw3pqaj8trSpGGSEFXIXkSOeBEs6vODDh/xX9gC
         WE8eF3BD1HOihVDMC8DdfnAR+8vw73QByksz1UTCuyydrHQJpIPOWGTt8vqqpzhZUXcV
         fSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745003347; x=1745608147;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG1Bxch6x3OgorYiiEYLNmcSoJ8xuGTKE7oUjof+wN4=;
        b=Qa/uQvIaX+8oYDtzbjfxruCHRVbWP9aRFYodBKrgdKeO3LnV17zeiJIYI96mOElG58
         CCJz8LHGMZb463z0Il+uJFh1JiOcvfJqlTC65iCYiBWuF0b1s4/OaOAJLacCVNrghBwb
         ijW4uzx37/KTKsHb7AOVFzAoowHoPQrABbzx5Erdv8BNhlBShNKpQiuIFgsHwbvq4Og+
         /kO3rEpAIJPaR6HGOfhw7Ttf3cMVIShz4XPien/sfbxmMlsHCdsltX7yDB6bNFHEAzSj
         H6+5Uv1q5Coj6MvrM2bASFQWZAzrrvikjn7AtNuUftHoXRk1BTeDMpocjXRGKFPL7zEb
         ZqXg==
X-Forwarded-Encrypted: i=1; AJvYcCVPKs078QJq61bETaWQwXiXEq/Iozn9JrFGCQtdPisNHx9eMFeju9dJJEtSnOpQDIDIad0jb7lrtVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jq+f5Rhd7AzdTxi0UZTelssPV3GWNCP7J055loQnKdVUEozW
	/2dZl9EryilWcBgU4xKXFjTP9/jF1Xpgaz9I60Y5aaov+L3Pd1cqr+KNf7gojWY=
X-Gm-Gg: ASbGncvAhAnoe2T4wiKPhHMKExMqsjFOSAbj0FaO68mkZrNCoPcligy8VU3FHdo0dv9
	wYLEsfBxiTt/GPVzYG+piUGSbbj4L/MM83Iipc2Vy2R8tvXR6W0Gu7JxA5kja1YzguCXslO/ap+
	6OK5tgi0+GYmKMW22LnjE02HDAF5fGY+NLKZqHI4wpXdKGMkyvM0Um4VH44BbPxfXJbjZmNh0cw
	A3Po36rpfZuH5sQ+T0lLEaorLeiqj+z2uRaJkbHr8e3OnIWgeUb0RqUehAqcsZ8YOpzkmJOVvOY
	Gcn1HMmqW33d3UnGA7jqwcUpXg2YKLAePdLXIb6Pw/LAsWVYTXwc7/rmhPtF36Rjcbr348AOGyy
	DSqP9lTjIZTjpVklddg==
X-Google-Smtp-Source: AGHT+IFx+Ev5S1uBDcn7BVitaXEYapaEjznsEh35Pj5xuyFGfgsakDxrFpZPL1Vb+Snxu1p+KuguuA==
X-Received: by 2002:a05:6808:6905:b0:3fa:25c8:a037 with SMTP id 5614622812f47-401c0c143e0mr1988465b6e.29.1745003346958;
        Fri, 18 Apr 2025 12:09:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5ee212sm474001eaf.13.2025.04.18.12.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 12:09:05 -0700 (PDT)
Message-ID: <ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
Date: Fri, 18 Apr 2025 14:09:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
 <CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/18/25 1:58 PM, Andy Shevchenko wrote:
> 
> 
> пʼятниця, 18 квітня 2025 р. David Lechner <dlechner@baylibre.com <mailto:dlechner@baylibre.com>> пише:
> 
>     Use DMA-safe memory instead of stack-allocated memory for the call to
>     regmap_bulk_read() in the ada4250_init() function as this could be used
>     directly by a SPI controller.
> 
> 
> Sorry, but can you elaborate more on this? If driver doesn’t override the callbacks the regmap SPI uses spi_write_then_read() which is supposed to be dma safe. 
>  
> 

Ah, I didn't dig that far down. Will send a new patch that just cleans up the
unnecessary alignment and unaligned call.

(Also can't believe you sent HTML mail!)


