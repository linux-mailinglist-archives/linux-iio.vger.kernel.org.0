Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5924421C8E7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgGLLRE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 07:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGLLRD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 07:17:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42DF22070B;
        Sun, 12 Jul 2020 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594552623;
        bh=FSu3XfSof6fYL9fVJl6MPhlfCQt1PNdefdPCtBXewlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h3oK9is4R7FsQnK9cutzQeCV1hdLg/q/Ie7UVDzbSIIv9y4Y8q9LNAeGtjjASHK3T
         RsajjowAw1CzUGc0NCF8wjyNHh0yPHHaOj1f3/OUaR1qnqPqgchnNd+SoV1WebBaJT
         Q1tx3feXbXAxD1f6nETuKC2/NAYoAj5g6TgoA6eA=
Date:   Sun, 12 Jul 2020 12:16:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "charles.stanhope@gmail.com" <charles.stanhope@gmail.com>
Subject: Re: [PATCH 1/3] iio: dac: ad5592r: fix unbalanced mutex unlocks in
 ad5592r_read_raw()
Message-ID: <20200712121659.1792a7dd@archlinux>
In-Reply-To: <872263d31269c590c34b46ccb6517ec26a330c18.camel@analog.com>
References: <20200706110259.23947-1-alexandru.ardelean@analog.com>
        <872263d31269c590c34b46ccb6517ec26a330c18.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Jul 2020 16:36:09 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2020-07-06 at 14:02 +0300, Alexandru Ardelean wrote:
> > [External]
> > 
> > There are 2 exit paths where the lock isn't held, but try to unlock the
> > mutex when exiting. In these places we should just return from the
> > function.
> > 
> > A neater approach would be to cleanup the ad5592r_read_raw(), but that
> > would make this patch more difficult to backport to stable versions.
> >   
> 
> I was a bit too hasty with this.
> Apologies.
> I'd like to add a tag here.
> 
> Reported-by: Charles Stanhope <charles.stanhope@gmail.com>
Applied to the fixes-togreg branch of iio.git.

I'll have to wait for this to trickle through to the togreg branch though
before I can do anything with the next two patches.  As ever, if I've
clearly lost them give me a poke!

Jonathan

> 
> > Fixes 56ca9db862bf3: ("iio: dac: Add support for the AD5592R/AD5593R
> > ADCs/DACs")
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/dac/ad5592r-base.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-
> > base.c
> > index 5c4e5ff70380..cc4875660a69 100644
> > --- a/drivers/iio/dac/ad5592r-base.c
> > +++ b/drivers/iio/dac/ad5592r-base.c
> > @@ -413,7 +413,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
> >  			s64 tmp = *val * (3767897513LL / 25LL);
> >  			*val = div_s64_rem(tmp, 1000000000LL, val2);
> >  
> > -			ret = IIO_VAL_INT_PLUS_MICRO;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> >  		} else {
> >  			int mult;
> >  
> > @@ -444,7 +444,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
> >  		ret =  IIO_VAL_INT;
> >  		break;
> >  	default:
> > -		ret = -EINVAL;
> > +		return -EINVAL;
> >  	}
> >  
> >  unlock:  

