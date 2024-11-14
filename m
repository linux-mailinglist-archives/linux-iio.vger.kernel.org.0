Return-Path: <linux-iio+bounces-12246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8B9C8917
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B74EB2D9A2
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5AB1F943F;
	Thu, 14 Nov 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwJBUS/q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADA1F9419;
	Thu, 14 Nov 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583804; cv=none; b=ESyruPZCASB1HXGNapURh9XghpwVErDZCckyG0drR39VJjYepH+HIQs4hqiOIjSRwSqsiclRxMb9aJ6ZfK0W01A+ZoCvE+dDQme6K65kFAcpOQUaatmMnseoNCtVPacfqmie8239NmgBbq1l4b9ZCApM0b46E/qhjo37Howyfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583804; c=relaxed/simple;
	bh=16vkSOLafanI8gKAS/j2OyPkfk6Eps5LAOjhaBIEBGc=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=LG/iAnUeZmncfDuZ8qHHnPrOkfeUPb9Lg70rgFm8Ia4V2sDw3zadnGfynWScZt+p0j7Clnb9K9IV41uEf2XFcQqmiCuZj4ijn9m8+rX5TY0fKQcYAzGQ3I7A5wZ1AEXp/6BtEDL7NFW8gIe//UnIa4NZnF0KpoLb/BssRcr79kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwJBUS/q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314b316495so4652805e9.2;
        Thu, 14 Nov 2024 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731583801; x=1732188601; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BnRbG1RhA+4FKx1mPVfYaSzx3CyrTFor1YaY9bXue4Q=;
        b=lwJBUS/qD/FF3otzGUsBVP1tQpv50fXc8nmt/j8lhkE5tGKvymqIsd1l6SEe4swD8E
         cPMErKaPtfCYSETBXV/DPTNnEv6Txxm7yrdEdikVZKz45cAZT/W8DeG74eOfa+LfSJZx
         my1BEDOw46mwSandZJvQkStrG6yAq+1yeNc1IRK8NyHr4i5REiP0g0sfCSyxRaXEX7Xd
         Fv2kUzj4iP1b8pwDu6roLQle16HEbR+VrsUy9FZCDOOaeySI7SQoi24Fx3M3/vWcKUqq
         acz+IVG1ivHQ+vtVhTq92/FaliBL4PX7LeQRk+eNk5d4OIiZXFnD5G8rVpX/WnpUF2qr
         9h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731583801; x=1732188601;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnRbG1RhA+4FKx1mPVfYaSzx3CyrTFor1YaY9bXue4Q=;
        b=JMMI9DV0hD8kC/4CFiaeRsS3z/P3ze2zcQe0SXoe8AYdHdiAHZkARUOFidMP1HIp1j
         z4/YCvL+HkrCKX/rflvEn0M5f2KiD3vaaYOU7Uqeo8JfEYZsEDrJyfWqFjTExliCKSnZ
         rwADTUwFkAGVCcjv93lfcEJ/2hR84jWQJf1xVdqjT/uZiHvvxAtQpaJCQSKOfEc0AXC6
         BFRplpYkLnU/+9xYO6lUEFVL+4EG77Zh8/hECMPRyg3aaJPGkx1AFV9sXrqcdjA8JhCm
         /LcHsn5OuC+uxQ7AC+hrrW1h1g7pajL/czlJyqrqk4uFyy520fDSZqAfOn4mgEz/B1Wa
         82tA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YeZlCB3d1Dvqw+wYBp0v1BlfeVGESDhFSYgD53k4LWWFuDZe8hbWHluxHb5GEPK4eNWc9vPayJOAyXzQ@vger.kernel.org, AJvYcCUTbQFAEdHjcD9gwvEtw3acBU/Wlp1BxfhAaer1TdotfSe41loW5L9/37y4kqFrL4FSIqA5iJV/p3oiDA==@vger.kernel.org, AJvYcCUpxUjWc22hUbaP5Qhny+/VY8hHmcTvH97xAlOXbXiQczeE16cDk1HBvx98xvNqHQJDf3YrYNUzEcZy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5d+cP2RaFrOOQVqluRiowwkq4idz+Q48+0Hnq1DoXJg8acO6
	/j+HReRDZbsTFu9y17uXRPzoMQVGyArdedOWIWMphnq+x9XVvx5g
X-Google-Smtp-Source: AGHT+IGdcIn25fRJvDN4s98Aa7op/W/0w1PxJGmEsHW7cdKwHjHzi6yxcAagUD7SwFBmEJxtoR31sg==
X-Received: by 2002:a05:600c:510f:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-432d4a98374mr61282335e9.4.1731583800512;
        Thu, 14 Nov 2024 03:30:00 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe7f8sm1201646f8f.59.2024.11.14.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:30:00 -0800 (PST)
Date: Thu, 14 Nov 2024 12:29:59 +0100
Message-ID: <cf50fd85a836c32bbb828a832e22d2df@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Peter Rosin <peda@axentia.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>,
	Joe Perches <joe@perches.com>, Jens Axboe <axboe@kernel.dk>, Peter Zijlstra
	<peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <58d77d45-d052-4431-91de-3912a9c675b5@icloud.com>
References: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
	<c6d634d088f77abd956dbd125c26d43d@gmail.com>
	<58d77d45-d052-4431-91de-3912a9c675b5@icloud.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Sun, 10 Nov 2024 05:10:53 +0800, Zijun Hu <zijun_hu@icloud.com> wrote:
