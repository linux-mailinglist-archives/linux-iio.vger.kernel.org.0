Return-Path: <linux-iio+bounces-12020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6D9C18BB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928D3B2121A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0171E0B9C;
	Fri,  8 Nov 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/vhihQB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FE28EB;
	Fri,  8 Nov 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056673; cv=none; b=uywnirMG85sZnsmb5Jtyqp60mt6S0qvxa3XWw2qpx8twkFoNtdvCs3MjmrhpJNoxi1dagrrWjGYCxTKFRcbjMzvNpUQEcyh9+8aGY88RExMRPkzMLfpOByhAIt0aMM/Yi1SnXjhrAMitc7xtjBn0m+LzKEVVsDrw+odcX6WXbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056673; c=relaxed/simple;
	bh=AyeEwDBun6w6uaXopmqvpdcKmSZAcU23Z7sFvkx30EA=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=IoaRMjgbARno/1KuiebqJSkfB7uuqikguVb+DMhfnZ3AoH7GpwyndU0llWiiBqFUNU+kWBWUYXngl/DAqFWQUz64R5fwFxOCKPBnmA6e7e/Uig8kr1SeijAlOejXMeyHBNIr45uvP9JRQ1ytIW5N2fx5RRjMhRW57zZcGYfxMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/vhihQB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53c779ef19cso2140177e87.3;
        Fri, 08 Nov 2024 01:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731056670; x=1731661470; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ukb0WhkCUjRfInWYD6LunpJsHMp747p0BjeFB9MCAbc=;
        b=D/vhihQB32XPBevEm4yzG/vmqW8CkoH8hs5+7bEhgZuvYdwBGTcUVKESya5iy7zYb1
         yv/zAkQuQB0UqIo/f8RXFqGXZG3hWn7kIiDUufIfDK9vOJP7VETXVdQxzRRCVXUkozol
         uPXVlhrwPCef0xb5iwvFFRTj+UuP36++8TF8goQZePPQpJAKBt+Qb5NIEPPk5UjGxinA
         m/rePocDz3l3Dyk1OrGhJj7uQJeeRm7Ka242G7McQBlADe1aGBcw+DI1BAjwwNNxCPEQ
         wsFGdfprMK9ZPHiUVs0HiEr/vKeGoSrwWDalSAGr6kITwsVdzardZdNS0COC+p/spkJ+
         XRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056670; x=1731661470;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ukb0WhkCUjRfInWYD6LunpJsHMp747p0BjeFB9MCAbc=;
        b=LqW1m13dzOEp4RXeXP2fvmKMGIRX2FpAU0euCYPxWkitwIuDztl50Sm3XDXLgZhbWP
         Nr8RF/oKtSw1ja4ZoD5yVO6uKnEVubeYj7+6AwiRlQRv9i5tPMBpwR8f9PBbsjAzAPa1
         3fOTkBTA06DSWT7HcQn5OG/1xkLalbNuJ620c9d94YVSZwimVzT7GmUQzx5H8uqUU67R
         CD4bb+x+5m6rLz1PiP1gfzHtNXf4+tiJnH6z8kDoTBR8sd+mqo8Ng+yytcAKfnzc1hxl
         3Hnod/35+k3IOzjQhKpbBz5WUR2/BEuLUnuZyLvLfIuO+qobA4QHd4P/pV/Uy/wehkJp
         BGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfzMGRKIhRle9zTX+0TqDpBlsXlS6/FwcMrjBZd/7u89hnli7GnI7B73RFURX22iwC9Y5POIMHawV2dA==@vger.kernel.org, AJvYcCWlNB2rFK/HUUSUZC+0/gyEWpHmQAsMJ+odg4Cli0UIFdf1T351piyqMNgNB43SZts4+q3Xv0BvI2In@vger.kernel.org, AJvYcCX67hWynzqhlhh+hqeup54dhfbPMS/n0GyFSxd9DVdTMFnn5fiPOXSGSnNN3OGcvq9B9zHqDjA92iHGKvqh@vger.kernel.org
X-Gm-Message-State: AOJu0Yweh9HluLb2U/TMaK1h+R1NpTpuxT8Om6cLP6A7MnJ5a4SFs0mk
	yn5T1dXiWLyBqJZxtbN9Z34lEvXUziN8I7jeTWidt+BtqGR3DTKl3d6gbz2k
X-Google-Smtp-Source: AGHT+IFOpAxizeoWAsAf1Ig+nqrd38luvrclBvzCYJOG2h7JJE69AHUF22najhZFnz4M6jEFU735Hg==
X-Received: by 2002:a05:6512:1288:b0:539:fa3d:a73 with SMTP id 2adb3069b0e04-53d862be309mr1001057e87.39.1731056669460;
        Fri, 08 Nov 2024 01:04:29 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed987d33sm4037872f8f.43.2024.11.08.01.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:04:28 -0800 (PST)
