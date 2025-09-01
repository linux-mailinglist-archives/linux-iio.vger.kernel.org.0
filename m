Return-Path: <linux-iio+bounces-23597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C26B3ECD2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B42E7A5B85
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29321306484;
	Mon,  1 Sep 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oTTNc8if"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3B32F773
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746049; cv=none; b=nADXK9xrnnvFC7EqBwHH/VNKqnLFwp9t5RGkXwSM/ljAX/QVFv6SDsGiimvKJwXoBMruZKyUFudFHAjJxn+sVW2MpcAjB7hvSIZKg+fQ/0cGD2PjpNEer4uCSiWxdKOcVSbRSTMhU2j9FgzwY9vXuhyHLwCH+j1lP16NnaDMfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746049; c=relaxed/simple;
	bh=Bt/E5fYRuYgMGd5E3qlp1QAR/XCLIWL9ANVQ3PXy9nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHC8IZgv7YtghZTlilzRCXJU1TH2Es1334NgEX0jPFOxd85MjcT4piDMyUxVv65Ezg9N9h9sVIK8DtRmtBxxiZtmL8+A1gSSh08s9J4CsHjGuJp5zeW5e+BdCak7F2zr/6ymmtNpeIKA9yAvJncdgXyNh01gYjjX8+gl67QaFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oTTNc8if; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61c0b41ddd9so2613533eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756746046; x=1757350846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrqdFNDTpOyLhwZdVOt2XYhBmnygUG0NkUlt1st9S5o=;
        b=oTTNc8ifbwPQOA0dYpBVvS9Fqk0TWFOwKcNJVy4q5qAwNWzG4BuKclPd9gHICsKKEq
         QeqXED/p4+KMCVPrdiNI3xovxx4MHORr2tR1jA/q4ZG01xaWK+MFkVMBLYtjb9diaDu3
         XZrrnruUZUTDF86o+7AqX2EbgljUeOxQQmqKCARQWOqEvMLZbt5QYAXxhS7PNCMfFKBC
         moqZL55VcxkFoq3wXOpfyIusA300cQRT847LyAh12G55lmxOl4nddl6l4R047EwbrQmP
         UG248Z4OIRoCSMH2rABvDaZYq7AneOhUIePtYWnl2qwkQFnzHEf3jGpcIe7V3Uk5aWTV
         krbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746046; x=1757350846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrqdFNDTpOyLhwZdVOt2XYhBmnygUG0NkUlt1st9S5o=;
        b=tu7zwMno9WMd+YEiOn2tob2v8hifCzv9zoUlKoEf+qedcB6Mf3y32luOaXnGyhGzmM
         F+++dZfpSqNcw0Bzkm4MDRawF20erkHhCls4k4CuKzekLZTijCZzy5z8p2u1jZUTwB5I
         8H6ZBf5xf+78KQWuh69gVnseSxuLdsmtXN7blQEBPycGM3S6ndrGjPFbjmhax/aeRNQG
         9BlbG9yi1PmRCpV9l1f+JalO0pnXcTNxUyuaJHhwUVo8hWWhRCVDhXicioVnpgj/0A5k
         OAqT/xSWg2bdhcXLc/2g7GafsExpJMiPNTtwA69hbQsPctD6c7n/bPGz5BdFTwO+66aA
         N+5w==
X-Forwarded-Encrypted: i=1; AJvYcCUNasKviS7FPFInKWm1KXwmpL14Y5z67tyG2g49cJ5g57gb5yIPQRuiUswUIUqvy1Qm/xcQhd4CM0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYJMdiQZutdbQ8VYVi49fBDwzg+SXCpCYKA5ld35amujCMwSq
	n48dBXbl6/5c1zCSb8lsO8KCKMYWB99xPsxyeldndDeLmcUdyrj7w0eCvsGUz9L7Mvc=
