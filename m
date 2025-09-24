Return-Path: <linux-iio+bounces-24422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E9B9C43B
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 23:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9647B107F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38D2874E9;
	Wed, 24 Sep 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdez1HQ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D611185
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748942; cv=none; b=qwj2xByGqFW7x3LaiW7n0ZOnWrQkAU9MFSTwWitVAa9TcCBtT5OiED4aFWSExnEDWVzTGm1hMQ8JRZ0gGIqARajzWXnIofIe8tXQiSspz9MLWnLOyMq+B4+kHr3FyXCjhCKPUkFKGj9CdZ0p2b8OBOiWExeC9NwAfd7u6vgwwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748942; c=relaxed/simple;
	bh=snBJGZNmyUKAthQVP3kcSeopfnjQUciJQ+/l2jq6vXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRbdlmvmUH5TIZOOAb7fadzP8AaQute8KAuu1+UycZIdIaqAb+X7pQpxXha43tPzVB+LL8ua5QuqGIpcjHIdjanpWb8X/1SdblYI1fXl1jChIt7rZMAIjJD64RvYba2JQwoErXCoDKdpYkzRC/i0GxWeHZJZ8Owm0ZqDcoqS5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdez1HQ1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b267ca7c402so5340466b.0
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758748938; x=1759353738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8woU855OMVsj8Hl7/fNeszeDDlQhMuAL2SEdE0cya6Q=;
        b=jdez1HQ1yGmAeVoi2D5/MX4P8nkjhS/OMwYqZWxBoW7H9nHd8z6+Y415gtj31YOZda
         gE5fRqJXXpEM0PBu7FQDbLxYomfLXKbzpWoVpq4QgroLc18bu08wqoDJfmV0UDyKMnz+
         k3G0VpmU36mAsI78GMnCN4/PkV7YQpE8YEH42Mht0M4MqTOB7+blzFe9bsLKo1bZwFiE
         +hd7Ht3SrjFX8og5WqqPbZmOG87UX0ugw0vMTmD0ByTctDZ5gKAxVezn0whiQIAeBYej
         +hHcyWhhjO9tRom8tht22sXp7duR0JY8IqV8+SIkBcfHHmgSiLOixILfMtmXN5moVw2W
         0QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758748938; x=1759353738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8woU855OMVsj8Hl7/fNeszeDDlQhMuAL2SEdE0cya6Q=;
        b=AsDim63/tbaQPiuDIZYEyF9+aFcqSkWnJtlwlVpsmu0vfxOelvuyUfG9eyISjSh4Ld
         HiPDHNDDkXRvaU3etCBkeg1NyGtZrPo+nlFFvQqwePv/2txkdB9knBG7bO4fMnIPoOGQ
         XUH7vZC5lKKTqXX0WggYMA+yp255xMA0T/rNj7bGf86ZeX8Pz5FFxWPZKOGbMZkH7hZO
         IKXxQi53z9lZUWvf/mWz02ktYLsmEFWmOofG/fBIAaF/+VS2t8w7TeOO9mart/4vjdcd
         /T0F8EuLHXzxHxHXxiThIrCGTOk6YSuWXUTNoFI1RfpGXogscutlaC1oR4NtIgxmSmyl
         dQug==
X-Forwarded-Encrypted: i=1; AJvYcCVYsxZ0EClJlC0CFSTAsejemvugn3xxPFKb/DeyfiLPPmFeuXRZJwkA6akoTi/543ZTIATY6njLpYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUgQh9EleFqGyaLTBfca1ZOWHYXhroo3d+px276NpZ+Ixszd3
	+uF+rv+fTG60cKkjwgbwHFUUn4RPJfaX2iv4U71qnZBxk+3uryFZUcjO
X-Gm-Gg: ASbGncuR6wyiIqoXSyDeUXMX1RPup9s6NaDoy2n0OKJQ85zMaLjbqNe08wkCeJGMD4O
	Lb8qGm67oY3/1Gzq/azK5+Annsf0zq/d6RUYkUpHAGejNGOmgo5M2F8FL9kPQrvGNmMmpAztU1e
	c4HqmsQibZ90rK5KKEZFFO0ZHOrlftSJF7HP0TPYPRgzfrzWzAjm+Iv36We2lj+xOsE702ELC7z
	Y665kuAzdOEwAKvJ7Hut7v3jcl+rdIru2x+E3DpF3mlLpd02mJgiK9pdRre4BL+IjQ//MDK62Mo
	Go99+uqBozypIvMb0iZ9guL72LKyddWMWPe2e+Fs8In8g9sd/0HQrXFHNsfdFmG0DLlBEnxy1Sf
	b0c/YQACN9kak+V/v8Ej44UBWVmy3/ZgSuosn0ZOQ/Xczt3t39IHPj9K1HADmXLXY2+s=
