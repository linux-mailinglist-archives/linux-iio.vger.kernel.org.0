Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4582CF5EE9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfKIMN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfKIMN5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:13:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2CC21882;
        Sat,  9 Nov 2019 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573301636;
        bh=zipVPQPBvrpco5hpaAip5FMLLWEIza7+aFjlQJNwk9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JAXV/FiM2iwft27bcT/knkguHqWpfZEkSTxWYqJktSNUkWxPkvfOtwr2H6K/w7Fid
         UiQ7P9r6UBUDXpcw1FqHLx8725pVVkMdOe1ZiFgd3SutSBsuK9rzFZTFxZsKucqYX4
         CW93knQGYR8ORaicUVZU8tvHcp/rhMeRz5Oouf0w=
Date:   Sat, 9 Nov 2019 12:13:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "raltherr@google.com" <raltherr@google.com>
Subject: Re: [PATCH] iio: adc: aspeed: use devm_platform_ioremap_resource
Message-ID: <20191109121350.6db10b02@archlinux>
In-Reply-To: <1be83f4fa8c1c87d41f17c9180651bc0ced625e7.camel@analog.com>
References: <20191013113705.1721011-1-jic23@kernel.org>
        <1be83f4fa8c1c87d41f17c9180651bc0ced625e7.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:12:58 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 12:37 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduces boilerplate.
> > 
> > Identified by: Coccinelle / coccicheck
> > 
> > CHECK   drivers/iio/adc/aspeed_adc.c
> > drivers/iio/adc/aspeed_adc.c:189:1-11: WARNING: Use
> > devm_platform_ioremap_resource for data -> base
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied. Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Rick Altherr <raltherr@google.com>
> > ---
> >  drivers/iio/adc/aspeed_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> > index d3fc39df535d..1e5375235cfe 100644
> > --- a/drivers/iio/adc/aspeed_adc.c
> > +++ b/drivers/iio/adc/aspeed_adc.c
> > @@ -173,7 +173,6 @@ static int aspeed_adc_probe(struct platform_device
> > *pdev)
> >  	struct iio_dev *indio_dev;
> >  	struct aspeed_adc_data *data;
> >  	const struct aspeed_adc_model_data *model_data;
> > -	struct resource *res;
> >  	const char *clk_parent_name;
> >  	int ret;
> >  	u32 adc_engine_control_reg_val;
> > @@ -185,8 +184,7 @@ static int aspeed_adc_probe(struct platform_device
> > *pdev)
> >  	data = iio_priv(indio_dev);
> >  	data->dev = &pdev->dev;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	data->base = devm_ioremap_resource(&pdev->dev, res);
> > +	data->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(data->base))
> >  		return PTR_ERR(data->base);
> >    

