Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949B4496C76
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 14:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiAVNJj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 08:09:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61988 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230519AbiAVNJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 08:09:38 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20MBkdxm014331;
        Sat, 22 Jan 2022 08:09:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3drfq8r7k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jan 2022 08:09:25 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 20MD9Op3022697
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Jan 2022 08:09:24 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 22 Jan 2022 08:09:22 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 22 Jan 2022 08:09:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 22 Jan 2022 08:09:22 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20MD9BHU004310;
        Sat, 22 Jan 2022 08:09:17 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 3/3] iio: adis: stylistic changes
Date:   Sat, 22 Jan 2022 14:09:05 +0100
Message-ID: <20220122130905.99-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220122130905.99-1-nuno.sa@analog.com>
References: <20220122130905.99-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: y9s03da1KUSCa757OdVRfeCTdV5J1Rw3
X-Proofpoint-GUID: y9s03da1KUSCa757OdVRfeCTdV5J1Rw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-22_04,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201220092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minor stylistic changes to address checkptach complains when called with
'--strict'.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
changes in v2:
 * none.

 drivers/iio/imu/adis.c         | 47 +++++++++++++++++----------------
 drivers/iio/imu/adis_buffer.c  |  6 ++---
 drivers/iio/imu/adis_trigger.c |  3 +--
 include/linux/iio/imu/adis.h   | 48 ++++++++++++++++++----------------
 4 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index cb0d66bf6561..638957001653 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -30,8 +30,8 @@
  * @value: The value to write to device (up to 4 bytes)
  * @size: The size of the @value (in bytes)
  */
-int __adis_write_reg(struct adis *adis, unsigned int reg,
-	unsigned int value, unsigned int size)
+int __adis_write_reg(struct adis *adis, unsigned int reg, unsigned int value,
+		     unsigned int size)
 {
 	unsigned int page = reg / ADIS_PAGE_SIZE;
 	int ret, i;
@@ -114,7 +114,7 @@ int __adis_write_reg(struct adis *adis, unsigned int reg,
 	ret = spi_sync(adis->spi, &msg);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to write register 0x%02X: %d\n",
-				reg, ret);
+			reg, ret);
 	} else {
 		adis->current_page = page;
 	}
@@ -130,8 +130,8 @@ EXPORT_SYMBOL_GPL(__adis_write_reg);
  * @val: The value read back from the device
  * @size: The size of the @val buffer
  */
-int __adis_read_reg(struct adis *adis, unsigned int reg,
-	unsigned int *val, unsigned int size)
+int __adis_read_reg(struct adis *adis, unsigned int reg, unsigned int *val,
+		    unsigned int size)
 {
 	unsigned int page = reg / ADIS_PAGE_SIZE;
 	struct spi_message msg;
@@ -201,12 +201,12 @@ int __adis_read_reg(struct adis *adis, unsigned int reg,
 	ret = spi_sync(adis->spi, &msg);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to read register 0x%02X: %d\n",
-				reg, ret);
+			reg, ret);
 		return ret;
-	} else {
-		adis->current_page = page;
 	}
 
