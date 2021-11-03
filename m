Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D02444927
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 20:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCTvF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 15:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhKCTvE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 15:51:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A890861053;
        Wed,  3 Nov 2021 19:48:26 +0000 (UTC)
Date:   Wed, 3 Nov 2021 19:53:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jack Andersen <jackoalan@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dln2: Check return value of
 devm_iio_trigger_register()
Message-ID: <20211103195300.25a7670b@jic23-huawei>
In-Reply-To: <20211101133043.6974-1-lars@metafoo.de>
References: <20211101133043.6974-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Nov 2021 14:30:43 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Registering a trigger can fail and the return value of
> devm_iio_trigger_register() must be checked. Otherwise undefined behavior
> can occur when the trigger is used.
> 
> Fixes: 7c0299e879dd ("iio: adc: Add support for DLN2 ADC")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Seems obvious enough to pick up and won't go upstream until after the
merge window anyway so time for any feedback to come in.

Anyhow, applied to the fixes-togreg branch of iio.git and
marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/dln2-adc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index 16407664182c..846c92296221 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -656,7 +656,11 @@ static int dln2_adc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  	iio_trigger_set_drvdata(dln2->trig, dln2);
> -	devm_iio_trigger_register(dev, dln2->trig);
> +	ret = devm_iio_trigger_register(dev, dln2->trig);
> +	if (ret) {
> +		dev_err(dev, "failed to register trigger: %d\n", ret);
> +		return ret;
> +	}
>  	iio_trigger_set_immutable(indio_dev, dln2->trig);
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,

