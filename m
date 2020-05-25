Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4619B1E0DE5
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbgEYLyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 07:54:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14070 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390196AbgEYLyQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 07:54:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PBjk0C012446;
        Mon, 25 May 2020 07:53:42 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp7xhwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 07:53:41 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04PBre3s039928
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 May 2020 07:53:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 25 May
 2020 07:53:39 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 25 May 2020 07:53:39 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04PBrUvI018765;
        Mon, 25 May 2020 07:53:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <jic23@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <lorenzo.bianconi83@gmail.com>, <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/3] iio: remove iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Date:   Mon, 25 May 2020 14:38:55 +0300
Message-ID: <20200525113855.178821-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200525113855.178821-1-alexandru.ardelean@analog.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_06:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

This patch should be squashed into the first one, as the first one is
breaking the build (intentionally) to make the IIO core files easier to
review.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c                 | 20 +++--------
 drivers/iio/accel/bmc150-accel-core.c       |  4 +--
 drivers/iio/accel/kxcjk-1013.c              |  2 --
 drivers/iio/accel/kxsd9.c                   |  2 --
 drivers/iio/accel/st_accel_buffer.c         | 22 +++---------
 drivers/iio/accel/stk8312.c                 |  2 --
 drivers/iio/accel/stk8ba50.c                |  2 --
 drivers/iio/adc/ad7266.c                    |  2 --
 drivers/iio/adc/ad7606.c                    |  3 +-
 drivers/iio/adc/ad7766.c                    |  2 --
 drivers/iio/adc/ad7768-1.c                  |  8 +----
 drivers/iio/adc/ad7887.c                    |  2 --
 drivers/iio/adc/ad_sigma_delta.c            |  5 ---
 drivers/iio/adc/dln2-adc.c                  | 12 +------
 drivers/iio/adc/mxs-lradc-adc.c             |  2 --
 drivers/iio/adc/stm32-adc.c                 | 36 +++----------------
 drivers/iio/adc/stm32-dfsdm-adc.c           | 39 +++------------------
 drivers/iio/adc/ti-adc084s021.c             |  2 --
 drivers/iio/adc/ti-ads1015.c                |  2 --
 drivers/iio/adc/vf610_adc.c                 |  7 +---
 drivers/iio/adc/xilinx-xadc-core.c          |  2 --
 drivers/iio/chemical/atlas-sensor.c         |  6 +---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 14 --------
 drivers/iio/gyro/bmg160_core.c              |  2 --
 drivers/iio/gyro/mpu3050-core.c             |  2 --
 drivers/iio/gyro/st_gyro_buffer.c           | 21 +++--------
 drivers/iio/humidity/hdc100x.c              | 12 +------
 drivers/iio/humidity/hts221_buffer.c        |  2 --
 drivers/iio/light/gp2ap020a00f.c            | 10 ------
 drivers/iio/light/isl29125.c                | 20 ++---------
 drivers/iio/light/rpr0521.c                 |  2 --
 drivers/iio/light/si1145.c                  |  2 --
 drivers/iio/light/st_uvis25_core.c          |  2 --
 drivers/iio/light/tcs3414.c                 | 20 ++---------
 drivers/iio/light/vcnl4000.c                | 35 ++++--------------
 drivers/iio/magnetometer/bmc150_magn.c      |  2 --
 drivers/iio/magnetometer/rm3100-core.c      |  2 --
 drivers/iio/magnetometer/st_magn_buffer.c   | 26 ++------------
 drivers/iio/potentiostat/lmp91000.c         | 13 ++-----
 drivers/iio/pressure/st_pressure_buffer.c   | 26 ++------------
 drivers/iio/pressure/zpa2326.c              | 27 ++++++--------
 drivers/iio/proximity/sx9310.c              |  2 --
 drivers/iio/proximity/sx9500.c              |  9 -----
 43 files changed, 58 insertions(+), 377 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 60daf04ce188..53697ca09a22 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -795,13 +795,9 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	unsigned int mask;
 	int i, ret;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	mask = *indio_dev->active_scan_mask;
 
