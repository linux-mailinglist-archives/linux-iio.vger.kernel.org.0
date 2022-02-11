Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389AB4B2812
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 15:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351019AbiBKOiO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Feb 2022 09:38:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiBKOiN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2022 09:38:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E989188;
        Fri, 11 Feb 2022 06:38:11 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JwGRR3PLpz67xg8;
        Fri, 11 Feb 2022 22:37:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 11 Feb 2022 15:38:09 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Feb
 2022 14:38:08 +0000
Date:   Fri, 11 Feb 2022 14:38:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio:amplifiers:ada4250: add support for ADA4250
Message-ID: <20220211143806.000027de@Huawei.com>
In-Reply-To: <CY4PR03MB3399A93A85A377B11CF57A8F9B309@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220211095057.54979-1-antoniu.miclaus@analog.com>
        <20220211095057.54979-2-antoniu.miclaus@analog.com>
        <20220211124618.00000a70@Huawei.com>
        <CY4PR03MB3399A93A85A377B11CF57A8F9B309@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Feb 2022 13:41:21 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Friday, February 11, 2022 2:46 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/3] iio:amplifiers:ada4250: add support for ADA4250
> > 
> > [External]
> > 
> > On Fri, 11 Feb 2022 11:50:55 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >   
> > > The ADA4250 is an instrumentation amplifier with SPI/pin-strap
> > > progammable gains that is optimized for ultra-low power systems.
> > > With a minimum supply voltage of 1.7V, 26uA of quiescent current,
> > > a shutdown mode, a sleep mode, and a fast wake up settling time,
> > > ADA4250 can be power cycled on a battery powered system for even
> > > futher savings.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> > 
> > Hi Antoniu,
> > 
> > Just to check, this sort of amplifier is normally not used as
> > an analog front end?  If it were we'd want to deal with it
> > being a consumer of the ADC channels similar to our other AFE drivers.
> > If that's a possible usecase we might want to consider how to support
> > that if relevant to a particular configuration.
> > 
> > I don't understand what the two channels are.  Could you give us
> > some more description?
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hello Jonathan,
> 
> This is a basic amplifier part, that receives a voltage as input and applies a gain/offset to it.
> 
> I initially added a single IIO voltage channel having all the below attributes.
> But the gain has no measurement unit (V/V), as specified in `hwgain_table[]` comment.
> Same for the current bias setting (see `calibbias_table` comment).

True, neither of those are expected to have any relevance to scale.

> 
> Also I wanted to somehow emphasize that the scaling applies only to the offset value
> which is passed in uV so we can avoid floating point computations.

That should be fine anyway as it's
value realworld = ((internal value) + offset) * scale

The calibbias and hwgain are both not involved in that as they are considered to not affect
the realworld conversion. 

> The output offset raw value is computed based on the input voltage value set by the user.
> Depending on that value, and the current bias setting, a table of values/equations is provided
> in the documentation that establishes the VLSB/range values that need to be written in the 
> afferent registers (the entire computation is done in the `set_offset` function).

Hmm. Understood now.  I can see you concern because there might be some suggestion scale
is related to the amplifier gain.  I think our documentation should make it clear it
only applies to (raw + offset) but maybe we need to make that clearer, particularly
for amplifiers?

Anyhow, I think we need to squash this back down to a single channel as there is
no obvious meaning to having separate voltage and altvoltage channels here.

Thanks,

Jonathan


Jonathan