X-Gm-Gg: ASbGncvjT0Lgf1huEKRGGNQBfqFhkfo84VxUPkLtGje14m0GAuDIDwmtt+dfR/1IzUj
	ygyOB4STetFxhpUNGMOLCi8P63qxINyeF678oBgAic2CITX71uGdhSFKicMSU6XJOccNC2QAC5U
	lupJGr+nBT9AFwT/U/vWqgsbLb8Z2ZyTKjwmNO2WOO+nmaQ8/s4kJD7EU2tLRVlEsUPKpiHoTPT
	5Cg2A+unFRbBiRqFyIEoPLqe4/qlsOQ7WaqgcDeOeKF/5uN/EKgPInfzg57LmumiqHt85oy/Krr
	NXr6xycCEzyHG9svDus7HMJeK3SJk7BdzpO1DzI/VUD7heb0bmszvxKRz9rgOT09YQExKZ+R9HY
	dOzeDp7rEvg9V0zFqM4hOmtHA+F2KjOv9LyT9iZZRGQ/24/hBlxTdP3U2LLJteJIJ2frIp/pj
X-Google-Smtp-Source: AGHT+IGB3TjTYkZgHsuQOjcnZwKuCtsoGCrFHqU14FGoXAjd8xo5T6xjTMwKegpWpbn1ROIfbcTsBw==
X-Received: by 2002:a05:6808:2386:b0:433:ef4c:6d85 with SMTP id 5614622812f47-437f7ce00d8mr4030240b6e.14.1756746045833;
        Mon, 01 Sep 2025 10:00:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43800064245sm969232b6e.23.2025.09.01.10.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 10:00:45 -0700 (PDT)
Message-ID: <51042a87-0233-4748-b3c0-b167d3a4fa06@baylibre.com>
Date: Mon, 1 Sep 2025 12:00:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] staging: iio: adc: ad7816: fix race condition in SPI
 operations
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, sonic.zhang@analog.com,
 vapier@gentoo.org, dan.carpenter@linaro.org
References: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 11:03 AM, Mohammad Amin Hosseini wrote:
> The ad7816 driver lacks proper synchronization around SPI operations
> and device state access. Concurrent access from multiple threads can
> lead to data corruption and inconsistent device state.
> 
> The driver performs sequences of GPIO pin manipulations followed by
> SPI transactions without any locking. Device state variables (mode,
> channel_id, oti_data) are also accessed without synchronization.
> 
> This bug was found through manual code review using static analysis
> techniques. The review focused on identifying unsynchronized access
> patterns to shared resources. Key indicators were:
> - GPIO pin state changes followed by SPI operations without atomicity
> - Shared state variables accessed from multiple sysfs entry points
> - No mutex or spinlock protection around sections
> - Potential for interleaved execution in multi-threaded environments
> 
> The review methodology involved tracing data flow paths and identifying
> points where concurrent access could corrupt device state or SPI
> communication sequences.
> 
> Add io_lock mutex to protect:
> - SPI transactions and GPIO sequences in read/write functions
> - Device state variables in sysfs show/store functions
> - Concurrent access to chip configuration
> 
> This prevents race conditions when multiple processes access the device
> simultaneously through sysfs attributes or device file operations.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> 
> ---
> Changes in v4:
> - Added locking to reader functions (show_mode, show_channel, show_oti)
> - Fixed incomplete reader/writer synchronization that could still race
> - Ensured all device state access is properly synchronized
> - Replace sprintf() with sysfs_emit() in all sysfs show functions
> - Use sysfs_streq() instead of strcmp() for proper input parsing
> - Implement locked/unlocked SPI function variants to prevent deadlock
> - Use channel snapshot to ensure atomic read operations
> - Fix sizeof() usage in spi_read to be more explicit (sizeof(buf))
> - Make oti write operations atomic (SPI write + shadow update under lock)
> - Fix race condition in ad7816_set_oti() by taking channel_id snapshot under lock
> - Fix return type consistency (ssize_t vs int) in show functions
> - Use chip->id instead of string comparison for channel validation
> - Add explicit cast for narrowing assignment
> - Add default case for unknown chip ID validation
> - Use cansleep GPIO variants in sleepable context
> - Improve lock documentation for protected resources
> ---

This is way to much to do in a single patch. Also, given that this
part is obsolete [1] and this driver is in staging, is it really
worth all of this effort to fix it up?

[1]: https://www.analog.com/en/products/ad7816.html

