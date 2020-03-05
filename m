Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7346B17A347
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 11:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEKjn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 05:39:43 -0500
Received: from www381.your-server.de ([78.46.137.84]:40998 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCEKjn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 05:39:43 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 05:39:41 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8q71XZNrwfP+jSHQpdHpaiaYFsstKdd+i5beX4xklPQ=; b=lwLirqkBOMY5IvP4vywa+tw5dM
        GigArhYaphSQ4fPrgzt/RnqozMkAn3BqvyMtGNfCfFYWY6RdN78wHUMQefNRhicHRnOVgmK3Gxnmr
        H3cg7OaW/CsTl7ziUQXgs4mjOY9USLo5kpupIKgn3/DHRJd5J/XPqTLCnAL4Osz5I6eUEGY7T9/YC
        SRZsgu3kiwFhAvsylhOrwDwF+lNxesGhU1w2N88QYLIlHiGX8REQf++C5irM8sRkbkMebYBrVGAwK
        ZtGYA/eB6qICZDQwtKAk902dHPtNv5bW8tm7BnN39hHq5PdT06ST1HXtA1UYvFs7DkYBt/KfHmLZI
        Z6TcAXuA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1j9nuj-00084o-LL; Thu, 05 Mar 2020 11:39:37 +0100
Received: from [93.104.100.159] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1j9nuj-00016L-5o; Thu, 05 Mar 2020 11:39:37 +0100
Subject: Re: [PATCH 4/5] iio: imu: Add support for adis16475
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200225124152.270914-1-nuno.sa@analog.com>
 <20200225124152.270914-5-nuno.sa@analog.com>
 <20200303210814.1057fbbb@archlinux>
 <0021fdd0f92a30209bd798c761add8e67a8df5db.camel@analog.com>
 <f1f14ed4f13c41be728cee976b969192af95e61c.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8581ed92-e00e-c606-8890-85fd5ef11cb8@metafoo.de>
Date:   Thu, 5 Mar 2020 11:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f1f14ed4f13c41be728cee976b969192af95e61c.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25741/Wed Mar  4 15:15:26 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/5/20 10:58 AM, Sa, Nuno wrote:
> On Wed, 2020-03-04 at 17:59 +0000, Sa, Nuno wrote:
>> [External]
>>
>> On Tue, 2020-03-03 at 21:08 +0000, Jonathan Cameron wrote:
>>> [External]
>>>
>>> On Tue, 25 Feb 2020 13:41:51 +0100
>>> Nuno Sá <nuno.sa@analog.com> wrote:
>>>
>>>> Support ADIS16475 and similar IMU devices. These devices are
>>>> a precision, miniature MEMS inertial measurement unit (IMU) that
>>>> includes a triaxial gyroscope and a triaxial accelerometer. Each
>>>> inertial sensor combines with signal conditioning that optimizes
>>>> dynamic performance.
>>>>
>>>> The driver adds support for the following devices:
>>>>   * adis16470, adis16475, adis16477, adis16465, adis16467,
>>>> adis16500,
>>>>     adis16505, adis16507.
>>>>
>>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>>> A few bits and pieces inline.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>>
>>>> ---
>>>>   .../ABI/testing/sysfs-bus-iio-imu-adis16475   |    7 +
>>>>   MAINTAINERS                                   |    8 +
>>>>   drivers/iio/imu/Kconfig                       |   13 +
>>>>   drivers/iio/imu/Makefile                      |    1 +
>>>>   drivers/iio/imu/adis16475.c                   | 1304
>>>> +++++++++++++++++
>>>>   5 files changed, 1333 insertions(+)
>>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-imu-
>>>> adis16475
>>>>   create mode 100644 drivers/iio/imu/adis16475.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-imu-
>>>> adis16475
>>>> b/Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
>>>> new file mode 100644
>>>> index 000000000000..e2c3776035ea
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
>>>> @@ -0,0 +1,7 @@
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/burst_mode_ena
>>>> ble
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Use the device burst read mode when reading buffered
>>>> +		data. This mode provides a way to read a batch of
>>>> +		output data registers, using a continuous stream of
>>>> bits.
>>> See comment on this below.  I'm not keen on this being exposed to
>>> userspace
>>> because it will rarely have any idea how to set it.
>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 8fa40c3eb72a..f11262f1f3bb 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1008,6 +1008,14 @@ W:	
>>>> http://ez.analog.com/community/linux-device-drivers
>>>>   F:	drivers/iio/imu/adis16460.c
>>>>   F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460
>>>> .yaml
>>>>   
>>>> +ANALOG DEVICES INC ADIS16475 DRIVER
>>>> +M:	Nuno Sa <nuno.sa@analog.com>
>>>> +L:	linux-iio@vger.kernel.org
>>>> +W:	http://ez.analog.com/community/linux-device-drivers
>>>> +S:	Supported
>>>> +F:	drivers/iio/imu/adis16475.c
>>>> +F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
>>>> +
>>>>   ANALOG DEVICES INC ADM1177 DRIVER
>>>>   M:	Beniamin Bia <beniamin.bia@analog.com>
>>>>   M:	Michael Hennerich <Michael.Hennerich@analog.com>
>>>> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
>>>> index 60bb1029e759..fc4123d518bc 100644
>>>> --- a/drivers/iio/imu/Kconfig
>>>> +++ b/drivers/iio/imu/Kconfig
>>>> @@ -29,6 +29,19 @@ config ADIS16460
>>>>   	  To compile this driver as a module, choose M here: the module
>>>> will be
>>>>   	  called adis16460.
>>>>   
>>>> +config ADIS16475
>>>> +	tristate "Analog Devices ADIS16475 and similar IMU driver"
>>>> +	depends on SPI
>>>> +	select IIO_ADIS_LIB
>>>> +	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
>>>> +	help
>>>> +	  Say yes here to build support for Analog Devices ADIS16470,
>>>> ADIS16475,
>>>> +	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505,
>>>> ADIS16507 inertial
>>>> +	  sensors.
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the module
>>>> will be
>>>> +	  called adis16475.
>>>> +
>>>>   config ADIS16480
>>>>   	tristate "Analog Devices ADIS16480 and similar IMU driver"
>>>>   	depends on SPI
>>>> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
>>>> index 5237fd4bc384..88b2c4555230 100644
>>>> --- a/drivers/iio/imu/Makefile
>>>> +++ b/drivers/iio/imu/Makefile
>>>> @@ -6,6 +6,7 @@
>>>>   # When adding new entries keep the list in alphabetical order
>>>>   obj-$(CONFIG_ADIS16400) += adis16400.o
>>>>   obj-$(CONFIG_ADIS16460) += adis16460.o
>>>> +obj-$(CONFIG_ADIS16475) += adis16475.o
>>>>   obj-$(CONFIG_ADIS16480) += adis16480.o
>>>>   
>>>>   adis_lib-y += adis.o
>>>> diff --git a/drivers/iio/imu/adis16475.c
>>>> b/drivers/iio/imu/adis16475.c
>>>> new file mode 100644
>>>> index 000000000000..f7c637734ec8
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/adis16475.c
>>>> @@ -0,0 +1,1304 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * ADIS16475 IMU driver
>>>> + *
>>>> + * Copyright 2019 Analog Devices Inc.
>>>> + */
>>>> +#include <asm/unaligned.h>
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/iio/buffer.h>
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/imu/adis.h>
>>>> +#include <linux/iio/sysfs.h>
>>>> +#include <linux/iio/trigger_consumer.h>
>>>> +#include <linux/irq.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/spi/spi.h>
>>>> +
>>>> +#define ADIS16475_REG_DIAG_STAT		0x02
>>>> +#define ADIS16475_REG_X_GYRO_L		0x04
>>>> +#define ADIS16475_REG_Y_GYRO_L		0x08
>>>> +#define ADIS16475_REG_Z_GYRO_L		0x0C
>>>> +#define ADIS16475_REG_X_ACCEL_L		0x10
>>>> +#define ADIS16475_REG_Y_ACCEL_L		0x14
>>>> +#define ADIS16475_REG_Z_ACCEL_L		0x18
>>>> +#define ADIS16475_REG_TEMP_OUT		0x1c
>>>> +#define ADIS16475_REG_X_GYRO_BIAS_L	0x40
>>>> +#define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
>>>> +#define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
>>>> +#define ADIS16475_REG_X_ACCEL_BIAS_L	0x4c
>>>> +#define ADIS16475_REG_Y_ACCEL_BIAS_L	0x50
>>>> +#define ADIS16475_REG_Z_ACCEL_BIAS_L	0x54
>>>> +#define ADIS16475_REG_FILT_CTRL		0x5c
>>>> +#define ADIS16475_FILT_CTRL_MASK	GENMASK(2, 0)
>>>> +#define ADIS16475_FILT_CTRL(x)		FIELD_PREP(ADIS16475_FI
>>>> LT_CTRL_MASK, x)
>>>> +#define ADIS16475_REG_MSG_CTRL		0x60
>>>> +#define ADIS16475_MSG_CTRL_DR_POL_MASK	BIT(0)
>>>> +#define ADIS16475_MSG_CTRL_DR_POL(x) \
>>>> +				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MA
>>>> SK, x)
>>>> +#define ADIS16475_EXT_CLK_MASK		GENMASK(4, 2)
>>>> +#define ADIS16475_EXT_CLK(x)		FIELD_PREP(ADIS16475_EX
>>>> T_CLK_MASK, x)
>>>> +#define ADIS16475_REG_UP_SCALE		0x62
>>>> +#define ADIS16475_REG_DEC_RATE		0x64
>>>> +#define ADIS16475_REG_GLOB_CMD		0x68
>>>> +#define ADIS16475_REG_FIRM_REV		0x6c
>>>> +#define ADIS16475_REG_FIRM_DM		0x6e
>>>> +#define ADIS16475_REG_FIRM_Y		0x70
>>>> +#define ADIS16475_REG_PROD_ID		0x72
>>>> +#define ADIS16475_REG_SERIAL_NUM	0x74
>>>> +#define ADIS16475_REG_FLASH_CNT		0x7c
>>>> +#define ADIS16500_BURST32_MASK		BIT(9)
>>>> +#define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BU
>>>> RST32_MASK, x)
>>>> +/* number of data elements in burst mode */
>>>> +#define ADIS16475_BURST_MAX_DATA	10
>>>> +#define ADIS16475_MAX_SCAN_DATA		15
>>>> +
>>>> +enum clk_mode {
>>>> +	ADIS16475_CLK_DIRECT = 1,
>>>> +	ADIS16475_CLK_SCALED,
>>>> +	ADIS16475_CLK_OUTPUT,
>>>> +	ADIS16475_CLK_PULSE = 5,
>>>> +};
>>>> +
>>>> +struct adis16475_clks {
>>>> +	const char *name;
>>>> +	enum clk_mode clk_mode;
>>>> +	u16 min_rate;
>>>> +	u16 max_rate;
>>>> +};
>>>> +
>>>> +struct adis16475_chip_info {
>>>> +	const struct iio_chan_spec *channels;
>>>> +	const struct adis16475_clks *clks;
>>>> +	const struct adis_data adis_data;
>>>> +	u32 num_channels;
>>>> +	u32 gyro_max_val;
>>>> +	u32 gyro_max_scale;
>>>> +	u32 accel_max_val;
>>>> +	u32 accel_max_scale;
>>>> +	u32 temp_scale;
>>>> +	u32 int_clk;
>>>> +	u16 max_dec;
>>>> +	u8 num_clks;
>>>> +	bool has_burst32;
>>>> +};
>>>> +
>>>> +struct adis16475 {
>>>> +	const struct adis16475_chip_info *info;
>>>> +	struct adis adis;
>>>> +	u32 clk_freq;
>>>> +	u32 cached_spi_speed_hz;
>>>> +	bool burst32;
>>>> +};
>>>> +
>>>> +enum {
>>>> +	ADIS16475_SCAN_GYRO_X,
>>>> +	ADIS16475_SCAN_GYRO_Y,
>>>> +	ADIS16475_SCAN_GYRO_Z,
>>>> +	ADIS16475_SCAN_ACCEL_X,
>>>> +	ADIS16475_SCAN_ACCEL_Y,
>>>> +	ADIS16475_SCAN_ACCEL_Z,
>>>> +	ADIS16475_SCAN_TEMP,
>>>> +	ADIS16475_SCAN_DIAG_S_FLAGS,
>>>> +	ADIS16475_SCAN_CRC_FAILURE,
>>>> +};
>>>> +
>>>> +#ifdef CONFIG_DEBUG_FS
>>>> +static ssize_t adis16475_show_firmware_revision(struct file
>>>> *file,
>>>> +						char __user *userbuf,
>>>> +						size_t count, loff_t
>>>> *ppos)
>>>> +{
>>>> +	struct adis16475 *st = file->private_data;
>>>> +	char buf[7];
>>>> +	size_t len;
>>>> +	u16 rev;
>>>> +	int ret;
>>>> +
>>>> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_REV,
>>>> &rev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev &
>>>> 0xff);
>>>> +
>>>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
>>>> +}
>>>> +
>>>> +static const struct file_operations
>>>> adis16475_firmware_revision_fops = {
>>>> +	.open = simple_open,
>>>> +	.read = adis16475_show_firmware_revision,
>>>> +	.llseek = default_llseek,
>>>> +	.owner = THIS_MODULE,
>>>> +};
>>>> +
>>>> +static ssize_t adis16475_show_firmware_date(struct file *file,
>>>> +					    char __user *userbuf,
>>>> +					    size_t count, loff_t *ppos)
>>>> +{
>>>> +	struct adis16475 *st = file->private_data;
>>>> +	u16 md, year;
>>>> +	char buf[12];
>>>> +	size_t len;
>>>> +	int ret;
>>>> +
>>>> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_Y, &year);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_DM, &md);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", md >> 8,
>>>> md & 0xff,
>>>> +		       year);
>>>> +
>>>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
>>>> +}
>>>> +
>>>> +static const struct file_operations adis16475_firmware_date_fops
>>>> =
>>>> {
>>>> +	.open = simple_open,
>>>> +	.read = adis16475_show_firmware_date,
>>>> +	.llseek = default_llseek,
>>>> +	.owner = THIS_MODULE,
>>>> +};
>>>> +
>>>> +static int adis16475_show_serial_number(void *arg, u64 *val)
>>>> +{
>>>> +	struct adis16475 *st = arg;
>>>> +	u16 serial;
>>>> +	int ret;
>>>> +
>>>> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_SERIAL_NUM,
>>>> &serial);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	*val = serial;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_serial_number_fops,
>>>> +			adis16475_show_serial_number, NULL,
>>>> "0x%.4llx\n");
>>>> +
>>>> +static int adis16475_show_product_id(void *arg, u64 *val)
>>>> +{
>>>> +	struct adis16475 *st = arg;
>>>> +	u16 prod_id;
>>>> +	int ret;
>>>> +
>>>> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_PROD_ID,
>>>> &prod_id);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	*val = prod_id;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_product_id_fops,
>>>> +			adis16475_show_product_id, NULL, "%llu\n");
>>>> +
>>>> +static int adis16475_show_flash_count(void *arg, u64 *val)
>>>> +{
>>>> +	struct adis16475 *st = arg;
>>>> +	u32 flash_count;
>>>> +	int ret;
>>>> +
>>>> +	ret = adis_read_reg_32(&st->adis, ADIS16475_REG_FLASH_CNT,
>>>> +			       &flash_count);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	*val = flash_count;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_flash_count_fops,
>>>> +			adis16475_show_flash_count, NULL, "%lld\n");
>>>> +
>>>> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
>>>> +{
>>>> +	struct adis16475 *st = iio_priv(indio_dev);
>>>> +
>>>> +	debugfs_create_file("serial_number", 0400, indio_dev-
>>>>> debugfs_dentry,
>>>> +			    st, &adis16475_serial_number_fops);
>>>> +	debugfs_create_file("product_id", 0400, indio_dev-
>>>>> debugfs_dentry, st,
>>>> +			    &adis16475_product_id_fops);
>>>> +	debugfs_create_file("flash_count", 0400, indio_dev-
>>>>> debugfs_dentry, st,
>>>> +			    &adis16475_flash_count_fops);
>>>> +	debugfs_create_file("firmware_revision", 0400,
>>>> +			    indio_dev->debugfs_dentry, st,
>>>> +			    &adis16475_firmware_revision_fops);
>>>> +	debugfs_create_file("firmware_date", 0400, indio_dev-
>>>>> debugfs_dentry,
>>>> +			    st, &adis16475_firmware_date_fops);
>>>> +	return 0;
>>>> +}
>>>> +#else
>>>> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +#endif
>>>> +
>>>> +static ssize_t adis16475_burst_mode_enable_get(struct device
>>>> *dev,
>>>> +					       struct device_attribute
>>>> *attr,
>>>> +					       char *buf)
>>>> +{
>>>> +	struct adis16475 *st = iio_priv(dev_to_iio_dev(dev));
>>>> +
>>>> +	return sprintf(buf, "%d\n", st->adis.burst->en);
>>>> +}
>>>> +
>>>> +static ssize_t adis16475_burst_mode_enable_set(struct device
>>>> *dev,
>>>> +					       struct device_attribute
>>>> *attr,
>>>> +					       const char *buf, size_t
>>>> len)
>>>> +{
>>>> +	struct adis16475 *st = iio_priv(dev_to_iio_dev(dev));
>>>> +	bool val;
>>>> +	int ret;
>>>> +
>>>> +	ret = kstrtobool(buf, &val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (val)
>>>> +		/* 1MHz max in burst mode */
>>>> +		st->adis.spi->max_speed_hz = 1000000;
>>>> +	else
>>>> +		st->adis.spi->max_speed_hz = st->cached_spi_speed_hz;
>>>> +
>>>> +	st->adis.burst->en = val;
>>>> +
>>>> +	return len;
>>>> +}
>>>> +
>>>> +static IIO_DEVICE_ATTR(burst_mode_enable, 0644,
>>>> +		       adis16475_burst_mode_enable_get,
>>>> +		       adis16475_burst_mode_enable_set, 0);
>>>> +
>>>> +static struct attribute *adis16475_attributes[] = {
>>>> +	&iio_dev_attr_burst_mode_enable.dev_attr.attr,
>>> Hmm.  Normally we try to avoid exposing this and make the decision
>>> automatically based on which channels are enabled.
>> Hmm. In that case, the decision would probably have to go to the
>> library since it is there that the "preparations" for buffered mode
>> are
>> done. Mostly, the data we are interested in the burst data is gyro,
>> accel and temp. So to make the decision based on which channels are
>> enabled is not that straight. Should we enable it only when all
>> channels are enabled? Some of them (and which)?
> I thought a little bit more about it and we could do some math in the
> lib to know when using burst mode becomes faster (depending on enabled
> scan elements). The library would need to know about the burst max spi
> frequency and also some minor changes in how burst_len is being
> calculated (drivers should explicitly set this rather than the
> library). The question is, is it worth it to go with this extra work
> :)?

You can leave it out of the initial version and always use burst mode 
and then add support for this in a follow up patch if it is worth it.

- Lars

