Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813DD1F0BF4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFGOhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 10:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgFGOhm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 10:37:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8376C20663;
        Sun,  7 Jun 2020 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591540661;
        bh=XBVsX5XN9Ux6WFn3vUGBICg/ARMOHduqQ+t3TGgaZMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L3Be72jaKyoCJSjVPA6TMmvOS2kKvapKWAljG6Iuii7MPuqoHXlbScLNv9J9QoGYU
         BZn+EJNah+QiX9aMyuEw/jMFmfNTF7y4CSnYHGUEX1cC863P41hqT624FZKUBRpLsM
         syOgSM7kikYwsNLlQBY8hiMGXGzaOI1QuxHpOYCw=
Date:   Sun, 7 Jun 2020 15:37:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 04/25] iio:light:st_uvis25 Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200607153737.499cfa8c@archlinux>
In-Reply-To: <20200526175326.00007712@Huawei.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-5-jic23@kernel.org>
        <20200526075505.GB339643@localhost.localdomain>
        <20200526175326.00007712@Huawei.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 17:53:26 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 26 May 2020 09:55:05 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > One of a class of bugs pointed out by Lars in a recent review.
> > > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > > this driver which uses an array of smaller elements on the stack.
> > > As Lars also noted this anti pattern can involve a leak of data to
> > > userspace and that indeed can happen here.  We close both issues by
> > > moving to a suitable structure in the iio_priv()
> > > 
> > > This data is allocated with kzalloc so no data can leak apart
> > > from previous readings.
> > > 
> > > Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
> > > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>    
> > 
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> 
> Unfortunately this is wrong (as Andy Schevchenko pointed out in one
> of the other patches).  On x86_32 s64 is only aligned to 4 bytes
> so the size of the structure will end up too small for the IIO alignment
> rules.
> 
> There will be a v2 once we've figure out the best, consistent solution.

Given the change is fairly small I've kept acks etc from V1. Hopefully
no one minds that.

Jonathan

> 
> Sorry about that!
> 
> Jonathan
> 
> >   
> > > ---
> > >  drivers/iio/light/st_uvis25.h      | 5 +++++
> > >  drivers/iio/light/st_uvis25_core.c | 6 +++---
> > >  2 files changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
> > > index 78bc56aad129..f7027e4c4493 100644
> > > --- a/drivers/iio/light/st_uvis25.h
> > > +++ b/drivers/iio/light/st_uvis25.h
> > > @@ -27,6 +27,11 @@ struct st_uvis25_hw {
> > >  	struct iio_trigger *trig;
> > >  	bool enabled;
> > >  	int irq;
> > > +	/* Ensure timestamp is naturally aligned */
> > > +	struct {
> > > +		u8 chan;
> > > +		s64 ts;
> > > +	} scan;
> > >  };
> > >  
> > >  extern const struct dev_pm_ops st_uvis25_pm_ops;
> > > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> > > index d262c254b895..fe1f2dc970c7 100644
> > > --- a/drivers/iio/light/st_uvis25_core.c
> > > +++ b/drivers/iio/light/st_uvis25_core.c
> > > @@ -234,17 +234,17 @@ static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
> > >  
> > >  static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
> > >  {
> > > -	u8 buffer[ALIGN(sizeof(u8), sizeof(s64)) + sizeof(s64)];
> > >  	struct iio_poll_func *pf = p;
> > >  	struct iio_dev *iio_dev = pf->indio_dev;
> > >  	struct st_uvis25_hw *hw = iio_priv(iio_dev);
> > >  	int err;
> > >  
> > > -	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
> > > +	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR,
> > > +			  (unsigned int *)&hw->scan.chan);
> > >  	if (err < 0)
> > >  		goto out;
> > >  
> > > -	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
> > > +	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
> > >  					   iio_get_time_ns(iio_dev));
> > >  
> > >  out:
> > > -- 
> > > 2.26.2
> > >     
> >   
> 
> 