@@ -810,10 +806,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(adxl372_axis_lookup_table)) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (i == ARRAY_SIZE(adxl372_axis_lookup_table))
+		return -EINVAL;
 
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
@@ -833,14 +827,10 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret < 0) {
 		st->fifo_mode = ADXL372_FIFO_BYPASSED;
 		adxl372_set_interrupts(st, 0, 0);
-		goto err;
+		return ret;
 	}
 
 	return 0;
-
-err:
-	iio_triggered_buffer_predisable(indio_dev);
-	return ret;
 }
 
 static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
@@ -851,7 +841,7 @@ static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
 	st->fifo_mode = ADXL372_FIFO_BYPASSED;
 	adxl372_configure_fifo(st);
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 121b4e89f038..a2ff7033202d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1411,7 +1411,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	int ret = 0;
 
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-		return iio_triggered_buffer_postenable(indio_dev);
+		return 0;
 
 	mutex_lock(&data->mutex);
 
@@ -1443,7 +1443,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-		return iio_triggered_buffer_predisable(indio_dev);
+		return 0;
 
 	mutex_lock(&data->mutex);
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index c9924a65c32a..209b0e189fd4 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1027,9 +1027,7 @@ static const struct iio_chan_spec kxcjk1013_channels[] = {
 
 static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
 	.preenable		= kxcjk1013_buffer_preenable,
-	.postenable		= iio_triggered_buffer_postenable,
 	.postdisable		= kxcjk1013_buffer_postdisable,
-	.predisable		= iio_triggered_buffer_predisable,
 };
 
 static const struct iio_info kxcjk1013_info = {
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0b876b2dc5bd..39da8a090822 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -252,8 +252,6 @@ static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
 	.preenable = kxsd9_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = kxsd9_buffer_postdisable,
 };
 
diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index b5c814ef1637..492263589e04 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -33,13 +33,9 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int err;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		return err;
-
 	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_accel_buffer_predisable;
+		return err;
 
 	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
@@ -49,27 +45,19 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 
 st_accel_buffer_enable_all_axis:
 	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
-st_accel_buffer_predisable:
-	iio_triggered_buffer_predisable(indio_dev);
 	return err;
 }
 
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err, err2;
+	int err;
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-		goto st_accel_buffer_predisable;
-
-	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
-
-st_accel_buffer_predisable:
-	err2 = iio_triggered_buffer_predisable(indio_dev);
-	if (!err)
-		err = err2;
+		return err;
 
