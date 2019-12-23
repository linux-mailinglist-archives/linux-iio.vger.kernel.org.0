Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE212987C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWPuH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfLWPuH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:50:07 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBEEE20663;
        Mon, 23 Dec 2019 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577116206;
        bh=RMoTjXwZcjIZ4sWdkpbd+CDNN2WUkeQnAYsgLbSVu54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FDm6HjWvnEvmXVY0d+ZFGhVyJKlxV+7EhJpQtv6xEMM41psUFVFCb57loxIJZgKiJ
         8ESQcAoSB6lRrFp44fsrTaQP6YSbeMkKuLIiIstmeTo2dJg78X7g2ywMc2LZiExtCp
         /Ukdrs/au3+oxV4Rfu/LE4M+uEPDymjU8xXO+It8=
Date:   Mon, 23 Dec 2019 15:50:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     <vkoul@kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: Use dma_request_chan()
 instead dma_request_slave_channel()
Message-ID: <20191223155001.3c4c7261@archlinux>
In-Reply-To: <20191217103100.21737-1-peter.ujfalusi@ti.com>
References: <20191217103100.21737-1-peter.ujfalusi@ti.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 12:31:00 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
Unfortunately that doesn't seem to be true.
The function in question returns void...

And for that matter is called only from the set_watermark callback which
doesn't run at probe time.

So if we were to get a deferred response at runtime there isn't a whole
lot we could do with it.

Jonathan



> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
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

