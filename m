Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25928178499
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 22:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgCCVI3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 16:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbgCCVI3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 16:08:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE67520848;
        Tue,  3 Mar 2020 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583269708;
        bh=fuN7grPMuleGmr122EUSrvBt6tDPqCzQDdu1KPbDyTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zs8+5NjckpKYaD8jH3s3WCLMvMFQuurYtzQdOlckIXx6RL4GlKF+YoPPsggXNJFVT
         trD7aTiT1eBR6Cr3M0mey0Z6bG+fIs2K+26iPlrKgjA3UmZ/yECE5f89c8wwLMVsOI
         poSNfJUzOw/Hd70mR/Fk3ab3suSmAZnSaXIOYkGQ=
Date:   Tue, 3 Mar 2020 21:08:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 4/5] iio: imu: Add support for adis16475
Message-ID: <20200303210814.1057fbbb@archlinux>
In-Reply-To: <20200225124152.270914-5-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-5-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 13:41:51 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Support ADIS16475 and similar IMU devices. These devices are
> a precision, miniature MEMS inertial measurement unit (IMU) that
> includes a triaxial gyroscope and a triaxial accelerometer. Each
> inertial sensor combines with signal conditioning that optimizes
> dynamic performance.
>=20
> The driver adds support for the following devices:
>  * adis16470, adis16475, adis16477, adis16465, adis16467, adis16500,
>    adis16505, adis16507.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

A few bits and pieces inline.

Thanks,

Jonathan


> ---
>  .../ABI/testing/sysfs-bus-iio-imu-adis16475   |    7 +
>  MAINTAINERS                                   |    8 +
>  drivers/iio/imu/Kconfig                       |   13 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/adis16475.c                   | 1304 +++++++++++++++++
>  5 files changed, 1333 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
>  create mode 100644 drivers/iio/imu/adis16475.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475 b/Docu=
mentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> new file mode 100644
> index 000000000000..e2c3776035ea
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/burst_mode_enable
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Use the device burst read mode when reading buffered
> +		data. This mode provides a way to read a batch of
> +		output data registers, using a continuous stream of bits.