-	return err;
+	return st_sensors_set_axis_enable(indio_dev,
+					  ST_SENSORS_ENABLE_ALL_AXIS);
 }
 
 static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 58c160ccdee7..a7684545f12a 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -492,8 +492,6 @@ static int stk8312_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops stk8312_buffer_setup_ops = {
 	.preenable   = stk8312_buffer_preenable,
-	.postenable  = iio_triggered_buffer_postenable,
-	.predisable  = iio_triggered_buffer_predisable,
 	.postdisable = stk8312_buffer_postdisable,
 };
 
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index c70ddec29eb4..1eec8dfceefe 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -376,8 +376,6 @@ static int stk8ba50_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops stk8ba50_buffer_setup_ops = {
 	.preenable   = stk8ba50_buffer_preenable,
-	.postenable  = iio_triggered_buffer_postenable,
-	.predisable  = iio_triggered_buffer_predisable,
 	.postdisable = stk8ba50_buffer_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c8524f098883..d365c89d34ab 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -74,8 +74,6 @@ static int ad7266_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
 	.preenable = &ad7266_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7266_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e4683a68522a..a88e07869a69 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -499,7 +499,6 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	iio_triggered_buffer_postenable(indio_dev);
 	gpiod_set_value(st->gpio_convst, 1);
 
 	return 0;
@@ -511,7 +510,7 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 
 	gpiod_set_value(st->gpio_convst, 0);
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index bc388ea41754..0b6d27cb5f81 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -178,8 +178,6 @@ static const struct ad7766_chip_info ad7766_chip_info[] = {
 
 static const struct iio_buffer_setup_ops ad7766_buffer_setup_ops = {
 	.preenable = &ad7766_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7766_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0d132708c429..addd802ed5d7 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -490,7 +490,6 @@ static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
-	iio_triggered_buffer_postenable(indio_dev);
 	/*
 	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
 	 * continuous read mode. Subsequent data reads do not require an
@@ -502,17 +501,12 @@ static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
 static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
-	int ret;
 
 	/*
 	 * To exit continuous read mode, perform a single read of the ADC_DATA
 	 * reg (0x2C), which allows further configuration of the device.
 	 */
-	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
-	if (ret < 0)
-		return ret;
-
-	return iio_triggered_buffer_predisable(indio_dev);
+	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
 }
 
 static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index c6a3428e950a..7ce665601ce4 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -136,8 +136,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 
 static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
 	.preenable = &ad7887_ring_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7887_ring_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index dd3d54b3bc8b..3554ee6ee099 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -345,10 +345,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	unsigned int channel;
 	int ret;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 	ret = ad_sigma_delta_set_channel(sigma_delta,
@@ -441,7 +437,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad_sd_buffer_postdisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 65c7c9329b1c..e4616b4a790a 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -524,10 +524,6 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 	u16 conflict;
 	unsigned int trigger_chan;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&dln2->mutex);
 
 	/* Enable ADC */
@@ -541,7 +537,6 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 				(int)conflict);
 			ret = -EBUSY;
 		}
-		iio_triggered_buffer_predisable(indio_dev);
 		return ret;
 	}
 
@@ -555,7 +550,6 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 		mutex_unlock(&dln2->mutex);
 		if (ret < 0) {
 			dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
-			iio_triggered_buffer_predisable(indio_dev);
 			return ret;
 		}
 	} else {
@@ -568,7 +562,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 
 static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int ret, ret2;
+	int ret;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
 
 	mutex_lock(&dln2->mutex);
@@ -586,10 +580,6 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
 
-	ret2 = iio_triggered_buffer_predisable(indio_dev);
-	if (ret == 0)
-		ret = ret2;
-
 	return ret;
 }
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 9d2f74c2489a..7f49586944a9 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -568,8 +568,6 @@ static bool mxs_lradc_adc_validate_scan_mask(struct iio_dev *iio,
 
 static const struct iio_buffer_setup_ops mxs_lradc_adc_buffer_ops = {
 	.preenable = &mxs_lradc_adc_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &mxs_lradc_adc_buffer_postdisable,
 	.validate_scan_mask = &mxs_lradc_adc_validate_scan_mask,
 };
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index ae622ee6d08c..cbc7f0467ae8 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1482,7 +1482,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
+static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
@@ -1527,22 +1527,7 @@ static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
-{
-	int ret;
-
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	ret = __stm32_adc_buffer_postenable(indio_dev);
-	if (ret < 0)
-		iio_triggered_buffer_predisable(indio_dev);
-
-	return ret;
-}
-
-static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
+static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
@@ -1561,19 +1546,8 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-}
-
-static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
-{
-	int ret;
-
-	__stm32_adc_buffer_predisable(indio_dev);
-
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "predisable failed\n");
 
-	return ret;
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops stm32_adc_buffer_setup_ops = {
@@ -2016,7 +1990,7 @@ static int stm32_adc_suspend(struct device *dev)
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 
 	if (iio_buffer_enabled(indio_dev))
-		__stm32_adc_buffer_predisable(indio_dev);
+		stm32_adc_buffer_predisable(indio_dev);
 
 	return pm_runtime_force_suspend(dev);
 }
