Return-Path: <linux-iio+bounces-23626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63424B3EFC3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 22:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3074F205B97
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBA26FDAC;
	Mon,  1 Sep 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rLUDDSDf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD226E717
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759066; cv=none; b=ZXvo5YOclEMrG33fnPa9cUM0+Z5RlMpRlM/sBQ/uZ1teT0kcHrwHtIEecbSjnOJqM/Bv8Zr7njEoZ8iYAMKpQg4P44Oneg/oi7jIKpHo9c0p0zPs2z80xHDgyGSU5A1i8QuQj2tv8951ABOFDDqyHRp5NYQMDEmFfVAePqZASjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759066; c=relaxed/simple;
	bh=+HxizGUNPE0IAbaEtDTKLzRhHig2naRomVFB+5URGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXmUpTugYl/6YB5IMYzhi2FIJU0cgk8J1dXXp6/KIKlm0rb+5XgfYvxUQ7hF+LtSW68arsugiElwazC6bDSN4Q/ogCwc8rP/PAz5FkAXLN5jsaDj5EHDq/cVuWc5rM2XFmhcC95RAAx7TS7quiwqLEK3t+nsfXCq0pHHUc46B6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rLUDDSDf; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74557b7703aso954044a34.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756759062; x=1757363862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zfsf0ToW5FKPBE5eHIj7npldCgSMxNQpkAfQKcXNrQ=;
        b=rLUDDSDf/YqG+lnXgJINjqXRnnb+9yUJBHclmECUxlrFcXuRBVSPYSSnw0VSTJ695N
         tF+J4Dz6XIVUHRj/RGsWidh/JFmAglX875IQ452rgwhYpiiEVHbB3xDiQRWH0nTHzTw3
         6SnXWfxHq/nUn1GBDkXPRFqH9CODqHXd6lqy0/IYN4hW8YcHees8Du6orDW37RoXjt0q
         MORCEUH6zwW0/SrUw64kUbeT7Hb3z0tRGvGd3r9sB0QUplIwCboI2IQ1SfzaY0NzqiTH
         5CNBVFXI4xuRA+vuhrlVkWTi39mEsBoxrJJdAdfnMHLFIuivQWyDXzecqtZDmiFTFx8A
         clPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759062; x=1757363862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zfsf0ToW5FKPBE5eHIj7npldCgSMxNQpkAfQKcXNrQ=;
        b=j0uJhdIIHhjleA97hsONoFa1aeMjANrQ5woF2BbCiYlVjBMRG/gB8ZnitL6zF1l7yl
         MHuK4dKMRm+ZtNqvnqUdTTRRdNnpUD/ou7osA5YqxyuFly25dII9yxyuoBnnxzAWb58j
         AUas0b4TTInvsNSY01c3kkdIeVi9Sv8z0SNOLRuzbh7RhjIXo7mvj+crhoajv5uVLNdi
         5WeI4208soRUnUxo0fAT/KxEdEr8nQK2f293QF6YXIwfGRKgl8xbmknzI7vJBa5YH3na
         G4h17Qpnj3qgCnQfspJLwLp+hjwPVyt1rFChkYrKu2qXg732L/xPNc4dqh/qxGXYuldy
         JL/A==
X-Forwarded-Encrypted: i=1; AJvYcCXY5OP7GcpZVFtik4Pr4FrKzdz7Z2xGvnEmwZkWOm5pzROSbH6PdtQv6hJ40jjOd0DFxEuQ5bQeAag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxmLaUCQBpI9iw7QkcN+2xtDN3tLfX6EDf2rE7LuKP7XZQZtpD
	B9aiN6IV3uPI4Wb10j1a3t6OH0hE2/XBPcnVQ3JS/bokOTT04EXhaFE1QGSHnVVFPIYGRNnJGqh
	ykNOy
X-Gm-Gg: ASbGncvA05rmFFsL3yFPE7V/JCvEBWi+Xb7Jy9OWTK98GP2KqTbslJUvkE9zIcJNZSd
	ys9YlkjVDqOPDsgAEYIgXHGhS0td2Jlo1LTtUJb1qZIUYKw6gQFAGVXWIfNu4uEC7IQLqcpkc4+
	S43640VO8MDfl/yG3zUR0oHsCV1tEJ2zXHfAforKCPqAWWEk1w6+NSPNR4E8IiHJyaUJva9U8Cg
	h/gcxxKhWpJM6ookPXhqm+dFSDvqlHAXhbbxo6tW8Ljm1fxzvMkN+yHqw1SjEUVu/52dCJUijSX
	On/pa0PkKce9M3mdeFG81WGYFZJ3BpxGTNrXbhVCKLtwu12M5xQ8EP/lhC1YD5kBK+kb8p2i2t6
	f4mfvTAosPq05M7aJMvpRBcv4hhK+HjzaDlzah2Gsh0Kt1/XeuBdlVCd+MZPsggI9TBYtksb5Ly
	aXvZlgkr4=
X-Google-Smtp-Source: AGHT+IHn+yQITVhX7JOhNKmg1v0d4AeFsuyhfMZxVSx4jo79SO8Ist/PfxPol73ufoIwTw32azv2aA==
X-Received: by 2002:a05:6830:3109:b0:741:c038:f51c with SMTP id 46e09a7af769-74569dd8573mr5472670a34.11.1756759062500;
        Mon, 01 Sep 2025 13:37:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457428c153sm1192315a34.8.2025.09.01.13.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 13:37:42 -0700 (PDT)
Message-ID: <5365cf30-042e-4b71-87ea-3766c6f16bcb@baylibre.com>
Date: Mon, 1 Sep 2025 15:37:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: iio: adc: ad7816: fix race condition in SPI
 operations
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, sonic.zhang@analog.com,
 vapier@gentoo.org, dan.carpenter@linaro.org
References: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:40 PM, Mohammad Amin Hosseini wrote:
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
> Changes in v5:
> - Rebased on top of latest staging tree
> - Dropped unrelated cleanups (sysfs_emit, sysfs_streq, type casts, etc.)
> - Keep only the mutex locking for SPI and GPIO access
> ---

My comments from v1 [1] are still applicable (have not been addressed).


[1]: https://lore.kernel.org/linux-iio/b6c2ac13-2781-49ba-964f-ca821b32e2a2@baylibre.com/

