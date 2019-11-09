Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97577F5F09
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfKIMZc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfKIMZc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:25:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7B620659;
        Sat,  9 Nov 2019 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302331;
        bh=/9GBtJ0J9S/ji+0C6CU9c8LU6xj/0h5E2B5meCZU0d0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/7YuDXAspOA6/h3vj1YPBcq235FHYhuMv2miYOaLT6qwEG+QrUyOAOngZNccO4N2
         U0s+RusulIrhCaPjqGSXpF2C4vJ7x6e4LFH8i6oERSZWdwZGW6AImfnJdu9xjjHPgr
         zrNXQobMsNvNEZ4HZlOuAmS4imWPJftAjdrhiRME=
Date:   Sat, 9 Nov 2019 12:25:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: rcar-gyroadc: use
 devm_platform_ioremap_resource
Message-ID: <20191109122526.01a269a7@archlinux>
In-Reply-To: <853e5567973d6225307d6b557ecdcca61c86e0b7.camel@analog.com>
References: <20191013154832.1858884-1-jic23@kernel.org>
        <853e5567973d6225307d6b557ecdcca61c86e0b7.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:17:28 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 16:48 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Avoids some local boilerplate.
> > Suggested by coccinelle.
> > 
> > CHECK   drivers/iio/adc/rcar-gyroadc.c
> > drivers/iio/adc/rcar-gyroadc.c:495:1-11: WARNING: Use
> > devm_platform_ioremap_resource for priv -> regs
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied, 

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> > ---
> >  drivers/iio/adc/rcar-gyroadc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-
> > gyroadc.c
> > index c37f201294b2..63ce743ee7af 100644
> > --- a/drivers/iio/adc/rcar-gyroadc.c
> > +++ b/drivers/iio/adc/rcar-gyroadc.c
> > @@ -481,7 +481,6 @@ static int rcar_gyroadc_probe(struct platform_device
> > *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct rcar_gyroadc *priv;
> >  	struct iio_dev *indio_dev;
> > -	struct resource *mem;
> >  	int ret;
> >  
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> > @@ -491,8 +490,7 @@ static int rcar_gyroadc_probe(struct platform_device
> > *pdev)
> >  	priv = iio_priv(indio_dev);
> >  	priv->dev = dev;
> >  
> > -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	priv->regs = devm_ioremap_resource(dev, mem);
> > +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(priv->regs))
> >  		return PTR_ERR(priv->regs);
> >    

