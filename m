Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53C1C2B82
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgECK7N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 06:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgECK7M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 06:59:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B34312071C;
        Sun,  3 May 2020 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588503551;
        bh=c7egyq09BMhVt3ri4v+ufmeD1U0mLvSIu0PQfdAIRSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WYLF3dzNqQO5XKMNxjazLKDaCpQl4hs7L9tpnY4k2BYkw/hN70NXbzVWpPKu+Qier
         28cWbknZe425MdNsem7pyKYSY4P8wf+tJgF0/uF+LKp5pGK+dS8QtFBCT9q+XaqvG3
         3tS6+GafHfRkYjHSd3XlU5X5VKDJD11lMqHY1ZB4=
Date:   Sun, 3 May 2020 11:59:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 04/11] iio: light: cm32181: Add support for the
 CM3218
Message-ID: <20200503115906.6fb86b49@archlinux>
In-Reply-To: <20200428172923.567806-4-hdegoede@redhat.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
        <20200428172923.567806-4-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 19:29:16 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Add support for the CM3218 which is an older version of the
> CM32181.
> 
> This is based on a newer version of cm32181.c, with a copyright of:
> 
>  * Copyright (C) 2014 Capella Microsystems Inc.
>  * Author: Kevin Tsai <ktsai@capellamicro.com>
>  *
>  * This program is free software; you can redistribute it and/or modify it
>  * under the terms of the GNU General Public License version 2, as published
>  * by the Free Software Foundation.
> 
> Which is floating around on the net in various places, but the changes
> from this newer version never made it upstream.
> 
> This was tested on an Asus T100TA and an Asus T100CHI, which both come
> with the CM3218 variant of the light sensor.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

The need to also store the name for the different sensors makes
the case for picking between 'chip_info' structures in here stronger.
So I'd do that instead of setting multiple elements in your
switch statement... (See inline)

> ---
>  drivers/iio/light/cm32181.c | 48 +++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 6fc0a753c499..065bc7a11f84 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -55,15 +55,24 @@ static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>  	CM32181_REG_ADDR_CMD,
>  };
>  
> -static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
> -static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
> -	800000};
> +/* CM3218 Family */
> +static const int cm3218_als_it_bits[] = { 0, 1, 2, 3 };
> +static const int cm3218_als_it_values[] = { 100000, 200000, 400000, 800000 };
> +
> +/* CM32181 Family */
> +static const int cm32181_als_it_bits[] = { 12, 8, 0, 1, 2, 3 };
> +static const int cm32181_als_it_values[] = {
> +	25000, 50000, 100000, 200000, 400000, 800000
> +};
>  
>  struct cm32181_chip {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	u16 conf_regs[CM32181_CONF_REG_NUM];
>  	int calibscale;
> +	int num_als_it;
> +	const int *als_it_bits;
> +	const int *als_it_values;
These are constant for each type of chip and come as a set.
Better to just have a cm32181_chip_info structure with all 3 in it
(and the name as mentioned earlier).  That way your switch below
just becomes a matter of setting a single pointer for each case.

>  };
>  
>  /**
> @@ -85,8 +94,21 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  		return ret;
>  
>  	/* check device ID */
> -	if ((ret & 0xFF) != 0x81)
> +	switch (ret & 0xFF) {
> +	case 0x18: /* CM3218 */

I'd ideally like to see a sanity check that we have the part expected.
So the compatible matches what we actually get.

If it doesn't but the part is still one we support print a warning.

> +		cm32181->num_als_it = ARRAY_SIZE(cm3218_als_it_bits);
> +		cm32181->als_it_bits = cm3218_als_it_bits;
> +		cm32181->als_it_values = cm3218_als_it_values;
> +		break;
> +	case 0x81: /* CM32181 */
> +	case 0x82: /* CM32182, fully compat. with CM32181 */
> +		cm32181->num_als_it = ARRAY_SIZE(cm32181_als_it_bits);
> +		cm32181->als_it_bits = cm32181_als_it_bits;
> +		cm32181->als_it_values = cm32181_als_it_values;
> +		break;
> +	default:
>  		return -ENODEV;
> +	}
>  
>  	/* Default Values */
>  	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =
> @@ -121,9 +143,9 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
>  	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
>  	als_it &= CM32181_CMD_ALS_IT_MASK;
>  	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
> -	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
> -		if (als_it == als_it_bits[i]) {
> -			*val2 = als_it_value[i];
> +	for (i = 0; i < cm32181->num_als_it; i++) {
> +		if (als_it == cm32181->als_it_bits[i]) {
> +			*val2 = cm32181->als_it_values[i];
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		}
>  	}
> @@ -146,14 +168,14 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
>  	u16 als_it;
>  	int ret, i, n;
>  
> -	n = ARRAY_SIZE(als_it_value);
> +	n = cm32181->num_als_it;
>  	for (i = 0; i < n; i++)
> -		if (val <= als_it_value[i])
> +		if (val <= cm32181->als_it_values[i])
>  			break;
>  	if (i >= n)
>  		i = n - 1;
>  
> -	als_it = als_it_bits[i];
> +	als_it = cm32181->als_it_bits[i];
>  	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
>  
>  	mutex_lock(&cm32181->lock);
> @@ -265,11 +287,12 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
>  static ssize_t cm32181_get_it_available(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
> +	struct cm32181_chip *cm32181 = iio_priv(dev_to_iio_dev(dev));
>  	int i, n, len;
>  
> -	n = ARRAY_SIZE(als_it_value);
> +	n = cm32181->num_als_it;
>  	for (i = 0, len = 0; i < n; i++)
> -		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
> +		len += sprintf(buf + len, "0.%06u ", cm32181->als_it_values[i]);
>  	return len + sprintf(buf + len, "\n");
>  }
>  
> @@ -345,6 +368,7 @@ static int cm32181_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id cm32181_of_match[] = {
> +	{ .compatible = "capella,cm3218" },
>  	{ .compatible = "capella,cm32181" },
>  	{ }
>  };

