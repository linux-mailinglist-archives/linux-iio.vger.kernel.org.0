Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57913B9F57
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfIUSPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 14:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbfIUSPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C3D2196E;
        Sat, 21 Sep 2019 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089733;
        bh=2I/lXwkOsDHIBlp5SP8bOsaaK9/9GpXDgRx0ZCTnUeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LKhOhL298udbPmTIRj+3TyLSzDTQ4Hynw0/vM4rSjPxQzDGTiBddDcMT20wGwINlK
         MQf4TvtopzRh9p2xukOyNzz77A824siYeE6v9cBOgVYhucglDh9kit2NiM8X6fimhg
         A4zB75B9QbB/sO+YZmX0ghqmhrRANXPj6f0EzYcc=
Date:   Sat, 21 Sep 2019 19:15:27 +0100
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
Subject: Re: [PATCH v2] iio: imu: adis16400: fix memory leak
Message-ID: <20190921191527.4a6606d4@archlinux>
In-Reply-To: <3438e843e2304e22456b4ea83796f1118564b3f4.camel@analog.com>
References: <76a7c8d43f8c03a0549d157bbf278b515cfbc047.camel@analog.com>
        <20190919155636.3241-1-navid.emamdoost@gmail.com>
        <3438e843e2304e22456b4ea83796f1118564b3f4.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 06:46:05 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2019-09-19 at 10:56 -0500, Navid Emamdoost wrote:
> > In adis_update_scan_mode_burst, if adis->buffer allocation fails release
> > the adis->xfer.
> > 
> > v2: set adis->xfer = NULL to avoid any potential double free.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/adis_buffer.c
> > b/drivers/iio/imu/adis_buffer.c
> > index 9ac8356d9a95..78fe83c1f4fe 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -35,8 +35,11 @@ static int adis_update_scan_mode_burst(struct iio_dev
> > *indio_dev,
> >  		return -ENOMEM;
> >  
> >  	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
> > -	if (!adis->buffer)
> > +	if (!adis->buffer) {
> > +		kfree(adis->xfer);
> > +		adis->xfer = NULL;
> >  		return -ENOMEM;
> > +	}
> >  
> >  	tx = adis->buffer + burst_length;
> >  	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);  

