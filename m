Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7311E9845
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgEaOyt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaOyt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:54:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93EB20723;
        Sun, 31 May 2020 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590936888;
        bh=Bg+bGHCOopmbFf4GFVrUi1TfkYwf1NDe9nVoY8XNeAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OnRBGMxqnT1DbSH2MgrDVFvh0I5hVxlkGgAq71e7krnRQXz6ufrtva48Lq2539Oqr
         Jf9dE4HhEqEgMNhO1XXmKQIOECUtJJj69+JJxTGO0E77ZUesl0wz3VHZuR5FmONd1j
         ufBX6KyWUStK2tncAdVR35bCDJgV6VghfXbUyTLc=
Date:   Sun, 31 May 2020 15:54:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent
 assignment
Message-ID: <20200531155444.73b9fd78@archlinux>
In-Reply-To: <20200529134533.GD19480@localhost>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
        <20200522082208.383631-4-alexandru.ardelean@analog.com>
        <20200529101608.GC19480@localhost>
        <05500c815f4881a6aa86c809c5ac53e8af3f3e91.camel@analog.com>
        <20200529134533.GD19480@localhost>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 May 2020 15:45:33 +0200
Johan Hovold <johan@kernel.org> wrote:

> [ Trimming CC to something more reasonable... ]
> 
> On Fri, May 29, 2020 at 11:08:38AM +0000, Ardelean, Alexandru wrote:
> > On Fri, 2020-05-29 at 12:16 +0200, Johan Hovold wrote:  
> > > On Fri, May 22, 2020 at 11:22:07AM +0300, Alexandru Ardelean wrote:  
> > > > This assignment is the more peculiar of the bunch as it assigns the parent
> > > > of the platform-device's device (i.e. pdev->dev.parent) as the IIO device's
> > > > parent.
> > > > 
> > > > It's unclear whether this is intentional or not.
> > > > Hence it is in it's own patch.  
> > > 
> > > Yeah, we have a few mfd drivers whose child drivers registers their
> > > class devices directly under the parent mfd device rather than the
> > > corresponding child platform device.
> > > 
> > > Since it's done consistently I think you need to update them all if you
> > > really want to change this. 
> > > 
> > > And it may not be worth it since at least in theory someone could now be
> > > relying on this topology.  
> > 
> > Thanks for the feedback.
> > I guess, it could make sense to do here:
> >       devm_iio_device_alloc(pdev->dev.parent, ...)
> > 
> > Currently it's:
> >       devm_iio_device_alloc(&pdev->dev, ...)
> > 
> > That would make it slightly more consistent.  i.e. the life-time of
> > the object would be attached to the parent of the platform device,
> > versus the platform-device.  
> 
> Not really. If you unbind the iio driver, the iio device gets
> deregistered (as it should be) and there's no need to keep it around any
> more.
> 
> You'd essentially just leak resources every time you rebind the driver
> (e.g. during development).
> 
> And in fact, you could also introduce a use-after-free depending on if
> the parent mfd driver use devres to deregister its children.
> 
> > Currently, as it is, the allocation [of the IIO device] is tied the
> > platform-device, and the IIO registration to the parent (of the
> > platform-device).  
> 
> Not quite; the iio device still gets deregistered when the platform
> device is unbound.
> 
> > I'm not super-familiar with the internals here, but does this sound a
> > bit wrong?  
> 
> It's not a common pattern but not necessarily wrong per se.
> 
> > Is there a chance where the IIO device could be de-allocated, while
> > registered?  
> 
> No, the device-managed iio device object is freed when the platform
> device is unbound and specifically after the iio device has been
> deregistered.

I had a feeling we might have a few cases like this hiding in IIO.

For these I'd just leave the parent being manually set.
It doesn't do any harm and the facility existing is useful for messing
around with topology.

We may however want to wrap it up in a utility function on the
basis that we may want to change the visibility and location
of the IIO device down the line.

iio_device_set_parent() perhaps with docs to specify that it must
be called between allocation and registration + is meant to allow
cases where we want a different parent than the device used for
managed allocations etc.

Jonathan


> 
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > ---
> > > >  drivers/iio/light/lm3533-als.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> > > > index bc196c212881..0f380ec8d30c 100644
> > > > --- a/drivers/iio/light/lm3533-als.c
> > > > +++ b/drivers/iio/light/lm3533-als.c
> > > > @@ -852,7 +852,6 @@ static int lm3533_als_probe(struct platform_device
> > > > *pdev)
> > > >  	indio_dev->channels = lm3533_als_channels;
> > > >  	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
> > > >  	indio_dev->name = dev_name(&pdev->dev);
> > > > -	indio_dev->dev.parent = pdev->dev.parent;
> > > >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > > >  
> > > >  	als = iio_priv(indio_dev);  
> 
> Johan

