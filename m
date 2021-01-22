Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A81300A29
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbhAVR2F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 12:28:05 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21490 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729173AbhAVP4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:20 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFV0Du019196;
        Fri, 22 Jan 2021 10:55:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rbtjq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:27 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtQBw002559
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 10:55:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 22 Jan 2021
 10:55:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 22 Jan 2021 10:55:25 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF58014933;
        Fri, 22 Jan 2021 10:55:23 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 05/12] iio: core: split __iio_device_attr_init() to init only the attr object
Date:   Fri, 22 Jan 2021 17:57:58 +0200
Message-ID: <20210122155805.83012-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122155805.83012-1-alexandru.ardelean@analog.com>
References: <20210122155805.83012-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The __iio_device_attr_init() function initializes a device_attribute
object, but mostly it just does a lot of name creation logic.

We will want to re-use this logic for name-creation, so this change
re-purposes the __iio_device_attr_init() to be a __iio_attr_init() function
which just handles the creation of the attribute name.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 43 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 95d66745f118..b8f7261945f5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -968,22 +968,15 @@ static ssize_t iio_write_channel_info(struct device *dev,
 }
 
 static
-int __iio_device_attr_init(struct device_attribute *dev_attr,
-			   const char *postfix,
-			   struct iio_chan_spec const *chan,
-			   ssize_t (*readfunc)(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf),
-			   ssize_t (*writefunc)(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf,
-						size_t len),
-			   enum iio_shared_by shared_by)
+int iio_attr_init(struct attribute *attr,
+		  const char *postfix,
+		  struct iio_chan_spec const *chan,
+		  enum iio_shared_by shared_by)
 {
 	int ret = 0;
 	char *name = NULL;
 	char *full_postfix;
-	sysfs_attr_init(&dev_attr->attr);
+	sysfs_attr_init(attr);
 
 	/* Build up postfix of <extend_name>_<modifier>_postfix */
 	if (chan->modified && (shared_by == IIO_SEPARATE)) {
@@ -1079,17 +1072,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		ret = -ENOMEM;
 		goto error_free_full_postfix;
 	}
-	dev_attr->attr.name = name;
-
-	if (readfunc) {
-		dev_attr->attr.mode |= S_IRUGO;
-		dev_attr->show = readfunc;
-	}
-
-	if (writefunc) {
-		dev_attr->attr.mode |= S_IWUSR;
-		dev_attr->store = writefunc;
-	}
+	attr->name = name;
 
 error_free_full_postfix:
 	kfree(full_postfix);
@@ -1122,9 +1105,7 @@ int __iio_add_chan_devattr(const char *postfix,
 	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
 	if (iio_attr == NULL)
 		return -ENOMEM;
-	ret = __iio_device_attr_init(&iio_attr->dev_attr,
-				     postfix, chan,
-				     readfunc, writefunc, shared_by);
+	ret = iio_attr_init(&iio_attr->dev_attr.attr, postfix, chan, shared_by);
 	if (ret)
 		goto error_iio_dev_attr_free;
 	iio_attr->c = chan;
@@ -1140,6 +1121,16 @@ int __iio_add_chan_devattr(const char *postfix,
 		}
 	list_add(&iio_attr->l, attr_list);
 
+	if (readfunc) {
+		iio_attr->dev_attr.attr.mode |= S_IRUGO;
+		iio_attr->dev_attr.show = readfunc;
+	}
+
+	if (writefunc) {
+		iio_attr->dev_attr.attr.mode |= S_IWUSR;
+		iio_attr->dev_attr.store = writefunc;
+	}
+
 	return 0;
 
 error_device_attr_deinit:
-- 
2.17.1

