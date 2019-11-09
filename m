Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF0F5EFB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKIMXn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKIMXn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:23:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7131D20659;
        Sat,  9 Nov 2019 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573302222;
        bh=dS+Q94tAc4gH/z7Q+IFfr6eO9zTmQkHVu5Ido9mdckU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sGk1IzDETFahHa4xn/+3g1wxsjBZX554kqtSMR83pLsa0lGMO3bDju4tQpdE6CkD+
         B4LyHMcKKvvPqKAW9Y0tskuzPWklsH+SLAtApGszgSly/b0PhPuvxs0OJcNvORZwjx
         SDs4ACYz4YemyXJ9Zxo4uiovLLLsh1t/OX4xc0p0=
Date:   Sat, 9 Nov 2019 12:23:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: npcm: use devm_platform_ioremap_resource
Message-ID: <20191109122338.2f24fad9@archlinux>
In-Reply-To: <82747a09236357a7b1a285404dcc9ae17baac963.camel@analog.com>
References: <20191013154427.1853794-1-jic23@kernel.org>
        <82747a09236357a7b1a285404dcc9ae17baac963.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:17:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 16:44 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Reduces local boilerplate code.
> > Suggested by coccinelle via coccicheck.
> > 
> > CHECK   drivers/iio/adc/npcm_adc.c
> > drivers/iio/adc/npcm_adc.c:200:1-11: WARNING: Use
> > devm_platform_ioremap_resource for info -> regs
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  drivers/iio/adc/npcm_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> > index 910f3585fa54..a6170a37ebe8 100644
> > --- a/drivers/iio/adc/npcm_adc.c
> > +++ b/drivers/iio/adc/npcm_adc.c
> > @@ -183,7 +183,6 @@ static int npcm_adc_probe(struct platform_device
> > *pdev)
> >  	int irq;
> >  	u32 div;
> >  	u32 reg_con;
> > -	struct resource *res;
> >  	struct npcm_adc *info;
> >  	struct iio_dev *indio_dev;
> >  	struct device *dev = &pdev->dev;
> > @@ -196,8 +195,7 @@ static int npcm_adc_probe(struct platform_device
> > *pdev)
> >  
> >  	info->dev = &pdev->dev;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	info->regs = devm_ioremap_resource(&pdev->dev, res);
> > +	info->regs = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(info->regs))
> >  		return PTR_ERR(info->regs);
> >    

