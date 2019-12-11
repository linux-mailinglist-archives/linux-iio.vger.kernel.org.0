Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D0011A914
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 11:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfLKKl6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 05:41:58 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38248 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbfLKKl5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 05:41:57 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBAfM0C017008;
        Wed, 11 Dec 2019 05:41:42 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wraevvh83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:41:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVQHSrKIcBdE6iUBzfcHYnTATqwFEkgkUSJqWPwm82vplYOrWLHJ55Sygf9xYyOdvhP+gWLfou3MIMHPo4PgwJ4hmrfNPMXwXlRdUBCRkDUFegm7dEryk37Zvm+J9Pdw6YSoY6uwhj2d3mzZcESaKqpCD9aC95PIV4QuSUHh0ecPlIKl19fkIQCmw+aWxCwDXYfE77hNTeC/Dg08LV9gsuKEL4N2kK/x2Z+eOVVgbhAH1orQ5NH/Qkc6P+IPAFUghLZgqFMdRN0zqYx4v/dFFKCC04Ykvv2L2AKA6JODHuG6th8pi+zsL2vDx45/2GBzutl4eycSRCfXv9hr7S/3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiHsAVhHeTXfHbTkPF/cNWEUVWUEcAgBIBl30maBM4s=;
 b=kYP3MlJ83w8D1Phn0uCkHkeY9wK96x6yzIQ0khdyOCWNyrqN48gm44MiS5IXCjbveIlbLwiNmeQSKcUo++cYJsoSWjCM4J8hI9IEs2eO2x7UhVA6FYv2HDPyF2VevlmynZ66UcfHv+99rARfR7gXNiuM/KlDqZ89pkY1OuQ8S3HVdN6jIPHG3a1XUIpVr4SiudmHROWTVGNerTPf4NTr9fQvzpqs3Wy3ZfQBnssx+EOz27YUuordch/DddfFQdKxyL8ZnRj8QNJ0txoOONODFS5Oe1BLAYggQWN+UjwjLm4Nbol0TEnwkOTFh4OXPGnknVoWh3MIUmwDaMuxJ+B9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiHsAVhHeTXfHbTkPF/cNWEUVWUEcAgBIBl30maBM4s=;
 b=zBvHV/B1W95X/vfiTjvPsaQRsqTnk5JMuR+UyS3gXemZN/2foctk2wlnArKk60/aVrb0C803tnzD89lrHKkF/pNLe/Tfl26e0uAWMu+pMX16OdBmAwJTLb3LMyqZYDkZnZLpRPYppLby5yzUti58yDH7HUZ8Ea/K8w0ioOQlTo8=
Received: from BN6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:404:23::33)
 by DM6PR03MB4906.namprd03.prod.outlook.com (2603:10b6:5:188::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 10:41:39 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN6PR03CA0023.outlook.office365.com
 (2603:10b6:404:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 10:41:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Wed, 11 Dec 2019 10:41:38 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBBAfcU7012989
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Dec 2019 02:41:38 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Dec
 2019 05:41:37 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Dec 2019 05:41:37 -0500
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBBAfaki006824;
        Wed, 11 Dec 2019 05:41:36 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: rename 'read_first_n' callback to 'read'
Date:   Wed, 11 Dec 2019 12:43:00 +0200
Message-ID: <20191211104300.14113-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(54906003)(110136005)(4326008)(36756003)(7636002)(316002)(70586007)(8676002)(478600001)(107886003)(336012)(186003)(44832011)(1076003)(26005)(8936002)(2616005)(6666004)(86362001)(5660300002)(2906002)(356004)(7696005)(70206006)(246002)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4906;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 314cec72-0293-4b50-0391-08d77e26b402
X-MS-TrafficTypeDiagnostic: DM6PR03MB4906:
X-Microsoft-Antispam-PRVS: <DM6PR03MB490682E62C314CD88861935DF95A0@DM6PR03MB4906.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejWCO7Ej+bDwakFT37HmrmhjsrI2AZ0o7qM8o2qM17Uajva793i8aN+NIqfGJaXQrvaQtvsQvNTCzLlHow1hjS4Q+raLx6+Kn2rhDgCJBqZvQbVHBdCKDA+SuNzeKhLu/NKlD5HjKeJ9rA+kk+nINXn/VS847PMy7MUT/yT5jcXTBhp0CClw9UTZOKIbsvre4wnP5/yrALZmbFdIKslay1wYK2rNYpOtoRUVRPa1EglhRwlKhLn6wuDE5wQCyXUrC0GJ6WSGykdURVPzvKe3PQQm7XVcII0ayq7QlR+Dd0GzMMlTnJxEcH6NLtZrtcMbd2g9w4TGmf/MFor/MaIb+j50MW3bg1W1dq1tMp/kI0pv+6QPrOKWprj6kVz6/bkbjS2BUspIMEp8mxFDULglZms5NhiYQbBLGVr+wNVukHHB4B+nT6MydakLpdArn3F6
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 10:41:38.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314cec72-0293-4b50-0391-08d77e26b402
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4906
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_02:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=2 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110094
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

It is implied that 'read' will read the first n bytes and not e.g. bytes
only from offsets within the buffer that are a prime number.

This change is non-functional, mostly just a rename.
A secondary intent with this patch is to make room later to add a write
callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c       |  2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +-
 drivers/iio/buffer/kfifo_buf.c                     |  5 ++---
 drivers/iio/iio_core.h                             |  8 ++++----
 drivers/iio/industrialio-buffer.c                  | 10 +++++-----
 drivers/iio/industrialio-core.c                    |  2 +-
 include/linux/iio/buffer_impl.h                    |  6 ++----
 7 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 90cf6e586b10..a74bd9c0587c 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -476,7 +476,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
  * @n: Number of bytes to read
  * @user_buffer: Userspace buffer to copy the data to
  *
- * Should be used as the read_first_n callback for iio_buffer_access_ops
+ * Should be used as the read callback for iio_buffer_access_ops
  * struct for DMA buffers.
  */
 int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index e0b92f3dec0e..7d298aaff1f0 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -108,7 +108,7 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
 }
 
 static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
-	.read_first_n = iio_dma_buffer_read,
+	.read = iio_dma_buffer_read,
 	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
 	.set_length = iio_dma_buffer_set_length,
 	.request_update = iio_dma_buffer_request_update,
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index e78fc0834e6b..3150f8ab984b 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -98,8 +98,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 	return 0;
 }
 
