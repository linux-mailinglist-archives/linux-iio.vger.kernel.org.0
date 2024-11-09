Return-Path: <linux-iio+bounces-12060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E09C2B62
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD16282BE4
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47641474A2;
	Sat,  9 Nov 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UCuKevtA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B29145B27;
	Sat,  9 Nov 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144599; cv=none; b=mlMsIwrD+0HQUE5Cpadi5GR79tjqvexRhVeRhiK4pR0NYBIZ1fHF/VSxj6776qQswNgoscoZXdme5f9ay2yx9ArXLx2IMW3xiSV432LcopURtbM4ZKzOQYvqoeI8G0CKAWo8ZTtT1DIGIaOHabPUsep1Bv6Cs+3HspNa3/jflQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144599; c=relaxed/simple;
	bh=pmtM4/sq/dmYQBG/iqOWupx/KZw+DRpOQcqqel365xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgIHBNPPgBLZllVkn5hizWBFpOukkvXQdeBacQeHEBe3qaSqMaV2Lou9b0z9usl8EFJuWm3GF6XAtDPtkwJg877tBHobYGtvOMkQqhJTmsWWvBlDVZMzDjPTC4glWQeRSshrJn2pEn9YbTiQbsN+BN3CAqehVroWloV7t7hOK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UCuKevtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBD2C4CECE;
	Sat,  9 Nov 2024 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731144599;
	bh=pmtM4/sq/dmYQBG/iqOWupx/KZw+DRpOQcqqel365xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCuKevtA9HgMRWqCpMEoMFftN270EQg7bkvyF18oBfNnpA5ioVwPIuXx5D7aAETaj
	 oC+GHRB6wG0dtyI61zMswQQCPOfyhH+RBe3u5P7c52CTVSid8TlLa+l05G96WodpXq
	 76Q2bZb5SKf2/l6PjPw1PAfIV51nchWPzHRKpTfM=
Date: Sat, 9 Nov 2024 10:29:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Marc Gonzalez <marc.w.gonzalez@free.fr>,
	Peter Rosin <peda@axentia.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
Message-ID: <2024110903-litmus-stir-0956@gregkh>
References: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
 <c6d634d088f77abd956dbd125c26d43d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d634d088f77abd956dbd125c26d43d@gmail.com>

