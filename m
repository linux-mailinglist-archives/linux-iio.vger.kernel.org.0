Return-Path: <linux-iio+bounces-16466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01698A54C5D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281F0188E4A2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A320E33B;
	Thu,  6 Mar 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tJ5Bh73x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4382199B9;
	Thu,  6 Mar 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268360; cv=none; b=aDzZMpiWjudICSXU96oWkvQgLM9/RZwGXEZOGxT2Q1/0z106InSg2Rz6NFDMfhUG3YAegVVCy7efsl8qA4qm6M0yoeCEt53lt+KyfU7S1PNm52FaS2MIAQYHl99FFg9zeW4eRWw8/806LjKp9UWIbiW+F+iYTeHdTbgZ62N3800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268360; c=relaxed/simple;
	bh=YzzhThIvZFEWn+bU++JkDV+IQNHcf83+t0rSfg/MKbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3uzLs82m9Zt86P1qMMbPQBXPG2la4PKbM7lYJU4NtHuHzNKa4KdiX6v4XZnccR+mdIBoFIYaCIDM1VvNWWqg3v6QmZEtG7iOuVDUQLJnUVi9zeKpnYBhGx9+KJ83847r42yp/YsND/0jPV9dTeo6NyJ7hf2E4JtesqZwUvs8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tJ5Bh73x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED29C4CEE0;
	Thu,  6 Mar 2025 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741268359;
	bh=YzzhThIvZFEWn+bU++JkDV+IQNHcf83+t0rSfg/MKbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJ5Bh73xjS+Bi8M+dOoczyCIpfCofeGkcW+smkZ2OL21P4tvk3VYTCnpF0SOnbHcy
	 vI5UVtlxnk1qL18bqiwdSmfFqsWQ/g0vIkfcwOZjhXqtDxia5Cpzo+NP41XaoN5PNy
	 n3TS2XGXS/kxDLfwJUnNY7fV+kLlug3s6LNUlNmQ=
Date: Thu, 6 Mar 2025 14:39:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Jander <david@protonic.nl>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <2025030633-covenant-bootlace-7163@gregkh>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-2-david@protonic.nl>
 <6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
 <20250305164046.4de5b6ef@erd003.prtnl>
 <mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
 <2025030611-embezzle-sacrament-00d9@gregkh>
 <20250306092013.1147f27e@erd003.prtnl>
 <2025030638-wavy-napkin-41ab@gregkh>
 <20250306103402.2b9e51d7@erd003.prtnl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250306103402.2b9e51d7@erd003.prtnl>

