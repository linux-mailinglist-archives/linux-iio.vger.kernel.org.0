Return-Path: <linux-iio+bounces-20446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F1AD5A4F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B17C3A3A5F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7A1A8404;
	Wed, 11 Jun 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jULf+8cM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2A1A3148
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655322; cv=none; b=e8xlIhf4cs1ZSfJbPvv0harlRROSzKEhGBwt8jk2a9uhz1KlSF6lyADpHhhxHskDq3re6aV9valn3hu+ICJbw38DswUKmMAaVPAB0sQsJMOdKwNEQUu8+knMoa9ufiLQp9jv5FTyX4bTI9uf3jpUuZGMCOWd8Rxckwnfizr7szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655322; c=relaxed/simple;
	bh=n3FIuLuKqif1KExLRabmovZHhue7y0ojxGEe3NwRxXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvTR6dNIScafSlORCLmfW/ov2X/ceFGBl20nltUUAokHP/HV8xqUiKpzIT/WH81eRV0TAT1aaotgqwcO8p7HyBXjwPILrJ6JyOzERvAcJ8BhTCSlzP7J3u30wE3780qZo50pCFGeefJkqSaRbOLOFR+F13/GLQzmfeJkpFti5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jULf+8cM; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so649571fac.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749655319; x=1750260119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ni1bRS8N4SwYP8j3tmW1ofRjVUzlSftGXXllzoEq6s=;
        b=jULf+8cM6m/TbcfixaF0rhXbns9HlnuZDKCJTnNKdhMLUIgezCBMiH17zKcRf9A+WB
         Ouz08KGx0yM3rbZsey4DUTLHK6vvITO6a1S919NXAknpX1bb16fPMDEtdYoNg7UIbfQY
         BUkhoUfiUNKrkC6EkblFxu5ih9/uY5HbWLKy71S1V5VOtVS3TdokY0I7E2BlSQbBsuhN
         D1Zt7ghWqtnuwIHcmV2aF7jpL68TObu9GFQnRFJt9DdgFm3lVUCH70UT9F/kx9hgwb67
         j1ytpMePrxG5rq7TNLVp6l5RsjIWsrgELzEjRFh7SHA8P+yeJTkIrWO2bIISTl3dQGFb
         gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655319; x=1750260119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ni1bRS8N4SwYP8j3tmW1ofRjVUzlSftGXXllzoEq6s=;
        b=MiwuC8MZ7KDvo4KKL4Eub7DVVntaoDyR8ErCmUylXuS1bEwVqPKsZ5EHyZsVW034KM
         p3+GoTjJ78ft5aMw3qWsi0A3WbZJVNTUvLzFzKKBMpOAZ3JctAbMATEwvTPjfAitlTM1
         PpO68HfwiPDFsYwzc1jGOB0WEeC/MQoRZe7DNuaENoX8FPq7znCuKLGogrYhSP+uDniB
         AUTtsqv8j8hhKM+A4Eu/2Jb3TqhcZFW56H5v678hvedtlRdskuiQIqWSclFUp4wXFpwB
         AHFpyoiaZQp9HMe2OduyrVDz0ev91JlPKU8752YrThjZJK/SX+r9/ixdgZiHwnjCC3qh
         0Jyw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJdN9UOixECV0yspgCZabPwC4v+OYwFuL2ZfT5kmvcL1r28VP/sVQ0u3rWYpeRTyN+0a8E23FDS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQTUkdYEdXryBm7UZMjEHNxOQgKq4vIihLt41ci3/xaxoIVqH
	1euwunCEtcCKRF09cOzAjOwP94ZQ2uKWMfq8m79xCCIjxabgy41SQqylaes9OfiU7b4=
X-Gm-Gg: ASbGncvnpv2GZ3XiDxN3sM5bkmfv0tAATspbLQ+O1bYMV9cm6RZ9mLgNZ6bsM9xqo06
	mKBxzzVq6+xkaAHTJD4M9A5EbaTqdg7yyn8H9CoDFMzpILOGzNg2Mvpl/hw/iuEpKehGqdBq/Go
	VJ6WkLr5wG6w30aAA7xBTW6Fbf4Zz+ZYc0hsAutYtlPaHUCt0M0YqnGUSDR20f0daFa7Bkb2tYp
	oWHL+vBlnLsnw+DE0PrgEseIluzsb+p6bc46jdYpnESwxJibhxhruav0Q2yVGu1M65B4MX4Dgc3
	2rdT1cssdVrUrpEjenk5ioD3z4eh/vrGGbwO8ysMr89k60tJ27L3wHHdADdrJapWhqY6vV4pPpv
	Ogr0jV8ZC1Jj0xz73s6poWbT+w/bcEsTU8tml
X-Google-Smtp-Source: AGHT+IFMlCBuWrdSbRxuwu2djovc+7uWlkauXqh9E527VuU0BvMxRjpCUjzMoKCENhmWc+eyP/kJqA==
X-Received: by 2002:a05:6871:4688:b0:2c1:4d18:383a with SMTP id 586e51a60fabf-2ea96314d03mr1622210fac.3.1749655318938;
        Wed, 11 Jun 2025 08:21:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:eb6c:30d1:632b:494? ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea072e5d0fsm2891474fac.24.2025.06.11.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:21:58 -0700 (PDT)
Message-ID: <851b7d08-3e77-4344-97d1-9d60f1fb8762@baylibre.com>
Date: Wed, 11 Jun 2025 10:21:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7949: use spi_is_bpw_supported()
To: Andy Shevchenko <andy@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Da Xue <da@libre.computer>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
 <aEmdhV0ATRuUeGaL@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aEmdhV0ATRuUeGaL@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 10:15 AM, Andy Shevchenko wrote:
> On Wed, Jun 11, 2025 at 10:04:58AM -0500, David Lechner wrote:
>> Use spi_is_bpw_supported() instead of directly accessing spi->controller
>> ->bits_per_word_mask. bits_per_word_mask may be 0, which implies that
>> 8-bits-per-word is supported. spi_is_bpw_supported() takes this into
>> account while spi_ctrl_mask == SPI_BPW_MASK(8) does not.
> 
>> Closes: https://lore.kernel.org/linux-spi/c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk/
> 
> Reported-by yourself. I'm wondering if the Closes adds a value in this case.
> Otherwise I can do the same to maybe 10% of my patches, for instance. But
> I don't think I put Closes tag on whatever improvement potential bug fix
> I do report (read: notice) myself.

I included it so that Da Xue will know that this has been resolved and
doesn't need to do anything more. Normally I would have not included
it though.

> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Code wise LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 


