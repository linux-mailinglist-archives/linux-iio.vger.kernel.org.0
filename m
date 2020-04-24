Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C81B6CD8
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 06:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDXE4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 00:56:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38804 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXE4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 00:56:41 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O4o4ds030564;
        Fri, 24 Apr 2020 00:56:27 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud7n63y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 00:56:27 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03O4uQ89016518
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 00:56:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 00:56:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 00:56:25 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 24 Apr 2020 00:56:24 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O4uGpn017534;
        Fri, 24 Apr 2020 00:56:23 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v4 4/7] iio: core: register chardev only if needed
Date:   Fri, 24 Apr 2020 07:56:39 +0300
Message-ID: <20200424045642.4903-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424045642.4903-1-alexandru.ardelean@analog.com>
References: <20200424045642.4903-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The final intent is to localize all buffer ops into the
industrialio-buffer.c file, to be able to add support for multiple buffers
per IIO device.

We only need a chardev if we need to support buffers and/or events.

With this change, a chardev will be created only if an IIO buffer is
attached OR an event_interface is configured.

Otherwise, no chardev will be created, and the IIO device will get
registered with the 'device_add()' call.

Quite a lot of IIO devices don't really need a chardev, so this is a minor
improvement to the IIO core, as the IIO device will take up (slightly)
fewer resources.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bac865ff673e..03f5b5baeb94 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1676,6 +1676,15 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
+static const struct file_operations iio_event_fileops = {
+	.release = iio_chrdev_release,
+	.open = iio_chrdev_open,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	int ret;
@@ -1726,11 +1735,18 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	if (indio_dev->buffer)
+		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	else if (indio_dev->event_interface)
+		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
 
 	indio_dev->chrdev.owner = this_mod;
 
-	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
+	if (indio_dev->buffer || indio_dev->event_interface)
+		ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
+	else
+		ret = device_add(&indio_dev->dev);
+
 	if (ret < 0)
 		goto error_unreg_eventset;
 
@@ -1754,7 +1770,10 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
-	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+	if (indio_dev->buffer || indio_dev->event_interface)
+		cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+	else
+		device_del(&indio_dev->dev);
 
 	mutex_lock(&indio_dev->info_exist_lock);
 
-- 
2.17.1

