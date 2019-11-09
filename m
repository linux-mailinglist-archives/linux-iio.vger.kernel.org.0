Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36F2F5F11
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKIM3n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKIM3m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:29:42 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D57D2077C;
        Sat,  9 Nov 2019 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302582;
        bh=IvMfPvtyXFOWr9nMtraFMHpA+HueMXxBPomY2RhuXvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eBXg7nrULHCw+x8fuXDIdvnJQuDwqEOQvAT/smiGk4az+Okt+Mwj4QJE5KCfwEKjd
         Mf9rUUoM86ZLDQAhqkWgwd90eiKslDT7VS0r5Q3/Bj9DMBvAaPLkqjM0pWaawnjSSV
         YqsDwNqcScpxc0LL+iR7M/muVClj6DNwgf1ONgD0=
Date:   Sat, 9 Nov 2019 12:29:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "b38611@freescale.com" <b38611@freescale.com>
Subject: Re: [PATCH] iio: adc: vf610: use devm_platform_ioremap_resource
Message-ID: <20191109122937.4171752b@archlinux>
In-Reply-To: <0e4fecb0b690549305690972d3a83bef13b026e8.camel@analog.com>
References: <20191013164349.2049538-1-jic23@kernel.org>
        <0e4fecb0b690549305690972d3a83bef13b026e8.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:19:13 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 17:43 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduces boilerplate.
> > 
> > Suggested by coccinelle
> > CHECK   drivers/iio/adc/vf610_adc.c
> > drivers/iio/adc/vf610_adc.c:819:1-11: WARNING: Use
> > devm_platform_ioremap_resource for info -> regs
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

J
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Fugang Duan <b38611@freescale.com>
> > ---
> >  drivers/iio/adc/vf610_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > index 98b30475bbc6..cb7380bf07ca 100644
> > --- a/drivers/iio/adc/vf610_adc.c
> > +++ b/drivers/iio/adc/vf610_adc.c
> > @@ -802,7 +802,6 @@ static int vf610_adc_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct vf610_adc *info;
> >  	struct iio_dev *indio_dev;
> > -	struct resource *mem;
> >  	int irq;
> >  	int ret;
> >  
> > @@ -815,8 +814,7 @@ static int vf610_adc_probe(struct platform_device
> > *pdev)
> >  	info = iio_priv(indio_dev);
> >  	info->dev = &pdev->dev;
> >  
> > -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> > +	info->regs = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(info->regs))
> >  		return PTR_ERR(info->regs);
> >    

