Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4915D4BB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 10:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBNJ3i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 04:29:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33086 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728807AbgBNJ3h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 04:29:37 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E9GcYG003460;
        Fri, 14 Feb 2020 04:29:36 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udn4rjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 04:29:36 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01E9TZZp059242
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Feb 2020 04:29:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 14 Feb
 2020 04:29:34 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 14 Feb 2020 04:29:34 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01E9TVrF029232;
        Fri, 14 Feb 2020 04:29:33 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH 1/5] iio: accel: adxl372: Add support for FIFO peak mode
Date:   Fri, 14 Feb 2020 11:29:15 +0200
Message-ID: <20200214092919.24351-2-alexandru.tachici@analog.com>
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
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140076
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

By default, if all three channels (x, y, z) are enabled, sample sets of
concurrent 3-axis data is stored in the FIFO. This patch adds the option
to configure the FIFO to store peak acceleration (x, y and z) of every
over-threshold event. Since we cannot store 1 or 2 axis peak acceleration
data in the FIFO, then all three axis need to be enabled in order for this
mode to work.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 67b8817995c0..bb6c2bf1a457 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -264,6 +264,7 @@ struct adxl372_state {
 	u8				int2_bitmask;
 	u16				watermark;
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
+	bool				peak_fifo_mode_en;
 };
 
 static const unsigned long adxl372_channel_masks[] = {
@@ -722,6 +723,36 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", st->peak_fifo_mode_en);
+}
+
+static ssize_t adxl372_peak_fifo_en_set(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	st->peak_fifo_mode_en = val;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(peak_fifo_mode_enable, 0644,
+		       adxl372_peak_fifo_en_get,
+		       adxl372_peak_fifo_en_set, 0);
+
 static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -817,11 +848,16 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
 					  indio_dev->masklength);
+
+	/* Configure the FIFO to store sets of impact event peak. */
+	if (st->fifo_set_size == 3 && st->peak_fifo_mode_en)
+		st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
 	/*
 	 * The 512 FIFO samples can be allotted in several ways, such as:
 	 * 170 sample sets of concurrent 3-axis data
 	 * 256 sample sets of concurrent 2-axis data (user selectable)
 	 * 512 sample sets of single-axis data
+	 * 170 sets of impact event peak (x, y, z)
 	 */
 	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
 		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
@@ -894,6 +930,7 @@ static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
 static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
+	&iio_dev_attr_peak_fifo_mode_enable.dev_attr.attr,
 	NULL,
 };
 
-- 
2.20.1

