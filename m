Return-Path: <linux-iio+bounces-12262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F19C8FFA
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 17:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB61B2DC59
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B41547CC;
	Thu, 14 Nov 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3xY8sln"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC741C65;
	Thu, 14 Nov 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600603; cv=none; b=oi1qwgzKwHImxo6bwal+QMHJ2weY6L5jCCqAiSdNrZm9S8gYHT4CLiGSCGYeVTL/5TYdWp6ro189rjh8BmdSTkns8e0uhiLhvzFmjFNMQwt04KwRbnAi3nI8d/pUfS92oTsqxbvRFALeFdPxgAIzK37vZXBOjWUQ4ZkGGAHDyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600603; c=relaxed/simple;
	bh=BuGLPvGNAS66VEU+cW1eUCgQx2RjM0km7Ctu3UwUjTk=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=mbZ5TH7fp7IkHWbWBhhJGRV6n+5yycGRLmUw3s8EzzgmmON9Qd6Es2E/0qeMaxl+W9JMbuMrV7H20d2SEw5hkuPA+DljZKJT9zJqzCtwI/4eJFilklqjkWnFhPR0B5T1XPE8nLPEGTP1cXCqXc4AV49SrGvG9OU4D88bf8rBZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3xY8sln; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431688d5127so6990145e9.0;
        Thu, 14 Nov 2024 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731600599; x=1732205399; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=heHDM0GhrkLkt6MOJukpciyEuG+VKO+wAC6cQepDlWM=;
        b=b3xY8slnXRmGCt7XgXOan/hY1Y5wkF52oJr7/DJ03E2vB77XgwJLBjL3xqYyD7XlK7
         085TiUNp3L4Ui4Cxy1VwTPD/slfh0B0P3pKzArgF9IDQMeJ17fMEVHn2yccAEERugnF1
         WD3yhNp1o4alBEFVZzDZ00UJdnlXrCm5RHOJDW7M6TKv6+vVtlwWdnAIcW0WdjGXoTnd
         SquoLMPESRt2RjI90CCLgS/THnoj5wHkELkEM8N4g80T5bHpQU6FctNFsdr3euEEJyUl
         6zaVE3O3b4JRxsicG6FJ6zjAmVEMaLgLq6vCavHGgmqF/dwjnBEi+RN2NVmrfk86LcwX
         nggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600599; x=1732205399;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heHDM0GhrkLkt6MOJukpciyEuG+VKO+wAC6cQepDlWM=;
        b=H4HV9XTm1wA7Vit3oDsNcReU2IrctAhtgtPsQ7Lmf5Df5JHQEjhcG/wmh56D9BD0MP
         nT1E3/j4kpF2NC0od96IsxhywWqCYpYEdGnp0pLQyfRmqtKOAmIHg06dkxldsi17+ffP
         Ja78ZZLAqmjwPtSxTAKTik3//gu4mTM52+3Ol9Tq2GkIaeKX4Mlz5QEWlpgvY8ccoQ1h
         NIJDVu6gkPil92iUOiUgq3e5o/J85v8RalLxGjex4yQRG3SEyqShuZkbIv2I67tGoIJb
         Q330kWSG2ggBfCB+J73stUFLsQS1yLrIH+y4+B6Mc3CpUCI547eWjpyL+Y5S3u1jYgGl
         RTyA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxflUkGCRLnkXlpW+PLmLK8BpJQrdYNXrKLygpva9d+rXs5qyhr2Po2LSxYcgRTfz2OcfqKtFPdNp@vger.kernel.org, AJvYcCXYjvt0qpfcBBuOmbvQDvkVsrV28th1W/ziHAhzR/o8cPWzFMQKEWxUKAjIJDvinGZ4y2kDDhbvKW/4Aw==@vger.kernel.org, AJvYcCXx8Yy7m6d+OQHNSRG+DTwiOGpte/co2ntFM0SNFkwuaow2uNIeMudHZekQfIIMBnKLFjDEOGxhxPChfaXS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DnZwLnogN7h0n6PAnVOWsim92s6o6By8hkIE0QCoc030I9K0
	q46LE0JZMlq7WEnxqqDHCgmRp7vpUiiE0g8qdrgavE31c3y2WCnh
X-Google-Smtp-Source: AGHT+IG8mm5jhnULldvW+M+sdL5dGYXgO4+FMJVb7LWQPHSGPF8y3xXtYuD2qDtq5jpjwRl4R9TCaQ==
X-Received: by 2002:a05:6000:1a88:b0:37d:4d72:dca3 with SMTP id ffacd0b85a97d-381f186fc8cmr21379514f8f.31.1731600599342;
        Thu, 14 Nov 2024 08:09:59 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3127bsm1828216f8f.101.2024.11.14.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:09:58 -0800 (PST)
