Return-Path: <linux-iio+bounces-27371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E00CDFF5A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40296300B69A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B3325490;
	Sat, 27 Dec 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp6Xgbbv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F5324B22;
	Sat, 27 Dec 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853611; cv=none; b=KqEw7WPP33Q0NRtWLyO7jnzRkdhTDgqeuP6FwSnp6Y5On8gElPkwe8z8lBH+wBSletmbpC3CSHULRyDXBIcEmaph3pxNbCYZ0dXHXnD97l5CQRmM/NZc14Hf9L8tPSmXHMyIRAFy8E9WSTgTH8S5OfxnPCSZmot0mfIDprf1dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853611; c=relaxed/simple;
	bh=gQ5wLLWHw2PApgnKABMLdbTLhEHZRaoAE62701mYXz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BozK9+Z1+kblvcHOJ2nRPBRfZFcfAUFfx/1VxecQTjFwMi7CNq9tkv1xGtfZpj0dUwasX3BFe3cgcvl71eanYnAwU/pbSZWwSTT19V4/Y8odi34pNzLrAA4zTfI5VymtdrNPdh5HXuUpTPPw6QM+v3rV/tl3Yj/+RgHkwPve77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp6Xgbbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C57C4CEF1;
	Sat, 27 Dec 2025 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766853610;
	bh=gQ5wLLWHw2PApgnKABMLdbTLhEHZRaoAE62701mYXz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kp6XgbbvVTenp90dmOxGTG4fdCsy/nsLsffIL+xrPj9O1w9pqEZtdRThvqH2Fm8cy
	 KjEXb76peP18fw2LfN+gUVTZjZaNCwDPvKTY8ZvrVZ/W3y3tBrhkEnSYjz5OwKeI0f
	 uKD0HciEZtY397q1CVD6e4mIwX/SEAv6WSjuot1gXnH0kUTUcFkMElaXvkHPGufn80
	 s/FHkCP5LUWunE5lJkIkY7ezCj5DW34WjUV02PYWshgN3zuYC2I8spP3hhveerjvxT
	 OngBCtmrvqnbTmpQW6q/0qLIb580dRchcUhaORDuF9H5f6GRbV/o8eg9HTZilkc0yw
	 QOFyZvSIT6dog==
Date: Sat, 27 Dec 2025 16:40:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andreas Klinger
 <ak@it-klinger.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/14] iio: pressure: mprls0025pa: fix interrupt flag
Message-ID: <20251227164002.13f6ac58@jic23-huawei>
In-Reply-To: <aUjxnibLMpvMtOY1@lipo.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-12-b36a170f1a5c@subdimension.ro>
	<20251221183826.3050247c@jic23-huawei>
	<aUjxnibLMpvMtOY1@lipo.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 09:22:06 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> hello Jonathan,
> 
> On Sun, Dec 21, 2025 at 06:38:26PM +0000, Jonathan Cameron wrote:
> > On Thu, 18 Dec 2025 13:05:54 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Interrupt falling/rising flags should only be defined in the device tree.
> > > 
> > > Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>  
> > Gah. We shoudn't have let this slip through in 2023.
> > Some old drivers have done this for many years and for those we definitely
> > can't be sure there aren't boards with it set wrong in DT that will see
> > a regression with this fix.
> > 
> > For a 2023 driver, maybe we can gamble that no one has broken DT (where this
> > would annoyingly be a regression).  One other question below.
> > 
> >   
> > > ---
> > >  drivers/iio/pressure/mprls0025pa.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> > > index 243a5717b88f..fc04988b9437 100644
> > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/bits.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/errno.h>
> > > +#include <linux/interrupt.h>
> > >  #include <linux/math64.h>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > > @@ -404,9 +405,7 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
> > >  
> > >  	if (data->irq > 0) {
> > >  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> > > -				       IRQF_TRIGGER_RISING,
> > > -				       dev_name(dev),
> > > -				       data);
> > > +				       IRQF_ONESHOT, dev_name(dev), data);  
> > IRQF_ONESHOT addition here needs a separate explanation. Might well be correct
> > but it's not related to your patch description.  
> 
> do you feel like IRQF_TRIGGER_NONE would be a better fit?
That would be the minimal change.
> 
> I used ONESHOT just because it seemed like a good idea to isolate the sensor while the handler is running (if I understand the documentation correctly).
It's normally only necessary for devices where we might get
more interrupts signalled before we have performed all the operations
we need to for the one we are already handling.  E.g. level interrupts
with a threaded handler, or IIRC any freerunning pulse type interrupt.

Jonathan

> 
> best regards,
> peter
> 
> >   
> > >  		if (ret)
> > >  			return dev_err_probe(dev, ret,
> > >  					  "request irq %d failed\n", data->irq);
> > >   
> >   
> 


