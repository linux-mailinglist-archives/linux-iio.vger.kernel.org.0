Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA09D4A38FB
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356081AbiA3USh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:18:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356096AbiA3USg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:18:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3EC1B829AA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C27C340E4;
        Sun, 30 Jan 2022 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643573913;
        bh=qUopNQudD7J9o5weRvQQJB6Po6n4TqCra7x/Lnj2mDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OWIvhLzuI8wV1lw0mv9Wh2Fr/jq4bWy5hEPqmstfQW72Lx4gXEg20BH6J+J8H9/D0
         YmUti3GsXNyZv8DPIqO5y8cJiqYDZKQwQYTqWo0GeewIeqC2mbcMV7/qzOszVF7B1l
         Ij9HfnmCysTSwA/GdIgydvGehFnBcb63aWo6oNE5DK2FWhU/SHcfExV/tZP7sTQIA3
         M5lyl2+rPmry1FX5LNzheX+yZKT04KRutN7xLpbBM6fbIPBNpq6jS02rBB8UVzCm49
         0iaCb8lCyAWe/zMwvrCKv023Ns3QkTWIwjGEr/Nga3BWyiiscg6p+naZSf3gDOht20
         YWxd7giBFvlyQ==
Date:   Sun, 30 Jan 2022 20:24:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 14/17] staging:iio:adc:ad7280a: Use device properties
 to replace platform data.
Message-ID: <20220130202459.00a1be01@jic23-huawei>
In-Reply-To: <Yb5NcvGuaauOHBXe@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-15-jic23@kernel.org>
        <Yb5NcvGuaauOHBXe@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Dec 2021 18:06:58 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Removing AUX channels from alert detection is a bit tricky.
> According to a note from datasheet page 27:
> To remove AUX5 or AUX5 and AUX3 from the alert detection, conversions on
> three auxiliary ADC input channels only must be selected in the control register.

Hmm. Always hide the important stuff in foot notes. I missed that entirely it seems
though honestly I can only vaguely remember how this works at all.

> 
> We can check the AUX alert configuration and write to control register HB at
> probe but it would not last for long since every other device read sets D15:D14
> to 0x00 again. Can't think of any reasonable way to ensure only AUX1,3,5 without
> keeping ctrl_hb again. However, AUX selection should not bother if we drop AUX
> alert removal support for now.

Agreed. This is a pain.  Dropping the support is probably a better plan than
getting stuck figuring this out.  I'll give it a bit more thought when I get
back to this driver properly.

> 
> Few other bits and thoughts inline.
> 
> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Convert all the device specific info that was previously in platform data
> > over to generic firmware query interfaces.
> > 
> > dt-bindings to follow shortly.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 100 +++++++++++++++++++++++++-----
> >  drivers/staging/iio/adc/ad7280a.h |  31 ---------
> >  2 files changed, 86 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index acaae1b33986..0806238debe3 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -23,8 +23,6 @@
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  
> > -#include "ad7280a.h"
> > -
> >  /* Registers */
> >  
> >  #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> > @@ -81,6 +79,11 @@
> >  #define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
> >  
> >  #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
> > +#define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> > +#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> > +#define     AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)  
> typo, according to datasheet this bit disables AUX5 and AUX3 so it would be
> #define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)

Ah.  I'd missed that which rather makes a mess of using the 'last' channel
in the dt binding.  Will need a rethink.  Sometimes if feels like the
hardware folks design this stuff just to make it hard to put a nice
simple software description in place!

