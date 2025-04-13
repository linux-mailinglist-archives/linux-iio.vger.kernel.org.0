Return-Path: <linux-iio+bounces-18043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E6A87184
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CBA1898DA1
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605418DB05;
	Sun, 13 Apr 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpR1He7C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6754148850
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744539542; cv=none; b=bHSTVPcHeygvm6Ab1ujaoLUF1z0XT8WtMeWHQAzXk/+2UhLKNrJs2k6gKeRj/kirruZ6DtjIX1Pn3Cx43rv780pePJYsjysmygK4n4dqQZdkwCSV6aC59Xh7S0Gejv6bLGdHF7WpiNlRaOTjnXa1jH/qE1mX6k5BykUBU4ccs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744539542; c=relaxed/simple;
	bh=byDQr6cVAK3MtvCzIxewkfgvEAQvsTtJ53TCK8DWti0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2AGTQOZ5z1Q9/lfjwtRwcgKMi8S3/EzOL8JBQ5Si8/9Y0mOZYGcuYAPcZocm3rot7B6QAama9Lb6pXQyfUw7i5r6mVCF0D1fHtPgPGUFSbvKxKisgphJnbb13hkMNLA4oLKuPVTgbXPYqjOaOxbpdg+TQsaJAVMndXKCgsQIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpR1He7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4138C4CEDD;
	Sun, 13 Apr 2025 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744539542;
	bh=byDQr6cVAK3MtvCzIxewkfgvEAQvsTtJ53TCK8DWti0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpR1He7CwN7oy02RU/EQelrskc4j8SnFUaohA6/tyt45Uj2OCU2Eke4F2CTDWDb+e
	 NzeT2sfqCukUzAcXvNdugmai1ldklkti2ggoxuihjPyZuuUrhHaGKkiS0IdQqBfJSQ
	 P3Z4UUnhqWK4U61SHRRY+m302Vfh+JDQtSVdv/FaRgMK0UmHDEfnmKJTlQYfMC+MyQ
	 EdvnADjsGKVH88uQf7xt+DI1Gydc4b1Or4SNSWq+p1N0Jv506i70gmvLlLij5SRb2l
	 nhILrFcVZLLmTN8cBKzcysrNpBll0MtptDbrEFSLWqXr/ITXyjLJF2R5JYQBLCrLCQ
	 oGAHrKFhSqszg==
Date: Sun, 13 Apr 2025 11:18:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 09/20] iio: adc: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
Message-ID: <20250413111855.3c0afb60@jic23-huawei>
In-Reply-To: <Z_ObRMx7p9GVf1sV@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
	<20250406172001.2167607-10-jic23@kernel.org>
	<Z_ObRMx7p9GVf1sV@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 12:30:44 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Sun, Apr 06, 2025 at 06:19:50PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This new function allows us to perform debug checks in the helper to ensure
> > that the overrun does not occur.  Use it in all the simple cases where
> > either a static buffer or a structure is used in the drivers.  
> 
> ...
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &chip->scan, time);
> > +	iio_push_to_buffers_with_ts(indio_dev, &chip->scan, sizeof(chip->scan),
> > +				    time);  
> 
> I think readability is better when this occupies a single line.

Rare case where I think you cut too much.  Not obvious from that snippet
which driver it is in!

I tweaked a bunch of them to allow just over 80 chars 


> 
> ...
> 
> > +	iio_push_to_buffers_with_ts(indio_dev, priv->buffer,
> > +				    sizeof(priv->buffer), pf->timestamp);  
> 
> Isn't it enough room for one parameter on the previous line?
Strictly speaking nope. 82 chars, but meh I'm slowly being more flexible on this

> 
> ...
> 
> > +			iio_push_to_buffers_with_ts(indio_dev,
> > +						    &info->scan,  
> 
> In all other places you put these two on one line.
True enough. That one was accidental.

Jonathan

> 
> > +						    sizeof(info->scan),
> > +						    iio_get_time_ns(indio_dev));  
> 


