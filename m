Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86015D4BD
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgBNJ3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 04:29:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35688 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729113AbgBNJ3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 04:29:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E9F1Ah026700;
        Fri, 14 Feb 2020 04:29:39 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1tyqn1fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 04:29:39 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01E9TbxY026363
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Feb 2020 04:29:38 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 14 Feb 2020 01:29:36 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 14 Feb 2020 01:29:36 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 14 Feb 2020 01:29:36 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01E9TVrH029232;
        Fri, 14 Feb 2020 04:29:35 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH 3/5] iio: accel: adxl372: add sysfs for time registers
Date:   Fri, 14 Feb 2020 11:29:17 +0200
Message-ID: <20200214092919.24351-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214092919.24351-1-alexandru.tachici@analog.com>
References: <20200214092919.24351-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_02:2020-02-12,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140076
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently the driver configures adxl372 to work in loop mode.
The inactivity and activity timings  decide how fast the chip
will loop through the awake and waiting states.

This patch adds sysfs entries for the inactivity and activity
shared properties.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 538e5053a946..8bef6f2030ff 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -754,6 +754,70 @@ static IIO_DEVICE_ATTR(peak_fifo_mode_enable, 0644,
 		       adxl372_peak_fifo_en_get,
 		       adxl372_peak_fifo_en_set, 0);
 
+static ssize_t adxl372_time_activity_get(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", st->act_time_ms);
+}
+
+static ssize_t adxl372_time_activity_set(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = adxl372_set_activity_time_ms(st, val);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(time_activity, 0644,
+		       adxl372_time_activity_get,
+		       adxl372_time_activity_set, 0);
+
+static ssize_t adxl372_time_inactivity_get(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", st->inact_time_ms);
+}
+
+static ssize_t adxl372_time_inactivity_set(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = adxl372_set_inactivity_time_ms(st, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(time_inactivity, 0644,
+		       adxl372_time_inactivity_get,
+		       adxl372_time_inactivity_set, 0);
+
 static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -932,6 +996,8 @@ static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_peak_fifo_mode_enable.dev_attr.attr,
+	&iio_dev_attr_time_inactivity.dev_attr.attr,
+	&iio_dev_attr_time_activity.dev_attr.attr,
 	NULL,
 };
 
-- 
2.20.1