> 
> > +#define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
> > +#define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> >  #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
> >  #define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
> >  
> > @@ -163,6 +166,8 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
> >  struct ad7280_state {
> >  	struct spi_device		*spi;
> >  	struct iio_chan_spec		*channels;
> > +	unsigned int			chain_last_alert_ignore;
> > +	bool				thermistor_term_en;
> >  	int				slave_num;
> >  	int				scan_cnt;
> >  	int				readback_delay_us;
> > @@ -932,14 +937,8 @@ static const struct iio_info ad7280_info_no_irq = {
> >  	.write_event_value = &ad7280a_write_thresh,
> >  };
> >  
> > -static const struct ad7280_platform_data ad7793_default_pdata = {
> > -	.acquisition_time = AD7280A_ACQ_TIME_400ns,
> > -	.thermistor_term_en = true,
> > -};
> > -
> >  static int ad7280_probe(struct spi_device *spi)
> >  {
> > -	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
> >  	struct device *dev = &spi->dev;
> >  	struct ad7280_state *st;
> >  	int ret;
> > @@ -954,17 +953,90 @@ static int ad7280_probe(struct spi_device *spi)
> >  	st->spi = spi;
> >  	mutex_init(&st->lock);
> >  
> > -	if (!pdata)
> > -		pdata = &ad7793_default_pdata;
> > +	st->thermistor_term_en =
> > +		device_property_read_bool(dev, "adi,thermistor-termination");
> > +
> > +	if (device_property_present(dev, "adi,acquistion-time-ns")) {  
> typo, adi,acquistion-time-ns -> adi,acquisition-time-ns
> 
> > +		u32 val;
> > +
> > +		ret = device_property_read_u32(dev, "adi,acquisition-time-ns", &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (val) {
> > +		case 400:
> > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> > +			break;
> > +		case 800:
> > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_800ns;
> > +			break;
> > +		case 1200:
> > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1200ns;
> > +			break;
> > +		case 1600:
> > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
> > +			break;
> > +		default:
> > +			dev_err(dev, "Firmware provided acquisition time is invalid\n");
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> > +	}
> > +
> > +	/* Alert masks are intended for when particular inputs are not wired up */
> > +	if (device_property_present(dev, "adi,voltage-alert-last-chan")) {
> > +		u8 val;
> >  
> > +		ret = device_property_read_u8(dev, "adi,voltage-alert-last-chan", &val);  
> I added some extra configuration to the ad7280a qemu emulation stuff to test
> cases where we would have voltage and temperature channels removed from alert
> generation. On my setup, these device_property_read_u8 reads gave me zeros all
> the time while the u32 reads gave me the expected values.
> Not sure if this is something with qemu or even some misconfiguration from my side.
> Would be good if someone else could check it out.

I'll check it out.  Thanks for the heads up that it might be an issue.
Digging in the implementation it looks like it might need a specific format
for the device property.
https://elixir.bootlin.com/linux/latest/source/include/linux/of.h#L439

``property = /bits/ 8 <0x50 0x60 0x70>;`

So it might be that. Given we don't care better to just use
32 bit reads.

> 
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (val) {
> > +		case 3:
> > +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN4_VIN5;
> > +			break;
> > +		case 4:
> > +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN5;
> > +			break;
> > +		case 5:
> > +			break;
> > +		default:
> > +			dev_err(dev,
> > +				"Firmware provided last voltage alert channel invalid\n");
> > +			break;
> > +		}
> > +	}
> > +	if (device_property_present(dev, "adi,temp-alert-last-chan")) {
> > +		u8 val;
> > +
> > +		ret = device_property_read_u8(dev, "adi,temp-alert-last-chan", &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (val) {
> > +		case 3:
> > +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX4_AUX5;
> > +			break;
> > +		case 4:
> > +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX5;
> > +			break;
> > +		case 5:
> > +			break;
> > +		default:
> > +			dev_err(dev,
> > +				"Firmware provided last temp alert channel invalid\n");
> > +			break;
> > +		}
> > +	}
> >  	crc8_populate_msb(st->crc_tab, POLYNOM);
> >  
> >  	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
> >  	st->spi->mode = SPI_MODE_1;
> >  	spi_setup(st->spi);
> >  
> > -	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, pdata->acquisition_time) |
> > -		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, pdata->thermistor_term_en);
> > +	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
> > +		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
> >  	st->oversampling_ratio = 0; /* No oversampling */
> >  
> >  	ret = ad7280_chain_setup(st);
> > @@ -975,7 +1047,6 @@ static int ad7280_probe(struct spi_device *spi)
> >  	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
> >  	st->cell_threshhigh = 0xFF;
> >  	st->aux_threshhigh = 0xFF;
> > -	st->acquisition_time = pdata->acquisition_time;
> >  
> >  	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
> >  	if (ret)
> > @@ -1002,7 +1073,8 @@ static int ad7280_probe(struct spi_device *spi)
> >  		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
> >  				   AD7280A_ALERT_REG, 0,
> >  				   AD7280A_ALERT_GEN_STATIC_HIGH |
> > -				   (pdata->chain_last_alert_ignore & 0xF));
> > +				   FIELD_PREP(AD7280A_ALERT_REMOVE_MSK,
> > +					      st->chain_last_alert_ignore));
> >  		if (ret)
> >  			return ret;
> >  
> > diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> > deleted file mode 100644
> > index 99297789a46d..000000000000
> > --- a/drivers/staging/iio/adc/ad7280a.h
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -/*
> > - * AD7280A Lithium Ion Battery Monitoring System
> > - *
> > - * Copyright 2011 Analog Devices Inc.
> > - */
> > -
> > -#ifndef IIO_ADC_AD7280_H_
> > -#define IIO_ADC_AD7280_H_
> > -
> > -/*
> > - * TODO: struct ad7280_platform_data needs to go into include/linux/iio
> > - */
> > -
> > -#define AD7280A_ACQ_TIME_400ns			0
> > -#define AD7280A_ACQ_TIME_800ns			1
> > -#define AD7280A_ACQ_TIME_1200ns			2
> > -#define AD7280A_ACQ_TIME_1600ns			3
> > -
> > -#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
> > -#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> > -#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
> > -#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
> > -
> > -struct ad7280_platform_data {
> > -	unsigned int		acquisition_time;
> > -	unsigned int		chain_last_alert_ignore;
> > -	bool			thermistor_term_en;
> > -};
> > -
> > -#endif /* IIO_ADC_AD7280_H_ */
> > -- 
> > 2.34.1
> >   

