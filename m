Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A04138101
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAKLAr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbgAKLAq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:00:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA5320842;
        Sat, 11 Jan 2020 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578740446;
        bh=mLQHghOqDmybltd0XVnN5VdKnRcVz0LjzKPlp43ewtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGIRy8afxTZ44EuAq8HAqfOARlroZZCVwY6bUEIVAssSPbiWpP/2ZctOPGd35WrG7
         QDABfptlkZ67NVhjvN40OD7dHlE5XP02HtY7/w5dR8wkeCWinSzfwYIfQerv5bnI6Q
         O6fv3eN1fQ/Xj5S91D0NNZ2n6DjnMFZZXac1Dt3M=
Date:   Sat, 11 Jan 2020 11:00:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <vkoul@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3] iio: adc: stm32-adc: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20200111110039.09c6b9dd@archlinux>
In-Reply-To: <20200108080801.14144-1-peter.ujfalusi@ti.com>
References: <20200108080801.14144-1-peter.ujfalusi@ti.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Jan 2020 10:08:01 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan

> ---
> Hi,
> 
> Changes since v2:
> - Replace the comment as suggested by Fabrice
> 
> Changes since v1:
> - Fall back to IRQ mode only in case of ENODEV
> 
> Regards,
> Peter
> 
>  drivers/iio/adc/stm32-adc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 3b291d72701c..a8d2414ee2eb 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1746,9 +1746,21 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
>  	struct dma_slave_config config;
>  	int ret;
>  
> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> -	if (!adc->dma_chan)
> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
> +	if (IS_ERR(adc->dma_chan)) {
> +		ret = PTR_ERR(adc->dma_chan);
> +		if (ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&indio_dev->dev,
> +					"DMA channel request failed with %d\n",
> +					ret);
> +			return ret;
> +		}
> +
> +		/* DMA is optional: fall back to IRQ mode */
> +		adc->dma_chan = NULL;
>  		return 0;
> +	}
>  
>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>  					 STM32_DMA_BUFFER_SIZE,