See comment on this below.  I'm not keen on this being exposed to userspace
because it will rarely have any idea how to set it.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fa40c3eb72a..f11262f1f3bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1008,6 +1008,14 @@ W:	http://ez.analog.com/community/linux-device-dri=
vers
>  F:	drivers/iio/imu/adis16460.c
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> =20
> +ANALOG DEVICES INC ADIS16475 DRIVER
> +M:	Nuno Sa <nuno.sa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/imu/adis16475.c
> +F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> +
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Beniamin Bia <beniamin.bia@analog.com>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 60bb1029e759..fc4123d518bc 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -29,6 +29,19 @@ config ADIS16460
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called adis16460.
> =20
> +config ADIS16475
> +	tristate "Analog Devices ADIS16475 and similar IMU driver"
> +	depends on SPI
> +	select IIO_ADIS_LIB
> +	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices ADIS16470, ADIS16475,
> +	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505, ADIS16507 iner=
tial
> +	  sensors.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called adis16475.
> +
>  config ADIS16480
>  	tristate "Analog Devices ADIS16480 and similar IMU driver"
>  	depends on SPI
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 5237fd4bc384..88b2c4555230 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ADIS16400) +=3D adis16400.o
>  obj-$(CONFIG_ADIS16460) +=3D adis16460.o
> +obj-$(CONFIG_ADIS16475) +=3D adis16475.o
>  obj-$(CONFIG_ADIS16480) +=3D adis16480.o
> =20
>  adis_lib-y +=3D adis.o
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> new file mode 100644
> index 000000000000..f7c637734ec8
> --- /dev/null
> +++ b/drivers/iio/imu/adis16475.c
> @@ -0,0 +1,1304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADIS16475 IMU driver
> + *
> + * Copyright 2019 Analog Devices Inc.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/imu/adis.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#define ADIS16475_REG_DIAG_STAT		0x02
> +#define ADIS16475_REG_X_GYRO_L		0x04
> +#define ADIS16475_REG_Y_GYRO_L		0x08
> +#define ADIS16475_REG_Z_GYRO_L		0x0C
> +#define ADIS16475_REG_X_ACCEL_L		0x10
> +#define ADIS16475_REG_Y_ACCEL_L		0x14
> +#define ADIS16475_REG_Z_ACCEL_L		0x18
> +#define ADIS16475_REG_TEMP_OUT		0x1c
> +#define ADIS16475_REG_X_GYRO_BIAS_L	0x40
> +#define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
> +#define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
> +#define ADIS16475_REG_X_ACCEL_BIAS_L	0x4c
> +#define ADIS16475_REG_Y_ACCEL_BIAS_L	0x50
> +#define ADIS16475_REG_Z_ACCEL_BIAS_L	0x54
> +#define ADIS16475_REG_FILT_CTRL		0x5c
> +#define ADIS16475_FILT_CTRL_MASK	GENMASK(2, 0)
> +#define ADIS16475_FILT_CTRL(x)		FIELD_PREP(ADIS16475_FILT_CTRL_MASK, x)
> +#define ADIS16475_REG_MSG_CTRL		0x60
> +#define ADIS16475_MSG_CTRL_DR_POL_MASK	BIT(0)
> +#define ADIS16475_MSG_CTRL_DR_POL(x) \
> +				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MASK, x)
> +#define ADIS16475_EXT_CLK_MASK		GENMASK(4, 2)
> +#define ADIS16475_EXT_CLK(x)		FIELD_PREP(ADIS16475_EXT_CLK_MASK, x)
> +#define ADIS16475_REG_UP_SCALE		0x62
> +#define ADIS16475_REG_DEC_RATE		0x64
> +#define ADIS16475_REG_GLOB_CMD		0x68
> +#define ADIS16475_REG_FIRM_REV		0x6c
> +#define ADIS16475_REG_FIRM_DM		0x6e
> +#define ADIS16475_REG_FIRM_Y		0x70
> +#define ADIS16475_REG_PROD_ID		0x72
> +#define ADIS16475_REG_SERIAL_NUM	0x74
> +#define ADIS16475_REG_FLASH_CNT		0x7c
> +#define ADIS16500_BURST32_MASK		BIT(9)
> +#define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
> +/* number of data elements in burst mode */
> +#define ADIS16475_BURST_MAX_DATA	10
> +#define ADIS16475_MAX_SCAN_DATA		15
> +
> +enum clk_mode {
> +	ADIS16475_CLK_DIRECT =3D 1,
> +	ADIS16475_CLK_SCALED,
> +	ADIS16475_CLK_OUTPUT,
> +	ADIS16475_CLK_PULSE =3D 5,
> +};
> +
> +struct adis16475_clks {
> +	const char *name;
> +	enum clk_mode clk_mode;
> +	u16 min_rate;
> +	u16 max_rate;
> +};
> +
> +struct adis16475_chip_info {
> +	const struct iio_chan_spec *channels;
> +	const struct adis16475_clks *clks;
> +	const struct adis_data adis_data;
> +	u32 num_channels;
> +	u32 gyro_max_val;
> +	u32 gyro_max_scale;
> +	u32 accel_max_val;
> +	u32 accel_max_scale;
> +	u32 temp_scale;
> +	u32 int_clk;
> +	u16 max_dec;
> +	u8 num_clks;
> +	bool has_burst32;
> +};
> +
> +struct adis16475 {
> +	const struct adis16475_chip_info *info;
> +	struct adis adis;
> +	u32 clk_freq;
> +	u32 cached_spi_speed_hz;
> +	bool burst32;
> +};
> +
> +enum {
> +	ADIS16475_SCAN_GYRO_X,
> +	ADIS16475_SCAN_GYRO_Y,
> +	ADIS16475_SCAN_GYRO_Z,
> +	ADIS16475_SCAN_ACCEL_X,
> +	ADIS16475_SCAN_ACCEL_Y,
> +	ADIS16475_SCAN_ACCEL_Z,
> +	ADIS16475_SCAN_TEMP,
> +	ADIS16475_SCAN_DIAG_S_FLAGS,
> +	ADIS16475_SCAN_CRC_FAILURE,
> +};
> +
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t adis16475_show_firmware_revision(struct file *file,
> +						char __user *userbuf,
> +						size_t count, loff_t *ppos)
> +{
> +	struct adis16475 *st =3D file->private_data;
> +	char buf[7];
> +	size_t len;
> +	u16 rev;
> +	int ret;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_REV, &rev);
> +	if (ret)
> +		return ret;
> +
> +	len =3D scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +}
> +
> +static const struct file_operations adis16475_firmware_revision_fops =3D=
 {
> +	.open =3D simple_open,
> +	.read =3D adis16475_show_firmware_revision,
> +	.llseek =3D default_llseek,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static ssize_t adis16475_show_firmware_date(struct file *file,
> +					    char __user *userbuf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct adis16475 *st =3D file->private_data;
> +	u16 md, year;
> +	char buf[12];
> +	size_t len;
> +	int ret;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_Y, &year);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_DM, &md);
> +	if (ret)
> +		return ret;
> +
> +	len =3D snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", md >> 8, md & 0x=
ff,
> +		       year);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +}
> +
> +static const struct file_operations adis16475_firmware_date_fops =3D {
> +	.open =3D simple_open,
> +	.read =3D adis16475_show_firmware_date,
> +	.llseek =3D default_llseek,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int adis16475_show_serial_number(void *arg, u64 *val)
> +{
> +	struct adis16475 *st =3D arg;
> +	u16 serial;
> +	int ret;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_SERIAL_NUM, &serial);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D serial;
> +
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_serial_number_fops,
> +			adis16475_show_serial_number, NULL, "0x%.4llx\n");
> +
> +static int adis16475_show_product_id(void *arg, u64 *val)
> +{
> +	struct adis16475 *st =3D arg;
> +	u16 prod_id;
> +	int ret;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_PROD_ID, &prod_id);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D prod_id;
> +
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_product_id_fops,
> +			adis16475_show_product_id, NULL, "%llu\n");
> +
> +static int adis16475_show_flash_count(void *arg, u64 *val)
> +{
> +	struct adis16475 *st =3D arg;
> +	u32 flash_count;
> +	int ret;
> +
> +	ret =3D adis_read_reg_32(&st->adis, ADIS16475_REG_FLASH_CNT,
> +			       &flash_count);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D flash_count;
> +
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_flash_count_fops,
> +			adis16475_show_flash_count, NULL, "%lld\n");
> +
> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct adis16475 *st =3D iio_priv(indio_dev);
> +
> +	debugfs_create_file("serial_number", 0400, indio_dev->debugfs_dentry,
> +			    st, &adis16475_serial_number_fops);
> +	debugfs_create_file("product_id", 0400, indio_dev->debugfs_dentry, st,
> +			    &adis16475_product_id_fops);
> +	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry, st,
> +			    &adis16475_flash_count_fops);
> +	debugfs_create_file("firmware_revision", 0400,
> +			    indio_dev->debugfs_dentry, st,
> +			    &adis16475_firmware_revision_fops);
> +	debugfs_create_file("firmware_date", 0400, indio_dev->debugfs_dentry,
> +			    st, &adis16475_firmware_date_fops);
> +	return 0;
> +}
> +#else
> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static ssize_t adis16475_burst_mode_enable_get(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct adis16475 *st =3D iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", st->adis.burst->en);
> +}
> +
> +static ssize_t adis16475_burst_mode_enable_set(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t len)
> +{
> +	struct adis16475 *st =3D iio_priv(dev_to_iio_dev(dev));
> +	bool val;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val)
> +		/* 1MHz max in burst mode */
> +		st->adis.spi->max_speed_hz =3D 1000000;
> +	else
> +		st->adis.spi->max_speed_hz =3D st->cached_spi_speed_hz;
> +
> +	st->adis.burst->en =3D val;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(burst_mode_enable, 0644,
> +		       adis16475_burst_mode_enable_get,
> +		       adis16475_burst_mode_enable_set, 0);
> +
> +static struct attribute *adis16475_attributes[] =3D {
> +	&iio_dev_attr_burst_mode_enable.dev_attr.attr,

Hmm.  Normally we try to avoid exposing this and make the decision
automatically based on which channels are enabled.

If more cynical we decide that no one buys and expensive sensor only
to read a few of it's channels, so we turn on burst mode all the time :)

> +	NULL,
> +};
> +
> +static const struct attribute_group adis16495_attribute_group =3D {
> +	.attrs =3D adis16475_attributes,
> +};
> +
> +static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
> +{
> +	int ret;
> +	u16 dec;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, &dec);
> +	if (ret)
> +		return -EINVAL;
> +
> +	*freq =3D DIV_ROUND_CLOSEST(st->clk_freq, dec + 1);
> +
> +	return 0;
> +}
> +
> +static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
> +{
> +	u16 dec;
> +
> +	if (freq =3D=3D 0 || freq > st->clk_freq)
> +		return -EINVAL;
> +
> +	dec =3D DIV_ROUND_CLOSEST(st->clk_freq, freq);
> +
> +	if (dec)
> +		dec--;
> +
> +	if (dec > st->info->max_dec)
> +		dec =3D st->info->max_dec;
> +
> +	return adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
> +}
> +
> +/* The values are approximated. */
> +static const u32 adis16475_3db_freqs[] =3D {
> +	[0] =3D 720, /* Filter disabled, full BW (~720Hz) */
> +	[1] =3D 360,
> +	[2] =3D 164,
> +	[3] =3D 80,
> +	[4] =3D 40,
> +	[5] =3D 20,
> +	[6] =3D 10,
> +	[7] =3D 10, /* not a valid setting */
> +};
> +
> +static int adis16475_get_filter(struct adis16475 *st, u32 *filter)
> +{
> +	u16 filter_sz;
> +	int ret;
> +	const int mask =3D ADIS16475_FILT_CTRL_MASK;
> +
> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FILT_CTRL, &filter_sz=
);
> +	if (ret)
> +		return ret;
> +
> +	*filter =3D adis16475_3db_freqs[filter_sz & mask];
> +
> +	return 0;
> +}
> +
> +static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
> +{
> +	int i;
> +
> +	for (i =3D ARRAY_SIZE(adis16475_3db_freqs) - 1; i >=3D 1; i--) {
> +		if (adis16475_3db_freqs[i] >=3D filter)
> +			break;
> +	}
> +
> +	return adis_write_reg_16(&st->adis, ADIS16475_REG_FILT_CTRL,
> +				 ADIS16475_FILT_CTRL(i));
> +}
> +
> +static const u32 adis16475_calib_regs[] =3D {
> +	[ADIS16475_SCAN_GYRO_X] =3D ADIS16475_REG_X_GYRO_BIAS_L,
> +	[ADIS16475_SCAN_GYRO_Y] =3D ADIS16475_REG_Y_GYRO_BIAS_L,
> +	[ADIS16475_SCAN_GYRO_Z] =3D ADIS16475_REG_Z_GYRO_BIAS_L,
> +	[ADIS16475_SCAN_ACCEL_X] =3D ADIS16475_REG_X_ACCEL_BIAS_L,
> +	[ADIS16475_SCAN_ACCEL_Y] =3D ADIS16475_REG_Y_ACCEL_BIAS_L,
> +	[ADIS16475_SCAN_ACCEL_Z] =3D ADIS16475_REG_Z_ACCEL_BIAS_L,
> +};
> +
> +static int adis16475_read_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      int *val, int *val2, long info)
> +{
> +	struct adis16475 *st =3D iio_priv(indio_dev);
> +	int ret;
> +	u32 tmp;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan, 0, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val =3D st->info->gyro_max_val;
> +			*val2 =3D st->info->gyro_max_scale;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_ACCEL:
> +			*val =3D st->info->accel_max_val;
> +			*val2 =3D st->info->accel_max_scale;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			*val =3D st->info->temp_scale;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret =3D adis_read_reg_32(&st->adis,
> +				       adis16475_calib_regs[chan->scan_index],
> +				       val);
> +		break;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret =3D adis16475_get_filter(st, val);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D adis16475_get_freq(st, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D tmp / 1000;
> +		*val2 =3D (tmp % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;

Better to put this inline after each ret =3D section and return directly fr=
om those.
As it stands the code paths are rather inconsistent.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int adis16475_write_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int val, int val2, long info)
> +{
> +	struct adis16475 *st =3D iio_priv(indio_dev);
> +	u32 tmp;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		tmp =3D val * 1000 + val2 / 1000;
> +		return adis16475_set_freq(st, tmp);
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return adis16475_set_filter(st, val);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return adis_write_reg_32(&st->adis,
> +					 adis16475_calib_regs[chan->scan_index],
> +					 val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define ADIS16475_MOD_CHAN(_type, _mod, _address, _si, _r_bits, _s_bits)=
 \
> +	{ \
> +		.type =3D (_type), \
> +		.modified =3D 1, \
> +		.channel2 =3D (_mod), \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +		.address =3D (_address), \
> +		.scan_index =3D (_si), \
> +		.scan_type =3D { \
> +			.sign =3D 's', \
> +			.realbits =3D (_r_bits), \
> +			.storagebits =3D (_s_bits), \
> +			.endianness =3D IIO_BE, \
> +		}, \
> +	}
> +
> +#define ADIS16475_GYRO_CHANNEL(_mod) \
> +	ADIS16475_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> +	ADIS16475_REG_ ## _mod ## _GYRO_L, ADIS16475_SCAN_GYRO_ ## _mod, 32, \
> +	32)
> +
> +#define ADIS16475_ACCEL_CHANNEL(_mod) \
> +	ADIS16475_MOD_CHAN(IIO_ACCEL, IIO_MOD_ ## _mod, \
> +	ADIS16475_REG_ ## _mod ## _ACCEL_L, ADIS16475_SCAN_ACCEL_ ## _mod, 32, \
> +	32)
> +
> +#define ADIS16475_TEMP_CHANNEL() { \
> +		.type =3D IIO_TEMP, \
> +		.indexed =3D 1, \
> +		.channel =3D 0, \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +		.address =3D ADIS16475_REG_TEMP_OUT, \
> +		.scan_index =3D ADIS16475_SCAN_TEMP, \
> +		.scan_type =3D { \
> +			.sign =3D 's', \
> +			.realbits =3D 16, \
> +			.storagebits =3D 16, \
> +			.endianness =3D IIO_BE, \
> +		}, \
> +	}
> +
> +static const struct iio_chan_spec adis16475_channels[] =3D {
> +	ADIS16475_GYRO_CHANNEL(X),
> +	ADIS16475_GYRO_CHANNEL(Y),
> +	ADIS16475_GYRO_CHANNEL(Z),
> +	ADIS16475_ACCEL_CHANNEL(X),
> +	ADIS16475_ACCEL_CHANNEL(Y),
> +	ADIS16475_ACCEL_CHANNEL(Z),
> +	ADIS16475_TEMP_CHANNEL(),
> +	IIO_CHAN_SOFT_TIMESTAMP(9)
> +};
> +
> +enum adis16475_variant {
> +	ADIS16470,
> +	ADIS16475_1,
> +	ADIS16475_2,
> +	ADIS16475_3,
> +	ADIS16477_1,
> +	ADIS16477_2,
> +	ADIS16477_3,
> +	ADIS16465_1,
> +	ADIS16465_2,
> +	ADIS16465_3,
> +	ADIS16467_1,
> +	ADIS16467_2,
> +	ADIS16467_3,
> +	ADIS16500,
> +	ADIS16505_1,
> +	ADIS16505_2,
> +	ADIS16505_3,
> +	ADIS16507_1,
> +	ADIS16507_2,
> +	ADIS16507_3,
> +
> +};
> +
> +enum {
> +	ADIS16475_DIAG_STAT_DATA_PATH =3D 1,
> +	ADIS16475_DIAG_STAT_FLASH_MEM,
> +	ADIS16475_DIAG_STAT_SPI,
> +	ADIS16475_DIAG_STAT_STANDBY,
> +	ADIS16475_DIAG_STAT_SENSOR,
> +	ADIS16475_DIAG_STAT_MEMORY,
> +	ADIS16475_DIAG_STAT_CLK,
> +};
> +
> +static const char * const adis16475_status_error_msgs[] =3D {
> +	[ADIS16475_DIAG_STAT_DATA_PATH] =3D "Data Path Overrun",
> +	[ADIS16475_DIAG_STAT_FLASH_MEM] =3D "Flash memory update failure",
> +	[ADIS16475_DIAG_STAT_SPI] =3D "SPI communication error",
> +	[ADIS16475_DIAG_STAT_STANDBY] =3D "Standby mode",
> +	[ADIS16475_DIAG_STAT_SENSOR] =3D "Sensor failure",
> +	[ADIS16475_DIAG_STAT_MEMORY] =3D "Memory failure",
> +	[ADIS16475_DIAG_STAT_CLK] =3D "Clock error",
> +};
> +
> +static int adis16475_enable_irq(struct adis *adis, bool enable)
> +{
> +	/*
> +	 * There is no way to gate the data-ready signal internally inside the
> +	 * ADIS16475. We can only control it's polarity...
> +	 */
> +	if (enable)
> +		enable_irq(adis->spi->irq);
> +	else
> +		disable_irq(adis->spi->irq);
> +
> +	return 0;
> +}
> +
> +#define ADIS16475_DATA(_prod_id, _timeouts)				\
> +{									\
> +	.msc_ctrl_reg =3D ADIS16475_REG_MSG_CTRL,				\
> +	.glob_cmd_reg =3D ADIS16475_REG_GLOB_CMD,				\
> +	.diag_stat_reg =3D ADIS16475_REG_DIAG_STAT,			\
> +	.prod_id_reg =3D ADIS16475_REG_PROD_ID,				\
> +	.prod_id =3D (_prod_id),						\
> +	.self_test_mask =3D BIT(2),					\
> +	.self_test_reg =3D ADIS16475_REG_GLOB_CMD,			\
> +	.cs_change_delay =3D 16,						\
> +	.read_delay =3D 5,						\
> +	.write_delay =3D 5,						\
> +	.status_error_msgs =3D adis16475_status_error_msgs,		\
> +	.status_error_mask =3D BIT(ADIS16475_DIAG_STAT_DATA_PATH) |	\
> +		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |			\
> +		BIT(ADIS16475_DIAG_STAT_SPI) |				\
> +		BIT(ADIS16475_DIAG_STAT_STANDBY) |			\
> +		BIT(ADIS16475_DIAG_STAT_SENSOR) |			\
> +		BIT(ADIS16475_DIAG_STAT_MEMORY) |			\
> +		BIT(ADIS16475_DIAG_STAT_CLK),				\
> +	.enable_irq =3D adis16475_enable_irq,				\
> +	.timeouts =3D (_timeouts),					\
> +}
> +
> +static const struct adis16475_clks adis16475_ext_clks[] =3D {
> +	{ "sync", ADIS16475_CLK_OUTPUT, 1900, 2100 },
> +	{ "direct-sync", ADIS16475_CLK_DIRECT, 1900, 2100 },
> +	{ "scaled-sync", ADIS16475_CLK_SCALED, 1, 128 },
> +	{ "pulse-sync", ADIS16475_CLK_PULSE, 1000, 2100 },

Rob already commented on this so I'll not bother :)

> +};
> +
> +static const struct adis_timeout adis16475_timeouts =3D {
> +	.reset_ms =3D 200,
> +	.sw_reset_ms =3D 200,
> +	.self_test_ms =3D 20,
> +};
> +
> +static const struct adis_timeout adis1650x_timeouts =3D {
> +	.reset_ms =3D 260,
> +	.sw_reset_ms =3D 260,
> +	.self_test_ms =3D 30,
> +};
> +
> +static const struct adis16475_chip_info adis16475_chip_info[] =3D {
> +	[ADIS16470] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16470, &adis16475_timeouts),
> +	},
> +	[ADIS16475_1] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(4000 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16475, &adis16475_timeouts),
> +	},
> +	[ADIS16475_2] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(4000 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16475, &adis16475_timeouts),
> +	},
> +	[ADIS16475_3] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(4000 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16475, &adis16475_timeouts),
> +	},
> +	[ADIS16477_1] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16477, &adis16475_timeouts),
> +	},
> +	[ADIS16477_2] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16477, &adis16475_timeouts),
> +	},
> +	[ADIS16477_3] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16477, &adis16475_timeouts),
> +	},
> +	[ADIS16465_1] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(4000 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16465, &adis16475_timeouts),
> +	},
> +	[ADIS16465_2] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(4000 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16465, &adis16475_timeouts),
> +	},
> +	[ADIS16465_3] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(4000 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16465, &adis16475_timeouts),
> +	},
> +	[ADIS16467_1] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16467, &adis16475_timeouts),
> +	},
> +	[ADIS16467_2] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16467, &adis16475_timeouts),
> +	},
> +	[ADIS16467_3] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks),
> +		.adis_data =3D ADIS16475_DATA(16467, &adis16475_timeouts),
> +	},
> +	[ADIS16500] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 392,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16500, &adis1650x_timeouts),
> +	},
> +	[ADIS16505_1] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> +		.accel_max_val =3D 78,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16505, &adis1650x_timeouts),
> +	},
> +	[ADIS16505_2] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 78,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16505, &adis1650x_timeouts),
> +	},
> +	[ADIS16505_3] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 78,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16505, &adis1650x_timeouts),
> +	},
> +	[ADIS16507_1] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> +		.accel_max_val =3D 392,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16507, &adis1650x_timeouts),
> +	},
> +	[ADIS16507_2] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 392,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16507, &adis1650x_timeouts),
> +	},
> +	[ADIS16507_3] =3D {
> +		.num_channels =3D ARRAY_SIZE(adis16475_channels),
> +		.channels =3D adis16475_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> +		.accel_max_val =3D 392,
> +		.accel_max_scale =3D 32000 << 16,
> +		.temp_scale =3D 100,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.clks =3D adis16475_ext_clks,
> +		/* pulse sync not supported */
> +		.num_clks =3D ARRAY_SIZE(adis16475_ext_clks) - 1,
> +		.has_burst32 =3D true,
> +		.adis_data =3D ADIS16475_DATA(16507, &adis1650x_timeouts),
> +	},
> +};
> +
> +static const struct iio_info adis16475_info =3D {
> +	.read_raw =3D &adis16475_read_raw,
> +	.write_raw =3D &adis16475_write_raw,
> +	.update_scan_mode =3D adis_update_scan_mode,
> +	.attrs =3D &adis16495_attribute_group,
> +	.debugfs_reg_access =3D adis_debugfs_reg_access,
> +};
> +
> +static struct adis_burst adis16475_burst =3D {
> +	.en =3D true,
> +	.reg_cmd =3D ADIS16475_REG_GLOB_CMD,
> +	/*
> +	 * adis_update_scan_mode_burst() sets the burst length in respect with
> +	 * the number of channels and allocates 16 bits for each. However,
> +	 * adis1647x devices also need space for DIAG_STAT, DATA_CNTR or
> +	 * TIME_STAMP (depending on the clock mode but for us these bytes are
> +	 * don't care...) and CRC.
> +	 */
> +	.extra_len =3D 3 * sizeof(u16),
> +};
> +
> +static u16 adis16475_validate_crc(const u8 *buffer, const u16 crc,
> +				  const bool burst32)
> +{
> +	int i;
> +	u16 __crc =3D 0;
> +
> +	/* extra 6 elements for low gyro and accel */
> +	const u16 sz =3D burst32 ? ADIS16475_BURST_MAX_DATA + 6 :
> +		ADIS16475_BURST_MAX_DATA;
> +
> +	for (i =3D 0; i < sz * 2 - 2; i++)
> +		__crc +=3D buffer[i];
> +
> +	return (__crc !=3D crc);
> +}
> +
> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct adis16475 *st =3D iio_priv(indio_dev);
> +	struct adis *adis =3D &st->adis;
> +	int ret, bit, i =3D 0;
> +	u16 crc, data[ADIS16475_MAX_SCAN_DATA], *buffer, crc_res;
> +	/* offset until the first element after gyro and accel */
> +	const u8 offset =3D st->burst32 ? 13 : 7;
> +
> +	ret =3D spi_sync(adis->spi, &adis->msg);
> +	if (ret)
> +		return ret;
> +
> +	buffer =3D (u16 *)adis->buffer;
> +
> +	if (!(adis->burst && adis->burst->en))
> +		goto push_to_buffers;
> +
> +	/* We always validate the crc to at least print a message */
> +	crc =3D get_unaligned_be16(&buffer[offset + 2]);
> +	crc_res =3D adis16475_validate_crc((u8 *)adis->buffer, crc,
> +					 st->burst32);
> +	if (crc_res)
> +		dev_err(&adis->spi->dev, "Invalid crc\n");
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		/*
> +		 * When burst mode is used, system flags is the first data
> +		 * channel in the sequence, but the scan index is 7.
> +		 */
> +		switch (bit) {
> +		case ADIS16475_SCAN_TEMP:
> +			data[i++] =3D get_unaligned(&buffer[offset]);
> +			break;
> +		case ADIS16475_SCAN_GYRO_X ... ADIS16475_SCAN_ACCEL_Z:
> +			/*
> +			 * The first 2 bytes on the received data are the
> +			 * DIAG_STAT reg, hence the +1 offset here...
> +			 */
> +			if (st->burst32) {
> +				/* upper 16 */
> +				data[i++] =3D get_unaligned(&buffer[bit * 2 + 2]);
> +				/* lower 16 */
> +				data[i++] =3D get_unaligned(&buffer[bit * 2 + 1]);
> +			} else {
> +				data[i++] =3D get_unaligned(&buffer[bit + 1]);
> +				/* lower not used */
> +				data[i++] =3D 0;
> +			}
> +			break;
> +		}
> +	}
> +
> +	buffer =3D data;
> +
> +push_to_buffers:
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);

