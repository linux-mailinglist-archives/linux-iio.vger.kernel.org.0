Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B04189F6
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhIZPb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 26 Sep 2021 11:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhIZPb1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 11:31:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7239B60E08;
        Sun, 26 Sep 2021 15:29:49 +0000 (UTC)
Date:   Sun, 26 Sep 2021 16:33:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: Avoid using irq_work
Message-ID: <20210926163338.1170f73a@jic23-huawei>
In-Reply-To: <3974817ea942f616b77450914aa23b181b062d87.camel@redhat.com>
References: <20210624100046.1037159-1-nsaenzju@redhat.com>
        <CAHp75VcG-0L+qG5JirWH21bnpVwRv_wfjM6Sfd2pJrq4-OqJ0Q@mail.gmail.com>
        <3974817ea942f616b77450914aa23b181b062d87.camel@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 13:13:47 +0200
Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:

> Hi Andy, thanks for the review.
> 
> On Thu, 2021-06-24 at 13:39 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 24, 2021 at 1:01 PM Nicolas Saenz Julienne
> > <nsaenzju@redhat.com> wrote:  
> > > 
> > > The atlas sensor driver currently registers a threaded IRQ handler whose
> > > sole responsibility is to trigger an irq_work which will in turn run
> > > iio_trigger_poll() in IRQ context.
> > > 
> > > This seems overkill given the fact that there already was a opportunity  
> > 
> > an opportunity  
> 
> Thanks, noted.
> 
> > > @@ -474,7 +465,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
> > >         struct iio_dev *indio_dev = private;
> > >         struct atlas_data *data = iio_priv(indio_dev);
> > > 
> > > -       irq_work_queue(&data->work);
> > > +       iio_trigger_poll(data->trig);  
> > 
> > Have you considered dropping atlas_interrupt_trigger_ops() altogether?  
> 
> Not really, but it makes sense as a separate patch. I'll take care of it.
> 
> >   
> > >         if (client->irq > 0) {
> > >                 /* interrupt pin toggles on new conversion */
> > >                 ret = devm_request_threaded_irq(&client->dev, client->irq,  
> >   
> > > -                               NULL, atlas_interrupt_handler,
> > > +                               atlas_interrupt_handler, NULL,  
> > 
> > So, you move it from threaded IRQ to be a hard IRQ handler (we have a
> > separate call for this).  
> 
> Noted.
> 
> > Can you guarantee that handling of those events will be fast enough?  
> 
> Do you mean the events triggered in iio_trigger_poll()? If so the amount of
> time spent in IRQ context is going to be the same regardless of whether it's
> handled through atlas' IRQ or later in irq_work IPI (or softirq context on some
> weird platforms).
> 

Hi Nicolas, Andy, Matt,

Just been checking patchwork for IIO and noted that this one is still outstanding.

My reading of above is that we kind of got to a conclusion - though I'd like
Matt to sanity check the patch (and maybe test it if he still has hardware for
this?)

We have a generic form of this handler that may let you drop the atlas_interrupt_handler()
function entirely iio_trigger_generic_data_rdy_poll().

https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-trigger.c#L182

Thanks,

Jonathan


