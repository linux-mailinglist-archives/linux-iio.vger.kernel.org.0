Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C400381DBD
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEPJvM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 05:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhEPJvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:51:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6293561168;
        Sun, 16 May 2021 09:49:55 +0000 (UTC)
Date:   Sun, 16 May 2021 10:51:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: tsc2046: fix a warning message in
 tsc2046_adc_update_scan_mode()
Message-ID: <20210516105106.73671615@jic23-huawei>
In-Reply-To: <YJ+ZuO43TnguY5vq@mwanda>
References: <YJ+ZuO43TnguY5vq@mwanda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 May 2021 12:51:52 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> These variables are unsigned so the condition can't be less than zero
> and the warning message will never be printed.
> 
> Fixes: 5fec3541aa88 ("iio: adc: add ADC driver for the TI TSC2046 controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks.

Chances are I'm going to rebase togreg shortly to unwind a merge conflict
with fixes-togreg so hopefully I'll manage to remember to update that fixes
tag.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti-tsc2046.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 89a818b653b4..cf5373d5cdd7 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -398,7 +398,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	priv->xfer.len = size;
>  	priv->time_per_scan_us = size * 8 * priv->time_per_bit_ns / NSEC_PER_USEC;
>  
> -	if ((priv->scan_interval_us - priv->time_per_scan_us) < 0)
> +	if (priv->scan_interval_us > priv->time_per_scan_us)
>  		dev_warn(&priv->spi->dev, "The scan interval (%d) is less then calculated scan time (%d)\n",
>  			 priv->scan_interval_us, priv->time_per_scan_us);
>  

