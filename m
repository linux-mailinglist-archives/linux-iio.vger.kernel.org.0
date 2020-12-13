Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AF2D8DE3
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgLMOQc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgLMOQa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:16:30 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D802253D;
        Sun, 13 Dec 2020 14:15:48 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:15:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ye, Xiang" <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio:Documentation: Add documentation for hinge
 sensor channels
Message-ID: <20201213141545.1e9d30de@archlinux>
In-Reply-To: <20201207091818.GA23419@host>
References: <20201203035352.13918-1-xiang.ye@intel.com>
        <20201203035352.13918-4-xiang.ye@intel.com>
        <20201205160540.22d2b8d5@archlinux>
        <20201207091818.GA23419@host>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Dec 2020 17:18:18 +0800
"Ye, Xiang" <xiang.ye@intel.com> wrote:

> Hi Jonathan
> 
> Thanks for review and comments.
> 
> On Sat, Dec 05, 2020 at 04:05:40PM +0000, Jonathan Cameron wrote:
> > On Thu,  3 Dec 2020 11:53:52 +0800
> > Ye Xiang <xiang.ye@intel.com> wrote:
> >   
> > > Add channel description for hinge sensor, including channel label
> > > attribute and raw data description.
> > > 
> > > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index df42bed09f25..82303b1bdff0 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -1802,3 +1802,20 @@ Contact:	linux-iio@vger.kernel.org
> > >  Description:
> > >  		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
> > >  		Units after application of scale are nano nanowatts per square meter.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
> > > +KernelVersion:	5.12
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Angle of rotation for channel Y. Units after application of scale
> > > +		and offset are radians.  
> > 
> > This entry is already mostly in the doc around line 200, just without the index.
> > Please just add the What: line to that block to reduce repetition.
> > If you want to add... "Where present, Y indexes the channel." or something like
> > that feel free.  
> When adding in_anglY_raw to in_angl_raw block, Should I update the KernelVersion form
> 4.17 to 5.12? Like blow:
> 
> What:		/sys/bus/iio/devices/iio:deviceX/in_angl_raw
> What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
> KernelVersion:	5.12
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		Angle of rotation. Units after application of scale and offset
> 		are radians. Where present, Y indexes the channel.

No. This is an unfortunate limitation of these files unless we keep duplicating
nearly identical text.

I'm not that worried about documenting an optional bit of ABI as apparently
being in an earlier kernel than it actually was.  That way any userspace
will work.  The other way around is more likely to cause problems.

> 
> > 
> >   
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
> > > +KernelVersion:	5.12
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Optional symbolic label for channel Y.
> > > +		For Intel hid hinge sensor, the label values are:
> > > +		hinge, keyboard, screen. It means the three channels
> > > +		each correspond respectively to hinge angle, keyboard angle,
> > > +		and screen angle.  
> > 
> > Makes sense to keep this block separate given the additional info provided.
> > Alternative would be to add it to the one with in_voltageY_label which would
> > be odd given what follows!  
> Ok, Then I will keep the in_anglY_label block here. BTW, I didnot see in_voltageY_label
> in sysfs-bus-iio in current kernel master branch.
It was part of the series that added the support for per channel labels to the core.
3079188f821c ("iio:Documentation: Add documentation for label channel attribute")
so will only going into current master in the merge window that will open shortly.

Thanks,

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> Thanks
> Ye, Xiang
> >   

