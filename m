Return-Path: <linux-iio+bounces-21482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EFAFEA40
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5A61885A87
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DAA28A1C6;
	Wed,  9 Jul 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyMI7rJR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15440944F
	for <linux-iio@vger.kernel.org>; Wed,  9 Jul 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067938; cv=none; b=ADODkbfKhfG9vILZ5f0PP6VMrDF5fHxdaQEZ9UrU4Z4Ps2BcnglkcZPUoJBkdDOUOPtP3ZiQ74SF5zhIvt8ywiYiiT73gGyUv9OPC6NOu8OGauGfoCpxad4tZC2wsvQArNmqN6fV39X/O1MLgvIQ6ccFv4dyHzP0pv0QjPcsvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067938; c=relaxed/simple;
	bh=EdxvPjbZ3pfqvRK+OHlDIuiEL5jgjtSqmV6K15dJJ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nsu3bK0PR6P1Kdbh4y1AJ0/Z8v/OBlgd6cNa6PFAioB0MbUJe8mkHFgqQLt20Xx3zYLcfwlhguq/bDfcPqV7rytd5jxi4pXV9+TSKIM3oLseYWErGIht2/puF12URpP8QsHqTPp53GcWBSZenAOUR7XTweS9YPB40V3ykltdRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyMI7rJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7755C4CEF4;
	Wed,  9 Jul 2025 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752067936;
	bh=EdxvPjbZ3pfqvRK+OHlDIuiEL5jgjtSqmV6K15dJJ8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EyMI7rJR0aod6ztV+IjXxBVyh6UegOik0yL6pXG0RQNftfwECMPhaDNL+HtpwFAw/
	 8ooaubPjn0sCz0PEjEoWiz7pIOP0PYULZlKog9HWk8GZxnjnhMCrwImiDXlae+Qjj/
	 OB5VR8XtH9kp2k6MKN3VUTqXcvsyeA27Gy/dR8G2fM+i0+GohC7GXrymPt5kWgs9Y5
	 BqnXqpH16Zpeyr9pmsoDyN+Zg8dQS4hrSDVDfuPc9ZWwIyYM9ExqhVWpt2D7Bek3TI
	 oW+Vpfp7/8Rw7BIoq1m8LUFOtz4MBUMdSaG99AO7Yuh7BzNffsybiwnNlTZTAdnHir
	 2akINDw+jTK2A==
Date: Wed, 9 Jul 2025 14:32:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
Message-ID: <20250709143210.633ad60a@jic23-huawei>
In-Reply-To: <aGwlxyxRSm2WLXor@smile.fi.intel.com>
References: <20250629183649.184479-1-jic23@kernel.org>
	<aGwlxyxRSm2WLXor@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 22:53:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Jun 29, 2025 at 07:36:49PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Motivated by the W=1 warning about export.h that was introduced this cycle
> > this is an attempt to apply an approximation of the principles of including
> > whatever is used in the file directly.
> > 
> > Helped by the include-what-you-use tool.
> > 
> > Reasoning:
> > - Drop linux/moduleparam.h as completely unused.
> > - linux/array_size.h for ARRAY_SIZE()
> > - linux/bitmap.h for for_each_set_bit
> > - linux/errno.h for error codes.
> > - linux/export.h for EXPORT_SYMBOL*()
> > - linux/math64.h for do_div - alternative would be asm/div64.h
> > - linux/minmax.h for min()
> > - linux/sysfs.h for sysfs_emit()
> > - linux/time64.h for USEC_PER_MSEC
> > - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> > - asm/byteorder.h for le16_to_cpu()  
> 
> Change LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied.

Thanks,

Jonathan

