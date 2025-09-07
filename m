Return-Path: <linux-iio+bounces-23864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B2B47B8F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359E118992BD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC432750FE;
	Sun,  7 Sep 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk4oAOgj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7D2AF0A;
	Sun,  7 Sep 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757251244; cv=none; b=VEiHlrIbkyd9eYADbsShKOt8y90D6TJhb0K7c0WxZlVRAV1DP8PDVRXz/pI5dw1QscZoaA3HGezhuW6RtXPEnYzZDojoANRSiKez+Z7ldzKNhMsp7Vr2yPF7d5gbEBBP/V8uGZorcpLCAj6FTJqdwtihCLqDO7hlR0C8kDhSrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757251244; c=relaxed/simple;
	bh=MPOKjDQcKcN99TkwDgarp+uqWvYBP8M4xBaya72W6hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9BYH3nwUPGGB2FTalwvUd+3Nly2PFAyC0p5L84ddJCZGjGlIfzVfTdhZmAAGOjAgiNqIknQ8UpLIgfKVCXFWzRf5rkIDxlh7eYcdldQf7Y9+mqNIhR7T1HiHOWSVsWDmIRNlA2uEFNemQrm7odCFbD6yKL+Kbb2vl3oMzoIJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk4oAOgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA6DC4CEF0;
	Sun,  7 Sep 2025 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757251244;
	bh=MPOKjDQcKcN99TkwDgarp+uqWvYBP8M4xBaya72W6hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jk4oAOgjZEJCOPDwIizFQU3ll3pSfz2yqLHoLnGCMqRpL183hztvGjyhtXuJ5JnIy
	 rc6BIyi2FX15+z8KUoCYAEmyHbhMdlif17i/k3ECPvfx64hPat78KokydWYXBMSVRT
	 CFmZBRhnUIE2Lg493UqBGxsM84NM9d7OoFeRQ43ugDsjnwrTArm9jVbxjOoyD4m/bM
	 /PXWyxY/OfCZ+ilX76MUlzwo4XArazqKPHh4rR3PxPbYIJSZLg0p3pEsxD9rwvMHZc
	 qbuSLeRKfCapQS2rpJQFrORSUoV2JGvO+U+nTsPHkcQJJd7Q2/AP0cGiOgm49vZMnH
	 DaTf1z7TiP9vA==
Date: Sun, 7 Sep 2025 14:20:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
Message-ID: <20250907142034.5b000107@jic23-huawei>
In-Reply-To: <fbea7d45-bf92-4f6b-a464-0f7a6f921bde@baylibre.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
	<20250901-icm42pmreg-v3-5-ef1336246960@geanix.com>
	<fbea7d45-bf92-4f6b-a464-0f7a6f921bde@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > @@ -299,7 +298,7 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
> >  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> >  	int ret;
> >  
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> >  
> >  	/* exit if FIFO is already on */
> >  	if (st->fifo.on) {
> > @@ -311,30 +310,29 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
> >  	ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
> >  			      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> >  
> >  	/* flush FIFO data */
> >  	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
> >  			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> >  
> >  	/* set FIFO in streaming mode */
> >  	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> >  			   INV_ICM42600_FIFO_CONFIG_STREAM);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> >  
> >  	/* workaround: first read of FIFO count after reset is always 0 */
> >  	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT, st->buffer, 2);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> >  
> >  out_on:
> >  	/* increase FIFO on counter */
> >  	st->fifo.on++;  
> 
> I would be tempted to get rid of out_on as well even if we have to repeat
> `st->fifo.on++;` in two places.

There is strong guidance in cleanup.h on basically never mixing gotos
and cleanup (including guard).  It is probably fine here but some compilers
(gcc) are very bad at detecting uninitialized conditions that can happen with
gotos.  More generally Linus has expressed that if you need to mix the two
cleanup.h magic is not appropriate. Following David's suggestion the problem
is solved through duplication of that increment.

> 
> > -out_unlock:
> > -	mutex_unlock(&st->lock);
> > +
> >  	return ret;  
> 
> Can just return 0 here and simplify if (st->fifo.on).



