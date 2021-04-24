Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3836A0C6
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhDXLHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 07:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237217AbhDXLHw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:07:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9106124B;
        Sat, 24 Apr 2021 11:07:12 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:07:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Nuno Sa <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/9] iio: adis_buffer: check return value on page
 change
Message-ID: <20210424120753.5a2ff1bd@jic23-huawei>
In-Reply-To: <CA+U=Dsp6Rc6j5cwN77F1s=inBy3Cj+L=zwSm2AchZdmugAe1HQ@mail.gmail.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-5-nuno.sa@analog.com>
        <CA+U=Dsp6Rc6j5cwN77F1s=inBy3Cj+L=zwSm2AchZdmugAe1HQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 10:14:48 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
> >
> > On the trigger handler, we might need to change the device page. Hence,
> > we should check the return value from 'spi_write()' and act accordingly.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> > index 175af154e443..0ae551a748eb 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -134,7 +134,12 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
> >                 if (adis->current_page != 0) {
> >                         adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
> >                         adis->tx[1] = 0;
> > -                       spi_write(adis->spi, adis->tx, 2);
> > +                       ret = spi_write(adis->spi, adis->tx, 2);
> > +                       if (ret) {
> > +                               dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
> > +                               mutex_unlock(&adis->state_lock);
> > +                               goto irq_done;
> > +                       }
> >                 }
> >         }
> >
> > @@ -151,6 +156,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
> >         iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> >                 pf->timestamp);
> >
> > +irq_done:
> >         iio_trigger_notify_done(indio_dev->trig);
> >
> >         return IRQ_HANDLED;
> > --
> > 2.31.1
> >  

