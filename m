Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9342D8DE7
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLMOTc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgLMOTb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:19:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5D82253D;
        Sun, 13 Dec 2020 14:18:50 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:18:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: remove omitted
 iio_kfifo_free()
Message-ID: <20201213141847.049b5abd@archlinux>
In-Reply-To: <20201203072650.24128-1-alexandru.ardelean@analog.com>
References: <20201203072650.24128-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Dec 2020 09:26:50 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> When the conversion was done to use devm_iio_kfifo_allocate(), a call to
> iio_kfifo_free() was omitted (to be removed).
> This change removes it.
> 
> Fixes: 3c5308058899 ("iio: adc: ti_am335x_adc: alloc kfifo & IRQ via devm_ functions")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

applied to the fixes-togreg branch of iio.git and marked for stable.

Pull request for this will be sometime soon after rc1.

Thanks,

Jonathan
	
> ---
> 
> Seems I was doing too many things at once when I wrote this.
> 
>  drivers/iio/adc/ti_am335x_adc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index b11c8c47ba2a..e946903b0993 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -397,16 +397,12 @@ static int tiadc_iio_buffered_hardware_setup(struct device *dev,
>  	ret = devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
>  				flags, indio_dev->name, indio_dev);
>  	if (ret)
> -		goto error_kfifo_free;
> +		return ret;
>  
>  	indio_dev->setup_ops = setup_ops;
>  	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>  
>  	return 0;
> -
> -error_kfifo_free:
> -	iio_kfifo_free(indio_dev->buffer);
> -	return ret;
>  }
>  
>  static const char * const chan_name_ain[] = {

