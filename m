Return-Path: <linux-iio+bounces-14992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F7A27B58
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199FA18868F5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B6204680;
	Tue,  4 Feb 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0Yc60LR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852E203719
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697591; cv=none; b=a9SlUWBFhNglnTo3hznD2FZisAg+dzNLs90YxZLXX5Bryoye63leG1yMlnOT4bga9bUqRkLn9EWJGUB9iyK2oirwOxQg9DChzOSDP7vC32o6M4YhZRP1JEiXu6GxxaHQS96XkpShsB/O61cqHXM1kzKK56gEhhUzkmp1MiMn1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697591; c=relaxed/simple;
	bh=nrGfpy3OkkxPLFWIRMQoe9so9fBwqiEsMlzfUSceoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4ed0thc7OyOk9G0wL54udN5KihKuLiBOAfFKXOFik9Qy2G6PuVf7pQr+xB0KbBZCoU+Q+E1ON3hvh0HLYMuxIig3TA35bnLD7hQDYbvTgHQ5LJLOuLKqnMS/Qcd/sE731VjaYSPpq4UQLSVSfGt6MCv5ErOKAgPlVUws34O6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0Yc60LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F82AC4CEDF;
	Tue,  4 Feb 2025 19:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697591;
	bh=nrGfpy3OkkxPLFWIRMQoe9so9fBwqiEsMlzfUSceoWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a0Yc60LRxE+KK2HD6O7Xi+0+ySUxehVyuA0kHg2TkH54PLr1k37kReBaeWzw0swXr
	 JNUH7R7ZZjHmfJbG0xxXwH2iUocalpLLrUNt6ZxuKiiFxOgdBsvLfucmezQqzN3ddT
	 e66kK2WJZ57oIsqionHzigkd8jREecgNjUN09PB/g/bX/CwZx/VCnEK9PxuRmyCkQd
	 PoCtj+WuA30J36+kcNrYHtHcWpjEk/WPkf7JftKNuvy/mdGFdampGmOi5rpQnGsOdV
	 6u0yd8r+c3DW0xdw3o4rhgR09QbO69+y/xpYEaCzkB7U+sQvarAPJS44aeeUTjTRid
	 V5MfEcAGniyHA==
Date: Tue, 4 Feb 2025 19:33:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-iio@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [bug report] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
Message-ID: <20250204193304.6cdcc9d7@jic23-huawei>
In-Reply-To: <db435a8b-7546-4d16-9a15-ee44dac849c9@stanley.mountain>
References: <db435a8b-7546-4d16-9a15-ee44dac849c9@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 14:18:36 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Neil Armstrong,
> 
> Commit 3c9b6fd74188 ("iio: magnetometer: add Allegro MicroSystems
> ALS31300 3-D Linear Hall Effect driver") from Oct 30, 2024
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	drivers/iio/magnetometer/als31300.c:248 als31300_trigger_handler()
> 	warn: check that 'scan.timestamp' doesn't leak information
> 
> drivers/iio/magnetometer/als31300.c
>     226 static irqreturn_t als31300_trigger_handler(int irq, void *p)
>     227 {
>     228         struct iio_poll_func *pf = p;
>     229         struct iio_dev *indio_dev = pf->indio_dev;
>     230         struct als31300_data *data = iio_priv(indio_dev);
>     231         struct {
>     232                 u16 temperature;
>     233                 s16 channels[3];
>     234                 aligned_s64 timestamp;
>     235         } scan;
>     236         s16 x, y, z;
>     237         int ret;
>     238         u16 t;
>     239 
>     240         ret = als31300_get_measure(data, &t, &x, &y, &z);
>     241         if (ret)
>     242                 goto trigger_out;
>     243 
>     244         scan.temperature = t;
>     245         scan.channels[0] = x;
>     246         scan.channels[1] = y;
>     247         scan.channels[2] = z;
> --> 248         iio_push_to_buffers_with_timestamp(indio_dev, &scan,  
>     249                                            pf->timestamp);
> 
> So I guess we had some CVEs recently with regards to
> iio_push_to_buffers_with_timestamp() so this was added as a "must be
> initialized" thing.  The "aligned_s64 timestamp" struct member is
> sometimes initialized in iio_push_to_buffers_with_timestamp() but not
> always.  So this seems like a valid static checker warning?
Hi Dan,

It's a false positive. When it's not initialized it is also never
used.  No code beyond that iio_push_to_buffers_with_timestamp() can
assume there is even data there. In the common case of it being a
kfifo the elements aren't big enough to store the timestamp if
it's not enabled. So it never gets to userspace.

The other bugs were around holes in the structure.  Those can
get to userspace.  On my todo list is a patch to add
a size parameter to that function so we can verify the passed
buffer is big enough, but that won't change how the data is used.

Jonathan

> 
> These are simple enoug to fix if we add a "scan = {};" initializer
> but the IIO function is slightly new to me so I thought I would consult.
> There was also one in trigger_handler().
> 
> drivers/media/pci/mgb4/mgb4_trigger.c:99 trigger_handler()
> warn: check that 'scan' doesn't leak information (struct has a hole after 'data')
> 
>     250 
>     251 trigger_out:
>     252         iio_trigger_notify_done(indio_dev->trig);
>     253 
>     254         return IRQ_HANDLED;
>     255 }
> 
> regards,
> dan carpenter
> 