On Fri, Nov 08, 2024 at 10:04:27AM +0100, Matteo Martelli wrote:
> On Mon, 28 Oct 2024 13:04:10 +0100, matteomartelli3@gmail.com wrote:
> > Hi everyone,
> > 
> > I found an issue that might interest iio, sysfs and devres, about a
> > particular usage of devm_kmalloc() for buffers that later pass through
> > sysfs_emit() or sysfs_emit_at(). These sysfs helpers require the output
> > buffer to be PAGE_SIZE aligned since commit 2efc459d06f1 ("sysfs: Add
> > sysfs_emit and sysfs_emit_at to format sysfs output"). Such requirement
> > is satisfied when kmalloc(PAGE_SIZE, ...) is used but not when
> > devm_kmalloc(PAGE_SIZE,...) is used as it actually returns a pointer to
> > a buffer located after the devres metadata and thus aligned to
> > PAGE_SIZE+sizeof(struct devres).
> > 
> > Specifically, I came across this issue during some testing of the
> > pac1921 iio driver together with the iio-mux iio consumer driver, which
> > allocates a page sized buffer to copy the ext_info of the producer
> > pac1921 iio producer driver. To fill the buffer, the latter calls
> > iio_format_value(), and so sysfs_emit_at() which fails due to the buffer
> > not being page aligned. This pattern seems common for many iio drivers
> > which fill the ext_info attributes through sysfs_emit*() helpers, likely
> > necessary as they are exposed on sysfs.
> > 
> > I could reproduce the same error behavior with a minimal dummy char
> > device driver completely unrelated to iio. I will share the entire dummy
> > driver code if needed but essentially this is the only interesting part:
> > 
> > 	data->info_buf = devm_kzalloc(data->dev, PAGE_SIZE, GFP_KERNEL);
> > 	if (!data->info_buf)
> > 		return -ENOMEM;
> > 
> > 	if (offset_in_page(data->info_buf))
> > 		pr_err("dummy_test: buf not page algined\n");
> > 
> > When running this, the error message is printed out for the reason above.
> > 
> > I am not sure whether this should be addressed in the users of
> > devm_kmalloc() or in the devres implementation itself. I would say that
> > it would be more clear if devm_kmalloc() would return the pointer to the
> > size aligned buffer, as it would also comply to the following kmalloc
> > requirement (introduced in [1]):
> > 
> > The address of a chunk allocated with `kmalloc` is aligned to at least
> > ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
> > alignment is also guaranteed to be at least to the respective size.
> > 
> > To do so I was thinking to try to move the devres metadata after the
> > data buffer, so that the latter would directly correspond to pointer
> > returned by kmalloc. I then found out that it had been already suggested
> > previously to address a memory optimization [2]. Thus I am reporting the
> > issue before submitting any patch as some discussions might be helpful
> > first.
> > 
> > I am sending this to who I think might be interested based on previous
> > related activity. Feel free to extend the cc list if needed.
> 
> Adding some more context to better understand the impact of this.
> 
> With a trivial grep it looks like there are only few instances where
> devm_k*alloc() is used to allocate a PAGE_SIZE buffer:
> 
> $ git grep -n 'devm_.*alloc.*(.*PAGE_SIZE'
> block/badblocks.c:1584:         bb->page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> drivers/iio/multiplexer/iio-mux.c:287:          page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> drivers/mtd/nand/raw/mxc_nand.c:1702:   host->data_buf = devm_kzalloc(&pdev->dev, PAGE_SIZE, GFP_KERNEL);
> drivers/usb/gadget/udc/gr_udc.c:1987:           buf = devm_kzalloc(dev->dev, PAGE_SIZE, GFP_DMA | GFP_ATOMIC);
> sound/soc/sof/debug.c:277:              dfse->buf = devm_kmalloc(sdev->dev, PAGE_SIZE, GFP_KERNEL);
> 
> What takes my attention is the bb->page in blocks/badblocks.c, being the
> buffer named "page" maybe it is supposed to be page aligned?
> 
> Also in [3] it was suggested to add the page alignment check for
> sysfs_emit() and sysfs_emit_at(), but I haven't found why that's
> necessary. My guess is for optimizations to avoid the buffer to spread
> in more than one page. Is this correct? Are there other reasons? Can
> anyone add more details? I think it would help to understand whether
> page alignment is necessary in the other instances of devm_k*alloc().

sysfs_emit* functions should only be operating on the buffer that was
passed to the show function callback, which is allocated by the sysfs
core, so should not have any of these issues.  So why would it need to
be checked?

> Beside page alignment, there are plenty of devm_k*alloc() around the
> code base, is there any way to spot whether any of those instances
> expect the allocated buffer to be aligned to the provided size?

That's a good question, and a worry about the devm_* calls.  I know many
busses (i.e. USB) require that the data passed to them are allocated
from kmalloc buffers, but I don't know about the alignment issues
required, as that is usually very hardware-specific.

> If this is a limited use-case it can be worked around with just regular
> k*alloc() + devm_add_action_or_reset() as Jonathan suggested. However, I
> still think it can be easy to introduce some alignment related bug,
> especially when transitioning from k*alloc() to devm_k*alloc() in an old
> implementation since it can be assumed that they have the same alignment
> guarantees. Maybe some comment in the devres APIs or documentation would
> help in this case?

I think the general statement of "don't migrate drivers to devm_* calls
unless you have the hardware and can test the changes" is good to follow
here.  That should resolve the problem going forward as new drivers are
expected to be at least tested by the submitter :)

thanks,

greg k-h

