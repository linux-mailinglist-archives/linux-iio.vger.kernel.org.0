Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7924FA6F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 11:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgHXJ4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 05:56:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5172 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728211AbgHXIgG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 04:36:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07O8S0Fa010434;
        Mon, 24 Aug 2020 04:36:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 333094wgka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 04:36:04 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07O8a351003516
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Aug 2020 04:36:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 24 Aug
 2020 04:36:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 24 Aug 2020 04:36:02 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07O8a0Lg005561;
        Mon, 24 Aug 2020 04:36:00 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [RFC PATCH v2] iio: core: Add optional symbolic label to a device channel
Date:   Mon, 24 Aug 2020 11:36:46 +0300
Message-ID: <20200824083646.84886-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_07:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this channel add that
to the channel specific attributes. This is useful for userspace to
be able to identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 Changes in v2:
	- Move label check before "read_raw" callback.
	- Move the responsability to of parsing channel labels, to the
	  driver.

 drivers/iio/industrialio-core.c | 10 ++++++++--
 include/linux/iio/iio.h         |  2 ++
 include/linux/iio/types.h       |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..32277e94f02d 100644
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
@@ -1399,6 +1404,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 			attrcount_orig++;
 	}
 	attrcount = attrcount_orig;
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

