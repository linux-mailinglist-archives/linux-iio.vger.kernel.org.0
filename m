Return-Path: <linux-iio+bounces-23610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB8B3EECA
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CE83A6EBC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D2269CE6;
	Mon,  1 Sep 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnpZQOAD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D62690E7;
	Mon,  1 Sep 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756010; cv=none; b=lWt4pkUfOuH2SC08cMT87mapG70DivMTwsQUpWAzit2NMDzXcSMcVkgZC/mTlhLkx7pkT2llpxMBVMQwq3dlhuypEKUf2+xnh7UOjaWPbYwDvD7Jjks+9vs3CAt/wZJ7W3tsXI6uBHpJPjrzQ+ZfyvumIUOkh35rLvj2kYz2LE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756010; c=relaxed/simple;
	bh=ryLKVNWHHNr99ui3supYs3n7AEHkdw+L0ecBy0DtCNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwtNDY/cfk5ii3pu6p9lSzligyer/g1uR9xi1QdtB89o4ZhkqFhFIE6FpLVBiT9/Amn16zPr6djyI+mcJn1fP3zJTu5p2Lhp58d4gg79fJnqzpT4zWFxXTMRVJ0mtQSNr9heQKF7/aOTZGcjGhOhUad6DzyX2L2j0H2Q++3qLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnpZQOAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB61C4CEF0;
	Mon,  1 Sep 2025 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756010;
	bh=ryLKVNWHHNr99ui3supYs3n7AEHkdw+L0ecBy0DtCNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tnpZQOADOfFuqatEL9arhjzFqUnaI8SnD2BQS8K7II/uVlfhOgH6pVaKpT+m6eMKs
	 OFq/UZvfOdyGVkXmOin84sqtKEwzdRl5DwY5gVJzk5URFNkK5qVAsnwibn2B1tgXv1
	 md+Z4IGfNRw4uas0u/F25H4ATP9thnlpm/U2KHaDf1C1ZUtqSyCo41qxFVaC+LeEzr
	 3AEFTDAC4gc97owBvU7oGu++J0Kyy0YARy4KitvFNpNtAN4qcX/S1yxrspLbvelQbH
	 9+dQYsx8jmLTmKHQwU3/wRmHoJdZ+KKGNcvjAatk1SgmbJFxFeTKoR2vlIUIlkmJ0k
	 HTdr2YG8jXvSA==
Date: Mon, 1 Sep 2025 20:46:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 sonic.zhang@analog.com, vapier@gentoo.org, dan.carpenter@linaro.org
Subject: Re: [PATCH v4] staging: iio: adc: ad7816: fix race condition in SPI
 operations
Message-ID: <20250901204640.3cee61bc@jic23-huawei>
In-Reply-To: <51042a87-0233-4748-b3c0-b167d3a4fa06@baylibre.com>
References: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>
	<51042a87-0233-4748-b3c0-b167d3a4fa06@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 12:00:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/1/25 11:03 AM, Mohammad Amin Hosseini wrote:
> > The ad7816 driver lacks proper synchronization around SPI operations
> > and device state access. Concurrent access from multiple threads can
> > lead to data corruption and inconsistent device state.
> > 
> > The driver performs sequences of GPIO pin manipulations followed by
> > SPI transactions without any locking. Device state variables (mode,
> > channel_id, oti_data) are also accessed without synchronization.
> > 
> > This bug was found through manual code review using static analysis
> > techniques. The review focused on identifying unsynchronized access
> > patterns to shared resources. Key indicators were:
> > - GPIO pin state changes followed by SPI operations without atomicity
> > - Shared state variables accessed from multiple sysfs entry points
> > - No mutex or spinlock protection around sections
> > - Potential for interleaved execution in multi-threaded environments
> > 
> > The review methodology involved tracing data flow paths and identifying
> > points where concurrent access could corrupt device state or SPI
> > communication sequences.
> > 
> > Add io_lock mutex to protect:
> > - SPI transactions and GPIO sequences in read/write functions
> > - Device state variables in sysfs show/store functions
> > - Concurrent access to chip configuration
> > 
> > This prevents race conditions when multiple processes access the device
> > simultaneously through sysfs attributes or device file operations.
> > 
> > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> > 
> > Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> > 
> > ---
> > Changes in v4:
> > - Added locking to reader functions (show_mode, show_channel, show_oti)
> > - Fixed incomplete reader/writer synchronization that could still race
> > - Ensured all device state access is properly synchronized
> > - Replace sprintf() with sysfs_emit() in all sysfs show functions
> > - Use sysfs_streq() instead of strcmp() for proper input parsing
> > - Implement locked/unlocked SPI function variants to prevent deadlock
> > - Use channel snapshot to ensure atomic read operations
> > - Fix sizeof() usage in spi_read to be more explicit (sizeof(buf))
> > - Make oti write operations atomic (SPI write + shadow update under lock)
> > - Fix race condition in ad7816_set_oti() by taking channel_id snapshot under lock
> > - Fix return type consistency (ssize_t vs int) in show functions
> > - Use chip->id instead of string comparison for channel validation
> > - Add explicit cast for narrowing assignment
> > - Add default case for unknown chip ID validation
> > - Use cansleep GPIO variants in sleepable context
> > - Improve lock documentation for protected resources
> > ---  
> 
> This is way to much to do in a single patch. Also, given that this
> part is obsolete [1] and this driver is in staging, is it really
> worth all of this effort to fix it up?
> 
> [1]: https://www.analog.com/en/products/ad7816.html

Sadly not obsolete (or at least not all of the supported parts).
I checked these out the other day - the ad7817 is a production part.

Biggest issue here is slow down!  Too may versions, without
time for thorough review before another one turns up.  Aim for
at least a few days, or a 1 week between versions.

Jonathan

> 


