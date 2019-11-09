Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3103CF5EF4
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfKIMSw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKIMSw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:18:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F41121848;
        Sat,  9 Nov 2019 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573301931;
        bh=LFk4DoIMLX9YIAbDfQ1bX1diTZXkmbJ4dUydHT+9Ua8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IPXVi4abeIQs9S1L1k7I6T3A/vyLy93zbj2RHXc3GgQkcTxHHJPHHV17UhwsHE1F9
         eFg0eW7HnGnN/6YvJnGpJ3PhI8P36pfozKg2w2CRl6Jxc/HOr6+An/iE39Kpl98fxZ
         33JryyDr2Yi+2XGS+BHouOk55cKI2v56gGBb8DFY=
Date:   Sat, 9 Nov 2019 12:18:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "naidu.tellapati@imgtec.com" <naidu.tellapati@imgtec.com>
Subject: Re: [PATCH] iio: adc: cc10001: use devm_platform_ioremap_resource
Message-ID: <20191109121847.505e53db@archlinux>
In-Reply-To: <882478ce1c7e6f6b857231b19b9e15c05f7c943c.camel@analog.com>
References: <20191013122512.1793656-1-jic23@kernel.org>
        <882478ce1c7e6f6b857231b19b9e15c05f7c943c.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:15:50 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 13:25 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduces local boilerplate.
> > Found by coccinelle:
> > 
> > drivers/iio/adc/cc10001_adc.c:344:1-18: WARNING: Use
> > devm_platform_ioremap_resource for adc_dev -> reg_base
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Naidu Tellapati <naidu.tellapati@imgtec.com>
> > ---
> >  drivers/iio/adc/cc10001_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/cc10001_adc.c
> > b/drivers/iio/adc/cc10001_adc.c
> > index f93f1d93b80d..fe9257624f16 100644
> > --- a/drivers/iio/adc/cc10001_adc.c
> > +++ b/drivers/iio/adc/cc10001_adc.c
> > @@ -310,7 +310,6 @@ static int cc10001_adc_probe(struct platform_device
> > *pdev)
> >  	struct device_node *node = pdev->dev.of_node;
> >  	struct cc10001_adc_device *adc_dev;
> >  	unsigned long adc_clk_rate;
> > -	struct resource *res;
> >  	struct iio_dev *indio_dev;
> >  	unsigned long channel_map;
> >  	int ret;
> > @@ -340,8 +339,7 @@ static int cc10001_adc_probe(struct platform_device
> > *pdev)
> >  	indio_dev->info = &cc10001_adc_info;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> > +	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(adc_dev->reg_base)) {
> >  		ret = PTR_ERR(adc_dev->reg_base);
> >  		goto err_disable_reg;  

