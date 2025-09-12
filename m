Return-Path: <linux-iio+bounces-24035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA9B5567F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4AB1CC49A2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963A32F76A;
	Fri, 12 Sep 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xo2q4+PC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B21DDC1E
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702442; cv=none; b=aNI1/oFlsl+JKamqgKaHhiKABf88sPnYedNLglgLuRXrR85J8hMY2sHPcJwsQtPODeC6MD5PCgva9lAKIc+cT4LKyGeKrSNS7BWAU+YPza4J6k2FieQkAHbtQa5Xire5bbNdZWU8guSjyNO+BqhdCQsiXuD5YiR9SrWwqEllx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702442; c=relaxed/simple;
	bh=k00K2WIE6Ewqt/eZ5d9m+rjyZ1/wA4exwontTQ1IGR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUiAevNhCCZ9wpv/pQU4wQubYHXLaO97MKVur8TO+SvK9k/B0byfpIXGs+mO8Qjf1c6/s+0yesN9cyBcjvtOdAhRZhuwldWSJJRtb8WqtC3Z0ox+qNhF5SufRFYw/Jz6mbcVFtigWwlMNj2Zm0U1qXI+Esx0d5YdrMS/08djWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xo2q4+PC; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-621cc387bb8so173103eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757702439; x=1758307239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fr6WpPJO26szNguY0sxPUuMJDw0v1LfC514tjVSDNIA=;
        b=Xo2q4+PCeo9u4UTGCA/pyhbJ2Ss2d9msCPz/2nL2xbx41Yscvra8tzBC/hMA3bddBT
         PmnR09Yg7aqut0dIWwmPN193Cv3KWu+uNaIxWqtQZwS2/wNXDyqRnAAil0SzV3PGp7Ml
         pUsUTuzBeN5HPRUFXv06/quJcOZg2KJ73Xy6H5nbT6guCkUyFex7sRgQkQTXE77FvkRt
         rsxd0ewM6kjN/8VaeuLsW3njBby6Dp5W/iieMo3Jz2GEE1YXhTWv+KrGWLO8XeQ0trV1
         JEhj4HA2ckJRuKDxHY7SGz93uNCjBOw0PCJzEl+cGcEZfAtUvZlQamDBy11YuAZTTkIJ
         mjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702439; x=1758307239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fr6WpPJO26szNguY0sxPUuMJDw0v1LfC514tjVSDNIA=;
        b=RBPVE/rDxY0GqbTXs65pSCJgM06wgMKdfAIgKhW4fe+LQwQrk0MH8CBsP3tGiKN+Cz
         2C4j2H4LGp9bnpzvh1AsLEboZ90tygfdOP+/obMPtHCOjHJ07vkGfyaG7yXxq6A3NWyu
         Hlt46STbOJO1st6sGpNAKxK9URk7kT4BKNxRZlA17KKVof/jZsM9uoMRtxAH4dGw2ika
         RayqNuM5P7lNtmb801yC/sMnOl5qfi6L2DdxlPEVbvJnFPiTVQYxxW5NNqWQUv+YpFL1
         Rzd24yAHE/zQSs5fLDeuWwUp2vtTPeShfGIOz3/+jv7HUlA4rHeqCKk8Amao2WrwCVrG
         FyuA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Izeu+4aN39fYN7zNaiw2GvoHKpdqT1CYtismYyNjXFCW5WrySkWXRLzk5PmgtEwX8UBRQT8/g2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaC7zyQEfsVpYA4SS7nmRrebzh6yjMpBKcbFM2ykiCgOEMhFez
	FqhJr9tbGhchV4N7y5H7ch6cNeHokRZS+TgCx9g2zzuVgMnPoTdaKiDCRIswSJfyvC8=
X-Gm-Gg: ASbGncufmu63wlsyuyJ8JACxmVOF8Owl1sptsacO2CXh/eLRwLGpc30WeCAM6Is/hiF
	NWvnejDRjDDBybvpb4PTPso1mpg8nDhzOwXYFg+OF27XNM7la1dOsxSJGVWogbdLLChQLRdt7K3
	Nc7Hf8n+kVtU9D3+i7RNQkfWpGGcA0Q8bx298z9kfTsDhoy1+s+bUgYNCHY54gZsGrnN0wdCq9k
	45W19GDV46OleTpB61EN7Jz+x3lNvtnXvTnQ0QdWjibiq1I2AZJW07bF5/Wa128XkImaNXc17gI
	sjQYA0CGLGbKWP1BhQJHSu1hHMSzFmwJ12OMzf32GDGfSsPOw1SXVwKDLqPVdfa7pMlLlZknxqL
	iEc4Rr8bDaiR+yz5GFcOTawp1oOxxArkCrP3RIffH310CyseG1BYUd4Dr1SV0hbAPVPsEc1tmcG
	+AR07PWXL31A==
X-Google-Smtp-Source: AGHT+IGYgWI504crkZYqNYG2WaIQBqGpslOWvuZ65zJIIsRR4sKsnCoCflMDuHLa29qJHSoMBvw4uw==
X-Received: by 2002:a05:6808:2389:b0:43a:2e17:3b98 with SMTP id 5614622812f47-43b8d88e3b4mr2010278b6e.7.1757702439155;
        Fri, 12 Sep 2025 11:40:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1? ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d2eccsm916131b6e.6.2025.09.12.11.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 11:40:38 -0700 (PDT)
Message-ID: <7f71c489-410b-4fdb-9d78-9f2835c32379@baylibre.com>
Date: Fri, 12 Sep 2025 13:40:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: buffer: iio_push_to_buffers_with_ts_unaligned()
 might_sleep()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
 <20250912-iio-doc-push-to-buffers-context-v1-2-c4aad013d96e@baylibre.com>
 <aMRiCvmGt27JEYBz@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aMRiCvmGt27JEYBz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 1:10 PM, Andy Shevchenko wrote:
> On Fri, Sep 12, 2025 at 11:05:53AM -0500, David Lechner wrote:
>> Call might_sleep() in iio_push_to_buffers_with_ts_unaligned() since it
>> can allocate memory, which may sleep.
> 
> It can or does it always do?
> If the first one is correct, better to use might_sleep_if().
> 

Just below this in the function is:

	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
		void *bb;

		bb = devm_krealloc(&indio_dev->dev,
				   iio_dev_opaque->bounce_buffer,
				   indio_dev->scan_bytes, GFP_KERNEL);
		if (!bb)
			return -ENOMEM;
		iio_dev_opaque->bounce_buffer = bb;
		iio_dev_opaque->bounce_buffer_size = indio_dev->scan_bytes;
	}


Would it make sense to move the might_sleep() inside of this
if statement rather than repeat the condition in might_sleep_if()?

devm_krealloc() is the only part of this function that might sleep.


