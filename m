Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D260301D14
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbhAXPOQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 10:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbhAXPNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 10:13:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A9822B43;
        Sun, 24 Jan 2021 15:12:47 +0000 (UTC)
Date:   Sun, 24 Jan 2021 15:12:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio:adc:ti-ads124s08: Fix packet read from the ADC
Message-ID: <20210124151242.285ce9c6@archlinux>
In-Reply-To: <20210121191431.12057-2-dmurphy@ti.com>
References: <20210121191431.12057-1-dmurphy@ti.com>
        <20210121191431.12057-2-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 13:14:31 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Fix the spi_transfer array in the reading of the data from the ADC.
> 
> Fixes: ("e717f8c6dfec iio: adc: Add the TI ads124s08 ADC code")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

I'm not really following the changes below..

> ---
>  drivers/iio/adc/ti-ads124s08.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index f05d4e0e1c9d..023d81c7e8da 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -201,12 +201,10 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
>  	struct spi_transfer t[] = {
>  		{
>  			.tx_buf = &priv->data[0],
> -			.len = 4,
> -			.cs_change = 1,

We should still need to provide a length for this transfer.

>  		}, {
> -			.tx_buf = &priv->data[1],
>  			.rx_buf = &priv->data[1],
>  			.len = 4,
> +			.cs_change = 1,

That's unusual... cs_change being set on the last transfer means
the opposite of what it does for earlier transfers.

https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi.h#L905

Or is the intent here to provide a performance hint that the device doesn't
care if the cs line goes inactive before stating a new set of transfers?
If so add a comment to say that perhaps.

>  		},
>  	};
>  

