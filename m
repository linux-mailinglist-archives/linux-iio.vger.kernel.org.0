Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC33EB19F2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfIMIqw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35126 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387782AbfIMIqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:51 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gaUD015969;
        Fri, 13 Sep 2019 04:46:44 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2058.outbound.protection.outlook.com [104.47.34.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdksa6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU7wHEOcRG4BSrs+Fd8uhS16hBZ2h1bd19B7ZNh00g63oQIw9eOCR9esJSD51kRHG52xSBeYqv4yi6w5raAicNrYR3muD+seccDeSPRBYV3XYuND3l+G8QHm8OQta/c7W3otOhbPozMSPeu3R8n2DwodPUNV5041OO0MnDRd09+68vl1PQ6p97qK9hCLzDOwINJrhaVBuyjOrJRxcUTE6smvGkhO0WL6vqc19bnBLGCiU5P4Iz8Ey7z4kIy8OP1Aho4fa/ZiHNIFaaa2TRHZkDwQBQJMLGyjPtAgANHqU1Vk8Ji2fvjxyvkPrmAoK2QQ/Ish97D/WlLboZ/OGq3TjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eZVsTNwzDgCxa0wjOHr/PorZMO2qAzcIXvyuqXf5D8=;
 b=g35Niy49efBTyFAqgezP7MYvp42HiC8lPlDVdxmSMgMFQgS0G2RsCTRFDN32ULwt7N7TThvES2+BAhmOWGi9Pzph3VH4x3Ni9VDyfSHT5LUm5+UI34426v2GVaDKY4KsQsQt0SeLKsOkKvgNhcbDcIhVkcrA5/C3lJCgmm69jIa+uBQcZN5OeCQEwU/BegBkmJ4Njh+45d2uKoRspJFucU8S6HkT/yICpKNgihBVHRozbnPhlqQPipE26OPemdLk1epCZsKQeAJPDc1rHIejTMV0BjKtaqVFEdKm2x3LMEuCbhT7KeGgvguInu3kOZq9uD7Z8lEEEm0GWvZJUT1/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eZVsTNwzDgCxa0wjOHr/PorZMO2qAzcIXvyuqXf5D8=;
 b=CLnDKCHKy+QfVgosMCioGEr9HTSJx4ujbab6aGzedBrMSvpQC0u6anQ7tdKVKQg7Yz7lo3hfCyqlpfj6WPDk2G0kwzn83hWwhUfQpkO2R01DhxYDoSR0yETQlu+L4VhItrUovsUjj7yE4kLqHplgpyMgjbjggvTBLjL3He517k4=
Received: from BN3PR03CA0100.namprd03.prod.outlook.com (2603:10b6:400:4::18)
 by BYAPR03MB3799.namprd03.prod.outlook.com (2603:10b6:a03:6f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15; Fri, 13 Sep
 2019 08:46:43 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN3PR03CA0100.outlook.office365.com
 (2603:10b6:400:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:42 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kbhW030732
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:37 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:41 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 12/15] spi: spi-loopback-test: use new `delay` field
Date:   Fri, 13 Sep 2019 14:45:47 +0300
Message-ID: <20190913114550.956-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(54906003)(426003)(446003)(356004)(50226002)(86362001)(44832011)(476003)(486006)(2870700001)(70206006)(51416003)(11346002)(7696005)(7636002)(126002)(8936002)(70586007)(107886003)(305945005)(8676002)(246002)(76176011)(2616005)(478600001)(186003)(36756003)(2201001)(7416002)(2906002)(316002)(110136005)(48376002)(4326008)(26005)(5660300002)(1076003)(106002)(50466002)(47776003)(336012)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3799;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 492ce2f4-6f95-4897-0d66-08d73826e6a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR03MB3799;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3799:
X-Microsoft-Antispam-PRVS: <BYAPR03MB379927DB409374DD5B9BA940F9B30@BYAPR03MB3799.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aRPsKEtJCzprUENgjeZBi73UwzYkamBAcK5VhMKCTRYg0QmGY6e7fpUC5P8aUtiBOWl0ShdDdoavlnCRiRUmQJqfB/LcUFT84FYkT0MizdDn2niN3SstaWvvfUwpazdF0Jw5vLQe1t2qCp83wt1AEQHKZ8Z4+I4EYPLySy2Jm5sRtU8qrEQTLS2yWioeLrIzFjJDWFqnMoX4Ej+xk03yrgVKHQ2dByLLNtRQ97S2LKL2m/5TlWCbJebf1nHv9s4Q6NMYvJThXXulY4FKHDgbroED9uRK8RIFlzJlkRkcYbgJ5vqjLMTmJ8FI1J3fXkucnyHmVHcwdFEDFHFqPPZPv0bP4eW4jk/aUkpRh3vMXGusmmoEhQ1axGwc5fe1TqrUUriik9O5/N+ogY0jS6sqdNfJ8gq0kimIxZ/hPR0Wqjs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:42.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ce2f4-6f95-4897-0d66-08d73826e6a8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3799
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=937 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change replaces the use of the `delay_usecs` field with the new
`delay` field. The code/test still uses micro-seconds, but they are now
configured and used via the `struct spi_delay` format of the `delay` field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-loopback-test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6f18d4952767..b6d79cd156fb 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -298,12 +298,18 @@ static struct spi_test spi_tests[] = {
 			{
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
-				.delay_usecs = 1000,
+				.delay = {
+					.value = 1000,
+					.unit = SPI_DELAY_UNIT_USECS,
+				},
 			},
 			{
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
-				.delay_usecs = 1000,
+				.delay = {
+					.value = 1000,
+					.unit = SPI_DELAY_UNIT_USECS,
+				},
 			},
 		},
 	},
@@ -537,7 +543,7 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 		unsigned long long nbits = (unsigned long long)BITS_PER_BYTE *
 					   xfer->len;
 
-		delay_usecs += xfer->delay_usecs;
+		delay_usecs += xfer->delay.value;
 		if (!xfer->speed_hz)
 			continue;
 		estimated_time += div_u64(nbits * NSEC_PER_SEC, xfer->speed_hz);
-- 
2.20.1

