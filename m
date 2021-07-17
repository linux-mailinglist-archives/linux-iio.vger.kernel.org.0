Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F923CC49F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhGQQ42 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 12:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhGQQ42 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 12:56:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FA26109E;
        Sat, 17 Jul 2021 16:53:28 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:55:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Liam Beguin" <liambeguin@gmail.com>
Cc:     "Peter Rosin" <peda@axentia.se>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <20210717175551.20265ac4@jic23-huawei>
In-Reply-To: <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
        <20210715031215.1534938-6-liambeguin@gmail.com>
        <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
        <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Jul 2021 15:18:33 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Thu Jul 15, 2021 at 5:48 AM EDT, Peter Rosin wrote:
> >
> > On 2021-07-15 05:12, Liam Beguin wrote:  
> > > From: Liam Beguin <lvb@xiphos.com>
> > > 
> > > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > > Add support for these to allow using the iio-rescaler with them.
> > > 
> > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > ---
> > >  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > > index 4c3cfd4d5181..a2b220b5ba86 100644
> > > --- a/drivers/iio/afe/iio-rescale.c
> > > +++ b/drivers/iio/afe/iio-rescale.c
> > > @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
> > >  			do_div(tmp, 1000000000LL);
> > >  			*val = tmp;
> > >  			return ret;
> > > +		case IIO_VAL_INT_PLUS_NANO:
> > > +			tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> > > +			do_div(tmp, rescale->denominator);
> > > +
> > > +			*val = div_s64(tmp, 1000000000LL);
> > > +			*val2 = tmp - *val * 1000000000LL;
> > > +			return ret;  
> >
> > This is too simplistic and prone to overflow. We need something like
> > this
> > (untested)
> >
> > tmp = (s64)*val * rescale->numerator;
> > rem = do_div(tmp, rescale->denominator);
> > *val = tmp;
> > tmp = ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
> > do_div(tmp, rescale->denominator);
> > *val2 = tmp;
> >
> > Still not very safe with numerator and denominator both "large", but
> > much
> > better. And then we need normalizing the fraction part after the above,
> > of
> > course.
> >  
> 
> Understood, I'll test that.
> 
> > And, of course, I'm not sure what *val == -1 and *val2 == 500000000
> > really
> > means. Is that -1.5 or -0.5? The above may very well need adjusting for
> > negative values...
> >  
> 
> I would've assumed the correct answer is -1 + 500000000e-9 = -0.5
> but adding a test case to iio-test-format.c seems to return -1.5...

No. -1.5 is as intended, though the IIO_VAL_PLUS_MICRO is rather confusing
naming :( We should perhaps add more documentation for that.  Signs were
always a bit of a pain with this two integer scheme for fixed point.

The intent is to have moderately readable look up tables with the problem that
we don't have a signed 0 available.  Meh, maybe this decision a long time
back wasn't a the right one, but it may be a pain to change now as too many
drivers to check!

1, 0000000  == 1
0, 5000000  == 0.5
0, 0000000  == 0
0, -5000000 == -0.5
-1, 5000000 == -1.5


> 
> I believe that's a bug but we can work around if for now by moving the
> integer part of *val2 to *val.

Yup.  Fiddly corner cases..

Jonathan

> 
> Liam
> 
> > Cheers,
> > Peter
> >  
> > > +		case IIO_VAL_INT_PLUS_MICRO:
> > > +			tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> > > +			do_div(tmp, rescale->denominator);
> > > +
> > > +			*val = div_s64(tmp, 1000000LL);
> > > +			*val2 = tmp - *val * 1000000LL;
> > > +			return ret;
> > >  		default:
> > > +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> > >  			return -EOPNOTSUPP;
> > >  		}
> > >  	default:
> > >   
> 