-static int iio_read_first_n_kfifo(struct iio_buffer *r,
-			   size_t n, char __user *buf)
+static int iio_read_kfifo(struct iio_buffer *r, size_t n, char __user *buf)
 {
 	int ret, copied;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
@@ -141,7 +140,7 @@ static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
 
 static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.store_to = &iio_store_to_kfifo,
-	.read_first_n = &iio_read_first_n_kfifo,
+	.read = &iio_read_kfifo,
 	.data_available = iio_kfifo_buf_data_available,
 	.request_update = &iio_request_update_kfifo,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 159ea3f8c02b..fd9a5f1d5e51 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -42,14 +42,14 @@ struct poll_table_struct;
 
 __poll_t iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait);
-ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
-				      size_t n, loff_t *f_ps);
+ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
+			      size_t n, loff_t *f_ps);
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
 #define iio_buffer_poll_addr (&iio_buffer_poll)
-#define iio_buffer_read_first_n_outer_addr (&iio_buffer_read_first_n_outer)
+#define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
@@ -57,7 +57,7 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 #else
 
 #define iio_buffer_poll_addr NULL
-#define iio_buffer_read_first_n_outer_addr NULL
+#define iio_buffer_read_outer_addr NULL
 
 static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c193d64e5217..dbbf0cf4cac9 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -87,7 +87,7 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
 }
 
 /**
- * iio_buffer_read_first_n_outer() - chrdev read for buffer access
+ * iio_buffer_read_outer() - chrdev read for buffer access
  * @filp:	File structure pointer for the char device
  * @buf:	Destination buffer for iio buffer read
  * @n:		First n bytes to read
@@ -99,8 +99,8 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
  * Return: negative values corresponding to error codes or ret != 0
  *	   for ending the reading activity
  **/
-ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
-				      size_t n, loff_t *f_ps)
+ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
+			      size_t n, loff_t *f_ps)
 {
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
@@ -112,7 +112,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	if (!indio_dev->info)
 		return -ENODEV;
 
-	if (!rb || !rb->access->read_first_n)
+	if (!rb || !rb->access->read)
 		return -EINVAL;
 
 	datum_size = rb->bytes_per_datum;
@@ -147,7 +147,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 			continue;
 		}
 
-		ret = rb->access->read_first_n(rb, n, buf);
+		ret = rb->access->read(rb, n, buf);
 		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
 			ret = -EAGAIN;
 	} while (ret == 0);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f72c2dc5f703..5fd33644df1f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1617,7 +1617,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 }
 
 static const struct file_operations iio_buffer_fileops = {
-	.read = iio_buffer_read_first_n_outer_addr,
+	.read = iio_buffer_read_outer_addr,
 	.release = iio_chrdev_release,
 	.open = iio_chrdev_open,
 	.poll = iio_buffer_poll_addr,
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index d1171db23742..a4d2d8061ef6 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -18,7 +18,7 @@ struct iio_buffer;
 /**
  * struct iio_buffer_access_funcs - access functions for buffers.
  * @store_to:		actually store stuff to the buffer
- * @read_first_n:	try to get a specified number of bytes (must exist)
+ * @read:		try to get a specified number of bytes (must exist)
  * @data_available:	indicates how much data is available for reading from
  *			the buffer.
  * @request_update:	if a parameter change has been marked, update underlying
@@ -45,9 +45,7 @@ struct iio_buffer;
  **/
 struct iio_buffer_access_funcs {
 	int (*store_to)(struct iio_buffer *buffer, const void *data);
-	int (*read_first_n)(struct iio_buffer *buffer,
-			    size_t n,
-			    char __user *buf);
+	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
 	size_t (*data_available)(struct iio_buffer *buffer);
 
 	int (*request_update)(struct iio_buffer *buffer);
-- 
2.20.1

