Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F59279A48
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgIZPGm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 11:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZPGm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 11:06:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58BCD208FE;
        Sat, 26 Sep 2020 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132802;
        bh=htXlnv5A9dqMAbHS9wNei22Suz97UHqIh5HeHeyclOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FcgXLA6lTt5sqvVDNchVGU0DeFW0EhV3IH3eWdOO6diJR1sdUQ253XfwGPgemvQpv
         jG+DYc4JZrRNS3S5CcCXQOkhSb2Nf0jFl8dXgJvdGfujbINWNuGanX/ahCuFHY/XoA
         457qRs+SU7Ow3jyjyQ9tPRBvBIyp709UMEA6EiEo=
Date:   Sat, 26 Sep 2020 16:06:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: fix DMA conversion crash
Message-ID: <20200926160637.4f0f0bcd@archlinux>
In-Reply-To: <20200923121748.49384-1-eugen.hristev@microchip.com>
References: <20200923121748.49384-1-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Sep 2020 15:17:48 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> After the move of the postenable code to preenable, the DMA start was
> done before the DMA init, which is not correct.
> The DMA is initialized in set_watermark. Because of this, we need to call
> the DMA start functions in set_watermark, after the DMA init, instead of
> preenable hook, when the DMA is not properly setup yet.
> 
> Fixes: f3c034f61775 ("iio: at91-sama5d2_adc: adjust iio_triggered_buffer_{predisable,postenable} positions")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied to the fixes togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> - check return value of buffer prepare, and in case of error, unwind DMA
> - validated by trying to force an error :
> 
> # echo 100 > /sys/bus/iio/devices/iio\:device0/buffer/length
> # echo 100 > /sys/bus/iio/devices/iio\:device0/buffer/watermark
> # iio_generic_buffer -n fc030000.adc -t fc030000.adc-dev0-external_rising -c 5
> iio device number being used is 0
> iio trigger number being used is 0
> /sys/bus/iio/deviciio io:device0 fc030000.adc-dev0-external_risingiio:device0: using dma0chan10 for rx DMA transfers
> 
> iio iio:device0: continuing without DMA support
> 505.151367
> 983.715820
> 1352.709961
> 1485.644531
> 
> 
> Original patch message:
> 
> Hi,
> 
> This crash is in the kernel since 5.8-rc1
> 
> Please have a look at discussion here:
> https://lore.kernel.org/linux-iio/CA+U=DsqRUtjjoe5nevP_wNxTgr27+O2V1h9w7d3QijBQ+5f3XA@mail.gmail.com/T/#t
> 
> Thanks !
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index de9583d6cddd..f94641193b98 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -884,7 +884,7 @@ static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
>  			       AT91_SAMA5D2_MAX_CHAN_IDX + 1);
>  }
>  
> -static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
> +static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
>  {
>  	int ret;
>  	u8 bit;
> @@ -901,7 +901,7 @@ static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
>  	/* we continue with the triggered buffer */
>  	ret = at91_adc_dma_start(indio_dev);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "buffer postenable failed\n");
> +		dev_err(&indio_dev->dev, "buffer prepare failed\n");
>  		return ret;
>  	}
>  
> @@ -989,7 +989,6 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>  }
>  
>  static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
> -	.preenable = &at91_adc_buffer_preenable,
>  	.postdisable = &at91_adc_buffer_postdisable,
>  };
>  
> @@ -1563,6 +1562,7 @@ static void at91_adc_dma_disable(struct platform_device *pdev)
>  static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	if (val > AT91_HWFIFO_MAX_SIZE)
>  		return -EINVAL;
> @@ -1586,7 +1586,15 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  	else if (val > 1)
>  		at91_adc_dma_init(to_platform_device(&indio_dev->dev));
>  
> -	return 0;
> +	/*
> +	 * We can start the DMA only after setting the watermark and
> +	 * having the DMA initialization completed
> +	 */
> +	ret = at91_adc_buffer_prepare(indio_dev);
> +	if (ret)
> +		at91_adc_dma_disable(to_platform_device(&indio_dev->dev));
> +
> +	return ret;
>  }
>  
>  static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,