I'm not sure data is the right size.  It needs to have space to have an ali=
gned
timestamp at the end.

> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void adis16475_disable_clk(void *data)
> +{
> +	clk_disable_unprepare((struct clk *)data);
> +}
> +
> +static int adis16475_config_ext_clk(struct adis16475 *st)
> +{
> +	int ret;
> +	int i;
> +	struct device *dev =3D &st->adis.spi->dev;
> +	const struct adis16475_clks *ext_clks =3D st->info->clks;
> +
> +	for (i =3D 0; i < st->info->num_clks; i++) {
> +		u16 mode =3D ADIS16475_EXT_CLK(ext_clks[i].clk_mode);
> +		struct clk *clk =3D devm_clk_get(dev, ext_clks[i].name);
> +
> +		if (IS_ERR(clk) && PTR_ERR(clk) !=3D -ENOENT)
> +			return PTR_ERR(clk);
> +		else if (IS_ERR(clk))
> +			continue;
> +
> +		ret =3D clk_prepare_enable(clk);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_add_action_or_reset(dev, adis16475_disable_clk, clk);
> +		if (ret)
> +			return ret;
> +
> +		st->clk_freq =3D clk_get_rate(clk);
> +		if (st->clk_freq < ext_clks[i].min_rate ||
> +		    st->clk_freq > ext_clks[i].max_rate) {
> +			dev_err(dev,
> +				"Clk rate:%u not in a valid range:[%u %u]\n",
> +				st->clk_freq, ext_clks[i].min_rate,
> +				ext_clks[i].max_rate);
> +			return -EINVAL;
> +		}
> +
> +		if (ext_clks[i].clk_mode =3D=3D ADIS16475_CLK_SCALED) {
> +			u16 up_scale;
> +			u32 scaled_out_freq =3D 0;
> +			/*
> +			 * If we are in scaled mode, we must have an up_scale.
> +			 * In scaled mode the allowable input clock range is
> +			 * 1 Hz to 128 Hz, and the allowable output range is
> +			 * 1900 to 2100 Hz. Hence, a scale must be given to
> +			 * get the allowable output.
> +			 */
> +			device_property_read_u32(dev, "adi,scaled-output-hz",
> +						 &scaled_out_freq);
> +
> +			if (scaled_out_freq < 1900 || scaled_out_freq > 2100) {
> +				dev_err(dev,
> +					"Invalid value:%u for adi,scaled-output-hz",
> +					scaled_out_freq);
> +				return -EINVAL;
> +			}
> +
> +			up_scale =3D DIV_ROUND_CLOSEST(scaled_out_freq,
> +						     st->clk_freq);
> +
> +			ret =3D __adis_write_reg_16(&st->adis,
> +						  ADIS16475_CLK_SCALED,
> +						  up_scale);
> +			if (ret)
> +				return ret;
> +
> +			st->clk_freq =3D scaled_out_freq;
> +		}
> +		/*
> +		 * Keep in mind that the mask for the clk modes in adis1650*
> +		 * chips is different (1100 instead of 11100). However, we
> +		 * are not configuring BIT(4) in these chips and the default
> +		 * value is 0, so we are fine in doing the below operations.
> +		 * I'm keeping this for simplicity and avoiding extra variables
> +		 * in chip_info.
> +		 */
> +		ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16475_EXT_CLK_MASK, mode);
> +		if (ret)
> +			return ret;
> +
> +		usleep_range(250, 260);
> +
> +		break;
> +	}
> +
> +	if (i =3D=3D st->info->num_clks)
> +		/* internal clk */
> +		st->clk_freq =3D st->info->int_clk;
> +
> +	st->clk_freq *=3D 1000;
> +
> +	return 0;
> +}
> +
> +static int adis16475_config_irq_pin(struct adis16475 *st)
> +{
> +	int ret;
> +	struct irq_data *desc;
> +	u32 irq_type;
> +	u16 val =3D 0;
> +	u8 polarity;
> +	struct spi_device *spi =3D st->adis.spi;
> +
> +	desc =3D irq_get_irq_data(spi->irq);
> +	if (!desc) {
> +		dev_err(&spi->dev, "Could not find IRQ %d\n", spi->irq);
> +		return -EINVAL;
> +	}
> +	/*
> +	 * It is possible to configure the data ready polarity. Furthermore, we
> +	 * need to update the adis struct if we want data ready as active low.
> +	 */
> +	irq_type =3D irqd_get_trigger_type(desc);
> +	if (irq_type =3D=3D IRQF_TRIGGER_RISING) {
> +		polarity =3D 1;
> +	} else if (irq_type =3D=3D IRQF_TRIGGER_FALLING) {
> +		polarity =3D 0;
> +		st->adis.irq_mask =3D IRQF_TRIGGER_FALLING;
> +	} else {
> +		dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
> +			irq_type);
> +		return -EINVAL;
> +	}
> +
> +	val =3D ADIS16475_MSG_CTRL_DR_POL(polarity);
> +	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * There is a delay writing to any bits written to the MSC_CTRL
> +	 * register. It should not be bigger than 200us, so 250 should be more
> +	 * than enough!
> +	 */
> +	usleep_range(250, 260);
> +
> +	return 0;
> +}
> +
> +static int adis16475_burst_config(struct adis16475 *st)
> +{
> +	const u16 burst32 =3D ADIS16500_BURST32(1);
> +	int ret;
> +
> +	st->burst32 =3D device_property_read_bool(&st->adis.spi->dev,
> +						"adi,burst32-enable");
> +	if (!st->burst32)
> +		goto burst16;
A forwards goto like this on a non error condition, is a bit unusual.
While it involves more indenting I would still prefer the logic flipped
	if (st->burst32) {

	}


> +
> +	if (!st->info->has_burst32) {
> +		dev_err(&st->adis.spi->dev, "%s does not support burst32 mode\n",
> +			spi_get_device_id(st->adis.spi)->name);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +				 ADIS16500_BURST32_MASK, burst32);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(250, 260);
> +	/*
> +	 * In 32bit mode we need extra 2 bytes for all gyro and accel
> +	 * channels.
> +	 */
> +	adis16475_burst.extra_len +=3D 6 * sizeof(u16);
> +burst16:
> +	st->adis.burst =3D &adis16475_burst;
> +	/* it's enabled by default so spi max speed needs to be 1MHz */
> +	st->cached_spi_speed_hz =3D st->adis.spi->max_speed_hz;
> +	st->adis.spi->max_speed_hz =3D 1000000;
> +
> +	return 0;
> +}
> +
> +static int adis16475_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis16475 *st;
> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->info =3D &adis16475_chip_info[id->driver_data];
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &st->info->adis_data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->dev.parent =3D &spi->dev;
> +	indio_dev->name =3D id->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->info =3D &adis16475_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16475_burst_config(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16475_config_irq_pin(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16475_config_ext_clk(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16475_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	adis16475_enable_irq(&st->adis, false);
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16475_debugfs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id adis16475_ids[] =3D {

Is it actually possible to instantiate this except by
using the dt table below?  If not, then move the 'data'
part into that table and don't provide an spi_device_id
table at all.  It's not relevant to the possible ways
of causing the driver to probe.

> +	{ "adis16470", ADIS16470 },
> +	{ "adis16475-1", ADIS16475_1 },
> +	{ "adis16475-2", ADIS16475_2 },
> +	{ "adis16475-3", ADIS16475_3 },
> +	{ "adis16477-1", ADIS16477_1 },
> +	{ "adis16477-2", ADIS16477_2 },
> +	{ "adis16477-3", ADIS16477_3 },
> +	{ "adis16465-1", ADIS16465_1 },
> +	{ "adis16465-2", ADIS16465_2 },
> +	{ "adis16465-3", ADIS16465_3 },
> +	{ "adis16467-1", ADIS16467_1 },
> +	{ "adis16467-2", ADIS16467_2 },
> +	{ "adis16467-3", ADIS16467_3 },
> +	{ "adis16500", ADIS16500 },
> +	{ "adis16505-1", ADIS16505_1 },
> +	{ "adis16505-2", ADIS16505_2 },
> +	{ "adis16505-3", ADIS16505_3 },
> +	{ "adis16507-1", ADIS16507_1 },
> +	{ "adis16507-2", ADIS16507_2 },
> +	{ "adis16507-3", ADIS16507_3 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16475_ids);
> +
> +static const struct of_device_id adis16475_of_match[] =3D {
> +	{ .compatible =3D "adi,adis16470" },
> +	{ .compatible =3D "adi,adis16475-1" },
> +	{ .compatible =3D "adi,adis16475-2" },
> +	{ .compatible =3D "adi,adis16475-3" },
> +	{ .compatible =3D "adi,adis16477-1" },
> +	{ .compatible =3D "adi,adis16477-2" },
> +	{ .compatible =3D "adi,adis16477-3" },
> +	{ .compatible =3D "adi,adis16465-1" },
> +	{ .compatible =3D "adi,adis16465-2" },
> +	{ .compatible =3D "adi,adis16465-3" },
> +	{ .compatible =3D "adi,adis16467-1" },
> +	{ .compatible =3D "adi,adis16467-2" },
> +	{ .compatible =3D "adi,adis16467-3" },
> +	{ .compatible =3D "adi,adis16500" },
> +	{ .compatible =3D "adi,adis16505-1" },
> +	{ .compatible =3D "adi,adis16505-2" },
> +	{ .compatible =3D "adi,adis16505-3" },
> +	{ .compatible =3D "adi,adis16507-1" },
> +	{ .compatible =3D "adi,adis16507-2" },
> +	{ .compatible =3D "adi,adis16507-3" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adis16475_of_match);
> +
> +static struct spi_driver adis16475_driver =3D {
> +	.driver =3D {
> +		.name =3D "adis16475",
> +		.of_match_table =3D adis16475_of_match,
> +	},
> +	.id_table =3D adis16475_ids,
> +	.probe =3D adis16475_probe,
> +};
> +module_spi_driver(adis16475_driver);
> +
> +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16475 IMU driver");
> +MODULE_LICENSE("GPL");

