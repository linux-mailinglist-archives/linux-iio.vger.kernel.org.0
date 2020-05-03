Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401291C2AE2
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgECJXZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgECJXY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 05:23:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C327206A5;
        Sun,  3 May 2020 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588497804;
        bh=tS8rC1xwfDsH8CpezAlet6bkQanl+yMNiprBNGD6djY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2CjA7HuwF3NwkOh+hkxYDNqyBIoT+EOkEDNGLLwIzj3G7kmBXBpBu+NCb+Imya6WJ
         7yyP8+/tRWBq6z8/5kMwrXrLm0XDdrRzihGNzhofPQwwTuYJZlWNR2oxoUfRhvPZ1A
         ex2DOR/tUhRIKR5g6hfFiI5yt6O8oQTgWZTQevlw=
Date:   Sun, 3 May 2020 11:23:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, felipe.balbi@linux.intel.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH 0/4] Introduce the Counter character device interface
Message-ID: <20200503092316.GA570888@kroah.com>
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
 <20200430201345.GX51277@piout.net>
 <20200501154519.GA4581@icarus>
 <20200502175536.1e9ac944@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502175536.1e9ac944@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 02, 2020 at 05:55:36PM +0100, Jonathan Cameron wrote:
> On Fri, 1 May 2020 11:46:10 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > On Thu, Apr 30, 2020 at 10:13:45PM +0200, Alexandre Belloni wrote:
> > > Hi,
> > > 
> > > On 29/04/2020 14:11:34-0400, William Breathitt Gray wrote:  
> > > > Over the past couple years we have noticed some shortcomings with the
> > > > Counter sysfs interface. Although useful in the majority of situations,
> > > > there are certain use-cases where interacting through sysfs attributes
> > > > can become cumbersome and inefficient. A desire to support more advanced
> > > > functionality such as timestamps, multi-axis positioning tables, and
> > > > other such latency-sensitive applications, has motivated a reevaluation
> > > > of the Counter subsystem. I believe a character device interface will be
> > > > helpful for this more niche area of counter device use.
> > > > 
> > > > To quell any concerns from the offset: this patchset makes no changes to
> > > > the existing Counter sysfs userspace interface -- existing userspace
> > > > applications will continue to work with no modifications necessary. I
> > > > request that driver maintainers please test their applications to verify
> > > > that this is true, and report any discrepancies if they arise.
> > > >   
> > > 
> > > On that topic, I'm wondering why the counter subsystem uses /sys/bus
> > > instead of /sys/class that would be more natural for a class of devices.
> > > I can't see how counters would be considered busses. I think you should
> > > consider moving it over to /sys/class (even if deprecating
> > > /sys/bus/counter will be long).  
> > 
> > At the time I wasn't quite familiar with sysfs development so I was
> > following the iio sysfs code rather closely. However, I see now that
> > you're probably right: this isn't really a bus but rather a collection
> > of various types of counters -- i.e. a class of devices.
> > 
> > Perhaps I should migrate this then to /sys/class/counter. Of course, the
> > /sys/bus/counter location will have to remain for compatibility with
> > existing applications, but I think a simple symlink to the new
> > /sys/class/counter location should suffice for that.
> > 
> > If anyone sees an issue with this give me a heads up.
> To just address this point as I've not read the rest of the thread yet...
> 
> I would resist moving it.  This one is an old argument. 
> 
> Some info in https://lwn.net/Articles/645810/
> As that puts it a "bus" is better known as a "subsystem".
> 
> When we originally considered class vs bus for IIO, the view expressed
> at the times was that the whole separation of the two didn't mean anything
> and for non trivial cases bus was always preferred.  It's nothing to do
> with with whether the thing is a bus or not.  Now I suppose it's possible
> opinion has moved on this topic...    However, I'd say there
> is really 0 advantage in moving an existing subsystem even if opinion
> has changed.
> 
> +CC Greg in case he wants to add anything.

Traditionally classes are a unified way of representing data to
userspace, independant of the physical transport that the data came to
userspace on (i.e. input devices are a class, it doesn't matter if they
came on serial, USB, PS/2, or virtual busses.)

A bus is traditionally a collection of drivers that all talk on a same
physical transport, that then expose data from that transport to a
specific userspace class.  Again, think USB mice drivers, serial mice
drivers, PS/2 mice drivers.

Busses bind a driver to a device it creates based on that "bus".
Classes create virtual devices that export data to userspace for a
specific common protocol.

Does that help?

One can argue (and have properly in the past), that classes and busses
really are not all that different, and there used to be code floating
around that made them the same exact thing in the kernel, with loads of
userspace sysfs symlinks to preserve things, but those are well out of
date and I don't think anyone feels like reviving them.  However I think
systemd might still have code in it to work properly if that ever
happens, haven't looked in a few years...

thanks,

greg k-h
