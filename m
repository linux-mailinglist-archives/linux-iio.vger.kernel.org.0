Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A05225D35
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGTLNV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgGTLNU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 07:13:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1377C2073A;
        Mon, 20 Jul 2020 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595243599;
        bh=M5jvI/quvoForWUcS62rD6ZdvRnxbGiZoLp3i3Iuz/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KuStPNymwyTh8RDmwb+Tm9hMHS1XdTHET98Xf1ILTeFt+4ijVlWyPzM30huDq9UAa
         kL09Q8fZvrrhidHX1aTswrxKE1VCU7SYeXsSOnOJR8NWJ3D03jfPWr3Ig+uRdC53+x
         DgrNS031N0b2tgvfjq14qkf3JlKL4iKeFXHWF1x0=
Date:   Mon, 20 Jul 2020 12:13:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: gyro: Add driver support for ADXRS290
Message-ID: <20200720121315.38500910@archlinux>
In-Reply-To: <e369f36c-ec9e-0f90-674f-06c7d51d8b5e@gmail.com>
References: <20200715092757.14563-1-nish.malpani25@gmail.com>
        <e369f36c-ec9e-0f90-674f-06c7d51d8b5e@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 15:20:35 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Hello,
>=20
> On 15/07/20 2:57 pm, Nishant Malpani wrote:
> > ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
> > angular rate sensor (gyroscope) designed for use in stabilization
> > applications. It also features an internal temperature sensor and
> > programmable high-pass and low-pass filters.
> >=20
> > Add support for ADXRS290 in direct-access mode for now.
> >=20
> > Datasheet:
> > Link: https://www.analog.com/media/en/technical-documentation/data-shee=
ts/ADXRS290.pdf
> >=20
> > Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Hi Nishant,

Mostly looks good. A few comments / questions inline.

I replied to your reply so I could answer the question you raised alongside
the rest of the review.  Short answer, do precise matches as everything
necessary is exposed to userspace or userspace to be clever if wants to be.

Thanks,

Jonathan

> > ---
> >   MAINTAINERS                 |   6 +
> >   drivers/iio/gyro/Kconfig    |  10 +
> >   drivers/iio/gyro/Makefile   |   1 +
> >   drivers/iio/gyro/adxrs290.c | 490 ++++++++++++++++++++++++++++++++++++
> >   4 files changed, 507 insertions(+)
> >   create mode 100644 drivers/iio/gyro/adxrs290.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e016ee39c74a..dd02cfc410e8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1098,6 +1098,12 @@ L:	linux-media@vger.kernel.org
> >   S:	Maintained
> >   F:	drivers/media/i2c/adv7842*
> >  =20
> > +ANALOG DEVICES INC ADXRS290 DRIVER
> > +M:	Nishant Malpani <nish.malpani25@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +F:	drivers/iio/gyro/adxrs290.c
> > +
> >   ANALOG DEVICES INC ASOC CODEC DRIVERS
> >   M:	Lars-Peter Clausen <lars@metafoo.de>
> >   M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> > diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> > index 6daeddf37f60..024a34139875 100644
> > --- a/drivers/iio/gyro/Kconfig
> > +++ b/drivers/iio/gyro/Kconfig
> > @@ -41,6 +41,16 @@ config ADIS16260
> >   	  This driver can also be built as a module.  If so, the module
> >   	  will be called adis16260.
> >  =20
> > +config ADXRS290
> > +	tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Analog Devices ADXRS290 programma=
ble
> > +	  digital output gyroscope.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called adxrs290.
> > +
> >   config ADXRS450
> >   	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI dri=
ver"
> >   	depends on SPI
> > diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> > index 45cbd5dc644e..0319b397dc3f 100644
> > --- a/drivers/iio/gyro/Makefile
> > +++ b/drivers/iio/gyro/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_ADIS16080) +=3D adis16080.o
> >   obj-$(CONFIG_ADIS16130) +=3D adis16130.o
> >   obj-$(CONFIG_ADIS16136) +=3D adis16136.o
> >   obj-$(CONFIG_ADIS16260) +=3D adis16260.o
> > +obj-$(CONFIG_ADXRS290) +=3D adxrs290.o
> >   obj-$(CONFIG_ADXRS450) +=3D adxrs450.o
> >   obj-$(CONFIG_BMG160) +=3D bmg160_core.o
> >   obj-$(CONFIG_BMG160_I2C) +=3D bmg160_i2c.o
> > diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> > new file mode 100644
> > index 000000000000..1139f79a3bd5
> > --- /dev/null
> > +++ b/drivers/iio/gyro/adxrs290.c
> > @@ -0,0 +1,490 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * ADXRS290 SPI Gyroscope Driver
> > + *
> > + * Copyright (C) 2020 Analog Devices, Inc.

