Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08E22CFE6E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLETe0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 14:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgLETeZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 14:34:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF4623133;
        Sat,  5 Dec 2020 15:52:35 +0000 (UTC)
Date:   Sat, 5 Dec 2020 15:52:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio:Documentation: Add documentation for hinge
 sensor channels
Message-ID: <20201205155232.702ce388@archlinux>
In-Reply-To: <697be63c1500a4ad80651a8182e56ce4271693c1.camel@linux.intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
        <20201203035352.13918-4-xiang.ye@intel.com>
        <697be63c1500a4ad80651a8182e56ce4271693c1.camel@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 04 Dec 2020 03:40:15 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Thu, 2020-12-03 at 11:53 +0800, Ye Xiang wrote:
> > Add channel description for hinge sensor, including channel label
> > attribute and raw data description.
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > b/Documentation/ABI/testing/sysfs-bus-iio
> > index df42bed09f25..82303b1bdff0 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1802,3 +1802,20 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Unscaled light intensity according to CIE 1931/DIN 5033
> > color space.
> >  		Units after application of scale are nano nanowatts per
> > square meter.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw  
> Channel "Y" doesn't sound to be a variable. Why not just say "*"

Long term convention.  More generally you need a way to refer to the
individual wild cards. Sometimes there are more than the two we have
here.

Not entirely sure where the convention comes from but it is used
throughout this file and I doubt I invented it.

Jonathan


> 
> Thanks,
> Srinivas
> 
> > +KernelVersion:	5.12
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Angle of rotation for channel Y. Units after
> > application of scale
> > +		and offset are radians.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
> > +KernelVersion:	5.12
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Optional symbolic label for channel Y.
> > +		For Intel hid hinge sensor, the label values are:
> > +		hinge, keyboard, screen. It means the three channels
> > +		each correspond respectively to hinge angle, keyboard
> > angle,
> > +		and screen angle.  
> 

