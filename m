Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56DBF0F9
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfIZLSf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25216 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfIZLSe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:34 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI6cE003194;
        Thu, 26 Sep 2019 07:18:33 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwy9yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFCZsbtgRoe6LDbfH6hgzJeXvRSYeCwmyez6Iv/pz95VtZOhF3Tq5fctyfvZZdJXXtlSnH8mUQ48xBr98FIlikFqa27zVova9ud3a/qiT3IZjhiQx210NzFoFFTCgfH9JBEKEYPGxP7LVbjC9UkvV8n0EBGIZsWJTIo5+gZBTTS0MVw0Ak0V7FedXY8qxVm93wEmXqfD5t259HGBwQTnetTFyHnCFhu4MlaCRtLAT/g/kPNDYD4aqujs+rezxxtlvkG/ho8lUijZpOZQJzuvg7+6j3siA0lZEbfrB/VV6QbjjjU7E5E9tWQ9M7ZXYwTK8PS1GdW50unpzck0SX44qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxMsVOJjXLrCUC/e3XbLe1b8sUrkmGPUlALenVf12U8=;
 b=oAAZACY6Py0aoDhy++/adK4bmartV1q9JUoyyU2Rp+zF+9MTmbtwyr/5ACRHwSgUteEl6vplZoCPcdMX8UhyI1Qc0XwREzyRZJJd+kAavngbUhIOaEZjh+prrwMceIf7YJbLDSbAuE+G6N+upmT/jY7jRw6cUcFfLjGJLcIDQnfZlCmTYKTmoeE2TFUMddIozyKQ2oa+GYTgdqkhYA/vL8PTwLKx05z2UOQoLAK73aFQRQDijIe1NTw3CtdMSDNwrLH+63SJ/bN1USZp4cTwahmA6Fh3vhz4+2wZNlRk2AuI1qF41D9TQ4QV9FOchw1MzFsBHl0ML7hY3kDCfukI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxMsVOJjXLrCUC/e3XbLe1b8sUrkmGPUlALenVf12U8=;
 b=PG0U5kfuREcyFUEgxXPVGy8zQIcMc7Yhu5Wbi/Gc7arjJh/YY7JVu5BRSHT8qLJ/LpMJAYyEzarCxJJYsMVTy8F6LD3rGiw1HewOAwYAalvJHsI4w22bRtrkNo/01cYRam1uiiH3/HnKY4bJUmsgm+W/w9Ztsh4DhoiPb+bb3EQ=
Received: from BYAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:a02:a8::32)
 by BN6PR03MB3331.namprd03.prod.outlook.com (2603:10b6:405:43::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15; Thu, 26 Sep
 2019 11:18:31 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BYAPR03CA0019.outlook.office365.com
 (2603:10b6:a02:a8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIOpE004163
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:24 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:29 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 04/10] iio: imu: adis: create an unlocked version of adis_check_status()
Date:   Thu, 26 Sep 2019 14:18:06 +0300
Message-ID: <20190926111812.15957-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(7636002)(4326008)(8676002)(5660300002)(1076003)(110136005)(70586007)(2616005)(76176011)(478600001)(476003)(48376002)(51416003)(486006)(26005)(2906002)(86362001)(8936002)(50466002)(426003)(44832011)(7696005)(107886003)(6666004)(126002)(2870700001)(336012)(11346002)(186003)(47776003)(446003)(14444005)(246002)(70206006)(50226002)(316002)(356004)(106002)(54906003)(305945005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3331;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194dd2af-1917-41aa-0e0b-08d7427342ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN6PR03MB3331;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3331:
X-Microsoft-Antispam-PRVS: <BN6PR03MB333106BAACE7F7A10DE0958CF9860@BN6PR03MB3331.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bL7FgOe2r5bdIxd2xgC8U4RKUWtfOklHW765kMSY9JdQqIwMK11uebZmVXh+byAwD7BtfWD9WjbP/PjcEE4Q9wwdesGUBtKx+5NVc+u2b3g3TDZCxYAHJI+/ItaTHdC6Yk6bUSuFpWRDQV0CAc0/GhRjs20fJpqBwtPecLPAJ3hU1m9ob49UP6O+jyd32o/Vdjlez8zycGj2p0x3itOsExyadw+7NgSTZHEQoW+CfpTugRZ4Ksz1he/j1wVoHomruQ2NkimwonBAOa1pWUpIw512BjUeiwFXB1gRDZBMY1XSSyA53UIGcZ6eNlakH5RLOCdZdmoSvsRZure84N0LUuTaAvEYT8NKDF+5FfTom20ORcxJajO+PwpdBZN/rJivNdag05jKq/uGdiDbtU3fh60I1va2e1n/BbJQIbZh5D0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:30.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194dd2af-1917-41aa-0e0b-08d7427342ce
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3331
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This one also gets re-used in certain operations, so it makes sense to
have an unlocked version of this to group it with other
reads/writes/operations to have a single lock for the whole state change.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       |  8 ++++----
 include/linux/iio/imu/adis.h | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index dc30f70d36f3..e461b9ae22a5 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -277,18 +277,18 @@ int adis_enable_irq(struct adis *adis, bool enable)
 EXPORT_SYMBOL(adis_enable_irq);
 
 /**
- * adis_check_status() - Check the device for error conditions
+ * __adis_check_status() - Check the device for error conditions (unlocked)
  * @adis: The adis device
  *
  * Returns 0 on success, a negative error code otherwise
  */
-int adis_check_status(struct adis *adis)
+int __adis_check_status(struct adis *adis)
 {
 	uint16_t status;
 	int ret;
 	int i;
 
-	ret = adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
+	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
 	if (ret < 0)
 		return ret;
 
@@ -306,7 +306,7 @@ int adis_check_status(struct adis *adis)
 
 	return -EIO;
 }
-EXPORT_SYMBOL_GPL(adis_check_status);
+EXPORT_SYMBOL_GPL(__adis_check_status);
 
 /**
  * adis_reset() - Reset the device
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 3a028c40e04e..f4ffba0c36b1 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -263,7 +263,18 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 }
 
 int adis_enable_irq(struct adis *adis, bool enable);
-int adis_check_status(struct adis *adis);
+int __adis_check_status(struct adis *adis);
+
+static inline int adis_check_status(struct adis *adis)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_check_status(adis);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
 
 int adis_initial_startup(struct adis *adis);
 
-- 
2.20.1

