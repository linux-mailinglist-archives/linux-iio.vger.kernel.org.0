Return-Path: <linux-iio+bounces-12170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5C79C4956
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B6BB22336
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CD1BCA02;
	Mon, 11 Nov 2024 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XlKi6OPw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDC156F5E
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365468; cv=none; b=nGlmV47CenDAQzT3i4dc2wwv3QlTNhg+ojUbUwI9y24cPisAQqY2Pp28RFnHZUDshDssKjMOVq8YcfZJveI8vXTGfkQXdHJ5NSeIzmgXbMhILbVw/um/kDSmenF2wylMAayxsTKccMBvVqTuuzea1xbX4zvXd21XWCSoQYFtw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365468; c=relaxed/simple;
	bh=NyhDWCmh/e17XfKVoxY6SLJ29UtaIpJ+DelPVZzkvOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/tkNlaFjkEcyzhhXORWkkOeYs00sQC5posI+0W3JPlLHiPfhwru8PwVOU1qaTNtPapIO8RovLCU2guIDiPNtgUh8QFgXi5+yuMKNqkFWVARGEZjIMhvRblobMsT6nxJVoUfVkyGnna4Csn+93wDEgUnu/2V81G609ccJv90qRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XlKi6OPw; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6bd37f424so19870125ab.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731365464; x=1731970264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTdDzCYRBRhSLyboKtTQOLAFBt9x0DbQTEdRVM6MA34=;
        b=XlKi6OPwcW9nXsDNMSE4muia2f7TOxnVD3xkPskrqUopCq7c44hXwbtcFRE3aU90kN
         UJKpk4p8XGScesk1Iwd8P8vBaCv8C198CE+qZwqnV1GQ8RCJmKxbzydtokRLuveST+Ul
         A/JC7USaQW6I+yh//1t/rhyHvhAlrJQnXPyz4eZKND51jWSIOysx8ut58oVccl9rZDFh
         3ptN7YKOGHTGCjE1roZsvgBY59GdaV2vBGnESQ3CEAf4EEiimzPGJpIoYNRhAIz+x8cs
         hVmtr4WyYfrBuHGXZzSyzisSj6juLyJ8P2+0UwIGwOsz8MnHI3BlKK085g4QAL9iZVSH
         xexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365464; x=1731970264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTdDzCYRBRhSLyboKtTQOLAFBt9x0DbQTEdRVM6MA34=;
        b=iB6DQzTH96P1f215ZcYvbcVc2FxGqjJDM3ekkOYhy/tSIVM3PDs3oX5HaPTyHsLzpp
         508TO00bGEiLlVSdLEz8QdswWWf5R5dMi0VGZ0NBFX3OWQXGhNJsGhio7LkR+GufJ9yg
         v7wu3dW13K9TIAzGcft9kINdwwqBb2jmKaBE/B8ByTxVox/Gj0C5lCwKoW/b2DaeOQIg
         oRBjc6lUFn5h630pXImDIUBbQ7v7Vp010oDLnKhOAIzhgdYR/UiBcHYr8VV50+sYoGsV
         AOfkypyOBcWFfIj9Yc588bMLIxaBcM144hhYsiGWG+48w2gC6G6bKRwQgEQaV6DGUwzu
         le9g==
X-Forwarded-Encrypted: i=1; AJvYcCWIfQJqwd8pyNya/uMW17HK6SPVOL4p1p2RtehzXPKOvPoY+YeYZY41W3hO+WAZIaee1z27Z1fbJe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iiAibAuUHomPS7YhCSKK3joNmvlAk6xviBf4qpwBNUsa8g4Q
	Ul4iNxPovzsTE9BHKIfcYumU3lmErEQ/7qEcv6bo68O7qgspk6o7UMetDLbI2Jw=
X-Google-Smtp-Source: AGHT+IEtIUyvJdzpK4c4ujWrQA/hnBETNtlG/7l6hYXi6h+y3fgZDr4h4pUhVLK64ZeQM/TV6wduHw==
X-Received: by 2002:a05:6e02:19ce:b0:3a6:c1ad:3a02 with SMTP id e9e14a558f8ab-3a70c8990e2mr4057645ab.24.1731365464197;
        Mon, 11 Nov 2024 14:51:04 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f987e20asm16884155ab.56.2024.11.11.14.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:51:03 -0800 (PST)
Message-ID: <b15fd3d7-6add-4220-8c24-afb725177466@baylibre.com>
Date: Mon, 11 Nov 2024 17:51:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ad4695: add custom regmap bus callbacks
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
 <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-11 10:59, Trevor Gamblin wrote:
> Add a custom implementation of regmap read/write callbacks using the SPI
> bus. This allows them to be performed at a lower SCLK rate than data
> reads. Previously, all SPI transfers were being performed at a lower
> speed, but with this change sample data is read at the max bus speed
> while the register reads/writes remain at the lower rate.
>
> Also remove .can_multi_write from the AD4695 driver's regmap_configs, as
> this isn't implemented or needed.
>
> For some background context, see:
>
> https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/
>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Found a couple more bugs after some testing. I'll wait until EOD on 
Wednesday to send a v2, in case there are any other review comments.

