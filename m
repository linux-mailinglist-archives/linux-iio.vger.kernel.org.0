Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC926440A25
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhJ3QHH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 12:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhJ3QHH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 12:07:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4C5601FF;
        Sat, 30 Oct 2021 16:04:35 +0000 (UTC)
Date:   Sat, 30 Oct 2021 17:09:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Gwendal Grignou <gwendal@chromium.org>, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: Use .realbits to extend a small signed integer
Message-ID: <20211030170903.68b7e561@jic23-huawei>
In-Reply-To: <c71a2781-f5f6-0725-dbdf-aaa823883be1@metafoo.de>
References: <20211030111827.1494139-1-gwendal@chromium.org>
        <20211030111827.1494139-2-gwendal@chromium.org>
        <c71a2781-f5f6-0725-dbdf-aaa823883be1@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 Oct 2021 13:35:19 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/30/21 1:18 PM, Gwendal Grignou wrote:
> > When calling sign_extend32() on a channel, use its .realbit information
> > to limit the number of bits to process, instead of a constant.
> >
> > Changed only simple sign_extend32() calls, when .realbits was defined in
> > the same file. Use 'grep -r sign_extend32 $(grep -lr realbits drivers/iio/)'
> > to locate the files.
> >
> > Some files were not processed:
> > gyro/fxas21002c_core.c : function parameter changes needed.
> > health/max30102.c: Incomplete channel definition.
> > health/max30100.c  
> 
> I think this is good work, but it seems a bit out of place in this 
> series. I think it will be easier to get this reviewed and merged if it 
> is submitted independently. It might make sense to only have the sx9310 
> changes as part of this series and send the other ones as a separate patch.
> 
> What's also missing in the commit description is the motivation for 
> this. The generated code will be a bit more complex, so there needs to 
> be a good justification. E.g. having a single source of truth for this 
> data and avoiding accidental mistakes.
> 
> The patch also uses `shift` were applicable, which is not mentioned in 
> the commit dscription.

Be careful.  I have seen devices (with FIFOs) where the realbits doesn't
necessarily match with a separate read path used for polled reads.

It is an option for the sca3000 for example but that's carrying a hack where
ignore that and rely on some coincidental data alignment to pretend realbits
is 13 when it's actually 11.

Still in general it's a reasonable change but agree with Lars, separate series
please.
 
> 
> 
> > [...]
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> > index 1eb9e7b29e050..355854f0f59d2 100644
> > --- a/drivers/iio/pressure/mpl3115.c
> > +++ b/drivers/iio/pressure/mpl3115.c
> > @@ -74,7 +74,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
> >   			    int *val, int *val2, long mask)
> >   {
> >   	struct mpl3115_data *data = iio_priv(indio_dev);
> > -	__be32 tmp = 0;
> > +	__be16 tmp = 0;
> >   	int ret;  
> The be32 to be16 change might warrant its own patch. This is definitely 
> changing the behavior of the driver. And I don't think it is correct the 
> way its done. For the pressure data it is reading 3 bytes, which will 
> cause a stack overflow.
> >   
> >   	switch (mask) {
> > @@ -96,7 +96,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
> >   			mutex_unlock(&data->lock);
> >   			if (ret < 0)
> >   				break;
> > -			*val = be32_to_cpu(tmp) >> 12;
> > +			*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> >   			ret = IIO_VAL_INT;
> >   			break;
> >   		case IIO_TEMP: /* in 0.0625 celsius / LSB */
> > @@ -111,7 +111,8 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
> >   			mutex_unlock(&data->lock);
> >   			if (ret < 0)
> >   				break;
> > -			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
> > +			*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
> > +					     chan->scan_type.realbits - 1);
> >   			ret = IIO_VAL_INT;
> >   			break;
> >   		default:  
> 

