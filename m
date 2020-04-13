Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D81A68FD
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgDMPhq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgDMPhp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:37:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8B32072C;
        Mon, 13 Apr 2020 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586792265;
        bh=lQ8kyjkpMTyR85fSUdpR9VATKBOfxGyqeQRWXIWSwHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NfgsGatWPdOuSoVilt1i+8H0bYzRjSVvm2+qN90yARaeKWT9voanCYZ0YuSmgXyNH
         Bvt10f/cQ0+5gdY4GvfKOLicT01q51fsLe62EYzgnMV82Ot0jabjgwRcoq43YTH+R8
         9X6PgLY6pG97BuQuPDt88moH3eYsx9hmLw8Duu5k=
Date:   Mon, 13 Apr 2020 16:37:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: Use
 devm_platform_ioremap_resource
Message-ID: <20200413163739.38474d8a@archlinux>
In-Reply-To: <20200412135023.3831-1-aishwaryarj100@gmail.com>
References: <20200409151306.308-1-aishwaryarj100@gmail.com>
        <20200412135023.3831-1-aishwaryarj100@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Apr 2020 19:20:20 +0530
Aishwarya R <aishwaryarj100@gmail.com> wrote:

> From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
> 
> Use the helper function that wraps the calls to
> platform_get_resource() and devm_ioremap_resource()
> together.It reduces boilerplate and suggested by coccinelle.
> 
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
Again see earlier patches for comments but applied anyway to
save myself time.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index fa71489195c6..b0a4dc88ba9b 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -294,7 +294,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  	struct mx25_gcq_priv *priv;
>  	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev = &pdev->dev;
> -	struct resource *res;
>  	void __iomem *mem;
>  	int ret;
>  	int i;
> @@ -305,8 +304,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  
>  	priv = iio_priv(indio_dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mem = devm_ioremap_resource(dev, res);
> +	mem = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mem))
>  		return PTR_ERR(mem);
>  

