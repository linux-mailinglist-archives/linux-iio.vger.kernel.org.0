Return-Path: <linux-iio+bounces-22702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5162B25754
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 01:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239E11C24BE8
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D32FB99B;
	Wed, 13 Aug 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eoeJE20g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACC2FB991
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126751; cv=none; b=PgPQgneGeWb/gpzuZJb4jM9olB2n8RLZCc6ghtzYJXmNYF0D5b/SMVVm81GFCWyJ8bRMw0824hxgDE6/iyxQcbkAcDxDVyHDsIo05alFwm4G6iXRgqzAWCIlBchyjTnJkXzlIdbTAwndRE4KTM8W7jTo+8BgqkMJb8XyW60Oa3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126751; c=relaxed/simple;
	bh=J0fQmYN0td9BbUutnx5hhUXkf/3YV2ZNu1t6raM0LRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpVQ3a7+UBrfTh/w8QQPYVREcbiJ6Pcl/9rjr84kpRSZWz7/aUMz3TG2WWHc9loHG1VTd8PrWG6go6ZqQY5ZoLPfnhBmKhyvDN6wRYIES1ueq7Pu+gAkkhhRlePQzrfRKvJTASagEtT/pvf63Lr8+jwaeyw7dEAZAj1AKRfKJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eoeJE20g; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-435de59ddf7so295876b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755126748; x=1755731548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5P13aKoekVtyFP6DFw45bojcRd5Z/0K56R01yQ6Y0BM=;
        b=eoeJE20gXYdhn484UOPPhgOP9UvdyLF7fXoMpw0h9oJLxrIJrFLcc/1NM6Q4IdzAq2
         Rl5Y36gOuHTKk459RmRs+Sg96jwds5Bm+z+TwkxDgbixSfPYxS/xzy13RXB2eJKUY0Jj
         9P1iFm0mHUoTxn5D7gPdGsr55fLK7g6+pMhyBSILNFe9sOEXmRHVRJ+fkClrP8pl5nEx
         +CPN0YJxU5uRzQCBJH06JAvYNqmH47yBHEW+FvFaCWEnSaIlYfZ9vB8gog3YO8SnuXhO
         bTOAUJR69YvPhUS/9SmMDGYzmL7kKDLBOTatrgrkwvshmweZJEYF0YoC7Bmf6hxV5TpJ
         I1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755126748; x=1755731548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P13aKoekVtyFP6DFw45bojcRd5Z/0K56R01yQ6Y0BM=;
        b=e5mW89DF64N7xu4TVB4gvPPJuvIHqKV8kal9Z8sqi8Vd64B3Q5vDKcReCNQT4MkNbf
         YmE8rVV71CX5oUAOdBrwzIgmyswQ8KW/d9YewvSfvWAZ0Q+HHMi7tlSZIbzeAkTBwi6B
         iExw0uQoF13tti6hfFT2mAITPGaqcfZgvPF9GoVYro4pe0SaT1KX3z3+sRA+CSavBonk
         WgMxfF9R7cUDnb8SR2GB1o0Sigpm10vGKgFmKr1ZC+yuUwojeVJ0wc3J7abmhBqaIG6M
         giCbUHGG4w14MWCVgGpDKFIqDMZgX6vQm81uYzIvKcREXZ3BN8oBQ8Jqt2xRu6PMynaD
         EXfA==
X-Gm-Message-State: AOJu0YyD7GpYpVE2S+UzSTz4GNauDl6H9uBnVa0e6sbu0z6gBWnhb1eE
	nvujQVUPAGwG7BzwL++xzpHu7OchyD/d8LicE6issNwrrT64PFlmHxoLn10NNzasrj0=
X-Gm-Gg: ASbGnctimHHt2hXEoIM1yQ6mIoGDbCSdfTr/B6sHqTLuFu4kDe8wvdvKARmIMWwKQGr
	xrewQDkYXqLeNyE7Zf5FS6At6KHQq3P1MFggfE/REMdP61V4WgrAst4ACaXWDwr4E9vCIzF8n7c
	sWzeW1naXmSY838DUYEVw0KqUlwkcmKtCQpkfEaRJZ406+i+QUP5l+HkrjQKlbsawThYrsBeKAP
	9wYs6SMSTF4KPhLuoNcSTItD4ebfg00N7/D8ICeM1QAIs4TVR1QRGTI4TpaoqrFrA6i8IH1Jy83
	5i4+Uh3Plcj5Cj0uz8C8m1dHMNudyts6dKLAAfkjfs5/BisCcY1LKuYZ98KdHs1Z33fj/wpd3We
	vEsUJnYn1NhLWX3Ieo1NHXKXLbiq/r4dwAMjkeU/EHFZUh9UlPCYAnEaj4PxhSAvW41ZlYjmU
X-Google-Smtp-Source: AGHT+IHYzwo2bMR0+x+++sRYWHwfN72nCHTfvR4CPHAeB3wV36pwiHYsEgW+gCnOX3eWHG3onNxoBQ==
X-Received: by 2002:a05:6808:1813:b0:435:7126:fc82 with SMTP id 5614622812f47-435df6c07a7mr661060b6e.3.1755126748288;
        Wed, 13 Aug 2025 16:12:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce72b2fdsm860695b6e.11.2025.08.13.16.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:12:26 -0700 (PDT)
Message-ID: <4e109905-347d-4830-aea6-a93d88252481@baylibre.com>
Date: Wed, 13 Aug 2025 18:12:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: health: afe4403: Use devm_regulator_get_enable()
 helper
To: Andrew Davis <afd@ti.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813225840.576305-1-afd@ti.com>
 <20250813225840.576305-2-afd@ti.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250813225840.576305-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 5:58 PM, Andrew Davis wrote:
> This takes care of both getting and enabling the regulator in one
> function, it also handles the devm action, so remove that. Also
> do not disable the regulator on suspend, this will be handled for

I didn't know that this worked automatically. What is the mechanism
that makes it work? I've seen lots of drivers doing the disable/
enable in suspend/resume, so I just always assumed that was how one
is supposed to do it.

> us. We now do not need to track the regulator at all, so drop it
> from the device struct.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

