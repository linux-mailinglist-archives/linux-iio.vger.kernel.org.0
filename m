Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14005E5CF
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfGCNzK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 09:55:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9288 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfGCNzK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 09:55:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BXQd0010588;
        Wed, 3 Jul 2019 07:37:16 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tg79xtsyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 07:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6nXuikyYxYxvFKZsOVReRlv7OEk+joo2L3+lAMjbAk=;
 b=ObvRl2GlzRN4qyKfpsg/hoyOMz8gOC6OVBJM9WyU89ULwKIZV76Q/utjf44ABPUSPqGNQr88j2me8L613J1JLbyiAONqhMEeRxgsU1DMCRj7NHr3u3o0PAMzuqbdVZJNErzux/YyHZN4MYqUn8NHD2aDuM1RVvVU0CCewjBvjog=
Received: from CY1PR03CA0038.namprd03.prod.outlook.com (2603:10b6:600::48) by
 BYAPR03MB3830.namprd03.prod.outlook.com (2603:10b6:a03:6e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Wed, 3 Jul 2019 11:37:14 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY1PR03CA0038.outlook.office365.com
 (2603:10b6:600::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.17 via Frontend
 Transport; Wed, 3 Jul 2019 11:37:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Wed, 3 Jul 2019 11:37:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x63BbC5l016720
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 3 Jul 2019 04:37:12 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Jul 2019 07:37:12 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/5] iio: adc: ad7606: Move common channel definition to header
Date:   Wed, 3 Jul 2019 17:36:44 +0300
Message-ID: <20190703143648.24402-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(189003)(199004)(316002)(16586007)(186003)(426003)(50466002)(48376002)(7696005)(51416003)(72206003)(8676002)(77096007)(2906002)(356004)(6666004)(1076003)(478600001)(86362001)(5660300002)(47776003)(26005)(70206006)(70586007)(246002)(2351001)(106002)(107886003)(8936002)(7636002)(305945005)(54906003)(2616005)(476003)(6916009)(126002)(486006)(4326008)(44832011)(36756003)(336012)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3830;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97870928-42c8-497a-a913-08d6ffaacae8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB3830;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3830:
X-Microsoft-Antispam-PRVS: <BYAPR03MB383026B4A3F5EB1FC8B5DEAFF0FB0@BYAPR03MB3830.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 00872B689F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZQ2o4CqD230aV5p4wMdGbxemdB5vmslA53KIVbx4lG2G4sKV0Ius7yh/6JqE8veN2jYe6KVmMa5kro9Iat9r0bnBM6uyKw45tC8ybgg5qP4O3x+/+qnBgENA7+JkUxnS2U6RpcKAtBjl9rk5STW0Tp0rMriOqJNeMaKDJVyUerg9Ee9jTlfE4yQmvP536xPtElAPnMgJCvTMqNi0Jg3FgNnW+3LDxMKjbsSsrt239LKiqCQhTRLkgQtDcPGsFGyj3glVCg/eaxzcwt/oDeLgVYi5k4tQsRRLhBBm91ucpm+/7WMV5b2IzZqvZ0WuHGiDLOtlG/Sf6Y9O9RGmTn7q9WnPuM7M4p4yJcyoGy/REeqLqnrp2lGxg3HZaJ8dffFouzZ6qn1ANIrdq4syqhV+3ziIZpqlMhvO1lLLhd9qOH8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2019 11:37:13.2281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97870928-42c8-497a-a913-08d6ffaacae8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The common channel definition which are going to be used by both core
file but also spi file, were moved in header file. Some devices have
different channel definitions when are used in software mode, feature
available only with spi, and those definitions will be added in spi file.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 23 -----------------------
 drivers/iio/adc/ad7606.h | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index aba0fd123a51..a49dc106a21c 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -308,29 +308,6 @@ static const struct attribute_group ad7606_attribute_group_range = {
 	.attrs = ad7606_attributes_range,
 };
 
-#define AD760X_CHANNEL(num, mask) {				\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.address = num,					\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.info_mask_shared_by_all = mask,		\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = 16,				\
-			.storagebits = 16,			\
-			.endianness = IIO_CPU,			\
-		},						\
-}
-
-#define AD7605_CHANNEL(num)	\
-	AD760X_CHANNEL(num, 0)
-
-#define AD7606_CHANNEL(num)	\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
-
 static const struct iio_chan_spec ad7605_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 	AD7605_CHANNEL(0),
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index d8a509c2c428..d547e88f4c9d 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -8,6 +8,29 @@
 #ifndef IIO_ADC_AD7606_H_
 #define IIO_ADC_AD7606_H_
 
+#define AD760X_CHANNEL(num, mask) {				\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.channel = num,					\
+		.address = num,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.info_mask_shared_by_all = mask,		\
+		.scan_index = num,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 16,				\
+			.storagebits = 16,			\
+			.endianness = IIO_CPU,			\
+		},						\
+}
+
+#define AD7605_CHANNEL(num)	\
+	AD760X_CHANNEL(num, 0)
+
+#define AD7606_CHANNEL(num)	\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
-- 
2.17.1

