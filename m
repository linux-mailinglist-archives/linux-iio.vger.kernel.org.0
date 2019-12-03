Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312A310FB9D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCKRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 05:17:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38212 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfLCKRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2019 05:17:06 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3ADHoD003925;
        Tue, 3 Dec 2019 05:16:22 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2057.outbound.protection.outlook.com [104.47.33.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57ra33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 05:16:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DklC9vcm6WAygTyHbsVXzmTXP7oDu8Vlwsz5XHz9+RyUP1D5raKe6cuPEsMpE4IyFVZGdiMxLT0FnMYY1hYhAVGLFd49gCCA7TP2xZurFywyIgIcq3vDx65bmBCie0c4UL+U87hcNu6UfAyFFK0TRECppFYkUMg71lOqLYF9xrS5GCJhikzqxeftVAm/cMRFET2PbbNLo6aVbRYRk3Uqj0vxOsc8ybxqqBz4VKaKLA8uqNlw8UFUklyCGH9o9S55dOiLaj4iUY4b5ebVrMUlu5gBX06+I3LcMhSRGL/77061CQXcUwf69XLPjQQirso0F9IuBil1yJmQ5bwdJqBf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfhpGYZzDf0Es+gabfCZrL49uqJKjWCVPUfyUO1MLvA=;
 b=M+54xxuspKDi5gCct358sdPYv5ziUq6tiLnzuRKOLJEBnH9z7VGzWf2w/wXQrbF03Nlh/4KWRWfVmYpO4kKwxH2+6YshxqmuI2XXModaxEQnjjkTGFSbj2OV+WS1YRxAGSPKMCUxuURhjZPzUbr27Mm6Vk2VO+18BXMuxHTf5d+DeGc9GlMvhTp4Y4blbyauzGyVfKBAQwALSQB2TCW+zIUIyAhvIKVYY1M8g3cHv7QwNY+bpGRBUNHoog2+ZUsIPmOO/y0ZVXKC6HC/Jdd941GsvjcgU+05rGm1LayjwG9AVy/DgZ2xi3CLDxZSMEaK3tUXv5WX85cH0TzFbn+JmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=pmeerw.net smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfhpGYZzDf0Es+gabfCZrL49uqJKjWCVPUfyUO1MLvA=;
 b=jRSQtd9lkorZwdYA/psyHdFJv6eqXKedHizquh6Or9abfTiV5CsBi85c6xyvGNRtpOC8J2/sOG0r3m4leDGvmVVmqoQ9FYrn4BgM/avs6+LKmmrNnT95CfYwxdHg59hnKDPXcyUNk/2uKTmHB3RkQyaWKp6o7Gor4RfPkKoMG4Q=
Received: from BN6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:405:6f::15)
 by MWHPR03MB2543.namprd03.prod.outlook.com (2603:10b6:300:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Tue, 3 Dec
 2019 10:16:19 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN6PR03CA0077.outlook.office365.com
 (2603:10b6:405:6f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Tue, 3 Dec 2019 10:16:19 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Tue, 3 Dec 2019 10:16:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xB3AG8JO006140
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Dec 2019 02:16:08 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 3 Dec 2019 05:16:16 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <fabrice.gasnier@st.com>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH] iio: adc: Move AD7091R5 entry in a alphabetical order in Makefile
Date:   Tue, 3 Dec 2019 12:17:13 +0200
Message-ID: <20191203101713.22888-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(336012)(8676002)(44832011)(426003)(2616005)(2906002)(7636002)(7696005)(51416003)(2351001)(4326008)(107886003)(70586007)(305945005)(5660300002)(186003)(6666004)(54906003)(70206006)(106002)(36756003)(356004)(16586007)(26005)(86362001)(48376002)(14444005)(50466002)(246002)(316002)(478600001)(1076003)(8936002)(50226002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2543;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2f90da7-a496-4fbf-07ee-08d777d9d6a7
X-MS-TrafficTypeDiagnostic: MWHPR03MB2543:
X-Microsoft-Antispam-PRVS: <MWHPR03MB2543DD667054D0D46696C888F0420@MWHPR03MB2543.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02408926C4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxvX5Z/j7Uc/CswqbDAk0EtqPnl9OFNGSWhY+xm/tc28njaWRuHY34r5b2/vUdb03RycayXwCgXfNF7QgjxeaznzF1hCjWs+2tTj89P/4GTPLgnt/L9wQ50y2iiDU1ZEM7HjVVA019o7Zgr/2rWifPiYLkPCWkP78TrHi09cBSGrv0EXj6MYdrxs1Cva4hrOTxTUsoqztA63E7P2ghM8LJHPApE7SsNQ/CUV80utS+ezCW4ufF+gDJqZGYAGJyQLWShZxc52fegdyDp/s98Cgk6wjB7CL16X3RtRYIPWslRlJg7h/Futxpzp5z2i9sN5pMRakTG9juYcvgtXm77FdRkknVu/zapx+JaaX9LUSkOA0VnbEhlZvkP0U6dZonwlsYk0uuNoi4GWd5QIbBEl58zCKMeodhUpH4mJrZ3gksoLIEJakMJ2Vc02NTqjTr2W
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 10:16:18.7672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f90da7-a496-4fbf-07ee-08d777d9d6a7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2543
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_02:2019-11-29,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=970 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ad7091R5 was added in a non alphabetical order after AD7124 in Makefile and
KConfig. This patch fixes that and place Ad7091R5 before AD7124.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/Kconfig  | 14 +++++++-------
 drivers/iio/adc/Makefile |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 976567d4dbef..27bb4e56eaea 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -21,6 +21,13 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD7091R5
+	tristate "Analog Devices AD7091R5 ADC Driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
+
 config AD7124
 	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
 	depends on SPI_MASTER
@@ -32,13 +39,6 @@ config AD7124
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7124.
 
-config AD7091R5
-	tristate "Analog Devices AD7091R5 ADC Driver"
-	depends on I2C
-	select REGMAP_I2C
-	help
-	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
-
 config AD7266
 	tristate "Analog Devices AD7265/AD7266 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 84936ec24411..bf8354cdbc34 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,8 +6,8 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
-obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
+obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
-- 
2.17.1

