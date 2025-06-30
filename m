Return-Path: <linux-iio+bounces-21166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5FAEE01C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E263A2051
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4921C186;
	Mon, 30 Jun 2025 14:06:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE934289372
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292385; cv=none; b=hiZvNMqu7/ClI1NPj3OVjxc30As6qV7Nt87PJk7eX+kztUfizXeq3E1EfgPGEaQRPZ5BcFtINckZAsTivfSyX3jadGwDp2NNOSGBoDP8YL0H3zu5agW7OXRXvSRxVPMi6ds0FLFAIpV1nOzmAqtoyA0aTyWf4KugqZg8CL67ZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292385; c=relaxed/simple;
	bh=Bz8nmw7J/wizh3ZMuuNe2z/hgO39mVQirqw3wW6t9zA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFUuSl8yoZOVbO5JFf5RiATGBCOI3xo01CBC327Aq0oXXLJuqLwzmAwAMVXmtPWBiEGMaMRJsokJEtba4uL7Uck2wnirkE/vaPGBPkN5xcZHiow9+EeDrjiEfR9LjKkZeESZ89VLis04ZVtyWYhNFHh3a/DCNYC1H142O5aaRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW7GY64qZz6M4gT;
	Mon, 30 Jun 2025 22:05:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 89CA41404F9;
	Mon, 30 Jun 2025 22:06:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 16:06:18 +0200
Date: Mon, 30 Jun 2025 15:06:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Tanzir Hasan <tanzhasanwork@gmail.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
Message-ID: <20250630150616.000053b1@huawei.com>
In-Reply-To: <aGJp-NYffceeX8bi@smile.fi.intel.com>
References: <20250629183649.184479-1-jic23@kernel.org>
	<20250629194336.34a03946@jic23-huawei>
	<aGJp-NYffceeX8bi@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Jun 2025 13:42:00 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jun 29, 2025 at 07:43:36PM +0100, Jonathan Cameron wrote:
> > On Sun, 29 Jun 2025 19:36:49 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Motivated by the W=1 warning about export.h that was introduced this cycle
> > > this is an attempt to apply an approximation of the principles of including
> > > whatever is used in the file directly.
> > > 
> > > Helped by the include-what-you-use tool.
> > > 
> > > Reasoning:
> > > - Drop linux/moduleparam.h as completely unused.
> > > - linux/array_size.h for ARRAY_SIZE()
> > > - linux/bitmap.h for for_each_set_bit
> > > - linux/errno.h for error codes.
> > > - linux/export.h for EXPORT_SYMBOL*()
> > > - linux/math64.h for do_div - alternative would be asm/div64.h
> > > - linux/minmax.h for min()
> > > - linux/sysfs.h for sysfs_emit()
> > > - linux/time64.h for USEC_PER_MSEC
> > > - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> > > - asm/byteorder.h for le16_to_cpu()
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > 
> > > I picked this one fairly randomly as an example but longer term I'd like
> > > to look through at least all new drivers with this in mind + all the ones
> > > that are currently messing up my W=1 build logs.
> > > 
> > > Note I've been very descriptive in this patch to allow people to suggest
> > > better alternatives for some of the ones that aren't entirely obvious.
> > >   
> > Helpfully I had a script lying around from 2021:
> > https://lore.kernel.org/all/20211003153306.391766-1-jic23@kernel.org/
> > 
> > Just for reference I used iwyu with: 
> > 
> > make LLVM=1 LOCALVERSION= W=1 -j12 C=1 CHECK=include-what-you-use CHECKFLAGS="-Xiwyu --no_default_mappings -Xiwyu --mapping_file=iio.imp"
> > 
> > where iio.imp is from a few years ago and contains:
> > 	{ include: ["\"linux/sizes.h\"", "private", <linux/sizes.h>, "public"] },
> > 	{ include: ["\"linux/slab.h\"", "private", <linux/slab.h>, "public"] },
> > 	{ include: ["\"linux/spinlock.h\"", "private", <linux/spinlock.h>, "public"] },
> > 	{ include: ["\"linux/spinlock_types.h\"", "private", <linux/spinlock.h>, "public"] },
> > 	{ include: ["\"linux/spi/spi.h\"", "private", <linux/spi/spi.h>, "public"] },
> > 	{ include: ["\"linux/stat.h\"", "private", <linux/stat.h>, "public"] },
> > 	{ include: ["\"linux/stdarg.h\"", "private", <linux/stdarg.h>, "public"] },
> > 	{ include: ["\"linux/stddef.h\"", "private", <linux/stddef.h>, "public"] },
> > 	{ include: ["\"linux/string.h\"", "private", <linux/string.h>, "public"] },
> > 	{ include: ["\"linux/stringify.h\"", "private", <linux/stringify.h>, "public"] },
> > 	{ include: ["\"linux/sysfs.h\"", "private", <linux/sysfs.h>, "public"] },
> > 	{ include: ["\"linux/types.h\"", "private", <linux/types.h>, "public"] },
> > 	{ include: ["\"linux/uuid.h\"", "private", <linux/uuid.h>, "public"] },
> > 	{ include: ["\"linux/sched.h\"", "private", <linux/sched.h>, "public"] },
> > 	{ include: ["\"linux/wait.h\"", "private", <linux/wait.h>, "public"] },
> > 	{ include: ["\"linux/workqueue.h\"", "private", <linux/workqueue.h>, "public"] },
> > 	{ include: ["\"asm-generic/int-ll64.h\"", "private", <linux/types.h>, "public"] },	
> > 	{ include: ["\"linux/device.h\"", "private", <linux/device.h>, "public"] },
> > 	{ include: ["\"linux/dev_printk.h\"", "private", <linux/device.h>, "public"] },
> > 	{ include: ["\"linux/device/bus.h\"", "private", <linux/device.h>, "public"] },
> > 	{ include: ["\"linux/device/driver.h\"", "private", <linux/device.h>, "public"] },
> > 	{ include: ["\"linux/bits.h\"", "private", <linux/bits.h>, "public"] },	
> > 	{ include: ["\"vdso/bits.h\"", "private", <linux/bits.h>, "public"] },
> > 	{ include: ["\"vdso/limits.h\"", "private", <linux/limits.h>, "public"] },
> > 	{ include: ["\"linux/limits.h\"", "private", <linux/limits.h>, "public"] },
> > 	{ include: ["\"vdso/ktime.h\"", "private", <linux/ktime.h>, "public"] },
> > 	{ include: ["\"linux/ktime.h\"", "private", <linux/ktime.h>, "public"] },
> > 	{ include: ["\"vdso/time64.h\"", "private", <linux/time64.h>, "public"] },
> > 	{ include: ["\"linux/time.h\"", "private", <linux/time.h>, "public"] },
> > 	{ include: ["\"linux/timer.h\"", "private", <linux/timer.h>, "public"] }
> > ]
> > 
> > Clear this needs a few upates, like mutex_types.h -> mutex.h and
> > probably devres.h->device.h  
> 
> Right, we got a lot of new *_types.h headers.
> This is a database (kind of) I was talking about in previous reply.
> Can we actually start it as .iwyu or so in the kernel source tree?

Nick and Tanzir talked about using iwyu at Plumbers 2023 and probably have
a much better starting point that this (even more) ancient version.
I missed the talk completely at the time, but came across it more recently.

+CC them both

Jonathan


