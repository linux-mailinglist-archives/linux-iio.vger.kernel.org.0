Return-Path: <linux-iio+bounces-10100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56B98FA01
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 00:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191D6284661
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EE1CDFD0;
	Thu,  3 Oct 2024 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zagitdjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB01CDFA8
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995465; cv=none; b=L8faWKihstXwUg3LJtM8T9XIKzaG4mtcp2GuXzEs9knkrfxcggCfXZY9umgRO6oUZqDxE3DE7Vp3rYHpecU2/UYHcsF/C+/Ba5FAYHeNgw6W7p9Z/yq0d5jOXmef6T9967qjI4TPOtG2AeNj/zwkKtgGvtBds3bNJeIgFog857E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995465; c=relaxed/simple;
	bh=o8ebjcf5elci6+vmOjYA+4yF9GuzZtxTC2XVhCEUmY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4EcyFB7ECp9+pO4cj0KqQU+7UjwGJiKwLRkrlF917Sgx8MVJ6O08GWtFn3EGTEk5CsVYdvjMY3aBy1aYImX4awFIBuouRqeMJvbuqm77diZOZ+QtCgu2kCuEd2wJ0Z8PL13qDQkeIXP/spyh7rowqZZxg2qEV28H0vRGBT0VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zagitdjK; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e3b79b4858so863459b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727995463; x=1728600263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3Fwnh7Bt1kFJtuZA2sVF/zP/LFGXkr6p/ZZ2spiAsc=;
        b=zagitdjKUmZdEkGJMS0y8Ne3exRhljdUJ9aFkPxGwIELm7z1663+nHlIPR32dec6rp
         L2cvLVUycBRWLpKkwrCtKNlknARAtzlfW3JigESipFghTTRoQdnmlShRgmLeIFgbNswK
         JMRXCYnsxHTsyYFtphGGmDQg5dyT4nWQBg/h8+grThUrcP9X2YuuUbI955VIrHeQrV9v
         AOXjzkHjZlx4evKkIqLvw73qtnZ41WhTaTcawiRW+gvGJLFcuS/hsRwp75nL3Z5+aqtB
         ICRuYEEZ7ksSfN5fUb0wXbbalZQJN3m3oAp6mhITGiTWsnFxguzDZQ8QXDF1SsoBzaGE
         tppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995463; x=1728600263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Fwnh7Bt1kFJtuZA2sVF/zP/LFGXkr6p/ZZ2spiAsc=;
        b=dzPguhcBFKymOiy3W8dW/Sb/mTb6TMzHPc0dzwfdrHjBQ0dliB3w9Gem0yoWHiXb2W
         LTObTmbU11daEb2bDdAoR3S1cEyvcmnQpm5xnGZV5BwcTqwLrq6CcCKo5kqxZvfR8wiK
         +t89b1cPWSxf52AduCEpeM8ZSlqLlNqhWFfooDbKu7U+u+MRVNTweQ8PqSAKl1ux6fz2
         a+7aT+9cHCzWPhrdDcBvA54UiP6bGp1rEtdvp/W9dyZ0mAN6qlzaYrOpx/Iu/TP2GR5F
         LSwC+LWyvm5Op4vx5R89pOB8qezPUYk79LmgbXjOk7ogpJ7UzxEZN7zuBaRXYqAQudSH
         LXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTVbDF8JvBEkQZ282v77gKI/cYhJogWaC/gwGVxUcCDW4XFPd5yxMlvcJElpkBQQtUMBHpYzs15P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzDKJBcCtSWfWtbyKhvAJWFL29L/ZDtBNHWZxVRXkWlzTceQ6
	sX6xP6KAKP12Mo+3kvSYvKo4LiM8K2dU46r8Blsbm6Vl4GJsmNCvjjkltN7uopM=
X-Google-Smtp-Source: AGHT+IFTYaFSOOnkFquU0RvkBfCzHSKAni/48i7yLnz4+35O4Yz/Zbkfda+nBpOJ1NdzKdNpMuJu2A==
X-Received: by 2002:a05:6808:202a:b0:3e3:a1a8:5b05 with SMTP id 5614622812f47-3e3c177f96bmr906871b6e.29.1727995462732;
        Thu, 03 Oct 2024 15:44:22 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3bc367db2sm618443b6e.18.2024.10.03.15.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:44:21 -0700 (PDT)
Message-ID: <96b0ec27-d001-4d8c-9d20-1b6ce09b4896@baylibre.com>
Date: Thu, 3 Oct 2024 17:44:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iio: resolver: ad2s1210: add missing select
 (TRIGGERED_)BUFFER in Kconfig
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Cristian Pop <cristian.pop@analog.com>,
 Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
 <20241003-ad2s1210-select-v1-2-4019453f8c33@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241003-ad2s1210-select-v1-2-4019453f8c33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 11:49 AM, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 128b9389db0e ("staging: iio: resolver: ad2s1210: add triggered buffer support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

