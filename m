Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92E817CDC6
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgCGLZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 06:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgCGLZS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 06:25:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459D4206D5;
        Sat,  7 Mar 2020 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583580317;
        bh=XvK6fCM++Zx3agMl3Xt8wquZGRKdHIKF5mh0VIvhQlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MrHPhkcSVN7E1uIo4vmRH0x4HBywOaFQNxuZooTyXLWkiOr8XLW7qmEOuYKGzjYhX
         ARagZQmydPlFFmFY3LQBc+B5ODVQ4bPHbqA6bbQffFUFL9kTO2S/e31TeN37BX2F6j
         Ay51V6BZh3BaOQlS9fWasK93kquqoIYksgZiK4o8=
Date:   Sat, 7 Mar 2020 11:25:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 4/5] iio: imu: Add support for adis16475
Message-ID: <20200307112511.68b7ff34@archlinux>
In-Reply-To: <8581ed92-e00e-c606-8890-85fd5ef11cb8@metafoo.de>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-5-nuno.sa@analog.com>
        <20200303210814.1057fbbb@archlinux>
        <0021fdd0f92a30209bd798c761add8e67a8df5db.camel@analog.com>
        <f1f14ed4f13c41be728cee976b969192af95e61c.camel@analog.com>
        <8581ed92-e00e-c606-8890-85fd5ef11cb8@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 5 Mar 2020 11:39:36 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/5/20 10:58 AM, Sa, Nuno wrote:
> > On Wed, 2020-03-04 at 17:59 +0000, Sa, Nuno wrote: =20
> >> [External]
> >>
> >> On Tue, 2020-03-03 at 21:08 +0000, Jonathan Cameron wrote: =20
> >>> [External]
> >>>
> >>> On Tue, 25 Feb 2020 13:41:51 +0100
> >>> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >>> =20
> >>>> Support ADIS16475 and similar IMU devices. These devices are
> >>>> a precision, miniature MEMS inertial measurement unit (IMU) that
> >>>> includes a triaxial gyroscope and a triaxial accelerometer. Each
> >>>> inertial sensor combines with signal conditioning that optimizes
> >>>> dynamic performance.
> >>>>
> >>>> The driver adds support for the following devices:
> >>>>   * adis16470, adis16475, adis16477, adis16465, adis16467,
> >>>> adis16500,
> >>>>     adis16505, adis16507.
> >>>>
> >>>> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> >>> A few bits and pieces inline.
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan
> >>>
> >>> =20
> >>>> ---
> >>>>   .../ABI/testing/sysfs-bus-iio-imu-adis16475   |    7 +
> >>>>   MAINTAINERS                                   |    8 +
> >>>>   drivers/iio/imu/Kconfig                       |   13 +
> >>>>   drivers/iio/imu/Makefile                      |    1 +
> >>>>   drivers/iio/imu/adis16475.c                   | 1304
> >>>> +++++++++++++++++
> >>>>   5 files changed, 1333 insertions(+)
> >>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-imu-
> >>>> adis16475
> >>>>   create mode 100644 drivers/iio/imu/adis16475.c
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-imu-
> >>>> adis16475
> >>>> b/Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> >>>> new file mode 100644
> >>>> index 000000000000..e2c3776035ea
> >>>> --- /dev/null
> >>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> >>>> @@ -0,0 +1,7 @@
> >>>> +What:		/sys/bus/iio/devices/iio:deviceX/burst_mode_ena
> >>>> ble
> >>>> +KernelVersion:
> >>>> +Contact:	linux-iio@vger.kernel.org
> >>>> +Description:
> >>>> +		Use the device burst read mode when reading buffered
> >>>> +		data. This mode provides a way to read a batch of
> >>>> +		output data registers, using a continuous stream of
> >>>> bits. =20
> >>> See comment on this below.  I'm not keen on this being exposed to
> >>> userspace
> >>> because it will rarely have any idea how to set it.
> >>> =20
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index 8fa40c3eb72a..f11262f1f3bb 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -1008,6 +1008,14 @@ W:=09
> >>>> http://ez.analog.com/community/linux-device-drivers
> >>>>   F:	drivers/iio/imu/adis16460.c
> >>>>   F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460
> >>>> .yaml
> >>>>  =20
> >>>> +ANALOG DEVICES INC ADIS16475 DRIVER
> >>>> +M:	Nuno Sa <nuno.sa@analog.com>
> >>>> +L:	linux-iio@vger.kernel.org
> >>>> +W:	http://ez.analog.com/community/linux-device-drivers
> >>>> +S:	Supported
> >>>> +F:	drivers/iio/imu/adis16475.c
> >>>> +F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> >>>> +
> >>>>   ANALOG DEVICES INC ADM1177 DRIVER
> >>>>   M:	Beniamin Bia <beniamin.bia@analog.com>
> >>>>   M:	Michael Hennerich <Michael.Hennerich@analog.com>
> >>>> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> >>>> index 60bb1029e759..fc4123d518bc 100644
> >>>> --- a/drivers/iio/imu/Kconfig
> >>>> +++ b/drivers/iio/imu/Kconfig
> >>>> @@ -29,6 +29,19 @@ config ADIS16460
> >>>>   	  To compile this driver as a module, choose M here: the module
> >>>> will be
> >>>>   	  called adis16460.
> >>>>  =20
> >>>> +config ADIS16475
> >>>> +	tristate "Analog Devices ADIS16475 and similar IMU driver"
> >>>> +	depends on SPI
> >>>> +	select IIO_ADIS_LIB
> >>>> +	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> >>>> +	help
> >>>> +	  Say yes here to build support for Analog Devices ADIS16470,
> >>>> ADIS16475,
> >>>> +	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505,
> >>>> ADIS16507 inertial
> >>>> +	  sensors.
> >>>> +
> >>>> +	  To compile this driver as a module, choose M here: the module
> >>>> will be
> >>>> +	  called adis16475.
> >>>> +
> >>>>   config ADIS16480
> >>>>   	tristate "Analog Devices ADIS16480 and similar IMU driver"
> >>>>   	depends on SPI
> >>>> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> >>>> index 5237fd4bc384..88b2c4555230 100644
> >>>> --- a/drivers/iio/imu/Makefile
> >>>> +++ b/drivers/iio/imu/Makefile
> >>>> @@ -6,6 +6,7 @@
> >>>>   # When adding new entries keep the list in alphabetical order
> >>>>   obj-$(CONFIG_ADIS16400) +=3D adis16400.o
> >>>>   obj-$(CONFIG_ADIS16460) +=3D adis16460.o
> >>>> +obj-$(CONFIG_ADIS16475) +=3D adis16475.o
> >>>>   obj-$(CONFIG_ADIS16480) +=3D adis16480.o
> >>>>  =20
> >>>>   adis_lib-y +=3D adis.o
> >>>> diff --git a/drivers/iio/imu/adis16475.c
> >>>> b/drivers/iio/imu/adis16475.c
> >>>> new file mode 100644
> >>>> index 000000000000..f7c637734ec8
> >>>> --- /dev/null
> >>>> +++ b/drivers/iio/imu/adis16475.c
> >>>> @@ -0,0 +1,1304 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * ADIS16475 IMU driver
> >>>> + *
> >>>> + * Copyright 2019 Analog Devices Inc.
> >>>> + */
> >>>> +#include <asm/unaligned.h>
> >>>> +#include <linux/bitfield.h>
> >>>> +#include <linux/bitops.h>
> >>>> +#include <linux/clk.h>
> >>>> +#include <linux/debugfs.h>
> >>>> +#include <linux/delay.h>
> >>>> +#include <linux/device.h>
> >>>> +#include <linux/kernel.h>
> >>>> +#include <linux/iio/buffer.h>
> >>>> +#include <linux/iio/iio.h>
> >>>> +#include <linux/iio/imu/adis.h>
> >>>> +#include <linux/iio/sysfs.h>
> >>>> +#include <linux/iio/trigger_consumer.h>
> >>>> +#include <linux/irq.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/spi/spi.h>
> >>>> +
> >>>> +#define ADIS16475_REG_DIAG_STAT		0x02
> >>>> +#define ADIS16475_REG_X_GYRO_L		0x04
> >>>> +#define ADIS16475_REG_Y_GYRO_L		0x08
> >>>> +#define ADIS16475_REG_Z_GYRO_L		0x0C
> >>>> +#define ADIS16475_REG_X_ACCEL_L		0x10
> >>>> +#define ADIS16475_REG_Y_ACCEL_L		0x14
> >>>> +#define ADIS16475_REG_Z_ACCEL_L		0x18
> >>>> +#define ADIS16475_REG_TEMP_OUT		0x1c
> >>>> +#define ADIS16475_REG_X_GYRO_BIAS_L	0x40
> >>>> +#define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
> >>>> +#define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
> >>>> +#define ADIS16475_REG_X_ACCEL_BIAS_L	0x4c
> >>>> +#define ADIS16475_REG_Y_ACCEL_BIAS_L	0x50
> >>>> +#define ADIS16475_REG_Z_ACCEL_BIAS_L	0x54
> >>>> +#define ADIS16475_REG_FILT_CTRL		0x5c
> >>>> +#define ADIS16475_FILT_CTRL_MASK	GENMASK(2, 0)
> >>>> +#define ADIS16475_FILT_CTRL(x)		FIELD_PREP(ADIS16475_FI
> >>>> LT_CTRL_MASK, x)
> >>>> +#define ADIS16475_REG_MSG_CTRL		0x60
> >>>> +#define ADIS16475_MSG_CTRL_DR_POL_MASK	BIT(0)
> >>>> +#define ADIS16475_MSG_CTRL_DR_POL(x) \
> >>>> +				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MA
> >>>> SK, x)
> >>>> +#define ADIS16475_EXT_CLK_MASK		GENMASK(4, 2)
> >>>> +#define ADIS16475_EXT_CLK(x)		FIELD_PREP(ADIS16475_EX
> >>>> T_CLK_MASK, x)
> >>>> +#define ADIS16475_REG_UP_SCALE		0x62
> >>>> +#define ADIS16475_REG_DEC_RATE		0x64
> >>>> +#define ADIS16475_REG_GLOB_CMD		0x68
> >>>> +#define ADIS16475_REG_FIRM_REV		0x6c
> >>>> +#define ADIS16475_REG_FIRM_DM		0x6e
> >>>> +#define ADIS16475_REG_FIRM_Y		0x70
> >>>> +#define ADIS16475_REG_PROD_ID		0x72
> >>>> +#define ADIS16475_REG_SERIAL_NUM	0x74
> >>>> +#define ADIS16475_REG_FLASH_CNT		0x7c
> >>>> +#define ADIS16500_BURST32_MASK		BIT(9)
> >>>> +#define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BU
> >>>> RST32_MASK, x)
> >>>> +/* number of data elements in burst mode */
> >>>> +#define ADIS16475_BURST_MAX_DATA	10
> >>>> +#define ADIS16475_MAX_SCAN_DATA		15
> >>>> +
> >>>> +enum clk_mode {
> >>>> +	ADIS16475_CLK_DIRECT =3D 1,
> >>>> +	ADIS16475_CLK_SCALED,
> >>>> +	ADIS16475_CLK_OUTPUT,
> >>>> +	ADIS16475_CLK_PULSE =3D 5,
> >>>> +};
> >>>> +
> >>>> +struct adis16475_clks {
> >>>> +	const char *name;
> >>>> +	enum clk_mode clk_mode;
> >>>> +	u16 min_rate;
> >>>> +	u16 max_rate;
> >>>> +};
> >>>> +
> >>>> +struct adis16475_chip_info {
> >>>> +	const struct iio_chan_spec *channels;
> >>>> +	const struct adis16475_clks *clks;
> >>>> +	const struct adis_data adis_data;
> >>>> +	u32 num_channels;
> >>>> +	u32 gyro_max_val;
> >>>> +	u32 gyro_max_scale;
> >>>> +	u32 accel_max_val;
> >>>> +	u32 accel_max_scale;
> >>>> +	u32 temp_scale;
> >>>> +	u32 int_clk;
> >>>> +	u16 max_dec;
> >>>> +	u8 num_clks;
> >>>> +	bool has_burst32;
> >>>> +};
> >>>> +
> >>>> +struct adis16475 {
> >>>> +	const struct adis16475_chip_info *info;
> >>>> +	struct adis adis;
> >>>> +	u32 clk_freq;
> >>>> +	u32 cached_spi_speed_hz;
> >>>> +	bool burst32;
> >>>> +};
> >>>> +
> >>>> +enum {
> >>>> +	ADIS16475_SCAN_GYRO_X,
> >>>> +	ADIS16475_SCAN_GYRO_Y,
> >>>> +	ADIS16475_SCAN_GYRO_Z,
> >>>> +	ADIS16475_SCAN_ACCEL_X,
> >>>> +	ADIS16475_SCAN_ACCEL_Y,
> >>>> +	ADIS16475_SCAN_ACCEL_Z,
> >>>> +	ADIS16475_SCAN_TEMP,
> >>>> +	ADIS16475_SCAN_DIAG_S_FLAGS,
> >>>> +	ADIS16475_SCAN_CRC_FAILURE,
> >>>> +};
> >>>> +
> >>>> +#ifdef CONFIG_DEBUG_FS
> >>>> +static ssize_t adis16475_show_firmware_revision(struct file
> >>>> *file,
> >>>> +						char __user *userbuf,
> >>>> +						size_t count, loff_t
> >>>> *ppos)
> >>>> +{
> >>>> +	struct adis16475 *st =3D file->private_data;
> >>>> +	char buf[7];
> >>>> +	size_t len;
> >>>> +	u16 rev;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_REV,
> >>>> &rev);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	len =3D scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev &
> >>>> 0xff);
> >>>> +
> >>>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> >>>> +}
> >>>> +
> >>>> +static const struct file_operations
> >>>> adis16475_firmware_revision_fops =3D {
> >>>> +	.open =3D simple_open,
> >>>> +	.read =3D adis16475_show_firmware_revision,
> >>>> +	.llseek =3D default_llseek,
> >>>> +	.owner =3D THIS_MODULE,
> >>>> +};
> >>>> +
> >>>> +static ssize_t adis16475_show_firmware_date(struct file *file,
> >>>> +					    char __user *userbuf,
> >>>> +					    size_t count, loff_t *ppos)
> >>>> +{
> >>>> +	struct adis16475 *st =3D file->private_data;
> >>>> +	u16 md, year;
> >>>> +	char buf[12];
> >>>> +	size_t len;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_Y, &year);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_DM, &md);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	len =3D snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", md >> 8,
> >>>> md & 0xff,
> >>>> +		       year);
> >>>> +
> >>>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> >>>> +}
> >>>> +
> >>>> +static const struct file_operations adis16475_firmware_date_fops
> >>>> =3D
> >>>> {
> >>>> +	.open =3D simple_open,
> >>>> +	.read =3D adis16475_show_firmware_date,
> >>>> +	.llseek =3D default_llseek,
> >>>> +	.owner =3D THIS_MODULE,
> >>>> +};
> >>>> +
> >>>> +static int adis16475_show_serial_number(void *arg, u64 *val)
> >>>> +{
> >>>> +	struct adis16475 *st =3D arg;
> >>>> +	u16 serial;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_SERIAL_NUM,
> >>>> &serial);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	*val =3D serial;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_serial_number_fops,
> >>>> +			adis16475_show_serial_number, NULL,
> >>>> "0x%.4llx\n");
> >>>> +
> >>>> +static int adis16475_show_product_id(void *arg, u64 *val)
> >>>> +{
> >>>> +	struct adis16475 *st =3D arg;
> >>>> +	u16 prod_id;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret =3D adis_read_reg_16(&st->adis, ADIS16475_REG_PROD_ID,
> >>>> &prod_id);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	*val =3D prod_id;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_product_id_fops,
> >>>> +			adis16475_show_product_id, NULL, "%llu\n");
> >>>> +
> >>>> +static int adis16475_show_flash_count(void *arg, u64 *val)
> >>>> +{
> >>>> +	struct adis16475 *st =3D arg;
> >>>> +	u32 flash_count;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret =3D adis_read_reg_32(&st->adis, ADIS16475_REG_FLASH_CNT,
> >>>> +			       &flash_count);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	*val =3D flash_count;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_flash_count_fops,
> >>>> +			adis16475_show_flash_count, NULL, "%lld\n");
> >>>> +
> >>>> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
> >>>> +{
> >>>> +	struct adis16475 *st =3D iio_priv(indio_dev);
> >>>> +
> >>>> +	debugfs_create_file("serial_number", 0400, indio_dev- =20
> >>>>> debugfs_dentry, =20
> >>>> +			    st, &adis16475_serial_number_fops);
> >>>> +	debugfs_create_file("product_id", 0400, indio_dev- =20
> >>>>> debugfs_dentry, st, =20
> >>>> +			    &adis16475_product_id_fops);
> >>>> +	debugfs_create_file("flash_count", 0400, indio_dev- =20
> >>>>> debugfs_dentry, st, =20
> >>>> +			    &adis16475_flash_count_fops);
> >>>> +	debugfs_create_file("firmware_revision", 0400,
> >>>> +			    indio_dev->debugfs_dentry, st,
> >>>> +			    &adis16475_firmware_revision_fops);
> >>>> +	debugfs_create_file("firmware_date", 0400, indio_dev- =20
> >>>>> debugfs_dentry, =20
> >>>> +			    st, &adis16475_firmware_date_fops);
> >>>> +	return 0;
> >>>> +}
> >>>> +#else
> >>>> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
> >>>> +{
> >>>> +	return 0;
> >>>> +}
> >>>> +#endif
> >>>> +
> >>>> +static ssize_t adis16475_burst_mode_enable_get(struct device
> >>>> *dev,
> >>>> +					       struct device_attribute
> >>>> *attr,
> >>>> +					       char *buf)
> >>>> +{
> >>>> +	struct adis16475 *st =3D iio_priv(dev_to_iio_dev(dev));
> >>>> +
> >>>> +	return sprintf(buf, "%d\n", st->adis.burst->en);
> >>>> +}
> >>>> +
> >>>> +static ssize_t adis16475_burst_mode_enable_set(struct device
> >>>> *dev,
> >>>> +					       struct device_attribute
> >>>> *attr,
> >>>> +					       const char *buf, size_t
> >>>> len)
> >>>> +{
> >>>> +	struct adis16475 *st =3D iio_priv(dev_to_iio_dev(dev));
> >>>> +	bool val;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret =3D kstrtobool(buf, &val);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	if (val)
> >>>> +		/* 1MHz max in burst mode */
> >>>> +		st->adis.spi->max_speed_hz =3D 1000000;
> >>>> +	else
> >>>> +		st->adis.spi->max_speed_hz =3D st->cached_spi_speed_hz;
> >>>> +
> >>>> +	st->adis.burst->en =3D val;
> >>>> +
> >>>> +	return len;
> >>>> +}
> >>>> +
> >>>> +static IIO_DEVICE_ATTR(burst_mode_enable, 0644,
> >>>> +		       adis16475_burst_mode_enable_get,
> >>>> +		       adis16475_burst_mode_enable_set, 0);
> >>>> +
> >>>> +static struct attribute *adis16475_attributes[] =3D {
> >>>> +	&iio_dev_attr_burst_mode_enable.dev_attr.attr, =20
> >>> Hmm.  Normally we try to avoid exposing this and make the decision
> >>> automatically based on which channels are enabled. =20
> >> Hmm. In that case, the decision would probably have to go to the
> >> library since it is there that the "preparations" for buffered mode
> >> are
> >> done. Mostly, the data we are interested in the burst data is gyro,
> >> accel and temp. So to make the decision based on which channels are
> >> enabled is not that straight. Should we enable it only when all
> >> channels are enabled? Some of them (and which)? =20
> > I thought a little bit more about it and we could do some math in the
> > lib to know when using burst mode becomes faster (depending on enabled
> > scan elements). The library would need to know about the burst max spi
> > frequency and also some minor changes in how burst_len is being
> > calculated (drivers should explicitly set this rather than the
> > library). The question is, is it worth it to go with this extra work
> > :)? =20
>=20
> You can leave it out of the initial version and always use burst mode=20
> and then add support for this in a follow up patch if it is worth it.
>=20
> - Lars
>=20
Agreed.   No one tends to buy an expensive IMU to just sample one channel
quickly!  Hence I doubt anyone will ever run it in a mode where burst
mode doesn't make sense.

Thanks,

Jonathan

