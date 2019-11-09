Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024BDF5EEB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfKIMPM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfKIMPM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:15:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9E721882;
        Sat,  9 Nov 2019 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573301711;
        bh=PrWZknVDB5BsrZM0ZI+7Zy0Sfy4iHLW6Iu9LQdkYymw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aZXn2qBuJcLqOT8HusIGwir1f3b3KDyHNFwXxh7mgb9Jy6UnUUMYO3FnfVfMM+BAM
         31f1FcTQyq14cWAcQGql6hHXwM5fewMsSQjdxx1zaquXvPkzowVVegDT2Qog1daeY5
         uusAUdAMs3bb3jok8ip+GOwmlpnTnwro1OfAjBBY=
Date:   Sat, 9 Nov 2019 12:15:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "zhiyong.tao@mediatek.com" <zhiyong.tao@mediatek.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: mt6577_auxdac: use
 devm_platform_ioremap_resource
Message-ID: <20191109121507.5a25e6ed@archlinux>
In-Reply-To: <15c54a7c16eda55700e5e073db5650eece76d9f1.camel@analog.com>
References: <20191013121538.1782436-1-jic23@kernel.org>
        <15c54a7c16eda55700e5e073db5650eece76d9f1.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:14:32 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 13:15 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduces boilerplate.  Identified by coccinelle
> > 
> > CHECK   drivers/iio/adc/mt6577_auxadc.c
> > drivers/iio/adc/mt6577_auxadc.c:257:1-18: WARNING: Use
> > devm_platform_ioremap_resource for adc_dev -> reg_base
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> 
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  drivers/iio/adc/mt6577_auxadc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c
> > b/drivers/iio/adc/mt6577_auxadc.c
> > index 7bbb64ca3b32..a4776d924f3a 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -237,7 +237,6 @@ static int mt6577_auxadc_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct mt6577_auxadc_device *adc_dev;
> >  	unsigned long adc_clk_rate;
> > -	struct resource *res;
> >  	struct iio_dev *indio_dev;
> >  	int ret;
> >  
> > @@ -253,8 +252,7 @@ static int mt6577_auxadc_probe(struct platform_device
> > *pdev)
> >  	indio_dev->channels = mt6577_auxadc_iio_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> > +	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(adc_dev->reg_base)) {
> >  		dev_err(&pdev->dev, "failed to get auxadc base address\n");
> >  		return PTR_ERR(adc_dev->reg_base);  

