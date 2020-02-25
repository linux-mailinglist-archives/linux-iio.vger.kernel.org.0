Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2216C068
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBYMJv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:09:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7732 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730631AbgBYMJb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:09:31 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC4tSH012929;
        Tue, 25 Feb 2020 07:09:30 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yay1brsvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:09:30 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PC9TVd012335
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:09:29 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 07:09:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 07:09:28 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 07:09:27 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PC9N1F003238;
        Tue, 25 Feb 2020 07:09:27 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 3/6] iio: accel: adxl372: Add sysfs for g thresholds
Date:   Tue, 25 Feb 2020 14:09:06 +0200
Message-ID: <20200225120909.12629-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225120909.12629-1-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adxl372 has configurable thresholds for all 3 axis
that define activity and inactivity.
The driver sets the default inactivity threshold to 100mg
and the activity threshold to 1g. These values are not
ideal for all applications.

This patch adds event attributes for activity and inactivity
thresholds for each axis.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 90 +++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 5da3c924c62d..775dc4f0aaf4 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -5,6 +5,7 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -131,6 +132,14 @@
 #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
 #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
 
+/* ADX372_THRESH */
+#define ADXL372_THRESH_VAL_H_MSK		GENMASK(10, 3)
+#define ADXL372_THRESH_VAL_H_SEL(x)		\
+		FIELD_GET(ADXL372_THRESH_VAL_H_MSK, x)
+#define ADXL372_THRESH_VAL_L_MSK		GENMASK(2, 0)
+#define ADXL372_THRESH_VAL_L_SEL(x)		\
+		FIELD_GET(ADXL372_THRESH_VAL_L_MSK, x)
+
 /* The ADXL372 includes a deep, 512 sample FIFO buffer */
 #define ADXL372_FIFO_SIZE			512
 
@@ -226,10 +235,12 @@ static const struct iio_event_spec adxl372_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
 	},
 };
@@ -290,6 +301,43 @@ static const unsigned long adxl372_channel_masks[] = {
 	0
 };
 
+static ssize_t adxl372_read_threshold_value(struct iio_dev *indio_dev,
+					    unsigned int addr,
+					    u16 *threshold)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	__be16 __regval;
+	u16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &__regval, sizeof(__regval));
+	if (ret < 0)
+		return ret;
+
+	regval = be16_to_cpu(__regval);
+	regval >>= 5;
+
+	*threshold = regval;
+
+	return 0;
+}
+
+static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev,
+					     unsigned int addr,
+					     u16 threshold)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(st->regmap, addr,
+			   ADXL372_THRESH_VAL_H_SEL(threshold));
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
+				  ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
@@ -744,8 +792,34 @@ int adxl372_read_event_value(struct iio_dev *indio_dev,
 			     enum iio_event_info info, int *val, int *val2)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int addr;
+	u16 raw_value;
+	int ret;
 
 	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			addr = ADXL372_X_THRESH_ACT_H + 2 * chan->scan_index;
+			ret = adxl372_read_threshold_value(indio_dev, addr,
+							   &raw_value);
+			if (ret < 0)
+				return ret;
+			*val = raw_value * ADXL372_USCALE;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			addr = ADXL372_X_THRESH_INACT_H + 2 * chan->scan_index;
+			ret =  adxl372_read_threshold_value(indio_dev, addr,
+							    &raw_value);
+			if (ret < 0)
+				return ret;
+			*val = raw_value * ADXL372_USCALE;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_INFO_PERIOD:
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
@@ -772,8 +846,24 @@ int adxl372_write_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
 	unsigned int val_ms;
+	unsigned int addr;
+	u16 raw_val;
 
 	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		raw_val = DIV_ROUND_UP(val * 1000000, ADXL372_USCALE);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			addr = ADXL372_X_THRESH_ACT_H + 2 * chan->scan_index;
+			return adxl372_write_threshold_value(indio_dev, addr,
+							     raw_val);
+		case IIO_EV_DIR_FALLING:
+			addr = ADXL372_X_THRESH_INACT_H + 2 * chan->scan_index;
+			return adxl372_write_threshold_value(indio_dev, addr,
+							     raw_val);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_INFO_PERIOD:
 		val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
 		switch (dir) {
-- 
2.20.1

