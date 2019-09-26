Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C28BF061
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfIZKxG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:53:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3786 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfIZKxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:53:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqQhO002867;
        Thu, 26 Sep 2019 06:53:00 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96rdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUhI8mxrofhjo5uXfi0LGBSIfQmDo9CMgybqoxUDe9g10B0SkLSFck9HZnpd9gZ7NuUAr2EcYldUyQS9fBIQNjj2O5OdzQ6Mx/Jd+2sQ//zkJC7SL1gnei8IJJBBfKyZ/pYb4UYGXg3zyJXP6cZjDvYRqcMYwoBZxQSXLDjkPtjTfkYmiub8IRSxGNA813DkIwwspLlTHkSNthLiFclj+S9/kD6bR4frcT+zt/IX/vNC8UIaC6wM13FiUPR5OJwhEdBmqwvySspF/kvuRZskguNGG0U+8RRT2nduoNHdPPvHqz/UyXRsowLJ7GKhRej3+a1qh59qaUbfKb0U0Z6rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InhT3tLFpAEPqc/cBRcMPhOccnv8KIq0Uf1g4BCMzws=;
 b=Vslx9Geq18nRPCpBEdj7Dc4N7hTuF4fmwnIg/8nmVwVftPVFuOB2Nw0e6XgOTvisyuMtdOH4/Gr9+Nv60/tqAdz8bMUot8CskteeqsVk9HZKPT4bXdbkSqs2tCd5bRgQvyv0DJrSLXSYtMX5NYfDil4YJs1PM0ERyhCvU0jRehI5a/17M39dUfREhreW+pGG7A/yH/FVJyW0IyOZK96Lp2VQGcbg/LiPYS1vPJosfVf6KYvOdEd6HyvaRgcmGhusjpbr4kYjD95dPzLnCXvN+cntvDVmUvVs3eB1tgLPPjERr4XCgJ3IrelB0Kw6Otwn2Ic4LbgmT83AmrI0WBnAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InhT3tLFpAEPqc/cBRcMPhOccnv8KIq0Uf1g4BCMzws=;
 b=kfG1XAWU1j2OslvqSYvGlcAri7o4aK4r7vpUAtw3H/1RG+gzLcRhxWwYbsyKKD08Xwcw+jbbGfQNuFK4MB+JqyWmIaVbMYFgxNosonBH0ZQYXv4JJTCguCFlwj3j3EpUZ67F40OjRv5OSwk6BQyEBGwauZ7bSjcLitjZnVIJK+M=
Received: from BN6PR03CA0113.namprd03.prod.outlook.com (2603:10b6:404:10::27)
 by DM6PR03MB4954.namprd03.prod.outlook.com (2603:10b6:5:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 10:52:58 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR03CA0113.outlook.office365.com
 (2603:10b6:404:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqve5015026
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:57 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:57 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 18/19] spi: bcm63xx: extend error condition to `delay` as well
Date:   Thu, 26 Sep 2019 13:51:46 +0300
Message-ID: <20190926105147.7839-19-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(478600001)(1076003)(186003)(2906002)(14444005)(26005)(7636002)(2870700001)(4744005)(305945005)(336012)(44832011)(51416003)(7696005)(76176011)(356004)(7416002)(47776003)(476003)(2616005)(126002)(6666004)(486006)(446003)(11346002)(54906003)(8936002)(426003)(70206006)(50226002)(2201001)(36756003)(110136005)(86362001)(316002)(70586007)(246002)(8676002)(106002)(50466002)(5660300002)(48376002)(4326008)(107886003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4954;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 809b12ea-04c1-460c-15c0-08d7426fb195
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR03MB4954;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4954:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4954EDE9B5B35C95DB34844BF9860@DM6PR03MB4954.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: sTE0/mSZJdSrWM8Hq/uCy5abrdUYtv7PlPtp1EocLW22OkiD/evwpKwTDMAYkCqiuYdQuKDXrW9azdZCTZC39N+h3MpcuujLTbXH5ZAa/te8ycAsXpE4HgcoG7wIVgTmM58neddJwx9Wy8XAI8e+9t7JWLLvM+F+64QOI5wfcArGKEAL9eU+UgAC8l6PXYlBsRhhdiayAzC2tqfEzrNk85pp+Wgoe1XvGADIF8GeYf0MdMxwTZ1FI9Tfw2GLkFGYhtl5SU4CURwDc7IqB2+ZL00ASH//Ih+dZFg4PHInAc+B19jecHO3Gx8PlR2ToI6FhepWNtv9CDBK9XBaSaReKJMaqVuCu2tdkVGowpTAPSZpwr9Nng3MBOareS13QbROfZLeKY1D/AU4X+M0lhg+5Un8pY/uprwUr7Y7cko3mZw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:58.3084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b12ea-04c1-460c-15c0-08d7426fb195
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4954
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=844 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver errors out if `delay_usecs` is non-zero. This error condition
should be extended to the new `delay` field, to account for when it will be
used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index df1c94a131e6..4e582acda709 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -368,7 +368,7 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 		}
 
 		/* CS will be deasserted directly after transfer */
-		if (t->delay_usecs) {
+		if (t->delay_usecs || t->delay.value) {
 			dev_err(&spi->dev, "unable to keep CS asserted after transfer\n");
 			status = -EINVAL;
 			goto exit;
-- 
2.20.1