@@ -2039,7 +2013,7 @@ static int stm32_adc_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	return __stm32_adc_buffer_postenable(indio_dev);
+	return stm32_adc_buffer_postenable(indio_dev);
 }
 #endif
 
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 76a60d93fe23..0f652165d781 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -993,7 +993,7 @@ static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int __stm32_dfsdm_postenable(struct iio_dev *indio_dev)
+static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	int ret;
@@ -1036,30 +1036,7 @@ static int __stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
-{
-	int ret;
-
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		ret = iio_triggered_buffer_postenable(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
-
-	ret = __stm32_dfsdm_postenable(indio_dev);
-	if (ret < 0)
-		goto err_predisable;
-
-	return 0;
-
-err_predisable:
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-		iio_triggered_buffer_predisable(indio_dev);
-
-	return ret;
-}
-
-static void __stm32_dfsdm_predisable(struct iio_dev *indio_dev)
+static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
@@ -1071,14 +1048,6 @@ static void __stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 
 	if (adc->hwc)
 		iio_hw_consumer_disable(adc->hwc);
-}
-
-static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
-{
-	__stm32_dfsdm_predisable(indio_dev);
-
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-		iio_triggered_buffer_predisable(indio_dev);
 
 	return 0;
 }
@@ -1667,7 +1636,7 @@ static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 
 	if (iio_buffer_enabled(indio_dev))
-		__stm32_dfsdm_predisable(indio_dev);
+		stm32_dfsdm_predisable(indio_dev);
 
 	return 0;
 }
@@ -1690,7 +1659,7 @@ static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
 	}
 
 	if (iio_buffer_enabled(indio_dev))
-		__stm32_dfsdm_postenable(indio_dev);
+		stm32_dfsdm_postenable(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index bdedf456ee05..75ec8a21d28e 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -187,8 +187,6 @@ static const struct iio_info adc084s021_info = {
 
 static const struct iio_buffer_setup_ops adc084s021_buffer_setup_ops = {
 	.preenable = adc084s021_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = adc084s021_buffer_postdisable,
 };
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 5ea4f45d6bad..efb55c2bccf4 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -788,8 +788,6 @@ static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
 	.preenable	= ads1015_buffer_preenable,
-	.postenable	= iio_triggered_buffer_postenable,
-	.predisable	= iio_triggered_buffer_predisable,
 	.postdisable	= ads1015_buffer_postdisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index cb7380bf07ca..72b363ea4074 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -724,13 +724,8 @@ static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct vf610_adc *info = iio_priv(indio_dev);
 	unsigned int channel;
-	int ret;
 	int val;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	val = readl(info->regs + VF610_REG_ADC_GC);
 	val |= VF610_ADC_ADCON;
 	writel(val, info->regs + VF610_REG_ADC_GC);
@@ -761,7 +756,7 @@ static int vf610_adc_buffer_predisable(struct iio_dev *indio_dev)
 
 	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d7fecab9252e..2e81aa390978 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -839,8 +839,6 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.preenable = &xadc_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &xadc_postdisable,
 };
 
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index a6d996ab9a66..362cf766a79a 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -398,10 +398,6 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	ret = pm_runtime_get_sync(&data->client->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(&data->client->dev);
@@ -425,7 +421,7 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 17606eca42b4..8e13c53d4360 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -99,20 +99,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 }
 
 static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
-	/*
-	 * iio_triggered_buffer_postenable:
-	 * Generic function that simply attaches the pollfunc to the trigger.
-	 * Replace this to mess with hardware state before we attach the
-	 * trigger.
-	 */
-	.postenable = &iio_triggered_buffer_postenable,
-	/*
-	 * iio_triggered_buffer_predisable:
-	 * Generic function that simple detaches the pollfunc from the trigger.
-	 * Replace this to put hardware state back again after the trigger is
-	 * detached but before userspace knows we have disabled the ring.
-	 */
-	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 428ddfc13acb..0d0bfdd6036e 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1051,8 +1051,6 @@ static int bmg160_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
 	.preenable = bmg160_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = bmg160_buffer_postdisable,
 };
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 8e908a749f95..de1cd17d57f0 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -662,8 +662,6 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops mpu3050_buffer_setup_ops = {
 	.preenable = mpu3050_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = mpu3050_buffer_postdisable,
 };
 
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 9c92ff7a82be..4feb7ada7195 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -33,13 +33,9 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int err;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		return err;
-
 	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_gyro_buffer_predisable;
