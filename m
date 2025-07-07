Return-Path: <linux-iio+bounces-21434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C0AFB70F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD31728ED
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451D288CA1;
	Mon,  7 Jul 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZaSWHCSo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC4199EAD
	for <linux-iio@vger.kernel.org>; Mon,  7 Jul 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901336; cv=none; b=ttTn9wBFxDWLrLFQNvjboBz2onqdOF6pQplmX0CYTa++DkgFuBKmtj1jlOKO7p6QLQooagTXX69OSq+SR1h65rnvqAD0paiPkEbijRaOI1ZQxZefaUJAIeSbaEH+NUb/YESU+P+thNmyGiUXe02vY5wAp6OJMfhC9vpsdyKQ/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901336; c=relaxed/simple;
	bh=uTjhbn9sjZ8nYDFwLW3rKKkyudKoLuSkFLrx/5nIwJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZxnx7byzaruKN2sJTc6pybUUsUcCjNaFEbGln4SqTYDdIhYfAzY1jTIEqJ48ZJzqzN0Efo+5ZOngODCorMDdylt3ERlWft45n7Fys3KTHJCS6vQ01l7AYQVw8DfNYrufNHqNKmEJP4jEUT5P4sxq1XP3X5l3EGb+l44Iu4UaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZaSWHCSo; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so2419561fac.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Jul 2025 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751901332; x=1752506132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAMRas9DqpUlmdQlIb5TMSHqrY2Rb8U6bBcLvEpVLe8=;
        b=ZaSWHCSomd5+dRK7xmh2nj+HA7l6VNNpUf8eE3n+uF8zy5nM3MT894b2F86yGHbuyk
         J9YrSa93PlDiXaXcqGUEVVBt4kbCnGhTvB/l/fgwiVIEuLcfO5/1SdZZJd3HkyzgZDON
         canpHBca0C+EjnkCUs7Rl1lqAl7RGBfXMETIaXvPwq/tAP5xMcGlHxYvEVAQquG40WEx
         T0tBdRuMNw8fEjYTevD9EyYkQanjkWy8RVx3AHvDVK9kjTqSkTCoLnovUXF0xYu2Sflw
         mxqrlJuTKK45fJ06ST+30qba1Hae8XNcrUE8jmSoehqjfJBxmImncZwM1vo104SuY6xL
         cvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901332; x=1752506132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAMRas9DqpUlmdQlIb5TMSHqrY2Rb8U6bBcLvEpVLe8=;
        b=vPbsnMhQZ9p/iu/RyIaBMXB0052cpWKOfRBV1pv54GMhhhhqhnvxc+5Evcz0Td8bCA
         m8mtNRZognMrFtBG+wVF1usGauclxi8BdIfWYLijs9S3V4cJr3PBAKTtgPaiyAwxynxF
         lZ68I2fv6TOySvJ2kthzmB8invjJcVmvnMnydKvCsghEJiSti+b2loQxysPdOuhux5NE
         WAV4cS5Fyvfd1PKlveh/3YXUbjvEARsbomeo9OByBN8sGmSxjBn1nN5v4cTKflNcHyt8
         UntAqJBUAfpmV0KfijjZfktQSsKIIdJOiwAbjwJnCk9xTv359FIUZlM4ALhE4JB0y+U6
         Ehuw==
X-Gm-Message-State: AOJu0YylbgvBtZmha2iJD9K3VVrRKq9eT5Zfxh9Bq5aen6poU2ctyFro
	2a+S1jaYQxJ4yzsSyip0xVcxG/MRh+IkUZ3fn/s9K6+7z3ttogCIND2+wwl6Al7v7ck=
X-Gm-Gg: ASbGncud+Z2/SCUXi1U9rjbpEe6ENleM9FKSCyFQgw7lIApZKgnEjS7rV5TlBjBEg/o
	eVgK3KTkpVj3hN+DnZipY1O18vFH7KnSo7czr5O9/RxFpgNOnjr8zaPfAkq0O+U7UvF+xxrZ8Hm
	mj+fdOUchmJkJWWDMj+2jVQWy8ULO8U6dptb3QF35BDvuTJSZXVtUYF1jgMDmk0wNjOU6oK01tm
	v1xms05WZrr8YvNzcREciJpgkPeOwh0t/YDiJ+R4hhBMIPpS+frkZB+7RVg2BD8mLSZ08X3W+R/
	jzAlNMqAxgl2ARx9OKes0SbyXONhZif5frRupJpRoUXe3aLNfdT26NLMMo+Bcyf6tUxXtX5FV/F
	mrCOF1BaoPIMPoS/h7IMUUYUS+SNXTrwLY8rrvAE=
X-Google-Smtp-Source: AGHT+IHR4p+cFMDG6ujNP41mFtXD5qjHs+tyWfZeT3b0Sz79ynr+NC78trahunrJcvyh8knmamWv7Q==
X-Received: by 2002:a05:6870:9d95:b0:2bc:6933:4a9f with SMTP id 586e51a60fabf-2f7b004c91dmr6729531fac.25.1751901332301;
        Mon, 07 Jul 2025 08:15:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9991:e55c:8c0a:6a8a? ([2600:8803:e7e4:1d00:9991:e55c:8c0a:6a8a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f7901a6324sm2299097fac.31.2025.07.07.08.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 08:15:30 -0700 (PDT)
Message-ID: <214c7998-d9b6-4d18-adbc-e1a38a685572@baylibre.com>
Date: Mon, 7 Jul 2025 10:15:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 9:42 AM, Sean Nyekjaer wrote:
> Hi,
> 
> I'm having some weird issues with reading the temperature of the icm42605.
> Kernel version: 6.16.0-rc5
> 
> # cat /sys/bus/iio/devices/iio:device2/name
> icm42605-accel
> 
> When reading the temperature I get:
> # cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> cat: read error: Invalid argument
> 
> But if I read from the accelerometer first, I will go better:
> # cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw
> -378
> # cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> 600
> 
> Then after "some" time, I re-read the temperature I recieve
> "Invalid argument" again.
> 
> I have traced the -EINVAL to inv_icm42600_temp_read() because I receive
> INV_ICM42600_DATA_INVALID.
> 

...

> 
> Will the iio core retry a read? If the -EINVAL is returned,
> inv_icm42600_accel_read_raw() is call once more.

No, the core code won't retry, it just passes the error to
userspace. But it does sound like this driver should do a retry
since the datasheet says:

	Invalid Data Generation: FIFO/Sense Registers may contain
	invalid data under the following conditions:
	...
	c) When accel and gyro are enabled with different ODRs.
	In this case, the sensor with lower ODR will generate
	invalid samples when it has no new data

So it could make sense to fsleep() for one ODR period before
attempting to read to ensure data is available - assuming that
is what is actually happening.


> 
> One more thing...
> When I'm removing the module, the kernel prints this:
> inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!

It looks like there is an extra pm_runtime_put() near the
end of inv_icm42600_core_probe().

> 
> I will continue investigate this
> Br,
> Sean


