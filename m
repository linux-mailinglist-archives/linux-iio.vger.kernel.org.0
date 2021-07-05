Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC313BB953
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhGEIct (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:32:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3353 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhGEIcr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:32:47 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJJZR218rz6G8Bq;
        Mon,  5 Jul 2021 16:22:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 10:30:08 +0200
Received: from localhost (10.47.85.51) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 09:30:07 +0100
Date:   Mon, 5 Jul 2021 09:29:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <peda@axentia.se>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 04/10] iio: afe: rescale: reduce risk of integer
 overflow
Message-ID: <20210705092949.000060b1@Huawei.com>
In-Reply-To: <CCKX5239AEWI.3T3JF9PXHIESQ@shaak>
References: <20210701010034.303088-1-liambeguin@gmail.com>
        <20210701010034.303088-5-liambeguin@gmail.com>
        <20210704173639.622371bf@jic23-huawei>
        <CCKX5239AEWI.3T3JF9PXHIESQ@shaak>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.51]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 05 Jul 2021 00:23:59 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Sun Jul 4, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> > On Wed, 30 Jun 2021 21:00:28 -0400
> > Liam Beguin <liambeguin@gmail.com> wrote:
> >  
> > > From: Liam Beguin <lvb@xiphos.com>
> > > 
> > > Reduce the risk of integer overflow by doing the scale calculation with
> > > 64bit integers and looking for a Greatest Common Divider for both parts
> > > of the fractional value.
> > > 
> > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > ---
> > >  drivers/iio/afe/iio-rescale.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > > index 774eb3044edd..98bcb5d418d6 100644
> > > --- a/drivers/iio/afe/iio-rescale.c
> > > +++ b/drivers/iio/afe/iio-rescale.c
> > > @@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
> > >  			    int *val, int *val2, long mask)
> > >  {
> > >  	struct rescale *rescale = iio_priv(indio_dev);
> > > -	unsigned long long tmp;
> > > +	s64 tmp, tmp2;
> > > +	u32 factor;
> > >  	int ret;
> > >  
> > >  	switch (mask) {
> > > @@ -67,8 +68,11 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
> > >  		}
> > >  		switch (ret) {
> > >  		case IIO_VAL_FRACTIONAL:
> > > -			*val *= rescale->numerator;
> > > -			*val2 *= rescale->denominator;
> > > +			tmp = (s64)*val * rescale->numerator;
> > > +			tmp2 = (s64)*val2 * rescale->denominator;
> > > +			factor = gcd(tmp, tmp2);  
> >
> > Hmm. I wonder if there are cases where this doesn't work and we end up
> > truncating because the gcd is say 1. If all of val, val2,
> > rescale->numerator,
> > rescale->denominator are primes and the rescale values are moderately
> > large
> > then that might happen. We probably need a fallback position. Perhaps
> > check tmp / factor and temp2/factor will fit in an int. If not, shift
> > them until
> > they do even if we have to dump some precision to do so.
> >  
> 
> I see what you mean. If we want to do that I guess it would also apply
> to other areas of the driver.

Certainly possible.  It's a bit obscure so may not have occurred to anyone
on previous reviews :(

> 
> > This stuff is getting fiddly enough we might want to figure out some
> > self tests
> > that exercise the various cases.
> >  
> 
> I never implemented kernel self tests before, I guess it should follow
> the example of drivers/iio/test/iio-test-format.c?
> 
> Would you be okay to add this in a follow up series?

Yes, that's fine.

> 
> > > +			*val = tmp / factor;
> > > +			*val2 = tmp2 / factor;  
> >
> > This is doing 64 bit numbers divided by 32 bit ones. Doesn't that
> > require
> > use of do_div() etc on 32 bit platforms?
> >  
> 
> Apologies for that mistake, will fix.
> 
> > >  			return ret;
> > >  		case IIO_VAL_INT:
> > >  			*val *= rescale->numerator;  
> 

