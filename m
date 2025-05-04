Return-Path: <linux-iio+bounces-19068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC6AA88EC
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C813AAB7E
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064281DF250;
	Sun,  4 May 2025 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbvXtdHW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9611E0DB3;
	Sun,  4 May 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382884; cv=none; b=CM4p4PaJFIsC3DKhZ1WbkCfg/gTACfRsSWOQBSPxdzNDUOkJYSFuu/5gVhzWeul6snBj8HqVauOSwmKlUkmy2czFISv8W1o7mYHGseFkfoj4T0jrPEYAWJSAYddK5y4HtAsrcdSKWeXGn9bIzHb7+L2vh5W3tnhFyDoLJKFRY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382884; c=relaxed/simple;
	bh=KOAZiABp9+mI+kG5GYtWceCiGAqKMeRUcy+uyqIjQnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZiPqpZ6Q6yIU8CIktjb9GynLFGcxk0ozvf+7fOKqIjx1RDgd9EgudxpZT9uS/ir1wEnu81GAEHCh2b2Cq0Euoj6ION6qXCYJXy0R29QIzNpO1EcGt6fERkmIPv+vGdVbjh5aE4rAg3jdQiBPwyXI/6z8SJVwcnCrpMJBHLBIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbvXtdHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB52C4CEE7;
	Sun,  4 May 2025 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746382884;
	bh=KOAZiABp9+mI+kG5GYtWceCiGAqKMeRUcy+uyqIjQnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jbvXtdHW9n/PaDPOptlkAUJBTRvGxgwOxb/RovSUt8ulRRr19JbRBYBWeW505f014
	 Yp2XFqR6t3GOryTPmJSWI3fYw9Ta3+LnTbS+sC9qT0AwDvorpPOJOTm0XurGEP7eDh
	 aOHG8hcFbuoHNUUwDQuSt+zqY7VhTno/o66EcsTPNGHpwjqwk1ETZdKnXJ6PdMYWvo
	 ZwVCJLQKjs7oHgbRaSN0QkgL0iOpHyWsJqw+Jkl6F/RCxTdgiV2L6rSRLCfnB70o/v
	 t/+sMpg946zMuXYFh91067qMbB+yjQ1izA+3h2nVkyAzPSYOh6VjnadPdOG3BlydrJ
	 hOTyfisJTosLQ==
Date: Sun, 4 May 2025 19:21:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 2/7] iio: adc: Add basic support for AD4170
Message-ID: <20250504192117.5e19f44b@jic23-huawei>
In-Reply-To: <01ac3a81f9aa7f1fe48478ff60c0033dd02aefb1.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
	<01ac3a81f9aa7f1fe48478ff60c0033dd02aefb1.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 09:28:03 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> Add support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Digital filter and sampling frequency configuration.
> - Calibration gain and offset configuration.
> - Differential and pseudo-differential input configuration.
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Various comments inline, but as Andy mentioned, this is not exactly bite si=
zed
to review so the quality will suffer. I know I need to take a break from th=
e screen
after this one! :)  If you can break it up further that would be great.
Some smaller things like filter control are often relatively easy to separa=
te
off.

Jonathan


> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..4d0af15cb48d
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c
> @@ -0,0 +1,1888 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Analog Devices, Inc.
> + * Author: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
This might belong in a later patch. Not sure we have custom
attrs in this one.

> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>

> +/* AD4170 register constants */
> +
> +/* AD4170_CHAN_MAP_REG constants */
> +#define AD4170_CHAN_MAP_AIN0			0
> +#define AD4170_CHAN_MAP_AIN1			1
> +#define AD4170_CHAN_MAP_AIN2			2
> +#define AD4170_CHAN_MAP_AIN3			3
> +#define AD4170_CHAN_MAP_AIN4			4
> +#define AD4170_CHAN_MAP_AIN5			5
> +#define AD4170_CHAN_MAP_AIN6			6
> +#define AD4170_CHAN_MAP_AIN7			7
> +#define AD4170_CHAN_MAP_AIN8			8
Maybe a macro for these?
#define AD4170_CHAN_MAP_AIN(x) (x)

Perhaps it's not worth bothering. I didn't check!

