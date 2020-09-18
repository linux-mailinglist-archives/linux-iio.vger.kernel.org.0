Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87CE26FAA7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRKds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 06:33:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63460 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgIRKdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 06:33:47 -0400
X-Greylist: delayed 3634 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 06:33:47 EDT
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I9TaMb029138;
        Fri, 18 Sep 2020 05:33:12 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p69wq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 05:33:12 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08I9XBXu046127
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Sep 2020 05:33:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 18 Sep
 2020 05:33:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 18 Sep 2020 05:33:15 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08I9X71p024012;
        Fri, 18 Sep 2020 05:33:07 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v5] iio: core: Add optional symbolic label to a device channel
Date:   Fri, 18 Sep 2020 12:33:02 +0300
Message-ID: <20200918093302.93527-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_11:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180079
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this channel add that
to the channel specific attributes. This is useful for userspace to
be able to identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in V5:
	Create patch for single commits.
 drivers/iio/industrialio-core.c | 41 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  6 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..49868e080840 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -643,6 +643,21 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 }
 EXPORT_SYMBOL_GPL(iio_format_value);
 
+static ssize_t iio_read_channel_label(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (indio_dev->info->read_label)
+		return indio_dev->info->read_label(indio_dev,
+							this_attr->c,
+							buf);
+	else
+		return -EINVAL;
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1111,6 +1126,25 @@ int __iio_add_chan_devattr(const char *postfix,
 	return ret;
 }
 
+static int iio_device_add_channel_label(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan)
+{
+	int ret;
+
+	ret = __iio_add_chan_devattr("label",
+					chan,
+					&iio_read_channel_label,
+					NULL,
+					0,
+					IIO_SEPARATE,
+					&indio_dev->dev,
+					&indio_dev->channel_attr_list);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
@@ -1241,6 +1275,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	if (indio_dev->info->read_label) {
+		ret = iio_device_add_channel_label(indio_dev, chan);
+		if (ret < 0)
+			return ret;
+		attrcount += ret;
+	}
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a1be82e74c93..58b151f5321d 100644
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

