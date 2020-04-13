Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8731A6A37
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbgDMQvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 12:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbgDMQvA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 12:51:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9F42063A;
        Mon, 13 Apr 2020 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796659;
        bh=kX2lIkUzBaiu0Fn0I8qHB+oBIIc1p2aUEa1l0kyhBW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cgfU03VuqSmqRvA9hKfgjFJSIOddPfA5cNcmoRHZXq0XTvxWuHOugVyZ8FCIaWP4U
         lgSJsJFnfiLnIl1MkHZCUM3oPQ1FJea8BYYXp+nmt6ivsTh44lmUyY4LInOjCD1er6
         0L+0MEEDM/NzCsL2nDrJJE9/akZm0eJWxFDVPcII=
Date:   Mon, 13 Apr 2020 17:50:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     mani@kernel.org
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: Add OF match table for CCS811 VOC
 sensor
Message-ID: <20200413175054.626283dc@archlinux>
In-Reply-To: <20200412183658.6755-4-mani@kernel.org>
References: <20200412183658.6755-1-mani@kernel.org>
        <20200412183658.6755-4-mani@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 00:06:58 +0530
mani@kernel.org wrote:

> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Add devicetree OF match table support for CCS811 VOC sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

Hi,

A few small things to clean up inline

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/ccs811.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 6cd92c49c348..313931208f61 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -24,6 +24,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/module.h>
> +#include <linux/of.h>

You are including this just to get things in mod_devicetable.h
so include that directly instead.

>  
>  #define CCS811_STATUS		0x00
>  #define CCS811_MEAS_MODE	0x01
> @@ -538,9 +539,16 @@ static const struct i2c_device_id ccs811_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ccs811_id);
>  
> +static const struct of_device_id ccs811_dt_ids[] = {
> +	{ .compatible = "ams,ccs811" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
> +
>  static struct i2c_driver ccs811_driver = {
>  	.driver = {
>  		.name = "ccs811",
> +		.of_match_table = of_match_ptr(ccs811_dt_ids),
No need for the of_match_ptr macro.  It has several issues.

1) Blocks PRP001 ACPI magic device types being used to instantiate
this using the device tree binding but under ACPI.
2) Will give warnings about ccs811_dt_ids being unused on no
   device tree builds.

>  	},
>  	.probe = ccs811_probe,
>  	.remove = ccs811_remove,

