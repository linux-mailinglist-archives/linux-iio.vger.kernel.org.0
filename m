Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27299318A6C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBKMZ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:25:56 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14470 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231947AbhBKMXh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:23:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCMj8k016267;
        Thu, 11 Feb 2021 07:22:45 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qg8ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:22:45 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCMhJq004243
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:22:43 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 04:22:42 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 11 Feb 2021 04:22:42 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 11 Feb 2021 04:22:42 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWa011557;
        Thu, 11 Feb 2021 07:22:38 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 02/17] iio: core: register chardev only if needed
Date:   Thu, 11 Feb 2021 14:24:37 +0200
Message-ID: <20210211122452.78106-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_05:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
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

This change has a small chance of breaking some userspace ABI, because it
removes un-needed chardevs. While these chardevs (that are being removed)
have always been unusable, it is likely that some scripts may check their
existence (for whatever logic).
And we also hope that before opening these chardevs, userspace would have
already checked for some pre-conditions to make sure that opening these
chardevs makes sense.
For the most part, there is also the hope that it would be easier to change
userspace code than revert this. But in the case that reverting this is
required, it should be easy enough to do it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 7db761afa578..0a6fd299a978 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1761,6 +1761,15 @@ static const struct file_operations iio_buffer_fileops = {
 	.release = iio_chrdev_release,
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
@@ -1788,6 +1797,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int ret;
 
 	if (!indio_dev->info)
@@ -1805,9 +1815,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		return ret;
 
-	/* configure elements for the chrdev */
-	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
-
 	iio_device_register_debugfs(indio_dev);
 
 	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
@@ -1836,9 +1843,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
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

