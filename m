Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32434553C0
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFYPwL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 11:52:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26038 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfFYPwL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 11:52:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PCcUwC020266
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2019 08:51:19 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63gtwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2019 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTHohcCMjlarwmVnCluWFcnSVeaNlV5ZjwMTdPIus0U=;
 b=eDPbR5LVNRqy7jdLElcx79Q6h05I1mNA5GHs5vgKHDjuY8XKuKFZk+IOH7QOAQFuCjCp1DJpnxBFqlTzF6WJXad8e1cr+DSUxbemxAY+iS5CBj4kgRLIa81foEv8uw/nvUtA/G4aBhIyq0c9gjMAoeXTsVTpvgn/2UzyCl0Sfu0=
Received: from BN6PR03CA0116.namprd03.prod.outlook.com (2603:10b6:404:10::30)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 12:48:50 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR03CA0116.outlook.office365.com
 (2603:10b6:404:10::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 12:48:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 12:48:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5PCmmvO031452
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2019 05:48:48 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 08:48:48 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adis162xx: fix low-power docs & reports
Date:   Tue, 25 Jun 2019 15:48:40 +0300
Message-ID: <20190625124840.24542-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(189003)(199004)(77096007)(186003)(246002)(86362001)(356004)(2870700001)(50226002)(6916009)(14444005)(2616005)(1076003)(478600001)(51416003)(4326008)(8936002)(26005)(316002)(7696005)(50466002)(2351001)(8676002)(48376002)(336012)(6666004)(70206006)(7636002)(476003)(5660300002)(47776003)(70586007)(44832011)(107886003)(305945005)(36756003)(2906002)(126002)(426003)(486006)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e822deb7-fcb5-4cd7-b342-08d6f96b784d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR03MB553;
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Antispam-PRVS: <BY2PR03MB5539534E4B515FCE4694413F9E30@BY2PR03MB553.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PuaHB7JRzJ8h/3C3RCFGgvo6fCwI5sbG4ktWQvx7v478ZbN506jG8pDRpaco4WRqJ9pb87SItpp77ikaA+7dyyWLlECDm49j7pgPGB4Ll7pw/BGXSIUvQk+TQuYL23FTc5omzcOpc11GxOvrPkpF6ZtGws1bVe1ZktRx/J1vuGMJxkgGZ/L6nEGzZBE/AzabKINFRF/7hqS1lFIxnvcm2TPDCfPKdTl5+DrmakWZVECUIIn1gsziuojX0nC9mCxMfvscYJv2XPzORfS6LZOr3bDV6JGsbuXWIKGq4meX7iRmxEAxWpwMFa6/1gADyhnGmRsxk0L+JVb4FMv55T+VCqWMwF7rLOMw/Gz7efHzjpNr4vSU1f6efD7WT5Ma3BNZOY/u66SM8EBYWhPeYPWX4VFFrGOdlYNy4sEUjuhH1+Y=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 12:48:49.1366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e822deb7-fcb5-4cd7-b342-08d6f96b784d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=985 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All current ADIS162XX drivers have incorrect values defined via comments.
Also, when an error is reported the printed value is incorrect.

The functionality itself isn't affected, so it's not a critical issue.

And since the change is trivial, it was included in a single patch that
fixes these in one go. All values were correlated with the ones specified
in the data-sheets.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adis16201.c         | 4 ++--
 drivers/iio/accel/adis16209.c         | 4 ++--
 drivers/staging/iio/accel/adis16203.c | 4 ++--
 drivers/staging/iio/accel/adis16240.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 4c1d482ea73a..3257d4d27015 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -71,7 +71,7 @@
 #define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
 /* Power supply above 3.625 V */
 #define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		1
-/* Power supply below 3.15 V */
+/* Power supply below 2.975 V */
 #define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		0
 
 /* System Command Register Definition */
@@ -231,7 +231,7 @@ static const char * const adis16201_status_error_msgs[] = {
 	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
 	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
 };
 
 static const struct adis_data adis16201_data = {
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index f2dc3a5f0463..01dd02f7e1d6 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -73,7 +73,7 @@
 #define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
 /* Power supply above 3.625 V */
 #define  ADIS16209_STAT_POWER_HIGH_BIT		1
-/* Power supply below 3.15 V */
+/* Power supply below 2.975 V */
 #define  ADIS16209_STAT_POWER_LOW_BIT		0
 
 #define ADIS16209_CMD_REG			0x3E
@@ -241,7 +241,7 @@ static const char * const adis16209_status_error_msgs[] = {
 	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
 	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
 };
 
 static const struct adis_data adis16209_data = {
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index a5d974ac2e3b..39687139a7d3 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -122,7 +122,7 @@
 /* Power supply above 3.625 V */
 #define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
 
-/* Power supply below 3.15 V */
+/* Power supply below 2.975 V */
 #define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
 
 /* GLOB_CMD */
@@ -234,7 +234,7 @@ static const char * const adis16203_status_error_msgs[] = {
 	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
 	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
 	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
 };
 
 static const struct adis_data adis16203_data = {
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index b80c8529784b..62f4b3b1b457 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -175,7 +175,7 @@
 /* Power supply above 3.625 V */
 #define ADIS16240_DIAG_STAT_POWER_HIGH_BIT	1
 
- /* Power supply below 3.15 V */
+ /* Power supply below 2.225 V */
 #define ADIS16240_DIAG_STAT_POWER_LOW_BIT	0
 
 /* GLOB_CMD */
-- 
2.20.1

