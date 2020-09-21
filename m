Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18CA2727EA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgIUOkS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgIUOkP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 10:40:15 -0400
X-Greylist: delayed 923 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Sep 2020 07:40:15 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAFCC061755
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2020 07:40:15 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1kKMkI-0001QY-7F; Mon, 21 Sep 2020 16:24:46 +0200
Date:   Mon, 21 Sep 2020 16:24:46 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 03/38] iio:potentiometer:max5432: Drop of_match_ptr and
 use generic fw accessors
Message-ID: <20200921142446.qejv2uroxwcjfmxe@viti.kaiser.cx>
References: <20200910173242.621168-1-jic23@kernel.org>
 <20200910173242.621168-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910173242.621168-4-jic23@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thus wrote Jonathan Cameron (jic23@kernel.org):

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> These prevent use of this driver with ACPI via PRP0001 and are
> an example of an anti pattern I'm trying to remove from IIO.
> Drop them to remove this restriction.

> Also switch headers to reflect this change.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/iio/potentiometer/max5432.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
> index 280de9c54471..aed3b6ab82a2 100644
> --- a/drivers/iio/potentiometer/max5432.c
> +++ b/drivers/iio/potentiometer/max5432.c
> @@ -11,8 +11,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/limits.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>

>  /* All chip variants have 32 wiper positions. */
>  #define MAX5432_MAX_POS 31
> @@ -100,7 +100,7 @@ static int max5432_probe(struct i2c_client *client,

>  	data = iio_priv(indio_dev);
>  	data->client = client;
> -	data->ohm = (unsigned long)of_device_get_match_data(dev);
> +	data->ohm = (unsigned long)device_get_match_data(dev);

>  	indio_dev->info = &max5432_info;
>  	indio_dev->channels = max5432_channels;
> @@ -122,7 +122,7 @@ MODULE_DEVICE_TABLE(of, max5432_dt_ids);
>  static struct i2c_driver max5432_driver = {
>  	.driver = {
>  		.name = "max5432",
> -		.of_match_table = of_match_ptr(max5432_dt_ids),
> +		.of_match_table = max5432_dt_ids,
>  	},
>  	.probe = max5432_probe,
>  };
> -- 
> 2.28.0

Looks good to me.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
