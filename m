Return-Path: <linux-iio+bounces-21484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F2AFEDBC
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418E4545C36
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709362E7F34;
	Wed,  9 Jul 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPYZSuvC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1A198E9B;
	Wed,  9 Jul 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074898; cv=none; b=LkA4dXPUPQPLL0QUCcXmZhugTdOLxSawngqOY7kKI1JdzPT3srPLGIv9w2IMR3e+/QVPKt+yc5wyy9SbXu3mOsyBQSrjdtDee57M6fLg6LoPsGm+Iiyxm1bzUFKbzt9Gjq0V57XMXtcSJ0zQBfD0yU55ry3+157W06lx88bvHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074898; c=relaxed/simple;
	bh=lk+8zMt56gCFuxNbdsiMnzJ2gRivwoTJdcbdfhoBhU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4PLEMzDCPDVB0S3RMRu8NTn5zftraj4V5St+V+kD6UZ2Ahti0gB5O/mXGQkkZffaWNEj1JJrs56/oxfMHoKTeQFgRhJwGtCWkawSDvUNd/PwK+ST4rslVpSU1FnKJRPSFI8i8CJH/6kmPNrAWkTq13P7X1tyG0l0bjDLJ31pbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPYZSuvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258A5C4CEEF;
	Wed,  9 Jul 2025 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074897;
	bh=lk+8zMt56gCFuxNbdsiMnzJ2gRivwoTJdcbdfhoBhU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XPYZSuvCWB5ax6nxzQ2iVciNLOI4/sMVn4yQmWXsVsHNJ13KmngNKXvNc7AeD0C0R
	 rvYFat7CFFwGM6SOtS1QI2lw/GuHbpoKaVgykDQtXYNEXICj3VeueMOmDRzqB/9Dl2
	 LPT0toSxIanMzvNFvDCQmZJFEo2IOXeWVoMxm5oBIL2Mzb02a0xBywInPgq0aoZwZF
	 HaWBExvdXO0CtNQ40E4wh0xVu6/KN/wgFt0aNVXPj4Y99MJq8t1U0A8TXO6Ab0OOyB
	 XeHjsNdcAJA6tXwypNs74ImWcXwhbWZQ0qi1U2N9SSIev8mWu0qt8Wzd4dVDOrvWxJ
	 GLBmzciZmrgpA==
Date: Wed, 9 Jul 2025 16:28:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>, Greg KH
 <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Julien
 Stephan <jstephan@baylibre.com>, Bo Liu <liubo03@inspur.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Sean Nyekjaer <sean@geanix.com>, Haibo Chen
 <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, Francisco Henriques
 <franciscolealhenriques@usp.br>, Gustavo Vaz <gustavo.vaz@usp.br>, Matti
 Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iio: accel: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250709162805.37e472ac@jic23-huawei>
In-Reply-To: <aG4sZohbXE6kmq2G@smile.fi.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
	<20250708231151.971256-1-sakari.ailus@linux.intel.com>
	<aG4sZohbXE6kmq2G@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 11:46:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 09, 2025 at 02:11:51AM +0300, Sakari Ailus wrote:
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().  
> 
> ...
> 
> > -	if (on) {
> > +	if (on)
> >  		ret = pm_runtime_resume_and_get(dev);
> > -	} else {
> > -		pm_runtime_mark_last_busy(dev);
> > +	else
> >  		ret = pm_runtime_put_autosuspend(dev);
> > -	}  
> 
> The following blank line can be removed as it's done in the other file.
> 
> ...
> 
> Side note: Looking at this, perhaps we can also have a helper to toggle state?
> 
> ...
> 
> >  	if (on)
> >  		ret = pm_runtime_resume_and_get(&data->client->dev);
> > -	else {
> > -		pm_runtime_mark_last_busy(&data->client->dev);
> > +	else
> >  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> > -	}  
> 
> So, already two users of the potential new helper :-)

Maybe, but also worth a close look at whether, after this simplification
these little functions to set power state add anything over just
calling pm_runtime_resume_and_get() or *_put_autosuspend()
inline at the call sites.   There are some cases in these drivers
where the state is not hard coded at the call site though so
a helper might be useful for those.

I'm not thinking of it as a job for this patch though which shouldn't
be making significant changes even if they are enabled by
the removals of the calls to pm_runtime_mark_last_busy()

So good idea, but probably get this in first.


> 
> ...
> 
> > -	if (on) {
> > +	if (on)
> >  		ret = pm_runtime_resume_and_get(&client->dev);
> > -	} else {
> > -		pm_runtime_mark_last_busy(&client->dev);
> > +	else
> >  		ret = pm_runtime_put_autosuspend(&client->dev);
> > -	}
> >    
> 
> No blank line?
> 
> Three!
> 
> >  	if (ret < 0) {  
> 
> ...
> 
> >  	if (on)
> >  		ret = pm_runtime_resume_and_get(&client->dev);
> > -	else {
> > -		pm_runtime_mark_last_busy(&client->dev);
> > +	else
> >  		ret = pm_runtime_put_autosuspend(&client->dev);
> > -	}
> >  
> >  	if (ret < 0) {  
> 
> As per above and counting...
> 