+		return err;
 
 	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
@@ -49,27 +45,18 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 
 st_gyro_buffer_enable_all_axis:
 	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
-st_gyro_buffer_predisable:
-	iio_triggered_buffer_predisable(indio_dev);
 	return err;
 }
 
 static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err, err2;
+	int err;
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-		goto st_gyro_buffer_predisable;
-
-	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
-
-st_gyro_buffer_predisable:
-	err2 = iio_triggered_buffer_predisable(indio_dev);
-	if (!err)
-		err = err2;
+		return err;
 
-	return err;
+	return st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 }
 
 static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 7ecd2ffa3132..9243f8546cfb 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -278,17 +278,11 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	/* Buffer is enabled. First set ACQ Mode, then attach poll func */
 	mutex_lock(&data->lock);
 	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
 				    HDC100X_REG_CONFIG_ACQ_MODE);
 	mutex_unlock(&data->lock);
-	if (ret)
-		iio_triggered_buffer_predisable(indio_dev);
 
 	return ret;
 }
@@ -296,16 +290,12 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
 static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct hdc100x_data *data = iio_priv(indio_dev);
-	int ret, ret2;
+	int ret;
 
 	mutex_lock(&data->lock);
 	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
 	mutex_unlock(&data->lock);
 
-	ret2 = iio_triggered_buffer_predisable(indio_dev);
-	if (ret == 0)
-		ret = ret2;
-
 	return ret;
 }
 
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 9fb3f33614d4..d18b39f30ea7 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -153,8 +153,6 @@ static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
 
 static const struct iio_buffer_setup_ops hts221_buffer_ops = {
 	.preenable = hts221_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = hts221_buffer_postdisable,
 };
 
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 070d4cd0cf54..29d7af33efa1 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1390,12 +1390,6 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0) {
-		mutex_unlock(&data->lock);
-		return err;
-	}
-
 	/*
 	 * Enable triggers according to the scan_mask. Enabling either
 	 * LIGHT_CLEAR or LIGHT_IR scan mode results in enabling ALS
@@ -1430,8 +1424,6 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 		err = -ENOMEM;
 
 error_unlock:
-	if (err < 0)
-		iio_triggered_buffer_predisable(indio_dev);
 	mutex_unlock(&data->lock);
 
 	return err;
@@ -1465,8 +1457,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	if (err == 0)
 		kfree(data->buffer);
 
-	iio_triggered_buffer_predisable(indio_dev);
-
 	mutex_unlock(&data->lock);
 
 	return err;
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 95611f5eff01..76065433a967 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -216,36 +216,20 @@ static const struct iio_info isl29125_info = {
 static int isl29125_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct isl29125_data *data = iio_priv(indio_dev);
-	int err;
-
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err)
-		return err;
 
 	data->conf1 |= ISL29125_MODE_RGB;
-	err = i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
+	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
-	if (err) {
-		iio_triggered_buffer_predisable(indio_dev);
-		return err;
-	}
-
-	return 0;
 }
 
 static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct isl29125_data *data = iio_priv(indio_dev);
-	int ret;
 
 	data->conf1 &= ~ISL29125_MODE_MASK;
 	data->conf1 |= ISL29125_MODE_PD;
-	ret = i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
+	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
-
-	iio_triggered_buffer_predisable(indio_dev);
-
-	return ret;
 }
 
 static const struct iio_buffer_setup_ops isl29125_buffer_setup_ops = {
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index a0a7aeae5a82..e43c050cc766 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -570,8 +570,6 @@ static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
 	.preenable = rpr0521_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = rpr0521_buffer_postdisable,
 };
 
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 0476c2bc8138..d409389ba38e 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1171,8 +1171,6 @@ static bool si1145_validate_scan_mask(struct iio_dev *indio_dev,
 
 static const struct iio_buffer_setup_ops si1145_buffer_setup_ops = {
 	.preenable = si1145_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.validate_scan_mask = si1145_validate_scan_mask,
 };
 
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index d262c254b895..0951dbeb5d04 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -227,8 +227,6 @@ static int st_uvis25_buffer_postdisable(struct iio_dev *iio_dev)
 
 static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
 	.preenable = st_uvis25_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = st_uvis25_buffer_postdisable,
 };
 
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index b542e5619ead..2dc3d5db5d08 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -243,35 +243,19 @@ static const struct iio_info tcs3414_info = {
 static int tcs3414_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
 
 	data->control |= TCS3414_CONTROL_ADC_EN;
-	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
-	if (ret)
-		iio_triggered_buffer_predisable(indio_dev);
-
-	return ret;
 }
 
 static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
-	int ret, ret2;
 
 	data->control &= ~TCS3414_CONTROL_ADC_EN;
-	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
-
-	ret2 = iio_triggered_buffer_predisable(indio_dev);
-	if (!ret)
-		ret = ret2;
-
-	return ret;
 }
 
 static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 2a4b3d331055..5287ac7d8655 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -957,50 +957,29 @@ static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
 	int ret;
 	int cmd;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	/* Do not enable the buffer if we are already capturing events. */
