Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F681CE3CA
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgEKTUa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 15:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTU3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 May 2020 15:20:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0EB206E6;
        Mon, 11 May 2020 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589224828;
        bh=h8tGE9qMIzJ9Bxj1OxssLWsbEC2G8vv9/jW1E9oLHUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YSt/E9sqgnzLj/fsxQk1Zvzqz6o2sxA2QoPKDQdYMf6G2v8y2TwFCegOJKk33AfxX
         74SX74RhlsKurvdbsblcjjnrzSZkqJFHFu/q54iyZOSKJ700X8WR3FHORWWYQqk0gB
         COGF9a/rPs/xTiCtPKhyHZhcEkTIdYmdFKB0xKqs=
Date:   Mon, 11 May 2020 20:20:23 +0100
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
Subject: Re: [PATCH v4 10/11] iio: light: cm32181: Add support for parsing
 CPM0 and CPM1 ACPI tables
Message-ID: <20200511202023.45f2d130@archlinux>
In-Reply-To: <20200504125551.434647-10-hdegoede@redhat.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
        <20200504125551.434647-10-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  4 May 2020 14:55:50 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> On ACPI based systems the CPLM3218 ACPI device node describing the
> CM3218[1] sensor typically will have some extra tables with register
> init values for initializing the sensor and calibration info.
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
> This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
> Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181).
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tiny thing 0-day picked up that I've just fixed and pushed out.

> ---
> Changes in v2:
> - Factor out the parsing into a separate helper function
> ---
>  drivers/iio/light/cm32181.c | 101 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index a0812e3cba9b..5eeefa3ee4f1 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -4,6 +4,7 @@
>   * Author: Kevin Tsai <ktsai@capellamicro.com>
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> @@ -53,6 +54,15 @@
>  
>  #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
>  
> +/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
> +#define CPM0_REGS_BITMAP		2
> +#define CPM0_HEADER_SIZE		3
> +
> +/* CPM1 Index 0: lux_per_bit, 1: calibscale, 2: resolution (100000) */
> +#define CPM1_LUX_PER_BIT		0
> +#define CPM1_CALIBSCALE			1
> +#define CPM1_SIZE			3
> +
>  struct cm32181_chip_info {
>  	const char *name;
>  	const int *als_it_bits;
> @@ -61,6 +71,7 @@ struct cm32181_chip_info {
>  };
>  
>  struct cm32181_chip {
> +	struct device *dev;
>  	struct i2c_client *client;
>  	const struct cm32181_chip_info *info;
>  	struct mutex lock;
> @@ -95,6 +106,92 @@ const struct cm32181_chip_info cm32181_chip_info = {
>  	.num_als_it = ARRAY_SIZE(cm32181_als_it_bits),
>  };
>  
> +static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
> +
> +#ifdef CONFIG_ACPI
> +/**
> + * cm32181_acpi_get_cpm() - Get CPM object from ACPI
> + * @client	pointer of struct i2c_client.
> + * @obj_name	pointer of ACPI object name.
> + * @count	maximum size of return array.
> + * @vals	pointer of array for return elements.
> + *
> + * Convert ACPI CPM table to array.
> + *
> + * Return: -ENODEV for fail.  Otherwise is number of elements.
> + */
> +static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
> +				u64 *values, int count)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *cpm, *elem;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int i;
> +
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "object %s not found\n", obj_name);
> +		return -ENODEV;
> +	}
> +
> +	cpm = buffer.pointer;
> +	if (cpm->package.count > count)
> +		dev_warn(dev, "%s table contains %d values, only using first %d values\n",
> +			 obj_name, cpm->package.count, count);

cpm->package.count is unsigned.

> +
> +	count = min_t(int, cpm->package.count, count);
> +	for (i = 0; i < count; i++) {
> +		elem = &(cpm->package.elements[i]);
> +		values[i] = elem->integer.value;
> +	}
> +
> +	kfree(buffer.pointer);
> +
> +	return count;
> +}
> +
> +static void cm32181_acpi_parse_cpm_tables(struct cm32181_chip *cm32181)
> +{
> +	u64 vals[CPM0_HEADER_SIZE + CM32181_CONF_REG_NUM];
> +	struct device *dev = cm32181->dev;
> +	int i, count;
> +
> +	count = cm32181_acpi_get_cpm(dev, "CPM0", vals, ARRAY_SIZE(vals));
> +	if (count <= CPM0_HEADER_SIZE)
> +		return;
> +
> +	count -= CPM0_HEADER_SIZE;
> +
> +	cm32181->init_regs_bitmap = vals[CPM0_REGS_BITMAP];
> +	cm32181->init_regs_bitmap &= GENMASK(count - 1, 0);
> +	for_each_set_bit(i, &cm32181->init_regs_bitmap, count)
> +		cm32181->conf_regs[i] =	vals[CPM0_HEADER_SIZE + i];
> +
> +	count = cm32181_acpi_get_cpm(dev, "CPM1", vals, ARRAY_SIZE(vals));
> +	if (count != CPM1_SIZE)
> +		return;
> +
> +	cm32181->lux_per_bit = vals[CPM1_LUX_PER_BIT];
> +
> +	/* Check for uncalibrated devices */
> +	if (vals[CPM1_CALIBSCALE] == CM32181_CALIBSCALE_DEFAULT)
> +		return;
> +
> +	cm32181->calibscale = vals[CPM1_CALIBSCALE];
> +	/* CPM1 lux_per_bit is for the current it value */
> +	cm32181_read_als_it(cm32181, &cm32181->lux_per_bit_base_it);
> +}
> +#else
> +static void cm32181_acpi_parse_cpm_tables(struct cm32181_chip *cm32181)
> +{
> +}
> +#endif /* CONFIG_ACPI */
> +
>  /**
>   * cm32181_reg_init() - Initialize CM32181 registers
>   * @cm32181:	pointer of struct cm32181.
> @@ -134,6 +231,9 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  	cm32181->lux_per_bit = CM32181_LUX_PER_BIT;
>  	cm32181->lux_per_bit_base_it = CM32181_LUX_PER_BIT_BASE_IT;
>  
> +	if (ACPI_HANDLE(cm32181->dev))
> +		cm32181_acpi_parse_cpm_tables(cm32181);
> +
>  	/* Initialize registers*/
>  	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
>  		ret = i2c_smbus_write_word_data(client, i,
> @@ -376,6 +476,7 @@ static int cm32181_probe(struct i2c_client *client)
>  	}
>  
>  	cm32181 = iio_priv(indio_dev);
> +	cm32181->dev = dev;
>  	cm32181->client = client;
>  
>  	mutex_init(&cm32181->lock);

