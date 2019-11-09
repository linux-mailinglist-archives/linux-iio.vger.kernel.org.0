Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD00AF5F15
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfKIMcc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKIMcc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:32:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C15207FF;
        Sat,  9 Nov 2019 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302751;
        bh=uH1tghfYu2yIv43zpAU7ZhVCiSkTEvt4MtcadK8Y0mc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=moAxqOXT2s4E8OEQ6/fi69+2J9EujtcSHJkT+CvktU2UJ/JpCD926nQ7dJrqGtOC/
         OAhBdnE1f+6Wcs185EiqExkxM8uFgGTcJXN8WMaleM9xkx8r5w+bV8mL2szecESvuq
         SjzFu+IyGTdvtccyYlUWToFKR3NW7LH5Oom1gGj4=
Date:   Sat, 9 Nov 2019 12:32:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "maitysanchayan@gmail.com" <maitysanchayan@gmail.com>
Subject: Re: [PATCH] iio: dac: vf610: Use devm_platform_ioremap_resource
Message-ID: <20191109123225.02d181fa@archlinux>
In-Reply-To: <997b426fd9211cda5b3bb8ae645c07c1dbb5af7e.camel@analog.com>
References: <20191013171732.2169010-1-jic23@kernel.org>
        <997b426fd9211cda5b3bb8ae645c07c1dbb5af7e.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:18:09 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 18:17 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduce local boilerplate.
> > Suggested by coccinelle
> > 
> > CHECK   drivers/iio/dac/vf610_dac.c
> > drivers/iio/dac/vf610_dac.c:189:1-11: WARNING: Use
> > devm_platform_ioremap_resource for info -> regs
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  drivers/iio/dac/vf610_dac.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
> > index 0ec4d2609ef9..71f8a5c471c4 100644
> > --- a/drivers/iio/dac/vf610_dac.c
> > +++ b/drivers/iio/dac/vf610_dac.c
> > @@ -172,7 +172,6 @@ static int vf610_dac_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct iio_dev *indio_dev;
> >  	struct vf610_dac *info;
> > -	struct resource *mem;
> >  	int ret;
> >  
> >  	indio_dev = devm_iio_device_alloc(&pdev->dev,
> > @@ -185,8 +184,7 @@ static int vf610_dac_probe(struct platform_device
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

