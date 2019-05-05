Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2813F3C
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 13:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfEELsp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 07:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfEELso (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 07:48:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F594206DF;
        Sun,  5 May 2019 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557056924;
        bh=CLY42SOCP114hx0siJmK7XEwe3fFs1ycdguMO9f5ack=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vFvXIbG/OYIPZ4e37Jq74sj7UKStYSLVxbjeKqA8D7Jpb/LH/u36DMNckNYAELw62
         zTtjdGFfdqVbO6/swDmzKWgqfogyHy3sDj6KmlN9QW8gvC2Pk2H9BXUg5qI9cDO7E3
         uGJScLHdQn2wDMIVvcEBYAHNUYBRRnvf7MvkQCqQ=
Date:   Sun, 5 May 2019 12:48:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rcar-gyroadc: Remove devm_iio_device_alloc()
 error printing
Message-ID: <20190505124836.0956f2d2@archlinux>
In-Reply-To: <20190429152409.23081-1-geert+renesas@glider.be>
References: <20190429152409.23081-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Apr 2019 17:24:09 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> devm_iio_device_alloc() can only fail due to a memory or IDA allocation
> failure.  Hence there is no need to print a message, as the memory
> allocation or IIO core code already takes care of that.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
I'm not totally sure there aren't any paths which can result in an
error without message, but they are at least pretty unlikely 
so I'm happy to take this.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/rcar-gyroadc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index 2c0d0316d149707f..2d685730f8673e65 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -485,10 +485,8 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> -	if (!indio_dev) {
> -		dev_err(dev, "Failed to allocate IIO device.\n");
> +	if (!indio_dev)
>  		return -ENOMEM;
> -	}
>  
>  	priv = iio_priv(indio_dev);
>  	priv->dev = dev;

