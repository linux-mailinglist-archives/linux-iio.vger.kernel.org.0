Return-Path: <linux-iio+bounces-15975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1C4A40A97
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC683B5EF7
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B411B2186;
	Sat, 22 Feb 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4f4GlrY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448842F3B
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245047; cv=none; b=RFWiXn7poUiRx7JwA+n69waP3QN2WJiUXppRCW+Sv4d32N43q7jWwx7udb5hR99HImr+krAihwJq11bYFnZiSGU/SO1gnJ8USOmhzXiXecKJEurOidkkT2DXyiQnB4RDP6ieetZ7vQr4TXGhC1sQOfTvdTwkPHrhuaKBInRdLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245047; c=relaxed/simple;
	bh=N3tnKPD0sGhZuJ6CMpzU/FVR77Gipm+KKLgQplgYwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0AbJwpIdJmmUQmwqZcU318ZYx6oWSHCQqu0matNAeX4X3wetrdfMbATFfr5/rWW+85k3tH6iX15vXeVl4v0+MKrxzBajyfqD97mF3DahMVRweCxqiJGxF9Jin9EtWNNk4CdEYBSrULgV5lE/UVkdbMqB2Oy3s221FPjOEm8uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4f4GlrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C875C4CED1;
	Sat, 22 Feb 2025 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740245045;
	bh=N3tnKPD0sGhZuJ6CMpzU/FVR77Gipm+KKLgQplgYwxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4f4GlrY9Lgb7HsXZIcDFUul4gapUVKIPDkSIPtp2ELpAx/ZvxH4azexRpI8ZkoPY
	 nOWQIyesv/Tev7QkK4NUT2SCi330/QmWNzITq1a3jtFJ9MZOPoLKp3Ya5z5zd8WCbg
	 Tgy47heoDWHFPJzi1B0Ui0iRBgawlfsu7d98pSccYCO1FRUsGrDpLDWi/UuzLab2vG
	 TERzl+P0mECc448pVZHMjqC9/33XYAMMCeuCWSRod4N/zUeUv0WCmylilsQ14MkcB2
	 8xEz8oV4y5/isLTPUsJqfwKzlfgU+OTPqxpB7XJsrX2YiKMXbyCwczHscCabgLByUT
	 Ozkhfd/B+cAFQ==
Date: Sat, 22 Feb 2025 17:23:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250222172357.05378fd4@jic23-huawei>
In-Reply-To: <Z7nyQgjZ36zkO8oD@surfacebook.localdomain>
References: <20250209180624.701140-1-jic23@kernel.org>
	<20250209180624.701140-2-jic23@kernel.org>
	<Z7nyQgjZ36zkO8oD@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 17:51:02 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Sun, Feb 09, 2025 at 06:05:58PM +0000, Jonathan Cameron kirjoitti:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Initial thought was to do something similar to __cond_lock()
> > 
> > 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
> > + Appropriate static inline iio_device_release_direct_mode()
> > 
> > However with that, sparse generates false positives. E.g.
> > 
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock
> > 
> > So instead, this patch rethinks the return type and makes it more
> > 'conditional lock like' (which is part of what is going on under the hood
> > anyway) and return a boolean - true for successfully acquired, false for
> > did not acquire.
> > 
> > To allow a migration path given the rework is now non trivial, take a leaf
> > out of the naming of the conditional guard we currently have for IIO
> > device direct mode and drop the _mode postfix from the new functions giving
> > iio_device_claim_direct() and iio_device_release_direct()
> > 
> > Whilst the kernel supports __cond_acquires() upstream sparse does not
> > yet do so.  Hence rely on sparse expanding a static inline wrapper
> > to explicitly see whether __acquire() is called.
> > 
> > Note that even with the solution here, sparse sometimes gives false
> > positives. However in the few cases seen they were complex code
> > structures that benefited from simplification anyway.  
> 
> ...
> 
> 
> > +/*
> > + * Helper functions that allow claim and release of direct mode
> > + * in a fashion that doesn't generate many false positives from sparse.
> > + * Note this must remain static inline in the header so that sparse
> > + * can see the __acquire() marking. Revisit when sparse supports
> > + * __cond_acquires()
> > + */
> > +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
> > +{
> > +	int ret = iio_device_claim_direct_mode(indio_dev);
> > +
> > +	if (ret)
> > +		return false;
> > +
> > +	__acquire(iio_dev);
> > +
> > +	return true;  
> 
> While I understand the intention, I dislike the function return boolean and
> hide the actual error code, it calls user to misuse and replace boolean false
> by arbitrary error codes.
> 
> Can we rather return an error code, please?
> (as a side effect it reduces the churn in the followup changes)
> 
Hi Andy,

I tried - see above.  It plays badly with sparse which is the whole point of
this exercise. Note that iio_device_claim_direct_mode() only ever returns one
error code -EBUSY. So reality is it's a boolean and this is a lot close
to mutex_trylock() than anything else hence the switch to a boolean return.

At the end of the full series (not yet posted) is a patch that gets rid
of their being any pretence this isn't a yes / no question and can
return other error values. This intermediate step does leave it looking
more confusing.

Churn wise if we'd been able to do keep the error return and make sparse
work I could have just applied this to the original functions and made
no changes at all to the vast majority of drivers.  Sadly that wasn't
to be. End result of ending up with a trylock type approach is cleaner
and more compact even if it's not what we have gotten used to for this
particular function.

Jonathan


> > +}  
> 


