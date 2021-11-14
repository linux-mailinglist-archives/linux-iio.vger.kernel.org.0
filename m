Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422444F8E6
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhKNP7N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 14 Nov 2021 10:59:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhKNP7L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 10:59:11 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6E560EE2;
        Sun, 14 Nov 2021 15:56:14 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:01:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kister Genesis Jimenez <kister.jimenez@analog.com>
Subject: Re: [PATCH v2] iio: adxrs290: fix data signedness
Message-ID: <20211114160101.5a102715@jic23-huawei>
In-Reply-To: <20211112162346.20bdccd6@jic23-huawei>
References: <20211111143411.187090-1-nuno.sa@analog.com>
        <20211112162346.20bdccd6@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Nov 2021 16:23:46 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 11 Nov 2021 15:34:11 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > From: Kister Genesis Jimenez <kister.jimenez@analog.com>
> > 
> > Properly sign-extend the rate and temperature data.
> > 
> > Fixes: 2c8920fff1457 ("iio: gyro: Add driver support for ADXRS290")
> > Signed-off-by: KJimenez <kister.jimenez@analog.com>  
> 
> Full name needed in Signed-off-by: and should match the From above.
> 
> Otherwise this looks fine to me.

By which I mean send a v3 with that fixed.  I don't like messing
with tags whilst applying because there are legal implications etc of
messing with DCO related parts.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> > changes in v2:
> >  * removed redundant temp & 0xFFF.
> > 
> >  drivers/iio/gyro/adxrs290.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> > index 3e0734ddafe3..600e9725da78 100644
> > --- a/drivers/iio/gyro/adxrs290.c
> > +++ b/drivers/iio/gyro/adxrs290.c
> > @@ -7,6 +7,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > @@ -124,7 +125,7 @@ static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *
> >  		goto err_unlock;
> >  	}
> >  
> > -	*val = temp;
> > +	*val = sign_extend32(temp, 15);
> >  
> >  err_unlock:
> >  	mutex_unlock(&st->lock);
> > @@ -146,7 +147,7 @@ static int adxrs290_get_temp_data(struct iio_dev *indio_dev, int *val)
> >  	}
> >  
> >  	/* extract lower 12 bits temperature reading */
> > -	*val = temp & 0x0FFF;
> > +	*val = sign_extend32(temp, 11);
> >  
> >  err_unlock:
> >  	mutex_unlock(&st->lock);  
> 

