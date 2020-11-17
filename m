Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5756A2B69D6
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKQQTA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:19:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbgKQQTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:19:00 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGImiG028487;
        Tue, 17 Nov 2020 11:18:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td199y78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:42 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIXQr044675
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:33 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Nov
 2020 08:18:31 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 08:18:31 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTN032565;
        Tue, 17 Nov 2020 11:18:29 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 01/12] iio: core: register chardev only if needed
Date:   Tue, 17 Nov 2020 18:23:29 +0200
Message-ID: <20201117162340.43924-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_04:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We only need a chardev if we need to support buffers and/or events.

With this change, a chardev will be created only if an IIO buffer is
attached OR an event_interface is configured.

Otherwise, no chardev will be created, and the IIO device will get
registered with the 'device_add()' call.

Quite a lot of IIO devices don't really need a chardev, so this is a minor
improvement to the IIO core, as the IIO device will take up (slightly)
fewer resources.

In order to not create a chardev, we mostly just need to not initialize the
indio_dev->dev.devt field. If that is un-initialized, cdev_device_add()
behaves like device_add().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 419d6f8acc13..ca8b11541477 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1763,6 +1763,15 @@ static const struct file_operations iio_buffer_fileops = {
 	.compat_ioctl = compat_ptr_ioctl,
 };
 
+static const struct file_operations iio_event_fileops = {
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.open = iio_chrdev_open,
+	.release = iio_chrdev_release,
+};
+
 static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 {
 	int i, j;
@@ -1790,6 +1799,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int ret;
 
 	if (!indio_dev->info)
@@ -1807,9 +1817,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		return ret;
 
-	/* configure elements for the chrdev */
-	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
-
 	iio_device_register_debugfs(indio_dev);
 
 	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
@@ -1838,9 +1845,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	if (indio_dev->buffer)
+		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	else if (iio_dev_opaque->event_interface)
+		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
 
-	indio_dev->chrdev.owner = this_mod;
+	if (indio_dev->buffer || iio_dev_opaque->event_interface) {
+		indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
+		indio_dev->chrdev.owner = this_mod;
+	}
 
 	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
 	if (ret < 0)
-- 
2.17.1

