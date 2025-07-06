Return-Path: <linux-iio+bounces-21412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A1BAFA6BC
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B54E189ACA4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BC1D6194;
	Sun,  6 Jul 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCgVo0M+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4CEAC7
	for <linux-iio@vger.kernel.org>; Sun,  6 Jul 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822012; cv=none; b=raTthw4pR8+UTfG5v+LVN9gI9DrnJTGioqgjn9gucr1/Sonr3UzvNCw6mwkNXn7AkgY6mqeZ8yH3EQaCJOjz7X0xxAiyUinfAdsCBYPPZmocY9e/emine0DIjYOl/WhE0TnL/sKbKCmfcB0+gKvk6MGUQ1QaeSnohsREMfkXZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822012; c=relaxed/simple;
	bh=f+U0a/MPczF5I4PRCHXaUH19GvpLm0ZC1RnGnfBuk4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4/LChhJC4btWFjjpAw2sWaTvxsiHZeehd+nOzTQF00f2ibeQWLFqCtk8u/GahjlfzsGIKMWCgbIGva+j2EInpddAt13dynLmVzQfaKiaqxJYn9teptXwRfKIHfZg788GBS/HWrXHLokhjKrOh0emtL+VVb3Qojimq+SgXzy8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCgVo0M+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648CBC4CEED;
	Sun,  6 Jul 2025 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751822010;
	bh=f+U0a/MPczF5I4PRCHXaUH19GvpLm0ZC1RnGnfBuk4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TCgVo0M+EPRbL4o8KWfIQApd/FjRl10u83a6lvK9jbanCUdTHW0HRSO3drAgPGgOm
	 hMu0J+IpzM3wOHtOlZbMBiaKerI+opsI1gOJUt8ahJWO23/+Gy8IMDlcOSwyxt3TJE
	 7LAE0tq4x4Qj0HOVnHEDf5IMXjlp0eaAPQcXpbQWB2BWCswEy/VTDpsvlZbjtHrbqW
	 +kFVpac9d0MUdWhJdS+m19NVGK1M3a88OQVeiSHRyj1/EWFQR+xR6T9sgYL46PY3LF
	 iGfc+FNvbSOul131tiH6/NfyaqDYi7uvfjIhgt2Hke86OsHnBpu0MWrgfyc7gGY5Yl
	 B+iUNIuUnCkvA==
Date: Sun, 6 Jul 2025 18:13:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
Message-ID: <20250706181322.3ef4d3c0@jic23-huawei>
In-Reply-To: <aGJpoNfSMW_cQ4Ry@smile.fi.intel.com>
References: <20250629183649.184479-1-jic23@kernel.org>
	<aGJpoNfSMW_cQ4Ry@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 13:40:32 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

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
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > I picked this one fairly randomly as an example but longer term I'd like
> > to look through at least all new drivers with this in mind + all the ones
> > that are currently messing up my W=1 build logs.
> > 
> > Note I've been very descriptive in this patch to allow people to suggest
> > better alternatives for some of the ones that aren't entirely obvious.  
> 
> Thanks for trying it again, very much appreciated!
> 
> What we actually miss is the database (in any text-based format, even *.d would
> work I suppose) for the guarantees. For example, if code uses ERR_PTR() and at
> the same time (very likely) uses something like -EINVAL, the errno.h is implied
> (and guaranteed!) by err.h. Explicit errno.h is in two cases: 1) nothing is used
> from err.h, but errno.h; 2) Linux special error codes are in use, e.g. EPROBE_DEFER.
> 
> Next, what I would really start with is the kernel.h. this is the beast that is
> happening in many files and old snippets all over the internet, it would be nice
> to clean it sooner than later. Especially if it's in the headers (should not be
> as written at the top of that file). So, hence just a priority for these cleanups
> first.
> 
Those W=1 warnings are driving me mad, so I'll drive this from point of view
of cleaning those up.  Will sweep around doing others later. 

Speaking of which lots of discussion about how to do this - anyone fancy
giving me a review for this actual patch? :)


