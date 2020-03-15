Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD3185C70
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgCOMun (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgCOMun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:50:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E938E205ED;
        Sun, 15 Mar 2020 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584276643;
        bh=tSUX5BtR0r5shVkJhiBSsjEhd6hJK8EV8By9+NiYji8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NUJ6pbs01C+UoQMm4altkbimFzj4hq+5lJT3bJdtivP2WzevDKmLpjIquh31vEi8M
         kH+lo1CVFvqgTPkHVRDX8QPRbloZdLPngsYShTc7+ZwK+S13rnW32SpREupkTj+H08
         7ZnFsKn8dBKuLH6uw/IQt0DJ+fk22aS96Zih21j8=
Date:   Sun, 15 Mar 2020 12:50:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.Ardelean@analog.com, dragos.bogdan@analog.com,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: health: max30100: use generic property handler
Message-ID: <20200315124955.207d515c@archlinux>
In-Reply-To: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com>
References: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 08:59:13 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Instead of of_property_read_xxx use device_property_read_xxx as it is
> compatible with ACPI too as opposed to only device tree.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>

Look at how this driver is probing from DT.  There is another thing you need
to do to make it possible to use PRP001 ACPI based bindings.

(check what Andy Shevchenko did in a similar patch)

I'm being deliberately vague as useful for you to understand what is going
on here for yourself :)

Also, make sure to check you have cc'd everyone relevant.  Here you are missing
the driver author. +cc Matt
Jonathan

> ---
>  drivers/iio/health/max30100.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 84010501762d..8249c6b36818 100644
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

