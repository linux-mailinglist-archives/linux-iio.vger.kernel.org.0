Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573E326E26A
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIQR3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgIQR30 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 13:29:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0DF221EC;
        Thu, 17 Sep 2020 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600363707;
        bh=NudZN54sc5i4qumVD3ViKxr7+VKLAtm733yj4DizhGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/aMRUUNvIyM2brFmCUJW+GQFXIuQGJ7swGeNT+UXIdn2qWVNj2Qlxqbl44zup4yN
         4f4BA+cO4gSeNxjI9b3Yr+I9HDyAy3PJ1CsPdtKXgaWAB7AR3HcfsUjJJ1oe/3U5GG
         EY+yOYeRquvprpdDFKcmd4w8+GHDwWNjsxAuNock=
Date:   Thu, 17 Sep 2020 18:28:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix DMA conversion crash
Message-ID: <20200917182822.5134767d@archlinux>
In-Reply-To: <20200916070821.118374-1-eugen.hristev@microchip.com>
References: <20200916070821.118374-1-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 10:08:21 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> After the move of the postenable code to preenable, the DMA start was
> done before the DMA init, which is not correct.
> The DMA is initialized in set_watermark. Because of this, we need to call
> the DMA start functions in set_watermark, after the DMA init, instead of
> preenable hook, when the DMA is not properly setup yet.
> 
> Fixes: f3c034f61775 ("iio: at91-sama5d2_adc: adjust iio_triggered_buffer_{predisable,postenable} positions")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Basic approach looks fine, but if we were to get an error from  the
buffer_prepare() function, should we be looking to disable dma if we
enabled it earlier in the set_watermark callback?

> ---
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
>  drivers/iio/adc/at91-sama5d2_adc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index de9583d6cddd..b5196797dcb8 100644
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
> @@ -1586,7 +1585,11 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  	else if (val > 1)
>  		at91_adc_dma_init(to_platform_device(&indio_dev->dev));
>  
> -	return 0;
> +	/*
> +	 * We can start the DMA only after setting the watermark and
> +	 * having the DMA initialization completed
> +	 */

Looks superficially to me like we may need to unwind some stuff if this fails.

> +	return at91_adc_buffer_prepare(indio_dev);
>  }
>  
>  static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,

