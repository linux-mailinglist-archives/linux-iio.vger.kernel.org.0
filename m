Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB36C94A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfGRG2B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 02:28:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19324 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfGRG2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 02:28:01 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I6NsA0008860;
        Thu, 18 Jul 2019 02:27:56 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tt0q7u4wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 02:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjWx1GuWAtNa0K0MiX64tmSOrOuCXaDMMbROKHk4mBrPwMqOT/GwcOFRKble4mUEGJQ5hb4eeAiFa+jXVkRb3NYjeiXEYVWK8KPLVeL3gbKh1TCbFDCU0bnvCp3yjAYUhjIfaznWY/bWudEB9/x1vPnl+6/TwyZXArJMJLLo66F9bJngby3Ec6b+974lPfnChGY1rNzofgtLe2fFHEeuHVULDQRcPX/moJntTxBRRPSNNrRTzOP7FmPinspVke0ELpiIYw7/BEJ4Sagq22mKrt6wZlEbE4q+PDqhOV75Kc/eAbN0aGxPS27DSEHiadgrs366K7Re8So8B0VlXiVyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5m3DIBnGSakN+9XEutiKkkuZTjFRdwUEw7oqEPCzIM=;
 b=DdRoxkcGCSttdNz1rPbO5wnuJlE/Mh4zhFqxn5gQSPYaTL9wWKe2m4JzwsFVWFrhBuTTz5gagi78M/XDiRqA4C/swGwFA36pplZhAn32dNpl1lFQgJa6P2xtzax/DLOSx1ahTuv78by6swF3mzEKGVleRt0oIcoEZV4/lYxLQz6UlVFfFAMcb8A72qttZy8NC2/V0dPo49wjkRES9ULnmMGNyPZIVyZm5Du0g6SxAA/EnI2OMZxZbCDcXFq+qUj8rRwLHw7aDzj/lpb/wqWQVhbJw69Lyg/hh3ug5fWvfcp9OIDPaeXX0KWQYQWzguggbdYCD52bEbtNeB6F7xjvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5m3DIBnGSakN+9XEutiKkkuZTjFRdwUEw7oqEPCzIM=;
 b=iewfSRHYZrf+1Ruy4TlbuYwYxx9bLveAEaeEiCy9K0ulhvBmP+4LM+XvHHLwkpu+QVVllsOft7Beu6e0+F+sbiiGp00P+2NmLzW22pBzN9zFjI2dqFValU+zeNDhQMkkX2BmkuYdj6UxQ+HuJL+iuV+LpcRAN9qacwZ8sT5O8Mo=
Received: from CY4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:910:4d::31)
 by MWHPR03MB3279.namprd03.prod.outlook.com (2603:10b6:301:42::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.13; Thu, 18 Jul
 2019 06:27:53 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR03CA0090.outlook.office365.com
 (2603:10b6:910:4d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.11 via Frontend
 Transport; Thu, 18 Jul 2019 06:27:53 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Thu, 18 Jul 2019 06:27:53 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6I6RqqE015202
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 23:27:52 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Jul 2019 02:27:52 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/5] iio: adc: ad7606: Move common channel definition to header
Date:   Thu, 18 Jul 2019 09:27:30 +0300
Message-ID: <20190718062734.17306-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(8936002)(48376002)(6916009)(107886003)(50466002)(1076003)(316002)(5660300002)(50226002)(4326008)(70586007)(70206006)(356004)(6666004)(336012)(86362001)(44832011)(2616005)(36756003)(476003)(426003)(54906003)(2906002)(478600001)(16586007)(2351001)(106002)(486006)(8676002)(305945005)(7696005)(51416003)(246002)(186003)(126002)(47776003)(7636002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3279;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5db390f-2ecc-4b0f-09f1-08d70b491072
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR03MB3279;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3279:
X-Microsoft-Antispam-PRVS: <MWHPR03MB327962C8EB674CE59F488891F0C80@MWHPR03MB3279.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: J+ncbzz2UfJbYuu04se/o80Fpx6vanuy0iK1cOF96vRg4wMkeVxazaToi+qtX6QZUiSyn78TM/b083bSoSRtjpUntDJ2hB1FtYW3/eMIzGPRHJ5aorni0rbTMLWziYFLoNaI8L0akeL75k4gurlzXSNZFu6EqwEb+KJ8NY48v3SYSu53HC+oo/9bNF19DNdVftFxpvmXXXGkJOJD97/Ax7KZa7N+I4ksLwJv+MdUST9vvhV77pX9QL5kSHtmsw+t5Hyn3HCEUl/EvQbZMGyAHL1AyXZuDWVXX0AUALAnxtuVJvakebiJmrbWkPAv/P7Kqmp6V43iaO9r5R0EsREHoNWbpilZbCUAVUdHOpz0oHfIdjPXsbG7K/D6hISf5LVVsAQpwqikOtQsy/+Swl5w6rh/QCb1ugt3F0W2DUBwWSc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 06:27:53.1698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db390f-2ecc-4b0f-09f1-08d70b491072
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3279
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The common channel definition which are going to be used by both core
file but also spi file, were moved in header file. Some devices have
different channel definitions when are used in software mode, feature
available only with spi, and those definitions will be added in spi file.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

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

