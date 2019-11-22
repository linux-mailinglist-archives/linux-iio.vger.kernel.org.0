Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2D10732D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfKVNaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21028 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727876AbfKVNaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:08 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDNBxt026861;
        Fri, 22 Nov 2019 08:30:04 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2waew7wbpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEpVvTyK5QofMlwPZQrbv5aJqc2n4Z1vaIJa4JIu9ycnz62oEjGFUcgjdDpB9DWpr+G9cWISFkABCU5mtR/Km5N9SUjNMnn/JmDK381+qA44iu91lEFBqps+RfSN5Y9JwvpFa30ykdqbWEzbRz7VFhFkY3NLlvrGm54nzQR6hMeMFhNGg8fBT+6G345BFn76xAdaQ2LrjKnwR81MeGNttOrxnQeZTEaUsfYlj2HF84J1f4YIhfpVWdOJawHjWT/ZfrO0qaYbneHa2fdc+4WEMAHdcEivkAnGUquYyW5oLwGGL+Ja9TFLgoGuIwHz0TIy5gqY9L2Z728csgUN1PyoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy+DtZ02z1c+BX70vxhhzMzrnmeUFVoRtgxaK6XGgcs=;
 b=T8l6+xfWPhD9MT1IFEIxXJYmVYoFB+BrAZdZsYbAmr+tXpJPfB7bXGDWXB2Y1jjvT1AykqSAIOLugscQa8riTESbiTu9RqAPx4RmlDrwtU9/75uTuXof9h6hilxx/0d2U8nPcM4idldQRj3bjp346l92+EVxR8nR7B1psAEIII5QwLx365ZfJtlvEV3FpyHxLKX9La1UkIIqs9LN47iq8zV2dv62Ojm99l/R3rcDpSN6q0B0Rtcpz6SVyZfNr93KtmifpVKSD2oTpWCK7fQeuLajatj+dCldHaJqMsr4VU1hnsm/Fv5U6LM2yQAB6ejp7xsLFtEGMbdAIm6smwHrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy+DtZ02z1c+BX70vxhhzMzrnmeUFVoRtgxaK6XGgcs=;
 b=bmJgFU220Z2Z3Kn/rHzS5EouTi33tyNDVSel1FrvaVCwnaoZ+6PFx4ZLgJk0WXOrbO9jLfmVLmJwhpkFQKw7zUCc/f1yzWcEy2LaRUxGTkknUDad9FtKcgbSBG6v4TwoR9kmFDOXTd923WpdU6RhWWybL75Bf3gol2C6dKZj0KM=
Received: from DM3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:0:50::30) by
 MN2PR03MB4768.namprd03.prod.outlook.com (2603:10b6:208:ae::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 13:29:59 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by DM3PR03CA0020.outlook.office365.com
 (2603:10b6:0:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 13:29:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:29:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDToRu015787
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:50 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:29:58 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 05/11] iio: imu: adis: create an unlocked version of adis_reset()
Date:   Fri, 22 Nov 2019 15:24:15 +0200
Message-ID: <20191122132421.5500-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(44832011)(50226002)(356004)(1076003)(50466002)(48376002)(51416003)(4326008)(478600001)(6666004)(5660300002)(54906003)(7696005)(316002)(336012)(186003)(110136005)(7636002)(86362001)(106002)(76176011)(2870700001)(26005)(446003)(8676002)(8936002)(36756003)(246002)(70586007)(14444005)(11346002)(70206006)(426003)(305945005)(47776003)(2616005)(107886003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4768;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e3fcced-e9a6-4bb7-1eb3-08d76f501272
X-MS-TrafficTypeDiagnostic: MN2PR03MB4768:
X-Microsoft-Antispam-PRVS: <MN2PR03MB476803249DA5053DEF365F33F9490@MN2PR03MB4768.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0nElPUTnBvLYch2Tp+pNZeC5hRxdT3PchSBuFTW6pzRJ6Prjs6eyvtTeb5DUbkMCaIem5YuX5h07hYbpV43drmjVs1kVAwfykH2wfBaVzsv8NuD1gYGNpj66kXx+IX9fJpDyPvRSxXUhhWiEmZdXTIiSGsTJiy2KKYXZ0aTwF40jf2vv/7DBzc6ofjRvIWMS3OsxtPeJTGnym7Xo4itdOFM7VUWByTYjPsAxVo1OE6JWnJqVK3wB6v6M+gXN0TLA66b6OGl0y6totJ5RGyC0fszhQdojxDUKY8pb9RmHFDcEeK+jqaliVzVuOsf1UAquPmcw9WBIHDpGLcRPSKpAt1q8a7RZ/8WWfYltYB1LEglB9aOWW3anZI4HHIud0uNm6ZO8DkdB/qx+fj7h0KjRWP90Hy6u2PGs9tdRJN+Cv+UFzPa6faOMXqR5TKMLPl/
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:29:59.3339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3fcced-e9a6-4bb7-1eb3-08d76f501272
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4768
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
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
index b63d6e6f5415..615f174f0e6e 100644
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
index db759957e1c1..4b5bc0e06e69 100644
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

