Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42B844F430
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhKMQpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 11:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhKMQpZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 11:45:25 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9A8604DA;
        Sat, 13 Nov 2021 16:42:31 +0000 (UTC)
Date:   Sat, 13 Nov 2021 16:47:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Remove unnecessary print function
 dev_err()
Message-ID: <20211113164718.139af103@jic23-huawei>
In-Reply-To: <20211105015504.39226-1-vulab@iscas.ac.cn>
References: <20211105015504.39226-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  5 Nov 2021 01:55:04 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Applied, thanks

Jonathan
> ---
>  drivers/iio/adc/rzg2l_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 32fbf57c362f..9d5be52bd948 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -506,10 +506,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "no irq resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
>  			       0, dev_name(dev), adc);