X-Google-Smtp-Source: AGHT+IH1hiPkyWHf62ijBt5yw+X/RyOjzaSI05ePABstyRwN6/Jos3EsSTFhQmx13NYCMeCsWAtsaw==
X-Received: by 2002:a17:907:3f0e:b0:af9:6580:c34f with SMTP id a640c23a62f3a-b34bf66a9aemr61437166b.9.1758748937600;
        Wed, 24 Sep 2025 14:22:17 -0700 (PDT)
Received: from flu-Virtual-Machine (86-83-125-241.fixed.kpn.net. [86.83.125.241])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm19334166b.26.2025.09.24.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:22:17 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:22:15 +0200
From: Adrian Fluturel <fluturel.adrian@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aNRhBw2lKgsvEEDL@flu-Virtual-Machine>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
 <20250924-i3c_ddr-v2-4-682a0eb32572@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-i3c_ddr-v2-4-682a0eb32572@nxp.com>

On Wed, Sep 24, 2025 at 10:30:05AM -0400, Frank Li wrote:
> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.
> 
> Co-developed-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - new patch
> ---
>  drivers/iio/magnetometer/Kconfig   |  12 +
>  drivers/iio/magnetometer/Makefile  |   1 +
>  drivers/iio/magnetometer/mmc5633.c | 543 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 556 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -139,6 +139,18 @@ config MMC35240
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mmc35240.
>  
> +config MMC5633
> +	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
> +	select REGMAP_I2C
> +	select REGMAP_I3C
> +	depends on I2C || I3C
> +	help
> +	  Say yes here to build support for the MEMSIC MMC5633 3-axis
> +	  magnetic sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mmc5633
> +
>  config IIO_ST_MAGN_3AXIS
>  	tristate "STMicroelectronics magnetometers 3-Axis Driver"
>  	depends on (I2C || SPI_MASTER) && SYSFS
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
>  obj-$(CONFIG_MAG3110)	+= mag3110.o
>  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
>  obj-$(CONFIG_MMC35240)	+= mmc35240.o
> +obj-$(CONFIG_MMC5633)	+= mmc5633.o
>  
>  obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
>  st_magn-y := st_magn_core.o
> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b1a6973ea175634bbc2247ff84488ea5393eba0e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mmc5633.c
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MMC5633 - MEMSIC 3-axis Magnetic Sensor
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + * Copyright (c) 2025, NXP
> + *
> + * IIO driver for MMC5633, base on mmc35240.c
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/i3c/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +
> +#define MMC5633_REG_XOUT_L	0x00
> +#define MMC5633_REG_XOUT_H	0x01
> +#define MMC5633_REG_YOUT_L	0x02
> +#define MMC5633_REG_YOUT_H	0x03
> +#define MMC5633_REG_ZOUT_L	0x04
> +#define MMC5633_REG_ZOUT_H	0x05
> +#define MMC5633_REG_XOUT_2	0x06
> +#define MMC5633_REG_YOUT_2	0x07
> +#define MMC5633_REG_ZOUT_2	0x08
> +
> +#define MMC5633_REG_STATUS1	0x18
> +#define MMC5633_REG_STATUS0	0x19
> +#define MMC5633_REG_CTRL0	0x1b
> +#define MMC5633_REG_CTRL1	0x1c
> +#define MMC5633_REG_CTRL2	0x1d
> +
> +#define MMC5633_REG_ID		0x39
> +
> +#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
> +
> +#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
> +#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
> +#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
> +#define MMC5633_CTRL0_RESET		BIT(4)
> +#define MMC5633_CTRL0_SET		BIT(3)
> +#define MMC5633_CTRL0_MEAS_T		BIT(1)
> +#define MMC5633_CTRL0_MEAS_M		BIT(0)
> +
> +#define MMC5633_CTRL1_BW0_BIT		BIT(0)
> +#define MMC5633_CTRL1_BW1_BIT		BIT(1)
> +
> +#define MMC5633_CTRL1_BW_MASK		(MMC5633_CTRL1_BW0_BIT | \
> +					 MMC5633_CTRL1_BW1_BIT)
> +
> +#define MMC5633_WAIT_CHARGE_PUMP	50000	/* us */
> +#define MMC5633_WAIT_SET_RESET		1000	/* us */
> +
> +#define MMC5633_HDR_CTRL0_MEAS_M	0x01
> +#define MMC5633_HDR_CTRL0_MEAS_T	0x03
> +#define MMC5633_HDR_CTRL0_SET		0X05
> +#define MMC5633_HDR_CTRL0_RESET		0x07
> +
> +enum mmc5633_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +struct mmc5633_data {
> +	struct device *dev;
> +	struct i3c_device *i3cdev;
> +	struct mutex mutex; /* protect to finish one whole measurement */
> +	struct regmap *regmap;
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} mmc5633_samp_freq[] = { {1, 200000},
> +			  {2, 0},
> +			  {3, 500000},
> +			  {6, 600000},
> +			};
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.2 2.0 3.5 6.6");
> +
> +#define MMC5633_CHANNEL(_axis) { \
> +	.type = IIO_MAGN, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_ ## _axis, \
> +	.address = AXIS_ ## _axis, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				    BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +static const struct iio_chan_spec mmc5633_channels[] = {
> +	MMC5633_CHANNEL(X),
> +	MMC5633_CHANNEL(Y),
> +	MMC5633_CHANNEL(Z),
> +};
> +
> +static struct attribute *mmc5633_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group mmc5633_attribute_group = {
> +	.attrs = mmc5633_attributes,
> +};
> +
> +static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
> +				       int val, int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
> +		if (mmc5633_samp_freq[i].val == val &&
> +		    mmc5633_samp_freq[i].val2 == val2)
> +			return i;
> +	return -EINVAL;
> +}
> +
> +static int mmc5633_hw_set(struct mmc5633_data *data, bool set)
> +{
> +	u8 coil_bit;
> +
> +	if (set)
> +		coil_bit = MMC5633_CTRL0_SET;
> +	else
> +		coil_bit = MMC5633_CTRL0_RESET;
> +
> +	return regmap_write(data->regmap, MMC5633_REG_CTRL0, coil_bit);
> +}
> +
> +static int mmc5633_init(struct mmc5633_data *data)
> +{
> +	unsigned int reg_id, ret;
> +
> +	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret,
> +				     "Error reading product id\n");
> +
> +	/*
> +	 * make sure we restore sensor characteristics, by doing
> +	 * a SET/RESET sequence, the axis polarity being naturally
> +	 * aligned after RESET
> +	 */
> +	ret = mmc5633_hw_set(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(MMC5633_WAIT_SET_RESET, MMC5633_WAIT_SET_RESET + 1);
> +
> +	ret = mmc5633_hw_set(data, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set default sampling frequency */
> +	ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> +				 MMC5633_CTRL1_BW_MASK,
> +				 FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mmc5633_take_measurement(struct mmc5633_data *data)
> +{
> +	unsigned int reg_status;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_MEAS_M);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
> +				       reg_status & MMC5633_STATUS1_MEAS_M_DONE_BIT,
> +				       10000, 10000 * 100);
> +
> +	if (ret) {
> +		dev_err(data->dev, "data not ready\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mmc5633_read_measurement(struct mmc5633_data *data, void *buf, size_t sz)
> +{
> +	__le16 data_word;
> +	__le16 status;
> +	int ret, val;
> +
> +	if (data->i3cdev &&
> +	    (i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR))) {
> +		struct i3c_xfer xfers_wr_cmd[] = {
> +			{
> +				.cmd = 0x3b,
> +				.len = 2,
> +				.data.out = &data_word,
> +			}
> +		};
> +
> +		struct i3c_xfer xfers_rd_sta_cmd[] = {
> +			{
> +				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
> +				.len = 2,
> +				.data.in = &status,
> +			},
> +		};
> +
> +		struct i3c_xfer xfers_rd_data_cmd[] = {
> +			{
> +				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
> +				.len = sz,
> +				.data.in = buf,
> +			},
> +		};
> +
> +		data_word = cpu_to_le16(MMC5633_HDR_CTRL0_MEAS_M << 8);
> +
> +		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = read_poll_timeout(i3c_device_do_xfers, val,
> +					val ||
> +					(le16_to_cpu(status) & MMC5633_STATUS1_MEAS_M_DONE_BIT),
> +					10000, 10000 * 100, 0,
> +					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
> +
> +		if (ret || val) {
> +			dev_err(data->dev, "data not ready\n");
> +			return -EIO;
> +		}
> +
> +		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
> +	}
> +
> +	/* Fallback to use SDR/I2C mode */
> +	ret = mmc5633_take_measurement(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
> +}
> +
> +static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
> +{
> +	/*
> +	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
> +	 */
> +	*val = buf[2 * index];
> +	*val <<= 8;
> +
> +	*val |= buf[2 * index + 1];
> +	*val <<= 8;
> +
> +	*val |= buf[index + 6];
> +
> +	*val >>= 4;
> +
> +	return 0;
> +}
> +
> +#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
> +
> +static int mmc5633_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mmc5633_data *data = iio_priv(indio_dev);
> +	char buf[MMC5633_ALL_SIZE];
> +	unsigned int reg;
> +	int ret, i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = mmc5633_read_measurement(data, buf, MMC5633_ALL_SIZE);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		ret = mmc5633_get_raw(data, chan->address, buf, val);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 62500;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
> +		if (i < 0 || i >= ARRAY_SIZE(mmc5633_samp_freq))
> +			return -EINVAL;
> +
> +		*val = mmc5633_samp_freq[i].val;
> +		*val2 = mmc5633_samp_freq[i].val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mmc5633_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct mmc5633_data *data = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		i = mmc5633_get_samp_freq_index(data, val, val2);
> +		if (i < 0)
> +			return -EINVAL;
> +
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> +						 MMC5633_CTRL1_BW_MASK,
> +						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
> +			if (ret)
> +				return ret;
> +		};
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info mmc5633_info = {
> +	.read_raw	= mmc5633_read_raw,
> +	.write_raw	= mmc5633_write_raw,
> +	.attrs		= &mmc5633_attribute_group,
> +};
> +
> +static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MMC5633_REG_CTRL0:
> +	case MMC5633_REG_CTRL1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MMC5633_REG_XOUT_L:
> +	case MMC5633_REG_XOUT_H:
> +	case MMC5633_REG_YOUT_L:
> +	case MMC5633_REG_YOUT_H:
> +	case MMC5633_REG_ZOUT_L:
> +	case MMC5633_REG_ZOUT_H:
> +	case MMC5633_REG_XOUT_2:
> +	case MMC5633_REG_YOUT_2:
> +	case MMC5633_REG_ZOUT_2:
> +	case MMC5633_REG_STATUS1:
> +	case MMC5633_REG_ID:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MMC5633_REG_CTRL0:
> +	case MMC5633_REG_CTRL1:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct reg_default mmc5633_reg_defaults[] = {
> +	{ MMC5633_REG_CTRL0,  0x00 },
> +	{ MMC5633_REG_CTRL1,  0x00 },
> +};
> +
> +static const struct regmap_config mmc5633_regmap_config = {
> +	.name = "mmc5633_regmap",
> +
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = MMC5633_REG_ID,
> +	.cache_type = REGCACHE_FLAT,
> +
> +	.writeable_reg = mmc5633_is_writeable_reg,
> +	.readable_reg = mmc5633_is_readable_reg,
> +	.volatile_reg = mmc5633_is_volatile_reg,
> +
> +	.reg_defaults = mmc5633_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
> +};
> +
> +static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
> +				char *name, struct i3c_device *i3cdev)
> +{
> +	struct mmc5633_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->regmap = regmap;
> +	data->i3cdev = i3cdev;
> +	data->dev = dev;
> +
> +	ret = devm_mutex_init(dev, &data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &mmc5633_info;
> +	indio_dev->name = name;
> +	indio_dev->channels = mmc5633_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = mmc5633_init(data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int mmc5633_suspend(struct device *dev)
> +{
> +	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	regcache_cache_only(data->regmap, true);
> +
> +	return 0;
> +}
> +
> +static int mmc5633_resume(struct device *dev)
> +{
> +	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	regcache_mark_dirty(data->regmap);
> +	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
> +				   MMC5633_REG_CTRL1);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to restore control registers\n");
> +
> +	regcache_cache_only(data->regmap, false);
> +
> +	return 0;
> +}
> +
> +static int mmc5633_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
> +
> +	return mmc5633_common_probe(dev, regmap, client->name, NULL);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
> +				mmc5633_resume);
> +
> +static const struct of_device_id mmc5633_of_match[] = {
> +	{ .compatible = "memsic,mmc5633", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mmc5633_of_match);
> +
> +static const struct i2c_device_id mmc5633_i2c_id[] = {
> +	{ "mmc5633" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
> +
> +static struct i2c_driver mmc5633_i2c_driver = {
> +	.driver = {
> +		.name = "mmc5633_i2c",
> +		.of_match_table = mmc5633_of_match,
> +		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
> +	},
> +	.probe	  = mmc5633_i2c_probe,
> +	.id_table       = mmc5633_i2c_id,
> +};
> +
> +static const struct i3c_device_id mmc5633_i3c_ids[] = {
> +	I3C_DEVICE(0x0251, 0x0000, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
> +
> +static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +
> +	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
> +}
> +
> +static struct i3c_driver mmc5633_i3c_driver = {
> +	.driver = {
> +		.name = "mmc5633_i3c",
> +	},
> +	.probe = mmc5633_i3c_probe,
> +	.id_table = mmc5633_i3c_ids,
> +};
> +
> +module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
> +
> +MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
> +MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1
> 

Hello all,

I've been working on a driver for the MMC 5603NJ using I2C these last few days and it seems to be working. As it happens, I noticed your patch and looked over the datasheet and it seems they are very similar, but your sensor has some extra features. My driver also reads the temperature. I am not experienced enough to tell if they are compatible and if we could merge the drivers in some way. Is there a point to me sending my driver? What is the protocol for situations like these?

I would test your driver to see if it works on my sensor, but there are some features there that my board does not have, so in its current form, I don't think I can use it.

Thank you for your consideration,
- Adrian Fluturel

