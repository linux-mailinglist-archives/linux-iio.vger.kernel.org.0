Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715FE43E3A1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJ1O3N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1O3M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:29:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CEE61106;
        Thu, 28 Oct 2021 14:26:44 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:31:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imx7d_adc: Don't pass IIO device to
 imx7d_adc_{enable,disable}()
Message-ID: <20211028153110.7b1e41ff@jic23-huawei>
In-Reply-To: <20211020085754.16654-1-lars@metafoo.de>
References: <20211020085754.16654-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Oct 2021 10:57:54 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The `imx7d_adc_enable()` and `imx7d_adc_disable()` functions are used as
> the suspend and resume callbacks for the device. When called as
> suspend/resume functions they are called with the platform_device's device
> as their parameter.
> 
> In addition the functions are called on device probe and remove. In this
> case they are passed the struct device of the IIO device that the driver
> registers.
> 
> This works because in the `imx7d_adc_{enable,disable}()` functions the
> passed struct device is only ever used as a parameter to `dev_get_drvdata()`
> and `dev_get_drvdata()` returns the same value for the platform device and
> the IIO device.
> 
> But for consistency we should pass the same struct device to the
> `imx7d_adc_{enable,disable}()` in all cases. This will avoid accidental
> breakage if the device is ever used for something more than
> `dev_get_drvdata()`.
> 
> Another motivation is that `dev_get_drvdata()` on the IIO device relies on
> the IIO core calling `dev_set_drvdata()`. Something we want to remove.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git and pushed out as testing to let 0-day
work its magic.

Note, plenty of time for reviews before I push this out as non rebasing if
anyone else has time to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 4969a5f941e3..7abf0ad526a3 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -528,12 +528,11 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  
>  	imx7d_adc_feature_config(info);
>  
> -	ret = imx7d_adc_enable(&indio_dev->dev);
> +	ret = imx7d_adc_enable(dev);
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_add_action_or_reset(dev, __imx7d_adc_disable,
> -				       &indio_dev->dev);
> +	ret = devm_add_action_or_reset(dev, __imx7d_adc_disable, dev);
>  	if (ret)
>  		return ret;
>  