> On 2024/11/8 17:04, Matteo Martelli wrote:
> > On Mon, 28 Oct 2024 13:04:10 +0100, matteomartelli3@gmail.com wrote:
> >> Hi everyone,
> >>
> >> I found an issue that might interest iio, sysfs and devres, about a
> >> particular usage of devm_kmalloc() for buffers that later pass through
> >> sysfs_emit() or sysfs_emit_at(). These sysfs helpers require the output
> >> buffer to be PAGE_SIZE aligned since commit 2efc459d06f1 ("sysfs: Add
> >> sysfs_emit and sysfs_emit_at to format sysfs output"). Such requirement
> >> is satisfied when kmalloc(PAGE_SIZE, ...) is used but not when
> >> devm_kmalloc(PAGE_SIZE,...) is used as it actually returns a pointer to
> >> a buffer located after the devres metadata and thus aligned to
> >> PAGE_SIZE+sizeof(struct devres).
> >>
> >> Specifically, I came across this issue during some testing of the
> >> pac1921 iio driver together with the iio-mux iio consumer driver, which
> >> allocates a page sized buffer to copy the ext_info of the producer
> >> pac1921 iio producer driver. To fill the buffer, the latter calls
> >> iio_format_value(), and so sysfs_emit_at() which fails due to the buffer
> >> not being page aligned. This pattern seems common for many iio drivers
> >> which fill the ext_info attributes through sysfs_emit*() helpers, likely
> >> necessary as they are exposed on sysfs.
> >>
> >> I could reproduce the same error behavior with a minimal dummy char
> >> device driver completely unrelated to iio. I will share the entire dummy
> >> driver code if needed but essentially this is the only interesting part:
> >>
> >> 	data->info_buf = devm_kzalloc(data->dev, PAGE_SIZE, GFP_KERNEL);
> >> 	if (!data->info_buf)
> >> 		return -ENOMEM;
> >>
> >> 	if (offset_in_page(data->info_buf))
> >> 		pr_err("dummy_test: buf not page algined\n");
> >>
> >> When running this, the error message is printed out for the reason above.
> >>
> >> I am not sure whether this should be addressed in the users of
> >> devm_kmalloc() or in the devres implementation itself. I would say that
> >> it would be more clear if devm_kmalloc() would return the pointer to the
> >> size aligned buffer, as it would also comply to the following kmalloc
> >> requirement (introduced in [1]):
> >>
> >> The address of a chunk allocated with `kmalloc` is aligned to at least
> >> ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
> >> alignment is also guaranteed to be at least to the respective size.
> >>
> >> To do so I was thinking to try to move the devres metadata after the
> >> data buffer, so that the latter would directly correspond to pointer
> >> returned by kmalloc. I then found out that it had been already suggested
> >> previously to address a memory optimization [2]. Thus I am reporting the
> >> issue before submitting any patch as some discussions might be helpful
> >> first.
> >>
> 
> no, IMO, that is not good idea absolutely.

It’s now quite clear to me that the issue is a rare corner case, and the
potential impact of making such a change does not justify it. However,
for completeness and future reference, are there any additional reasons
why this change is a bad idea?

> >> I am sending this to who I think might be interested based on previous
> >> related activity. Feel free to extend the cc list if needed.
> > 
> > Adding some more context to better understand the impact of this.
> > 
> > With a trivial grep it looks like there are only few instances where
> > devm_k*alloc() is used to allocate a PAGE_SIZE buffer:
> > 
> > $ git grep -n 'devm_.*alloc.*(.*PAGE_SIZE'
> > block/badblocks.c:1584:         bb->page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> > drivers/iio/multiplexer/iio-mux.c:287:          page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> > drivers/mtd/nand/raw/mxc_nand.c:1702:   host->data_buf = devm_kzalloc(&pdev->dev, PAGE_SIZE, GFP_KERNEL);
> > drivers/usb/gadget/udc/gr_udc.c:1987:           buf = devm_kzalloc(dev->dev, PAGE_SIZE, GFP_DMA | GFP_ATOMIC);
> > sound/soc/sof/debug.c:277:              dfse->buf = devm_kmalloc(sdev->dev, PAGE_SIZE, GFP_KERNEL);
> > 
> > What takes my attention is the bb->page in blocks/badblocks.c, being the
> > buffer named "page" maybe it is supposed to be page aligned?
> > 
> > Also in [3] it was suggested to add the page alignment check for
> > sysfs_emit() and sysfs_emit_at(), but I haven't found why that's
> > necessary. My guess is for optimizations to avoid the buffer to spread
> > in more than one page. Is this correct? Are there other reasons? Can
> > anyone add more details? I think it would help to understand whether
> > page alignment is necessary in the other instances of devm_k*alloc().
> > 
> > Beside page alignment, there are plenty of devm_k*alloc() around the
> > code base, is there any way to spot whether any of those instances
> > expect the allocated buffer to be aligned to the provided size?
> > 
> > If this is a limited use-case it can be worked around with just regular
> > k*alloc() + devm_add_action_or_reset() as Jonathan suggested. However, I
> > still think it can be easy to introduce some alignment related bug,
> > especially when transitioning from k*alloc() to devm_k*alloc() in an old
> > implementation since it can be assumed that they have the same alignment
> > guarantees. Maybe some comment in the devres APIs or documentation would
> > help in this case?
> > 
> > Any thoughts?
> >
> 
> why not to use existing APIs?
> 
> addr = devm_get_free_pages(dev, GFP_KERNEL|__GFP_ZERO, 0);
> devm_free_pages(dev,addr);
> 
> >>
> >> [1]: https://lore.kernel.org/all/20190826111627.7505-3-vbabka@suse.cz/
> >> [2]: https://lore.kernel.org/all/20191220140655.GN2827@hirez.programming.kicks-ass.net/
> > 
> > [3]: https://lore.kernel.org/all/743a648dc817cddd2e7046283c868f1c08742f29.camel@perches.com/
> > 
> > Best regards,
> > Matteo Martelli
> > 
> 
Best regards,
Matteo Martelli

