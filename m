Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6693717CEEB
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgCGPIH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGPIH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:08:07 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91AEB20675;
        Sat,  7 Mar 2020 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583593686;
        bh=RQpDqkyyxmFg9c3rc/jOhh1yQA+Hq7TSDoK7PRzgQ0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRgraDd5g2lyhqe/VHYJfWH8Kx0++0nF5g8fRF/GUXbIuEPV9DQEEa1eot9plToWK
         vpMZCqgUDGZG+77uAOPhuyjJUC1uClW+UBh0S8S+YKoo8YF15uRlT08pYMHJjPDCJJ
         PsQvSvEBfJGiP17xk+Yba/GFY1PuY6mHGdbrQqAI=
Date:   Sat, 7 Mar 2020 15:08:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32-adc: fix sleep in atomic context
Message-ID: <20200307150801.011f35b2@archlinux>
In-Reply-To: <20200306155335.6019-1-olivier.moysan@st.com>
References: <20200306155335.6019-1-olivier.moysan@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Mar 2020 16:53:35 +0100
Olivier Moysan <olivier.moysan@st.com> wrote:

> This commit fixes the following error:
> "BUG: sleeping function called from invalid context at kernel/irq/chip.c"
> 
> In DMA mode suppress the trigger irq handler, and make the buffer
> transfers directly in DMA callback, instead.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
looks good to me, but... fixes tag?

We probably want to backport this so good to know when we introduced
the issue.

Thanks,

Jonathan

> ---
> This solution has been already discussed in the thread
> https://lkml.org/lkml/2019/3/30/171, and applied in STM32 DFSDM driver:
> e19ac9d9a978 ("iio: adc: stm32-dfsdm: fix sleep in atomic context")
> ---
>  drivers/iio/adc/stm32-adc.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 80c3f963527b..ae622ee6d08c 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1418,8 +1418,30 @@ static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
>  static void stm32_adc_dma_buffer_done(void *data)
>  {
>  	struct iio_dev *indio_dev = data;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int residue = stm32_adc_dma_residue(adc);
> +
> +	/*
> +	 * In DMA mode the trigger services of IIO are not used
> +	 * (e.g. no call to iio_trigger_poll).
> +	 * Calling irq handler associated to the hardware trigger is not
> +	 * relevant as the conversions have already been done. Data
> +	 * transfers are performed directly in DMA callback instead.
> +	 * This implementation avoids to call trigger irq handler that
> +	 * may sleep, in an atomic context (DMA irq handler context).
> +	 */
> +	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
>  
> -	iio_trigger_poll_chained(indio_dev->trig);
> +	while (residue >= indio_dev->scan_bytes) {
> +		u16 *buffer = (u16 *)&adc->rx_buf[adc->bufi];
> +
> +		iio_push_to_buffers(indio_dev, buffer);
> +
> +		residue -= indio_dev->scan_bytes;
> +		adc->bufi += indio_dev->scan_bytes;
> +		if (adc->bufi >= adc->rx_buf_sz)
> +			adc->bufi = 0;
> +	}
>  }
>  
>  static int stm32_adc_dma_start(struct iio_dev *indio_dev)
> @@ -1845,6 +1867,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
>  	struct device *dev = &pdev->dev;
> +	irqreturn_t (*handler)(int irq, void *p) = NULL;
>  	struct stm32_adc *adc;
>  	int ret;
>  
> @@ -1911,9 +1934,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!adc->dma_chan)
> +		handler = &stm32_adc_trigger_handler;
> +
>  	ret = iio_triggered_buffer_setup(indio_dev,
> -					 &iio_pollfunc_store_time,
> -					 &stm32_adc_trigger_handler,
> +					 &iio_pollfunc_store_time, handler,
>  					 &stm32_adc_buffer_setup_ops);
>  	if (ret) {
>  		dev_err(&pdev->dev, "buffer setup failed\n");

