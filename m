Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760742D8DE9
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgLMOXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgLMOXi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:23:38 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069A12253D;
        Sun, 13 Dec 2020 14:22:56 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:22:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: dummy: convert all simple allocation devm_
 variants
Message-ID: <20201213142253.14afd9d9@archlinux>
In-Reply-To: <CA+U=Dsr_95ktcCFQApndtsPzO3dSVpvpBYUTDh6njBv15FYV=A@mail.gmail.com>
References: <20201203095005.72252-1-alexandru.ardelean@analog.com>
        <20201205163618.3b26334f@archlinux>
        <CA+U=Dsr_95ktcCFQApndtsPzO3dSVpvpBYUTDh6njBv15FYV=A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Dec 2020 09:22:28 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, Dec 5, 2020 at 8:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 3 Dec 2020 11:50:03 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >  
> > > Since a main requirement for an IIO device is to have a parent device
> > > object, it makes sense to attach more of the IIO device's objects to the
> > > lifetime of the parent object, to clean up the code.
> > > The idea is to also provide a base example that is more up-to-date with
> > > what's going on lately with most IIO drivers.  
> >
> > To some degree maybe, it's also very very handy for testing odd corner
> > cases with.  I'd definitely not recommend it as a reference driver
> > because it inherently has some odd corners because we need to
> > fake various things that don't exist without hardware.  
> 
> It's funny because during GSoC it seemed like some people would try to
> use this as a starting point, then shift to another working ADC/DAC
> example.

Hmm. It make sense to use it if you are interested in see what actually
turns up in userspace etc as a gsoc student probably doesn't have much
hardware that is already supported.  But code wise it's somewhat odd
and may be less good as an example than a i2c/spi ADC.

> I was also thinking about maybe extending this a bit further, to have
> it a bit more dynamic at load time [being able to load fake IIO
> drivers, load fake data to be read via fake IIO device].
> No idea when this will be ready, but it's on my long todo-list.

Sure. It's always been on my long term list to make this driver do
more complex stuff, but real parts often get in the way unless I'm
proving out something I don't have any real hardware for.

> 
> >  
> > >
> > > This change tackles the simple allocations, to convert them to
> > > device-managed calls, and tie them to the parent device.  
> >
> > I'm confused or maybe I missrecall how this works.
> >
> > IIRC there isn't a parent device...
> >
> > Maybe we could create one via a bit of smoke and magic.  
> 
> Yep, there isn't one.
> I'll add one through some smoke, magic, some OF and maybe some fake
> i2c/spi device IDs.

Hmm. Whatever is done needs to be both non invasive and not imply
anything that isn't true.  Maybe better off with a platform device
than i2c or spi as the parent.

Jonathan

> 
> >
> >  
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  drivers/iio/dummy/iio_simple_dummy.c | 29 ++++++++--------------------
> > >  1 file changed, 8 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> > > index c0b7ef900735..2a2e62f780a1 100644
> > > --- a/drivers/iio/dummy/iio_simple_dummy.c
> > > +++ b/drivers/iio/dummy/iio_simple_dummy.c
> > > @@ -574,11 +574,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> > >        * parent = &client->dev;
> > >        */
> > >
> > > -     swd = kzalloc(sizeof(*swd), GFP_KERNEL);
> > > -     if (!swd) {
> > > -             ret = -ENOMEM;
> > > -             goto error_kzalloc;
> > > -     }
> > > +     swd = devm_kzalloc(parent, sizeof(*swd), GFP_KERNEL);
> > > +     if (!swd)
> > > +             return ERR_PTR(-ENOMEM);
> > >       /*
> > >        * Allocate an IIO device.
> > >        *
> > > @@ -587,11 +585,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> > >        * It also has a region (accessed by iio_priv()
> > >        * for chip specific state information.
> > >        */
> > > -     indio_dev = iio_device_alloc(parent, sizeof(*st));
> > > -     if (!indio_dev) {
> > > -             ret = -ENOMEM;
> > > -             goto error_ret;
> > > -     }
> > > +     indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
> > > +     if (!indio_dev)
> > > +             return ERR_PTR(-ENOMEM);
> > >
> > >       st = iio_priv(indio_dev);
> > >       mutex_init(&st->lock);
> > > @@ -615,7 +611,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> > >        *    indio_dev->name = id->name;
> > >        *    indio_dev->name = spi_get_device_id(spi)->name;
> > >        */
> > > -     indio_dev->name = kstrdup(name, GFP_KERNEL);
> > > +     indio_dev->name = devm_kstrdup(parent, name, GFP_KERNEL);
> > >
> > >       /* Provide description of available channels */
> > >       indio_dev->channels = iio_dummy_channels;
> > > @@ -632,7 +628,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> > >
> > >       ret = iio_simple_dummy_events_register(indio_dev);
> > >       if (ret < 0)
> > > -             goto error_free_device;
> > > +             return ERR_PTR(ret);
> > >
> > >       ret = iio_simple_dummy_configure_buffer(indio_dev);
> > >       if (ret < 0)
> > > @@ -649,11 +645,6 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> > >       iio_simple_dummy_unconfigure_buffer(indio_dev);
> > >  error_unregister_events:
> > >       iio_simple_dummy_events_unregister(indio_dev);
> > > -error_free_device:
> > > -     iio_device_free(indio_dev);
> > > -error_ret:
> > > -     kfree(swd);
> > > -error_kzalloc:
> > >       return ERR_PTR(ret);
> > >  }
> > >
> > > @@ -683,10 +674,6 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
> > >
> > >       iio_simple_dummy_events_unregister(indio_dev);
> > >
> > > -     /* Free all structures */
> > > -     kfree(indio_dev->name);
> > > -     iio_device_free(indio_dev);
> > > -
> > >       return 0;
> > >  }
> > >  
> >  