> +#define AD4170_CHAN_MAP_TEMP_SENSOR		17
> +#define AD4170_CHAN_MAP_AVDD_AVSS_P		18
> +#define AD4170_CHAN_MAP_AVDD_AVSS_N		18
> +#define AD4170_CHAN_MAP_IOVDD_DGND_P		19
> +#define AD4170_CHAN_MAP_IOVDD_DGND_N		19
> +#define AD4170_CHAN_MAP_DAC_P			20
> +#define AD4170_CHAN_MAP_DAC_N			20
> +#define AD4170_CHAN_MAP_ALDO			21
> +#define AD4170_CHAN_MAP_DLDO			22
> +#define AD4170_CHAN_MAP_AVSS			23
> +#define AD4170_CHAN_MAP_DGND			24
> +#define AD4170_CHAN_MAP_REFIN1_P		25
> +#define AD4170_CHAN_MAP_REFIN1_N		26
> +#define AD4170_CHAN_MAP_REFIN2_P		27
> +#define AD4170_CHAN_MAP_REFIN2_N		28
> +#define AD4170_CHAN_MAP_REFOUT			29

> +/*
> + * There are 8 of each MISC, AFE, FILTER, FILTER_FS, OFFSET, and GAIN
> + * configuration registers. That is, there are 8 miscellaneous registers=
, MISC0
> + * to MISC7. Each MISC register is associated with a setup; MISCN is ass=
ociated
> + * with setup number N. The other 5 above mentioned types of registers h=
ave
> + * analogous structure. A setup is a set of those registers. For example,
> + * setup 1 comprises of MISC1, AFE1, FILTER1, FILTER_FS1, OFFSET1, and G=
AIN1
> + * registers. Also, there are 16 CHANNEL_SETUP registers (CHANNEL_SETUP0=
 to
> + * CHANNEL_SETUP15). Each channel setup is associated with one of the 8 =
possible
> + * setups. Thus, AD4170 can support up to 16 channels but, since there a=
re only
> + * 8 available setups, channels must share settings if more than 8 chann=
els are
> + * configured.
> + */
> +struct ad4170_setup {
> +	u16 misc;
> +	u16 afe;
> +	u16 filter;
> +	u16 filter_fs;
> +	u32 offset; /* For calibration purposes */
> +	u32 gain; /* For calibration purposes */
> +};
> +
> +struct ad4170_setup_info {
> +	struct ad4170_setup setup;
> +	unsigned int enabled_channels;
> +	unsigned int channels;
> +};
As mentioned below. We had some concerns about matching with memcpy on these
structures. Now I don't see holes today so in theory it is fine, but I think
we should still do an explicit matching function that checks field by field
just to avoid potential future issues.

>
> +struct ad4170_state {
> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +	int vrefs_uv[AD4170_MAX_SUP];
> +	struct mutex lock; /* Protect read-modify-write and multi write sequenc=
es */
> +	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
> +	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
> +	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
> +	u32 mclk_hz;
> +	int pins_fn[AD4170_NUM_ANALOG_PINS];
> +	u32 int_pin_sel;
> +	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> +	struct completion completion;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
> +	 */
> +	u8 tx_buf[AD4170_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[AD4170_SPI_MAX_XFER_LEN];
> +};
> +

> +static int ad4170_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg, unsigned int writeval,
> +				     unsigned int *readval)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret =3D -EINVAL;
> +
> +	if (readval)
> +		ret =3D regmap_read(st->regmap, reg, readval);
return regmap_read()
> +	else
> +		ret =3D regmap_write(st->regmap, reg, writeval);
> +
> +	return ret;
> +}

> +
> +static int ad4170_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct ad4170_state *st =3D context;
> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D st->tx_buf,
> +			.len =3D 2,
> +		},
> +		{
> +			.rx_buf =3D st->rx_buf,
> +		},
> +	};
> +	unsigned int size;
> +	int ret;
> +
> +	ret =3D ad4170_get_reg_size(st, reg, &size);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_be16(AD4170_REG_READ_MASK | reg, st->tx_buf);
> +	t[1].len =3D size;
> +
> +	ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret)
> +		return ret;
> +
> +	switch (size) {
> +	case 3:
> +		*val =3D get_unaligned_be24(st->rx_buf);
> +		break;
> +	case 2:
> +		*val =3D get_unaligned_be16(st->rx_buf);
> +		break;
> +	case 1:
> +		*val =3D st->rx_buf[0];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Might as well return in all the good paths instead of break.

> +}

