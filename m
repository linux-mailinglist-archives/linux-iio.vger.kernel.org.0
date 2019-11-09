Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77111F5EF0
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfKIMRR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfKIMRQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:17:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DE521848;
        Sat,  9 Nov 2019 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573301836;
        bh=MyfG5kWnkq5B8jVbUgHIRNS/JsSxgSCS96NrjG+4hoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=omcwhicxAoKaF0OgDAVf7NUoGmK9iIstwkIUTvfJWLU6K5E+nIuPrgjRPcvimDO67
         WVBFLJVJibLw0hytvTVyt8ssPSlKvLHZp4K16rSmUwRet7yslULjP8Lz0hmwU3M9QT
         gFbbfYOx8hDtt5O2rF9bMbEeoQUZ8deMM5T+jUss=
Date:   Sat, 9 Nov 2019 12:17:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "raveendra.padasalagi@broadcom.com" 
        <raveendra.padasalagi@broadcom.com>
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: drop a stray semicolon
Message-ID: <20191109121710.7389b110@archlinux>
In-Reply-To: <5f786ddb2265a0a11a046ab2750ca471f0fc893e.camel@analog.com>
References: <20191013121856.1782707-1-jic23@kernel.org>
        <5f786ddb2265a0a11a046ab2750ca471f0fc893e.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:15:30 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 13:18 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found by coccinelle / coccicheck
> > 
> > CHECK   drivers/iio/adc/bcm_iproc_adc.c
> > drivers/iio/adc/bcm_iproc_adc.c:311:3-4: Unneeded semicolon
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied thanks.

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> > ---
> >  drivers/iio/adc/bcm_iproc_adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/bcm_iproc_adc.c
> > b/drivers/iio/adc/bcm_iproc_adc.c
> > index 646ebdc0a8b4..5e396104ac86 100644
> > --- a/drivers/iio/adc/bcm_iproc_adc.c
> > +++ b/drivers/iio/adc/bcm_iproc_adc.c
> > @@ -308,7 +308,7 @@ static int iproc_adc_do_read(struct iio_dev
> > *indio_dev,
> >  				"IntMask set failed. Read will likely
> > fail.");
> >  			read_len = -EIO;
> >  			goto adc_err;
> > -		};
> > +		}
> >  	}
> >  	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
> >    

