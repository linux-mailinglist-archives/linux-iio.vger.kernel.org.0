Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A052BC02A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgKUPKz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgKUPKy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:10:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0344322226;
        Sat, 21 Nov 2020 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605971453;
        bh=JOmXJ8GhVmVUzkilu+dYeO6+zNU8V6nbmJpVJcisMf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eUuTX64ubF565q5cUZTkR4DLaP9swSD0logHU/hG4RawYpAuIJzxqmXGNLBwNb8JA
         PJvzjZNYamX3hCOIE6Ctm81Xon5unANA4gMsLJKJAUYB8TD6h0Ha7J5oSbNTOeBJV3
         P56mEsTBGXqoqL08w/gav1yBVZlKJ6MXGh8WiV0w=
Date:   Sat, 21 Nov 2020 15:10:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        rishi gupta <gupt21@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: mcp2221: add ADC support
Message-ID: <20201121151049.425a7c97@archlinux>
In-Reply-To: <CAJCx=gkHYsu6=ne2BPCajVP+N9natV3stieP0cKd5nTSC8ARRA@mail.gmail.com>
References: <20201120030103.36138-1-matt.ranostay@konsulko.com>
        <CALUj-guTNWK9m-bwmkRC3st9VExhFkXPiUevXw_EA9xamR6BYA@mail.gmail.com>
        <CAJCx=gn=jAeYkVtLQ8Ou7P9xRpvSaXpuUk5XWDxMD_HPMTzH+Q@mail.gmail.com>
        <8151a886-b2db-8d44-eee6-46e8eb300ffb@metafoo.de>
        <CAJCx=gkHYsu6=ne2BPCajVP+N9natV3stieP0cKd5nTSC8ARRA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Nov 2020 12:31:23 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Nov 20, 2020 at 11:54 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> > On 11/20/20 8:17 PM, Matt Ranostay wrote:  
> > > On Fri, Nov 20, 2020 at 5:15 AM rishi gupta <gupt21@gmail.com> wrote:  
> > >> On Fri, Nov 20, 2020 at 8:31 AM Matt Ranostay
> > >> <matt.ranostay@konsulko.com> wrote:  
> > >>> Add support for the three 10-bit ADC channels registered via
> > >>> the IIO subsystem.
> > >>>
> > >>> Cc: linux-input@vger.kernel.org
> > >>> Cc: linux-iio@vger.kernel.org
> > >>> CC: Rishi Gupta <gupt21@gmail.com>
> > >>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > >>> ---
> > >>>   drivers/hid/Kconfig       |  1 +
> > >>>   drivers/hid/hid-mcp2221.c | 65 ++++++++++++++++++++++++++++++++++++++-
> > >>>   2 files changed, 65 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > >>> index 05315b434276..4795744d9979 100644
> > >>> --- a/drivers/hid/Kconfig
> > >>> +++ b/drivers/hid/Kconfig
> > >>> @@ -1157,6 +1157,7 @@ config HID_MCP2221
> > >>>          tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
> > >>>          depends on USB_HID && I2C
> > >>>          depends on GPIOLIB
> > >>> +       depends on IIO  
> > >> I am wondering what will happen on systems which do not enable IIO.
> > >> This driver can not be used there.
> > >> Is my understanding correct?  
> > > Actually yeah this should be "select IIO" to avoid that issue.  
> >
> > No, we should not have a individual driver select a framework. This will
> > cause all kinds of issues with reverse dependencies.
> >
> > It might be worth splitting this driver into a MFD driver, then the MFD
> > cells could have their own module that depend on the subsystem and if
> > not enabled the functionality will not be provided.  
> 
> Would it make sense to use IS_REACHABLE(CONFIG_IIO) for the iio blocks?
> 
> Guessing the weak reference "imply IIO" would still be bad for the
> driver selecting a framework?

A lesser option than going full MFD for this (which is probably the
right design decision but is a big change) would be to just put the
IIO stuff in a separate C file and use some build time magic.

I agree with Lars though that this is probably better done as an MFD.
It supports a bunch of things in entirely different subsystems afterall.

Jonathan

> 
> Thanks,
> 
> Matt
> 
> >
> > - Lars
> >  