> +
> +static int ad4170_find_setup(struct ad4170_state *st,
> +			     struct ad4170_setup *target_setup,
> +			     unsigned int *setup_num, bool *overwrite)
> +{
> +	unsigned int i;
> +
> +	*setup_num =3D AD4170_INVALID_SETUP;
> +	*overwrite =3D false;
> +
> +	for (i =3D 0; i < AD4170_MAX_SETUPS; i++) {
> +		struct ad4170_setup_info *setup_info =3D &st->setup_infos[i];
> +
> +		/* Immediately accept a matching setup. */
> +		if (!memcmp(target_setup, &setup_info->setup,
> +			    sizeof(*target_setup))) {

Didn't we run into concerns with holes, variable structure definitions etc
for these in other drivers and change them all to explicit field matches?

> +			*setup_num =3D i;
> +			return 0;
> +		}
> +
> +		/* Ignore all setups which are used by enabled channels. */
> +		if (setup_info->enabled_channels)
> +			continue;
> +
> +		/* Find the least used slot. */
> +		if (*setup_num =3D=3D AD4170_INVALID_SETUP ||
> +		    setup_info->channels < st->setup_infos[*setup_num].channels)
> +			*setup_num =3D i;
> +	}
> +
> +	if (*setup_num =3D=3D AD4170_INVALID_SETUP)
> +		return -EINVAL;
> +
> +	*overwrite =3D true;
> +	return 0;
> +}

> +
> +static int ad4170_set_filter_type(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int val)
> +{

> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->lock);
> +	/*
> +	 * The filters provide the same ODR for a given filter_fs value but
> +	 * there are different minimum and maximum filter_fs limits for each
> +	 * filter. The filter_fs value will be adjusted if the current filter_fs
> +	 * is out of the limits of the just requested filter. Since the
> +	 * filter_fs value affects the ODR (sampling_frequency), changing the
> +	 * filter may lead to a change in the sampling frequency.
> +	 */
> +	old_filter =3D setup->filter;
> +	old_filter_fs =3D setup->filter_fs;
> +	if (val =3D=3D AD4170_SINC5_AVG || val =3D=3D AD4170_SINC3) {
> +		if (setup->filter_fs < AD4170_SINC3_MIN_FS)
> +			setup->filter_fs =3D AD4170_SINC3_MIN_FS;
> +		if (setup->filter_fs > AD4170_SINC3_MAX_FS)
> +			setup->filter_fs =3D AD4170_SINC3_MAX_FS;
> +
> +	} else if (val =3D=3D AD4170_SINC5) {
> +		if (setup->filter_fs < AD4170_SINC5_MIN_FS)
> +			setup->filter_fs =3D AD4170_SINC5_MIN_FS;
> +		if (setup->filter_fs > AD4170_SINC5_MAX_FS)
> +			setup->filter_fs =3D AD4170_SINC5_MAX_FS;
Smells like a clamp()?
> +	}


> +static int __ad4170_read_sample(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int settling_time_ms, ret;
> +
> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_SINGLE);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * When a channel is manually selected by the user, the ADC needs an
> +	 * extra time to provide the first stable conversion. The ADC settling
> +	 * time depends on the filter type, filter frequency, and ADC clock
> +	 * frequency (see datasheet page 53). The maximum settling time among
> +	 * all filter configurations is 6291164 / fCLK. Use that formula to wait
> +	 * for sufficient time whatever the filter configuration may be.
> +	 */
> +	settling_time_ms =3D DIV_ROUND_UP(6291164 * MILLI, st->mclk_hz);
> +	reinit_completion(&st->completion);

No chance this triggers before we get here? I'd normally expect the reinit_=
completion
before the thing that might trigger it to be complete which I'd guess is the
ad4170_set_mode() call?

