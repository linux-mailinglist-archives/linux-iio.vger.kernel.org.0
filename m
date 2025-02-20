Return-Path: <linux-iio+bounces-15902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A71A3E6EC
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9463BFD76
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C6264F98;
	Thu, 20 Feb 2025 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ii1U/RoC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FD26461D
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087831; cv=none; b=QHwNFEQJBtuYuAuzsFWHOYtb7tbDEj2RKZwp7WFrXc8bu5Lf93glpAhCq2i2hn+jgiEoOv4Iy5AI3HTCVbFZaCC1uCGUm6Whfj+quFJWT/G39RwkuCaUUcX/E3dXoEYU+vMq1hWoNeSrrb0reXL45/suN5whEs+AqXTkVOOHLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087831; c=relaxed/simple;
	bh=ES4OGi23rslj+Ajn+wNFewphPy7M6o0Ty7Wpu/HZ5lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfSObf71Og7bHcwVOni+9Bc6QDoPic/FXEvasSleZ8RwFWa1zYWKZrLzJAIwY0TmGG0Q1jkp0xmRaiELchIri9l0LfbfeLk4+aBdKSoZJhmkN3pbbRkZUUhDAXtWbsxx5B40LZmQhwAl5Z7jCbnVBjpU+jKpkb8yuNHamY1wsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ii1U/RoC; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fc6cd89f85so603536eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740087829; x=1740692629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt524ElHokjzB1IIM2DIs3AzK+URz67k2uKl/q2oOJ8=;
        b=ii1U/RoCmBoiI1CKzwEmdZFMoROd9ObKguIgJPoJ7GwSpt2MItgCcdBShF8R2iK5mz
         3JzLWMMiEX6GwonlfLt2IIHNZE1sciNO4j+NbshDdkN2jYSjDnUXqTglyaHhXEuBkr7l
         qyotlmkD1evDNZ7IdqppSVS8wmUJePNzVhhFrYJvNuJmws3fc8L9oBNpSWHfak9qrPhl
         quJRpLx484t7pINKv64QHjZN/zSQ9wAgwOxIzg2mISK/IKJ9Kqt4oVh2/jWh+oOaWYpi
         E83WVRZZ/d9Jq2rjtrxuf/1Wd5Bicp6n+Xyciwget+J5VdQHYdJlRSwhBbD/lnQdoj5Z
         2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087829; x=1740692629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt524ElHokjzB1IIM2DIs3AzK+URz67k2uKl/q2oOJ8=;
        b=qNgHT2xGuUygWHdKBnT5Ng5Tm6RjSIg53+pRQ+Rl4FvSGRY26TETBMrb8kOoeZswVH
         BXt2vuKPMwwuMTBXcdC3LRJ1gPRnOhwXnNmlEZsvYm/0dXn/YxhHjVAkpL4j+05P3ILG
         IthvO+igPfy1UXjFON0AYRDsl6VnhRW+ia2G+xdXWPMxT1hMb+xJpampdCFAgy23m6SY
         watPII0/SKYvEb1FvQPOPee0xR0ca8adBixP42ZbIPy4AEKFnIaHjXnANs5WKu89qsVY
         c0pKl1F55UWTXMNFAArEZ6h8SBhoA54fQa0qGm5ypJXdDKIMzt6c4YSsmQZjTXgtrkTz
         QsRw==
X-Forwarded-Encrypted: i=1; AJvYcCUTpLasPO///+0zMERYOxtXUGKC5UcsaWmiMYAj8DY3ztOqOI6mrGN6LjAJrXU5tHfTy0Jirt6mtmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8JW+t/d7xdOslh/drCYGJ/OxRtIwa4PSSPyeJ0YueM42plJX
	EpQINALXMVRyYwINlhZzR5zU82ED6A/KaoHS1ms5241t1340rEwXcDYyxKRrpuQ=
X-Gm-Gg: ASbGncs1iLBGFPFkBMkrK2lIgtsNrulm73pU3YO+r/NSFWqeNAyrrfbLQc9cd5PUDe1
	VkYasUnDPhbiHWR7kEoWQ6mf36GyHNnSiRfA/15JA9opl6O7kza5PHFYU9XoIghb5d1WZaV7yG4
	xSqHdgO2ttAsCdZOqk06HkkN8uTaifDSACsKMdxRu1STTltE1idpodPXTvD03LnhyNs9MHDQ9lc
	bocCGoAKt5Le4Hqi/hZdRgqZ9YAfOkbAuA9MNzUsrKkMxDxReGJHD4Q1sEzE8L6yubccRGfVjGJ
	TeE+8k2Onh3n1MyKmaNI4tejlhXxbZG3o4MBvJJZV4BfnOV99zHA
X-Google-Smtp-Source: AGHT+IFOfWm9sA+tBwWhqqwmy4uqvJdg4Cmb7v3gPA1NaW7kkEAVPWo6zRGWCJs9b+QrumlHS9MUmg==
X-Received: by 2002:a05:6820:825:b0:5fc:b489:6cec with SMTP id 006d021491bc7-5fd194de281mr893707eaf.2.1740087829046;
        Thu, 20 Feb 2025 13:43:49 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcf2e2c385sm1637668eaf.10.2025.02.20.13.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:43:46 -0800 (PST)
Message-ID: <b8c43ee5-ec88-4dcc-9926-38764d18efa0@baylibre.com>
Date: Thu, 20 Feb 2025 15:43:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 10/17] iio: adc: ad7768-1: Move buffer
 allocation to a separate function
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <d78aba0d188119bdfde7cb91041229ba16e8eeea.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d78aba0d188119bdfde7cb91041229ba16e8eeea.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:17 PM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


