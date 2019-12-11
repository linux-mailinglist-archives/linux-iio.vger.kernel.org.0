Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8857211A911
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfLKKkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 05:40:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13360 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfLKKkp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 05:40:45 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBAbp9e003963;
        Wed, 11 Dec 2019 05:40:29 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wrb1sbw5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f40k4T8kvimUQZQKg/53wKwTbqLoretq3G86atjLSdHdfwTQQmNmyTWUV47R9lG0XXOVYeCAIXpbtwsqDGoU7E/Y50kEAHvKgSxUyvPt44o7OMIUFMf/KIMePsO8JjGQA0gBmDfLrJhGZkXuHZvbci7dLvd+XJJjxp+XN0i+rTZgGTAvr/ly5YbgC8S3QRBFcTgp/ntePROSn5Guz5A0xebBY1WeX/Om7pyB3bIEU38qcLYc8TyE8F7/bEZ40/cn1Vx4sEX545W0PrCAmrsF0zFAShdQcCOeW/RR1PCDWn6NX92QLMB+NdddyRS8uyt4BhLsPO8LIfdWPpvr5yR8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOAsGeXJzYMjXwebW8VZT+rkYhJTmYh4DphJVoTMPrA=;
 b=gqo0jnaBQ32S5pnxl+0Dmgy7SypuixNzVCQ1dseiRJtm4dUuVO9vgFFiHoItjtchIOxsF7qweaksAjJ6n2Mg0yeFNYoFqUmkaUvbGWjlWNWs+Q/ja9jMswRKNXQXj7tGYdfh1EPtfQ0uFt3T85b8DYqz/jwQF5NOmt1Ri2Wj6Uq97RztorYk6LUQi2DRtoN4TWceyfIU3igfvfRX0sSPgxCrpEAQCvRrCS37t02yUYhM0s73LAO0mzJ+LCZhiNfsv6lPRU6JW1viz+rOkNKnBVXr/kKPTVMASMvhhTVqI7CH6uNysYgcIN8Odj4OfYQsizVUNQU/l7TG/BwzXXrsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOAsGeXJzYMjXwebW8VZT+rkYhJTmYh4DphJVoTMPrA=;
 b=ntQOm+Y7QSThAINwj4gctYfg36QMQqS1B8vEanvMOLJtlSMd4BUpMtZb539EtNL0vwL+AIe7Abyc4FuYNrvS3xAj+NlZgoR6OpX+9vZwmX0CbVKkE3ia/IvSvYOvavLPy5kkLFzI0yLg41pdImZD2LqPpcwXi/tfMrKfazjOjwc=
Received: from BN6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:404:23::11)
 by BL0PR03MB4228.namprd03.prod.outlook.com (2603:10b6:208:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 10:40:28 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR03CA0001.outlook.office365.com
 (2603:10b6:404:23::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 10:40:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Wed, 11 Dec 2019 10:40:27 +0000
Received: from ASHBMBX9.ad.analog.com ([10.64.17.110])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBBAeQnk014620
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Dec 2019 02:40:27 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Dec
 2019 05:40:26 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Dec 2019 05:40:26 -0500
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBBAeOTT006799;
        Wed, 11 Dec 2019 05:40:24 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer-dmaengine: Add module information
Date:   Wed, 11 Dec 2019 12:41:47 +0200
Message-ID: <20191211104147.13368-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(7636002)(107886003)(2616005)(426003)(186003)(4326008)(70206006)(336012)(7696005)(54906003)(110136005)(26005)(478600001)(316002)(8676002)(1076003)(70586007)(5660300002)(86362001)(6666004)(8936002)(356004)(2906002)(36756003)(246002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4228;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a0d2847-65ee-4ba0-6dd3-08d77e26898b
X-MS-TrafficTypeDiagnostic: BL0PR03MB4228:
X-Microsoft-Antispam-PRVS: <BL0PR03MB42281834D1D70AF902763B91F95A0@BL0PR03MB4228.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4rnd7VPNc0W4mMB98bXOiKylJ1zjqUiNCkud0WVPVzD2lCzNP1jNAcjlKZqgc4eIDtmVArkPFOUbGng/iqkK+jUoxN2rwBihLtnKipXqfSNsq7GX6g6Cd73jR6C5trekilTDtgY3QMMwppsTdo6kXqd0K28EVSxyo2XL7Cmwp9qxYgesmeTZWiX9TZ7efpL/wNgcj/ahN0JKVL/FupUb9RAgzUXMTJcfmH2h22aROPay+HNAzPgX7+W+8HlpfjR/Cg/f/BuUGTUm2xTD2XUu0WUzFIVtwA/5k3JUqeS7BJIKlGfKxqAHIQuJCIDr2/sKdB1HykQbqjucKalloalzcbw1758VUAQ5r9jBf25DOEPAFP+qN0xfTLHFnnTg3QQz1S11iyWpmBzOIX0/nB0Cpa3HWkcf1ehfg+T3iO+oVXD/dpNAXo5hYY04FTu/Aob
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 10:40:27.6486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d2847-65ee-4ba0-6dd3-08d77e26898b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4228
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_02:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=2 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110093
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Make sure that the industrialio-buffer-dmaengine has proper license
information so it can be build as a module and loaded without tainting the
kernel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b7b5a934e9b2..e0b92f3dec0e 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -206,3 +207,7 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 	iio_buffer_put(buffer);
 }
 EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("DMA buffer for the IIO framework");
+MODULE_LICENSE("GPL");
-- 
2.20.1

