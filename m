Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F736A0CC
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhDXLNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 07:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhDXLN3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:13:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F586146B;
        Sat, 24 Apr 2021 11:12:50 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:13:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Nuno Sa <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/9] iio: adis_buffer: don't push data to buffers on
 failure
Message-ID: <20210424121331.5dd63a22@jic23-huawei>
In-Reply-To: <CA+U=Dsq-8bggBJtTi5dkq9LrKpweyCSzZ4nisuDJ3doPu37FTg@mail.gmail.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-6-nuno.sa@analog.com>
        <CA+U=Dsq-8bggBJtTi5dkq9LrKpweyCSzZ4nisuDJ3doPu37FTg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 10:28:08 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
> >
> > There's no point in pushing data to IIO buffers in case 'spi_sync()'
> > fails.
> >  
> 
> Overall, this feels like it's adding some duplication.
> However, short-term I'm not seeing a considerably better way to do this.
> Maybe, this would require some refactoring of the
> adis_trigger_handler() to handle the paging logic a bit more
> elegantly.
> But that's a broader change.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

In here the read failed, but I think the switch to current_page = 0
succeeded (as was before this spi_sync).  So should we not
be setting current_page = 0 even int his error path?

With that in mind can we just move the if (ret) check past
the existing unlock? + does it make sense to just move the
setting of current_page = 0 up to where it's actually set?


> 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> > index 0ae551a748eb..a29d22f657ce 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -144,9 +144,12 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
> >         }
> >
> >         ret = spi_sync(adis->spi, &adis->msg);
> > -       if (ret)
> > +       if (ret) {
> >                 dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
> > -
> > +               if (adis->data->has_paging)
> > +                       mutex_unlock(&adis->state_lock);
> > +               goto irq_done;
> > +       }
> >
> >         if (adis->data->has_paging) {
> >                 adis->current_page = 0;
> > --
> > 2.31.1
> >  

