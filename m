Return-Path: <linux-iio+bounces-13761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97959FAE58
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A8162253
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715951AB6CC;
	Mon, 23 Dec 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq17qjiE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316001AAE0B
	for <linux-iio@vger.kernel.org>; Mon, 23 Dec 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957902; cv=none; b=jn0mCv+5qB7iCRzTJamx/A/DCNtQ0fplW/kkryhIafdj5M4ei7fd2iIMSnMdOAUY3XhIutXYDaBay4XTKh4h/LDFEurLiLMI2UgmGv0tAocmetk/A42fzjXBOcC0DoalR7lKL2PH8YhZmWP6gP6TES6i+0HvKo+Un8vM0iwJ3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957902; c=relaxed/simple;
	bh=HXj5XwkUSjjThSbjXSALGwUZDTSIn3ZkKv78zXS8A5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR+e7XX/8gdxRrk53xBiR4oi3be5uJMc33Nbq2MYKC8VWU8MK6esALHS70dISGwIT9UE+fVHsHEGoKhLTqWgboijc6pWPbCUWF72Noa6xIKuJC7wyo/aW46hPFsrLmzrU4HHPAHIObgmoufEQTnkvOk+AEVTLsU042dExxnti9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq17qjiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F6DC4CED3;
	Mon, 23 Dec 2024 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734957901;
	bh=HXj5XwkUSjjThSbjXSALGwUZDTSIn3ZkKv78zXS8A5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eq17qjiE4cO6yM8b5RBDI91fYO8XBdFE2bufKcgg/1LoZbaqoVcTQaxqlqwJWc+KC
	 28V5cwaPlohT28bYwzNUI/kow5QZxNvbcg/vL2bXY1QWaE8am48gJJW+5EzYO2SPWA
	 g/pzyMBqm0DaFwnGDtAALKikika3PYOF4aryhkRoydV8JNfiu+szXWrgRQ7aItOHuL
	 L+w5Vcpi5673/3upYooKyYvHG7q7iCOe4u3I2NoXhZI5Ryy3fwKigiv3TQowQglCaE
	 w63I1MCAtYDCsMHB6AJaubMldCYLdF2vOtODUfd79fzO31VgmIMeIzqtLkR52K5v0M
	 K94mbfI72aGDQ==
Date: Mon, 23 Dec 2024 12:44:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Heiko
 Stuebner <heiko@sntech.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 15/20] iio: buffer: Make timestamp s64 in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20241223124449.2bc68b9d@jic23-huawei>
In-Reply-To: <Z19GLcY8m6ErkHk1@smile.fi.intel.com>
References: <20241215182912.481706-1-jic23@kernel.org>
	<20241215182912.481706-16-jic23@kernel.org>
	<Z19GLcY8m6ErkHk1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 23:12:13 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Dec 15, 2024 at 06:29:06PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This is a bit of a corner case for selecting between the in kernel types
> > and standard c integer types we tend to prefer for userspace interfaces.  
> 
> s/c/C/
> 
> > The interface is entirely within the kernel but in many cases the data
> > ultimately ends up in userspace (via some time in a kfifo).  On balance
> > the value passed is almost always an s64, so standardize on that.
> > Main reason to change this is that it has led to some inconsistency in
> > the storage type used.  The majority use aligned_s64 rather than
> > int64_t __aligned(8) and this will ensure there is one obvious choice.  
> 
> ...
> 
> >  static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
> > -	void *data, int64_t timestamp)
> > +	void *data, s64 timestamp)  
> 
> Hmm... Is it the indentation used for other static inline definitions there?
> Otherwise I would fix it to follow standard pattern (use same column as the
> first argument).

Makes sense.

> 
> ...
> 
> >  	if (indio_dev->scan_timestamp) {
> > -		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
> > -		((int64_t *)data)[ts_offset] = timestamp;
> > +		size_t ts_offset = indio_dev->scan_bytes / sizeof(s64) - 1;  
> 
> sizeof(timestamp) ?

I think not on this one. It's about the type of the cast on the next line more
than timestamp type. If timestamp were an s32 and we were writing it into
a 64 bit location then sizeof(timestamp) would be the wrong size but whereas
the proposal here would still work.  If we were doing a memcpy rather than
a simple assignment the sizes would have to be the same and your suggestion
would make sense.

Could introduce a local variable to make this more obvious and provide a
parameter for the sizeof()

		s64 *datas64 = (s64 *)data;
		size_t ts_offset = indio-dev->scan_bytes / sizeof(*datas64) - 1;
		
		datas64[ts_offset] = timestamp;

Do you think that is worth doing or just adding complexity we don't need?
I don't see it as much more readable, so think on balance sticking to original
proposal in this patch makes more sense.

Note this needed a rebase anyway as scan_timestamp is now private.

> 
> > +		((s64 *)data)[ts_offset] = timestamp;
> >  	}  
> 


