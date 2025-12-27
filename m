Return-Path: <linux-iio+bounces-27359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16021CDFE0F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE01300FE04
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3DA226CF9;
	Sat, 27 Dec 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI9UT4MU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5D211706;
	Sat, 27 Dec 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766847204; cv=none; b=sKkNOOODo8yM5t9viY4fMGEvYjjmHqMp+EIuDvSLS7Ch2BP0MAK4QD4MGPrJu6TZE4U+jQqwvRCW5fSZqy+hV1I5effIRVMAzkSt7EzLK+Pfy+M4c6UWKVX5ZIi8W/IDpVr/8sPcFZq2e+hPTC/yl+q1UP0T8qBhWIOdwjlV0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766847204; c=relaxed/simple;
	bh=0vCAZs6dQxN+Z8g1a+PkB/BDpvSbBzDK71JGJwidryk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEDiiOe52Y9BRFTEGzyZdjrCkTHzdt86VowoXa3JOSLSsnaXgFIVgk0fKY1AIX/LO77XjxHNqgvuDtqUlA3wSJxCJpF58gslxPLD1t61Su0BJ9ED4yO5JTdmW7Eo+Xte97MIxxNomaoaaSww2tbRfk658FQWmvNWJUCWl88c8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI9UT4MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BB5C4CEF1;
	Sat, 27 Dec 2025 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766847203;
	bh=0vCAZs6dQxN+Z8g1a+PkB/BDpvSbBzDK71JGJwidryk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TI9UT4MU+nElX3XlAea4wntqzeBvsoOdlhy7Qh4w+MeGzIY++y0Te6JBQ1j5e64UG
	 IyLY37RX2cv3hZfO/CfCh+HyN+Al92+qgsyOF4v9sWlfSi2ODESPn9qcX+Z3/SDsGB
	 JPurT87vgkBVOxHBFN03+vB4uNkGUrop/SUjOaRg4H/CPE1gXh1ty1ryD64C3rsjg7
	 ddyXppYY8XHKedl1MZT4hfDkmbOQaI7JGc2zWoIJCkdHnnAzOiC8k6oFq5kTsJadRA
	 yZgL5IUPxehrg1RQ6TsfE8itWE8EYZHAHQHwvNUJztplZaTn79poqx2RSvIF90r1pU
	 4EDZjYopZIY8w==
Date: Sat, 27 Dec 2025 14:53:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung
 <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Message-ID: <20251227145312.0f1c5f87@jic23-huawei>
In-Reply-To: <f5ef483b-12d8-4ed2-9637-af993c3f8b7d@baylibre.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
	<20251211-lock-impr-v2-4-6fb47bdaaf24@gmail.com>
	<f5ef483b-12d8-4ed2-9637-af993c3f8b7d@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 11:23:24 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/11/25 8:45 PM, Kurt Borja wrote:
> > Add guard classes for iio_device_claim_*() conditional locks. This will
> > aid drivers write safer and cleaner code when dealing with some common
> > patterns.
> >   
> 
> 
> > These classes are not meant to be used directly by drivers (hence the
> > __priv__ prefix). Instead, documented wrapper macros are provided to
> > enforce the use of ACQUIRE() or guard() semantics and avoid the
> > problematic scoped guard.  
> 
> Would be useful to repeat this in a comment in the code.
> 
Given David did a much more thorough review than me I've just
added a few comments on top.

Jonathan

> > + * Context: Can sleep
> > + */
> > +#define IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) \
> > +	ACQUIRE(__priv__iio_dev_mode_lock_try_direct, _var)(_dev)
> > +
> > +/**
> > + * IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) - Tries to acquire the buffer mode
> > + *                                           lock with automatic release
> > + * @_dev: IIO device instance
> > + * @_var: Dummy variable identifier to store acquire result
> > + *
> > + * Tries to acquire the direct mode lock and automatically releases it at the
> > + * end of the scope. It most be paired with IIO_DEV_ACQUIRE_ERR(), for example::
> > + *
> > + *	IIO_DEV_ACQUIRE_BUFFER_MODE(indio_dev, claim);
> > + *	if (IIO_DEV_ACQUIRE_ERR(&claim))
> > + *		return IRQ_HANDLED;
> > + *
> > + * Context: Can sleep
> > + */
> > +#define IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) \
> > +	ACQUIRE(__priv__iio_dev_mode_lock_try_buffer, _var)(_dev)

This one doesn't actually have any users I think?  Do we want to introduce
it without them? I'm not sure we do.

> > +
> > +/**
> > + * IIO_DEV_ACQUIRE_ERR() - ACQUIRE_ERR() wrapper
> > + * @_var: Dummy variable passed to IIO_DEV_ACQUIRE_*_MODE()
> > + *
> > + * Return: true on success, false on error  
> 
> This could be clarified more. Based on the example, this sounds
> backwards.
> 
> 	Returns: true if acquiring the mode failed, otherwise false.
> 
> > + */
> > +#define IIO_DEV_ACQUIRE_ERR(_var_ptr) \
> > +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_buffer, _var_ptr)  
> 
> There is no error code here, so calling it "ERR" seems wrong.
> Maybe IIO_DEV_ACQUIRE_FAILED()?
> 
> > +
> > +/**
> > + * IIO_DEV_GUARD_ANY_MODE - Acquires the mode lock with automatic release
> > + * @_dev: IIO device instance  
> 
> It would be helpful to explain more about the use case here and that this
> is used rarely.
> 
> The point to get across is that it is used when we need to do something
> that doesn't depend on the current mode, but would be affected by a mode
> switch. So it guards against changing the mode without caring what the
> current mode is. If it is in buffer mode, it stays in buffer mode, otherwise
> direct mode is claimed.
> 
> > + *
> > + * Acquires the mode lock with cleanup guard() semantics. It is usually paired
> > + * with iio_buffer_enabled().
> > + *
> > + * This should *not* be used to protect internal driver state and it's use in
> > + * general is *strongly* discouraged. Use any of the IIO_DEV_ACQUIRE_*_MODE()
> > + * variants.  
> 
> Might as well add Context: here like the others.
> 
> > + */
> > +#define IIO_DEV_GUARD_ANY_MODE(_dev) \  
> 
> Accordingly, I would be inclined to call it IIO_DEV_GUARD_CURRENT_MODE()

Agreed. That's a clearer name. 

> 
> > +	guard(__priv__iio_dev_mode_lock)(_dev)
> > +
> >  extern const struct bus_type iio_bus_type;
> >  
> >  /**
> >   
> 


