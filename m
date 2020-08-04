Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5623B861
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgHDKDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 06:03:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16210 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbgHDKDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 06:03:19 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074A39Ni004120;
        Tue, 4 Aug 2020 06:03:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n6cjsk1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 06:03:18 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 074A3HHH055531
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Aug 2020 06:03:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 4 Aug 2020
 06:03:16 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 4 Aug 2020 06:03:15 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 074A3CbR002099;
        Tue, 4 Aug 2020 06:03:13 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] iio: imu: adis16480: Add the option to enable/disable burst mode
Date:   Tue, 4 Aug 2020 13:04:14 +0300
Message-ID: <20200804100414.39002-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804100414.39002-1-alexandru.ardelean@analog.com>
References: <20200804100414.39002-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

Although the burst read function does not require a stall time between
each 16-bit segment, it however requires more processing since the
software needs to look for the BURST_ID and take into account the offset
to the first data channel. Some users might find it useful to be able to
switch between the two modes.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 9b100c8fb744..7d7712c33435 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -330,6 +330,45 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
 
 #endif
 
+static ssize_t adis16495_burst_mode_enable_get(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct adis16480 *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", st->adis.burst->en);
+}
+
+static ssize_t adis16495_burst_mode_enable_set(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
+{
+	struct adis16480 *st = iio_priv(dev_to_iio_dev(dev));
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	st->adis.burst->en = val;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(burst_mode_enable, 0644,
+		       adis16495_burst_mode_enable_get,
+		       adis16495_burst_mode_enable_set, 0);
+
+static struct attribute *adis16495_attributes[] = {
+	&iio_dev_attr_burst_mode_enable.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adis16495_attribute_group = {
+	.attrs = adis16495_attributes,
+};
+
 static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
@@ -1131,6 +1170,14 @@ static const struct iio_info adis16480_info = {
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
+static const struct iio_info adis16495_info = {
+	.attrs = &adis16495_attribute_group,
+	.read_raw = &adis16480_read_raw,
+	.write_raw = &adis16480_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
+};
+
 static int adis16480_stop_device(struct iio_dev *indio_dev)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
@@ -1365,6 +1412,7 @@ static int adis16480_probe(struct spi_device *spi)
 	if (st->chip_info->burst) {
 		st->adis.burst = st->chip_info->burst;
 		st->adis.burst_extra_len = st->chip_info->burst->extra_len;
+		indio_dev->info = &adis16495_info;
 	}
 
 	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev,
-- 
2.17.1

