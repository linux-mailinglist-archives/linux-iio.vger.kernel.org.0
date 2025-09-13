Return-Path: <linux-iio+bounces-24055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB16B56147
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6B91B27C1C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909B2EFD86;
	Sat, 13 Sep 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOf0JO6+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F972EBB81;
	Sat, 13 Sep 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771547; cv=none; b=hXxy9NaYZGEz+MKwk54TRJN420JDse5a2KmGZTNKvDlnU7YTiHJNytTTL+nWJo67D/Z9hXmuGIGWVCkipLd1mvnxs1MIT3BrCsAGrdnAYzb5L/LSGD3ouCRYTKVMOW/Bzb4KMmyK0szqsgzprwwcqVu1+SNdP7JG41MTELgUAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771547; c=relaxed/simple;
	bh=JMpHgQCz20B3Y3hZWjjmgaUygxAetFE+uk1Dzrp1FjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihM+soeRnYptAFWL6VASEroB3IpgFPKWSneRPaZboaqIjXF225XYuKGiPbPgnD064LpZj754VBrVvzXlFz6xnUGTe/0lG6FJa8kshSgqLucxrCQqFJMy5THj9Va42i/QNivTrahvgc4QxZuKjEBVXwjVjNP2jC5outpRIj3ag18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOf0JO6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E16C4CEEB;
	Sat, 13 Sep 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757771547;
	bh=JMpHgQCz20B3Y3hZWjjmgaUygxAetFE+uk1Dzrp1FjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bOf0JO6+bs4ShFdnrjGZP0aft+EgYdUSA+NFGJ3YntZnYkWoh2UumzlrQNNuFVMAB
	 KZ1qYGROVgf1lFLohePvI51Gx3mmnJKj1jN/2yj+il0dwuW0zJZVzgxHsds6qswLrv
	 xAcYZOjfBGLGgsBsdGmz3Gi9KwpQ9yHD0Y7lQdbJ8ewH3MgFrK0DKRd+PhEotw2GtV
	 Ruq3gQM0GUhpq+kewg53HbkSNWy/bpwXOhfMAh/fHWI7mLx7yoTJtYNhqW3PmX95UY
	 JdSyjWccXgFfJ0z0lv73lv3wjhwe7c7XWBqeccASvORR/GD433Fq0c+slg8Lhr84Ff
	 akjDRGN5YmTCA==
Date: Sat, 13 Sep 2025 14:52:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/7] iio: buffer:
 iio_push_to_buffers_with_ts_unaligned() might_sleep()
Message-ID: <20250913145218.03d1be7d@jic23-huawei>
In-Reply-To: <7f71c489-410b-4fdb-9d78-9f2835c32379@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
	<20250912-iio-doc-push-to-buffers-context-v1-2-c4aad013d96e@baylibre.com>
	<aMRiCvmGt27JEYBz@smile.fi.intel.com>
	<7f71c489-410b-4fdb-9d78-9f2835c32379@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 13:40:37 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/12/25 1:10 PM, Andy Shevchenko wrote:
> > On Fri, Sep 12, 2025 at 11:05:53AM -0500, David Lechner wrote:  
> >> Call might_sleep() in iio_push_to_buffers_with_ts_unaligned() since it
> >> can allocate memory, which may sleep.  
> > 
> > It can or does it always do?
> > If the first one is correct, better to use might_sleep_if().
> >   
> 
> Just below this in the function is:
> 
> 	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
> 		void *bb;
> 
> 		bb = devm_krealloc(&indio_dev->dev,
> 				   iio_dev_opaque->bounce_buffer,
> 				   indio_dev->scan_bytes, GFP_KERNEL);
> 		if (!bb)
> 			return -ENOMEM;
> 		iio_dev_opaque->bounce_buffer = bb;
> 		iio_dev_opaque->bounce_buffer_size = indio_dev->scan_bytes;
> 	}
> 
> 
> Would it make sense to move the might_sleep() inside of this
> if statement rather than repeat the condition in might_sleep_if()?
> 
> devm_krealloc() is the only part of this function that might sleep.
> 
Whilst true that the sleep is only at this point, we always go into
this path the first time (assuming I remember correctly how this works).

So I'd argue a might_sleep() where you have it is appropriate
as we will already have spat out the debug info if we get to the
second case that doesn't sleep.

If this ever matters to a driver, we could add a new function
to allocate the bounce buffer earlier. 

Jonathan




