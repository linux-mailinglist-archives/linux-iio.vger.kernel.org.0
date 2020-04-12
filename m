Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93E21A5E07
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDLKZr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 06:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLKZr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:25:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABE820708;
        Sun, 12 Apr 2020 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586687146;
        bh=GPoR6fO9oT8HCa7+VFKYGXh0NeNqRhagYkJ4iTjJt/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXF89qPSLNzeNHt80CdhfT3Z5f0uYHt7THlNdM3epKAaCVFqrCGjxeERp/OjeSI/S
         Jxjhr83g+1iBKcB85v67YpHhBaPhL6Gz2EJZhPbLCej2+3M1+KUZDibLqgxxon0o0m
         eI/GChqvxjQF1CloTeeJyHa4Ynu6YN6Q05784YwQ=
Date:   Sun, 12 Apr 2020 11:25:41 +0100
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
        Stephen Boyd <swboyd@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: Use
 devm_platform_ioremap_resource
Message-ID: <20200412112541.2a2097fa@archlinux>
In-Reply-To: <20200409151306.308-1-aishwaryarj100@gmail.com>
References: <20200409151306.308-1-aishwaryarj100@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Apr 2020 20:43:05 +0530
Aishwarya R <aishwaryarj100@gmail.com> wrote:

> Use the helper function that wraps the calls to
> platform_get_resource() and devm_ioremap_resource()
> together.
> 
> Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
Please update the commit message for v2. In particular if an automated
tool was used to identify this location then mention that.  If not just
say 'by inspection' or similar!

Also, same thing about the signed-off-by as in previous patch.

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

