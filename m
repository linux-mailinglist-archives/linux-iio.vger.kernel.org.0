Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1E14D208
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgA2Uiy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 15:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgA2Uix (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jan 2020 15:38:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5230E20702;
        Wed, 29 Jan 2020 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580330333;
        bh=qNiMEXw2OMq3yQf+yM13b64RxSKj3AzWpXBPeM61NKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gjQ4JAx6oTiQjRLTT6FyJbhvrioT+IzWSFCDLHMOo+fkWvTPO0NYb4w7zJgj1wPg0
         y94X1s6j+RPE3U7asyVVOpo1KsHqy97XLRp+6WriEBtzKODukMxboj67INtSjeYYu1
         BkcT3QQE/2lbWQpRoGWM5n/2OHdJ8NGfcvEAVZxI=
Date:   Wed, 29 Jan 2020 20:38:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: accel: st_accel: Use
 st_sensors_dev_name_probe()
Message-ID: <20200129203848.73dd3a9b@archlinux>
In-Reply-To: <20200120092550.39427-1-andriy.shevchenko@linux.intel.com>
References: <20200120092550.39427-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jan 2020 11:25:50 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use st_sensors_dev_name_probe() instead open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to start poking at it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_i2c.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 633955d764cc..8c489312f668 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -147,12 +147,9 @@ static int st_accel_i2c_probe(struct i2c_client *client)
>  	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *adata;
>  	struct iio_dev *indio_dev;
> -	const char *match;
>  	int ret;
>  
> -	match = device_get_match_data(&client->dev);
> -	if (match)
> -		strlcpy(client->name, match, sizeof(client->name));
> +	st_sensors_dev_name_probe(&client->dev, client->name, sizeof(client->name));
>  
>  	settings = st_accel_get_settings(client->name);
>  	if (!settings) {