+	adis->current_page = page;
+
 	switch (size) {
 	case 4:
 		*val = get_unaligned_be32(adis->rx);
@@ -247,13 +247,13 @@ EXPORT_SYMBOL_GPL(__adis_update_bits_base);
 
 #ifdef CONFIG_DEBUG_FS
 
-int adis_debugfs_reg_access(struct iio_dev *indio_dev,
-	unsigned int reg, unsigned int writeval, unsigned int *readval)
+int adis_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			    unsigned int writeval, unsigned int *readval)
 {
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 
 	if (readval) {
-		uint16_t val16;
+		u16 val16;
 		int ret;
 
 		ret = adis_read_reg_16(adis, reg, &val16);
@@ -261,9 +261,9 @@ int adis_debugfs_reg_access(struct iio_dev *indio_dev,
 			*readval = val16;
 
 		return ret;
-	} else {
-		return adis_write_reg_16(adis, reg, writeval);
 	}
+
+	return adis_write_reg_16(adis, reg, writeval);
 }
 EXPORT_SYMBOL(adis_debugfs_reg_access);
 
@@ -279,14 +279,16 @@ EXPORT_SYMBOL(adis_debugfs_reg_access);
 int adis_enable_irq(struct adis *adis, bool enable)
 {
 	int ret = 0;
-	uint16_t msc;
+	u16 msc;
 
 	mutex_lock(&adis->state_lock);
 
 	if (adis->data->enable_irq) {
 		ret = adis->data->enable_irq(adis, enable);
 		goto out_unlock;
-	} else if (adis->data->unmasked_drdy) {
+	}
+
+	if (adis->data->unmasked_drdy) {
 		if (enable)
 			enable_irq(adis->spi->irq);
 		else
@@ -322,7 +324,7 @@ EXPORT_SYMBOL(adis_enable_irq);
  */
 int __adis_check_status(struct adis *adis)
 {
-	uint16_t status;
+	u16 status;
 	int ret;
 	int i;
 
@@ -358,7 +360,7 @@ int __adis_reset(struct adis *adis)
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
 	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
-			ADIS_GLOB_CMD_SW_RESET);
+				 ADIS_GLOB_CMD_SW_RESET);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
 		return ret;
@@ -414,7 +416,7 @@ int __adis_initial_startup(struct adis *adis)
 {
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 	struct gpio_desc *gpio;
-	uint16_t prod_id;
+	u16 prod_id;
 	int ret;
 
 	/* check if the device has rst pin low */
@@ -423,7 +425,7 @@ int __adis_initial_startup(struct adis *adis)
 		return PTR_ERR(gpio);
 
 	if (gpio) {
-		msleep(10);
+		usleep_range(10, 12);
 		/* bring device out of reset */
 		gpiod_set_value_cansleep(gpio, 0);
 		msleep(timeouts->reset_ms);
@@ -477,7 +479,8 @@ EXPORT_SYMBOL_GPL(__adis_initial_startup);
  * a error bit in the channels raw value set error_mask to 0.
  */
 int adis_single_conversion(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int error_mask, int *val)
+			   const struct iio_chan_spec *chan,
+			   unsigned int error_mask, int *val)
 {
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 	unsigned int uval;
@@ -486,7 +489,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	mutex_lock(&adis->state_lock);
 
 	ret = __adis_read_reg(adis, chan->address, &uval,
-			chan->scan_type.storagebits / 8);
+			      chan->scan_type.storagebits / 8);
 	if (ret)
 		goto err_unlock;
 
@@ -521,7 +524,7 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
  * called.
  */
 int adis_init(struct adis *adis, struct iio_dev *indio_dev,
-	struct spi_device *spi, const struct adis_data *data)
+	      struct spi_device *spi, const struct adis_data *data)
 {
 	if (!data || !data->timeouts) {
 		dev_err(&spi->dev, "No config data or timeouts not defined!\n");
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 351c303c8a8c..d3527cf5ed37 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -20,7 +20,7 @@
 #include <linux/iio/imu/adis.h>
 
 static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
-	const unsigned long *scan_mask)
+				       const unsigned long *scan_mask)
 {
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 	unsigned int burst_length, burst_max_length;
@@ -67,7 +67,7 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 }
 
 int adis_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *scan_mask)
+			  const unsigned long *scan_mask)
 {
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 	const struct iio_chan_spec *chan;
@@ -158,7 +158,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
-		pf->timestamp);
+					   pf->timestamp);
 
 irq_done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index c461bd1e8e69..0e7fb00ba241 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -15,8 +15,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/imu/adis.h>
 
-static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
+static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig, bool state)
 {
 	struct adis *adis = iio_trigger_get_drvdata(trig);
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 11754f97d8bb..515ca09764fe 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -32,6 +32,7 @@ struct adis_timeout {
 	u16 sw_reset_ms;
 	u16 self_test_ms;
 };
+
 /**
  * struct adis_data - ADIS chip variant specific data
  * @read_delay: SPI delay for read operations in us
@@ -45,7 +46,7 @@ struct adis_timeout {
  * @self_test_mask: Bitmask of supported self-test operations
  * @self_test_reg: Register address to request self test command
  * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
- * @status_error_msgs: Array of error messgaes
+ * @status_error_msgs: Array of error messages
  * @status_error_mask: Bitmask of errors supported by the device
  * @timeouts: Chip specific delays
  * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
@@ -130,12 +131,12 @@ struct adis {
 	unsigned long		irq_flag;
 	void			*buffer;
 
-	uint8_t			tx[10] ____cacheline_aligned;
-	uint8_t			rx[4];
+	u8			tx[10] ____cacheline_aligned;
+	u8			rx[4];
 };
 
 int adis_init(struct adis *adis, struct iio_dev *indio_dev,
-	struct spi_device *spi, const struct adis_data *data);
+	      struct spi_device *spi, const struct adis_data *data);
 int __adis_reset(struct adis *adis);
 
 /**
@@ -156,9 +157,9 @@ static inline int adis_reset(struct adis *adis)
 }
 
 int __adis_write_reg(struct adis *adis, unsigned int reg,
-	unsigned int val, unsigned int size);
+		     unsigned int val, unsigned int size);
 int __adis_read_reg(struct adis *adis, unsigned int reg,
-	unsigned int *val, unsigned int size);
+		    unsigned int *val, unsigned int size);
 
 /**
  * __adis_write_reg_8() - Write single byte to a register (unlocked)
@@ -167,7 +168,7 @@ int __adis_read_reg(struct adis *adis, unsigned int reg,
  * @value: The value to write
  */
 static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
-	uint8_t val)
+				     u8 val)
 {
 	return __adis_write_reg(adis, reg, val, 1);
 }
