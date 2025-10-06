Return-Path: <linux-iio+bounces-24782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E297BBE9DD
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4334A0CE
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D31F09B6;
	Mon,  6 Oct 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ua2rC38d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEA1E2312
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767542; cv=none; b=uh038R/u6A7V7Dbeqzw2zcYLx49euexKNQSjVP6Jk2Pycjsju0auSMtwqDX/lGy3FQGJKOFgcC8ddLdo63W4IvSeTorVzU8j4oB0qerKEVDo9ZkefQDCwWersfGbJvde7ESKI8l3keMbG1Mq3Fi5v97UzQHhGTuLYF2GU0ILtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767542; c=relaxed/simple;
	bh=Q6EvSHfkO4e/9YwivHi3csU4VMPQMQ8A5SfcPJE6jwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pwnh7oP0jome4zPvo8Q5VrPRvPPkdqJO5HrTBRbs4MVAXhbFvx2qXEiI4zTTwGjFDX9g1ojZgehmERAIOdVCaHVvH9v1kGu98/rDgTUiyze3WuaRHK+LfhgTQMYWPGwn94Slv8fgkMnuoToGqultV44vqOHD71Pv/FJ8mrll+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ua2rC38d; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6418c6b8cbdso2750649eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759767539; x=1760372339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhZR1oqC5kvhnlZSDqYbJoK0fSBTzQfqw1bJiCNbME8=;
        b=ua2rC38dpGLUY9/t/s/ojZk/HTks1yn89dcbPA9a42xXCHASxBBPCd33iW0xt5fz4W
         HDSbT0Jm6LYmlRxqSa//GDCV+73jjztuy1Xfvww9s2rpARun7fpRs0mdKr4ILVF2glbs
         rmRuzzuJ4RkYdtK5mj5SgMbp2BaylBgN3ZMYhPPMel1mY9LsuZazu6mqDgWwB7HQQ1uq
         phcAK0z7ueI0Drb8jZB+M++o9KkxaoHYZRT3S6RT8YnJr7ZxRNeWI62mBzTrA14UhI1N
         wAGqOH2gKE7y9uiwRdmZvYvwYyCTkAT3psGxI7W3oAZb8ATAnygMxXiBqIUP0vrGCMc2
         hDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767539; x=1760372339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhZR1oqC5kvhnlZSDqYbJoK0fSBTzQfqw1bJiCNbME8=;
        b=eQtPTzoi2dmfznnuO/e75Y9scPd0KbFbhjHZeo7jdHSkTr0TvxMKdhWySkYXpWH3i6
         kLMoVbi64SK4O1KlsM/exfFejWSBcI7qt/2H1pYEHZu0cdD8kSMlsIoOzseCnLKUdmJ/
         kZpvIR3KnDiG8b0Jh+LrKFR2+DcFZ66VWZddc9BUqycUlzdXy3xzFqHXKUE6+BPG7vFQ
         PkPjXXbuuC0vTTF3AwVfNhmxnX619oMRGFLjmN7YDwCwsP1ERUXmXJbUm7xgbvxukqnh
         5Arc+qkHV9u/6ayoDK2QaKvPJ1ooJbDn8Fas6BacnnsFh5a0MDn+QUAMvyJIXsa6Yfk7
         U+dg==
X-Forwarded-Encrypted: i=1; AJvYcCVL8UDFDI4IOzd75uQgC2+3pDihHooFlqPq+9xxLumffRyAsf3600CTpQsWFhvDuXzDe4FI7Dtmz+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtYrvLUZ45aVjTCKeacpg/GTa/y+0ZBjD4UHutax72t3e93Sx
	cP635MDBxX4KEr1VWmp15n5VW4haZXI8B4gLFayW9BMa2Ki6jsggCm1iH2YKzlEzlLg=
X-Gm-Gg: ASbGncsNdgUed9QXmz1jvEBRnBZVsr8BRcicOX87bCjivrVYbgIbWzGgH7CRp3CPB7C
	x1XWsXurTODnWChiI7KsxSU7WZcj2W2IjNP4nSFj1AuUdirJcRrrJ6XSWI5PeBwhOHVYB7hZGoJ
	9bx5YTYCjyMYTuIZQQu0opWDcV8zowRpWJlDb7E45TTIwbDjTiw8dlkx/8Uxodt20oFXieTCOxD
	+/LANzT/uopQlq6QSHdl4qKOaV/QtRur3sJ/eLyms9I80pVEQJcx1XJvn4Tf3dJ0J01TAHwGrZw
	iMyXW+YZDPrHckBSt3Psfk5NNCi3NxbAZ1cJVFZ6RRX7XO3kJ0+YL/cYQ8OPGi41Lmq38a6eMKk
	Ynk0oxKMnQe5uWJC4lca1FsQKEuzSGPUJ08WVjilAiHHAMaKJv+iB2RfwjYyM9OGSbR0hu3OTnY
	KpDAdPwL3ijf4gvF01d5ojkEQ=
X-Google-Smtp-Source: AGHT+IFUfHmjx5ckM1OlqXY6Ld+RV1yTaLt0MDlsh6omBMgy6OcZDc1gI3MR0SM9LREgCHsUySFRVA==
X-Received: by 2002:a05:6870:264:b0:30b:8821:aba4 with SMTP id 586e51a60fabf-3b0fd798233mr6748754fac.20.1759767539344;
        Mon, 06 Oct 2025 09:18:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246? ([2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab794bd04esm4196944fac.10.2025.10.06.09.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:18:58 -0700 (PDT)
Message-ID: <7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
Date: Mon, 6 Oct 2025 11:18:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/25 11:06 AM, Nuno Sá via B4 Relay wrote:
> This series fixes an issue with DMABUF support in the IIO subsystem where
> the wrong DMA device could be used for buffer mapping operations. This
> becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where memory
> can be mapped above the 32-bit address range.
> 
> Problem:
> --------
> The current IIO DMABUF implementation assumes it can use the parent device
> of the IIO device for DMA operations. However, this device may not have
> the appropriate DMA mask configuration for accessing high memory addresses.
> On systems where memory is mapped above 32-bits, this leads to the use of
> bounce buffers through swiotlb, significantly impacting performance.
> 
> Solution:
> ---------
> This series introduces a new .get_dma_dev() callback in the buffer access
> functions that allows buffer implementations to specify the correct DMA
> device that should be used for DMABUF operations. The DMA buffer
> infrastructure implements this callback to return the device that actually
> owns the DMA channel, ensuring proper memory mapping without bounce buffers.
> 
> Changes:
> --------
> 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and update core
>    DMABUF code to use it when available
> 2. Implement the callback in the DMA buffer infrastructure
> 3. Wire up the callback in the dmaengine buffer implementation
> 
> This ensures that DMABUF operations use the device with the correct DMA
> configuration, eliminating unnecessary bounce buffer usage and improving
> performance on high-memory systems.
> 
> (AI generated cover. I would not be this formal but I guess is not
> that bad :))
> 
> ---
> Changes in v2:
> - Dropped Fixes tags on the first two patches and Cc stable them instead
>   (as prerequisites for the third patch). 
> - Link to v1: https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com

Did you not care for my other suggestions in v1?


