Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BA214C3A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGELzD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 07:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELzD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 07:55:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E04582073E;
        Sun,  5 Jul 2020 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593950102;
        bh=PySaQ9280ijbHQQr9O4QujlwIn0LScfCX/BaELoUy5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RqanaMKwwfzNgOIWn4Iepy9x2SyFj3yhUFFqac1wnsQwrkSSrs93uM3ro9SvymKVM
         KOYYo0liVxn8kMBMHRvI5n4R7Hjv2HU5r3INtnx0Q9Dmr43FVVgL9PEQm5xcdbqmP1
         D7kFG62KuI5hbDpEKBjkjTbyFco8RlRMnET4hMz4=
Date:   Sun, 5 Jul 2020 12:54:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 21/32] iio:pressure:ms5611 Fix buffer element alignment
Message-ID: <20200705125459.32fb5457@archlinux>
In-Reply-To: <20200607180313.GA95841@arch>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-22-jic23@kernel.org>
        <20200607180313.GA95841@arch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 20:03:13 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> On Sun, Jun 07, 2020 at 04:53:57PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > Here there is no data leak possibility so use an explicit structure
> > on the stack to ensure alignment and nice readable fashion.
> >
> > The forced alignment of ts isn't strictly necessary in this driver
> > as the padding will be correct anyway (there isn't any).  However
> > it is probably less fragile to have it there and it acts as
> > documentation of the requirement.
> >  
> 
> Looks good.
> Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
I'm picking up those patch in the series for which I have an ack to
cut down on the number we need to consider in the next version.

Thanks,

Jonathan

> 
> > Fixes: 713bbb4efb9dc ("iio: pressure: ms5611: Add triggered buffer support")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/pressure/ms5611_core.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> > index d451bb9dffc8..214b0d25f598 100644
> > --- a/drivers/iio/pressure/ms5611_core.c
> > +++ b/drivers/iio/pressure/ms5611_core.c
> > @@ -212,16 +212,21 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct ms5611_state *st = iio_priv(indio_dev);
> > -	s32 buf[4]; /* s32 (pressure) + s32 (temp) + 2 * s32 (timestamp) */
> > +	/* Ensure buffer elements are naturally aligned */
> > +	struct {
> > +		s32 channels[2];
> > +		s64 ts __aligned(8);
> > +	} scan;
> >  	int ret;
> >
> >  	mutex_lock(&st->lock);
> > -	ret = ms5611_read_temp_and_pressure(indio_dev, &buf[1], &buf[0]);
> > +	ret = ms5611_read_temp_and_pressure(indio_dev, &scan.channels[1],
> > +					    &scan.channels[0]);
> >  	mutex_unlock(&st->lock);
> >  	if (ret < 0)
> >  		goto err;
> >
> > -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> >  					   iio_get_time_ns(indio_dev));
> >
> >  err:
> > --
> > 2.26.2
> >  

