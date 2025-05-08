Return-Path: <linux-iio+bounces-19334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5335AAB021C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB4D4C10BB
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68AE2882BA;
	Thu,  8 May 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h/NKT0MV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0176207DEE
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727430; cv=none; b=KzlXEXi7dJgfXxyeR2dB8dmQqjcEXu0C4wBtoCVNo11po/5FL2xtBFENyXPrhMkoMg6ly1BK5zr6Oobuzspj3FTanY/YH1Nbdc4ze2EI7zzoAV80yFFPsK7RNvE30twPknI6lIb+rP6eaNeFfCc01H0U5IsBdTuNa5QI+rAxswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727430; c=relaxed/simple;
	bh=BPaM3uBsQYkug/7fouL8TiZUFIRkQwryGGOrlftw3rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=No4bf1XvMtgo7R/c5DMWa+93kpACTdWkrULTNay2BDGVUfCRAV+JrdPBQfpQAx5yxzb9Od4sojzRNJI4nN7D88dkWcJcTaFAbHDVkzeyhgXZtQEWVmKyfG0d3MlnczkHNe6n+CAVT8LngGJ8pDJ2aYRQ753N+1L3GfC76P/HyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h/NKT0MV; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-607dceb1afdso844287eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746727428; x=1747332228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDIMXcUh+1t2oaHEL05AcYmEhaIiuHzLG4RdkwQs3gQ=;
        b=h/NKT0MV3szo5YA+cTcEaMfm/g+f0KzQJ91PosONwMUNS0wToMj+tFls38jgaX1uPk
         oOzMwrNE4VZBd+m2MuNC8R8iNS/DIQpoczEJb6rPaaX1jcu8CwuvfdP4yttusT6yyTfM
         qPl21SWeECE2vCHispLqKCQZhaVar87SqRnOQtj1ZOcW9+2NRXWqhPPUJTBl5/2zFYfM
         ay6NY5O9EN1S/u5TU8pkcohEr11mqVa1mTZXSizJxPXrnr8HD6/wQFoLXnvvAw3onxsU
         7Mq+4mTzDcR8lB2ZQu3Fcy7MlIH3WZxucn6FVPqI/dKX4HZCGo0Oj30UwsFsBfG3HTXN
         VfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727428; x=1747332228;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDIMXcUh+1t2oaHEL05AcYmEhaIiuHzLG4RdkwQs3gQ=;
        b=rKT+8wu75Lx14vjjuNRgmRpnoimL4+wqAZ3QfoQFaqNqB479EQ1nm1XUFNf8NCO91w
         EP9CmDD56Iyl83nhyVIE0YZdG1uKPr/9OYI6BQjkotFZ6Yp7USDuWflVztEWU9K5thNu
         oUuYhgnYmS/CI1WZZs+U+7cpd1YXZg0wV2FblM/hXkgyfkpVXLmZPUBVx9EsCU9pDup+
         buqIP0m+fONawKnF/mJ9yriZpSZWeIyTYDW9OOyr026J+6jSDj+6wwOjIv5wWyqzXH1p
         dwz4asVxufcpagg5O3ORg3gttXLUrsPbVGuENzEw3s6tC5+tK3adljMkBybsq2O9txqE
         HkpA==
X-Forwarded-Encrypted: i=1; AJvYcCVswHGP53Mb7AxpT01z4+wSHNtjqn/1z3OSQmB3cmfXKUQTX20B+WOBdPVunfDLTWrvjt5R3dy4GAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpsK0kHX3HGejOCawLs3pErsnWN6GvY3f0jYsw4aro5VWMlXl
	ELRkBuFXvKouQ20uMZWzTaRisKtTs79iYcOGuBwfI6PGicvLhWgJ6esnWKao8og=
X-Gm-Gg: ASbGncv4yO3WLhtTXo5UIMmHwCbydX77TvhhgBZFE/NwLyX51EiUe8eO9oAaQQPZ55b
	eoCqfs4H6xq19JJW88rqUzmRsOXc5IbLNhQKpHGiBinDE35HigzV7naV8e+VhmAhUElKD9vJRjP
	qI5qTfH+V2xW5hxlAbAZrEv35unqQiVX3ctZSMQ8fqPv1gMozbqf4vSZHuiDVkCehaVgkbY6DdL
	mUZRasD2iOryFsOHGUX3YX3wQrG70yLyePKNtJAvk5YORg7Oe+cSn8N3dSWHmzQo16N72F/YjFM
	VCnPWBR5ltq2iODJqi5WDsDzaOJfao6WIswhS/CbNrASTHikCo8HMp3qHISwtqb5IwJcTAob4LK
	LfoeWsqM3seWvyb3+5g==
X-Google-Smtp-Source: AGHT+IEf3U6aBnbW0K6M59yOkNClYiW3gx4S2YQp31BRyUSuIa+tQqcacAiU4K9X6FdN1TJqPPe90A==
X-Received: by 2002:a05:6820:818d:b0:606:9ed9:c38 with SMTP id 006d021491bc7-6083fdc3f6cmr408574eaf.0.1746727427735;
        Thu, 08 May 2025 11:03:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403803995e7sm60463b6e.46.2025.05.08.11.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 11:03:47 -0700 (PDT)
Message-ID: <1f8e1576-a850-4ddc-9be1-16e59756c65a@baylibre.com>
Date: Thu, 8 May 2025 13:03:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/12] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com,
 David Lechner <dlechner@baylire.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <8b8f861422b15b1316a1513cd66abc544ab8c5bd.1746662899.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <8b8f861422b15b1316a1513cd66abc544ab8c5bd.1746662899.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 12:04 PM, Jonathan Santos wrote:
> When the device is configured to decimation x8, only possible in the
> sinc5 filter, output data is reduced to 16-bits in order to support
> 1 MHz of sampling frequency due to clock limitation.
> 
> Use multiple scan types feature to enable the driver to switch
> scan type at runtime, making it possible to support both 24-bit and
> 16-bit resolution.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Reviewed-by: David Lechner <dlechner@baylire.com>

Typo in my email: baylibre.com

> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

