Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5E29172F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgJRLfm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 07:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgJRLfl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:35:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD2F208FE;
        Sun, 18 Oct 2020 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603020941;
        bh=UWLuhUKEx+WAD2L3KLRIl56EXU9fus9VaiXZGC/F8cA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EFuy8CMiMz4SEgoUC7jCZebpXt2fe3ymS4H7bqmGQnFmPnVguxvGmWB39D2yjwLVw
         vscBr+TFlikv1Ax1m+PNZqNw6rnlrYoQgGCCUc3HZUAaI/AZI4xL1RmwwM7V/dq5RO
         mG8WgtaZOru27dHuUvk95rwuAHGw1PtiRwaQBbBw=
Date:   Sun, 18 Oct 2020 12:35:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, alexandru.ardelean@analog.com,
        nish.malpani25@gmail.com, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: Re: [PATCH v2] iio: light: tsl2563 change of_property_read to
 device_property_read
Message-ID: <20201018123535.7fdd3ee5@archlinux>
In-Reply-To: <20201018032543.GA27580@ubuntu>
References: <20201018032543.GA27580@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Oct 2020 08:55:43 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> replace the of_property_read_u32 for reading the amstaos,cover-comp-gain
> property with device_property_read_u32,allows the driver to
> get the properties information using the more generic device_property_*
> helpers and opens the possibility of passing the properties during
> platform instantiation of the device by a suitably populated
> struct property_entry.
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Please tidy up that description in a similar fashion to I've suggested in
other reviews.  Code looks fine.

On another day I might have just fixed that description whilst applying but
we have lots of time at this point in the cycle, hence I'm bouncing
them back to you ;)

Thanks,

Jonathan

> ---
>  v2:
> 	- fix commit message
>  drivers/iio/light/tsl2563.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index abc8d7db8dc1..1f1b8b7cefa4 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -703,7 +703,6 @@ static int tsl2563_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct tsl2563_chip *chip;
>  	struct tsl2563_platform_data *pdata = client->dev.platform_data;
> -	struct device_node *np = client->dev.of_node;
>  	int err = 0;
>  	u8 id = 0;
>  
> @@ -738,13 +737,14 @@ static int tsl2563_probe(struct i2c_client *client,
>  	chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
>  	chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
>  
> -	if (pdata)
> +	if (pdata) {
>  		chip->cover_comp_gain = pdata->cover_comp_gain;
> -	else if (np)
> -		of_property_read_u32(np, "amstaos,cover-comp-gain",
> -				     &chip->cover_comp_gain);
> -	else
> -		chip->cover_comp_gain = 1;
> +	} else {
> +		err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
> +					       &chip->cover_comp_gain);
> +		if (err)
> +			chip->cover_comp_gain = 1;
> +	}
>  
>  	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
>  	indio_dev->name = client->name;

