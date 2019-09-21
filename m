Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3ACB9F4D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfIUSLj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 14:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfIUSLj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 14:11:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489FE2080F;
        Sat, 21 Sep 2019 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089498;
        bh=+j2NftTgVB/uEJoBJMJYrqT3F+1ZbejcQjaaV0Bb4EM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B6i+hZbYCOt8hATSgKEzQiiJJi2hhGFxf5t5XRnZPn0U4b7R7ni4qtoFnXK6Ybexd
         g3buqih/uEPQZP6b9rQ9jKzWQhuM2Lki35HBBhNL6ve222tlO7DEcY8xtqfSyLRBhk
         0iQk9gJJMUdBHyNjKBvvmGMMZI7X52+gLgt43OH0=
Date:   Sat, 21 Sep 2019 19:11:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "navid.emamdoost@gmail.com" <navid.emamdoost@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: imu: adis16400: release allocated memory on
 failure
Message-ID: <20190921191133.62f12b65@archlinux>
In-Reply-To: <d4c21c74d88e542771818720e6270e4d6141b686.camel@analog.com>
References: <84e2832b52cc88665ff071942c1545b83eeb5602.camel@analog.com>
        <20190919155003.2207-1-navid.emamdoost@gmail.com>
        <d4c21c74d88e542771818720e6270e4d6141b686.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 06:46:37 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2019-09-19 at 10:50 -0500, Navid Emamdoost wrote:
> > In adis_update_scan_mode, if allocation for adis->buffer fails,
> > previously allocated adis->xfer needs to be released.
> > 
> > v2: added adis->xfer = NULL to avoid any potential double free. 

Version changes go below the --- so they don't get recorded in the
git tree log when it's applied.

 
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git. Thanks,

Jonathan

> 
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/adis_buffer.c
> > b/drivers/iio/imu/adis_buffer.c
> > index 9ac8356d9a95..f446ff497809 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -78,8 +78,11 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
> >  		return -ENOMEM;
> >  
> >  	adis->buffer = kcalloc(indio_dev->scan_bytes, 2, GFP_KERNEL);
> > -	if (!adis->buffer)
> > +	if (!adis->buffer) {
> > +		kfree(adis->xfer);
> > +		adis->xfer = NULL;
> >  		return -ENOMEM;
> > +	}
> >  
> >  	rx = adis->buffer;
> >  	tx = rx + scan_count;  

