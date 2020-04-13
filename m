Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75081A68E9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgDMPd6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgDMPd5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:33:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4773C2072C;
        Mon, 13 Apr 2020 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586792036;
        bh=C3rwpvDMNRiUZqo5CRZNrWuQ/iGdulM0YD+Yiedl4is=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nch7zZynKO9XRTNRHTyGFb43yPeXfg7AeWvauV6v/IMXB9OxThDPanZyxhR51xuey
         mWeAgikpzWUR7Exd4nZl6YlU9Ikg+9GrMkH80dO8KrRZdSRikf6LSPTqit48yz2qDd
         tIyupxztaVnKwHL6CnsX3cOH2wWIePm5bsrT3eSQ=
Date:   Mon, 13 Apr 2020 16:33:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: Use
 devm_platform_ioremap_resource
Message-ID: <20200413163351.3b7cfd4e@archlinux>
In-Reply-To: <20200412143220.4476-1-aishwaryarj100@gmail.com>
References: <20200409141331.30882-1-aishwaryarj100@gmail.com>
        <20200412143220.4476-1-aishwaryarj100@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Apr 2020 20:02:18 +0530
Aishwarya R <aishwaryarj100@gmail.com> wrote:

> From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
> 
> Use the helper function that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.Reduces boilerplate and suggested
> by coccinelle.
> 
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

So couple of general things for future reference.
1. New versions of a patch need a title such as [PATCH V2]
2. You have several similar patches, they would have been best sent
   as a series as that lets a maintainer pick them all up in one go.
3. Don't send new versions in reply to older versions.  It doesn't scale
   as we regularly end up 10 or more versions in to a series.  Not to mention
   many reviewers read backwards in time (as often earlier patches are resolved
   before you get to them) so by sending it as a reply you ensured it was much
   less likely to be applied.  Here you were luck as I am on holiday so have
   time to catch up.

Applied to the togreg branch of iio.git with the message above tidied up
a little.  Will be pushed out as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 176e1cb4abb1..0f2c1738a90d 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -496,7 +496,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  				struct iio_dev *indio_dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
> -	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
>  
> @@ -508,8 +507,7 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
>  	indio_dev->channels = sun8i_a33_gpadc_channels;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, mem);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  

