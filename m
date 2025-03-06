Return-Path: <linux-iio+bounces-16458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2408A54386
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 08:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA3518944AC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22141B4234;
	Thu,  6 Mar 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WecRY+Fx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68018DB04;
	Thu,  6 Mar 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245601; cv=none; b=ZuZY43jLi0dkynYEeRBcvjGFM53jfg0eD9lRMtG0Ud1AbL4KzWBkCqhcTj4dBuoip9tmWyUVPpbY738XdyZ99/YZPCeeofdja05W5cczS5LabDqqySGTWFVUgHaSyEOmRGz1Zjs+sHGkrMK2PCnOm9+kUEUVg+HM1SpYdf59YHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245601; c=relaxed/simple;
	bh=qLuqTZiAoEdE5ZqzkuOEquYAHoFjFE1U9aW4fu6/tYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEa2PKz+1XLXS2mMnFo6QR+E1An0Wb64GPddHudvga5Ky+Qv4ZZr0E27Bw5q+I/bgY8Zu3NZyvQ15AkOVDltMyTUKpvbB08CzYE3huTpnHNiFaJ/RFfkd7Bz4VqwNrp+Xt6lH4gvhyFhkTU9k8ETFkMOuwk0hyANwR1a7XIvogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WecRY+Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503A9C4CEE0;
	Thu,  6 Mar 2025 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741245600;
	bh=qLuqTZiAoEdE5ZqzkuOEquYAHoFjFE1U9aW4fu6/tYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WecRY+FxXOJFSeHz07hdLmt4UZKnKWvJEscFSOnyndfNaDgAGzNxTPftEKZTK5Yz1
	 vBy6K9J5miiQnrj2vHPqMW+Jh5qtFA8JuyKnlMmZYpu2XMEs7TefYNNL8UuMwKcbrs
	 bQqnF/wwWMjzaxAaVtdgsvr0xBSAd5I/LcLozbtw=
Date: Thu, 6 Mar 2025 08:18:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <2025030611-embezzle-sacrament-00d9@gregkh>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-2-david@protonic.nl>
 <6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
 <20250305164046.4de5b6ef@erd003.prtnl>
 <mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>

On Thu, Mar 06, 2025 at 12:21:22AM +0100, Uwe Kleine-König wrote:
> Hello David,
> 
> On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:
> > On Fri, 28 Feb 2025 17:44:27 +0100
> > Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > [...]
> > > > +static int motion_open(struct inode *inode, struct file *file)
> > > > +{
> > > > +	int minor = iminor(inode);
> > > > +	struct motion_device *mdev = NULL, *iter;
> > > > +	int err;
> > > > +
> > > > +	mutex_lock(&motion_mtx);  
> > > 
> > > If you use guard(), error handling gets a bit easier.
> > 
> > This looks interesting. I didn't know about guard(). Thanks. I see the
> > benefits, but in some cases it also makes the locked region less clearly
> > visible. While I agree that guard() in this particular place is nice,
> > I'm hesitant to try and replace all mutex_lock()/_unlock() calls with guard().
> > Let me know if my assessment of the intended use of guard() is incorrect.
> 
> I agree that guard() makes it harder for non-trivial functions to spot
> the critical section. In my eyes this is outweight by not having to
> unlock in all exit paths, but that might be subjective. Annother
> downside of guard is that sparse doesn't understand it and reports
> unbalanced locking.
>  
> > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > +		if (iter->minor != minor)
> > > > +			continue;
> > > > +		mdev = iter;
> > > > +		break;
> > > > +	}  
> > > 
> > > This should be easier. If you use a cdev you can just do
> > > container_of(inode->i_cdev, ...);
> > 
> > Hmm... I don't yet really understand what you mean. I will have to study the
> > involved code a bit more.
> 
> The code that I'm convinced is correct is
> https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com/
> 
> This isn't in mainline because there is some feedback I still have to
> address, but I think it might serve as an example anyhow.
> 
> > > > [...]
> > > > +
> > > > +static const struct class motion_class = {
> > > > +	.name		= "motion",
> > > > +	.devnode	= motion_devnode,  
> > > 
> > > IIRC it's recommended to not create new classes, but a bus.
> > 
> > Interesting. I did some searching, and all I could find was that the chapter
> > in driver-api/driver-model about classes magically vanished between versions
> > 5.12 and 5.13. Does anyone know where I can find some information about this?
> > Sorry if I'm being blind...
> 
> Half knowledge on my end at best. I would hope that Greg knows some
> details (which might even be "no, classes are fine"). I added him to Cc:

A class is there for when you have a common api that devices of
different types can talk to userspace (i.e. the UAPI is common, not the
hardware type).  Things like input devices, tty, disks, etc.  A bus is
there to be able to write different drivers to bind to for that hardware
bus type (pci, usb, i2c, platform, etc.)

So you need both, a bus to talk to the hardware, and a class to talk to
userspace in a common way (ignore the fact that we can also talk to
hardware directly from userspace like raw USB or i2c or PCI config
space, that's all bus-specific stuff).

Did that help?

thanks,

greg k-h

