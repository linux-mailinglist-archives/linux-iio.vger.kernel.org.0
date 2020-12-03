Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668C02CD30C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 10:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgLCJ5q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 04:57:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56730 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730121AbgLCJ5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 04:57:46 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B39tR0N005837;
        Thu, 3 Dec 2020 04:56:53 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vj5n7uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 04:56:53 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B39uoYu008262
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 04:56:50 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 01:56:48 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 01:56:48 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 01:56:48 -0800
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B39ukah003105;
        Thu, 3 Dec 2020 04:56:47 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: core: split __iio_device_attr_init() to init only the attr object
Date:   Thu, 3 Dec 2020 11:56:42 +0200
Message-ID: <20201203095642.74622-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030059
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

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20201117162340.43924-6-alexandru.ardelean@analog.com/
* split away from series; I don't know when I will have time to re-visit
  the entire original series, so might as well move forward a few patches

 drivers/iio/industrialio-core.c | 43 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1da7e518435a..5bfcee277879 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -935,22 +935,15 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
@@ -1046,17 +1039,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
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
@@ -1089,9 +1072,7 @@ int __iio_add_chan_devattr(const char *postfix,
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
@@ -1107,6 +1088,16 @@ int __iio_add_chan_devattr(const char *postfix,
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
2.27.0

