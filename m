Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B679712985D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLWPmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfLWPmf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:42:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE0520409;
        Mon, 23 Dec 2019 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577115754;
        bh=W7dVTbz3atfdVAhEErfOc/0Hk/lMKKZVb4bYQnWDj2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s//tC+nTdBusmIDHh3w/JHuWKUr8WZVN0KLC+5/wqYR78n9MAxMnp6XKUU4AC657c
         U14znr1zujKNxf6wQUO+8FMnp7RkFlmi3LhRux36l3jmUeE1S5MfamQvscwQPE3N9f
         V1cD1j/T75J6/4t7OPNogFXjcHgnMBW3Nc+c3bpQ=
Date:   Mon, 23 Dec 2019 15:42:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20191223154230.7fb2a988@archlinux>
In-Reply-To: <20191217075153.23766-1-peter.ujfalusi@ti.com>
References: <20191217075153.23766-1-peter.ujfalusi@ti.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 09:51:53 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Hi Peter,

Change looks sensible to me, but I'd like to leave a little longer
for others to look at this.

Give me a poke if I seem to have lost it by the end of the first
week in Jan.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 3b291d72701c..5dab23f1fdee 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1746,9 +1746,15 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
>  	struct dma_slave_config config;
>  	int ret;
>  
> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> -	if (!adc->dma_chan)
> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
> +	if (IS_ERR(adc->dma_chan)) {
> +		if (PTR_ERR(adc->dma_chan) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		/* Ignore errors to fall back to IRQ mode */
> +		adc->dma_chan = NULL;
>  		return 0;
> +	}
>  
>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>  					 STM32_DMA_BUFFER_SIZE,

