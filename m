Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F331F5EF9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfKIMVz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKIMVz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:21:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA2D20659;
        Sat,  9 Nov 2019 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302114;
        bh=qeMlsP7cH6NsEUrI4JB/qngD5u+omDaeKH94xfTbEKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wUNwv2JPfbUh9qPWqaZ8DgYcmUUHaioqfCazc6EW1RXC3XvHGG+OEif2B+jZ3ZLjn
         2VpNKusq5hcC6/X8by5Uwie+UYAGc3qIQzBhgYPd3I0TYIt0UnIMJFuZCiG3qXW17G
         thRO20s3Lscvzt9D1r+pdkcy0J2rsFrh/GrPljU8=
Date:   Sat, 9 Nov 2019 12:21:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "manabian@gmail.com" <manabian@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: lpc18xx: use devm_platform_ioremap_resource
Message-ID: <20191109122150.1ecbab24@archlinux>
In-Reply-To: <3579f153fbec2b9f60e3adaff094ae395bee57e4.camel@analog.com>
References: <20191013153234.1835827-1-jic23@kernel.org>
        <3579f153fbec2b9f60e3adaff094ae395bee57e4.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:19:33 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 16:32 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Avoid local boilerplate.
> > Identified by coccinelle
> > 
> > CHECK   drivers/iio/adc/lpc18xx_adc.c
> > drivers/iio/adc/lpc18xx_adc.c:137:1-10: WARNING: Use
> > devm_platform_ioremap_resource for adc -> base  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Joachim Eastwood <manabian@gmail.com>
> > ---
> >  drivers/iio/adc/lpc18xx_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/lpc18xx_adc.c
> > b/drivers/iio/adc/lpc18xx_adc.c
> > index e400a95f553d..4c6ac6644dc0 100644
> > --- a/drivers/iio/adc/lpc18xx_adc.c
> > +++ b/drivers/iio/adc/lpc18xx_adc.c
> > @@ -119,7 +119,6 @@ static int lpc18xx_adc_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct iio_dev *indio_dev;
> >  	struct lpc18xx_adc *adc;
> > -	struct resource *res;
> >  	unsigned int clkdiv;
> >  	unsigned long rate;
> >  	int ret;
> > @@ -133,8 +132,7 @@ static int lpc18xx_adc_probe(struct platform_device
> > *pdev)
> >  	adc->dev = &pdev->dev;
> >  	mutex_init(&adc->lock);
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	adc->base = devm_ioremap_resource(&pdev->dev, res);
> > +	adc->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(adc->base))
> >  		return PTR_ERR(adc->base);
> >    