Nishant, you are doing a gsoc I believe?

If so I'd assume the copyright should be yours or joint with ADI rather
than just ADI?

> > + */
> > +
> > +#include <asm/unaligned.h>

Convention is put 'generic headers' (e.g. the linux/ ones first)
then arch specific (asm) stuff after.
Not sure that's actually documented anywhere though!

> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/delay.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define ADXRS290_ADI_ID		0xAD
> > +#define ADXRS290_MEMS_ID	0x1D
> > +#define ADXRS290_DEV_ID		0x92
> > +
> > +#define ADXRS290_REG_ADI_ID	0x00 /* Analog Devices Identifier Register=
 */
> > +#define ADXRS290_REG_MEMS_ID	0x01 /* MEMS Identifier Register */
> > +#define ADXRS290_REG_DEV_ID	0x02 /* Device Identifier Register */
> > +#define ADXRS290_REG_REV_ID	0x03 /* Silicon Revision Number Register */

These first 4 are fairly obvious from the naming so I don't think the comme=
nts
add much.

> > +#define ADXRS290_REG_SN0	0x04 /* Serial Number Registers, 4 bytes */
> > +#define ADXRS290_REG_DATAX0	0x08 /* Roll Rate o/p Data Regs, 2 bytes */
> > +#define ADXRS290_REG_DATAY0	0x0A /* Pitch Rate o/p Data Regs, 2 bytes =
*/

Are we actually right to map roll and pitch to x and y?=20
If so we should probably add that to the docs somewhere.  We need to docume=
nt
which one maps to x and which to y as that mapping is far from obvious!

> > +#define ADXRS290_REG_TEMP0	0x0C /* Temperature Data Registers, 2 bytes=
 */
> > +#define ADXRS290_REG_POWER_CTL	0x10 /* Power Control Register */
> > +#define ADXRS290_REG_FILTER	0x11 /* Band-pass Filter Register */
> > +#define ADXRS290_REG_DATA_RDY	0x12 /* Data Ready Register */

Most of these comments also don't tell us anything the naming doesn't.
Always keep in mind that comments may become incorrect due to future change=
s,
hence just use them when the comment adds significant value in of itself.