On Thu, Mar 06, 2025 at 10:34:02AM +0100, David Jander wrote:
> On Thu, 6 Mar 2025 10:03:26 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Mar 06, 2025 at 09:20:13AM +0100, David Jander wrote:
> > > On Thu, 6 Mar 2025 08:18:46 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > On Thu, Mar 06, 2025 at 12:21:22AM +0100, Uwe Kleine-König wrote:  
> > > > > Hello David,
> > > > > 
> > > > > On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:    
> > > > > > On Fri, 28 Feb 2025 17:44:27 +0100
> > > > > > Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:    
> > > > > > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > > > > > [...]    
> > > > > > > > +static int motion_open(struct inode *inode, struct file *file)
> > > > > > > > +{
> > > > > > > > +	int minor = iminor(inode);
> > > > > > > > +	struct motion_device *mdev = NULL, *iter;
> > > > > > > > +	int err;
> > > > > > > > +
> > > > > > > > +	mutex_lock(&motion_mtx);      
> > > > > > > 
> > > > > > > If you use guard(), error handling gets a bit easier.    
> > > > > > 
> > > > > > This looks interesting. I didn't know about guard(). Thanks. I see the
> > > > > > benefits, but in some cases it also makes the locked region less clearly
> > > > > > visible. While I agree that guard() in this particular place is nice,
> > > > > > I'm hesitant to try and replace all mutex_lock()/_unlock() calls with guard().
> > > > > > Let me know if my assessment of the intended use of guard() is incorrect.    
> > > > > 
> > > > > I agree that guard() makes it harder for non-trivial functions to spot
> > > > > the critical section. In my eyes this is outweight by not having to
> > > > > unlock in all exit paths, but that might be subjective. Annother
> > > > > downside of guard is that sparse doesn't understand it and reports
> > > > > unbalanced locking.
> > > > >      
> > > > > > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > > > > > +		if (iter->minor != minor)
> > > > > > > > +			continue;
> > > > > > > > +		mdev = iter;
> > > > > > > > +		break;
> > > > > > > > +	}      
> > > > > > > 
> > > > > > > This should be easier. If you use a cdev you can just do
> > > > > > > container_of(inode->i_cdev, ...);    
> > > > > > 
> > > > > > Hmm... I don't yet really understand what you mean. I will have to study the
> > > > > > involved code a bit more.    
> > > > > 
> > > > > The code that I'm convinced is correct is
> > > > > https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com/
> > > > > 
> > > > > This isn't in mainline because there is some feedback I still have to
> > > > > address, but I think it might serve as an example anyhow.
> > > > >     
> > > > > > > > [...]
> > > > > > > > +
> > > > > > > > +static const struct class motion_class = {
> > > > > > > > +	.name		= "motion",
> > > > > > > > +	.devnode	= motion_devnode,      
> > > > > > > 
> > > > > > > IIRC it's recommended to not create new classes, but a bus.    
> > > > > > 
> > > > > > Interesting. I did some searching, and all I could find was that the chapter
> > > > > > in driver-api/driver-model about classes magically vanished between versions
> > > > > > 5.12 and 5.13. Does anyone know where I can find some information about this?
> > > > > > Sorry if I'm being blind...    
> > > > > 
> > > > > Half knowledge on my end at best. I would hope that Greg knows some
> > > > > details (which might even be "no, classes are fine"). I added him to Cc:    
> > > > 
> > > > A class is there for when you have a common api that devices of
> > > > different types can talk to userspace (i.e. the UAPI is common, not the
> > > > hardware type).  Things like input devices, tty, disks, etc.  A bus is
> > > > there to be able to write different drivers to bind to for that hardware
> > > > bus type (pci, usb, i2c, platform, etc.)
> > > > 
> > > > So you need both, a bus to talk to the hardware, and a class to talk to
> > > > userspace in a common way (ignore the fact that we can also talk to
> > > > hardware directly from userspace like raw USB or i2c or PCI config
> > > > space, that's all bus-specific stuff).  
> > > 
> > > Thanks for chiming in. Let me see if I understand this correctly: In this
> > > case, I have a UAPI that is common to different types of motion control
> > > devices. So I need a class. check.  
> > 
> > Correct.
> > 
> > > Do I need a bus? If one can conceive other drivers or kernel parts that talk to
> > > motion drivers, I would need a bus. If that doesn't make sense, I don't. Right?  
> > 
> > Correct.
> > 
> > > I actually can think of a new motion device that acts as an aggregator of
> > > several single-channel motion devices into a single "virtual" multi-channel
> > > device... so do I need also a bus? I suppose...?  
> > 
> > Nope, that should just be another class driver.  Think about how input
> > does this, some input /dev/ nodes are the sum of ALL input /dev/ nodes
> > together, while others are just for individual input devices.
> 
> Understood. Thanks!
> 
> > > Then the question remains: why did the chapter about classes vanish?  
> > 
> > What are you specifically referring to?  I don't remember deleting any
> > documentation, did files move around somehow and the links not get
> > updated?
> 
> This:
> https://www.kernel.org/doc/html/v5.12/driver-api/driver-model/index.html
> 
> vs this:
> https://www.kernel.org/doc/html/v5.13/driver-api/driver-model/index.html
> 
> Maybe it moved somewhere else, but I can't find it... I'd have to git bisect
> or git blame between the two releases maybe.

Ah, this was removed in:
	1364c6787525 ("docs: driver-model: Remove obsolete device class documentation")
as the information there was totally incorrect, since the 2.5.69 kernel
release.  "device classes" aren't a thing, "classes" are a thing :)

thanks,

greg k-h

