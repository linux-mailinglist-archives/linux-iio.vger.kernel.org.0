Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0CC320AE7
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 15:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBUOF4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 09:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBUOFy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 09:05:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0315061481;
        Sun, 21 Feb 2021 14:05:10 +0000 (UTC)
Date:   Sun, 21 Feb 2021 14:05:07 +0000
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
Message-ID: <20210221140507.0a5ef57f@archlinux>
In-Reply-To: <YC98GTwzwt+pkzMO@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <c9b55d1cff6acac692a7853b0a25777ecf017b12.1613131238.git.vilhelm.gray@gmail.com>
        <20210214180913.05bd3498@archlinux>
        <YC98GTwzwt+pkzMO@shinobu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Feb 2021 17:51:37 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Feb 14, 2021 at 06:09:13PM +0000, Jonathan Cameron wrote:
> > On Fri, 12 Feb 2021 21:13:43 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > The Generic Counter chrdev interface expects users to supply extension
> > > IDs in order to select extensions for requests. In order for users to
> > > know what extension ID belongs to which extension this information must
> > > be exposed. The extension*_name attribute provides a way for users to
> > > discover what extension ID belongs to which extension by reading the
> > > respective extension name for an extension ID.
> > > 
> > > Cc: David Lechner <david@lechnology.com>
> > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-counter |  9 ++++
> > >  drivers/counter/counter-sysfs.c             | 51 +++++++++++++++++----
> > >  2 files changed, 50 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> > > index 6353f0a2f8f8..847e96f19d19 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > > @@ -100,6 +100,15 @@ Description:
> > >  		Read-only attribute that indicates whether excessive noise is
> > >  		present at the channel Y counter inputs.
> > >  
> > > +What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
> > > +What:		/sys/bus/counter/devices/counterX/extensionZ_name
> > > +What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
> > > +KernelVersion:	5.13
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Read-only attribute that indicates the component name of
> > > +		Extension Z.  
> > 
> > Good to say what form this takes.  
> 
> Do you mean a description like this: "Read-only string attribute that
> indicates the component name of Extension Z"?

My expectation would be that the possible strings are tightly constrained
(perhaps via review). So I'd like to see what they are and a brief description
of what each one means.

Jonathan

> 
> William Breathitt Gray

