Return-Path: <linux-iio+bounces-19240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A4AAE0D4
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458643ABC4D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D200288CB2;
	Wed,  7 May 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PQoo9je9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC5288C31
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624863; cv=none; b=DY2g3mQM2KHdRU067O9+DFwPeneMsx4IONqgpkVCb+c5gOG6ZKt6cX6F+POpbm98r1bgB0tsOwdsQjvJzADMv4QWKuROr6DmbbONtqdcBD5qQX6HJuFueL+kfMnzmvq79qADV19cnrbluI/BvI7wnLKEuQ46k6+sPfcL9mf9bXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624863; c=relaxed/simple;
	bh=bUgRtOSGIIheBXHPUBc4u7ua3sa6xcHfao2mgrmxIH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UV3YDKlVuz2b3WAn7b79nL9mTvxlwbLNC2qD0Pc93NMJMiuoOyAR5inyVHG5uqFMRndlIoXT7exf55Nq9ULSf/Xhir6RzuunzGTQ7j0TkwHML90OO2huRlo9LBRitX2Yg7FVLgY9bTn3Hg0b7FN2Q7//P8Rs7K5aPUZQew2Kpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PQoo9je9; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6062e41916dso3290857eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746624861; x=1747229661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWXvIenX/6jiZJInoxV/hkglW1/muitYRDlj1FkN0YU=;
        b=PQoo9je9h7HRk48OeHTcfmCJAR2P1HkCKHP4GQzLogl9K+TuSBlMQ+91WiHT5pcAfZ
         35g27IL2kC/QjO4LGZn5MRLtfSBpt0srFdKXiY5SpnQ6aWe1AIjS/RS3WkJKqP1aQQ3k
         Fk9f08GRdnRrXKRem1vJcm+CGXq2k+nJqUPrPxQhJGNS0MikTw//3kHptHPLQPVt0PhT
         euzDGycj18M61r1/8FOUL92oe6RAMEwO5iGmN9ZG+fUcxT4qMP9iIRnbR9oxoZMMclXl
         7L5SnRrjeXEnNUX49sCc3K1DMM8Oo5aSCp7r2Ru/Atd+4ZkN6jPSq+a+HQeZJmeCfkkl
         cJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624861; x=1747229661;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWXvIenX/6jiZJInoxV/hkglW1/muitYRDlj1FkN0YU=;
        b=j2o6VldwzuPWptuku648+szIN3zIPdaKiBGD80y3FiAygeqkzz0Bu1hhL2sB2yjKFW
         nYezFdVjd3M02sZJDKU+pDPbzmdm4C5k4OEaiMMT7mD6/750zfSxRNZ1Oy9y7rfmVaPo
         tQWsn5T7FV+EIBJGnHij/e0A7kttWNB/mlHJduZN0akQrOukOxOzAIGS9vi3Ew0DEX0d
         rLAMdeT7fk2nM6gmkqtcOwh6kNiGBSL+/dPN+iEORyNd2lpinMXmH1IWZ9rMrpTfeWii
         SE2FyYi1P2ZI+c0yeOLjzG2NXLbUrnnK4zZuh8UnBPB/mNvzk9XDECzGjoTml4jl+ZOu
         fHHg==
X-Forwarded-Encrypted: i=1; AJvYcCXed4MsnEIbSiJ8o3hT6K9XGsOWNoRR7vs2L/fijCPY6P8k7EsejvYqUPqLGivxBKgdvXDBgpInYqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/oljsLB67/pF+jtc20F4PPXrB0IHthmS+ZIfnbfsyVKGVfWQ
	aOJKoI3SR1r1vaNyTsuKL256MXcsJomt5LRaNchUU+PalubtWyjy7SViVcbSY6Q=
X-Gm-Gg: ASbGncsC/wypGBLa5kQDHVZQ/srnwhn/1R+0Q7733YCpxsLNyBn1bRQ/IN6+nmIWE9y
	wEb7Fs7WzeZYfEdbBEbNU28lIAzt0itacR3as8QW1+0Ifdy7qweH6t8bMbkWDipT3q09+vx6w7N
	ybIQwIdxlc0iVc9U5oQk0Nu6vAoguaYw877neKRJbn3A0MnXSZYESAxTHbHmIZ5URKA+iDt518b
	nhsbj1Xqa+dFe4ubwRLM3/eeCRIeWd+1bIJYH/z4D200GiV3/Ip5Cwn/lQq6URC7MbU3zte11tk
	P+kIeOPMDkzPU+taQTWuhupzQR/3pDUYm9KbhlTKgwFnBPj6BeNPle2UsGnskac4gP0Ytf1blDY
	HpCMoI+JqZiPxWN0=
X-Google-Smtp-Source: AGHT+IFWABUyQ9KrWW43rC0EUTNGG1v3mlrsBmKhdcVlqqM3Amu1ul/RyY+1vnEhszLvdaTDyKaUhg==
X-Received: by 2002:a05:6820:1890:b0:606:293f:d2da with SMTP id 006d021491bc7-60828d850b9mr1960367eaf.8.1746624860742;
        Wed, 07 May 2025 06:34:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3356:f6f6:bf76:a32? ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7db25f5sm2786366eaf.17.2025.05.07.06.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:34:20 -0700 (PDT)
Message-ID: <941655e1-676f-499b-81bc-1ed8230cb486@baylibre.com>
Date: Wed, 7 May 2025 08:34:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] iio: chemical: mhz19b: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>, Gyeyoung Baek <gye976@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aBtZFLFlr0slcYSi@stanley.mountain>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aBtZFLFlr0slcYSi@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 7:59 AM, Dan Carpenter wrote:
> Return -ENOMEM if devm_iio_device_alloc() fails.  Don't return success.
> 
> Fixes: b43278d66e99 ("iio: chemical: Add support for Winsen MHZ19B CO2 sensor")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