Date: Thu, 14 Nov 2024 17:09:58 +0100
Message-ID: <b9b7582409247dc088ea2df64af24024@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Peter Rosin <peda@axentia.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>,
	Joe Perches <joe@perches.com>, Jens Axboe <axboe@kernel.dk>, Peter Zijlstra
	<peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <ff24d6c8-581d-4dd1-8565-916d3f429ae4@icloud.com>
References: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
	<c6d634d088f77abd956dbd125c26d43d@gmail.com>
	<58d77d45-d052-4431-91de-3912a9c675b5@icloud.com>
	<cf50fd85a836c32bbb828a832e22d2df@gmail.com>
	<ff24d6c8-581d-4dd1-8565-916d3f429ae4@icloud.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Thu, 14 Nov 2024 20:25:59 +0800, Zijun Hu <zijun_hu@icloud.com> wrote:
> On 2024/11/14 19:29, Matteo Martelli wrote:
> >>>> The address of a chunk allocated with `kmalloc` is aligned to at least
> >>>> ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
> >>>> alignment is also guaranteed to be at least to the respective size.
> >>>>
> >>>> To do so I was thinking to try to move the devres metadata after the
> >>>> data buffer, so that the latter would directly correspond to pointer
> >>>> returned by kmalloc. I then found out that it had been already suggested
> >>>> previously to address a memory optimization [2]. Thus I am reporting the
> >>>> issue before submitting any patch as some discussions might be helpful
> >>>> first.
> >>>>
> >> no, IMO, that is not good idea absolutely.
> > It’s now quite clear to me that the issue is a rare corner case, and the
> > potential impact of making such a change does not justify it. However,
> > for completeness and future reference, are there any additional reasons
> > why this change is a bad idea?
> 
> 1)
> as i ever commented, below existing APIs is very suitable for your
> requirements. right ?
> addr = devm_get_free_pages(dev, GFP_KERNEL|__GFP_ZERO, 0);
> devm_free_pages(dev,addr);

Yes, but I was concerned by the possibility that other users assumed by
mistake that devm_kmalloc() would have provided the same alignment
guarantees as kmalloc(), so at that point a more generic approach could
have been worth a consideration. Given that today the issue seems to be
confined in only one IIO driver it's clearly a corner case and it is
just a matter of fixing that driver by using kmalloc()+devred_add(), or
devm_get_free_pages() as you suggested, instead of using devm_kmalloc().

> 
> 2)
> touching existing API which have been used frequently means high risk?

Indeed. Same answer for 1) applies here.

> 
> 3) if you put the important metadata at the end of the memory block.
>    3.1) it is easy to be destroyed by out of memory access.

This is a good point.

>    3.2) the API will be used to allocate memory with various sizes
>         how to seek the tail metadata ?  is it easy to seek it?

Apparently yes, but likely very hacky by using ksize(). See
data2devres() in [2] for an example.

>    3.3) if you allocate one page, the size to allocate is page size
>         + meta size, it will waste memory align.

I think this is already the case with the current devm_kmalloc().

> 4) below simple alternative is better than your idea. it keep all
> attributes of original kmalloc(). right ?
> 
> static int devres_raw_kmalloc_match(struct device *dev, void *res, void *p)
> {
> 	void **ptr = res;
> 	return *ptr == p;
> }
> 
> static void devres_raw_kmalloc_release(struct device *dev, void *res)
> {
> 	void **ptr = res;
> 	kfree(*ptr);
> }
> 
> void *devm_raw_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> {
> 	void **ptr;
> 	
> 	ptr = devres_alloc(devres_raw_kmalloc_release, sizeof(*ptr), GFP_KERNEL);
> 	f (!ptr)
> 		return NULL;
> 	
> 	*ptr = kmalloc(size, gfp);
> 	if (!*ptr) {
> 		devres_free(ptr);
> 		return NULL;
> 	}
> 	devres_add(dev, ptr);
> 	return *ptr;
> }
> EXPORT(...)
> 
> void *devm_raw_kfree(struct device *dev, void *p)
> {
> 	devres_release(dev, devres_raw_kmalloc_release,
> devres_raw_kmalloc_match, p);
> }
> EXPORT(...)

I also considered an alternative to decouple the two allocations of the
devres metadata and the actual buffer as you suggested here. However, I
would have preferred avoiding an additional API and applying this
approach directly within the original devres_kmalloc() if it turned out
to be necessary. At that point, though, I am not sure which of the two
approaches would have had less impact.

Thanks for sharing this, it could be useful if a similar discussion
arises in future.


>>>> [2]: https://lore.kernel.org/all/20191220140655.GN2827@hirez.programming.kicks-ass.net/

Best regards,
Matteo Martelli

