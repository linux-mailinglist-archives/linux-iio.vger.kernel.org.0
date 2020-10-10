Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26E128A259
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgJJW5B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbgJJS5V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 14:57:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E3F2064B;
        Sat, 10 Oct 2020 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602346045;
        bh=yqbHya5AzbPmZRg4XfaW3rvqiSj4EXVXjoskEJWuMvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BcF0zQDkAGm9Coi1aAVr+rHLbwd9umTY7wfJ3NuTStMHuDva8OF2RHoELbm/Q4pD2
         Lk2Ce8sqYPC1OXoQZ+qgs/1tKmGcJvzCx2ZQN29bxAyJS7i5zxNzBC4hwxWK4eWnzO
         gf+07FdlYDMUUt+ZK10fcJlMinE3UvMTqmucK6ls=
Date:   Sat, 10 Oct 2020 17:07:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com
Subject: Re: [PATCH v4 4/4] iio: adc: at91_adc: remove platform data and
 move defs in driver file
Message-ID: <20201010170720.29f192f8@archlinux>
In-Reply-To: <20200930140555.GI2804081@piout.net>
References: <20200930135048.11530-1-alexandru.ardelean@analog.com>
        <20200930135048.11530-5-alexandru.ardelean@analog.com>
        <20200930140555.GI2804081@piout.net>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Sep 2020 16:05:55 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 30/09/2020 16:50:48+0300, Alexandru Ardelean wrote:
> > The AT91 ADC driver no longer uses the 'at91_add_device_adc' platform data
> > type. This is no longer used (at least in mainline boards).
> > 
> > This change removes the platform-data initialization from the driver, since
> > it is mostly dead code now.
> > 
> > Some definitions [from the platform data at91_adc.h include] have been
> > moved in the driver, since they are needed in the driver.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> > ---
> >  drivers/iio/adc/at91_adc.c             | 60 ++++++++++----------------
> >  include/linux/platform_data/at91_adc.h | 49 ---------------------
> >  2 files changed, 22 insertions(+), 87 deletions(-)
> >  delete mode 100644 include/linux/platform_data/at91_adc.h
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 473bffe84fbd..be6abf739881 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -22,8 +22,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/wait.h>
> >  
> > -#include <linux/platform_data/at91_adc.h>
> > -
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/trigger.h>
> > @@ -153,6 +151,25 @@
> >  #define TOUCH_SHTIM                    0xa
> >  #define TOUCH_SCTIM_US		10		/* 10us for the Touchscreen Switches Closure Time */
> >  
> > +enum atmel_adc_ts_type {
> > +	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
> > +	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
> > +	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
> > +};
> > +
> > +/**
> > + * struct at91_adc_trigger - description of triggers
> > + * @name:		name of the trigger advertised to the user
> > + * @value:		value to set in the ADC's trigger setup register
> > +			to enable the trigger
Build with W=1 (and hence kernel doc checks) picked up missing * 
on this line.

Fixed.

Jonathan

> > + * @is_external:	Does the trigger rely on an external pin?
> > + */
> > +struct at91_adc_trigger {
> > +	const char	*name;
> > +	u8		value;
> > +	bool		is_external;
> > +};
> > +
> >  /**
> >   * struct at91_adc_reg_desc - Various informations relative to registers
> >   * @channel_base:	Base offset for the channel data registers
> > @@ -873,9 +890,6 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
> >  	int i = 0, ret;
> >  	u32 prop;
> >  
> > -	if (!node)
> > -		return -EINVAL;
> > -
> >  	st->caps = of_device_get_match_data(&pdev->dev);
> >  
> >  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
> > @@ -957,30 +971,6 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
> >  	return ret;
> >  }
> >  
> > -static int at91_adc_probe_pdata(struct at91_adc_state *st,
> > -				struct platform_device *pdev)
> > -{
> > -	struct at91_adc_data *pdata = pdev->dev.platform_data;
> > -
> > -	if (!pdata)
> > -		return -EINVAL;
> > -
> > -	st->caps = (struct at91_adc_caps *)
> > -			platform_get_device_id(pdev)->driver_data;
> > -
> > -	st->use_external = pdata->use_external_triggers;
> > -	st->vref_mv = pdata->vref;
> > -	st->channels_mask = pdata->channels_used;
> > -	st->num_channels = st->caps->num_channels;
> > -	st->startup_time = pdata->startup_time;
> > -	st->trigger_number = pdata->trigger_number;
> > -	st->trigger_list = pdata->trigger_list;
> > -	st->registers = &st->caps->registers;
> > -	st->touchscreen_type = pdata->touchscreen_type;
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct iio_info at91_adc_info = {
> >  	.read_raw = &at91_adc_read_raw,
> >  };
> > @@ -1157,15 +1147,9 @@ static int at91_adc_probe(struct platform_device *pdev)
> >  
> >  	st = iio_priv(idev);
> >  
> > -	if (pdev->dev.of_node)
> > -		ret = at91_adc_probe_dt(idev, pdev);
> > -	else
> > -		ret = at91_adc_probe_pdata(st, pdev);
> > -
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "No platform data available.\n");
> > -		return -EINVAL;
> > -	}
> > +	ret = at91_adc_probe_dt(idev, pdev);
> > +	if (ret)
> > +		return ret;
> >  
> >  	platform_set_drvdata(pdev, idev);
> >  
> > diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
> > deleted file mode 100644
> > index f20eaeb827ce..000000000000
> > --- a/include/linux/platform_data/at91_adc.h
> > +++ /dev/null
> > @@ -1,49 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-or-later */
> > -/*
> > - * Copyright (C) 2011 Free Electrons
> > - */
> > -
> > -#ifndef _AT91_ADC_H_
> > -#define _AT91_ADC_H_
> > -
> > -enum atmel_adc_ts_type {
> > -	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
> > -	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
> > -	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
> > -};
> > -
> > -/**
> > - * struct at91_adc_trigger - description of triggers
> > - * @name:		name of the trigger advertised to the user
> > - * @value:		value to set in the ADC's trigger setup register
> > -			to enable the trigger
> > - * @is_external:	Does the trigger rely on an external pin?
> > - */
> > -struct at91_adc_trigger {
> > -	const char	*name;
> > -	u8		value;
> > -	bool		is_external;
> > -};
> > -
> > -/**
> > - * struct at91_adc_data - platform data for ADC driver
> > - * @channels_used:		channels in use on the board as a bitmask
> > - * @startup_time:		startup time of the ADC in microseconds
> > - * @trigger_list:		Triggers available in the ADC
> > - * @trigger_number:		Number of triggers available in the ADC
> > - * @use_external_triggers:	does the board has external triggers availables
> > - * @vref:			Reference voltage for the ADC in millivolts
> > - * @touchscreen_type:		If a touchscreen is connected, its type (4 or 5 wires)
> > - */
> > -struct at91_adc_data {
> > -	unsigned long			channels_used;
> > -	u8				startup_time;
> > -	struct at91_adc_trigger		*trigger_list;
> > -	u8				trigger_number;
> > -	bool				use_external_triggers;
> > -	u16				vref;
> > -	enum atmel_adc_ts_type		touchscreen_type;
> > -};
> > -
> > -extern void __init at91_add_device_adc(struct at91_adc_data *data);
> > -#endif
> > -- 
> > 2.17.1
> >   
> 