> +	ret =3D wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(settling_time_ms));
> +	if (!ret)
> +		dev_dbg(&st->spi->dev,
> +			"No Data Ready signal. Reading after delay.\n");
> +
> +	ret =3D regmap_read(st->regmap, AD4170_DATA_24B_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->scan_type.sign =3D=3D 's')
> +		*val =3D sign_extend32(*val, chan->scan_type.realbits - 1);
> +
> +	return 0;
> +}
> +
> +static int ad4170_read_sample(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	/*
> +	 * The ADC sequences through all enabled channels. That can lead to
> +	 * incorrect channel being sampled if a previous read would have left a
> +	 * different channel enabled. Thus, always enable and disable the
> +	 * channel on single-shot read.
> +	 */
> +	ret =3D ad4170_set_channel_enable(st, chan->address, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __ad4170_read_sample(indio_dev, chan, val);
> +	if (ret)
> +		dev_err(&st->spi->dev, "failed to read sample: %d\n", ret);

I guess we print it which is better than nothing, but we also eat
the return code if the channel disable succeeds which is not good.
You will need to use multiple ret/ret2 here or duplicate the
set_channel_enable() code in an error path and main path.

> +
> +	ret =3D ad4170_set_channel_enable(st, chan->address, false);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4170_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	enum ad4170_filter_type f_type;
> +	unsigned int pga, fs_idx;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D ad4170_read_sample(indio_dev, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> +		*val =3D chan_info->scale_tbl[pga][0];
> +		*val2 =3D chan_info->scale_tbl[pga][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> +		*val =3D chan_info->offset_tbl[pga];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		f_type =3D __ad4170_get_filter_type(setup->filter);
> +		switch (f_type) {
> +		case AD4170_SINC5_AVG:
> +		case AD4170_SINC3:
> +			fs_idx =3D find_closest(setup->filter_fs,
> +					      ad4170_sinc3_filt_fs_tbl,
> +					      ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl));
> +			*val =3D st->sps_tbl[f_type][fs_idx][0];
> +			*val2 =3D st->sps_tbl[f_type][fs_idx][1];
> +			break;
> +		case AD4170_SINC5:
> +			fs_idx =3D find_closest(setup->filter_fs,
> +					      ad4170_sinc5_filt_fs_tbl,
> +					      ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl));
> +			*val =3D st->sps_tbl[f_type][fs_idx][0];
> +			*val2 =3D st->sps_tbl[f_type][fs_idx][1];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
I'd return earlier where the breaks are to give a tiny bit simpler flow.

> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val =3D setup->offset;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val =3D setup->gain;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4170_fill_scale_tbl(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	int bipolar =3D chan->scan_type.sign =3D=3D 's' ? 1 : 0;
> +	int precision_bits =3D chan->scan_type.realbits;
> +	int pga, ainm_voltage, ret;
> +	unsigned long long offset;
> +
> +	ainm_voltage =3D 0;
> +	ret =3D ad4170_get_ain_voltage_uv(st, chan->channel2, &ainm_voltage);
> +	if (ret < 0)
> +		return dev_err_probe(&st->spi->dev, ret,
> +				     "Failed to fill scale table\n");
> +
> +	for (pga =3D 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
> +		u64 nv;
> +		unsigned int lshift, rshift;
> +
> +		/*
> +		 * The scale factor to get ADC output codes to values in mV
> +		 * units is given by:
> +		 * _scale =3D (input_range / gain) / 2^precision
> +		 * AD4170 gain is a power of 2 so the above can be written as
> +		 * _scale =3D input_range / 2^(precision + gain)
> +		 * Keep the input range in =C2=B5V to avoid truncating the less
> +		 * significan bits when right shifting it so to preserve scale
> +		 * precision.
> +		 */
> +		nv =3D (u64)chan_info->input_range_uv * NANO;
> +		lshift =3D (pga >> 3 & 1);  /* handle cases 8 and 9 */

I'm lost.  Where did 8 and 9 come from?

> +		rshift =3D precision_bits - bipolar + (pga & 0x7) - lshift;
> +		chan_info->scale_tbl[pga][0] =3D 0;
> +		chan_info->scale_tbl[pga][1] =3D div_u64(nv >> rshift, MILLI);
> +
> +		/*
> +		 * If the negative input is not at GND, the conversion result
> +		 * (which is relative to IN-) will be offset by the level at IN-.
> +		 * Use the scale factor the other way around to go from a known
> +		 * voltage to the corresponding ADC output code.
> +		 * With that, we are able to get to what would be the output
> +		 * code for the voltage at the negative input.
> +		 * If the negative input is not fixed, there is no offset.
> +		 */
> +		offset =3D ((unsigned long long)abs(ainm_voltage)) * MICRO;
> +		offset =3D DIV_ROUND_CLOSEST_ULL(offset, chan_info->scale_tbl[pga][1]);
> +
> +		/*
> +		 * After divided by the scale, offset will always fit into 31
> +		 * bits. For _raw + _offset to be relative to GND, the value
> +		 * provided as _offset is of opposite sign than the real offset.
> +		 */
> +		if (ainm_voltage > 0)
> +			chan_info->offset_tbl[pga] =3D -(int)(offset);
> +		else
> +			chan_info->offset_tbl[pga] =3D (int)(offset);
> +	}
> +	return 0;
> +}
> +
> +static int ad4170_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	enum ad4170_filter_type f_type;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (int *)chan_info->scale_tbl;
> +		*length =3D ARRAY_SIZE(chan_info->scale_tbl) * 2;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		f_type =3D ad4170_get_filter_type(indio_dev, chan);
> +		switch (f_type) {
> +		case AD4170_SINC5_AVG:
> +			fallthrough;
If there is nothing in it, IIRC you can just skip the fallthrough.
		case AD4170_SINC5_AVG:
		case AD4170_SINC3:
			*vals =3D ...


> +		case AD4170_SINC3:
> +			*vals =3D (int *)st->sps_tbl[f_type];
> +			*length =3D ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
> +			break;
> +		case AD4170_SINC5:
> +			*vals =3D (int *)st->sps_tbl[f_type];
> +			*length =3D ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*type =3D IIO_VAL_INT_PLUS_MICRO;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4170_set_pga(struct ad4170_state *st,
> +			  struct iio_chan_spec const *chan, int val, int val2)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	unsigned int old_pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> +	unsigned int pga;
> +	int ret;
> +
> +	for (pga =3D 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
> +		if (val =3D=3D chan_info->scale_tbl[pga][0] &&
> +		    val2 =3D=3D chan_info->scale_tbl[pga][1])
> +			break;
> +	}
> +
> +	if (pga =3D=3D AD4170_NUM_PGA_OPTIONS)
> +		return -EINVAL;
> +
> +	if (pga =3D=3D old_pga)
> +		return 0;
> +
> +	guard(mutex)(&st->lock);
> +	setup->afe &=3D ~AD4170_AFE_PGA_GAIN_MSK;
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
> +
> +	ret =3D ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret) {
> +		setup->afe &=3D ~AD4170_AFE_PGA_GAIN_MSK;
> +		setup->afe |=3D FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, old_pga);
I'd
		return ret;
> +	}
> +
> +	return ret;
	return 0;

So the error path is nicely separated.

> +}




> +static int ad4170_parse_firmware(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	int reg_data, ret, i;
> +
> +	st->mclk_hz =3D AD4170_INT_CLOCK_16MHZ;
> +
> +	for (i =3D 0; i < AD4170_NUM_ANALOG_PINS; i++)
> +		st->pins_fn[i] =3D AD4170_PIN_UNASIGNED;
> +
> +	/* On power on, device defaults to using SDO pin for data ready signal =
*/
> +	st->int_pin_sel =3D AD4170_INT_PIN_SDO;
> +	ret =3D device_property_match_property_string(dev, "interrupt-names",
> +						    ad4170_int_pin_names,
> +						    ARRAY_SIZE(ad4170_int_pin_names));

Hmm. This is unusual handling.  Normally we just try to get the first inter=
rupt by
name and if that fails move on to the second one.  What you have here seems=
 valid
just not a choice I recall seeing before.

> +	if (ret >=3D 0)
> +		st->int_pin_sel =3D ret;
> +
> +	reg_data =3D FIELD_PREP(AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK,
> +			      st->int_pin_sel =3D=3D AD4170_INT_PIN_DIG_AUX1 ?
> +			      AD4170_PIN_MUXING_DIG_AUX1_RDY :
> +			      AD4170_PIN_MUXING_DIG_AUX1_DISABLED);
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4170_PIN_MUXING_REG,
> +				 AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK, reg_data);
> +	if (ret)
> +		return ret;
> +
> +	return ad4170_parse_channels(indio_dev);
> +}

