Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023191A6424
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgDMIZl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 04:25:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1230 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbgDMIZ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 04:25:28 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D8P4m7029352;
        Mon, 13 Apr 2020 04:25:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30b7r5xpra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 04:25:04 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03D8P3To002508
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 13 Apr 2020 04:25:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Apr
 2020 04:25:02 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Apr 2020 04:25:02 -0400
Received: from NSA-L01.ad.analog.com (nsa-l01.ad.analog.com [10.32.224.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03D8Om3x026405;
        Mon, 13 Apr 2020 04:24:59 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v5 5/6] iio: imu: Add support for adis16475
Date:   Mon, 13 Apr 2020 10:24:44 +0200
Message-ID: <20200413082445.17324-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413082445.17324-1-nuno.sa@analog.com>
References: <20200413082445.17324-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_02:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130075
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support ADIS16475 and similar IMU devices. These devices are
a precision, miniature MEMS inertial measurement unit (IMU) that
includes a triaxial gyroscope and a triaxial accelerometer. Each
inertial sensor combines with signal conditioning that optimizes
dynamic performance.

The driver adds support for the following devices:
* adis16470, adis16475, adis16477, adis16465, adis16467, adis16500,
  adis16505, adis16507.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Remove burst mode config (enabled by default);
 * Fix timestamp channel index;
 * Do return code checks inline in `adis16475_read_raw`;
 * Increase buffer size to fit aligned timestamp;
 * Remove spi_device_id table;
 * Rename `adis16475_clks` to `adis16475_sync`;
 * Rename `adis16475_config_ext_clk` `adis16475_config_sync_mode`;
 * Fix output-sync mode. There's no need to call clk_get in this mode as
it acts as an output pin;
 * Fix scaled-mode configuration. Up scale was not being written on the right register;
 * Handle burst32 configuration at runtime. When the decimation or the FIR filter is enabled
the LSB bits are meangninfull. Hence, use burst32 in that case (if the part supports it);
 * When there's no burst32 mode and the LSB data is meangninfull, read it manually...
 * Do not push data to buffers if crc is invalid.

Changes in V3:
 * Fix multiple instance devices for different burst sizes;
 * Only return error if `freq` is 0 on `adis16475_set_freq``;
 * Fixed typo in comment;
 * Do not allow 7 to be set in `adis16475_set_filter`;
 * Change `adis16475_validate_crc` return type to bool;
 * Return 1 if crc is valid instead of 0.

Changes in v4:
 * Remove unused file from MAINTAINERS;
 * Remove `<asm/unaligned.h>`;
 * Use `irq_flag` - Changed in 2 patch;
 * Use DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe;
 * No need to return in `adis16475_debugfs_init`;
 * Drop parentheses in (crc == 0);
 * Remove unnecessary casts;
 * Directly pass `data` to `iio_push_to_buffers_with_timestamp`;
 * Remove all get_unaligned calls;
 * Better indent macros with inside macros;
 * Use `assign_bit()`;
 * Drop `ret < 0` checks;
 * Use `device_get_match_data()`;
 * Replace `linux/of_device.h` by `<linux/mod_devicetable.h>`and `<linux/property.h>`;
 * Remove invalid index in `adis16475_3db_freqs`;
 * Make the loop in `adis16475_set_filter` more readable.

Changes in v5:
 * Added braces in while expression;
 * Removed extra blank line;
 * Add missing blank lines;
 * Removed redundant parentheses;
 * Use the correct irq type defines after `irqd_get_trigger_type`;
 * Explictly assign irq_flags even when IRQ_TYPE_EDGE_RISING;
 * Check return value of `device_property_read_u32` when checking adi,scaled-output-hz.

 MAINTAINERS                 |    7 +
 drivers/iio/imu/Kconfig     |   13 +
 drivers/iio/imu/Makefile    |    1 +
 drivers/iio/imu/adis16475.c | 1339 +++++++++++++++++++++++++++++++++++
 4 files changed, 1360 insertions(+)
 create mode 100644 drivers/iio/imu/adis16475.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8687cc5397c8..a2ff8322c184 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1009,6 +1009,13 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
+ANALOG DEVICES INC ADIS16475 DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/imu/adis16475.c
+
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Beniamin Bia <beniamin.bia@analog.com>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 60bb1029e759..fc4123d518bc 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -29,6 +29,19 @@ config ADIS16460
 	  To compile this driver as a module, choose M here: the module will be
 	  called adis16460.
 
+config ADIS16475
+	tristate "Analog Devices ADIS16475 and similar IMU driver"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices ADIS16470, ADIS16475,
+	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505, ADIS16507 inertial
+	  sensors.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adis16475.
+
 config ADIS16480
 	tristate "Analog Devices ADIS16480 and similar IMU driver"
 	depends on SPI
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 5237fd4bc384..88b2c4555230 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16400) += adis16400.o
 obj-$(CONFIG_ADIS16460) += adis16460.o
+obj-$(CONFIG_ADIS16475) += adis16475.o
 obj-$(CONFIG_ADIS16480) += adis16480.o
 
 adis_lib-y += adis.o
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
new file mode 100644
index 000000000000..e2bd4214eaeb
--- /dev/null
+++ b/drivers/iio/imu/adis16475.c
@@ -0,0 +1,1339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADIS16475 IMU driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/imu/adis.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#define ADIS16475_REG_DIAG_STAT		0x02
+#define ADIS16475_REG_X_GYRO_L		0x04
+#define ADIS16475_REG_Y_GYRO_L		0x08
+#define ADIS16475_REG_Z_GYRO_L		0x0C
+#define ADIS16475_REG_X_ACCEL_L		0x10
+#define ADIS16475_REG_Y_ACCEL_L		0x14
+#define ADIS16475_REG_Z_ACCEL_L		0x18
+#define ADIS16475_REG_TEMP_OUT		0x1c
+#define ADIS16475_REG_X_GYRO_BIAS_L	0x40
+#define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
+#define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
+#define ADIS16475_REG_X_ACCEL_BIAS_L	0x4c
+#define ADIS16475_REG_Y_ACCEL_BIAS_L	0x50
+#define ADIS16475_REG_Z_ACCEL_BIAS_L	0x54
+#define ADIS16475_REG_FILT_CTRL		0x5c
+#define ADIS16475_FILT_CTRL_MASK	GENMASK(2, 0)
+#define ADIS16475_FILT_CTRL(x)		FIELD_PREP(ADIS16475_FILT_CTRL_MASK, x)
+#define ADIS16475_REG_MSG_CTRL		0x60
+#define ADIS16475_MSG_CTRL_DR_POL_MASK	BIT(0)
+#define ADIS16475_MSG_CTRL_DR_POL(x) \
+				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MASK, x)
+#define ADIS16475_SYNC_MODE_MASK	GENMASK(4, 2)
+#define ADIS16475_SYNC_MODE(x)		FIELD_PREP(ADIS16475_SYNC_MODE_MASK, x)
+#define ADIS16475_REG_UP_SCALE		0x62
+#define ADIS16475_REG_DEC_RATE		0x64
+#define ADIS16475_REG_GLOB_CMD		0x68
+#define ADIS16475_REG_FIRM_REV		0x6c
+#define ADIS16475_REG_FIRM_DM		0x6e
+#define ADIS16475_REG_FIRM_Y		0x70
+#define ADIS16475_REG_PROD_ID		0x72
+#define ADIS16475_REG_SERIAL_NUM	0x74
+#define ADIS16475_REG_FLASH_CNT		0x7c
+#define ADIS16500_BURST32_MASK		BIT(9)
+#define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
+/* number of data elements in burst mode */
+#define ADIS16475_BURST32_MAX_DATA	32
+#define ADIS16475_BURST_MAX_DATA	20
+#define ADIS16475_MAX_SCAN_DATA		20
+/* spi max speed in brust mode */
+#define ADIS16475_BURST_MAX_SPEED	1000000
+#define ADIS16475_LSB_DEC_MASK		BIT(0)
+#define ADIS16475_LSB_FIR_MASK		BIT(1)
+
+enum {
+	ADIS16475_SYNC_DIRECT = 1,
+	ADIS16475_SYNC_SCALED,
+	ADIS16475_SYNC_OUTPUT,
+	ADIS16475_SYNC_PULSE = 5,
+};
+
+struct adis16475_sync {
+	u16 sync_mode;
+	u16 min_rate;
+	u16 max_rate;
+};
+
+struct adis16475_chip_info {
+	const struct iio_chan_spec *channels;
+	const struct adis16475_sync *sync;
+	const struct adis_data adis_data;
+	const char *name;
+	u32 num_channels;
+	u32 gyro_max_val;
+	u32 gyro_max_scale;
+	u32 accel_max_val;
+	u32 accel_max_scale;
+	u32 temp_scale;
+	u32 int_clk;
+	u16 max_dec;
+	u8 num_sync;
+	bool has_burst32;
+};
+
+struct adis16475 {
+	const struct adis16475_chip_info *info;
+	struct adis adis;
+	u32 clk_freq;
+	bool burst32;
+	unsigned long lsb_flag;
+};
+
+enum {
+	ADIS16475_SCAN_GYRO_X,
+	ADIS16475_SCAN_GYRO_Y,
+	ADIS16475_SCAN_GYRO_Z,
+	ADIS16475_SCAN_ACCEL_X,
+	ADIS16475_SCAN_ACCEL_Y,
+	ADIS16475_SCAN_ACCEL_Z,
+	ADIS16475_SCAN_TEMP,
+	ADIS16475_SCAN_DIAG_S_FLAGS,
+	ADIS16475_SCAN_CRC_FAILURE,
+};
+
+#ifdef CONFIG_DEBUG_FS
+static ssize_t adis16475_show_firmware_revision(struct file *file,
+						char __user *userbuf,
+						size_t count, loff_t *ppos)
+{
+	struct adis16475 *st = file->private_data;
+	char buf[7];
+	size_t len;
+	u16 rev;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_REV, &rev);
+	if (ret)
+		return ret;
+
+	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static const struct file_operations adis16475_firmware_revision_fops = {
+	.open = simple_open,
+	.read = adis16475_show_firmware_revision,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t adis16475_show_firmware_date(struct file *file,
+					    char __user *userbuf,
+					    size_t count, loff_t *ppos)
+{
+	struct adis16475 *st = file->private_data;
+	u16 md, year;
+	char buf[12];
+	size_t len;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_Y, &year);
+	if (ret)
+		return ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIRM_DM, &md);
+	if (ret)
+		return ret;
+
+	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", md >> 8, md & 0xff,
+		       year);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static const struct file_operations adis16475_firmware_date_fops = {
+	.open = simple_open,
+	.read = adis16475_show_firmware_date,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
+static int adis16475_show_serial_number(void *arg, u64 *val)
+{
+	struct adis16475 *st = arg;
+	u16 serial;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_SERIAL_NUM, &serial);
+	if (ret)
+		return ret;
+
+	*val = serial;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(adis16475_serial_number_fops,
+			 adis16475_show_serial_number, NULL, "0x%.4llx\n");
+
+static int adis16475_show_product_id(void *arg, u64 *val)
+{
+	struct adis16475 *st = arg;
+	u16 prod_id;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_PROD_ID, &prod_id);
+	if (ret)
+		return ret;
+
+	*val = prod_id;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(adis16475_product_id_fops,
+			 adis16475_show_product_id, NULL, "%llu\n");
+
+static int adis16475_show_flash_count(void *arg, u64 *val)
+{
+	struct adis16475 *st = arg;
+	u32 flash_count;
+	int ret;
+
+	ret = adis_read_reg_32(&st->adis, ADIS16475_REG_FLASH_CNT,
+			       &flash_count);
+	if (ret)
+		return ret;
+
+	*val = flash_count;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(adis16475_flash_count_fops,
+			 adis16475_show_flash_count, NULL, "%lld\n");
+
+static void adis16475_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	debugfs_create_file_unsafe("serial_number", 0400,
+				   indio_dev->debugfs_dentry, st,
+				   &adis16475_serial_number_fops);
+	debugfs_create_file_unsafe("product_id", 0400,
+				   indio_dev->debugfs_dentry, st,
+				   &adis16475_product_id_fops);
+	debugfs_create_file_unsafe("flash_count", 0400,
+				   indio_dev->debugfs_dentry, st,
+				   &adis16475_flash_count_fops);
+	debugfs_create_file("firmware_revision", 0400,
+			    indio_dev->debugfs_dentry, st,
+			    &adis16475_firmware_revision_fops);
+	debugfs_create_file("firmware_date", 0400, indio_dev->debugfs_dentry,
+			    st, &adis16475_firmware_date_fops);
+}
+#else
+static void adis16475_debugfs_init(struct iio_dev *indio_dev)
+{
+}
+#endif
+
+static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
+{
+	int ret;
+	u16 dec;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, &dec);
+	if (ret)
+		return -EINVAL;
+
+	*freq = DIV_ROUND_CLOSEST(st->clk_freq, dec + 1);
+
+	return 0;
+}
+
+static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
+{
+	u16 dec;
+	int ret;
+
+	if (!freq)
+		return -EINVAL;
+
+	dec = DIV_ROUND_CLOSEST(st->clk_freq, freq);
+
+	if (dec)
+		dec--;
+
+	if (dec > st->info->max_dec)
+		dec = st->info->max_dec;
+
+	ret = adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
+	if (ret)
+		return ret;
+
+	/*
+	 * If decimation is used, then gyro and accel data will have meaningful
+	 * bits on the LSB registers. This info is used on the trigger handler.
+	 */
+	assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
+
+	return 0;
+}
+
+/* The values are approximated. */
+static const u32 adis16475_3db_freqs[] = {
+	[0] = 720, /* Filter disabled, full BW (~720Hz) */
+	[1] = 360,
+	[2] = 164,
+	[3] = 80,
+	[4] = 40,
+	[5] = 20,
+	[6] = 10,
+};
+
+static int adis16475_get_filter(struct adis16475 *st, u32 *filter)
+{
+	u16 filter_sz;
+	int ret;
+	const int mask = ADIS16475_FILT_CTRL_MASK;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FILT_CTRL, &filter_sz);
+	if (ret)
+		return ret;
+
+	*filter = adis16475_3db_freqs[filter_sz & mask];
+
+	return 0;
+}
+
+static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
+{
+	int i = ARRAY_SIZE(adis16475_3db_freqs);
+	int ret;
+
+	while (--i) {
+		if (adis16475_3db_freqs[i] >= filter)
+			break;
+	}
+
+	ret = adis_write_reg_16(&st->adis, ADIS16475_REG_FILT_CTRL,
+				ADIS16475_FILT_CTRL(i));
+	if (ret)
+		return ret;
+
+	/*
+	 * If FIR is used, then gyro and accel data will have meaningful
+	 * bits on the LSB registers. This info is used on the trigger handler.
+	 */
+	assign_bit(ADIS16475_LSB_FIR_MASK, &st->lsb_flag, i);
+
+	return 0;
+}
+
+static const u32 adis16475_calib_regs[] = {
+	[ADIS16475_SCAN_GYRO_X] = ADIS16475_REG_X_GYRO_BIAS_L,
+	[ADIS16475_SCAN_GYRO_Y] = ADIS16475_REG_Y_GYRO_BIAS_L,
+	[ADIS16475_SCAN_GYRO_Z] = ADIS16475_REG_Z_GYRO_BIAS_L,
+	[ADIS16475_SCAN_ACCEL_X] = ADIS16475_REG_X_ACCEL_BIAS_L,
+	[ADIS16475_SCAN_ACCEL_Y] = ADIS16475_REG_Y_ACCEL_BIAS_L,
+	[ADIS16475_SCAN_ACCEL_Z] = ADIS16475_REG_Z_ACCEL_BIAS_L,
+};
+
+static int adis16475_read_raw(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      int *val, int *val2, long info)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+	int ret;
+	u32 tmp;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return adis_single_conversion(indio_dev, chan, 0, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = st->info->gyro_max_val;
+			*val2 = st->info->gyro_max_scale;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_ACCEL:
+			*val = st->info->accel_max_val;
+			*val2 = st->info->accel_max_scale;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			*val = st->info->temp_scale;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = adis_read_reg_32(&st->adis,
+				       adis16475_calib_regs[chan->scan_index],
+				       val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = adis16475_get_filter(st, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = adis16475_get_freq(st, &tmp);
+		if (ret)
+			return ret;
+
+		*val = tmp / 1000;
+		*val2 = (tmp % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adis16475_write_raw(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       int val, int val2, long info)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+	u32 tmp;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		tmp = val * 1000 + val2 / 1000;
+		return adis16475_set_freq(st, tmp);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return adis16475_set_filter(st, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return adis_write_reg_32(&st->adis,
+					 adis16475_calib_regs[chan->scan_index],
+					 val);
+	default:
+		return -EINVAL;
+	}
+}
+
+#define ADIS16475_MOD_CHAN(_type, _mod, _address, _si, _r_bits, _s_bits) \
+	{ \
+		.type = (_type), \
+		.modified = 1, \
+		.channel2 = (_mod), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_CALIBBIAS), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+		.address = (_address), \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = (_r_bits), \
+			.storagebits = (_s_bits), \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16475_GYRO_CHANNEL(_mod) \
+	ADIS16475_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _GYRO_L, \
+			   ADIS16475_SCAN_GYRO_ ## _mod, 32, 32)
+
+#define ADIS16475_ACCEL_CHANNEL(_mod) \
+	ADIS16475_MOD_CHAN(IIO_ACCEL, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _ACCEL_L, \
+			   ADIS16475_SCAN_ACCEL_ ## _mod, 32, 32)
+
+#define ADIS16475_TEMP_CHANNEL() { \
+		.type = IIO_TEMP, \
+		.indexed = 1, \
+		.channel = 0, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+		.address = ADIS16475_REG_TEMP_OUT, \
+		.scan_index = ADIS16475_SCAN_TEMP, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = 16, \
+			.storagebits = 16, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+static const struct iio_chan_spec adis16475_channels[] = {
+	ADIS16475_GYRO_CHANNEL(X),
+	ADIS16475_GYRO_CHANNEL(Y),
+	ADIS16475_GYRO_CHANNEL(Z),
+	ADIS16475_ACCEL_CHANNEL(X),
+	ADIS16475_ACCEL_CHANNEL(Y),
+	ADIS16475_ACCEL_CHANNEL(Z),
+	ADIS16475_TEMP_CHANNEL(),
+	IIO_CHAN_SOFT_TIMESTAMP(7)
+};
+
+enum adis16475_variant {
+	ADIS16470,
+	ADIS16475_1,
+	ADIS16475_2,
+	ADIS16475_3,
+	ADIS16477_1,
+	ADIS16477_2,
+	ADIS16477_3,
+	ADIS16465_1,
+	ADIS16465_2,
+	ADIS16465_3,
+	ADIS16467_1,
+	ADIS16467_2,
+	ADIS16467_3,
+	ADIS16500,
+	ADIS16505_1,
+	ADIS16505_2,
+	ADIS16505_3,
+	ADIS16507_1,
+	ADIS16507_2,
+	ADIS16507_3,
+};
+
+enum {
+	ADIS16475_DIAG_STAT_DATA_PATH = 1,
+	ADIS16475_DIAG_STAT_FLASH_MEM,
+	ADIS16475_DIAG_STAT_SPI,
+	ADIS16475_DIAG_STAT_STANDBY,
+	ADIS16475_DIAG_STAT_SENSOR,
+	ADIS16475_DIAG_STAT_MEMORY,
+	ADIS16475_DIAG_STAT_CLK,
+};
+
+static const char * const adis16475_status_error_msgs[] = {
+	[ADIS16475_DIAG_STAT_DATA_PATH] = "Data Path Overrun",
+	[ADIS16475_DIAG_STAT_FLASH_MEM] = "Flash memory update failure",
+	[ADIS16475_DIAG_STAT_SPI] = "SPI communication error",
+	[ADIS16475_DIAG_STAT_STANDBY] = "Standby mode",
+	[ADIS16475_DIAG_STAT_SENSOR] = "Sensor failure",
+	[ADIS16475_DIAG_STAT_MEMORY] = "Memory failure",
+	[ADIS16475_DIAG_STAT_CLK] = "Clock error",
+};
+
+static int adis16475_enable_irq(struct adis *adis, bool enable)
+{
+	/*
+	 * There is no way to gate the data-ready signal internally inside the
+	 * ADIS16475. We can only control it's polarity...
+	 */
+	if (enable)
+		enable_irq(adis->spi->irq);
+	else
+		disable_irq(adis->spi->irq);
+
+	return 0;
+}
+
+#define ADIS16475_DATA(_prod_id, _timeouts)				\
+{									\
+	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,				\
+	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,				\
+	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,			\
+	.prod_id_reg = ADIS16475_REG_PROD_ID,				\
+	.prod_id = (_prod_id),						\
+	.self_test_mask = BIT(2),					\
+	.self_test_reg = ADIS16475_REG_GLOB_CMD,			\
+	.cs_change_delay = 16,						\
+	.read_delay = 5,						\
+	.write_delay = 5,						\
+	.status_error_msgs = adis16475_status_error_msgs,		\
+	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |	\
+		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |			\
+		BIT(ADIS16475_DIAG_STAT_SPI) |				\
+		BIT(ADIS16475_DIAG_STAT_STANDBY) |			\
+		BIT(ADIS16475_DIAG_STAT_SENSOR) |			\
+		BIT(ADIS16475_DIAG_STAT_MEMORY) |			\
+		BIT(ADIS16475_DIAG_STAT_CLK),				\
+	.enable_irq = adis16475_enable_irq,				\
+	.timeouts = (_timeouts),					\
+}
+
+static const struct adis16475_sync adis16475_sync_mode[] = {
+	{ ADIS16475_SYNC_OUTPUT },
+	{ ADIS16475_SYNC_DIRECT, 1900, 2100 },
+	{ ADIS16475_SYNC_SCALED, 1, 128 },
+	{ ADIS16475_SYNC_PULSE, 1000, 2100 },
+};
+
+static const struct adis_timeout adis16475_timeouts = {
+	.reset_ms = 200,
+	.sw_reset_ms = 200,
+	.self_test_ms = 20,
+};
+
+static const struct adis_timeout adis1650x_timeouts = {
+	.reset_ms = 260,
+	.sw_reset_ms = 260,
+	.self_test_ms = 30,
+};
+
+static const struct adis16475_chip_info adis16475_chip_info[] = {
+	[ADIS16470] = {
+		.name = "adis16470",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts),
+	},
+	[ADIS16475_1] = {
+		.name = "adis16475-1",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+	},
+	[ADIS16475_2] = {
+		.name = "adis16475-2",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+	},
+	[ADIS16475_3] = {
+		.name = "adis16475-3",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+	},
+	[ADIS16477_1] = {
+		.name = "adis16477-1",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+	},
+	[ADIS16477_2] = {
+		.name = "adis16477-2",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+	},
+	[ADIS16477_3] = {
+		.name = "adis16477-3",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+	},
+	[ADIS16465_1] = {
+		.name = "adis16465-1",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+	},
+	[ADIS16465_2] = {
+		.name = "adis16465-2",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+	},
+	[ADIS16465_3] = {
+		.name = "adis16465-3",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+	},
+	[ADIS16467_1] = {
+		.name = "adis16467-1",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+	},
+	[ADIS16467_2] = {
+		.name = "adis16467-2",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+	},
+	[ADIS16467_3] = {
+		.name = "adis16467-3",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+	},
+	[ADIS16500] = {
+		.name = "adis16500",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 392,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
+	},
+	[ADIS16505_1] = {
+		.name = "adis16505-1",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
+		.accel_max_val = 78,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+	},
+	[ADIS16505_2] = {
+		.name = "adis16505-2",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 78,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+	},
+	[ADIS16505_3] = {
+		.name = "adis16505-3",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 78,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+	},
+	[ADIS16507_1] = {
+		.name = "adis16507-1",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
+		.accel_max_val = 392,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+	},
+	[ADIS16507_2] = {
+		.name = "adis16507-2",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 392,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+	},
+	[ADIS16507_3] = {
+		.name = "adis16507-3",
+		.num_channels = ARRAY_SIZE(adis16475_channels),
+		.channels = adis16475_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 392,
+		.accel_max_scale = 32000 << 16,
+		.temp_scale = 100,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.has_burst32 = true,
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+	},
+};
+
+static const struct iio_info adis16475_info = {
+	.read_raw = &adis16475_read_raw,
+	.write_raw = &adis16475_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
+};
+
+static struct adis_burst adis16475_burst = {
+	.en = true,
+	.reg_cmd = ADIS16475_REG_GLOB_CMD,
+	/*
+	 * adis_update_scan_mode_burst() sets the burst length in respect with
+	 * the number of channels and allocates 16 bits for each. However,
+	 * adis1647x devices also need space for DIAG_STAT, DATA_CNTR or
+	 * TIME_STAMP (depending on the clock mode but for us these bytes are
+	 * don't care...) and CRC.
+	 */
+	.extra_len = 3 * sizeof(u16),
+	.burst_max_len = ADIS16475_BURST32_MAX_DATA,
+};
+
+static bool adis16475_validate_crc(const u8 *buffer, u16 crc,
+				   const bool burst32)
+{
+	int i;
+	/* extra 6 elements for low gyro and accel */
+	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA :
+		ADIS16475_BURST_MAX_DATA;
+
+	for (i = 0; i < sz - 2; i++)
+		crc -= buffer[i];
+
+	return crc == 0;
+}
+
+static void adis16475_burst32_check(struct adis16475 *st)
+{
+	int ret;
+	struct adis *adis = &st->adis;
+
+	if (!st->info->has_burst32)
+		return;
+
+	if (st->lsb_flag && !st->burst32) {
+		const u16 en = ADIS16500_BURST32(1);
+
+		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+					 ADIS16500_BURST32_MASK, en);
+		if (ret)
+			return;
+
+		st->burst32 = true;
+
+		/*
+		 * In 32-bit mode we need extra 2 bytes for all gyro
+		 * and accel channels.
+		 */
+		adis->burst_extra_len = 6 * sizeof(u16);
+		adis->xfer[1].len += 6 * sizeof(u16);
+		dev_dbg(&adis->spi->dev, "Enable burst32 mode, xfer:%d",
+			adis->xfer[1].len);
+
+	} else if (!st->lsb_flag && st->burst32) {
+		const u16 en = ADIS16500_BURST32(0);
+
+		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+					 ADIS16500_BURST32_MASK, en);
+		if (ret)
+			return;
+
+		st->burst32 = false;
+
+		/* Remove the extra bits */
+		adis->burst_extra_len = 0;
+		adis->xfer[1].len -= 6 * sizeof(u16);
+		dev_dbg(&adis->spi->dev, "Disable burst32 mode, xfer:%d\n",
+			adis->xfer[1].len);
+	}
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret, bit, i = 0;
+	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
+	u16 crc;
+	bool valid;
+	/* offset until the first element after gyro and accel */
+	const u8 offset = st->burst32 ? 13 : 7;
+	const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
+
+	adis->spi->max_speed_hz = ADIS16475_BURST_MAX_SPEED;
+
+	ret = spi_sync(adis->spi, &adis->msg);
+	if (ret)
+		return ret;
+
+	adis->spi->max_speed_hz = cached_spi_speed_hz;
+	buffer = adis->buffer;
+
+	crc = be16_to_cpu(buffer[offset + 2]);
+	valid = adis16475_validate_crc(adis->buffer, crc, st->burst32);
+	if (!valid) {
+		dev_err(&adis->spi->dev, "Invalid crc\n");
+		goto check_burst32;
+	}
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		/*
+		 * When burst mode is used, system flags is the first data
+		 * channel in the sequence, but the scan index is 7.
+		 */
+		switch (bit) {
+		case ADIS16475_SCAN_TEMP:
+			data[i++] = buffer[offset];
+			break;
+		case ADIS16475_SCAN_GYRO_X ... ADIS16475_SCAN_ACCEL_Z:
+			/*
+			 * The first 2 bytes on the received data are the
+			 * DIAG_STAT reg, hence the +1 offset here...
+			 */
+			if (st->burst32) {
+				/* upper 16 */
+				data[i++] = buffer[bit * 2 + 2];
+				/* lower 16 */
+				data[i++] = buffer[bit * 2 + 1];
+			} else {
+				data[i++] = buffer[bit + 1];
+				/*
+				 * Don't bother in doing the manual read if the
+				 * device supports burst32. burst32 will be
+				 * enabled in the next call to
+				 * adis16475_burst32_check()...
+				 */
+				if (st->lsb_flag && !st->info->has_burst32) {
+					u16 val = 0;
+					const u32 reg = ADIS16475_REG_X_GYRO_L +
+						bit * 4;
+
+					adis_read_reg_16(adis, reg, &val);
+					data[i++] = cpu_to_be16(val);
+				} else {
+					/* lower not used */
+					data[i++] = 0;
+				}
+			}
+			break;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+check_burst32:
+	/*
+	 * We only check the burst mode at the end of the current capture since
+	 * it takes a full data ready cycle for the device to update the burst
+	 * array.
+	 */
+	adis16475_burst32_check(st);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static void adis16475_disable_clk(void *data)
+{
+	clk_disable_unprepare((struct clk *)data);
+}
+
+static int adis16475_config_sync_mode(struct adis16475 *st)
+{
+	int ret;
+	struct device *dev = &st->adis.spi->dev;
+	const struct adis16475_sync *sync;
+	u32 sync_mode;
+
+	/* default to internal clk */
+	st->clk_freq = st->info->int_clk * 1000;
+
+	ret = device_property_read_u32(dev, "adi,sync-mode", &sync_mode);
+	if (ret)
+		return 0;
+
+	if (sync_mode >= st->info->num_sync) {
+		dev_err(dev, "Invalid sync mode: %u for %s\n", sync_mode,
+			st->info->name);
+		return -EINVAL;
+	}
+
+	sync = &st->info->sync[sync_mode];
+
+	/* All the other modes require external input signal */
+	if (sync->sync_mode != ADIS16475_SYNC_OUTPUT) {
+		struct clk *clk = devm_clk_get(dev, NULL);
+
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, adis16475_disable_clk, clk);
+		if (ret)
+			return ret;
+
+		st->clk_freq = clk_get_rate(clk);
+		if (st->clk_freq < sync->min_rate ||
+		    st->clk_freq > sync->max_rate) {
+			dev_err(dev,
+				"Clk rate:%u not in a valid range:[%u %u]\n",
+				st->clk_freq, sync->min_rate, sync->max_rate);
+			return -EINVAL;
+		}
+
+		if (sync->sync_mode == ADIS16475_SYNC_SCALED) {
+			u16 up_scale;
+			u32 scaled_out_freq = 0;
+			/*
+			 * If we are in scaled mode, we must have an up_scale.
+			 * In scaled mode the allowable input clock range is
+			 * 1 Hz to 128 Hz, and the allowable output range is
+			 * 1900 to 2100 Hz. Hence, a scale must be given to
+			 * get the allowable output.
+			 */
+			ret = device_property_read_u32(dev,
+						       "adi,scaled-output-hz",
+						       &scaled_out_freq);
+			if (ret) {
+				dev_err(dev, "adi,scaled-output-hz must be given when in scaled sync mode");
+				return -EINVAL;
+			} else if (scaled_out_freq < 1900 ||
+				   scaled_out_freq > 2100) {
+				dev_err(dev, "Invalid value: %u for adi,scaled-output-hz",
+					scaled_out_freq);
+				return -EINVAL;
+			}
+
+			up_scale = DIV_ROUND_CLOSEST(scaled_out_freq,
+						     st->clk_freq);
+
+			ret = __adis_write_reg_16(&st->adis,
+						  ADIS16475_REG_UP_SCALE,
+						  up_scale);
+			if (ret)
+				return ret;
+
+			st->clk_freq = scaled_out_freq;
+		}
+
+		st->clk_freq *= 1000;
+	}
+	/*
+	 * Keep in mind that the mask for the clk modes in adis1650*
+	 * chips is different (1100 instead of 11100). However, we
+	 * are not configuring BIT(4) in these chips and the default
+	 * value is 0, so we are fine in doing the below operations.
+	 * I'm keeping this for simplicity and avoiding extra variables
+	 * in chip_info.
+	 */
+	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
+	if (ret)
+		return ret;
+
+	usleep_range(250, 260);
+
+	return 0;
+}
+
+static int adis16475_config_irq_pin(struct adis16475 *st)
+{
+	int ret;
+	struct irq_data *desc;
+	u32 irq_type;
+	u16 val = 0;
+	u8 polarity;
+	struct spi_device *spi = st->adis.spi;
+
+	desc = irq_get_irq_data(spi->irq);
+	if (!desc) {
+		dev_err(&spi->dev, "Could not find IRQ %d\n", spi->irq);
+		return -EINVAL;
+	}
+	/*
+	 * It is possible to configure the data ready polarity. Furthermore, we
+	 * need to update the adis struct if we want data ready as active low.
+	 */
+	irq_type = irqd_get_trigger_type(desc);
+	if (irq_type == IRQ_TYPE_EDGE_RISING) {
+		polarity = 1;
+		st->adis.irq_flag = IRQF_TRIGGER_RISING;
+	} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {
+		polarity = 0;
+		st->adis.irq_flag = IRQF_TRIGGER_FALLING;
+	} else {
+		dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
+			irq_type);
+		return -EINVAL;
+	}
+
+	val = ADIS16475_MSG_CTRL_DR_POL(polarity);
+	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
+	if (ret)
+		return ret;
+	/*
+	 * There is a delay writing to any bits written to the MSC_CTRL
+	 * register. It should not be bigger than 200us, so 250 should be more
+	 * than enough!
+	 */
+	usleep_range(250, 260);
+
+	return 0;
+}
+
+static const struct of_device_id adis16475_of_match[] = {
+	{ .compatible = "adi,adis16470",
+		.data = &adis16475_chip_info[ADIS16470] },
+	{ .compatible = "adi,adis16475-1",
+		.data = &adis16475_chip_info[ADIS16475_1] },
+	{ .compatible = "adi,adis16475-2",
+		.data = &adis16475_chip_info[ADIS16475_2] },
+	{ .compatible = "adi,adis16475-3",
+		.data = &adis16475_chip_info[ADIS16475_3] },
+	{ .compatible = "adi,adis16477-1",
+		.data = &adis16475_chip_info[ADIS16477_1] },
+	{ .compatible = "adi,adis16477-2",
+		.data = &adis16475_chip_info[ADIS16477_2] },
+	{ .compatible = "adi,adis16477-3",
+		.data = &adis16475_chip_info[ADIS16477_3] },
+	{ .compatible = "adi,adis16465-1",
+		.data = &adis16475_chip_info[ADIS16465_1] },
+	{ .compatible = "adi,adis16465-2",
+		.data = &adis16475_chip_info[ADIS16465_2] },
+	{ .compatible = "adi,adis16465-3",
+		.data = &adis16475_chip_info[ADIS16465_3] },
+	{ .compatible = "adi,adis16467-1",
+		.data = &adis16475_chip_info[ADIS16467_1] },
+	{ .compatible = "adi,adis16467-2",
+		.data = &adis16475_chip_info[ADIS16467_2] },
+	{ .compatible = "adi,adis16467-3",
+		.data = &adis16475_chip_info[ADIS16467_3] },
+	{ .compatible = "adi,adis16500",
+		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16505-1",
+		.data = &adis16475_chip_info[ADIS16505_1] },
+	{ .compatible = "adi,adis16505-2",
+		.data = &adis16475_chip_info[ADIS16505_2] },
+	{ .compatible = "adi,adis16505-3",
+		.data = &adis16475_chip_info[ADIS16505_3] },
+	{ .compatible = "adi,adis16507-1",
+		.data = &adis16475_chip_info[ADIS16507_1] },
+	{ .compatible = "adi,adis16507-2",
+		.data = &adis16475_chip_info[ADIS16507_2] },
+	{ .compatible = "adi,adis16507-3",
+		.data = &adis16475_chip_info[ADIS16507_3] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16475_of_match);
+
+static int adis16475_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adis16475 *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+	st->adis.burst = &adis16475_burst;
+
+	st->info = device_get_match_data(&spi->dev);
+	if (!st->info)
+		return -EINVAL;
+
+	ret = adis_init(&st->adis, indio_dev, spi, &st->info->adis_data);
+	if (ret)
+		return ret;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &adis16475_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = __adis_initial_startup(&st->adis);
+	if (ret)
+		return ret;
+
+	ret = adis16475_config_irq_pin(st);
+	if (ret)
+		return ret;
+
+	ret = adis16475_config_sync_mode(st);
+	if (ret)
+		return ret;
+
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+						 adis16475_trigger_handler);
+	if (ret)
+		return ret;
+
+	adis16475_enable_irq(&st->adis, false);
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	adis16475_debugfs_init(indio_dev);
+
+	return 0;
+}
+
+static struct spi_driver adis16475_driver = {
+	.driver = {
+		.name = "adis16475",
+		.of_match_table = adis16475_of_match,
+	},
+	.probe = adis16475_probe,
+};
+module_spi_driver(adis16475_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16475 IMU driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

