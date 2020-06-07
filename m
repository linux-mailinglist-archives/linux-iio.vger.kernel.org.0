Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896481F0C24
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgFGOv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 10:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgFGOv3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 10:51:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A426E2067B;
        Sun,  7 Jun 2020 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591541488;
        bh=8SxteX4XQVXytBfKNR93s2bfYO4m0se0LPkOaE8Xxsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bukEQ7f6UIaceB+fmE9SvKw1/a3luHuk6WD4uWuxjBImzxXNJliw2I+DhITD1YcC3
         2tuHgQ+kxuWBbTG5HnL/1AZs6NybrI0t96BksMCZazOt1RvbcrT4uO4NWF025h8qAD
         Z9go8obauxwf4QK2MJDMG2hK+g6n5FkwKxLbdYpM=
Date:   Sun, 7 Jun 2020 15:51:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [PATCH 09/25] iio:humidity:hdc100x Fix alignment and data leak
 issues
Message-ID: <20200607155124.099d82d2@archlinux>
In-Reply-To: <CAJCx=g=cCucvub6-kPq5+tGu5M+J_LqJDwmDCoHj-aLUGQk6kQ@mail.gmail.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-10-jic23@kernel.org>
        <CAJCx=g=cCucvub6-kPq5+tGu5M+J_LqJDwmDCoHj-aLUGQk6kQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 12:31:11 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Mon, May 25, 2020 at 10:09 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data.
> > This data is allocated with kzalloc so no data can leak apart
> > from previous readings.
> >  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

This is one of the cases that Andy pointed out will be inconsistent
on x86_32.  That only requires 4 byte alignment for the s64 so here
we end up with the wrong amount of padding.  I've fixed that up
in v2 with s64 ts __aligned(8);

I've assumed the ack still stands given this is a fairly obscure corner.

Thanks,

Jonathan

> 
> > Fixes: 16bf793f86b2 ("iio: humidity: hdc100x: add triggered buffer support for HDC100X")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alison Schofield <amsfield22@gmail.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index 7ecd2ffa3132..fd825e281d4f 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -38,6 +38,11 @@ struct hdc100x_data {
> >
> >         /* integration time of the sensor */
> >         int adc_int_us[2];
> > +       /* Ensure natural alignment of timestamp */
> > +       struct {
> > +               __be16 channels[2];
> > +               s64 ts;
> > +       } scan;
> >  };
> >
> >  /* integration time in us */
> > @@ -322,7 +327,6 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
> >         struct i2c_client *client = data->client;
> >         int delay = data->adc_int_us[0] + data->adc_int_us[1];
> >         int ret;
> > -       s16 buf[8];  /* 2x s16 + padding + 8 byte timestamp */
> >
> >         /* dual read starts at temp register */
> >         mutex_lock(&data->lock);
> > @@ -333,13 +337,13 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
> >         }
> >         usleep_range(delay, delay + 1000);
> >
> > -       ret = i2c_master_recv(client, (u8 *)buf, 4);
> > +       ret = i2c_master_recv(client, (u8 *)data->scan.channels, 4);
> >         if (ret < 0) {
> >                 dev_err(&client->dev, "cannot read sensor data\n");
> >                 goto err;
> >         }
> >
> > -       iio_push_to_buffers_with_timestamp(indio_dev, buf,
> > +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> >                                            iio_get_time_ns(indio_dev));
> >  err:
> >         mutex_unlock(&data->lock);
> > --
> > 2.26.2
> >  

