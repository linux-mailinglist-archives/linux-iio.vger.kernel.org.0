Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE62C7529
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbgK1Vt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbgK1Syn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:54:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AB124680;
        Sat, 28 Nov 2020 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606572272;
        bh=6js5XI5p0Mnk++hEY907GUh8S1l4NEaanh58aW0/SSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rEONj2AD49CrgVgwezdLkoV9XbBlr0jpAS/E9HgdxVWDiQ0UieEv4ss7U8ZkmLZJb
         BdVaThnH5KfQfaECFZno5JKIvDPp59rEmZ11N87bhdG6VcXCSRXmx7Yo6rC8lzGZpg
         /2rJGxGmbE7I9Fw4K56jIDr5vKHwcc4In7YEVqyQ=
Date:   Sat, 28 Nov 2020 14:04:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: adc: at91_adc: remove platform data
Message-ID: <20201128140427.61dbaceb@archlinux>
In-Reply-To: <20201117140656.1235055-2-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
        <20201117140656.1235055-2-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 15:06:46 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> The at91 platforms have been DT only for a while, remove platform data.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Hi Alexandre,

I'd completely forgotten that we actually had a similar patch that
is already applied from Alexandru back in September.

Given vast majority matched, I've just changed your patch into one
that drops the id_table (which Alexandru didn't do).

So with that tweak applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c             | 80 +++++++-------------------
>  include/linux/platform_data/at91_adc.h | 49 ----------------
>  2 files changed, 22 insertions(+), 107 deletions(-)
>  delete mode 100644 include/linux/platform_data/at91_adc.h
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 9b2c548fae95..62bd35af8b13 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -22,8 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  
> -#include <linux/platform_data/at91_adc.h>
> -
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
> @@ -153,6 +151,25 @@
>  #define TOUCH_SHTIM                    0xa
>  #define TOUCH_SCTIM_US		10		/* 10us for the Touchscreen Switches Closure Time */
>  
> +enum atmel_adc_ts_type {
> +	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
> +	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
> +	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
> +};
> +
> +/**
> + * struct at91_adc_trigger - description of triggers
> + * @name:		name of the trigger advertised to the user
> + * @value:		value to set in the ADC's trigger setup register
> + *			to enable the trigger
> + * @is_external:	Does the trigger rely on an external pin?
> + */
> +struct at91_adc_trigger {
> +	const char	*name;
> +	u8		value;
> +	bool		is_external;
> +};
> +
>  /**
>   * struct at91_adc_reg_desc - Various informations relative to registers
>   * @channel_base:	Base offset for the channel data registers
> @@ -875,9 +892,6 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	int i = 0, ret;
>  	u32 prop;
>  
> -	if (!node)
> -		return -EINVAL;
> -
>  	st->caps = (struct at91_adc_caps *)
>  		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
>  
> @@ -960,30 +974,6 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	return ret;
>  }
>  
> -static int at91_adc_probe_pdata(struct at91_adc_state *st,
> -				struct platform_device *pdev)
> -{
> -	struct at91_adc_data *pdata = pdev->dev.platform_data;
> -
> -	if (!pdata)
> -		return -EINVAL;
> -
> -	st->caps = (struct at91_adc_caps *)
> -			platform_get_device_id(pdev)->driver_data;
> -
> -	st->use_external = pdata->use_external_triggers;
> -	st->vref_mv = pdata->vref;
> -	st->channels_mask = pdata->channels_used;
> -	st->num_channels = st->caps->num_channels;
> -	st->startup_time = pdata->startup_time;
> -	st->trigger_number = pdata->trigger_number;
> -	st->trigger_list = pdata->trigger_list;
> -	st->registers = &st->caps->registers;
> -	st->touchscreen_type = pdata->touchscreen_type;
> -
> -	return 0;
> -}
> -
>  static const struct iio_info at91_adc_info = {
>  	.read_raw = &at91_adc_read_raw,
>  };
> @@ -1160,15 +1150,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	st = iio_priv(idev);
>  
> -	if (pdev->dev.of_node)
> -		ret = at91_adc_probe_dt(idev, pdev);
> -	else
> -		ret = at91_adc_probe_pdata(st, pdev);
> -
> -	if (ret) {
> -		dev_err(&pdev->dev, "No platform data available.\n");
> -		return -EINVAL;
> -	}
> +	ret = at91_adc_probe_dt(idev, pdev);
> +	if (ret)
> +		return ret;
>  
>  	platform_set_drvdata(pdev, idev);
>  
> @@ -1444,29 +1428,9 @@ static const struct of_device_id at91_adc_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
>  
> -static const struct platform_device_id at91_adc_ids[] = {
> -	{
> -		.name = "at91sam9260-adc",
> -		.driver_data = (unsigned long)&at91sam9260_caps,
> -	}, {
> -		.name = "at91sam9rl-adc",
> -		.driver_data = (unsigned long)&at91sam9rl_caps,
> -	}, {
> -		.name = "at91sam9g45-adc",
> -		.driver_data = (unsigned long)&at91sam9g45_caps,
> -	}, {
> -		.name = "at91sam9x5-adc",
> -		.driver_data = (unsigned long)&at91sam9x5_caps,
> -	}, {
> -		/* terminator */
> -	}
> -};
> -MODULE_DEVICE_TABLE(platform, at91_adc_ids);
> -
>  static struct platform_driver at91_adc_driver = {
>  	.probe = at91_adc_probe,
>  	.remove = at91_adc_remove,
> -	.id_table = at91_adc_ids,
>  	.driver = {
>  		   .name = DRIVER_NAME,
>  		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
> diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
> deleted file mode 100644
> index f20eaeb827ce..000000000000
> --- a/include/linux/platform_data/at91_adc.h
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (C) 2011 Free Electrons
> - */
> -
> -#ifndef _AT91_ADC_H_
> -#define _AT91_ADC_H_
> -
> -enum atmel_adc_ts_type {
> -	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
> -	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
> -	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
> -};
> -
> -/**
> - * struct at91_adc_trigger - description of triggers
> - * @name:		name of the trigger advertised to the user
> - * @value:		value to set in the ADC's trigger setup register
> -			to enable the trigger
> - * @is_external:	Does the trigger rely on an external pin?
> - */
> -struct at91_adc_trigger {
> -	const char	*name;
> -	u8		value;
> -	bool		is_external;
> -};
> -
> -/**
> - * struct at91_adc_data - platform data for ADC driver
> - * @channels_used:		channels in use on the board as a bitmask
> - * @startup_time:		startup time of the ADC in microseconds
> - * @trigger_list:		Triggers available in the ADC
> - * @trigger_number:		Number of triggers available in the ADC
> - * @use_external_triggers:	does the board has external triggers availables
> - * @vref:			Reference voltage for the ADC in millivolts
> - * @touchscreen_type:		If a touchscreen is connected, its type (4 or 5 wires)
> - */
> -struct at91_adc_data {
> -	unsigned long			channels_used;
> -	u8				startup_time;
> -	struct at91_adc_trigger		*trigger_list;
> -	u8				trigger_number;
> -	bool				use_external_triggers;
> -	u16				vref;
> -	enum atmel_adc_ts_type		touchscreen_type;
> -};
> -
> -extern void __init at91_add_device_adc(struct at91_adc_data *data);
> -#endif

