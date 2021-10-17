Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A6430A82
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbhJQQWe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 12:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242581AbhJQQWd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 12:22:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A2261151;
        Sun, 17 Oct 2021 16:20:20 +0000 (UTC)
Date:   Sun, 17 Oct 2021 17:24:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: tsc2046: fix scan interval warning
Message-ID: <20211017172435.791cd280@jic23-huawei>
In-Reply-To: <20211007093007.1466-2-o.rempel@pengutronix.de>
References: <20211007093007.1466-1-o.rempel@pengutronix.de>
        <20211007093007.1466-2-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  7 Oct 2021 11:30:06 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Sync if statement with the actual warning.
> 
> Fixes: 9504db5765e8 ("iio: adc: tsc2046: fix a warning message in tsc2046_adc_update_scan_mode()")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Applied this one to the fixes-togreg branch of iio.git and marked it for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-tsc2046.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 170950d5dd49..d84ae6b008c1 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -398,7 +398,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	priv->xfer.len = size;
>  	priv->time_per_scan_us = size * 8 * priv->time_per_bit_ns / NSEC_PER_USEC;
>  
> -	if (priv->scan_interval_us > priv->time_per_scan_us)
> +	if (priv->scan_interval_us < priv->time_per_scan_us)
>  		dev_warn(&priv->spi->dev, "The scan interval (%d) is less then calculated scan time (%d)\n",
>  			 priv->scan_interval_us, priv->time_per_scan_us);
>  

