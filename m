Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE49F3B2
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 22:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfH0UDS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 16:03:18 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44712 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0UDS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2019 16:03:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2F1169E75AC;
        Tue, 27 Aug 2019 21:03:16 +0100 (BST)
Date:   Tue, 27 Aug 2019 21:03:14 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5380: fix incorrect assignment to val
Message-ID: <20190827210314.24887407@archlinux>
In-Reply-To: <20190818185544.66c32add@archlinux>
References: <20190815115846.21800-1-colin.king@canonical.com>
        <876a4d5190828619f75365863cc6bf2cfea4ffea.camel@analog.com>
        <20190818185544.66c32add@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Aug 2019 18:55:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 16 Aug 2019 06:16:26 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Thu, 2019-08-15 at 12:58 +0100, Colin King wrote:  
> > > [External]
> > >     
> > 
> > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> Applied to the fixes-togreg branch of iio.git.

I changed my mind on this because I've been a bit slow sending a pull
request and we are now at rc6.  Hence I've cherry picked it into
togreg so it'll go in during the next merge window and get backported
at that point.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> >   
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently the pointer val is being incorrectly incremented
> > > instead of the value pointed to by val. Fix this by adding
> > > in the missing * indirection operator.
> > > 
> > > Addresses-Coverity: ("Unused value")
> > > Fixes: c03f2c536818 ("staging:iio:dac: Add AD5380 driver")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/iio/dac/ad5380.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> > > index 4335214800d2..2ebe08326048 100644
> > > --- a/drivers/iio/dac/ad5380.c
> > > +++ b/drivers/iio/dac/ad5380.c
> > > @@ -220,7 +220,7 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
> > >  		if (ret)
> > >  			return ret;
> > >  		*val >>= chan->scan_type.shift;
> > > -		val -= (1 << chan->scan_type.realbits) / 2;
> > > +		*val -= (1 << chan->scan_type.realbits) / 2;
> > >  		return IIO_VAL_INT;
> > >  	case IIO_CHAN_INFO_SCALE:
> > >  		*val = 2 * st->vref;    
> 