>  
> Regards,
> Antoniu
> >   
> > > ---
> > >  drivers/iio/amplifiers/Kconfig   |  11 +
> > >  drivers/iio/amplifiers/Makefile  |   1 +
> > >  drivers/iio/amplifiers/ada4250.c | 388  
> > +++++++++++++++++++++++++++++++  
> > >  3 files changed, 400 insertions(+)
> > >  create mode 100644 drivers/iio/amplifiers/ada4250.c
> > >
> > > diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> > > index 5eb1357a9c78..98612e01d9d4 100644
> > > --- a/drivers/iio/amplifiers/Kconfig
> > > +++ b/drivers/iio/amplifiers/Kconfig
> > > @@ -23,6 +23,17 @@ config AD8366
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called ad8366.
> > >
> > > +config ADA4250
> > > +	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
> > > +	depends on SPI
> > > +	help
> > > +	  Say yes here to build support for Analog Devices ADA4250
> > > +	  SPI Amplifier's support. The driver provides direct access via
> > > +          sysfs.  
> > 
> > Odd spacing.
> >   
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called ada4250.
> > > +
> > >  config HMC425
> > >  	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
> > >  	depends on GPIOLIB
> > > diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
> > > index cb551d82f56b..2126331129cf 100644
> > > --- a/drivers/iio/amplifiers/Makefile
> > > +++ b/drivers/iio/amplifiers/Makefile
> > > @@ -5,4 +5,5 @@
> > >
> > >  # When adding new entries keep the list in alphabetical order
> > >  obj-$(CONFIG_AD8366) += ad8366.o
> > > +obj-$(CONFIG_ADA4250) += ada4250.o
> > >  obj-$(CONFIG_HMC425) += hmc425a.o
> > > diff --git a/drivers/iio/amplifiers/ada4250.c  
> > b/drivers/iio/amplifiers/ada4250.c  
> > > new file mode 100644
> > > index 000000000000..10725f6c2751
> > > --- /dev/null
> > > +++ b/drivers/iio/amplifiers/ada4250.c
> > > @@ -0,0 +1,388 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * ADA4250 driver
> > > + *
> > > + * Copyright 2022 Analog Devices Inc.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/device.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +/* ADA4250 Register Map */
> > > +#define ADA4250_REG_GAIN_MUX        0x00
> > > +#define ADA4250_REG_REFBUF_EN       0x01
> > > +#define ADA4250_REG_RESET           0x02
> > > +#define ADA4250_REG_SNSR_CAL_VAL    0x04
> > > +#define ADA4250_REG_SNSR_CAL_CNFG   0x05
> > > +#define ADA4250_REG_DIE_REV         0x18
> > > +#define ADA4250_REG_CHIP_ID         0x19
> > > +
> > > +/* ADA4250_REG_GAIN_MUX Map */
> > > +#define ADA4250_GAIN_MUX_MSK        GENMASK(2, 0)
> > > +
> > > +/* ADA4250_REG_REFBUF Map */
> > > +#define ADA4250_REFBUF_MSK          BIT(0)
> > > +
> > > +/* ADA4250_REG_RESET Map */
> > > +#define ADA4250_RESET_MSK           BIT(0)
> > > +
> > > +/* ADA4250_REG_SNSR_CAL_VAL Map */
> > > +#define ADA4250_SNSR_CAL_VAL_MSK    GENMASK(7, 0)
> > > +
> > > +/* ADA4250_REG_SNSR_CAL_CNFG Bit Definition */
> > > +#define ADA4250_BIAS_SET_MSK        GENMASK(3, 2)
> > > +#define ADA4250_RANGE_SET_MSK       GENMASK(1, 0)
> > > +
> > > +/* Miscellaneous definitions */
> > > +#define ADA4250_CHIP_ID             0x4250
> > > +#define ADA4250_RANGE1              0
> > > +#define	ADA4250_RANGE4              3
> > > +
> > > +/* ADA4250 current bias set */
> > > +enum ada4250_current_bias {
> > > +	ADA4250_BIAS_DISABLED,
> > > +	ADA4250_BIAS_BANDGAP,
> > > +	ADA4250_BIAS_AVDD,
> > > +};
> > > +
> > > +struct ada4250_state {
> > > +	struct spi_device	*spi;
> > > +	struct regmap		*regmap;
> > > +	struct regulator	*reg;
> > > +	/* Protect against concurrent accesses to the device and data  
> > content */  
> > > +	struct mutex		lock;
> > > +	u8			bias;
> > > +	u8			gain;
> > > +	int			offset_uv;
> > > +	bool			refbuf_en;
> > > +};
> > > +
> > > +/* ADA4250 Current Bias Source Settings: Disabled, Bandgap Reference,  
> > AVDD */  
> > > +static const int calibbias_table[] = {0, 1, 2};
> > > +
> > > +/* ADA4250 Gain (V/V) values: 1, 2, 4, 8, 16, 32, 64, 128 */
> > > +static const int hwgain_table[] = {0, 1, 2, 3, 4, 5, 6, 7};
> > > +
> > > +static const struct regmap_config ada4250_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.read_flag_mask = BIT(7),
> > > +	.max_register = 0x1A,
> > > +};
> > > +
> > > +static int ada4250_set_offset_uv(struct iio_dev *indio_dev,
> > > +				 const struct iio_chan_spec *chan,
> > > +				 int offset_uv)
> > > +{
> > > +	struct ada4250_state *st = iio_priv(indio_dev);
> > > +
> > > +	int i, ret, x[8], max_vos, min_vos, voltage_v, vlsb = 0;
> > > +	u8 offset_raw, range = ADA4250_RANGE1;
> > > +	u32 lsb_coeff[6] = {1333, 2301, 4283, 8289, 16311, 31599};
> > > +
> > > +	if (st->bias == 0 || st->bias == 3)
> > > +		return -EINVAL;
> > > +
> > > +	voltage_v = regulator_get_voltage(st->reg);
> > > +	voltage_v = DIV_ROUND_CLOSEST(voltage_v, 1000000);
> > > +
> > > +	if (st->bias == ADA4250_BIAS_AVDD)
> > > +		x[0] = voltage_v;
> > > +	else
> > > +		x[0] = 5;
> > > +
> > > +	x[1] = 126 * (x[0] - 1);
> > > +
> > > +	for (i = 0; i < 6; i++)
> > > +		x[i + 2] = DIV_ROUND_CLOSEST(x[1] * 1000, lsb_coeff[i]);
> > > +
> > > +	if (st->gain == 0)
> > > +		return -EINVAL;
> > > +
> > > +	/* Compute Range and VLSB for the Sensor Offset Calibration */
> > > +	for (i = ADA4250_RANGE1; i <= ADA4250_RANGE4; i++) {
> > > +		max_vos = x[st->gain] *  127 * ((1 << (i + 1)) - 1);
> > > +		min_vos = -1 * max_vos;
> > > +		if (offset_uv > min_vos && offset_uv < max_vos) {
> > > +			range = i;
> > > +			vlsb = x[st->gain] * ((1 << (i + 1)) - 1);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (vlsb <= 0)
> > > +		return -EINVAL;
> > > +
> > > +	offset_raw = DIV_ROUND_CLOSEST(abs(offset_uv), vlsb);
> > > +
> > > +	mutex_lock(&st->lock);
> > > +	ret = regmap_update_bits(st->regmap,  
> > ADA4250_REG_SNSR_CAL_CNFG,  
> > > +				 ADA4250_RANGE_SET_MSK,
> > > +				 FIELD_PREP(ADA4250_RANGE_SET_MSK,  
> > range));  
> > > +	if (ret)
> > > +		goto exit;
> > > +
> > > +	st->offset_uv = offset_raw * vlsb;
> > > +
> > > +	if (offset_uv < 0) {
> > > +		offset_raw |= 1 << 8;
> > > +		st->offset_uv *= (-1);
> > > +	}
> > > +
> > > +	ret = regmap_write(st->regmap, ADA4250_REG_SNSR_CAL_VAL,  
> > offset_raw);  
> > > +
> > > +exit:
> > > +	mutex_unlock(&st->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int ada4250_read_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *chan,
> > > +			    int *val, int *val2, long info)
> > > +{
> > > +	struct ada4250_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +		ret = regmap_read(st->regmap, ADA4250_REG_GAIN_MUX,  
> > val);  
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > +		*val = st->offset_uv;
> > > +
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_CALIBBIAS:
> > > +		ret = regmap_read(st->regmap,  
> > ADA4250_REG_SNSR_CAL_CNFG, val);  
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		*val = FIELD_GET(ADA4250_BIAS_SET_MSK, *val);
> > > +
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*val = 1;
> > > +		*val2 = 1000000;
> > > +
> > > +		return IIO_VAL_FRACTIONAL;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int ada4250_write_raw(struct iio_dev *indio_dev,
> > > +			     struct iio_chan_spec const *chan,
> > > +			     int val, int val2, long info)
> > > +{
> > > +	struct ada4250_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +		ret = regmap_write(st->regmap, ADA4250_REG_GAIN_MUX,
> > > +				   FIELD_PREP(ADA4250_GAIN_MUX_MSK,  
> > val));  
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		st->gain = val;
> > > +
> > > +		return ret;
> > > +	case IIO_CHAN_INFO_OFFSET:  
> > 
> > Given no DS, please provide some more info on what the channels are to
> > help evaluate if this is the appropriate interface.
> >   
> > > +		return ada4250_set_offset_uv(indio_dev, chan, val);
> > > +	case IIO_CHAN_INFO_CALIBBIAS:
> > > +		ret = regmap_update_bits(st->regmap,  
> > ADA4250_REG_SNSR_CAL_CNFG,  
> > > +					 ADA4250_BIAS_SET_MSK,
> > > +  
> > FIELD_PREP(ADA4250_BIAS_SET_MSK, val));  
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		st->bias = val;
> > > +
> > > +		return ret;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int ada4250_read_avail(struct iio_dev *indio_dev,
> > > +			      struct iio_chan_spec const *chan,
> > > +			      const int **vals, int *type, int *length,
> > > +			      long mask)
> > > +{
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_CALIBBIAS:
> > > +		*vals = calibbias_table;
> > > +		*type = IIO_VAL_INT;
> > > +		*length = ARRAY_SIZE(calibbias_table);
> > > +
> > > +		return IIO_AVAIL_LIST;
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +		*vals = hwgain_table;
> > > +		*type = IIO_VAL_INT;
> > > +		*length = ARRAY_SIZE(hwgain_table);
> > > +
> > > +		return IIO_AVAIL_LIST;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int ada4250_reg_access(struct iio_dev *indio_dev,
> > > +			      unsigned int reg,
> > > +			      unsigned int write_val,
> > > +			      unsigned int *read_val)
> > > +{
> > > +	struct ada4250_state *st = iio_priv(indio_dev);
> > > +
> > > +	if (read_val)
> > > +		return regmap_read(st->regmap, reg, read_val);
> > > +	else
> > > +		return regmap_write(st->regmap, reg, write_val);
> > > +}
> > > +
> > > +static const struct iio_info ada4250_info = {
> > > +	.read_raw = ada4250_read_raw,
> > > +	.write_raw = ada4250_write_raw,
> > > +	.read_avail = &ada4250_read_avail,
> > > +	.debugfs_reg_access = &ada4250_reg_access,
> > > +};
> > > +
> > > +static const struct iio_chan_spec ada4250_channels[] = {
> > > +	{
> > > +		.type = IIO_ALTVOLTAGE,  
> > 
> > For a device like this, I'd argue it's not 'necessarily' an alternating
> > voltage so type should probably be just voltage.  Obviously if there
> > is something about the amplifier architecture that means it won't carry
> > DC then it's a different matter.
> >   
> > > +		.output = 1,
> > > +		.indexed = 1,
> > > +		.channel = 0,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > > +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > > +		.info_mask_separate_available =  
> > BIT(IIO_CHAN_INFO_CALIBBIAS) |  
> > > +  
> > 	BIT(IIO_CHAN_INFO_HARDWAREGAIN),  
> > > +	},
> > > +	{
> > > +		.type = IIO_VOLTAGE,  
> > 
> > Given we have no datasheet, what's this?  Add a comment.
> >   
> > > +		.output = 1,
> > > +		.indexed = 1,
> > > +		.channel = 0,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
> > > +				      BIT(IIO_CHAN_INFO_SCALE),  
> > 
> > This is unusual as I'm not sure what meaning an offset and scale have
> > with out a raw value.
> >   
> > > +	},
> > > +};
> > > +
> > > +static void ada4250_reg_disable(void *data)
> > > +{
> > > +	regulator_disable(data);
> > > +}
> > > +
> > > +static int ada4250_init(struct ada4250_state *st)
> > > +{
> > > +	int ret;
> > > +	u16 chip_id;
> > > +	u8 data[2];
> > > +	struct spi_device *spi = st->spi;
> > > +
> > > +	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-  
> > enable");  
> > > +
> > > +	st->reg = devm_regulator_get(&spi->dev, "avdd");
> > > +	if (IS_ERR(st->reg))
> > > +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> > > +				     "failed to get the AVDD voltage\n");
> > > +
> > > +	ret = regulator_enable(st->reg);
> > > +	if (ret) {
> > > +		dev_err(&spi->dev, "Failed to enable specified AVDD  
> > supply\n");  
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = devm_add_action_or_reset(&spi->dev, ada4250_reg_disable,  
> > st->reg);  
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_write(st->regmap, ADA4250_REG_RESET,
> > > +			   FIELD_PREP(ADA4250_RESET_MSK, 1));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data,  
> > 2);
> > I think our current position is that regmap_bulk_* accesses should use
> > DMA safe buffers (on SPI anyway) as it's possible the implementation may
> > required that and it isn't documented as not requiring it.
> >   
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	chip_id = (data[1] << 8) | data[0];  
> > 
> > Endian conversion.  Firstly make data the appropriate type then use
> > the appropriate endian conversion function.
> >   
> > > +
> > > +	if (chip_id != ADA4250_CHIP_ID) {
> > > +		dev_err(&spi->dev, "Invalid chip ID.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return regmap_write(st->regmap, ADA4250_REG_REFBUF_EN,
> > > +			    FIELD_PREP(ADA4250_REFBUF_MSK, st-
> > >refbuf_en));
> > > +}
> > > +  
> >   
> 

