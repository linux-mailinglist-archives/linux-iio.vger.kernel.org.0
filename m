Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528A3F5F0D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfKIM1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfKIM1e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:27:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7202077C;
        Sat,  9 Nov 2019 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302453;
        bh=GroCLlKgG+borbZ1Ni4xrmO1QC7890xYGLaKYx9pmoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=toDA3WFjXqtz8+UB7z/Nr/fpLmspWZ2Yos/t/YwnFsF2n4X1D6gZTVoa2217IDZCg
         emT76gdj+KnifCjiZQiNwp8GHtjO1oBdA8aFanx2daQNfxaEZzkRO4hCPpyv4GyjE6
         g4ipFQculu2CJ5tdUjH32RnGgESSVVLFabfEBUzg=
Date:   Sat, 9 Nov 2019 12:27:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: spear_adc: Use devm_platform_ioremap_resource
Message-ID: <20191109122729.55f59ad2@archlinux>
In-Reply-To: <5069830d6f6b8ed3794efdd21c76afdf0f0d5072.camel@analog.com>
References: <20191013155239.1868818-1-jic23@kernel.org>
        <5069830d6f6b8ed3794efdd21c76afdf0f0d5072.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:17:47 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 16:52 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Avoids local boilerplate doing the same thing.
> > Suggested by coccinelle
> > 
> > CHECK   drivers/iio/adc/spear_adc.c
> > drivers/iio/adc/spear_adc.c:283:1-22: WARNING: Use
> > devm_platform_ioremap_resource for st -> adc_base_spear6xx
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied,

Thanks for sanity checking all these :)

Jonathan
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/spear_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> > index 592b97c464da..0ad536494e8f 100644
> > --- a/drivers/iio/adc/spear_adc.c
> > +++ b/drivers/iio/adc/spear_adc.c
> > @@ -260,7 +260,6 @@ static int spear_adc_probe(struct platform_device
> > *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct device *dev = &pdev->dev;
> >  	struct spear_adc_state *st;
> > -	struct resource *res;
> >  	struct iio_dev *indio_dev = NULL;
> >  	int ret = -ENODEV;
> >  	int irq;
> > @@ -279,8 +278,7 @@ static int spear_adc_probe(struct platform_device
> > *pdev)
> >  	 * (e.g. SPEAr3xx). Let's provide two register base addresses
> >  	 * to support multi-arch kernels.
> >  	 */
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	st->adc_base_spear6xx = devm_ioremap_resource(&pdev->dev, res);
> > +	st->adc_base_spear6xx = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(st->adc_base_spear6xx))
> >  		return PTR_ERR(st->adc_base_spear6xx);
> >    

