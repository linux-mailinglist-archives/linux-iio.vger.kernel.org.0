Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD22427B9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Aug 2020 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgHLJho (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Aug 2020 05:37:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10388 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbgHLJhn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2020 05:37:43 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07C9IUGi019108;
        Wed, 12 Aug 2020 05:37:41 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32sry4d0bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 05:37:41 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07C9bd99015869
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Aug 2020 05:37:40 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 12 Aug
 2020 02:37:38 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Aug 2020 02:37:38 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07C9batL011908;
        Wed, 12 Aug 2020 05:37:36 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [RFC PATCH] iio: core: Add optional symbolic label to a device channel
Date:   Wed, 12 Aug 2020 12:38:29 +0300
Message-ID: <20200812093829.7354-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-12_02:2020-08-11,2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this channel add that
to the channel specific attributes. This is useful for userspace to
be able to identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/industrialio-core.c | 45 +++++++++++++++++++++++++++++++--
 include/linux/iio/iio.h         |  2 ++
 include/linux/iio/types.h       |  1 +
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..d7c2405bc905 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -135,6 +135,7 @@ static const char * const iio_modifier_names[] = {
 /* relies on pairs of these shared then separate */
 static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_RAW] = "raw",
+	[IIO_CHAN_INFO_LABEL] = "label",
 	[IIO_CHAN_INFO_PROCESSED] = "input",
 	[IIO_CHAN_INFO_SCALE] = "scale",
 	[IIO_CHAN_INFO_OFFSET] = "offset",
@@ -653,14 +654,18 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	int ret;
 	int val_len = 2;
 
-	if (indio_dev->info->read_raw_multi)
+	if (indio_dev->info->read_raw_multi) {
 		ret = indio_dev->info->read_raw_multi(indio_dev, this_attr->c,
 							INDIO_MAX_RAW_ELEMENTS,
 							vals, &val_len,
 							this_attr->address);
-	else
+	} else {
 		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 				    &vals[0], &vals[1], this_attr->address);
+		if (ret < 0 && this_attr->address == IIO_CHAN_INFO_LABEL &&
+			this_attr->c->label_name)
+			return sprintf(buf, "%s\n", this_attr->c->label_name);
+	}
 
 	if (ret < 0)
 		return ret;
@@ -1383,6 +1388,37 @@ static ssize_t iio_store_timestamp_clock(struct device *dev,
 	return len;
 }
 
+static int iio_device_add_channel_label(struct iio_dev *indio_dev,
+					struct device_node *np)
+{
+	unsigned int num_child;
+	struct iio_chan_spec *chan;
+	struct device_node *child;
+	const char *label;
+	int crt_ch = 0;
+
+	num_child = of_get_available_child_count(np);
+	if (!num_child)
+		return 0;
+
+	for_each_available_child_of_node(np, child) {
+		if (of_property_read_u32(child, "reg", &crt_ch))
+			continue;
+
+		if (crt_ch >= indio_dev->num_channels)
+			continue;
+
+		if (of_property_read_string(child, "label", &label))
+			continue;
+
+		chan = (struct iio_chan_spec *)&indio_dev->channels[crt_ch];
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_LABEL);
+		chan->label_name = label;
+	}
+
+	return 0;
+}
+
 static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
 		   iio_show_timestamp_clock, iio_store_timestamp_clock);
 
@@ -1399,6 +1435,11 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 			attrcount_orig++;
 	}
 	attrcount = attrcount_orig;
+
+	ret = iio_device_add_channel_label(indio_dev, indio_dev->dev.parent->of_node);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * New channel registration method - relies on the fact a group does
 	 * not need to be initialized if its name is NULL.
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a1be82e74c93..39209f3b62be 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -223,6 +223,7 @@ struct iio_event_spec {
  *			correspond to the first name that the channel is referred
  *			to by in the datasheet (e.g. IND), or the nearest
  *			possible compound name (e.g. IND-INC).
+ * @label_name:		Unique name to identify which channel this is.
  * @modified:		Does a modifier apply to this channel. What these are
  *			depends on the channel type.  Modifier is set in
  *			channel2. Examples are IIO_MOD_X for axial sensors about
@@ -260,6 +261,7 @@ struct iio_chan_spec {
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
 	const char		*datasheet_name;
+	const char		*label_name;
 	unsigned		modified:1;
 	unsigned		indexed:1;
 	unsigned		output:1;
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index e6fd3645963c..c8f65f476eb2 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -34,6 +34,7 @@ enum iio_available_type {
 
 enum iio_chan_info_enum {
 	IIO_CHAN_INFO_RAW = 0,
+	IIO_CHAN_INFO_LABEL,
 	IIO_CHAN_INFO_PROCESSED,
 	IIO_CHAN_INFO_SCALE,
 	IIO_CHAN_INFO_OFFSET,
-- 
2.17.1

