Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65CF43E27F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhJ1NvN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 28 Oct 2021 09:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhJ1NvN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 09:51:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1341F61038;
        Thu, 28 Oct 2021 13:48:44 +0000 (UTC)
Date:   Thu, 28 Oct 2021 14:53:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] iio: accel: mma7660: Warn about failure to put device
 in stand-by in .remove()
Message-ID: <20211028145311.6e7637ef@jic23-huawei>
In-Reply-To: <20211025195007.84541-1-u.kleine-koenig@pengutronix.de>
References: <20211025195007.84541-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Oct 2021 21:50:07 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Whan an i2c driver's remove function returns a non-zero error code
> nothing happens apart from emitting a generic error message. Make this
> error message more device specific and return zero instead.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Applied to the togreg branch of iio.git.

Note this will be a next cycle thing now as we are too close to the
merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma7660.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 47f5cd66e996..78c20618fdc3 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -210,10 +210,16 @@ static int mma7660_probe(struct i2c_client *client,
>  static int mma7660_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	int ret;
>  
>  	iio_device_unregister(indio_dev);
>  
> -	return mma7660_set_mode(iio_priv(indio_dev), MMA7660_MODE_STANDBY);
> +	ret = mma7660_set_mode(iio_priv(indio_dev), MMA7660_MODE_STANDBY);
> +	if (ret)
> +		dev_warn(&client->dev, "Failed to put device in stand-by mode (%pe), ignoring\n",
> +			 ERR_PTR(ret));
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP

