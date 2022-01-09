Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCA488A0E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 16:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiAIPEx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 10:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAIPEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 10:04:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9244C06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 07:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB35B80D3B
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 15:04:51 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id BA002C36AEB;
        Sun,  9 Jan 2022 15:04:48 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:10:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mma8452: Fix probe failing when an i2c_device_id
 is used
Message-ID: <20220109151043.54d92a79@jic23-huawei>
In-Reply-To: <20220106111414.66421-1-hdegoede@redhat.com>
References: <20220106111414.66421-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Jan 2022 12:14:14 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> The mma8452_driver declares both of_match_table and i2c_driver.id_table
> match-tables, but its probe() function only checked for of matches.
> 
> Add support for i2c_device_id matches. This fixes the driver not loading
> on some x86 tablets (e.g. the Nextbook Ares 8) where the i2c_client is
> instantiated by platform code using an i2c_device_id.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Hi Hans,

At some point we'll want to get rid of the of_ specific stuff in here in
favour of generic firmware properties and I suspect at that time we'll
move the device name into the chip_info_table[] entries so that we
can just use device_get_match_data()

In the meantime this fix looks good to me.  Is there an appropriate
Fixes: tag?

Thanks,

Jonathan


> ---
>  drivers/iio/accel/mma8452.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 09c7f10fefb6..c82841c0a7b3 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1523,12 +1523,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int ret;
>  	const struct of_device_id *match;
> -
> -	match = of_match_device(mma8452_dt_ids, &client->dev);
> -	if (!match) {
> -		dev_err(&client->dev, "unknown device model\n");
> -		return -ENODEV;
> -	}
> +	const char *compatible;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1537,7 +1532,19 @@ static int mma8452_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
> -	data->chip_info = match->data;
> +
> +	if (id) {
> +		compatible = id->name;
> +		data->chip_info = &mma_chip_info_table[id->driver_data];
> +	} else {
> +		match = of_match_device(mma8452_dt_ids, &client->dev);
> +		if (!match) {
> +			dev_err(&client->dev, "unknown device model\n");
> +			return -ENODEV;
> +		}
> +		compatible = match->compatible;
> +		data->chip_info = match->data;
> +	}
>  
>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_reg))
> @@ -1581,7 +1588,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	}
>  
>  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
> -		 match->compatible, data->chip_info->chip_id);
> +		 compatible, data->chip_info->chip_id);
>  
>  	i2c_set_clientdata(client, indio_dev);
>  	indio_dev->info = &mma8452_info;

