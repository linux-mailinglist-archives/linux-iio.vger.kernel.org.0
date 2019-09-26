Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9261BF066
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfIZKxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:53:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5568 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbfIZKxJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:53:09 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqdX9002555;
        Thu, 26 Sep 2019 06:53:03 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwy81m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:53:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKSl4n0YPLkUt72zZb/+mZBRoeCwuRso5EiibWhRe/7s31ePgVUkRyOW+zgwQlV+YorvCHRGHX49xxSUoxs88qDCWeD6lqOid1Ec8MYLMOgWQJ1VLz/z9GR563MFA2feKdY89v8eFpWl1+L91D0vqP6zisyx8EkM7Joo2uwpw/pEp+vejrDDM2sXSluO8r6pUMc8Mj50SQkWZtS+qtpsGdU6HP2KNLkm54UnknMOv1mKxyEHJQLl9DdaX7iv7w6UfhT2bV/n6SUllqzir+rmWIdEbOBuiDZwvAv9LFPwP1XHlMmmnMxmqx0HAbIO8nwuXGWsPRhXBQ7MZdGba/LLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up797fUmJmr8mxk7XBoVCZkF3leVVxVqShL+Y1oR7d8=;
 b=cO/z6CcF22BFEo9LPQ+DXrN9oAidACnEDnUPwf+rRQPZhVf/W95b8Hel04NndNDMj/bwqA1Q45TZBMkr4GwUMUgjMTryplhuSF5YSoSu5bfVTLEj+i6D7l5vZsm1k4Dw+h96/6NZBj7SgkjF60ucVz3vzc/JrjXVkuKZMBJvVTCWV3jofok/Lf8y0mlGPJT67QxQzhpzav3kfmNPYW0x4YMsaZUT8ub6ixBEnoI2UoybgeH53jUy4I7zTUtHS0umeuzTc+ITHmwQ6rvQOR4b0c9LnaHEq9sSNbe61ufNl+A29/y/dnhEfU2KmNwdBNsGrbYTQ3Uy4B6y9lBObHgwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up797fUmJmr8mxk7XBoVCZkF3leVVxVqShL+Y1oR7d8=;
 b=RmPEwbWS37F5ODyf4zyKloCU6nSnJra7vsFe+6b2N8qXOV9Zk3C92z5r7S5aEthPv6xDAUYFdmj0GvvPmsn4MTJZYBpWJKTmFmpTLgqAdVdckdwq3QqX5D+EGE6W4OUBbw4g0Qa3kLjzX5BT/8pN96lBkY/KPrbUBXZ6xcYcoqU=
Received: from BN6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:404:10::13)
 by BN8PR03MB5041.namprd03.prod.outlook.com (2603:10b6:408:d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:53:01 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR03CA0099.outlook.office365.com
 (2603:10b6:404:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 10:53:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:53:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAr0iF015043
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:53:00 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:53:00 -0400
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
Subject: [PATCH v4 19/19] spi: spi-axi: extend support for the `delay` field
Date:   Thu, 26 Sep 2019 13:51:47 +0300
Message-ID: <20190926105147.7839-20-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(47776003)(36756003)(1076003)(5660300002)(356004)(6666004)(70586007)(70206006)(2201001)(86362001)(50466002)(107886003)(4326008)(426003)(76176011)(246002)(8936002)(305945005)(51416003)(7696005)(7636002)(8676002)(478600001)(106002)(476003)(11346002)(446003)(336012)(486006)(126002)(2616005)(186003)(2870700001)(26005)(2906002)(54906003)(110136005)(316002)(48376002)(7416002)(50226002)(44832011)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB5041;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ac0901-315a-4c45-fa61-08d7426fb322
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN8PR03MB5041;
X-MS-TrafficTypeDiagnostic: BN8PR03MB5041:
X-Microsoft-Antispam-PRVS: <BN8PR03MB50419E9860DC759C09D25264F9860@BN8PR03MB5041.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dNDNWcgcjGpxgeOh6yaA00CMdmbPs2AFT0h4cVxEmSpLDWmSH7JeCX3/aGbe1pZrXD7R8La2OlAamdi9LLXnm+oMGd+fisVlKFftHrhmJn1uBdgGyJHm4ZGMY60wc/WbgGjXxjUJD4IErAuiaL3u+1wUR2wllApBoeFctz40C9kbC3oKuCPDFfpov++c7q/7DDMs+PcVJKjgbHfcZjcTMmE16okXQbVkU4sG59jq5kdwivwhf4krAUQN6a4+k9VjBmdvXzuhahzz4t7XL5MNDig7GvJNywHcC8ySzAusqHljo+9yO0/v6qX9e4NeZTDv3j18AIBJ90LlvGrmpqDsv4ahCecru+6QWypwXWFiUReNN7XZ22k5w1AQvp1WexrPTKkAo2EZhXhWvlesJnoyif+IvyGjnPUxkxxbanvX68E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:53:00.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ac0901-315a-4c45-fa61-08d7426fb322
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5041
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AXI SPI engine driver uses the `delay_usecs` field from `spi_transfer`
to configure delays, which the controller will execute.
This change extends the logic to also include the `delay` value, in case it
is used (instead if `delay_usecs`).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3b1833e6c7ad..111d3b83285f 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -163,10 +163,21 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_engine *spi_engine, unsigned int clk_div, unsigned int delay)
+	struct spi_engine *spi_engine, unsigned int clk_div,
+	struct spi_transfer *xfer)
 {
 	unsigned int spi_clk = clk_get_rate(spi_engine->ref_clk);
 	unsigned int t;
+	int delay;
+
+	if (xfer->delay_usecs) {
+		delay = xfer->delay_usecs;
+	} else {
+		delay = spi_delay_to_ns(&xfer->delay, xfer);
+		if (delay < 0)
+			return;
+		delay /= 1000;
+	}
 
 	if (delay == 0)
 		return;
@@ -218,8 +229,7 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 			spi_engine_gen_cs(p, dry, spi, true);
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, spi_engine, clk_div,
-			xfer->delay_usecs);
+		spi_engine_gen_sleep(p, dry, spi_engine, clk_div, xfer);
 
 		cs_change = xfer->cs_change;
 		if (list_is_last(&xfer->transfer_list, &msg->transfers))
-- 
2.20.1

