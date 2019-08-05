Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3C82046
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfHEPcR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfHEPcR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:32:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C5D20B1F;
        Mon,  5 Aug 2019 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565019136;
        bh=5Fo1lcrk0QBH+nQkQEA4eroaNHcmo/SoobrETrf2H2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U86SO7xoHwFOD2M90mxGhLow/fXDhWnWdl0RzdQrXOi6UPr5x0pz7iSHOGldoClRt
         rXOvXuB2KnZnWcG1Blzgx2T3b3S/8b3rmDLmSryB0LTxBKXtryQeYPDaGy0RSTrVcJ
         oZTUPO7HhwKoeqjiJO1J3mjN1vXTpa1nDSqg9rO8=
Date:   Mon, 5 Aug 2019 16:32:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: tsl2772: Use devm_iio_device_register
Message-ID: <20190805163157.1ee0c0c0@archlinux>
In-Reply-To: <20190801073612.9689-1-hslester96@gmail.com>
References: <20190801073612.9689-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Aug 2019 15:36:12 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use devm_iio_device_register, which removes the tsl2772_remove
> function.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.

Thanks,

J
> ---
> Changes in v4:
>   - Split v3 into three patches.
>   - Revise description to make it more precise.
> 
>  drivers/iio/light/tsl2772.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index e866ae40f157..680afdb078d2 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1890,14 +1890,7 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&clientp->dev,
> -			"%s: iio registration failed\n", __func__);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return devm_iio_device_register(&clientp->dev, indio_dev);
>  }
>  
>  static int tsl2772_suspend(struct device *dev)
> @@ -1934,15 +1927,6 @@ static int tsl2772_resume(struct device *dev)
>  	return tsl2772_chip_on(indio_dev);
>  }
>  
> -static int tsl2772_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id tsl2772_idtable[] = {
>  	{ "tsl2571", tsl2571 },
>  	{ "tsl2671", tsl2671 },
> @@ -1989,7 +1973,6 @@ static struct i2c_driver tsl2772_driver = {
>  	},
>  	.id_table = tsl2772_idtable,
>  	.probe = tsl2772_probe,
> -	.remove = tsl2772_remove,
>  };
>  
>  module_i2c_driver(tsl2772_driver);

