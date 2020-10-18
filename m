Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F929171E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgJRLJW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 07:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgJRLJW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:09:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C694120897;
        Sun, 18 Oct 2020 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603019361;
        bh=2efbi6jPngvBZEM/jssvFYg3y1VW8zbKPIPxMZ6Fhto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AYNrOki5MxY9y4AB04vzYvGf4JlvOYUIY6eC2F+y5sJMIQqKKna+xFIEcogJZuxFj
         z0uhBPAfoajXaU32l33ZsV3c2hGu2T2lHs94xm/P4JMvupnA3kecAHcBSKagdd8U/5
         sSS78Rci3Elt65v1il1XvPaC5AuRJQXyaVQVF4VQ=
Date:   Sun, 18 Oct 2020 12:09:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     knaack.h@gmx.de, ars@metafoo.de, alexandru.ardelean@analog.com,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        drew@beagleboard.org, robertcnelson@beagleboard.org,
        rajkovic@mikroe.com
Subject: Re: [PATCH] iio: light: tsl2563 change of_property_read to
 device_property_read
Message-ID: <20201018120916.3819c172@archlinux>
In-Reply-To: <20201016183219.GA15288@ubuntu>
References: <20201016183219.GA15288@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 17 Oct 2020 00:04:27 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> This patch aims to replace the of_property_read_u32 for reading
> the amstaos,cover-comp-gain property with device_property_read_u32
> 
> Thanks and Regards,
> Vaishnav M A

Should keep this stuff about the --- to just the patch description as that
will end up in the git log when I pick up the patch.  You can add
any extra stuff as notes as long as it is after the --- below.

> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>

A really minor comment below, but I'd like a couple of header tweaks
to be part of this patch as well to reflect that we are removing the
explicit use of of_* in this driver (which is great btw!)

At the moment we are getting the following headers only via indirect
includes.  As we are using things directly defined in them please add

#include <linux/property.h> (for the device_property_read*)
#include <linux/mod_devicetable.h> (for the of_device_id table)

Thanks,

Jonathan

> ---
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

Hmm. This is a small change in logic.  I'm not sure it really matters,
but should have been called out explicitly in the patch description.

> +	}
>  
>  	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
>  	indio_dev->name = client->name;

