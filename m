Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0CF5F14
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfKIMa7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKIMa7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:30:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD82207FF;
        Sat,  9 Nov 2019 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302659;
        bh=OrUvo02sJBeTe0U1En5uoM1Rimj0kQfOcJ5K4YAEuSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rzbQTxRkYuyxpoewqZeYOVC3wPjL77ymvjjhYZYisIIXohPgRsrs9lYaitB2k+7h1
         H+WKFjzPNhi46Z/bJLuBdAFpNKtDIUzZzfxRu0FQJO62ZzmZ88Lx9DOnslf5KGgFWi
         CaAu/Eu2qspOOMpZ1pJfQ78uaJVRcUYnQES3E+bo=
Date:   Sat, 9 Nov 2019 12:30:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "manabian@gmail.com" <manabian@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: dac: lpc18xx: Use devm_platform_ioremap_resource
Message-ID: <20191109123055.156de624@archlinux>
In-Reply-To: <a26444c26603137a293dae3c84147f8e727ce198.camel@analog.com>
References: <20191013171414.2154379-1-jic23@kernel.org>
        <a26444c26603137a293dae3c84147f8e727ce198.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:16:44 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 18:14 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduce boilerplate.
> > Suggested by coccinelle
> >   CHECK   drivers/iio/dac/lpc18xx_dac.c
> > drivers/iio/dac/lpc18xx_dac.c:121:1-10: WARNING: Use
> > devm_platform_ioremap_resource for dac -> base
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
Applied,

Thanks,

J
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > CC: Joachim Eastwood <manabian@gmail.com>
> > ---
> >  drivers/iio/dac/lpc18xx_dac.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/lpc18xx_dac.c
> > b/drivers/iio/dac/lpc18xx_dac.c
> > index 883e84e96609..0ab357bd3633 100644
> > --- a/drivers/iio/dac/lpc18xx_dac.c
> > +++ b/drivers/iio/dac/lpc18xx_dac.c
> > @@ -106,7 +106,6 @@ static int lpc18xx_dac_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct iio_dev *indio_dev;
> >  	struct lpc18xx_dac *dac;
> > -	struct resource *res;
> >  	int ret;
> >  
> >  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*dac));
> > @@ -117,8 +116,7 @@ static int lpc18xx_dac_probe(struct platform_device
> > *pdev)
> >  	dac = iio_priv(indio_dev);
> >  	mutex_init(&dac->lock);
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	dac->base = devm_ioremap_resource(&pdev->dev, res);
> > +	dac->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(dac->base))
> >  		return PTR_ERR(dac->base);
> >    

