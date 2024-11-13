Return-Path: <linux-iio+bounces-12230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE59C7D9A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 22:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CC2B2B374
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658B20968D;
	Wed, 13 Nov 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TiMwg/yU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAA1C9B97
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532694; cv=none; b=sjD56v68CCK4pjkDlP0bhCcoQUl/WOEfokyiqWiKwFvrn29TjwqZODMrUnZNOrBvmGXaZcac+b+RV5pSzkXaXtR3nRpemAQIJHEpBHTKMNPmwXNVGVflP9pIdN9luuE8fLTmvgG2XbETTOvUzpz+OYmn4m2tQqz98xrls8v2gDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532694; c=relaxed/simple;
	bh=f6dori5l/j78KrvEqw9PZullPMp0BknMmMOtu9U8qi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPjxADKsL5OfRk3jQG+/za0x2fwHHmh8A4GmkwPIkPFZqEmWCivllN+I3SnqKbUYC5ys+Tnbrv9u+9WKr/mcEUc1O+FBM2TCYG608Fra/PZXAQO+s/DVazk1wsZjXeELRbBvXw7QMnZM2kDEtnqIZwipQwKRXDdoeBMs1D0ZD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TiMwg/yU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b155da5b0cso517437885a.2
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 13:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731532690; x=1732137490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEq6Xm9vC0u0FZtqckrn5kDwb1c/gkCi+Dl7LfGpdSg=;
        b=TiMwg/yUkVnXUhmDp43kRduGIV/dyLib2LyObLH081e9N+GuOg4nE/GRXP0RfzAUeI
         eVNIt470SKEl10XJ2+E2x0tHxHUBlnEh1GJS8y0nBzS6J7oFcAayVdbVYpUMwhHF+lK/
         cWXnsn6j+CVxUNbV6bZzqHXX+OP+tRnnSsNmtp9vjYUnieb2NjvwSgJh+uGsm4F5y9h7
         lgTtHklXenpH0bvkktrNZo8IuiX/SsPPZKLp4xp1IL5sJJerKr4UXBen2KDVfFYLUe9v
         z/RiE/1J67JFoqRhCzzxSqMz2MDB1DVxxxd4BW3p1z98fZWpWCjEPJrAICuCJVBWui5c
         V+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731532690; x=1732137490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEq6Xm9vC0u0FZtqckrn5kDwb1c/gkCi+Dl7LfGpdSg=;
        b=dxO/0xPxzOLP4Kyrs3PrwFO2IOJlUf2S1JvszbWj+0zXeA9dgs6XrRAoSL4hXqUryn
         xvgf7YsL+kB9QVzEt2BANUiSVzx03HLwBAZDb4hpGS6GeHs894Wdvih2xzEg8/Q/Z1PQ
         zT1L8rSNnkKQ0HCQaj4e0lHTAryEGIUKp/8RG+FUi3dBftloAAfXJGIQ0sayGiS3QWmu
         n7xBZoxNGOy+H7YaYGHIEEUfuZfA+ZF+veJOhq/BQABQSvzERlSaJOcjBVs86UiB30q6
         1Q4Q/FE5okYKInkew2jVqjg93YsMjG1WhaYwFjyp12J0EhT8ykzcdQ3HWcQHQUWQT6PC
         ppzg==
X-Forwarded-Encrypted: i=1; AJvYcCWJDb/SWaBVGbW9yv1gDgdatiN5tIsaIL7Ioen3eWEmbAFeqVMYK9MdMmwXObrZ4cpTdRE0mhnZPqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxSc8hPLm/+zUr+NJitwA3LRMXLt5dB2AoTYJBq16KknrmAm4
	YRBB1iJHsZwrBHKwByPFUO1XjLoyjUf42DvJ9K7JIyf5slHApBQPZFrC/si65wk=
X-Google-Smtp-Source: AGHT+IHFSpQjlUsjk+2YOLoGfSo3p++v0v/Xnn1uMBjGnraxgrkmUvtPg3uLcuW6zLUhDH0SAPOG/w==
X-Received: by 2002:a05:620a:2441:b0:7b1:4f3c:3a3e with SMTP id af79cd13be357-7b34bbc2468mr835009785a.40.1731532689818;
        Wed, 13 Nov 2024 13:18:09 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2db0asm731208285a.26.2024.11.13.13.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 13:18:09 -0800 (PST)
Message-ID: <43a95a8f-6677-4d41-b71f-83454b39d304@baylibre.com>
Date: Wed, 13 Nov 2024 16:18:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: adc: ad4695: add new regmap callbacks, timing
 improvements
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-11 10:59, Trevor Gamblin wrote:
> The AD4695 driver currently operates all SPI reads/writes at the speed
> appropriate for register access, rather than the max rate for the bus.
> Data reads should ideally operate at the latter speed, but making this
> change universally makes it possible for data to be corrupted during use
> and for unexpected behavior to occur on driver subsequent driver
> binds/unbinds. To solve this, introduce custom regmap bus callbacks for
> the driver that explicitly set a lower speed only for these operations.
>
> The first patch in this series is a fix introduced after discovering the
> corresponding issue during testing of the callbacks. This is a timing
> fix that ensures the AD4695 datasheet's timing specs are met, as before
> the busy signal would sometimes fail to toggle again following the end
> of the conversion sequence. Adding an extra delay in the form of a blank
> transfer before every CS deassert in ad4695_buffer_preenable() allows
> this requirement to be met.
>
> The second patch is an improvement that increases the robustness of the
> exit message in ad4695_exit_conversion_mode(), this time by adding a
> delay before the actual exit command. This helps avoid the possibility
> that the exit message will be read as data, causing corruption on some
> buffered reads.
>
> For additional context, see:
> https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/
>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> Trevor Gamblin (3):
>        iio: adc: ad4695: fix buffered read timing in ad4695_buffer_preenable()
>        iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
>        iio: adc: ad4695: add custom regmap bus callbacks
>
>   drivers/iio/adc/Kconfig  |   2 +-
>   drivers/iio/adc/ad4695.c | 135 ++++++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 118 insertions(+), 19 deletions(-)
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241111-tgamblin-ad4695_improvements-7a32a6268c26
>
> Best regards,

FYI, there is now a v2, so if anyone's currently reviewing this, please 
don't spend any additional time. v2:

https://lore.kernel.org/linux-iio/20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com/T/#


