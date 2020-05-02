Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBDE1C2716
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgEBQzn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 12:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgEBQzn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 12:55:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C26206B8;
        Sat,  2 May 2020 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588438542;
        bh=EN0jC8jtMpvS3MIG3TGZ6/L5gRNmXrVn1U3RMM0Hd6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K219v3P1Or+rBvMErrWH54Sa9dn/94QgsBGtbnvOq/l6WQL6DSKVVVPH4UYy5+Nfh
         oUK/mAgInHqqjSZ8LQWpRCt121xKo+Ab+/Rgxgri5xr8mT2uMH4pCl3wP6cS6kFbht
         6z95s2UWcvSXBSY/KTkyFYClUSNHbg43q60dddFs=
Date:   Sat, 2 May 2020 17:55:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, felipe.balbi@linux.intel.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] Introduce the Counter character device interface
Message-ID: <20200502175536.1e9ac944@archlinux>
In-Reply-To: <20200501154519.GA4581@icarus>
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
        <20200430201345.GX51277@piout.net>
        <20200501154519.GA4581@icarus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 May 2020 11:46:10 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Thu, Apr 30, 2020 at 10:13:45PM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 29/04/2020 14:11:34-0400, William Breathitt Gray wrote:  
> > > Over the past couple years we have noticed some shortcomings with the
> > > Counter sysfs interface. Although useful in the majority of situations,
> > > there are certain use-cases where interacting through sysfs attributes
> > > can become cumbersome and inefficient. A desire to support more advanced
> > > functionality such as timestamps, multi-axis positioning tables, and
> > > other such latency-sensitive applications, has motivated a reevaluation
> > > of the Counter subsystem. I believe a character device interface will be
> > > helpful for this more niche area of counter device use.
> > > 
> > > To quell any concerns from the offset: this patchset makes no changes to
> > > the existing Counter sysfs userspace interface -- existing userspace
> > > applications will continue to work with no modifications necessary. I
> > > request that driver maintainers please test their applications to verify
> > > that this is true, and report any discrepancies if they arise.
> > >   
> > 
> > On that topic, I'm wondering why the counter subsystem uses /sys/bus
> > instead of /sys/class that would be more natural for a class of devices.
> > I can't see how counters would be considered busses. I think you should
> > consider moving it over to /sys/class (even if deprecating
> > /sys/bus/counter will be long).  
> 
> At the time I wasn't quite familiar with sysfs development so I was
> following the iio sysfs code rather closely. However, I see now that
> you're probably right: this isn't really a bus but rather a collection
> of various types of counters -- i.e. a class of devices.
> 
> Perhaps I should migrate this then to /sys/class/counter. Of course, the
> /sys/bus/counter location will have to remain for compatibility with
> existing applications, but I think a simple symlink to the new
> /sys/class/counter location should suffice for that.
> 
> If anyone sees an issue with this give me a heads up.
To just address this point as I've not read the rest of the thread yet...

I would resist moving it.  This one is an old argument. 

Some info in https://lwn.net/Articles/645810/
As that puts it a "bus" is better known as a "subsystem".

When we originally considered class vs bus for IIO, the view expressed
at the times was that the whole separation of the two didn't mean anything
and for non trivial cases bus was always preferred.  It's nothing to do
with with whether the thing is a bus or not.  Now I suppose it's possible
opinion has moved on this topic...    However, I'd say there
is really 0 advantage in moving an existing subsystem even if opinion
has changed.

+CC Greg in case he wants to add anything.

> 
> > > Interaction with Counter character devices occurs via ioctl commands.
> > > This allows userspace applications to access and set counter data using
> > > native C datatypes rather than working through string translations.
> > >   
> > 
> > I agree with David that you should consider using read to retrieve the
> > counter data as this will simplify interrupt handling/polling and
> > blocking/non-blocking reads can be used by an application. ABI wise,
> > this can also be a good move as you could always consider having an
> > ioctl requesting a specific format when reading the device so you are
> > not stuck with the initial format you are going to choose.  
> 
> My hesitation to implement support for read/write calls is due to a
> concern that we will end up with various incompatible formats between
> counter drivers (thus requiring users to have intimate knowledge of the
> drivers and therefore defeating the purpose of a subsystem). However, if
> we can standardize on a format that is flexible enough to work for all
> counter drivers, then read/write calls should not be a problem.
> 
> I think a general format could be possible. For example, the counter
> character device can return a standard header data at the start which
> provides general information about the counter device: number of
> counters, number or signals, number of extensions, etc. From this
> information, offsets can be computed (or perhaps provided by the device)
> to where the binary data for the count, extension, etc., can be read or
> written. Interrupts can then be handled as blocking reads, as could
> other types of events we implement.
> 
> Would something like this work well?
> 
> William Breathitt Gray
> 
> > > 2. Should device driver callbacks return int or long? I sometimes see
> > >    error values returned as long (e.g. PTR_ERR(), the file_operations
> > >    structure's ioctl callbacks, etc.); when is it necessary to return
> > >    long as opposed to int?
> > >   
> > 
> > You should use a long if you ever have to return a point as it is
> > guaranteed to have the correct size. Else, just stick to an int if you
> > are not going to overflow it.
> >   
> > > 3. I only implemented the unlocked_ioctl callback. Should I implement a
> > >    compat_ioctl callback as well?
> > >   
> > 
> > The compat_ioctl is to handle 32bit userspace running on a 64bit kernel.
> > If your structures have the same size in both cases, then you don't have
> > to implement compat_ioctl.
> > 
> > Have a look at Documentation/driver-api/ioctl.rst
> > 
> > 
> > -- 
> > Alexandre Belloni, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com  

