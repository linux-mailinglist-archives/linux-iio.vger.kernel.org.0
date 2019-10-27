Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5185E63DF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJ0P6m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 11:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfJ0P6m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 11:58:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDA620873;
        Sun, 27 Oct 2019 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572191921;
        bh=66tHgdFuZFgwvfMgb7+hbPciCMsrO5SrqRnt9hjmZ1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wf+tMYqVxXsb/cfDFmgvgPoKwpWL1D6/od446FGICrGRm0LTENlOwSfb+bZP39CaC
         L+YBLArt/NSlK1PMzP08+dVPdbKM/wQGsNZDiPtLZdzh9ekovGl9V7uOS2AHNiLiTw
         ngMYY9lTMV0XSL+UNnmJgDb9uQH75z1845RCRLyA=
Date:   Sun, 27 Oct 2019 15:58:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: fix stopping dma
Message-ID: <20191027155836.2e3d8ebf@archlinux>
In-Reply-To: <1572015860-8931-1-git-send-email-fabrice.gasnier@st.com>
References: <1572015860-8931-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Oct 2019 17:04:20 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> There maybe a race when using dmaengine_terminate_all(). The predisable
> routine may call iio_triggered_buffer_predisable() prior to a pending DMA
> callback.
> Adopt dmaengine_terminate_sync() to ensure there's no pending DMA request
> before calling iio_triggered_buffer_predisable().
> 
> Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
I'm guessing this is not something that has been observed in practice, but
seems like a safe fix anyway to backport.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 663f8a5..73aee59 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1399,7 +1399,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
>  	if (ret) {
> -		dmaengine_terminate_all(adc->dma_chan);
> +		dmaengine_terminate_sync(adc->dma_chan);
>  		return ret;
>  	}
>  
> @@ -1477,7 +1477,7 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  		stm32_adc_conv_irq_disable(adc);
>  
>  	if (adc->dma_chan)
> -		dmaengine_terminate_all(adc->dma_chan);
> +		dmaengine_terminate_sync(adc->dma_chan);
>  
>  	if (stm32_adc_set_trig(indio_dev, NULL))
>  		dev_err(&indio_dev->dev, "Can't clear trigger\n");

