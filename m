Return-Path: <linux-iio+bounces-18797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6EBA9FAAD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2490A170847
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8D1DF988;
	Mon, 28 Apr 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jHZ5XZ9I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28D1CAA85
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872646; cv=none; b=QSPW07a7y8pfOS6fbp3jcjCE5SgsHi6KPgYoaQiYvy0RicSshB8HU+QXH5KKaCC/T9oFTX60fSXLnTTc/ErKNb+dCZZhXC41yfZKZ/Jry6Bx5wRjYT8XPk5DHJykbbzcdGEQoRICPF1BFohFuO8wUsKSNE7jkuytTavHdsmsBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872646; c=relaxed/simple;
	bh=RG16IxyNFQzdJ+l8YiIgV31gwxuUGCnbYmlOxmYE8vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnyXUydt8SpssSK/2UH+SKC7rSCRhOwUPtevq8e0kbVOYGRiorm0y4bgR1X7P87SNkwVjeR92BX4dhC65e/NNQ6s80sUkIJbTTqJ3y352bG4hJ8DWF49woCil8HPNaeZYfxXjOClsOY4MCYWC4pn/u1fKogR6txaWeKDgiKmvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jHZ5XZ9I; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso52574686d6.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745872642; x=1746477442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RG16IxyNFQzdJ+l8YiIgV31gwxuUGCnbYmlOxmYE8vM=;
        b=jHZ5XZ9IrhxvxoclFe3KfaWjgSd6YqvksZpBCtNMbWHmNzFhW3fWiEjzsBIzr4IYId
         kgZJpSSkkZX8pjLfzTp4tOsRFb6Z9Yn8UPS3iOemVqAFNsTVrnrxmcWALynzXgog1LSS
         lBXJZd50l0bMdWbphuWUWbWqDEUZdYas8hqqky0iHpLcIg6q95jClAv/NqsgGOLTOSOJ
         R43MyCGAVZbU7buO83ZzM1kAwe6elj0dB0YHqBzxGEgbDQWgl4faxxOyp91ESt883KAz
         WTEWcPuBV5TwbnM+hyzreLyZk3lnuT6syQHIrvXyylZjhWNbzhuuxFatdXWfPIWhNlxH
         Bxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745872642; x=1746477442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG16IxyNFQzdJ+l8YiIgV31gwxuUGCnbYmlOxmYE8vM=;
        b=CQPouJEn8wkWexTGx3dRlEyhq8StBuDY5PE6XbWgt6t0acv5Daat2muZUezb0t1NRe
         oTASFGQ8vJAMSi34uPj0BxoBGu/6ffvvkSXXkIoOtI94SMh5l2zDjgsiHH/FrILzQxJJ
         rkNkFhfdFrZKZpAK1tEpYlHdcX/bJ8vFUMRDiN0p+JKP7K6GXYquDmeycFehkz+aiNss
         ooY9VMU851HXhZCn/bk+txHCrJ5UYUXjxv5NEgCs32sU1leXBSOv4Kyi5LDWqEAqY7fw
         iZZXJzXTpET9oYqTGNd8SDRsJC9qHiT0yqJh8dciK5hF3UtFOQ5smd1M1Au9if26Fy3s
         thXA==
X-Gm-Message-State: AOJu0Yz389VUTdSHeOZEL4emhit3VdXyqEoo5It6YzSvyeBt77TIlS8R
	B7pZMMm/ZMCg7ZdiFO8GKbvJrurAaK1YsGJiZNqZn9gnUaNpLnjaIyCKDqP6MDM=
X-Gm-Gg: ASbGncs2oDPBMlke2pL5tZrJ0iWGcpEvBlQsG3iX3Awo3GR7LZvpyWY61wjJIPIRHe3
	SlD5eSoj/pa+e6vjc52hRuLPCAb7c2VvpP+H1DOYzTmpgWLQXT9OKikThy1is0JZMFy/z7CRCPp
	A/KUhhohHukXI+zOyYnr6vMWoHSAQTig85L+qmolflr34nJMEPgIui2Y+oh45Emh5S7naAPLGWy
	nbWeMsfG5AG54vgQfHlp49bxPh3CZ4DPUvQ1viKUAnRWAiMCOICo+UQQTS97HTARBCk9TxXL8Mx
	SU6kUNh7WjzlPwFzP8CmqHtWh0akQ5L1XBNKHb05WnagJsYbbEKIdJEL5aMib0xToSwkcaodsGg
	Gfx7y7qrm
X-Google-Smtp-Source: AGHT+IE8cclfNjGpRErtSU+IQYlC80KA/mvktmZUSPUgteaPfn+oZPkriEMGFnPqNoJ53MfrrkiFuA==
X-Received: by 2002:a05:6214:19ed:b0:6f2:c88a:50b2 with SMTP id 6a1803df08f44-6f4f1b9bf0bmr10177236d6.3.1745872641862;
        Mon, 28 Apr 2025 13:37:21 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0ad4382sm65108736d6.125.2025.04.28.13.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 13:37:21 -0700 (PDT)
Message-ID: <0082078a-32ef-48cb-a181-c2d598ae29e6@baylibre.com>
Date: Mon, 28 Apr 2025 16:37:19 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] iio: adc: ad4695: rename AD4695_MAX_VIN_CHANNELS
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-4-6f7f6126f1cb@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-4-6f7f6126f1cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-04-28 16:23, David Lechner wrote:
> Rename AD4695_MAX_CHANNELS to AD4695_MAX_VIN_CHANNELS. It has been a
> point of confusion that this macro is only the voltage input channels
> and not all channels.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

