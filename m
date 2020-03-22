Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF918EB1F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCVRus (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgCVRur (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:50:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FC5206C3;
        Sun, 22 Mar 2020 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584899446;
        bh=Sh7L3UieGYgixm8GAYfakbok0Y3K+sHMc1ocIK9XGkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ktftY6ofPak9V2HY5dfbS30wwGib13PT/8ptEYmPwtilPfKvU1P0KmPJUtDPaf0XO
         5N8GybHQEcLNsSyOqaovwArE4vDlxcnzseasiGCYzq1CrDO4iLJLuFsZISf9XR8B+a
         /Xw72O8RB+XdYs3bCgvjyN5wkKoeQfLDG+oFv3to=
Date:   Sun, 22 Mar 2020 17:50:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.Ardelean@analog.com, dragos.bogdan@analog.com,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: health: max30100: use generic property handler
Message-ID: <20200322175042.7903862d@archlinux>
In-Reply-To: <5e6e48dd.1c69fb81.11507.523e@mx.google.com>
References: <5e6e48dd.1c69fb81.11507.523e@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 20:55:12 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Instead of of_property_read_xxx use device_property_read_xxx as it is
> compatible with ACPI too as opposed to only device tree.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>

Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with them.

Thanks,

Jonathan

> ---
> Changelog
> v1 -> v2
> - remove of_match_ptr to make it possible to use PRP0001 ACPI based
>   bindings
>  drivers/iio/health/max30100.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 84010501762d..546fc37ad75d 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -16,7 +16,7 @@
>  #include <linux/irq.h>
>  #include <linux/i2c.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -267,11 +267,10 @@ static int max30100_get_current_idx(unsigned int val, int *reg)
>  static int max30100_led_init(struct max30100_data *data)
>  {
>  	struct device *dev = &data->client->dev;
> -	struct device_node *np = dev->of_node;
>  	unsigned int val[2];
>  	int reg, ret;
>  
> -	ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
> +	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
>  					(unsigned int *) &val, 2);
>  	if (ret) {
>  		/* Default to 24 mA RED LED, 50 mA IR LED */
> @@ -502,7 +501,7 @@ MODULE_DEVICE_TABLE(of, max30100_dt_ids);
>  static struct i2c_driver max30100_driver = {
>  	.driver = {
>  		.name	= MAX30100_DRV_NAME,
> -		.of_match_table	= of_match_ptr(max30100_dt_ids),
> +		.of_match_table	= max30100_dt_ids,
>  	},
>  	.probe		= max30100_probe,
>  	.remove		= max30100_remove,

