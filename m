Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6632FC3F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhCFRVF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhCFRUm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:20:42 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1448C65017;
        Sat,  6 Mar 2021 17:20:40 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:20:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: adc: at91-sama5d2: initialize hardware after
 clock is started
Message-ID: <20210306172038.482b2b9a@archlinux>
In-Reply-To: <20210301143256.16502-3-eugen.hristev@microchip.com>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
        <20210301143256.16502-3-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Mar 2021 16:32:54 +0200
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> The hw_init hardware init call must happen after the clock is prepared and
> enabled. Otherwise, writing to the registers might lead to a block or
> external abort.

Fix for existing parts or something only needed for the new devices?
If it's a fix we should be looking to back port it so please
provide me with a fixes tag.

If it's a fix but not super urgent then let me know and we can
take it with the rest of this series (and hence keep things simple)

Thanks,

Jonathan

> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index a7826f097b95..63325f037f09 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1832,12 +1832,12 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		goto vref_disable;
>  	}
>  
> -	at91_adc_hw_init(indio_dev);
> -
>  	ret = clk_prepare_enable(st->per_clk);
>  	if (ret)
>  		goto vref_disable;
>  
> +	at91_adc_hw_init(indio_dev);
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = at91_adc_buffer_and_trigger_init(&pdev->dev, indio_dev);

