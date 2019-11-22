Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78DE10732E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKVNaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21230 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbfKVNaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:08 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDN7Hl006075;
        Fri, 22 Nov 2019 08:30:03 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wabu7myus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at9Su0sX3/Cj+Md9l9J/u9ePWd7jaudTzoCUHXPgpKP2IBRRTfAtb5A396vG5nSFcdQseeXaVJS4YEsDEHUA3W4lY6cO+yoOTfD4UWWC6WmE8T+WkoMysWAAIBCQum2JJwVbyVf6c5kH5xoOeBbIYWoX2p3srIu5hFuX5NFqf1BJgYuM3/0yUBq3T6XMUJLpBfMxLJYm+xM0bzkPl/0781ehAuzFPGdN96FRZPTH3GXrbCwbzjRajgEQZShhELlSqH19TqByt80T0G1Q+dJq2ywnB0rh7cvqy5DurjMn0qwhfPCb7To9wZcn0eL8JBrI99uLtQfFSTW9gtyM5EMEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCigMqdzLvelihWxd/GXOmnpQ9Vuu4vaJn3a7PqBLTw=;
 b=FtCY3Y82Wa1E0e1mKenf69DMvGEMdjgSI6P+I15NrOyMgsY3RILdyyJK7mPWEsOw+zB0w/tFIb6mWBBYEb1VdY2M5BURVd2M42GyNULCPqNgckx/RpKiep5S2RgyjGePb46dR1FJr2f2lGeiBHuPzwDBzi9u3w4qLXjwMCVt5t8fRfyjjevt3zC5PXvbgtw6XJmHiDaAS1tGhHhlOdgHtABzRbnEuP7WcuuuiHbc3FVTqmwEJqg9j+7oc80rHY8Xns0GjILT0fynqycyvoL6DwFMKWCw1KGChb8czlsv+JkT8qk2lpPwwkiC9j30e9dINu0PQAnm84nAbuouweBfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCigMqdzLvelihWxd/GXOmnpQ9Vuu4vaJn3a7PqBLTw=;
 b=0ecMlG22G3GmAQSuA7EhCUt3z1lXTYoEJjT8xIQdrtENrt/9mbIbSZ850ap2KnoneExOM++MNAqd2wNdXNMTtfesQ9Q7rIOsyO0D698Llth6HuQ+67SDK8vAMIN1SbYeYqh6YwMxfYwAv0hilFgfTXL2mJCEESXbco9VvQin8Ds=
Received: from CH2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:59::17)
 by DM5PR03MB2554.namprd03.prod.outlook.com (2603:10b6:3:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Fri, 22 Nov
 2019 13:30:01 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CH2PR03CA0007.outlook.office365.com
 (2603:10b6:610:59::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 13:30:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:30:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTpCe015795
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:51 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:30:00 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 06/11] iio: imu: adis: protect initial startup routine with state lock
Date:   Fri, 22 Nov 2019 15:24:16 +0200
Message-ID: <20191122132421.5500-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(51416003)(446003)(2870700001)(7636002)(305945005)(70206006)(1076003)(246002)(4326008)(11346002)(426003)(70586007)(44832011)(2616005)(2906002)(8936002)(14444005)(48376002)(50466002)(47776003)(8676002)(36756003)(336012)(50226002)(106002)(107886003)(478600001)(186003)(86362001)(26005)(5660300002)(76176011)(54906003)(7696005)(110136005)(6666004)(356004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2554;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58929f6e-4486-4926-fcd1-08d76f50135f
X-MS-TrafficTypeDiagnostic: DM5PR03MB2554:
X-Microsoft-Antispam-PRVS: <DM5PR03MB25549CC1109692002AA90D27F9490@DM5PR03MB2554.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJg74/FCFiezYZF8tHCitjNhY2i6PV5a1KPeWkxM1bo9VfulB7qq2lXL5gEeXRK8y8gmhu5AOjqSwPIGPYaxUBr6zFBtcrh7pdrjHKGu0nAJsaaYL5CK6NLulHdMQXAIJ8Lhxyji35hxL0/Kh6cpHgi9pTKWxshuy7hc3pit2Np1d9+N/AuZgCgQlDDRMH9gSilv2NtGT0NkLJOIBALwNIkjMFD5dfZODRoh9n0tH5ULhtIMv4pK4prtY6sOW9a7tiO3Fx45ptQgpii4gUeCKQgWmWh1pFcP7mYWDrDvYgrTdcXteBdGh6kIjc7LvRMpt6X3SMUShDEVT01cCiUN4q/bseiNPnsLrVnrOAZDjIsCj0feXPZIwnQLL7o93MZFX5Da9S5rs0kABOG93eLG+2qu1Gsb9wCfS7LZXUgiWZ1oY/h0Cv4P+0uA7lXE8zLA
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:30:00.8918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58929f6e-4486-4926-fcd1-08d76f50135f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2554
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The initial startup routine is called by some ADIS drivers during probe,
and before registering with IIO. Normally, userspace should not be able to
do any access to the device (as there shouldn't be any available).

This change extends the state lock to the entire initial-startup routine.
Behaviourally nothing should change, but this should make the library
function a bit more robust.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 615f174f0e6e..10b8922fd51b 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -331,7 +331,7 @@ static int adis_self_test(struct adis *adis)
 {
 	int ret;
 
-	ret = adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
+	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
 			adis->data->self_test_mask);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to initiate self test: %d\n",
@@ -341,10 +341,10 @@ static int adis_self_test(struct adis *adis)
 
 	msleep(adis->data->startup_delay);
 
-	ret = adis_check_status(adis);
+	ret = __adis_check_status(adis);
 
 	if (adis->data->self_test_no_autoclear)
-		adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
+		__adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
 
 	return ret;
 }
@@ -362,19 +362,23 @@ int adis_initial_startup(struct adis *adis)
 {
 	int ret;
 
+	mutex_lock(&adis->state_lock);
+
 	ret = adis_self_test(adis);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
-		adis_reset(adis);
+		__adis_reset(adis);
 		msleep(adis->data->startup_delay);
 		ret = adis_self_test(adis);
 		if (ret) {
 			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
-			return ret;
+			goto out_unlock;
 		}
 	}
 
-	return 0;
+out_unlock:
+	mutex_unlock(&adis->state_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(adis_initial_startup);
 
-- 
2.20.1

