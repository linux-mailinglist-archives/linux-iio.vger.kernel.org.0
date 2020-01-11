Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC913810F
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgAKLPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbgAKLPH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:15:07 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EFA2082E;
        Sat, 11 Jan 2020 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578741306;
        bh=erQ6M4hMxHylqYfd9kNe8cMwdxxMfWcIL4nVaDchgOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rS1kqrVm1bYPDTCdYCZ7pPKr3VxaGwvPOLjF4nIlSfHNWyOhHgS+RPt9G6E5oRANy
         AJO+4ejKwlLNFNzmCRAk66UcsP4n4d39IwI1iE9na5KlMLinn3F7NPGxPwb/py1m1x
         yLWdoaKD8aCDqWIrs2w3vtaK9MhmeY9u0slnnoTE=
Date:   Sat, 11 Jan 2020 11:15:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     <vkoul@kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: Use dma_request_chan()
 instead dma_request_slave_channel()
Message-ID: <20200111111501.77d19476@archlinux>
In-Reply-To: <20200107113729.5505-1-peter.ujfalusi@ti.com>
References: <20200107113729.5505-1-peter.ujfalusi@ti.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Jan 2020 13:37:29 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> The dma_request_chan() is the standard API to request slave channel,
> clients should be moved away from the legacy API to allow us to retire
> them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied to the togreg branch of iio.git and pushed out as testing.
Note that tree will get rebased shortly to catch up with upstream.
(testing can in theory be rebased at any time even if I don't do it
that often).

Thanks,

Jonathan

> ---
> Hi,
> 
> Changes since v2:
> - Commit message updated
> 
> Changes since v1:
> - Subject prefix is corrected to "iio: adc: at91-sama5d2_adc:"
> 
> Regards,
> Peter
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e1850f3d5cf3..a5c7771227d5 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1444,10 +1444,10 @@ static void at91_adc_dma_init(struct platform_device *pdev)
>  	if (st->dma_st.dma_chan)
>  		return;
>  
> -	st->dma_st.dma_chan = dma_request_slave_channel(&pdev->dev, "rx");
> -
> -	if (!st->dma_st.dma_chan)  {
> +	st->dma_st.dma_chan = dma_request_chan(&pdev->dev, "rx");
> +	if (IS_ERR(st->dma_st.dma_chan))  {
>  		dev_info(&pdev->dev, "can't get DMA channel\n");
> +		st->dma_st.dma_chan = NULL;
>  		goto dma_exit;
>  	}
>  

