Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BED12986C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLWPpn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfLWPpn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:45:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E788205C9;
        Mon, 23 Dec 2019 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577115942;
        bh=dMvuhm75mr3sKsjJ7Ywmef0XPGuVcGPnp7cfWIxsSCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DaHSqFaCNmeahbQvTb1DfZhJNooZK+BVo6taxtGIlc5mPJD4W3/FyBXlDK2WofP/V
         9EFQtQCR7tggAtHZKUrGnV/EsHhMKe2KKfkzC9cP1pre4W3q2jMtYbPkpIgyG5bGxX
         /kVcHXicrY2042NtyLlZClV0KvhGolQp//VCTKB0=
Date:   Mon, 23 Dec 2019 15:45:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20191223154538.74a76f94@archlinux>
In-Reply-To: <20191217075221.23895-1-peter.ujfalusi@ti.com>
References: <20191217075221.23895-1-peter.ujfalusi@ti.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 09:52:21 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
I don't think this one goes far enough.  

One of the paths does:

	/* Optionally request DMA */
	if (stm32_dfsdm_dma_request(indio_dev)) {
		dev_dbg(&indio_dev->dev, "No DMA support\n");
		return 0;
	}

That needs specific handling for deferred probing.

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index e493242c266e..3aac1a21f9d0 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1383,9 +1383,9 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  
> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> -	if (!adc->dma_chan)
> -		return -EINVAL;
> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
> +	if (IS_ERR(adc->dma_chan))
> +		return PTR_ERR(adc->dma_chan);
>  
>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>  					 DFSDM_DMA_BUFFER_SIZE,

