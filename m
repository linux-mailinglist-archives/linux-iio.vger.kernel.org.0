Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C023C1F0C26
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFGOz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 10:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgFGOz0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 10:55:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F5A2067B;
        Sun,  7 Jun 2020 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591541725;
        bh=87Ee+2E8sUCFLyonw7G8rzy7vhuBn0nAQinH2YYCPZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B4HdqzODeSXnxW2QQMfKVzP9EIIUo19kV8OMPT8lM0/jFjxlHZlgetuvxl0aV4PvH
         vcr1GAlhcqJDIvZnAjK9YtBDMM5sq2g7my8snQh69sRBgw2rsazBNcGnrZdKwVdJaH
         Nd3YATBeYAxB7Y9QuYLXP3Y8hMaj2KxR3R6YeJ9Q=
Date:   Sun, 7 Jun 2020 15:55:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 10/25] iio:humidity:hts221 Fix alignment and data leak
 issues
Message-ID: <20200607155521.71923310@archlinux>
In-Reply-To: <20200526075230.GA339643@localhost.localdomain>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-11-jic23@kernel.org>
        <20200526075230.GA339643@localhost.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 09:52:30 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data.
> > This data is allocated with kzalloc so no data can leak
> > apart from previous readings.
> > 
> > Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo device")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>  
> 
> Hi Jonathan,
> 
> I guess you can drop HTS221_DATA_SIZE now since it seems no longer used.
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

This patch suffers from the issue with padding on x86_32 that
Andy pointed out.  For v2 I've added explicit __aligned(8)

Also dropped HTS221_DATA_SIZE as you suggested.

I've kept the Ack. Shout if you'd rather I didn't!

Jonathan

> 
> > ---
> >  drivers/iio/humidity/hts221.h        | 5 +++++
> >  drivers/iio/humidity/hts221_buffer.c | 9 +++++----
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> > index 7c650df77556..6ad579ca9cef 100644
> > --- a/drivers/iio/humidity/hts221.h
> > +++ b/drivers/iio/humidity/hts221.h
> > @@ -39,6 +39,11 @@ struct hts221_hw {
> >  
> >  	bool enabled;
> >  	u8 odr;
> > +	/* Ensure natural alignment of timestamp */
> > +	struct {
> > +		__le16 channels[2];
> > +		s64 ts;
> > +	} scan;
> >  };
> >  
> >  extern const struct dev_pm_ops hts221_pm_ops;
> > diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> > index 21c6c160462d..59ede9860185 100644
> > --- a/drivers/iio/humidity/hts221_buffer.c
> > +++ b/drivers/iio/humidity/hts221_buffer.c
> > @@ -160,7 +160,6 @@ static const struct iio_buffer_setup_ops hts221_buffer_ops = {
> >  
> >  static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
> >  {
> > -	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *iio_dev = pf->indio_dev;
> >  	struct hts221_hw *hw = iio_priv(iio_dev);
> > @@ -170,18 +169,20 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
> >  	/* humidity data */
> >  	ch = &iio_dev->channels[HTS221_SENSOR_H];
> >  	err = regmap_bulk_read(hw->regmap, ch->address,
> > -			       buffer, HTS221_DATA_SIZE);
> > +			       &hw->scan.channels[0],
> > +			       sizeof(hw->scan.channels[0]));
> >  	if (err < 0)
> >  		goto out;
> >  
> >  	/* temperature data */
> >  	ch = &iio_dev->channels[HTS221_SENSOR_T];
> >  	err = regmap_bulk_read(hw->regmap, ch->address,
> > -			       buffer + HTS221_DATA_SIZE, HTS221_DATA_SIZE);
> > +			       &hw->scan.channels[1],
> > +			       sizeof(hw->scan.channels[1]));
> >  	if (err < 0)
> >  		goto out;
> >  
> > -	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
> > +	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
> >  					   iio_get_time_ns(iio_dev));
> >  
> >  out:
> > -- 
> > 2.26.2
> >   

