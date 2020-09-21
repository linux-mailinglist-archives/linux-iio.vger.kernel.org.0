Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8848272589
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUNak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 09:30:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6894 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgIUNak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 09:30:40 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LDUFaG022846;
        Mon, 21 Sep 2020 09:30:39 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33nbu66g8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:30:39 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08LDUbYd035454
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Sep 2020 09:30:37 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 21 Sep
 2020 06:30:38 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Sep 2020 06:30:38 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08LDUW2E021472;
        Mon, 21 Sep 2020 09:30:32 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v6 1/4] iio: core: Add optional symbolic label to a device channel
Date:   Mon, 21 Sep 2020 16:30:17 +0300
Message-ID: <20200921133020.62978-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_05:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this channel add that
to the channel specific attributes. This is useful for userspace to
be able to identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in V6:
 - Fix indentation
 - Check for "read_label callback" inside "iio_device_add_channel_label"
 
 drivers/iio/industrialio-core.c | 40 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  6 +++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6e388293c828..b577fff35641 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -669,6 +669,19 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 }
 EXPORT_SYMBOL_GPL(iio_format_value);
 
+static ssize_t iio_read_channel_label(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (!indio_dev->info->read_label)
+		return -EINVAL;
+
+	return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1137,6 +1150,28 @@ int __iio_add_chan_devattr(const char *postfix,
 	return ret;
 }
 
+static int iio_device_add_channel_label(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan)
+{
+	int ret;
+
+	if (!indio_dev->info->read_label)
+		return 0;
+
+	ret = __iio_add_chan_devattr("label",
+				     chan,
+				     &iio_read_channel_label,
+				     NULL,
+				     0,
+				     IIO_SEPARATE,
+				     &indio_dev->dev,
+				     &indio_dev->channel_attr_list);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
@@ -1270,6 +1305,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_channel_label(indio_dev, chan);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2e45b3ceafa7..9a3cf4815148 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -362,6 +362,8 @@ struct iio_trigger; /* forward declaration */
  *			and max. For lists, all possible values are enumerated.
  * @write_raw:		function to write a value to the device.
  *			Parameters are the same as for read_raw.
+ * @read_label:		function to request label name for a specified label,
+ *			for better channel identification.
  * @write_raw_get_fmt:	callback function to query the expected
  *			format/precision. If not set by the driver, write_raw
  *			returns IIO_VAL_INT_PLUS_MICRO.
@@ -420,6 +422,10 @@ struct iio_info {
 			 int val2,
 			 long mask);
 
+	int (*read_label)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 char *label);
+
 	int (*write_raw_get_fmt)(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 long mask);
-- 
2.17.1

