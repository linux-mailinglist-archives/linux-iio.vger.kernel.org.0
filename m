Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F592A1EED
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKAPQT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgKAPQT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:16:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFF62224E;
        Sun,  1 Nov 2020 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604243778;
        bh=LixH8u9qVBLnTBl3AYfgoqK3zif6KQ2jZa5vZYWYUfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9nFKi801Yb9bzuwiVz6/lzhoZYyGKFEeLjCd8OCk9yhd6UlMbOw9OrCCqIO8UJlM
         RYPRlIuptMOmz3h7NOdE2Igu15mp9CHJ+K2wdOxiw9dLR8eQGplJUrrbCsjDn0tKk7
         UQOE4ZelwJ49tA4wDzfk45rVBK6frdouuKOQzVGA=
Date:   Sun, 1 Nov 2020 15:16:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     andy.shevchenko@gmail.com, wsa@kernel.org,
        songqiang1304521@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        alexandru.ardelean@analog.com, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: Re: [PATCH v4] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201101151612.71c3fa1b@archlinux>
In-Reply-To: <20201018195102.GA814713@ubuntu>
References: <20201018195102.GA814713@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Oct 2020 01:21:02 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> Add i2c_device_id table for the vl53l0x-i2c driver,
> helps in device instantiation using i2c_new_client_device()
> or from userspace in cases where device-tree based description
> is not possible now, like device(s) on a gbphy i2c adapter
> created by greybus.
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can find any issues.

Thanks,

Jonathan

> 
> ---
>  v4:
> 	-update commit message, add punctuation
>  v3:
> 	-modify commit message for readability
> 	 as suggested by Jonathan Cameron
>  v2:
> 	-fix commit message
>  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 5fbda9475ba9..7c29d4cae24a 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -143,6 +143,12 @@ static int vl53l0x_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> +static const struct i2c_device_id vl53l0x_id[] = {
> +	{ "vl53l0x", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
> +
>  static const struct of_device_id st_vl53l0x_dt_match[] = {
>  	{ .compatible = "st,vl53l0x", },
>  	{ }
> @@ -155,6 +161,7 @@ static struct i2c_driver vl53l0x_driver = {
>  		.of_match_table = st_vl53l0x_dt_match,
>  	},
>  	.probe_new = vl53l0x_probe,
> +	.id_table = vl53l0x_id,
>  };
>  module_i2c_driver(vl53l0x_driver);
>  

