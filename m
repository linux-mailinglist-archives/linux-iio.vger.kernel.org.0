Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8B326D85
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 16:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB0POy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 10:14:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0POw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 10:14:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C0164D79;
        Sat, 27 Feb 2021 15:14:08 +0000 (UTC)
Date:   Sat, 27 Feb 2021 15:14:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 19/22] counter: Implement extension*_name sysfs
 attributes
Message-ID: <20210227151405.0de48038@archlinux>
In-Reply-To: <YDgzq6t5YRm6cFvO@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <c9b55d1cff6acac692a7853b0a25777ecf017b12.1613131238.git.vilhelm.gray@gmail.com>
        <20210214180913.05bd3498@archlinux>
        <YC98GTwzwt+pkzMO@shinobu>
        <20210221140507.0a5ef57f@archlinux>
        <YDgzq6t5YRm6cFvO@shinobu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Feb 2021 08:32:59 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Feb 21, 2021 at 02:05:07PM +0000, Jonathan Cameron wrote:
> > On Fri, 19 Feb 2021 17:51:37 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > On Sun, Feb 14, 2021 at 06:09:13PM +0000, Jonathan Cameron wrote:  
> > > > On Fri, 12 Feb 2021 21:13:43 +0900
> > > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > > >     
> > > > > The Generic Counter chrdev interface expects users to supply extension
> > > > > IDs in order to select extensions for requests. In order for users to
> > > > > know what extension ID belongs to which extension this information must
> > > > > be exposed. The extension*_name attribute provides a way for users to
> > > > > discover what extension ID belongs to which extension by reading the
> > > > > respective extension name for an extension ID.
> > > > > 
> > > > > Cc: David Lechner <david@lechnology.com>
> > > > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-bus-counter |  9 ++++
> > > > >  drivers/counter/counter-sysfs.c             | 51 +++++++++++++++++----
> > > > >  2 files changed, 50 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> > > > > index 6353f0a2f8f8..847e96f19d19 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > > > > @@ -100,6 +100,15 @@ Description:
> > > > >  		Read-only attribute that indicates whether excessive noise is
> > > > >  		present at the channel Y counter inputs.
> > > > >  
> > > > > +What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
> > > > > +What:		/sys/bus/counter/devices/counterX/extensionZ_name
> > > > > +What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
> > > > > +KernelVersion:	5.13
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Read-only attribute that indicates the component name of
> > > > > +		Extension Z.    
> > > > 
> > > > Good to say what form this takes.    
> > > 
> > > Do you mean a description like this: "Read-only string attribute that
> > > indicates the component name of Extension Z"?  
> > 
> > My expectation would be that the possible strings are tightly constrained
> > (perhaps via review). So I'd like to see what they are and a brief description
> > of what each one means.
> > 
> > Jonathan  
> 
> Okay I see what you mean now. These names will match the sysfs attribute
> filenames. So for example, if Extension 9 of Count 2 of Counter device
> is /sys/bus/counter/devices/counter4/count2/ceiling, then the attribute
> /sys/bus/counter/devices/counter4/count2/extension9_name will hold a
> value of "ceiling".
> 
> The idea is that the user walks down through each extension*_name to
> find sysfs attribute name for the Extension that they want. When they
> find the desired Extension name in say sysfs attribute extension9_name,
> then they know 9 is the ID number for that Extension.
> 
> There is an alternative design I was considering: instead of
> extension*_name attributes, we could have each Extension sysfs attribute
> have a matching *_extension_id attribute which provides the respective
> Extension ID. So for example, using the same Extension as before:
> /sys/bus/counter/devices/counter4/count2/ceiling_extension_id will hold
> a value of 9.
> 
> Do you think this alternative design would be more intuitive to users?
It feels like the user is going to start from what they want to enable
then get the ID from that.   With the current way around they'll have
to search the extensionX_name files to find it, rather than a direct
look up.  So immediate thought is this second way would be easier to
use, but perhaps others think differently.

Jonathan

> 
> William Breathitt Gray

