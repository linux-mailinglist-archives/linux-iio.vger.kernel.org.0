Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534381D7EB0
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERQhf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 12:37:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbgERQhf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 May 2020 12:37:35 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 45C82CE65A8BA7712C08;
        Mon, 18 May 2020 17:37:34 +0100 (IST)
Received: from localhost (10.47.85.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 18 May
 2020 17:37:33 +0100
Date:   Mon, 18 May 2020 17:37:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 02/11] iio:accel:mma8452: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200518173707.00004d5d@Huawei.com>
In-Reply-To: <170d718b-7ee4-ac08-c083-830c06c59f65@metafoo.de>
References: <20200517173000.220819-1-jic23@kernel.org>
        <20200517173000.220819-3-jic23@kernel.org>
        <170d718b-7ee4-ac08-c083-830c06c59f65@metafoo.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.42]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 20:57:26 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 5/17/20 7:29 PM, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses a 16 byte u8 array on the stack.  As Lars also noted
> > this anti pattern can involve a leak of data to userspace and that
> > indeed can happen here.  We close both issues by moving to
> > a suitable structure in the iio_priv() data with alignment
> > ensured by use of an explicit c structure.  This data is allocated
> > with kzalloc so no data can leak appart from previous readings.
> >
> > Fixes: c7eeea93ac60 ("iio: Add Freescale MMA8452Q 3-axis accelerometer driver")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > ---
> >   drivers/iio/accel/mma8452.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 00e100fc845a..704867ffda7a 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -110,6 +110,12 @@ struct mma8452_data {
> >   	int sleep_val;
> >   	struct regulator *vdd_reg;
> >   	struct regulator *vddio_reg;
> > +
> > +	/* Ensure correct alignment of time stamp when present */
> > +	struct {
> > +		__be16 channels[3];
> > +		s64 ts;
> > +	} buffer;  
> 
> 
> I feel we should have a macro for this.
> 
> DECLARE_IIO_BUFFER_WITH_TIMESTAMP(buffer, __be16, 3);
> 
> The name is maybe a bit too long.

It runs into the issue we had with the afe4403 and other devices
that are happy to do very different numbers of enabled channels.
Such a macro would imply that the timestamp will always be written
at a fixed location, which isn't true.  So far, I've made sure
we didn't do anything like this unless the number of channels was
small enough there was only one possible location for the timestamp
(now we insist that at least one channel is enabled to start a buffer).

Maybe we just deal with that with some suitable documentation though.

> 
> And potentially also DECLARE_IIO_BUFFER_WITH_TIMESTAMP_ON_STACK() which 
> initializes it to zero.

The thing there is we should only need to initialize it to zero if there
are holes.  If we always write data up to the 8 byte boundary
it won't matter if the timestamp is disabled or not, I don't think we
will get a data leak.  We can't even do some magic in the call to
identify if there are potential holes because we can't tell if all
the channels will be written or not...

I'm not totally convinced hiding what is going on behind a macro
is a good idea.  Sometimes bashing people over the head with the
fact there are some non obvious requirements is a good idea.

Not sure...

J


> 
> >   };
> >   
> >    /**
> > @@ -1091,14 +1097,13 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
> >   	struct iio_poll_func *pf = p;
> >   	struct iio_dev *indio_dev = pf->indio_dev;
> >   	struct mma8452_data *data = iio_priv(indio_dev);
> > -	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
> >   	int ret;
> >   
> > -	ret = mma8452_read(data, (__be16 *)buffer);
> > +	ret = mma8452_read(data, data->buffer.channels);
> >   	if (ret < 0)
> >   		goto done;
> >   
> > -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >   					   iio_get_time_ns(indio_dev));
> >   
> >   done:  
> 
> 


