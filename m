Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF2344723
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVO3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 10:29:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2725 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCVO2n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 10:28:43 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F3xXS6zLBz681n6;
        Mon, 22 Mar 2021 22:22:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 15:28:41 +0100
Received: from localhost (10.47.84.0) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 22 Mar
 2021 14:28:40 +0000
Date:   Mon, 22 Mar 2021 14:27:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210322142722.000053a6@Huawei.com>
In-Reply-To: <20210322115635.GA14791@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
        <20210319144509.7627-4-o.rempel@pengutronix.de>
        <20210320154601.0131805d@jic23-huawei>
        <20210322115635.GA14791@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.0]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> >   
> > > +	/*
> > > +	 * Lock to protect the layout and the spi transfer buffer.
> > > +	 * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> > > +	 * in this case the l[] and tx/rx buffer will be out of sync to each
> > > +	 * other.
> > > +	 */
> > > +	struct mutex slock;
> > > +	struct tsc2046_adc_group_layout l[TI_TSC2046_MAX_CHAN];
> > > +	struct tsc2046_adc_atom *rx;
> > > +	struct tsc2046_adc_atom *tx;
> > > +
> > > +	struct tsc2046_adc_atom *rx_one;
> > > +	struct tsc2046_adc_atom *tx_one;
> > > +
> > > +	unsigned int count;
> > > +	unsigned int groups;
> > > +	u32 effective_speed_hz;
> > > +	u32 scan_interval_us;
> > > +	u32 time_per_scan_us;
> > > +	u32 time_per_bit_ns;
> > > +
> > > +	struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
> > > +};
> > > +
> > > +#define TI_TSC2046_V_CHAN(index, bits, name)			\
> > > +{								\
> > > +	.type = IIO_VOLTAGE,					\
> > > +	.indexed = 1,						\
> > > +	.channel = index,					\
> > > +	.datasheet_name = "#name",				\
> > > +	.scan_index = index,					\
> > > +	.scan_type = {						\
> > > +		.sign = 'u',					\
> > > +		.realbits = bits,				\
> > > +		.storagebits = 16,				\
> > > +		.endianness = IIO_CPU,				\
> > > +	},							\
> > > +}  
> > 
> > I'd not noticed this before but you are exposing nothing to the
> > normal IIO interfaces.
> > 
> > That means for usecases like iio-hwmon there is no access
> > to polled readings, or information like channel scaling.
> > 
> > I suppose that could be added later, but perhaps you want to call this
> > out by mentioning it in the patch description.  
> 
> If it is ok for you, then I'll add some words about it in to the patch
> description.
Sure

> 
> > > +
> > > +#define DECLARE_TI_TSC2046_8_CHANNELS(name, bits) \
> > > +const struct iio_chan_spec name ## _channels[] = { \
> > > +	TI_TSC2046_V_CHAN(0, bits, TEMP0), \
> > > +	TI_TSC2046_V_CHAN(1, bits, Y), \
> > > +	TI_TSC2046_V_CHAN(2, bits, VBAT), \
> > > +	TI_TSC2046_V_CHAN(3, bits, Z1), \
> > > +	TI_TSC2046_V_CHAN(4, bits, Z2), \
> > > +	TI_TSC2046_V_CHAN(5, bits, X), \
> > > +	TI_TSC2046_V_CHAN(6, bits, AUX), \
> > > +	TI_TSC2046_V_CHAN(7, bits, TEMP1), \
> > > +	IIO_CHAN_SOFT_TIMESTAMP(8), \
> > > +}
> > > +
> > > +static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> > > +
> > > +static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
> > > +	.channels = tsc2046_adc_channels,
> > > +	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
> > > +};
> > > +  
> > 
> > Hmm.  Flexibility that isn't yet used.  Normally I'm pretty resistant
> > to this going in, unless I'm reassured that there is support for additional
> > devices already in the pipeline.  Is that true here?  Otherwise
> > this is basically unneeded complexity.  
> 
> In the long term this driver should replace
> drivers/input/touchscreen/ads7846.c
> 
> This driver supports ti,ads7843, ti,ads7845, ti,ads7846.. at least with
> following number of supported channels:
> ti,ads7843 - 4 channels: x, y, aux0, aux1
> ti,ads7845 - 3 channels: x, y, aux0
> ti,ads7846 - 8 channels...
> 
> Currently I don't have this HW for testing and there a subtle
> differences that have to be taken care of and tested.
> 

Note that I'm only going to merge this driver with an explicit statement
from Dmitry as input maintainer that he is fine with this approach.

Jonathan
