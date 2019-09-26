Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB50BF104
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfIZLSg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:36 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:29258 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfIZLSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:36 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBIVNl029004;
        Thu, 26 Sep 2019 07:18:34 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7eeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGpFw6AkR2eMqC0Gpz+GtGBnbsR1pXUzdCfEmXGwv227OyE0TUZyNoUaLZPeBLF0u6kJ1P3bB9TiO/Kb284Zpx4/wIsuweWI2g6zTWIDvoFP1E1ypFuPBWUJlQx8/B5wLy+Q8wyZOaUG02WHrSL/K+72YnctKgirKO2UsnXl14sDYJiIggZ+TuFnGWVgQZx9wm3gcb7nn0MHwWo0NfIiRxGcQTlWfmlX7oRoLlBOXlSE/Y56TNFRB4wzf4AOksoMcTFbAyblk2EGXfX6T6Z0lFs1pKQmb/Le0op9uMZ9HSkpLBCtx8AHxzuBS5/68ml6idfwdwKrfWvtNyRPy65BNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6g6QAsZ/9NfGdw9KmwiiRTf/aJvbGJI/nX3YcE+BL4=;
 b=OE7oXw1gyoYigGiXbWnVHVb7CdTTVyekWyp86O5vpxeEFCDZoM2od6MoHucuSTvQyziImgYtqLaWAqGB8jcfB3I2NqR6UPhQWvRfMPK6j3C8/6/TrbeNCLOFkdu9DkN7fpcQtXo8QUHFMkG01LMwFQ4sGyaaWjCSK3Qz4wA9d9Z0x6IkJ4kpG7c0f1jN0iqtsNgBFxovjkaicjSN0ju+ZG5B1tBAlYAMeHlIGofhLiHlhRqlB7FLhap9kYlYGECuMwBhmTls6PoOdTDVnJrJygbbSfWtGAIM57yO7EgvdA/vDKg1iJ1T98yz+5wyMMJC/oN2viRSVUNjH3Te+i1yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6g6QAsZ/9NfGdw9KmwiiRTf/aJvbGJI/nX3YcE+BL4=;
 b=1fKSI40nMw47F/ukmO3H76nhbrFAey4GB5OrJLeKPr8ANBIUOLQykOCSjBUoc4QmLewplFXtTFUVDmnpPZe49HaIdkBSka4rlHJgU/z4renTGBM3ngnG3cpZsDIrrRjxCaS2dF2XPO47FASqerBkrFErWc50OuVOwOWr7LGyjhk=
Received: from BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42)
 by SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15; Thu, 26 Sep
 2019 11:18:32 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BYAPR03CA0029.outlook.office365.com
 (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIQLV004174
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:26 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:31 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 05/10] iio: imu: adis: create an unlocked version of adis_reset()
Date:   Thu, 26 Sep 2019 14:18:07 +0300
Message-ID: <20190926111812.15957-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(36756003)(26005)(186003)(5660300002)(8676002)(7696005)(8936002)(107886003)(2870700001)(51416003)(2906002)(76176011)(246002)(48376002)(1076003)(305945005)(7636002)(478600001)(4326008)(446003)(11346002)(2616005)(476003)(486006)(126002)(47776003)(6666004)(426003)(336012)(356004)(44832011)(106002)(110136005)(54906003)(86362001)(316002)(50466002)(14444005)(70586007)(50226002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3871;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff69ca13-b31f-42ca-5632-08d74273438c
X-MS-TrafficTypeDiagnostic: SN6PR03MB3871:
X-Microsoft-Antispam-PRVS: <SN6PR03MB387194CB2EEC1967D9E23541F9860@SN6PR03MB3871.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2kklWmWJqlOREbTrLvjtqVF74D+QrnczsTZ3yF4pysv6sv1yQyDtDY/VJYucJFLDgOKHMtBT0vo7dnZx7fJwaILNReqtHBJ8mfsSXCzOsuGrkiNlzX02t59SaAqiI+v0eIXC2eTXYNWK0nsPnRFk09KQkCzBj8+XUhfEhD9g/ZJFWFxofuDfzCurBk2M5USqPSRBg0EVULxJhTyeUp42VhgpoEsIXWV3+PrD+T161izwOLRZQT2PbZ1auFGyLspEqFAXIXjc/3BSSdZ/zIH4F+Pw6Sb3+8DeQRwu7DIpmqgTWCPld2AxZ0jhGWxVv4hhfgz51QVCC6b5Vlr8p7EwYxj8tMrsWjWJMDBe0UA4sO9RZuV89tdpDdwbcHltgya4ywn5i6otmruKk6+eWvLRjjyc9kDZmTTgosAmpWdceI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:31.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff69ca13-b31f-42ca-5632-08d74273438c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3871
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The reset routine may also be important to be protected by the state-lock
and grouped with other operations, so create an unlocked version, so that
this can be done.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       |  8 ++++----
 include/linux/iio/imu/adis.h | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index e461b9ae22a5..b14101bf34b9 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -309,23 +309,23 @@ int __adis_check_status(struct adis *adis)
 EXPORT_SYMBOL_GPL(__adis_check_status);
 
 /**
- * adis_reset() - Reset the device
+ * __adis_reset() - Reset the device (unlocked version)
  * @adis: The adis device
  *
  * Returns 0 on success, a negative error code otherwise
  */
-int adis_reset(struct adis *adis)
+int __adis_reset(struct adis *adis)
 {
 	int ret;
 
-	ret = adis_write_reg_8(adis, adis->data->glob_cmd_reg,
+	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
 			ADIS_GLOB_CMD_SW_RESET);
 	if (ret)
 		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(adis_reset);
+EXPORT_SYMBOL_GPL(__adis_reset);
 
 static int adis_self_test(struct adis *adis)
 {
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index f4ffba0c36b1..966af241710f 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -73,7 +73,24 @@ struct adis {
 
 int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct adis_data *data);
-int adis_reset(struct adis *adis);
+int __adis_reset(struct adis *adis);
+
+/**
+ * adis_reset() - Reset the device
+ * @adis: The adis device
+ *
+ * Returns 0 on success, a negative error code otherwise
+ */
+static inline int adis_reset(struct adis *adis)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_reset(adis);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
 
 int __adis_write_reg(struct adis *adis, unsigned int reg,
 	unsigned int val, unsigned int size);
-- 
2.20.1