-	if (vcnl4010_is_in_periodic_mode(data)) {
-		ret = -EBUSY;
-		goto end;
-	}
+	if (vcnl4010_is_in_periodic_mode(data))
+		return -EBUSY;
 
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
 					VCNL4010_INT_PROX_EN);
 	if (ret < 0)
-		goto end;
+		return ret;
 
 	cmd = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
-	if (ret < 0)
-		goto end;
-
-	return 0;
-end:
-	iio_triggered_buffer_predisable(indio_dev);
-
-	return ret;
+	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
 }
 
 static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret, ret_disable;
+	int ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
 	if (ret < 0)
-		goto end;
-
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
-
-end:
-	ret_disable = iio_triggered_buffer_predisable(indio_dev);
-	if (ret == 0)
-		ret = ret_disable;
+		return ret;
 
-	return ret;
+	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
 }
 
 static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d4de16750b10..1422da8db803 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -836,8 +836,6 @@ static int bmc150_magn_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
 	.preenable = bmc150_magn_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = bmc150_magn_buffer_postdisable,
 };
 
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 43a2e420c9c4..96ad92a3c5d0 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -463,8 +463,6 @@ static int rm3100_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops rm3100_buffer_ops = {
 	.preenable = rm3100_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = rm3100_buffer_postdisable,
 };
 
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index bb425c167a96..4917721fa2e5 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -31,34 +31,12 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
-
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		return err;
-
-	err = st_sensors_set_enable(indio_dev, true);
-	if (err < 0)
-		goto st_magn_buffer_predisable;
-
-	return 0;
-
-st_magn_buffer_predisable:
-	iio_triggered_buffer_predisable(indio_dev);
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err, err2;
-
-	err = st_sensors_set_enable(indio_dev, false);
-
-	err2 = iio_triggered_buffer_predisable(indio_dev);
-	if (!err)
-		err = err2;
-
-	return err;
+	return st_sensors_set_enable(indio_dev, false);
 }
 
 static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 2cb11da18e0f..5eac2dfae747 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -278,17 +278,8 @@ static const struct iio_trigger_ops lmp91000_trigger_ops = {
 static int lmp91000_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct lmp91000_data *data = iio_priv(indio_dev);
-	int err;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err)
-		return err;
-
-	err = iio_channel_start_all_cb(data->cb_buffer);
-	if (err)
-		iio_triggered_buffer_predisable(indio_dev);
-
-	return err;
+	return iio_channel_start_all_cb(data->cb_buffer);
 }
 
 static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
