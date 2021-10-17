Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7C4309EB
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbhJQPAt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 11:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343940AbhJQPAs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 11:00:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B884D60C4D;
        Sun, 17 Oct 2021 14:58:37 +0000 (UTC)
Date:   Sun, 17 Oct 2021 16:02:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: xilinx-xadc: Remove `irq` field from state struct
Message-ID: <20211017160252.38700e19@jic23-huawei>
In-Reply-To: <20211017121551.24063-1-lars@metafoo.de>
References: <20211017121551.24063-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Oct 2021 14:15:51 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Since commit 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and
> remove remove()") the `irq` field from XADC driver state struct is only
> used in the `probe()` function.
> 
> Use the local `irq` variable throughout the `probe()` function and remove
> the now unused field from the state struct.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Make sense.

Applied to the iio-togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 5 ++---
>  drivers/iio/adc/xilinx-xadc.h      | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 198d2916266d..83bea5ef765d 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1332,7 +1332,6 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	xadc = iio_priv(indio_dev);
>  	xadc->ops = id->data;
> -	xadc->irq = irq;
>  	init_completion(&xadc->completion);
>  	mutex_init(&xadc->mutex);
>  	spin_lock_init(&xadc->lock);
> @@ -1397,7 +1396,7 @@ static int xadc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
> +	ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler, 0,
>  			       dev_name(dev), indio_dev);
>  	if (ret)
>  		return ret;
> @@ -1407,7 +1406,7 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
> +	ret = xadc->ops->setup(pdev, indio_dev, irq);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index 8b80195725e9..7d78ce698967 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -67,7 +67,6 @@ struct xadc {
>  	spinlock_t lock;
>  
>  	struct completion completion;
> -	int irq;
>  };
>  
>  enum xadc_type {

