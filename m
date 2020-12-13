Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE52F2D8DF1
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbgLMO2J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbgLMO2J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:28:09 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E43C22D2B;
        Sun, 13 Dec 2020 14:27:26 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:27:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Pop, Cristian" <Cristian.Pop@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: dac: ad5766: add driver support for AD5766
Message-ID: <20201213142722.2a52b88b@archlinux>
In-Reply-To: <SJ0PR03MB542332C028820DB869A54BAAE7CD0@SJ0PR03MB5423.namprd03.prod.outlook.com>
References: <20201204182043.86899-1-cristian.pop@analog.com>
        <20201204182043.86899-2-cristian.pop@analog.com>
        <20201205180120.70125969@archlinux>
        <SJ0PR03MB542332C028820DB869A54BAAE7CD0@SJ0PR03MB5423.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Dec 2020 13:30:06 +0000
"Pop, Cristian" <Cristian.Pop@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, December 5, 2020 8:01 PM
> > To: Pop, Cristian <Cristian.Pop@analog.com>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org
> > Subject: Re: [PATCH v2 2/2] iio: dac: ad5766: add driver support for AD5766
> > 
> > [External]
> > 
> > On Fri, 4 Dec 2020 20:20:43 +0200
> > Cristian Pop <cristian.pop@analog.com> wrote:
> >   
> > > The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense
> > > DACs Digital-to-Analog converters.
> > >
> > > This change adds support for these DACs.
> > >
> > > Link:
> > > https://www.analog.com/media/en/technical-documentation/data-  
> > sheets/ad  
> > > 5766-5767.pdf
> > >
> > > Signed-off-by: Cristian Pop <cristian.pop@analog.com>  
> > 
> > Missing build files + docs for the new ABI.
> > Note it doesn't build so a few things to fix on that front!
> > 
> > Docs in appropriate file under Documentation/ABI/testing/sysfs-bus-iio-*
> > 
> > I'm a bit curious about the range being entirely controllable from userspace
> > as well. Seems like something that might be dangerous in some systems.
> > Perhaps we need some sort of dt binding restriction mechanism?  
> If you think it is better to restrict the user to a range that is set in device tree,
> please let me know. In some cases it is possible to have an extended range maybe,
> or a combination of multiple ranges.

It's an interesting question of whether anyone actually would use these
parts in a circumstance where they wanted to only access the full range
via a mode switch.  I agree it is theoretically possible, but it's pretty
odd and would smack of curious design decisions to me!
I'm a little cynical in that I suspect the only people who ever change these
ranges are those using devkits to do a PoC.  Production hardware would normally
be designed to work best with a fixed range.

If a range that doesn't correspond to one of the supported ones, actually makes
sense, then having a dt binding that sets max and min values separately and
allowed the driver to check against both would work.

Thanks,

Jonathan

