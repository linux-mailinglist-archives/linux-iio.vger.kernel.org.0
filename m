Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157929F034
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 16:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgJ2Pio (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 11:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgJ2Pio (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 11:38:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFCC2076E;
        Thu, 29 Oct 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603985923;
        bh=Y2j8bDq8gMUZy8zARJTkEfGUrc17A2GF2McIejrCvnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVaXIUx8A/CDynW1RHxXxSbPP4KcQYMa9FdVzvFN9SMyMuzX2xNEeTYxrPsd7rhqu
         nApNa0Veb+0QDZAl2TfI7We4Lz33f3MRqfGjgm1pDUmz85t8lLLHeETr8CiJKGPsEk
         +pxaHqHmeK/TY9aMcfjBX4js2q8dxGRtOBQGrmdY=
Date:   Thu, 29 Oct 2020 15:38:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 3/5] iio: adc: xilinx: use a devres action to disable
 and unprepare the clock
Message-ID: <20201029153838.069b46f5@archlinux>
In-Reply-To: <20201026133609.24262-4-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
        <20201026133609.24262-4-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Oct 2020 14:36:07 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to simplify resource management and error paths in probe(), add
> a devm action that calls clk_disable_unprepare() at driver detach.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index b516280ccbd4..e0da6258092c 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1185,6 +1185,13 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	return 0;
>  }
>  
> +static void xadc_clk_disable_unprepare(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
>  static int xadc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1262,6 +1269,11 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_samplerate_trigger;
>  

Hi Bartosz,

> +	ret = devm_add_action_or_reset(dev,
> +				       xadc_clk_disable_unprepare, xadc->clk);

Take advantage of flexibility in line length limit and put that on line line.

The moment I see a devm call with a goto in the error path I get suspicious about
ordering.  

So why do we have actions in the error paths of probe that don't turn up
in the remove function?  Fix that before you do this change.

There are some cases in here already that push the limits on this
such as clock allocation but they are easily argued as safe.  This is getting
less obvious.


Jonathan


> +	if (ret)
> +		goto err_free_samplerate_trigger;
> +
>  	/*
>  	 * Make sure not to exceed the maximum samplerate since otherwise the
>  	 * resulting interrupt storm will soft-lock the system.
> @@ -1280,7 +1292,7 @@ static int xadc_probe(struct platform_device *pdev)
>  	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
>  			  dev_name(dev), indio_dev);
>  	if (ret)
> -		goto err_clk_disable_unprepare;
> +		goto err_free_samplerate_trigger;
>  
>  	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
>  	if (ret)
> @@ -1344,8 +1356,6 @@ static int xadc_probe(struct platform_device *pdev)
>  err_free_irq:
>  	free_irq(xadc->irq, indio_dev);
>  	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
> -err_clk_disable_unprepare:
> -	clk_disable_unprepare(xadc->clk);
>  err_free_samplerate_trigger:
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>  		iio_trigger_free(xadc->samplerate_trigger);
> @@ -1372,7 +1382,6 @@ static int xadc_remove(struct platform_device *pdev)
>  	}
>  	free_irq(xadc->irq, indio_dev);
>  	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
> -	clk_disable_unprepare(xadc->clk);
>  
>  	return 0;
>  }

