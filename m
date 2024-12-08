Return-Path: <linux-iio+bounces-13239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75D9E8717
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7809281557
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9561F187862;
	Sun,  8 Dec 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBLjx57j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6B22EE4;
	Sun,  8 Dec 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733679226; cv=none; b=fzWqpLnn1CLDAbAIMLwqW8i4rBYnrfEkEHmq+qm4HjBC+eibyCJAFZ6UcO85kSke2i4kOv9FhVgscy4+VPgVBspo5VmqC3HSJSSf578/96YTcc5nD018gjE+/xyLvZGVhuUmT/eJBRblCh8Hn+4dSByW8mMq8LKqKMkR3Jy5nw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733679226; c=relaxed/simple;
	bh=tLuUoayLLlT2eNWkFArfaB8W5balZwTzE5ssrWn4He0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qlb1Hl58FqGVj6AISTv7ESProHqff3K25Cj847zUnJT20oD+WybZOtb2arzzVJvFUaUuqzAtv6R8sIM9r617n4JleRbV06vZz96ABixMu0zf2mVEWfw4omLPqllmsqwmqQ1cpO8l7LCclnej5+rbd0riJ5rWkA3BrcusZD8iZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBLjx57j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9767C4CED2;
	Sun,  8 Dec 2024 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733679225;
	bh=tLuUoayLLlT2eNWkFArfaB8W5balZwTzE5ssrWn4He0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CBLjx57jd9zdjZLLtC2DhVDHa36uS0qYAsRAS/Xb7HClfbuYzbJ7FgEYzliA4n/Rq
	 UJ/IqIzS1bg9V7Ih67bnrOXpSqloUtYXg/w9DGUbiRTy8xOmzAhvB6AC6s54AOvy8+
	 +HPVulRqCLRQ6R5kd7tEuOTvyakCy8IFpt2ScXb+QWM7l8IWcx0Jav+d0vJj8D9qbl
	 jgPxb8wC/FbhhJc74pX/1l4St0zs6FPlYi9ewuIb8zE9V62HuBvkGXKZAGEdl1WA1J
	 ye17Zq+gdbf9Uh9GNeIpXzx6EBDY18+WieP38/9/SpvIvv3vtZ6UwFmhlaygdqnJpC
	 f9arBdF+T8G6A==
Date: Sun, 8 Dec 2024 17:33:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: chemical: bme680: add power management
Message-ID: <20241208173336.6a09c9b2@jic23-huawei>
In-Reply-To: <Z078vIxRoQf_zLsy@smile.fi.intel.com>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
	<20241202192341.33187-4-vassilisamir@gmail.com>
	<Z04N6GUSL2H0zt6_@smile.fi.intel.com>
	<Z04aJg7eoBR9CYKe@vamoirid-laptop>
	<Z078vIxRoQf_zLsy@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 14:42:36 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Dec 02, 2024 at 09:35:50PM +0100, Vasileios Amoiridis wrote:
> > On Mon, Dec 02, 2024 at 09:43:36PM +0200, Andy Shevchenko wrote:  
> > > On Mon, Dec 02, 2024 at 08:23:41PM +0100, Vasileios Amoiridis wrote:  
> > > > Add runtime power management to the device.  
> 
> ...
> 
> > > > +	ret = pm_runtime_resume_and_get(dev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> > > > +	pm_runtime_mark_last_busy(dev);
> > > > +	pm_runtime_put_autosuspend(dev);  
> > > 
> > > Side note: as long as idle method is not defined (NULL) the above dance is
> > > already taken into account in the regular put.  
> 
> > Thanks again for the review! Indeed by looking at the code a bit, it
> > looks like the suspend callback is being called if the idle one is not
> > found. But I have seen this dance that you mention much more often in
> > the IIO that's why I used it. We can see what Jonathan has to say as
> > well, I think what you propose, simplifies things.  
> 
> Yeah, this is cargo cult by many people (including me :-) who missed that
> detail. If any, this can be addressed in a different series.
> 
> ...
> 
> > > > +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> > > > +{
> > > > +	struct bme680_data *data = iio_priv(indio_dev);
> > > > +	struct device *dev = regmap_get_device(data->regmap);
> > > > +	int ret;  
> > >   
> > > > +	ret = pm_runtime_resume_and_get(dev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return 0;  
> > > 
> > > Either this is broken (if the above can return positive codes), or can be
> > > replaced with direct return:
> > > 
> > > 	return pm_...
> > > 
> > > (but I believe it's the former and you wanted something like if (ret < 0)
> > >  there).
> > >   
> > > > +}  
> > 
> > Well, pm_runtime_resume_and_get() looks like it returns 0 on success and
> > negative value on error so I think the if (ret) is correct, no? But I
> > agree with you that it can be simplified as you proposed.  
> 
> Please, go ahead with the simplification!
> 
I tweaked it and applied the series to the togreg branch of iio.git and
pushed out as testing for all the normal reasons.

There was some mess because of the EXPORT_SYMBOL() macro changes this raced
against.  Please sanity check I didn't mess it up.

Jonathan