> > 
> >   
> > > ---
> > >  Changes in v2:
> > > 	-Remove forward declarations, arrange code
> > > 	-New ABI docs
> > > 	-Move "max_val" scope in case
> > > 	-Remove blank line
> > > 	-Use bitfield operations, where posible
> > > 	-Change declaration type to int of:
> > > 		int  
> > 	scale_avail[AD5766_VOLTAGE_RANGE_MAX][2];  
> > > 		int  
> > 	offset_avail[AD5766_VOLTAGE_RANGE_MAX][2];  
> > > 	-Move initialization down to just above where it is used:
> > > 		"type = spi_get_device_id(spi)->driver_data;"
> > >
> > >  drivers/iio/dac/ad5766.c | 758
> > > +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 758 insertions(+)
> > >  create mode 100644 drivers/iio/dac/ad5766.c
> > >
> > > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c new
> > > file mode 100644 index 000000000000..e6d24a41bd4e
> > > --- /dev/null
> > > +++ b/drivers/iio/dac/ad5766.c
> > > @@ -0,0 +1,758 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Analog Devices AD5766, AD5767
> > > + * Digital to Analog Converters driver
> > > + *
> > > + * Copyright 2019-2020 Analog Devices Inc.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/bitfield.h>
> > > +
> > > +#define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
> > > +#define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
> > > +#define AD5766_DITHER_SOURCE_MASK(x)		GENMASK(((2 * x) +  
> > 1), (2 * x))  
> > > +#define AD5766_DITHER_SCALE_MASK(x)  
> > 	AD5766_DITHER_SOURCE_MASK(x)  
> > > +
> > > +#define AD5766_CMD_NOP_MUX_OUT			0x00
> > > +#define AD5766_CMD_SDO_CNTRL			0x01
> > > +#define AD5766_CMD_WR_IN_REG(x)			(0x10 | ((x)  
> > & 0xF))  
> > > +#define AD5766_CMD_WR_DAC_REG(x)		(0x20 | ((x) & 0xF))
> > > +#define AD5766_CMD_SW_LDAC			0x30
> > > +#define AD5766_CMD_SPAN_REG			0x40
> > > +#define AD5766_CMD_WR_PWR_DITHER		0x51
> > > +#define AD5766_CMD_WR_DAC_REG_ALL		0x60
> > > +#define AD5766_CMD_SW_FULL_RESET		0x70
> > > +#define AD5766_CMD_READBACK_REG(x)		(0x80 | ((x) & 0xF))
> > > +#define AD5766_CMD_DITHER_SIG_1			0x90
> > > +#define AD5766_CMD_DITHER_SIG_2			0xA0
> > > +#define AD5766_CMD_INV_DITHER			0xB0
> > > +#define AD5766_CMD_DITHER_SCALE_1		0xC0
> > > +#define AD5766_CMD_DITHER_SCALE_2		0xD0
> > > +
> > > +#define AD5766_FULL_RESET_CODE			0x1234
> > > +
> > > +enum ad5766_type {
> > > +	ID_AD5766,
> > > +	ID_AD5767,
> > > +};
> > > +
> > > +enum ad5766_voltage_range {
> > > +	AD5766_VOLTAGE_RANGE_M20V_0V,
> > > +	AD5766_VOLTAGE_RANGE_M16V_to_0V,
> > > +	AD5766_VOLTAGE_RANGE_M10V_to_0V,
> > > +	AD5766_VOLTAGE_RANGE_M12V_to_14V,
> > > +	AD5766_VOLTAGE_RANGE_M16V_to_10V,
> > > +	AD5766_VOLTAGE_RANGE_M10V_to_6V,
> > > +	AD5766_VOLTAGE_RANGE_M5V_to_5V,
> > > +	AD5766_VOLTAGE_RANGE_M10V_to_10V,
> > > +	AD5766_VOLTAGE_RANGE_MAX,
> > > +};
> > > +
> > > +/**
> > > + * struct ad5766_chip_info - chip specific information
> > > + * @num_channels:	number of channels
> > > + * @channel:	        channel specification
> > > + */
> > > +struct ad5766_chip_info {
> > > +	unsigned int			num_channels;
> > > +	const struct iio_chan_spec	*channels;
> > > +};
> > > +
> > > +enum {
> > > +	AD5766_DITHER_PWR,
> > > +	AD5766_DITHER_INVERT
> > > +};
> > > +
> > > +/*
> > > + * External dither signal can be composed with the DAC output, if  
> > activated.  
> > > + * The dither signals are applied to the N0 and N1 input pins.
> > > + * Dither source for each of the channel can be selected by writing
> > > +to
> > > + * "dither_source",a 32 bit variable and two bits are used for each
> > > +of the 16
> > > + * channels: 0: NO_DITHER, 1: N0, 2: N1.
> > > + * This variable holds available dither source strings.
> > > + */
> > > +static const char * const ad5766_dither_sources[] = {
> > > +	"NO_DITHER",
> > > +	"N0",
> > > +	"N1",
> > > +};
> > > +
> > > +/*
> > > + * Dither signal can also be scaled.
> > > + * Available dither scale strings coresponding to "dither_scale"
> > > +field in
> > > + * "struct ad5766_state".
> > > + * "dither_scale" is a 32 bit variable and two bits are used for each
> > > +of the 16
> > > + * channels: 0: NO_SCALING, 1: 75%_SCALING, 2: 50%_SCALING, 3:  
> > 25%_SCALING.
> > 
> > Needs explicit ABI docs for a proper discussion.  My gut feeling is it should
> > be two controls. On/off + a scaling control that takes integer values.  
> There is a dither on/off, we can also add an on/off control for scale and source
> If requested.
> >   
> > > + */
> > > +static const char * const ad5766_dither_scales[] = {
> > > +	"NO_SCALING",
> > > +	"75%_SCALING",
> > > +	"50%_SCALING",
> > > +	"25%_SCALING",
> > > +};
> > > +
> > > +/**
> > > + * struct ad5766_state - driver instance specific data
> > > + * @spi:		SPI device
> > > + * @lock:		Mutex lock  
> > 
> > Say what exactly the scope of the lock is.  No interest at all to tell us what is
> > clear from the type of the structure element.
> >   
> > > + * @chip_info:		Chip model specific constants
> > > + * @gpio_reset:		Reset GPIO, used to reset the device
> > > + * @crt_range:		Current selected output range
> > > + * @cached_offset:	Cached range coresponding to the selected offset
> > > + * @dither_power_ctrl:	Power-down bit for each channel dither  
> > block (for  
> > > + *			example, D15 = DAC 15,D8 = DAC 8, and D0 = DAC 0)
> > > + *			0 - Normal operation, 1 - Power down
> > > + * @dither_invert:	Inverts the dither signal applied to the selected DAC
> > > + *			outputs
> > > + * @dither_source:	Selects between 3 possible sources:
> > > + *			0: No dither, 1: N0, 2: N1
> > > + *			Two bits are used for each channel
> > > + * @dither_scale:	Selects between 4 possible scales:
> > > + *			0: No scale, 1: 75%, 2: 50%, 3: 25%
> > > + *			Two bits are used for each channel
> > > + * @scale_avail:	Scale available table
> > > + * @offset_avail:	Offest available table
> > > + * @data:		SPI transfer buffers
> > > + */
> > > +struct ad5766_state {
> > > +	struct spi_device		*spi;
> > > +	struct mutex			lock;
> > > +	const struct ad5766_chip_info	*chip_info;
> > > +	struct gpio_desc		*gpio_reset;
> > > +	enum ad5766_voltage_range	crt_range;
> > > +	enum ad5766_voltage_range	cached_offset;
> > > +	u16		dither_power_ctrl;
> > > +	u16		dither_invert;
> > > +	u32		dither_source;
> > > +	u32		dither_scale;
> > > +	int		scale_avail[AD5766_VOLTAGE_RANGE_MAX][2];
> > > +	int		offset_avail[AD5766_VOLTAGE_RANGE_MAX][2];
> > > +	union {
> > > +		u32	d32;
> > > +		u16	w16[2];
> > > +		u8	b8[4];
> > > +	} data[3] ____cacheline_aligned;
> > > +};
> > > +  
> > ...  
> > > +
> > > +static int _ad5766_spi_read(struct ad5766_state *st, u8 dac, int
> > > +*val) {
> > > +	int ret;
> > > +	struct spi_transfer xfers[] = {
> > > +		{
> > > +			.tx_buf = &st->data[0].d32,
> > > +			.bits_per_word = 8,
> > > +			.len = 3,
> > > +			.cs_change = 1,
> > > +		}, {
> > > +			.tx_buf = &st->data[1].d32,
> > > +			.rx_buf = &st->data[2].d32,
> > > +			.bits_per_word = 8,
> > > +			.len = 3,
> > > +		},
> > > +	};
> > > +
> > > +	st->data[0].d32 = AD5766_CMD_READBACK_REG(dac);
> > > +	st->data[1].d32 = AD5766_CMD_NOP_MUX_OUT;
> > > +
> > > +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val = st->data[2].w16[1];
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int _ad5766_spi_write(struct ad5766_state *st, u8 command, u16
> > > +data) {
> > > +	st->data[0].b8[0] = command;
> > > +	st->data[0].b8[1] = (data & 0xFF00) >> 8;
> > > +	st->data[0].b8[2] = (data & 0x00FF) >> 0;  
> > 
> > That's an unaligned put so ideally use put_unaligned_xx16 and friends to
> > make that clear.
> >   
> > > +
> > > +	return spi_write(st->spi, &st->data[0].b8[0], 3); }
> > > +
> > > +static int ad5766_read(struct iio_dev *indio_dev, u8 dac, int *val) {
> > > +	struct ad5766_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	mutex_lock(&st->lock);
> > > +	ret = _ad5766_spi_read(st, dac, val);
> > > +	mutex_unlock(&st->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int ad5766_write(struct iio_dev *indio_dev, u8 dac, u16 data)
> > > +{
> > > +	struct ad5766_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	mutex_lock(&st->lock);
> > > +	ret = _ad5766_spi_write(st, AD5766_CMD_WR_DAC_REG(dac),  
> > data);
> > 
> > Normal convention for this sort of function would be __ rather than _ Looks
> > more deliberate.
> >   
> > > +	mutex_unlock(&st->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +  
> > 
> > ...
> >   
> > > +
> > > +#define _AD5766_CHAN_EXT_INFO(_name, _what, _shared) { \
> > > +	.name = _name, \
> > > +	.read = ad5766_read_ext, \
> > > +	.write = ad5766_write_ext, \
> > > +	.private = _what, \
> > > +	.shared = _shared, \
> > > +}
> > > +
> > > +static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
> > > +
> > > +	_AD5766_CHAN_EXT_INFO("dither_pwr", AD5766_DITHER_PWR,  
> > IIO_SEPARATE),  
> > > +	_AD5766_CHAN_EXT_INFO("dither_invert",  
> > AD5766_DITHER_INVERT,  
> > > +			      IIO_SEPARATE),
> > > +	IIO_ENUM("dither_source", IIO_SEPARATE,  
> > &ad5766_dither_source_enum),  
> > > +	IIO_ENUM_AVAILABLE_SHARED("dither_source",
> > > +				  IIO_SEPARATE,
> > > +				  &ad5766_dither_source_enum),
> > > +	IIO_ENUM("dither_scale", IIO_SEPARATE,  
> > &ad5766_dither_scale_enum),  
> > > +	IIO_ENUM_AVAILABLE_SHARED("dither_scale",  
> > 
> > That macro doesn't exist in mainline.
> >   
> > > +				  IIO_SEPARATE,
> > > +				  &ad5766_dither_scale_enum),
> > > +	{}
> > > +};  
> > 
> > All the above need ABI docs so we can talk about them without having to
> > read data sheets.
> > 
> > ...  