@@ -179,7 +180,7 @@ static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
  * @value: Value to be written
  */
 static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
-	uint16_t val)
+				      u16 val)
 {
 	return __adis_write_reg(adis, reg, val, 2);
 }
@@ -191,7 +192,7 @@ static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
  * @value: Value to be written
  */
 static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
-	uint32_t val)
+				      u32 val)
 {
 	return __adis_write_reg(adis, reg, val, 4);
 }
@@ -203,7 +204,7 @@ static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
  * @val: The value read back from the device
  */
 static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
-	uint16_t *val)
+				     u16 *val)
 {
 	unsigned int tmp;
 	int ret;
@@ -222,7 +223,7 @@ static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
  * @val: The value read back from the device
  */
 static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
-	uint32_t *val)
+				     u32 *val)
 {
 	unsigned int tmp;
 	int ret;
@@ -242,7 +243,7 @@ static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
  * @size: The size of the @value (in bytes)
  */
 static inline int adis_write_reg(struct adis *adis, unsigned int reg,
-	unsigned int val, unsigned int size)
+				 unsigned int val, unsigned int size)
 {
 	int ret;
 
@@ -261,7 +262,7 @@ static inline int adis_write_reg(struct adis *adis, unsigned int reg,
  * @size: The size of the @val buffer
  */
 static int adis_read_reg(struct adis *adis, unsigned int reg,
-	unsigned int *val, unsigned int size)
+			 unsigned int *val, unsigned int size)
 {
 	int ret;
 
@@ -279,7 +280,7 @@ static int adis_read_reg(struct adis *adis, unsigned int reg,
  * @value: The value to write
  */
 static inline int adis_write_reg_8(struct adis *adis, unsigned int reg,
-	uint8_t val)
+				   u8 val)
 {
 	return adis_write_reg(adis, reg, val, 1);
 }
@@ -291,7 +292,7 @@ static inline int adis_write_reg_8(struct adis *adis, unsigned int reg,
  * @value: Value to be written
  */
 static inline int adis_write_reg_16(struct adis *adis, unsigned int reg,
-	uint16_t val)
+				    u16 val)
 {
 	return adis_write_reg(adis, reg, val, 2);
 }
@@ -303,7 +304,7 @@ static inline int adis_write_reg_16(struct adis *adis, unsigned int reg,
  * @value: Value to be written
  */
 static inline int adis_write_reg_32(struct adis *adis, unsigned int reg,
-	uint32_t val)
+				    u32 val)
 {
 	return adis_write_reg(adis, reg, val, 4);
 }
@@ -315,7 +316,7 @@ static inline int adis_write_reg_32(struct adis *adis, unsigned int reg,
  * @val: The value read back from the device
  */
 static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
-	uint16_t *val)
+				   u16 *val)
 {
 	unsigned int tmp;
 	int ret;
@@ -334,7 +335,7 @@ static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
  * @val: The value read back from the device
  */
 static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
-	uint32_t *val)
+				   u32 *val)
 {
 	unsigned int tmp;
 	int ret;
@@ -439,8 +440,8 @@ static inline void adis_dev_unlock(struct adis *adis)
 }
 
 int adis_single_conversion(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int error_mask,
-	int *val);
+			   const struct iio_chan_spec *chan,
+			   unsigned int error_mask, int *val);
 
 #define ADIS_VOLTAGE_CHAN(addr, si, chan, name, info_all, bits) { \
 	.type = IIO_VOLTAGE, \
@@ -489,7 +490,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-		 info_sep, \
+		 (info_sep), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.info_mask_shared_by_all = info_all, \
 	.address = (addr), \
@@ -523,7 +524,7 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
 
 int adis_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *scan_mask);
+			  const unsigned long *scan_mask);
 
 #else /* CONFIG_IIO_BUFFER */
 
@@ -547,7 +548,8 @@ static inline int devm_adis_probe_trigger(struct adis *adis,
 #ifdef CONFIG_DEBUG_FS
 
 int adis_debugfs_reg_access(struct iio_dev *indio_dev,
-	unsigned int reg, unsigned int writeval, unsigned int *readval);
+			    unsigned int reg, unsigned int writeval,
+			    unsigned int *readval);
 
 #else
 
-- 
2.17.1

