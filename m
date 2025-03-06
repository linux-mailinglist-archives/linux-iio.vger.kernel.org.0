Return-Path: <linux-iio+bounces-16478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1851A54E55
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C315164FCA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447F18B476;
	Thu,  6 Mar 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRlSJjcc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519816DEB3;
	Thu,  6 Mar 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272859; cv=none; b=c2zxkAnWbMY8tYvl2kZq+ZCBIiiKRBAS56+/0JY1tYlAp1Oyyv/4BSl7oBMMd3+yzyW2Z4xg+sB3IAynxb/arSYm5tvqYKMXdnwyNxDamqQb7eAcTXTXNhKJm+BRyqLvEo6VQpUoP38Zu31BgEw1FeK3MNc0IRihqMYEE4kU/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272859; c=relaxed/simple;
	bh=ILbT7RQMEoDsdwEXXugZGqEIy/JOrstY20pKKZ4TSQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLl0IR9TH6TyGwdlI8xLmUY6JR95LNQAcaZBUO03bmIA8lO0OzE+BLGani+06foCblhq8TOuishBVqRI9Ibk2wb4Rjmr0eZBzKFKkY0Xr6ieO6DEQodx+iNCwfIZ+fqUNQXsI8HwnDDjjFt1EpwoBMMvPUDTv538o2BF0nET0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRlSJjcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9AC4CEE0;
	Thu,  6 Mar 2025 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741272859;
	bh=ILbT7RQMEoDsdwEXXugZGqEIy/JOrstY20pKKZ4TSQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRlSJjccXTjUOES93hGww9x7aXWW2u8eW/otT1Yj/1MudHbFNIxw8NAnSE1xUli1P
	 s5Q5//cvtz/8+POwJ1DfkpMQorgr3HNsa6yvrtIYYmZjxaAvaJQt8nAKUDIB4mZ0QQ
	 VNOJ08/PDyn8WIsrVdEVWzcGgDS4H75EgPDE/Tpk=
Date: Thu, 6 Mar 2025 15:54:16 +0100
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
Message-ID: <2025030617-waggle-sanitizer-f961@gregkh>
References: <20250227162823.3585810-2-david@protonic.nl>
 <6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
 <20250305164046.4de5b6ef@erd003.prtnl>
 <mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
 <2025030611-embezzle-sacrament-00d9@gregkh>
 <20250306092013.1147f27e@erd003.prtnl>
 <2025030638-wavy-napkin-41ab@gregkh>
 <20250306103402.2b9e51d7@erd003.prtnl>
 <2025030633-covenant-bootlace-7163@gregkh>
 <20250306152529.31dbfef2@erd003.prtnl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250306152529.31dbfef2@erd003.prtnl>

