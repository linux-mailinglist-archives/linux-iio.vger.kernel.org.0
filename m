Return-Path: <linux-iio+bounces-11454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89149B2FA3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74ED21F22FB6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822471D5ADE;
	Mon, 28 Oct 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN6Kj9lN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FA188733;
	Mon, 28 Oct 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117058; cv=none; b=FU5JZJpgw0gU9qdMvsOOh8YXbZW3CH1wfMuHMT0hBh/UG4juxn6mN78+HMpwEDRszIgGT6O8AWSSQ9wa0bH99TbYpJkE60okd2k3nnFme1R6M0I/sS3kqfrzF+5out0FkxgJxFL2gQfz04CTZXKUmDHShP7PiJwzYFkRdd8R5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117058; c=relaxed/simple;
	bh=7u6SgI6NxTTvIwEzQ/ayBSn+wdGd/VITrwQY4rEja/E=;
	h=From:Date:Message-ID:To:Cc:Subject; b=c17FSpDQkzpsOTem0zjKL2oHcMbIua1eLGVMhisvGv0xABeygJzOVxVAKN+BaFbzTw1bsx+2xiUYl3DecLwzsic6OXwnw5eJEeipnM8uPmjAX46LlGcwEmfhqYeUR8JWOefh4xO5XZ6w6P2LWQPyiwr1mfhyA1fI2WCkqFgVggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN6Kj9lN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43193678216so29680405e9.0;
        Mon, 28 Oct 2024 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730117054; x=1730721854; darn=vger.kernel.org;
        h=subject:cc:to:message-id:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKEeAXmbvPWUlnMl7Jy/ngdP6FBcL9ljUqpc/+uzW4g=;
        b=dN6Kj9lNZbGpze9gwxoUFS0VYuErr0FFtSGufjgpQdiTcDg+EBvT5IEVPZMF1mygXh
         sN99uenB99zEOH7WVcZab6Tu/AOAbwJiESLnH3O6gYovJX1gfPn216aZjw/iEeuJxDRF
         hMIe1V8aD378EQ6vKhd9i4BUSAhmYSatUa22HuP9qCSwlUfbIUjj4VjlLWmIgr0QfJ2y
         K1fRsUoajx5Ky7671jnW55haVGXyCMMD/F2XkrDnq8FvwPBMU/KxuuHGPOEOHw/bZxdx
         l0HsRJko83fApqljH0AkPKDgRoOWtCdyBSdNqHkyHWjQFh78ZSsnzsdIihnYeXdLCwuX
         I3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730117054; x=1730721854;
        h=subject:cc:to:message-id:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKEeAXmbvPWUlnMl7Jy/ngdP6FBcL9ljUqpc/+uzW4g=;
        b=HvRWfW1/bViRLj/gBdVQiY3xPU3XFrWQ2eBBNOrgdKATcxgCfP8nXReXl4nD5t8rqC
         e+XLamylE7U1EaJQd0y1FTSh8Js8vkuA88l4aNs+wYv05Z7tfwhQedIBiFi/8al/CMmf
         rXXuF6myebxXEtIcQfeON7RngXcSZ11Wqpr8WGaxoSwmNfHRgnYxJmqIf5ls1xBe+/9j
         iy9pt7Ne9xvtm2tvLSGxe2UN3COhwHR9xKLZzMCxy1gk0cBErAgIpjr/7FME/Rd9rrdM
         rxfwze9YqTz9AqypL+gu2wUiB83NbutJRfirsdNt0RS2RwaIZzCsPkxADIDNjMuVENxI
         z7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX67HsorgOebq5oYldSB0167ODKp8DBy1+JouaOPkAslFVX+KVI28/Ej52RkyPNUGkf3oDuaJmV2VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwowWJYxYc8F9C7+xZNbpowzY1mdN0NDvEqznW9F+5+R1dipARu
	wrDuEQIy2uUhJJmPqFH7J9CMjXpBfJdbThOIGuhI8kmlmP1IbNrMGH6tLPZF
X-Google-Smtp-Source: AGHT+IE7ghO3ADasZCUpCsmafd+B9E/1GUct+XWmzCsCPrT13CmOpKpNMlrWuxfbS/2eRIUlTDMkVg==
X-Received: by 2002:a05:600c:4a88:b0:431:9397:9ac9 with SMTP id 5b1f17b1804b1-431aa292eb4mr21813635e9.15.1730117054122;
        Mon, 28 Oct 2024 05:04:14 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f74b6sm107279115e9.33.2024.10.28.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:04:13 -0700 (PDT)
From: matteomartelli3@gmail.com
Date: Mon, 28 Oct 2024 13:04:10 +0100
Message-ID: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>, Marc Gonzalez <marc.w.gonzalez@free.fr>, Peter Rosin <peda@axentia.se>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Rafael J. Wysocki <rafael@kernel.org>, linux-iio@vger.kernel.org
Subject: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

Hi everyone,

I found an issue that might interest iio, sysfs and devres, about a
particular usage of devm_kmalloc() for buffers that later pass through
sysfs_emit() or sysfs_emit_at(). These sysfs helpers require the output
buffer to be PAGE_SIZE aligned since commit 2efc459d06f1 ("sysfs: Add
sysfs_emit and sysfs_emit_at to format sysfs output"). Such requirement
is satisfied when kmalloc(PAGE_SIZE, ...) is used but not when
devm_kmalloc(PAGE_SIZE,...) is used as it actually returns a pointer to
a buffer located after the devres metadata and thus aligned to
PAGE_SIZE+sizeof(struct devres).

Specifically, I came across this issue during some testing of the
pac1921 iio driver together with the iio-mux iio consumer driver, which
allocates a page sized buffer to copy the ext_info of the producer
pac1921 iio producer driver. To fill the buffer, the latter calls
iio_format_value(), and so sysfs_emit_at() which fails due to the buffer
not being page aligned. This pattern seems common for many iio drivers
which fill the ext_info attributes through sysfs_emit*() helpers, likely
necessary as they are exposed on sysfs.

I could reproduce the same error behavior with a minimal dummy char
device driver completely unrelated to iio. I will share the entire dummy
driver code if needed but essentially this is the only interesting part:

	data->info_buf = devm_kzalloc(data->dev, PAGE_SIZE, GFP_KERNEL);
	if (!data->info_buf)
		return -ENOMEM;

	if (offset_in_page(data->info_buf))
		pr_err("dummy_test: buf not page algined\n");

When running this, the error message is printed out for the reason above.

I am not sure whether this should be addressed in the users of
devm_kmalloc() or in the devres implementation itself. I would say that
it would be more clear if devm_kmalloc() would return the pointer to the
size aligned buffer, as it would also comply to the following kmalloc
requirement (introduced in [1]):

The address of a chunk allocated with `kmalloc` is aligned to at least
ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
alignment is also guaranteed to be at least to the respective size.

To do so I was thinking to try to move the devres metadata after the
data buffer, so that the latter would directly correspond to pointer
returned by kmalloc. I then found out that it had been already suggested
previously to address a memory optimization [2]. Thus I am reporting the
issue before submitting any patch as some discussions might be helpful
first.

I am sending this to who I think might be interested based on previous
related activity. Feel free to extend the cc list if needed.

[1]: https://lore.kernel.org/all/20190826111627.7505-3-vbabka@suse.cz/
[2]: https://lore.kernel.org/all/20191220140655.GN2827@hirez.programming.kicks-ass.net/

Best regard,
Matteo Martelli

