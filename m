Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9229916C069
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgBYMJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:09:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6766 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729566AbgBYMJa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:09:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC4sHJ012678;
        Tue, 25 Feb 2020 07:09:29 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yay1brsve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:09:29 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PC9Sf7012332
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:09:28 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 07:09:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 07:09:27 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 07:09:26 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PC9N1E003238;
        Tue, 25 Feb 2020 07:09:26 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 2/6] iio: accel: adxl372: add sysfs for time registers
Date:   Tue, 25 Feb 2020 14:09:05 +0200
Message-ID: <20200225120909.12629-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225120909.12629-1-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently the driver configures adxl372 to work in loop mode.
The inactivity and activity timings  decide how fast the chip
will loop through the awake and waiting states.

This patch adds standard events sysfs entries for the inactivity
and activity timings: thresh_falling_period/thresh_rising_period.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index ed93534f8dba..5da3c924c62d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -222,6 +222,18 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
 };
 
+static const struct iio_event_spec adxl372_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -238,6 +250,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 		.storagebits = 16,					\
 		.shift = 4,						\
 	},								\
+	.event_spec = adxl372_events,					\
+	.num_event_specs = 2						\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
@@ -723,6 +737,58 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+int adxl372_read_event_value(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir,
+			     enum iio_event_info info, int *val, int *val2)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = st->act_time_ms;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			*val = st->inact_time_ms;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+int adxl372_write_event_value(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info, int val, int val2)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int val_ms;
+
+	switch (info) {
+	case IIO_EV_INFO_PERIOD:
+		val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl372_set_activity_time_ms(st, val_ms);
+		case IIO_EV_DIR_FALLING:
+			return adxl372_set_inactivity_time_ms(st, val_ms);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -952,6 +1018,8 @@ static const struct iio_info adxl372_info = {
 	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
 	.write_raw = adxl372_write_raw,
+	.read_event_value = adxl372_read_event_value,
+	.write_event_value = adxl372_write_event_value,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.20.1