On Thu, Mar 06, 2025 at 03:25:29PM +0100, David Jander wrote:
> On Thu, 6 Mar 2025 14:39:16 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Mar 06, 2025 at 10:34:02AM +0100, David Jander wrote:
> > > On Thu, 6 Mar 2025 10:03:26 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > On Thu, Mar 06, 2025 at 09:20:13AM +0100, David Jander wrote:  
> > > > > On Thu, 6 Mar 2025 08:18:46 +0100
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > >     
> > > > > > On Thu, Mar 06, 2025 at 12:21:22AM +0100, Uwe Kleine-König wrote:    
> > > > > > > Hello David,
> > > > > > > 
> > > > > > > On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:      
> > > > > > > > On Fri, 28 Feb 2025 17:44:27 +0100
> > > > > > > > Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:      
> > > > > > > > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > > > > > > > [...]      
> > > > > > > > > > +static int motion_open(struct inode *inode, struct file *file)
> > > > > > > > > > +{
> > > > > > > > > > +	int minor = iminor(inode);
> > > > > > > > > > +	struct motion_device *mdev = NULL, *iter;
> > > > > > > > > > +	int err;
> > > > > > > > > > +
> > > > > > > > > > +	mutex_lock(&motion_mtx);        
> > > > > > > > > 
> > > > > > > > > If you use guard(), error handling gets a bit easier.      
> > > > > > > > 
> > > > > > > > This looks interesting. I didn't know about guard(). Thanks. I see the
> > > > > > > > benefits, but in some cases it also makes the locked region less clearly
> > > > > > > > visible. While I agree that guard() in this particular place is nice,
> > > > > > > > I'm hesitant to try and replace all mutex_lock()/_unlock() calls with guard().
> > > > > > > > Let me know if my assessment of the intended use of guard() is incorrect.      
> > > > > > > 
> > > > > > > I agree that guard() makes it harder for non-trivial functions to spot
> > > > > > > the critical section. In my eyes this is outweight by not having to
> > > > > > > unlock in all exit paths, but that might be subjective. Annother
> > > > > > > downside of guard is that sparse doesn't understand it and reports
> > > > > > > unbalanced locking.
> > > > > > >        
> > > > > > > > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > > > > > > > +		if (iter->minor != minor)
> > > > > > > > > > +			continue;
> > > > > > > > > > +		mdev = iter;
> > > > > > > > > > +		break;
> > > > > > > > > > +	}        
> > > > > > > > > 
> > > > > > > > > This should be easier. If you use a cdev you can just do
> > > > > > > > > container_of(inode->i_cdev, ...);      
> > > > > > > > 
> > > > > > > > Hmm... I don't yet really understand what you mean. I will have to study the
> > > > > > > > involved code a bit more.      
> > > > > > > 
> > > > > > > The code that I'm convinced is correct is
> > > > > > > https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com/
> > > > > > > 
> > > > > > > This isn't in mainline because there is some feedback I still have to
> > > > > > > address, but I think it might serve as an example anyhow.
> > > > > > >       
> > > > > > > > > > [...]
> > > > > > > > > > +
> > > > > > > > > > +static const struct class motion_class = {
> > > > > > > > > > +	.name		= "motion",
> > > > > > > > > > +	.devnode	= motion_devnode,        
> > > > > > > > > 
> > > > > > > > > IIRC it's recommended to not create new classes, but a bus.      
> > > > > > > > 
> > > > > > > > Interesting. I did some searching, and all I could find was that the chapter
> > > > > > > > in driver-api/driver-model about classes magically vanished between versions
> > > > > > > > 5.12 and 5.13. Does anyone know where I can find some information about this?
> > > > > > > > Sorry if I'm being blind...      
> > > > > > > 
> > > > > > > Half knowledge on my end at best. I would hope that Greg knows some
> > > > > > > details (which might even be "no, classes are fine"). I added him to Cc:      
> > > > > > 
> > > > > > A class is there for when you have a common api that devices of
> > > > > > different types can talk to userspace (i.e. the UAPI is common, not the
> > > > > > hardware type).  Things like input devices, tty, disks, etc.  A bus is
> > > > > > there to be able to write different drivers to bind to for that hardware
> > > > > > bus type (pci, usb, i2c, platform, etc.)
> > > > > > 
> > > > > > So you need both, a bus to talk to the hardware, and a class to talk to
> > > > > > userspace in a common way (ignore the fact that we can also talk to
> > > > > > hardware directly from userspace like raw USB or i2c or PCI config
> > > > > > space, that's all bus-specific stuff).    
> > > > > 
> > > > > Thanks for chiming in. Let me see if I understand this correctly: In this
> > > > > case, I have a UAPI that is common to different types of motion control
> > > > > devices. So I need a class. check.    
> > > > 
> > > > Correct.
> > > >   
> > > > > Do I need a bus? If one can conceive other drivers or kernel parts that talk to
> > > > > motion drivers, I would need a bus. If that doesn't make sense, I don't. Right?    
> > > > 
> > > > Correct.
> > > >   
> > > > > I actually can think of a new motion device that acts as an aggregator of
> > > > > several single-channel motion devices into a single "virtual" multi-channel
> > > > > device... so do I need also a bus? I suppose...?    
> > > > 
> > > > Nope, that should just be another class driver.  Think about how input
> > > > does this, some input /dev/ nodes are the sum of ALL input /dev/ nodes
> > > > together, while others are just for individual input devices.  
> > > 
> > > Understood. Thanks!
> > >   
> > > > > Then the question remains: why did the chapter about classes vanish?    
> > > > 
> > > > What are you specifically referring to?  I don't remember deleting any
> > > > documentation, did files move around somehow and the links not get
> > > > updated?  
> > > 
> > > This:
> > > https://www.kernel.org/doc/html/v5.12/driver-api/driver-model/index.html
> > > 
> > > vs this:
> > > https://www.kernel.org/doc/html/v5.13/driver-api/driver-model/index.html
> > > 
> > > Maybe it moved somewhere else, but I can't find it... I'd have to git bisect
> > > or git blame between the two releases maybe.  
> > 
> > Ah, this was removed in:
> > 	1364c6787525 ("docs: driver-model: Remove obsolete device class documentation")
> > as the information there was totally incorrect, since the 2.5.69 kernel
> > release.  "device classes" aren't a thing, "classes" are a thing :)
> 
> Aha. Thanks for pointing this out. The sheer removal of this, combined with
> other indirect indications, such as /sys/class/gpio being replaced with
> /sys/bus/gpio in the new api, Uwe's comment, etc... derailed my interpretation.
> :-)
> 
> Btw, sorry to ask here and now @Greg: I didn't CC you with this whole series
> while I probably should have... now I am tempted to move V2 of this series to
> staging, due to higher chances of potentially breaking UAPI changes during
> initial development, and in order to have a more flexible discussions over the
> UAPI of LMC in general. Is that advisable or should we better make sure that
> the version to get merged upstream (I hope it eventually will be) is set in
> stone?

Just because something is in drivers/staging/ does not mean you can
break the user/kernel api, that is NOT what staging is for at all.

Take the time to get this right, there's no rush here.  Make sure
userspace works well with what you have before committing to it.

If you want to cc: me on the next series so I can review the driver-core
interaction bits, I'll be glad to do so.

thanks,

greg k-h

