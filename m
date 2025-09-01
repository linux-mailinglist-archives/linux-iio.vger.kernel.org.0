Return-Path: <linux-iio+bounces-23611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437DFB3EECD
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E961B2183D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6342050;
	Mon,  1 Sep 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfDZQVg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328119F464
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756050; cv=none; b=EisjsLRsZo+x2lPnIC4dikBHEV/NV93rxd73oqMoHEv121JOwW3oZXYRnp5gET3NUAFUdA5MyqI4sa05fk+iOe3DJEH6bfTtYobhth2HzClcNS/KgepK1gURV+7nUyFpu7JPXOgE/nFkUBzmfV3bkOf5WsnTevDEkkAm/TVEZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756050; c=relaxed/simple;
	bh=RcgZq6hquKpfqYbIn+6sTfO1bsT384AJr49qfHk1DIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilrIFbM0zNxWYRMBxHSbqrGrcWX0h6u2bAd/dYxMN2cFiMarZMhf+Jzy9VQthDIUbCNjFb6U4l8qzaWDNmXV3pEPQKpuWa2cm96aOMFVLb4jMkZkRb8Yi/tOBoZIOdncXlmVRfRXqxEUHGW1x4pGHv/l75b1p9JBEQFwV/umabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfDZQVg1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b86157e18so12692615e9.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756756046; x=1757360846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSndmNKgJlks386GK4b6RRkFbD+zX0itT5uudAAwxDU=;
        b=sfDZQVg1TsZxAsZ9JpLSbMEmip0zGfGLCBd8wRRVNwcdIxBVGwgAnK6IbyJd2kVnxR
         YT9u/LmVWdEUIVDDvzQ8qIA0W29Zls5YHjZ2Qb98JKo1yp8Yqdqynqo72p7CDXAvSzL1
         n5WC3MDUX70EDusXyaTB+M5h86lz/YGMdyBgOCMNrNAGnP4iFNTZBNRfw+72x1GB2C7T
         G+eqhmipj6OrVhlCbldWaZVU6WLX6cyHGG9zNxdJOKFaxo6L99JS4rApKEumQpV3vd71
         lFv05VrjMqfY9KIzuLrupM4r+uhNBE9ZcndfY1RwmbNqh+Sk1jgpLvbJFAyEzP9TUQls
         IxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756756046; x=1757360846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSndmNKgJlks386GK4b6RRkFbD+zX0itT5uudAAwxDU=;
        b=Tw2D80PWDUWdl9ZeChqnDDtGz7OsoKckKrvC/CcGHDbonv9UY0SkelhgGKXK/LA7na
         /dczfeXRxWO6Au9WW6HVFke5M35hG8siUjIynxWWOgnkIUyNYxMHQh/jAjso+anX1ywR
         UmDfTJxedNdncHGhPxBOtu5PwYfHSlD3Z8DPmmdfm3QB+XioWK9JijU+o+UUozP5xjef
         tF4xctSCxoPXmXR9wMmaRMivVzqvzVEdZ3gsN99TcRstqSZM5uOVE2HwYJCdLdKTJ3HY
         cGvuOpZ0Lg2Q1Xog2qBNB6MLLmxZUhUiYReO8E08RlSSgF0N6/a3aVZ7fypJiZVdvzVk
         kB7Q==
X-Gm-Message-State: AOJu0YxEZG4EoN1iChIxe2jwOg7WwPt2AlpTe41QSL1/Zbu0kvEzvD4Z
	qd51G2Pv1wZlsMkn34jS4l7HLHfXUHhgux0wS2qcPJowWQovjW9d7OA04cAJ/QGJdiU=
X-Gm-Gg: ASbGncsxgR1ryJJ/pTQ7/TV7l55quWVpeJge6fKhgmxPVrWeuToct+nZQn4PywHxv8V
	0CU7pkaS6uJ+Hi6fEBeFOI/WJ9xq8FLNrw+ZzApjV//gjQe69a8HJqnsYZEmhkcYo1DbRv6HMI4
	vGs09Qaf3f0B1mV15n79VYJRK1BXWARnkK3bQbYJ5YYkD05pvyiMdwxTwZg3hnBeaEeTEmY6JrN
	SQk0e4+WEAw4+jHYgjpteprtllUe+JuAtmcjwIKkFKAhUhaaGuHpwX1GyI+P9zas/ZzBsVDOED+
	/2I2Mthv+8pGXvnJVK6JJm0aEiGux39vK016PFy6dZGQ8faW3rHNrn2ZRtDhpq05bLdpEU102Vm
	xTqOGB0fc7TK3hj7ph9j+qe0MN7M=
X-Google-Smtp-Source: AGHT+IF9XFzQaT4OzJqcXj3L72JEO/FSHcvHo14utxyiHAVTrzPdiXGjm/HvwtINoBkZqKmFN9Prrg==
X-Received: by 2002:a05:600c:c491:b0:45b:7a03:8d7e with SMTP id 5b1f17b1804b1-45b85587defmr63827345e9.21.1756756046448;
        Mon, 01 Sep 2025 12:47:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b96d2a6b3sm1825785e9.10.2025.09.01.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 12:47:25 -0700 (PDT)
Date: Mon, 1 Sep 2025 22:47:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sonic.zhang@analog.com, vapier@gentoo.org
Subject: Re: [PATCH v5] staging: iio: adc: ad7816: fix race condition in SPI
 operations
Message-ID: <aLX4SmvqBjJrS3FS@stanley.mountain>
References: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>

On Mon, Sep 01, 2025 at 11:10:43PM +0330, Mohammad Amin Hosseini wrote:
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

I've asked you to wait a day between resends and Jonathan asked you to
wait for "a few days"...  It really is a headache to review the same
patch over and over in the same day.

regards,
dan carpenter


