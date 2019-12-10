Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F782118305
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 10:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLJJIX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 04:08:23 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44648 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfLJJIX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 04:08:23 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA963sJ027946;
        Tue, 10 Dec 2019 04:08:17 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wragq8w8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 04:08:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNspiMcpejDTjqSVDZjtOS4VisQRnGxKjuCwauu1bS6TiYtu/d7WB9fxxvu9+AoLa/mLdYc6xFO1TzSx47vVfUZM/SuKPwC7QoImT3VdChEYHgwoVIH97O3tjeVzqbp//veDUcY3mN4OQDKmM1eU5LGcU9bzGwO81hcvlD5G/riE3WOuoPyfvHzyLB3zf7eVycEbZ9tvr5CC45bLcng5L7YOEHi2dHD5l/C2ORBWKuzqoYvut0yIzw5JAZtc7X5UqOToGRO0DgBzE6jP8QABQQN/9iTdO04Ko9ImTjDdMunKGbiPtwzDW7+lp3Xe9nIAKS2HftgAZ4j6ix4buy2VhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD6S9OstvxVnLhSmVSTtZpqQw5QTVU3QYhQajnSg27w=;
 b=C8eQytHsNVrhcoIBZ8efLjWDsEh2kSPIcyeKJRZplpKdWju9Sa6gIE2QRF9J6PrlXAZeRHM11BUFndWFOaXOvOWANl34kNfQx8cR/DbP4QAl6RIZxqghSsFOZWy3/fFYiXGYQzPs8HnI9Rbiir6WaPIOHLUHCqwic8qcr6f6S0/YaE1rsqfOBK+GcuILO0+Kn6Eg6k7Cv1AXztcdg4LMsCEj/+mVg0ZQeoV861CvGzawc4oBAuYitBdmta9T/Rfdv23WNYAlBwdOJ/7R1fpMXcnCNMot1QkFA46MHwD7irXUFjnNUOommcvbaqup2T+ZCNs3XirqBIYxXNHhC87K0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD6S9OstvxVnLhSmVSTtZpqQw5QTVU3QYhQajnSg27w=;
 b=5NvZ+psMTwicTlP2b5Xxg/G6BmDrE/lyYfnIfhfoLgwbfVIEiCcjPsmAgAgQ9lRzL8U0Mfceuf5D3cqCFeFnzJgk6KRrznnrl2hy4X6WbLCsYC9SXW8hPOmXDa+7TnFvE8kjXdfsSEOlCbUedjPWH91Vslnec6GPKWOKgah5Iwc=
Received: from DM6PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:40::40) by
 BL0PR03MB4164.namprd03.prod.outlook.com (2603:10b6:208:67::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 09:08:16 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by DM6PR03CA0027.outlook.office365.com
 (2603:10b6:5:40::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Tue, 10 Dec 2019 09:08:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Tue, 10 Dec 2019 09:08:15 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBA98Frr011330
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 10 Dec 2019 01:08:15 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 10 Dec
 2019 04:08:15 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 10 Dec 2019 04:08:15 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBA98D2Y003477;
        Tue, 10 Dec 2019 04:08:13 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: adc: ad7124: Fix DT channel configuration
Date:   Tue, 10 Dec 2019 11:06:21 +0200
Message-ID: <20191210090621.21714-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(4326008)(246002)(2906002)(8936002)(6666004)(2616005)(5660300002)(8676002)(356004)(107886003)(54906003)(316002)(70586007)(305945005)(7636002)(1076003)(70206006)(186003)(2870700001)(478600001)(86362001)(36756003)(44832011)(426003)(336012)(110136005)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4164;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02ec5762-5834-4c7d-d4c1-08d77d507dee
X-MS-TrafficTypeDiagnostic: BL0PR03MB4164:
X-Microsoft-Antispam-PRVS: <BL0PR03MB4164CE70BA2B2F9345DC7CB0905B0@BL0PR03MB4164.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02475B2A01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zf/PJLj4EfzFuH/30s14u3EeK57hPSYxch30sqfqAaY79L4/6g4bbveJipErXn+3EY/n3al9XconI8KM3oXfd5s7zwUCaXWWm+GOj1SFWR1DjNeX7jvRn8nIsIiGPtaoln7xX5zYD4JGu+Tpuo9YGjPBjzp10jfPYkNXsquIpxSAyySQRVZFx8mQZ8LXCFglQQD0G1fKWq0E58ZGwToPNbHSLJvd7BuZrsi8tB+ieekSgcRmta7qnrImdLe3BhNcZzKG8/Jit+E1lNNhb/j2Au4qY+al8iJZgMP+Amsx5G9RL8kcbPxPsFweaGs7KCVDvipMYPYBvVoIrf8MIP5Uk88juOYGCgpVEFkceWFkxVqXMqHaRPDLrBwdlYmvyozbwLUy9Nsmd1bIcV/W8eZdc1KffXYgpheKCYaXhmoMzUs5QxPSVe4P+gAx4Vw/ZX/V
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 09:08:15.9483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ec5762-5834-4c7d-d4c1-08d77d507dee
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4164
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch fixes device tree channel configuration.

Before this patch, the driver assumed that the DT children (adc channels)
are parsed in the order they are written in the DT. Now the driver uses the
reg property of each child to correctly identify to which channel the
parsed configuration belongs to.

Fixes b3af341bbd966: ("iio: adc: Add ad7124 support")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index edc6f1cc90b2..43a56c6f4cf3 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -489,13 +489,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		st->channel_config[channel].buf_negative =
 			of_property_read_bool(child, "adi,buffered-negative");
 
-		*chan = ad7124_channel_template;
-		chan->address = channel;
-		chan->scan_index = channel;
-		chan->channel = ain[0];
-		chan->channel2 = ain[1];
-
-		chan++;
+		chan[channel] = ad7124_channel_template;
+		chan[channel].address = channel;
+		chan[channel].scan_index = channel;
+		chan[channel].channel = ain[0];
+		chan[channel].channel2 = ain[1];
 	}
 
 	return 0;
-- 
2.20.1