Date: Fri, 08 Nov 2024 10:04:27 +0100
Message-ID: <c6d634d088f77abd956dbd125c26d43d@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>, Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Peter Rosin <peda@axentia.se>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
References: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Mon, 28 Oct 2024 13:04:10 +0100, matteomartelli3@gmail.com wrote:
> Hi everyone,
> 
> I found an issue that might interest iio, sysfs and devres, about a
> particular usage of devm_kmalloc() for buffers that later pass through
> sysfs_emit() or sysfs_emit_at(). These sysfs helpers require the output
> buffer to be PAGE_SIZE aligned since commit 2efc459d06f1 ("sysfs: Add
> sysfs_emit and sysfs_emit_at to format sysfs output"). Such requirement
> is satisfied when kmalloc(PAGE_SIZE, ...) is used but not when
> devm_kmalloc(PAGE_SIZE,...) is used as it actually returns a pointer to
> a buffer located after the devres metadata and thus aligned to
> PAGE_SIZE+sizeof(struct devres).
> 
> Specifically, I came across this issue during some testing of the
> pac1921 iio driver together with the iio-mux iio consumer driver, which
> allocates a page sized buffer to copy the ext_info of the producer
> pac1921 iio producer driver. To fill the buffer, the latter calls
> iio_format_value(), and so sysfs_emit_at() which fails due to the buffer
> not being page aligned. This pattern seems common for many iio drivers
> which fill the ext_info attributes through sysfs_emit*() helpers, likely
> necessary as they are exposed on sysfs.
> 
> I could reproduce the same error behavior with a minimal dummy char
> device driver completely unrelated to iio. I will share the entire dummy
> driver code if needed but essentially this is the only interesting part:
> 
> 	data->info_buf = devm_kzalloc(data->dev, PAGE_SIZE, GFP_KERNEL);
> 	if (!data->info_buf)
> 		return -ENOMEM;
> 
> 	if (offset_in_page(data->info_buf))
> 		pr_err("dummy_test: buf not page algined\n");
> 
> When running this, the error message is printed out for the reason above.
> 
> I am not sure whether this should be addressed in the users of
> devm_kmalloc() or in the devres implementation itself. I would say that
> it would be more clear if devm_kmalloc() would return the pointer to the
> size aligned buffer, as it would also comply to the following kmalloc
> requirement (introduced in [1]):
> 
> The address of a chunk allocated with `kmalloc` is aligned to at least
> ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
> alignment is also guaranteed to be at least to the respective size.
> 
> To do so I was thinking to try to move the devres metadata after the
> data buffer, so that the latter would directly correspond to pointer
> returned by kmalloc. I then found out that it had been already suggested
> previously to address a memory optimization [2]. Thus I am reporting the
> issue before submitting any patch as some discussions might be helpful
> first.
> 
> I am sending this to who I think might be interested based on previous
> related activity. Feel free to extend the cc list if needed.

Adding some more context to better understand the impact of this.

With a trivial grep it looks like there are only few instances where
devm_k*alloc() is used to allocate a PAGE_SIZE buffer:

$ git grep -n 'devm_.*alloc.*(.*PAGE_SIZE'
block/badblocks.c:1584:         bb->page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
drivers/iio/multiplexer/iio-mux.c:287:          page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
drivers/mtd/nand/raw/mxc_nand.c:1702:   host->data_buf = devm_kzalloc(&pdev->dev, PAGE_SIZE, GFP_KERNEL);
drivers/usb/gadget/udc/gr_udc.c:1987:           buf = devm_kzalloc(dev->dev, PAGE_SIZE, GFP_DMA | GFP_ATOMIC);
sound/soc/sof/debug.c:277:              dfse->buf = devm_kmalloc(sdev->dev, PAGE_SIZE, GFP_KERNEL);

What takes my attention is the bb->page in blocks/badblocks.c, being the
buffer named "page" maybe it is supposed to be page aligned?

Also in [3] it was suggested to add the page alignment check for
sysfs_emit() and sysfs_emit_at(), but I haven't found why that's
necessary. My guess is for optimizations to avoid the buffer to spread
in more than one page. Is this correct? Are there other reasons? Can
anyone add more details? I think it would help to understand whether
page alignment is necessary in the other instances of devm_k*alloc().

Beside page alignment, there are plenty of devm_k*alloc() around the
code base, is there any way to spot whether any of those instances
expect the allocated buffer to be aligned to the provided size?

If this is a limited use-case it can be worked around with just regular
k*alloc() + devm_add_action_or_reset() as Jonathan suggested. However, I
still think it can be easy to introduce some alignment related bug,
especially when transitioning from k*alloc() to devm_k*alloc() in an old
implementation since it can be assumed that they have the same alignment
guarantees. Maybe some comment in the devres APIs or documentation would
help in this case?

Any thoughts?

> 
> [1]: https://lore.kernel.org/all/20190826111627.7505-3-vbabka@suse.cz/
> [2]: https://lore.kernel.org/all/20191220140655.GN2827@hirez.programming.kicks-ass.net/

[3]: https://lore.kernel.org/all/743a648dc817cddd2e7046283c868f1c08742f29.camel@perches.com/

Best regards,
Matteo Martelli