> > +
> > +#define ADXRS290_READ		BIT(7)
> > +#define ADXRS290_TSM		BIT(0)
> > +#define ADXRS290_MEASUREMENT	BIT(1)
> > +#define ADXRS290_SYNC		GENMASK(1, 0)
> > +#define ADXRS290_LPF_MASK	GENMASK(2, 0)
> > +#define ADXRS290_LPF(x)		FIELD_PREP(ADXRS290_LPF_MASK, x)
> > +#define ADXRS290_HPF_MASK	GENMASK(7, 4)
> > +#define ADXRS290_HPF(x)		FIELD_PREP(ADXRS290_HPF_MASK, x)
> > +
> > +#define ADXRS290_READ_REG(reg)	(ADXRS290_READ | (reg))
> > +
> > +#define ADXRS290_MAX_TRANSITION_TIME_MS 100
> > +
> > +enum adxrs290_mode {
> > +	STANDBY,
> > +	MEASUREMENT,
> > +};
> > +
> > +struct adxrs290_state {
> > +	struct spi_device	*spi;
> > +	/* To atomize successive reads for single measurement */

Comment doesn't seem to be accurate.  Key point is you are
protecting the  buffers by serializing the read and processing of
the read.

> > +	struct mutex		lock;
> > +	enum adxrs290_mode	mode;
> > +	unsigned int		lpf_3db_freq_idx;
> > +	unsigned int		hpf_3db_freq_idx;
> > +	union {
> > +		u8 tx;
> > +		u8 rx[2];

I would not bother with a union here. It will save little
space and make readers have to think about whether it is safe.
Mark the tx as aligned and the following rx will be in the same
cacheline which should be safe.

> > +	}			data ____cacheline_aligned;
> > +};
> > +
> > +/*
> > + * Available cut-off frequencies of the low pass filter in Hz.
> > + * The integer part and fractional part are represented separately.
> > + */
> > +static const unsigned int adxrs290_lpf_3db_freq_tbl[][2] =3D {
> > +	[0] =3D {480, 0},
> > +	[1] =3D {320, 0},
> > +	[2] =3D {160, 0},
> > +	[3] =3D {80, 0},
> > +	[4] =3D {56, 600},
> > +	[5] =3D {40, 0},
> > +	[6] =3D {28, 300},
> > +	[7] =3D {20, 0},
> > +};
> > +
> > +/*
> > + * Available cut-off frequencies of the high pass filter in Hz.
> > + * The integer part and fractional part are represented separately.
> > + */
> > +static const unsigned int adxrs290_hpf_3db_freq_tbl[][2] =3D {
> > +	[0] =3D {0, 0},
> > +	[1] =3D {0, 11},
> > +	[2] =3D {0, 22},
> > +	[3] =3D {0, 44},
> > +	[4] =3D {0, 87},
> > +	[5] =3D {0, 175},
> > +	[6] =3D {0, 350},
> > +	[7] =3D {0, 700},
> > +	[8] =3D {1, 400},
> > +	[9] =3D {2, 800},
> > +	[10] =3D {11, 300},
> > +};
> > +
> > +static int adxrs290_spi_read16b(struct iio_dev *indio_dev, const u8 cm=
d,
> > +				u16 *val)
> > +{
> > +	struct adxrs290_state *st =3D iio_priv(indio_dev);
> > +	int ret =3D 0;

No reason to init this.

> > +
> > +	struct spi_transfer t[] =3D {
> > +		{
> > +			.tx_buf =3D &st->data.tx,
> > +			.bits_per_word =3D 8,
> > +			.len =3D sizeof(st->data.tx),
> > +			.cs_change =3D 0,


How is this different from spi_w8r16?

If it is, then a comment to explain that would be great as it's not immedia=
tely
obvious!

> > +		}, {
> > +			.rx_buf =3D &st->data.rx,
> > +			.bits_per_word =3D 8,
> > +			.len =3D sizeof(st->data.rx),
> > +		},
> > +	};
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	st->data.tx =3D cmd;
> > +	ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> > +
> > +	if (ret < 0) {
> > +		dev_err(&st->spi->dev, "error reading 16b from reg 0x%02x\n",
> > +			cmd);
> > +		goto err_unlock;
> > +	}
> > +
> > +	*val =3D get_unaligned_le16(st->data.rx);
> > +
> > +err_unlock:
> > +	mutex_unlock(&st->lock);
> > +	return ret;
> > +}
> > +
> > +static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 =
cmd,
> > +				  unsigned int *val)
> > +{
> > +	int ret;
> > +	u16 temp;
> > +
> > +	ret =3D adxrs290_spi_read16b(indio_dev, cmd, &temp);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val =3D temp;
> > +
> > +	return 0;
> > +}
> > +
> > +static int adxrs290_get_temp_data(struct iio_dev *indio_dev, unsigned =
int *val)
> > +{
> > +	const u8 cmd =3D ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
> > +	int ret;
> > +	u16 temp;
> > +
> > +	ret =3D adxrs290_spi_read16b(indio_dev, cmd, &temp);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* extract lower 12 bits temperature reading */
> > +	*val =3D temp & 0x0FFF;
> > +
> > +	return 0;
> > +}
> > +
> > +static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u=
8 *val2)
> > +{
> > +	struct adxrs290_state *st =3D iio_priv(indio_dev);
> > +	const u8 cmd =3D ADXRS290_READ_REG(ADXRS290_REG_FILTER);
> > +	int temp;
> > +
> > +	temp =3D spi_w8r8(st->spi, cmd);
> > +	if (temp < 0)
> > +		return temp;
> > +
> > +	*val =3D FIELD_GET(ADXRS290_LPF_MASK, temp);
> > +	*val2 =3D FIELD_GET(ADXRS290_HPF_MASK, temp);
> > +
> > +	return 0;
> > +}
> > +
> > +static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
> > +				  const u8 val)
> > +{
> > +	u8 buf[2];
> > +
> > +	buf[0] =3D reg;
> > +	buf[1] =3D val;
> > +
> > +	return spi_write(spi, buf, ARRAY_SIZE(buf));

spi_write requires a dma safe buffer.  Such a buffer needs to be in its
own cacheline.  Given trivial nature of what you have here, easiest
may be to use spi_write_then_read with the read length set to 0.
That function uses local bounce buffers to ensure the dma requirements
are met.

> > +}
> > +
> > +static unsigned int adxrs290_find_best_match(const unsigned int (*freq=
_tbl)[2],
> > +					     unsigned int n, unsigned int freq)
> > +{
> > +	unsigned int i, best_freq_idx;
> > +	unsigned int diff, best_diff;
> > +
> > +	best_freq_idx =3D 0;
> > +	best_diff =3D UINT_MAX;
> > +	for (i =3D 0; i < n; i++) {
> > +		diff =3D abs(freq_tbl[i][0] - freq); =20
>=20
> To find the "closest" 3db frequency from the acceptable ones, for now, I=
=20
> simply consider the integer part of the frequency (freq_tbl[i][0]).=20
> Taking into account the sensitivity of acceptable 3db frequencies for=20
> the high-pass filter [1], I'm guessing this isn't an acceptable=20
> solution. Should I progressively compare the fractional part after the=20
> integer part or perhaps directly exercise a FP arithmetic? Any other=20
> suggestions? Thanks in advance.
>=20
> [1] Supported 3db frequencies of the high-pass filter:
> 0.000 0.011 0.022 0.044 0.087 0.175 0.350 0.700 1.400 2.800 11.300

Given the driver is exporting the 'precise' values in the available
attribute, I would suggest just doing a precise match against both parts.
Leave any rounding complexity to userspace.

>=20
> With regards,
> Nishant Malpani
>=20
> > +		if (diff < best_diff) {
> > +			best_diff =3D diff;
> > +			best_freq_idx =3D i;
> > +		}
> > +	}
> > +
> > +	return best_freq_idx;
> > +}
> > +
> > +static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
> > +				    unsigned int lpf_idx, unsigned int hpf_idx)
> > +{
> > +	struct adxrs290_state *st =3D iio_priv(indio_dev);
> > +	u8 val;
> > +
> > +	val =3D ADXRS290_HPF(hpf_idx) | ADXRS290_LPF(lpf_idx);
> > +
> > +	return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
> > +}
> > +
> > +static ssize_t adxrs290_show_avail(const unsigned int (*freq_tbl)[2], =
size_t n,
> > +				   char *buf)
> > +{
> > +	ssize_t len =3D 0;
> > +	int i;
> > +
> > +	for (i =3D 0; i < n; i++) {
> > +		len +=3D scnprintf(buf + len, PAGE_SIZE - len,
> > +				 "%u.%03u ", freq_tbl[i][0], freq_tbl[i][1]);
> > +	}
> > +	buf[len - 1] =3D '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t adxrs290_show_lpf_freq_avail(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    char *buf)
> > +{
> > +	return adxrs290_show_avail(adxrs290_lpf_3db_freq_tbl,
> > +				   ARRAY_SIZE(adxrs290_lpf_3db_freq_tbl), buf);
> > +}
> > +
> > +static ssize_t adxrs290_show_hpf_freq_avail(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    char *buf)
> > +{
> > +	return adxrs290_show_avail(adxrs290_hpf_3db_freq_tbl,
> > +				   ARRAY_SIZE(adxrs290_hpf_3db_freq_tbl), buf);
> > +}
> > +
> > +/* attribute to display available 3db frequencies for the low-pass fil=
ter */
> > +static IIO_DEVICE_ATTR(in_anglvel_filter_low_pass_3db_frequency_availa=
ble,
> > +		       0444, adxrs290_show_lpf_freq_avail, NULL, 0);
> > +
> > +/* attribute to display available 3db frequencies for the high-pass fi=
lter */
> > +static IIO_DEVICE_ATTR(in_anglvel_filter_high_pass_3db_frequency_avail=
able,
> > +		       0444, adxrs290_show_hpf_freq_avail, NULL, 0);
> > +
> > +static struct attribute *adxrs290_attributes[] =3D {
> > +	&iio_dev_attr_in_anglvel_filter_low_pass_3db_frequency_available.dev_=
attr.attr,
> > +	&iio_dev_attr_in_anglvel_filter_high_pass_3db_frequency_available.dev=
_attr.attr,
> > +	NULL,
> > +};

Perhaps change these over to the read_avail core callbacks. The tables
are almost in the right form already so it may end up less complex.

> > +
> > +static const struct attribute_group adxrs290_attrs_group =3D {
> > +	.attrs =3D adxrs290_attributes,
> > +};
> > +
> > +static int adxrs290_initial_setup(struct iio_dev *indio_dev)
> > +{
> > +	struct adxrs290_state *st =3D iio_priv(indio_dev);
> > +
> > +	st->mode =3D MEASUREMENT;
> > +
> > +	return adxrs290_spi_write_reg(st->spi,
> > +				      ADXRS290_REG_POWER_CTL,
> > +				      ADXRS290_MEASUREMENT | ADXRS290_TSM);
> > +}
> > +
> > +static int adxrs290_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val,
> > +			     int *val2,
> > +			     long mask)
> > +{
> > +	struct adxrs290_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +	unsigned int t;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_ANGL_VEL:
> > +			ret =3D adxrs290_get_rate_data(indio_dev,
> > +						     ADXRS290_READ_REG(chan->address),
> > +						     &t);
> > +			if (ret < 0)
> > +				return ret;
> > +			*val =3D t;
> > +			return IIO_VAL_INT;
> > +		case IIO_TEMP:
> > +			ret =3D adxrs290_get_temp_data(indio_dev, &t);
> > +			if (ret < 0)
> > +				return ret;
> > +			*val =3D t;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_ANGL_VEL:
> > +			*val =3D 0;
> > +			*val2 =3D 87266;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		case IIO_TEMP:
> > +			*val =3D 100;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		switch (chan->type) {
> > +		case IIO_ANGL_VEL:
> > +			t =3D st->lpf_3db_freq_idx;
> > +			*val =3D adxrs290_lpf_3db_freq_tbl[t][0];
> > +			*val2 =3D adxrs290_lpf_3db_freq_tbl[t][1] * 1000;

Given we are writing integers and it doesn't otherwise mater, I'd make
the table int and also just add the zeros to avoid the need to do *1000
here.  That will also let you use the core support for avail.


> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > +		switch (chan->type) {
> > +		case IIO_ANGL_VEL:
> > +			t =3D st->hpf_3db_freq_idx;
> > +			*val =3D adxrs290_hpf_3db_freq_tbl[t][0];
> > +			*val2 =3D adxrs290_hpf_3db_freq_tbl[t][1] * 1000;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int adxrs290_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val,
> > +			      int val2,
> > +			      long mask)
> > +{
> > +	struct adxrs290_state *st =3D iio_priv(indio_dev);
> > +	unsigned int lpf_idx, hpf_idx;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		lpf_idx =3D adxrs290_find_best_match(adxrs290_lpf_3db_freq_tbl,
> > +						   ARRAY_SIZE(adxrs290_lpf_3db_freq_tbl),
> > +						   val);
> > +		/* caching the updated state of the low-pass filter */
> > +		st->lpf_3db_freq_idx =3D lpf_idx;
> > +		/* retrieving the current state of the high-pass filter */
> > +		hpf_idx =3D st->hpf_3db_freq_idx;
> > +		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > +		hpf_idx =3D adxrs290_find_best_match(adxrs290_hpf_3db_freq_tbl,
> > +						   ARRAY_SIZE(adxrs290_hpf_3db_freq_tbl),
> > +						   val);
> > +		/* caching the updated state of the high-pass filter */
> > +		st->hpf_3db_freq_idx =3D hpf_idx;
> > +		/* retrieving the current state of the low-pass filter */
> > +		lpf_idx =3D st->lpf_3db_freq_idx;
> > +		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +#define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
> > +	.type =3D IIO_ANGL_VEL,						\
> > +	.address =3D reg,							\
> > +	.modified =3D 1,							\
> > +	.channel2 =3D IIO_MOD_##axis,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |		\
> > +	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
> > +	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),		\
> > +}
> > +
> > +static const struct iio_chan_spec adxrs290_channels[] =3D {
> > +	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAX0, X),
> > +	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAY0, Y),
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.address =3D ADXRS290_REG_TEMP0,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +		BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +};
> > +
> > +static const struct iio_info adxrs290_info =3D {
> > +	.attrs =3D &adxrs290_attrs_group,
> > +	.read_raw =3D &adxrs290_read_raw,
> > +	.write_raw =3D &adxrs290_write_raw,
> > +};
> > +
> > +static int adxrs290_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adxrs290_state *st;
> > +	int ret;
> > +	u8 val, val2;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->spi =3D spi;
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->dev.parent =3D &spi->dev;
> > +	indio_dev->name =3D "adxrs290";
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D adxrs290_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(adxrs290_channels);
> > +	indio_dev->info =3D &adxrs290_info;
> > +
> > +	val =3D spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
> > +	if (val !=3D ADXRS290_ADI_ID) {
> > +		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
> > +		return -ENODEV;
> > +	}
> > +
> > +	val =3D spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
> > +	if (val !=3D ADXRS290_MEMS_ID) {
> > +		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
> > +		return -ENODEV;
> > +	}
> > +
> > +	val =3D spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
> > +	if (val !=3D ADXRS290_DEV_ID) {
> > +		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* default mode the gyroscope starts in */
> > +	st->mode =3D STANDBY;
> > +
> > +	/* switch to measurement mode and switch on the temperature sensor */
> > +	ret =3D adxrs290_initial_setup(indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* max transition time to measurement mode */
> > +	msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
> > +
> > +	ret =3D adxrs290_get_3db_freq(indio_dev, &val, &val2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	st->lpf_3db_freq_idx =3D val;
> > +	st->hpf_3db_freq_idx =3D val2;
> > +
> > +	return devm_iio_device_register(&spi->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id adxrs290_of_match[] =3D {
> > +	{ .compatible =3D "adi,adxrs290" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, adxrs290_of_match);
> > +
> > +static struct spi_driver adxrs290_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "adxrs290",
> > +		.of_match_table =3D adxrs290_of_match,
> > +	},
> > +	.probe =3D adxrs290_probe,
> > +};
> > +module_spi_driver(adxrs290_driver);
> > +
> > +MODULE_AUTHOR("Nishant Malpani <nish.malpani25@gmail.com>");
> > +MODULE_DESCRIPTION("Analog Devices ADXRS290 Gyroscope SPI driver");
> > +MODULE_LICENSE("GPL");
> >  =20

