Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08AE3C3B7F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhGKK0v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 06:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhGKK0v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 06:26:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A3261156;
        Sun, 11 Jul 2021 10:24:02 +0000 (UTC)
Date:   Sun, 11 Jul 2021 11:26:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-managed
 functions
Message-ID: <20210711112618.50c5bea1@jic23-huawei>
In-Reply-To: <CAASAkoYMaSuRnSWwtcoZVaGj+m6bDtu7ms2idHBtp5JFzDEp1g@mail.gmail.com>
References: <20210628135132.73682-1-aardelean@deviqon.com>
        <20210703185007.2c2283f4@jic23-huawei>
        <CAASAkoYMaSuRnSWwtcoZVaGj+m6bDtu7ms2idHBtp5JFzDEp1g@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Jul 2021 09:38:21 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> On Sat, 3 Jul 2021 at 20:47, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 28 Jun 2021 16:51:32 +0300
> > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> >  
> > > This one is a little easier to convert to device-managed, now with the
> > > devm_krealloc() function.
> > >
> > > The other iio_triggered_buffer_setup() and iio_device_register() can be
> > > converted to their devm_ variants. And devm_krealloc() can be used to
> > > (re)alloc the buffer. When the driver unloads, this will also be free'd.
> > >
> > > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > > ---
> > >  drivers/iio/light/adjd_s311.c | 34 +++++-----------------------------
> > >  1 file changed, 5 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> > > index 17dac8d0e11d..19d60d6986a1 100644
> > > --- a/drivers/iio/light/adjd_s311.c
> > > +++ b/drivers/iio/light/adjd_s311.c
> > > @@ -230,8 +230,8 @@ static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
> > >  {
> > >       struct adjd_s311_data *data = iio_priv(indio_dev);
> > >
> > > -     kfree(data->buffer);
> > > -     data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > > +     data->buffer = devm_krealloc(indio_dev->dev.parent, data->buffer,
> > > +                                  indio_dev->scan_bytes, GFP_KERNEL);  
> > I got some complaints about exactly this trick in a review recently so I'll
> > pass them on.
> >
> > Whilst devm_krealloc() usage like this won't lose the original reference, its
> > not what people expect from a realloc() case, so to not confuse people it is
> > better to do a dance where you use a local variable, then only set data->buffer
> > to it once we know the realloc succeeded.
> >
> > That avoids this looking like the anti-pattern it would be if that were a normal
> > realloc in which case you would just have leaked the original allocation.
> >
> > More interestingly, why are we bothering with resizing the buffer dependent on what
> > is enabled?  Can't we just allocate a 128 byte buffer and not bother changing it
> > as we really aren't wasting that much space?  Just embed it in the adjd_s311_data
> > structure directly and don't worry about the allocations.  Will need to be
> > aligned(8) though to avoid the push_to_buffer_with_timestamp() issue.
> > Using something like
> >
> > struct {
> >         s16 chans[4];
> >         s64 ts __aligned(8); /* I hate x86 32 bit */  
> 
> do you want to me t also add this comment? :p
> [just kidding]
> 
> > } scan;
> >
> > Inside the priv structure should work nicely.  
> 
> i agree; will do it like this;
> i hesitated a bit due to the inertia of converting things to devm_

A long discussion on rust usage in linux diverted into the issues around devm.
I 'believe' that we are fine in IIO after some work Lars did a long time back
to make us resilient to unbinds whilst the chardev was open, but probably
worth keeping an eye on that discussion.

https://lore.kernel.org/ksummit/CANiq72nkNrekzbxMci6vW02w=Q2L-SVTk_U4KN_LT8u_b=YPgw@mail.gmail.com/T/#m6db86a574237c22a32ecf49b596b3c2917967c5e

I'm a tiny bit nervous that there might be races where we are doing the devm_realloc.
I 'think' we are fine, but the 'think' and 'believe' in these statements expresses
a slight lack of certainty!

Jonathan

> 
> >
> >  
> > >       if (data->buffer == NULL)
> > >               return -ENOMEM;
> > >
> > > @@ -256,7 +256,6 @@ static int adjd_s311_probe(struct i2c_client *client,
> > >               return -ENOMEM;
> > >
> > >       data = iio_priv(indio_dev);
> > > -     i2c_set_clientdata(client, indio_dev);
> > >       data->client = client;
> > >
> > >       indio_dev->info = &adjd_s311_info;
> > > @@ -265,34 +264,12 @@ static int adjd_s311_probe(struct i2c_client *client,
> > >       indio_dev->num_channels = ARRAY_SIZE(adjd_s311_channels);
> > >       indio_dev->modes = INDIO_DIRECT_MODE;
> > >
> > > -     err = iio_triggered_buffer_setup(indio_dev, NULL,
> > > -             adjd_s311_trigger_handler, NULL);
> > > +     err = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> > > +                                           adjd_s311_trigger_handler, NULL);
> > >       if (err < 0)
> > >               return err;
> > >
> > > -     err = iio_device_register(indio_dev);
> > > -     if (err)
> > > -             goto exit_unreg_buffer;
> > > -
> > > -     dev_info(&client->dev, "ADJD-S311 color sensor registered\n");
> > > -
> > > -     return 0;
> > > -
> > > -exit_unreg_buffer:
> > > -     iio_triggered_buffer_cleanup(indio_dev);
> > > -     return err;
> > > -}
> > > -
> > > -static int adjd_s311_remove(struct i2c_client *client)
> > > -{
> > > -     struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > -     struct adjd_s311_data *data = iio_priv(indio_dev);
> > > -
> > > -     iio_device_unregister(indio_dev);
> > > -     iio_triggered_buffer_cleanup(indio_dev);
> > > -     kfree(data->buffer);
> > > -
> > > -     return 0;
> > > +     return devm_iio_device_register(&client->dev, indio_dev);
> > >  }
> > >
> > >  static const struct i2c_device_id adjd_s311_id[] = {
> > > @@ -306,7 +283,6 @@ static struct i2c_driver adjd_s311_driver = {
> > >               .name   = ADJD_S311_DRV_NAME,
> > >       },
> > >       .probe          = adjd_s311_probe,
> > > -     .remove         = adjd_s311_remove,
> > >       .id_table       = adjd_s311_id,
> > >  };
> > >  module_i2c_driver(adjd_s311_driver);  
> >  

