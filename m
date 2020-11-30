Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3C2C8F74
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgK3Uwg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 15:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgK3Uwg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Nov 2020 15:52:36 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63E52067C;
        Mon, 30 Nov 2020 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606769515;
        bh=3XghvH5+1v33ZLMdARgX+avrewzieVS+TSC2JtzLutU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aPn82KC+7TsgO1p50On/RpxsdkdxehvDVjENxlBHJb8vS5DCW2qBRn8td+uDw9Qim
         7UVlZy8wTmggp795MZgOeYXSrVlSdOaY/L8FL91BjKzzHllCt8K3/1KIsZzooea1Y8
         wbWabkJhgnwTCAO11y2hqDW8wb0ADHOwITgvg7IA=
Date:   Mon, 30 Nov 2020 20:51:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: gyro: mpu3050: Use devm_ to set up buffer
Message-ID: <20201130205150.052fb114@archlinux>
In-Reply-To: <20201130125915.1315667-1-linus.walleij@linaro.org>
References: <20201130125915.1315667-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Nov 2020 13:59:14 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This makes use of devm_iio_triggered_buffer_setup() to
> save some minor overhead.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus,

I'm very fussy about mixing devm and other cleanup.  Unless everything
that happens after this point is also managed, I'm not happy to see
an individual function made managed.  It may be safe, but
if fails the 'obviously safe' test.

Something odd going on here though.  We are currently removing the
buffer before we unregister the userspace interfaces to it.
That's not a good idea.  The remove order seems reverse from
what it should be...

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 00e58060968c..0d0850945d3a 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1203,9 +1203,10 @@ int mpu3050_common_probe(struct device *dev,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = name;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> -					 mpu3050_trigger_handler,
> -					 &mpu3050_buffer_setup_ops);
> +	ret = devm_iio_triggered_buffer_setup(dev,
> +					indio_dev, iio_pollfunc_store_time,
> +					mpu3050_trigger_handler,
> +					&mpu3050_buffer_setup_ops);
>  	if (ret) {
>  		dev_err(dev, "triggered buffer setup failed\n");
>  		goto err_power_down;
> @@ -1214,7 +1215,7 @@ int mpu3050_common_probe(struct device *dev,
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		dev_err(dev, "device register failed\n");
> -		goto err_cleanup_buffer;
> +		goto err_power_down;
>  	}
>  
>  	dev_set_drvdata(dev, indio_dev);
> @@ -1241,8 +1242,6 @@ int mpu3050_common_probe(struct device *dev,
>  
>  	return 0;
>  
> -err_cleanup_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
>  err_power_down:
>  	mpu3050_power_down(mpu3050);
>  
> @@ -1258,7 +1257,6 @@ int mpu3050_common_remove(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
>  	if (mpu3050->irq)
>  		free_irq(mpu3050->irq, mpu3050);
>  	iio_device_unregister(indio_dev);

