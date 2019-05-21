Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C03245DC
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 04:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfEUCNu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 22:13:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbfEUCNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 22:13:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L26cXZ042479
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 22:13:48 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm87f89rp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 22:13:48 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 21 May 2019 03:13:47 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 03:13:43 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L2DgKS2228498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 02:13:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3931078063;
        Tue, 21 May 2019 02:13:42 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C3D78060;
        Tue, 21 May 2019 02:13:41 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 02:13:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 1/3] iio: Add driver for Infineon DPS310
Date:   Mon, 20 May 2019 21:13:32 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558404814-26078-1-git-send-email-eajames@linux.ibm.com>
References: <1558404814-26078-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052102-0020-0000-0000-00000EED096A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206296; UDB=6.00633418; IPR=6.00987257;
 MB=3.00026978; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 02:13:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052102-0021-0000-0000-000065E748A6
Message-Id: <1558404814-26078-2-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210011
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

The DPS310 is a temperature and pressure sensor. It can be accessed over
i2c and SPI, but this driver only supports polling over i2c.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                   |   6 +
 drivers/iio/pressure/Kconfig  |  11 +
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/dps310.c | 468 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 486 insertions(+)
 create mode 100644 drivers/iio/pressure/dps310.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a2cd369..091eb49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7760,6 +7760,12 @@ W:	http://industrypack.sourceforge.net
 S:	Maintained
 F:	drivers/ipack/
 
+INFINEON DPS310 Driver
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-iio@vger.kernel.org
+F:	drivers/iio/pressure/dps310.c
+S:	Maintained
+
 INFINIBAND SUBSYSTEM
 M:	Doug Ledford <dledford@redhat.com>
 M:	Jason Gunthorpe <jgg@mellanox.com>
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index efeb89f..97976de 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -52,6 +52,17 @@ config IIO_CROS_EC_BARO
 	  To compile this driver as a module, choose M here: the module
 	  will be called cros_ec_baro.
 
+config DPS310
+	tristate "Infineon DPS310 pressure and temperature sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Support for the Infineon DPS310 digital barometric pressure sensor.
+	  It can be accessed over I2C bus.
+
+	  This driver can also be built as a module.  If so, the module will be
+	  called dps310.
+
 config HID_SENSOR_PRESS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index c2058d7..d8f5ace 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) += bmp280.o
 bmp280-objs := bmp280-core.o bmp280-regmap.o
 obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
 obj-$(CONFIG_BMP280_SPI) += bmp280-spi.o
+obj-$(CONFIG_DPS310) += dps310.o
 obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
