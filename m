Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5788EF5EF6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfKIMU2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKIMU2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:20:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFAB021848;
        Sat,  9 Nov 2019 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302027;
        bh=eypz+eq6ouo/UL1gyjOdBVG/yZCMcI7pa7oZxolzgjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yxZMh9Ek7TDqWvUVSSfH4V2cR9e/4VFQhwihC7inQ0V4ZOuPbODSfhLUInsClFGvu
         W398tfVc/fT/9/SewyhUSBcQ+HFK89RdJgT9lOviUd5doYs6ep8d5Bf8m3QvIdsYQH
         mnyLcZY4U0DPri2uzpHH/jiXXXn6NRIQXLG07tCI=
Date:   Sat, 9 Nov 2019 12:20:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "contact@artur-rojek.eu" <contact@artur-rojek.eu>
Subject: Re: [PATCH] iio: adc: ingenic: Use devm_platform_ioremap_resource
Message-ID: <20191109122023.26b1a6ed@archlinux>
In-Reply-To: <30c84014f09f22ed2cdfe2d5785eb60adff8b2a7.camel@analog.com>
References: <20191013152716.1830911-1-jic23@kernel.org>
        <30c84014f09f22ed2cdfe2d5785eb60adff8b2a7.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:16:14 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 16:27 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Replaces local boilerplate.  Identified by coccinelle.
> > CHECK   drivers/iio/adc/ingenic-adc.c
> > drivers/iio/adc/ingenic-adc.c:449:1-10: WARNING: Use
> > devm_platform_ioremap_resource for adc -> base
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Artur Rojek <contact@artur-rojek.eu>
> > ---
> >  drivers/iio/adc/ingenic-adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-
> > adc.c
> > index 7a53c2f8d438..39c0a609fc94 100644
> > --- a/drivers/iio/adc/ingenic-adc.c
> > +++ b/drivers/iio/adc/ingenic-adc.c
> > @@ -428,7 +428,6 @@ static int ingenic_adc_probe(struct platform_device
> > *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct iio_dev *iio_dev;
> >  	struct ingenic_adc *adc;
> > -	struct resource *mem_base;
> >  	const struct ingenic_adc_soc_data *soc_data;
> >  	int ret;
> >  
> > @@ -445,8 +444,7 @@ static int ingenic_adc_probe(struct platform_device
> > *pdev)
> >  	mutex_init(&adc->aux_lock);
> >  	adc->soc_data = soc_data;
> >  
> > -	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	adc->base = devm_ioremap_resource(dev, mem_base);
> > +	adc->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(adc->base))
> >  		return PTR_ERR(adc->base);
> >    