@@ -297,7 +288,7 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
 
 	iio_channel_stop_all_cb(data->cb_buffer);
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 418dbf9e6e1e..7cf6f06797e1 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -31,34 +31,12 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
-
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		return err;
-
-	err = st_sensors_set_enable(indio_dev, true);
-	if (err < 0)
-		goto st_press_buffer_predisable;
-
-	return 0;
-
-st_press_buffer_predisable:
-	iio_triggered_buffer_predisable(indio_dev);
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 }
 
 static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err, err2;
-
-	err = st_sensors_set_enable(indio_dev, false);
-
-	err2 = iio_triggered_buffer_predisable(indio_dev);
-	if (!err)
-		err = err2;
-
-	return err;
+	return st_sensors_set_enable(indio_dev, false);
 }
 
 static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 37fe851f89af..60948ad68cbd 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1242,19 +1242,17 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 	const struct zpa2326_private *priv = iio_priv(indio_dev);
 	int                           err;
 
-	/* Plug our own trigger event handler. */
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err)
-		goto err;
-
 	if (!priv->waken) {
 		/*
 		 * We were already power supplied. Just clear hardware FIFO to
 		 * get rid of samples acquired during previous rounds (if any).
 		 */
 		err = zpa2326_clear_fifo(indio_dev, 0);
-		if (err)
-			goto err_buffer_predisable;
+		if (err) {
+			zpa2326_err(indio_dev,
+				    "failed to enable buffering (%d)", err);
+			return err;
+		}
 	}
 
 	if (!iio_trigger_using_own(indio_dev) && priv->waken) {
@@ -1263,18 +1261,14 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 		 * powered up: reconfigure one-shot mode.
 		 */
 		err = zpa2326_config_oneshot(indio_dev, priv->irq);
-		if (err)
-			goto err_buffer_predisable;
+		if (err) {
+			zpa2326_err(indio_dev,
+				    "failed to enable buffering (%d)", err);
+			return err;
+		}
 	}
 
 	return 0;
-
-err_buffer_predisable:
-	iio_triggered_buffer_predisable(indio_dev);
-err:
-	zpa2326_err(indio_dev, "failed to enable buffering (%d)", err);
-
-	return err;
 }
 
 static int zpa2326_postdisable_buffer(struct iio_dev *indio_dev)
@@ -1287,7 +1281,6 @@ static int zpa2326_postdisable_buffer(struct iio_dev *indio_dev)
 static const struct iio_buffer_setup_ops zpa2326_buffer_setup_ops = {
 	.preenable   = zpa2326_preenable_buffer,
 	.postenable  = zpa2326_postenable_buffer,
-	.predisable  = iio_triggered_buffer_predisable,
 	.postdisable = zpa2326_postdisable_buffer
 };
 
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index d161f3061e35..764b147c8bde 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -736,8 +736,6 @@ static int sx9310_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops sx9310_buffer_setup_ops = {
 	.preenable = sx9310_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = sx9310_buffer_postdisable,
 };
 
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 287d288e40c2..129c14e9a359 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -680,10 +680,6 @@ static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int ret = 0, i;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&data->mutex);
 
 	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
@@ -700,9 +696,6 @@ static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
 
 	mutex_unlock(&data->mutex);
 
-	if (ret)
-		iio_triggered_buffer_predisable(indio_dev);
-
 	return ret;
 }
 
@@ -727,8 +720,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
 
 	mutex_unlock(&data->mutex);
 
-	iio_triggered_buffer_predisable(indio_dev);
-
 	return ret;
 }
 
-- 
2.25.1

