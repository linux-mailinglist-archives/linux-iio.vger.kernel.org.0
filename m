Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6451F2B2EC8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKNRNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKNRNq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 12:13:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F02E220B80;
        Sat, 14 Nov 2020 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605374025;
        bh=7Bx7OgTMf7K1V49Siex8+pfgI4ga4zani3QVJHYL0tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W6WLORTzjZDqjTxARI7WVd1eSW69I/gxp2zSSs047eoJG7N+HiaI/oCPEdKCNJ+QT
         EiC0JskYq/gYuh1RiPKi+S3p6fCoZXHMGYR8xh/0t23tHFVhgl1pX8YPDmn9prfNbW
         EFWY0a8Y1kyYGbOo2mW0HWuRxA5UikbhtVSXJa8Y=
Date:   Sat, 14 Nov 2020 17:13:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iio: adc: at91_adc: use devm_input_allocate_device
Message-ID: <20201114171340.2bf0d61e@archlinux>
In-Reply-To: <20201113212650.507680-8-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
        <20201113212650.507680-8-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 22:26:48 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Use devm_input_allocate_device to allocate the input device to simplify the
> error and remove paths.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

This one I'm less keen on.  Whilst it's obviously not a problem in
this particular case I'd ideally like to keep the remove order
as the exact reverse of probe - that makes it easy to review changes
quickly.

Now, you could easily enough make this fine by using devm for the
other items that happen before this (dev_add_action_or_reset needed
in a few cases).

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 76aeebce6f4d..d09ceb315c5a 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -937,9 +937,8 @@ static int at91_ts_register(struct iio_dev *idev,
>  {
>  	struct at91_adc_state *st = iio_priv(idev);
>  	struct input_dev *input;
> -	int ret;
>  
> -	input = input_allocate_device();
> +	input = devm_input_allocate_device(&pdev->dev);
>  	if (!input) {
>  		dev_err(&idev->dev, "Failed to allocate TS device!\n");
>  		return -ENOMEM;
> @@ -964,8 +963,7 @@ static int at91_ts_register(struct iio_dev *idev,
>  		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
>  			dev_err(&pdev->dev,
>  				"This touchscreen controller only support 4 wires\n");
> -			ret = -EINVAL;
> -			goto err;
> +			return -EINVAL;
>  		}
>  
>  		input_set_abs_params(input, ABS_X, 0, (1 << MAX_RLPOS_BITS) - 1,
> @@ -977,20 +975,7 @@ static int at91_ts_register(struct iio_dev *idev,
>  	st->ts_input = input;
>  	input_set_drvdata(input, st);
>  
> -	ret = input_register_device(input);
> -	if (ret)
> -		goto err;
> -
> -	return ret;
> -
> -err:
> -	input_free_device(st->ts_input);
> -	return ret;
> -}
> -
> -static void at91_ts_unregister(struct at91_adc_state *st)
> -{
> -	input_unregister_device(st->ts_input);
> +	return input_register_device(input);
>  }
>  
>  static int at91_adc_probe(struct platform_device *pdev)
> @@ -1203,8 +1188,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (!st->touchscreen_type) {
>  		at91_adc_trigger_remove(idev);
>  		at91_adc_buffer_remove(idev);
> -	} else {
> -		at91_ts_unregister(st);
>  	}
>  error_disable_adc_clk:
>  	clk_disable_unprepare(st->adc_clk);
> @@ -1224,8 +1207,6 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	if (!st->touchscreen_type) {
>  		at91_adc_trigger_remove(idev);
>  		at91_adc_buffer_remove(idev);
> -	} else {
> -		at91_ts_unregister(st);
>  	}
>  	clk_disable_unprepare(st->adc_clk);
>  	clk_disable_unprepare(st->clk);

