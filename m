Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077AF11AA44
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 12:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLKLzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 06:55:11 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:6578 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbfLKLzL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 06:55:11 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBBkK1w030183;
        Wed, 11 Dec 2019 06:54:56 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wragqcs6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 06:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKef25idFAfxdJpX++bgP2QPmDF23o4qqflrAuTUaqqZ4iDBbCc6Ym6OpnPZNmK55tJeYjc4SeAVr3daQxSE3wN5WNXW9Bef2dhc9IWt60Bi0whBCS+jUdDgGB/9kg+cMWLYGZLjyExQNtU1+MVtpvWDtbrDdjhtFCeiOr0IIFmnZs7fmwuXoA+TZfWOM5Zvr+Q3WUkSSIrGRKMOhVYtLHZzzdD7uztP8jkfv+498oxVSx+wKsV5ftkH567f/rBWR9HDkwwkmILIUqBhcZiMcFNsePUeW3BQJ98XXtIrFjvXK3c/jQRShZIMl9TW2y4/14tSoo4LI5R0Vz9NuOTdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA7N58gC/CkRiHvMYuLU4l7jGXzjGI2tRGSleCIo7Jw=;
 b=bNKmg3f85GxD7VmFE91JeUo4y/JeW2ggxdUZdn7D5I+xiBKx7ZCGRzVIWoscamPSyZNoKHkOuss3QL6SEQEv7K4wPm1jJlsrVrYiLdUHJB6X2nCLaFH/LGcWD3ICML3OUIMBvT3hd6zpYlq6yCcNBVNjxptAGaR/nCvqXkqiEYr+LbupBwl5OcxPailUbzL+VD8NRRKX4gYv3uDzuS3/lSACDi/WF2enjQ0nR5x/f6+7syDpJqtuEPV2Q9NoPZccbG5/9KULBnnOOn+5s3Id3V9Xchnfs2oZWdUx4pcj4zJFlL1SfIi7Tb8jNsH0g0/TwoGdSXlfOlmvwjx2jsTKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA7N58gC/CkRiHvMYuLU4l7jGXzjGI2tRGSleCIo7Jw=;
 b=1uK2iYl+mP4ev7FpFBlhrjSgy211WG2Mxp4w8afIauBTKvtoFb7v9SXFoRm6PX8cW7v9FXwOHE4tFEyu+ZOZ9LZNAQCIEQmwZZTMyUMNL+Xp3JH7Y8Ro9gdgJcLJnlZoXZVOHVwhmHU5fOzkpCPjTfwjnpsTjnNjPgXYKRkfAh4=
Received: from DM3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:0:50::33) by
 MN2PR03MB4864.namprd03.prod.outlook.com (2603:10b6:208:105::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Wed, 11 Dec
 2019 11:54:54 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by DM3PR03CA0023.outlook.office365.com
 (2603:10b6:0:50::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 11 Dec 2019 11:54:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Wed, 11 Dec 2019 11:54:54 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBBBsrMc029526
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Dec 2019 03:54:53 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.105) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Dec 2019 06:54:53 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Dec 2019 03:54:53 -0800
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBBBsoMb010627;
        Wed, 11 Dec 2019 06:54:51 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer-dmaengine: Report buffer length requirements
Date:   Wed, 11 Dec 2019 13:56:15 +0200
Message-ID: <20191211115615.9660-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(36756003)(70586007)(356004)(6666004)(5660300002)(70206006)(1076003)(316002)(4326008)(478600001)(107886003)(336012)(2616005)(426003)(110136005)(7696005)(2906002)(44832011)(26005)(186003)(8676002)(8936002)(86362001)(246002)(7636002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4864;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 895e1e1e-c50e-44f9-f9df-08d77e30eff9
X-MS-TrafficTypeDiagnostic: MN2PR03MB4864:
X-Microsoft-Antispam-PRVS: <MN2PR03MB4864E4590E643C48E3DB15E8F95A0@MN2PR03MB4864.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +opv+UyWRJLzcoMQ9eCbkMysK605EBrbmew+Dc9jXKcG5lptQrK2/x3fTVP4a9l6/l83yN1sQNH4y1GujKQw2O22l4B+6EN8Qgebpfx3c5P0tm0o+O9EClux94yFuYqxmAO01Qlge0jyy1udUy4RE3XdGk1y9lCnOI3et46tG90h2uHlHoMmUlYu67s5trDUNNdceWltGutcRrDdJX61PMY36woJ6EfuASUWE81GrPHVMrzof9Hy4A5BotYShHoayo4b1kTT+4TSclQgCcw1wticKBvD1EHuQQ6Y3ch1sZG5w3YlAmbqv8NDgDQ58AZKsV9w/Zg7DnhUP4j9k+XDFLMeVvNMBQI3cZHI4G9MFTcVIycmz6Wb4h3rzCTRLBSXdiIBXCN8/ygWW7KLJJ1mcM+hEK3ZK6kZ5RsD6z8jwfTYvDNAZrnAYn1ZnhrUUzkh
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 11:54:54.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895e1e1e-c50e-44f9-f9df-08d77e30eff9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4864
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_02:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The dmaengine buffer has some length alignment requirements that can differ
from platform to platform. If the length alignment requirements are not met
unexpected behavior like dropping of samples can occur.

Currently these requirements are not reported and applications need to know
the requirements of the platform by some out-of-band means.

Add a new buffer attribute that reports the length alignment requirements
called `length_align_bytes`. The reported length alignment is in bytes that
means the buffer length alignment in sample sets depends on the number of
enabled channels and the bytes per channel. Applications using this
attribute to determine the buffer size requirements need to consider this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dma-buffer      | 19 +++++++++++++++++
 .../buffer/industrialio-buffer-dmaengine.c    | 21 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
new file mode 100644
index 000000000000..999de481de82
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
@@ -0,0 +1,19 @@
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/length_align_bytes
+KernelVersion:	5.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		DMA buffers tend to have a alignment requirement for the
+		buffers. If this alignment requirement is not met samples might
+		be dropped from the buffer.
+
+		This property reports the alignment requirements in bytes. This means
+		that the buffer size in bytes needs to be a integer multiple of the
+		number reported by this file.
+
+		The alignment requirements in number of sample sets will depend on the
+		enabled channels and the bytes per channel. This means that the
+		alignment requirement in samples sets might change depending on which
+		and how many channels are enabled. Whereas the alignment requirement
+		reported in bytes by this property will remain static and does not
+		depend on which channels are
+		enabled.
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 7d298aaff1f0..b129693af0fd 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
@@ -126,6 +127,24 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
 	.abort = iio_dmaengine_buffer_abort,
 };
 
+static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct dmaengine_buffer *dmaengine_buffer =
+		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
+
+	return sprintf(buf, "%u\n", dmaengine_buffer->align);
+}
+
+static IIO_DEVICE_ATTR(length_align_bytes, 0444,
+		       iio_dmaengine_buffer_get_length_align, NULL, 0);
+
+static const struct attribute *iio_dmaengine_buffer_attrs[] = {
+	&iio_dev_attr_length_align_bytes.dev_attr.attr,
+	NULL,
+};
+
 /**
  * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
  * @dev: Parent device for the buffer
@@ -179,6 +198,8 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
 		&iio_dmaengine_default_ops);
+	iio_buffer_set_attrs(&dmaengine_buffer->queue.buffer,
+		iio_dmaengine_buffer_attrs);
 
 	dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;
 
-- 
2.20.1

