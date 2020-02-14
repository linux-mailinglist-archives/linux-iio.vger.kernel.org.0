Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C529A15D4C4
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 10:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNJcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 04:32:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42002 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728522AbgBNJcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 04:32:13 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E9GrRj011251;
        Fri, 14 Feb 2020 04:32:12 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udn4rqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 04:32:12 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01E9WBuT059588
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Feb 2020 04:32:11 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 14 Feb
 2020 04:32:10 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 14 Feb 2020 04:32:10 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01E9W9op029437;
        Fri, 14 Feb 2020 04:32:09 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH 4/5] iio: accel: adxl372: Add sysfs for g thresholds
Date:   Fri, 14 Feb 2020 11:31:56 +0200
Message-ID: <20200214093156.24528-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214092919.24351-1-alexandru.tachici@analog.com>
References: <20200214092919.24351-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_02:2020-02-12,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=686 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140076
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adxl372 has configurable thresholds for all 3 axis
that define activity and inactivity.
The driver sets the default inactivity threshold to 100mg
and the activity threshold to 1g. These values are not
ideal for all applications.

This patch adds device attributes for activity and inactivity
thresholds for each axis.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 91 +++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 8bef6f2030ff..ab154699e23a 100644
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
 
@@ -222,6 +231,32 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
 };
 
+static ssize_t adxl372_read_threshold_value(struct iio_dev *, uintptr_t,
+					    const struct iio_chan_spec *,
+					    char *);
+
+static ssize_t adxl372_write_threshold_value(struct iio_dev *, uintptr_t,
+					     struct iio_chan_spec const *,
+					     const char *, size_t);
+
+static const struct iio_chan_spec_ext_info adxl372_ext_info[] = {
+	{
+		.name = "threshold_activity",
+		.shared = IIO_SEPARATE,
+		.read = adxl372_read_threshold_value,
+		.write = adxl372_write_threshold_value,
+		.private = ADXL372_X_THRESH_ACT_H,
+	},
+	{
+		.name = "threshold_inactivity",
+		.shared = IIO_SEPARATE,
+		.read = adxl372_read_threshold_value,
+		.write = adxl372_write_threshold_value,
+		.private = ADXL372_X_THRESH_INACT_H,
+	},
+	{},
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -239,6 +274,7 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 		.shift = 4,						\
 		.endianness = IIO_BE,					\
 	},								\
+	.ext_info = adxl372_ext_info,					\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
@@ -277,6 +313,61 @@ static const unsigned long adxl372_channel_masks[] = {
 	0
 };
 
+static ssize_t adxl372_read_threshold_value(struct iio_dev *indio_dev,
+					    uintptr_t private,
+					    const struct iio_chan_spec *chan,
+					    char *buf)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int addr;
+	__be16 __regval;
+	u16 regval;
+	int ret;
+
+	addr = (unsigned int)chan->ext_info->private;
+	addr = addr + chan->scan_index * 2;
+
+	ret = regmap_bulk_read(st->regmap, addr, &__regval, sizeof(__regval));
+	if (ret < 0)
+		return ret;
+
+	regval = be16_to_cpu(__regval);
+	regval >>= 5;
+
+	return sprintf(buf, "%d\n", regval);
+}
+
+static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev,
+					     uintptr_t private,
+					     const struct iio_chan_spec *chan,
+					     const char *buf,
+					     size_t len)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int addr;
+	u16 threshold;
+	int ret;
+
+	ret = kstrtou16(buf, 0, &threshold);
+	if (ret < 0)
+		return ret;
+
+	addr = chan->ext_info->private;
+	addr = addr + chan->scan_index * 2;
+
+	ret = regmap_write(st->regmap, addr,
+			   ADXL372_THRESH_VAL_H_SEL(threshold));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
+				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
-- 
2.20.1