new file mode 100644
index 0000000..9acfccb
--- /dev/null
+++ b/drivers/iio/pressure/dps310.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
+/*
+ * The DPS310 is a barometric pressure and temperature sensor.
+ * Currently only reading a single temperature is supported by
+ * this driver.
+ *
+ * https://www.infineon.com/dgdl/?fileId=5546d462576f34750157750826c42242
+ *
+ * Temperature calculation:
+ *   c0 * 0.5 + c1 * T_raw / kT °C
+ *
+ * TODO:
+ *  - Pressure sensor readings
+ *  - Optionally support the FIFO
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define DPS310_DEV_NAME		"dps310"
+
+#define DPS310_PRS_B0		0x00
+#define DPS310_PRS_B1		0x01
+#define DPS310_PRS_B2		0x02
+#define DPS310_TMP_B0		0x03
+#define DPS310_TMP_B1		0x04
+#define DPS310_TMP_B2		0x05
+#define DPS310_PRS_CFG		0x06
+#define DPS310_TMP_CFG		0x07
+#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
+#define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
+#define  DPS310_TMP_EXT		BIT(7)
+#define DPS310_MEAS_CFG		0x08
+#define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
+#define   DPS310_PRS_EN		BIT(0)
+#define   DPS310_TEMP_EN	BIT(1)
+#define   DPS310_BACKGROUND	BIT(2)
+#define  DPS310_PRS_RDY		BIT(4)
+#define  DPS310_TMP_RDY		BIT(5)
+#define  DPS310_SENSOR_RDY	BIT(6)
+#define  DPS310_COEF_RDY	BIT(7)
+#define DPS310_CFG_REG		0x09
+#define  DPS310_INT_HL		BIT(7)
+#define  DPS310_TMP_SHIFT_EN	BIT(3)
+#define  DPS310_PRS_SHIFT_EN	BIT(4)
+#define  DPS310_FIFO_EN		BIT(5)
+#define  DPS310_SPI_EN		BIT(6)
+#define DPS310_RESET		0x0c
+#define  DPS310_RESET_MAGIC	0x09
+#define DPS310_COEF_BASE	0x10
+#define DPS310_COEF_SRC		0x28
+
+/* Make sure sleep time is <= 20ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Silently handle error in rate value here */
+#define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
+
+#define DPS310_PRS_BASE		DPS310_PRS_B0
+#define DPS310_TMP_BASE		DPS310_TMP_B0
+
+/*
+ * These values (defined in the spec) indicate how to scale the raw register
+ * values for each level of precision available.
+ */
+static const int scale_factors[] = {
+	 524288,
+	1572864,
+	3670016,
+	7864320,
+	 253952,
+	 516096,
+	1040384,
+	2088960,
+};
+
+struct dps310_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex lock;	/* Lock for sequential HW access functions */
+
+	s32 c0, c1;
+	s32 temp_raw;
+};
+
+static const struct iio_chan_spec dps310_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+/* To be called after checking the COEF_RDY bit in MEAS_CFG */
+static int dps310_get_temp_coef(struct dps310_data *data)
+{
+	int rc;
+	u8 coef[3];
+	u32 c0, c1;
+
+	/*
+	 * Read temperature calibration coefficients c0 and c1 from the
+	 * COEF register. The numbers are 12-bit 2's compliment numbers
+	 */
+	rc = regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
+			      sizeof(coef));
+	if (rc < 0)
+		return rc;
+
+	c0 = (coef[0] << 4) | (coef[1] >> 4);
+	data->c0 = sign_extend32(c0, 11);
+
+	c1 = ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
+	data->c1 = sign_extend32(c1, 11);
+
+	return 0;
+}
+
+static int dps310_get_temp_precision(struct dps310_data *data)
+{
+	int rc;
+	int val;
+
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * Scale factor is bottom 4 bits of the register, but 1111 is
+	 * reserved so just grab bottom three
+	 */
+	return BIT(val & GENMASK(2, 0));
+}
+
+/* Called with lock held */
+static int dps310_set_temp_precision(struct dps310_data *data, int val)
+{
+	int rc;
+	u8 shift_en;
+
+	if (val < 0 || val > 128)
+		return -EINVAL;
+
+	shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;
+	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+			       DPS310_TMP_SHIFT_EN, shift_en);
+	if (rc)
+		return rc;
+
+	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
+				  DPS310_TMP_PRC_BITS, ilog2(val));
+}
+
+/* Called with lock held */
+static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
+{
+	u8 val;
+
+	if (freq < 0 || freq > 128)
+		return -EINVAL;
+
+	val = ilog2(freq) << 4;
+
+	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
+				  DPS310_TMP_RATE_BITS, val);
+}
+
+static int dps310_get_temp_samp_freq(struct dps310_data *data)
+{
+	int rc;
+	int val;
+
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
+	if (rc < 0)
+		return rc;
+
+	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
+}
+
+static int dps310_get_temp_k(struct dps310_data *data)
+{
+	int rc = dps310_get_temp_precision(data);
+
+	if (rc < 0)
+		return rc;
+
+	return scale_factors[ilog2(rc)];
+}
+
+static int dps310_read_temp(struct dps310_data *data)
+{
+	int rc;
+	int rate;
+	int ready;
+	int timeout;
+	s32 raw;
+	u8 val[3];
+
+	if (mutex_lock_interruptible(&data->lock))
+		return -EINTR;
+
+	rate = dps310_get_temp_samp_freq(data);
+	timeout = DPS310_POLL_TIMEOUT_US(rate);
+
+	/* Poll for sensor readiness; base the timeout upon the sample rate. */
+	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
+				      ready & DPS310_TMP_RDY,
+				      DPS310_POLL_SLEEP_US(timeout), timeout);
+	if (rc < 0)
+		goto done;
+
+	rc = regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
+	if (rc < 0)
+		goto done;
+
+	raw = (val[0] << 16) | (val[1] << 8) | val[2];
+	data->temp_raw = sign_extend32(raw, 23);
+
+done:
+	mutex_unlock(&data->lock);
+	return rc;
+}
+
+static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DPS310_PRS_CFG:
+	case DPS310_TMP_CFG:
+	case DPS310_MEAS_CFG:
+	case DPS310_CFG_REG:
+	case DPS310_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DPS310_PRS_B0:
+	case DPS310_PRS_B1:
+	case DPS310_PRS_B2:
+	case DPS310_TMP_B0:
+	case DPS310_TMP_B1:
+	case DPS310_TMP_B2:
+	case DPS310_MEAS_CFG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int dps310_write_raw(struct iio_dev *iio,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long mask)
+{
+	int rc;
+	struct dps310_data *data = iio_priv(iio);
+
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	if (mutex_lock_interruptible(&data->lock))
+		return -EINTR;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rc = dps310_set_temp_samp_freq(data, val);
+		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		rc = dps310_set_temp_precision(data, val);
+		break;
+
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&data->lock);
+	return rc;
+}
+
+static int dps310_calculate_temp(struct dps310_data *data)
+{
+	s64 c0;
+	s64 t;
+	int kt = dps310_get_temp_k(data);
+
+	if (kt < 0)
+		return kt;
+
+	/* Obtain inverse-scaled offset */
+	c0 = div_s64((s64)kt * (s64)data->c0, 2);
+
+	/* Add the offset to the unscaled temperature */
+	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
+
+	/* Convert to milliCelsius and scale the temperature */
+	return (int)div_s64(t * 1000LL, kt);
+}
+
+static int dps310_read_raw(struct iio_dev *iio,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct dps310_data *data = iio_priv(iio);
+	int rc;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rc = dps310_get_temp_samp_freq(data);
+		if (rc < 0)
+			return rc;
+
+		*val = rc;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		rc = dps310_read_temp(data);
+		if (rc)
+			return rc;
+
+		rc = dps310_calculate_temp(data);
+		if (rc < 0)
+			return rc;
+
+		*val = rc;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		rc = dps310_get_temp_precision(data);
+		if (rc < 0)
+			return rc;
+
+		*val = rc;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void dps310_reset(void *action_data)
+{
+	struct dps310_data *data = action_data;
+
+	regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
+}
+
+static const struct regmap_config dps310_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = dps310_is_writeable_reg,
+	.volatile_reg = dps310_is_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = DPS310_COEF_SRC,
+};
+
+static const struct iio_info dps310_info = {
+	.read_raw = dps310_read_raw,
+	.write_raw = dps310_write_raw,
+};
+
+static int dps310_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct dps310_data *data;
+	struct iio_dev *iio;
+	int rc, ready;
+
+	iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
+	if (!iio)
+		return -ENOMEM;
+
+	data = iio_priv(iio);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	iio->dev.parent = &client->dev;
+	iio->name = id->name;
+	iio->channels = dps310_channels;
+	iio->num_channels = ARRAY_SIZE(dps310_channels);
+	iio->info = &dps310_info;
+	iio->modes = INDIO_DIRECT_MODE;
+
+	data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	/* Register to run the device reset when the device is removed */
+	rc = devm_add_action_or_reset(&client->dev, dps310_reset, data);
+	if (rc)
+		return rc;
+
+	/*
+	 * Set up external (MEMS) temperature sensor in single sample, one
+	 * measurement per second mode
+	 */
+	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
+	if (rc < 0)
+		return rc;
+
+	/* Temp shift is disabled when PRC <= 8 */
+	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+			       DPS310_TMP_SHIFT_EN, 0);
+	if (rc < 0)
+		return rc;
+
+	/* MEAS_CFG doesn't update correctly unless first written with 0 */
+	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			       DPS310_MEAS_CTRL_BITS, 0);
+	if (rc < 0)
+		return rc;
+
+	/* Turn on temperature measurement in the background */
+	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			       DPS310_MEAS_CTRL_BITS,
+			       DPS310_TEMP_EN | DPS310_BACKGROUND);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * Calibration coefficients required for reporting temperature.
+	 * They are available 40ms after the device has started
+	 */
+	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
+				      ready & DPS310_COEF_RDY, 10000, 40000);
+	if (rc < 0)
+		return rc;
+
+	rc = dps310_get_temp_coef(data);
+	if (rc < 0)
+		return rc;
+
+	rc = devm_iio_device_register(&client->dev, iio);
+	if (rc)
+		return rc;
+
+	i2c_set_clientdata(client, iio);
+
+	return 0;
+}
+
+static const struct i2c_device_id dps310_id[] = {
+	{ DPS310_DEV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, dps310_id);
+
+static struct i2c_driver dps310_driver = {
+	.driver = {
+		.name = DPS310_DEV_NAME,
+	},
+	.probe = dps310_probe,
+	.id_table = dps310_id,
+};
+module_i2c_driver(dps310_driver);
+
+MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_DESCRIPTION("Infineon DPS310 pressure and temperature sensor");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

