Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD029172C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgJRLdl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 07:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgJRLdk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:33:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F307620897;
        Sun, 18 Oct 2020 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603020820;
        bh=eDOIuNQIACDrEttGZrhRHmBTEHyvEkrV5fwiorjsl6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WWuknZJCBSnP11eJTF98si4B/kD/7CsD+LJCdw5ZS8RP1hzSVy0j5LSXW/HqRiGLl
         7jY7u00mFzsrbhUECzoOXNEDr6A5rnxJjgb+a3Bb1Ii8CzMOYHWUDstg0SLB4bXdXt
         Td7xfHZNV4tBxC4wXdnDs9k+TGjze2XJM8RbzKxM=
Date:   Sun, 18 Oct 2020 12:33:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     songqiang1304521@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        drew@beagleboard.org, robertcnelson@beagleboard.org,
        rajkovic@mikroe.com, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v2] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201018123334.5a8bb5ac@archlinux>
In-Reply-To: <20201018033142.GA27793@ubuntu>
References: <20201018033142.GA27793@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Oct 2020 09:01:42 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> add i2c_device_id for the vl53l0x-i2c driver so
> that the device can be instantiated using i2c_new_client_device
> or from userspace, useful in cases where device tree based description
> is not possible now(Eg. a device on a gbphy i2c
> adapter created by greybus).
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>

Please fix the description as mentioned in other patches.

The code change is fine, but it does raise the question of whether we want to think
about providing a means to register such devices using the of_match_table.
It's somewhat irritating to need to provide both (I'd rather not
just provide the non-dt version rely on the old hack that drops the
vendor ID for matching).

+CC Wolfram.

> ---
>  v2:
> 	- fix commit message
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

