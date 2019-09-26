Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B8BF047
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfIZKwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55238 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbfIZKwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:44 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqaKX006040;
        Thu, 26 Sep 2019 06:52:38 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96rc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp9mDqsO1ULkQD+isvsrtAzz+YdH6U3AzGC9EXC6RCvxzqMLH+Wyc9AXBYdyeK+lGu97tVrmxhk0hQR/4ejyWdQox4N9dGU+Ry+I4Xw5tUz83ErcaU9Me1GEaedR7teVlNDZTlXk/y14CfBqGZ0y7Gn304aHUWMOQTij+RwOsKqsbx1bGLjCq72T8jipOXyECGHYzd4BIwJVh2VfPJ+rHQGZw9T6DJytaeDcBnJdUlg/bUWYcnqlSF8EHmMmwDPxEZbntKZ54TCGkwpMYbb+lbt6WQWtkItVf3pLZfv6DOb1GF9G6hWmbFeoioJ6BZSADCHNyog6SyGm6oT41gNVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQjYpYv97m4TZLPufi3D9ESbTPdJRj3NrXmqIglhcCY=;
 b=dhtokO2NKe9a5aVEsRNkjScnmdkCGJF/C8GMecegzCLdKXiHPlwLzwlfhxTqWyAcw6Ipu5FFHLZFNYw8PiQe/ZKf5F6B1SGr1XAFBT+OC0KU4qIM23Niv0C8jMVaxpzYfwTvNkluTgEukJPR2j87VcyWYgKngidZA/MdO22hy+G8PonQomeqTKQ1Pb7Xnz9S1FOC7X0PIxqbOH3qGw65E3biCF6sJ8gZPoIvNBETUecAB4paXyUvsEgsRu3JanyeqfjNDV/MQgcNMb8uZdNGQOaF1q62CkUNdoAtdFnjDKXRLk6lZ6CVs3+q1rCuDNUpWMyvs0XlqHFbmK4QW4R79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQjYpYv97m4TZLPufi3D9ESbTPdJRj3NrXmqIglhcCY=;
 b=z5t9C7+wBEZsd/KTgyFW5lNEU+uR+bbLhCSmYs3nWxxJFyg/sMINCCMWAT/2H4h8RUKQwscdeVg4LQr342MgzSjQep2ZNrJau016s0gL8eFkVO8iJBJtPdICZuFUfLex8vWZ/TjqnWEs5fYHxbASi/XBya2qjMdmMHe7PjxvMa8=
Received: from BN3PR03CA0105.namprd03.prod.outlook.com (2603:10b6:400:4::23)
 by CO2PR03MB2262.namprd03.prod.outlook.com (2603:10b6:102:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22; Thu, 26 Sep
 2019 10:52:36 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN3PR03CA0105.outlook.office365.com
 (2603:10b6:400:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqZC6014810
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:35 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:35 -0400
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
Subject: [PATCH v4 10/19] spi: tegra114: use `spi_transfer_delay_exec` helper
Date:   Thu, 26 Sep 2019 13:51:38 +0300
Message-ID: <20190926105147.7839-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(5660300002)(11346002)(186003)(426003)(336012)(446003)(47776003)(246002)(86362001)(8676002)(356004)(2201001)(7696005)(51416003)(76176011)(70586007)(26005)(8936002)(1076003)(36756003)(7416002)(50226002)(316002)(2616005)(478600001)(476003)(126002)(305945005)(70206006)(2870700001)(7636002)(2906002)(486006)(48376002)(50466002)(44832011)(107886003)(4326008)(106002)(54906003)(110136005)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2262;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adebd68-1379-459c-4a9f-08d7426fa43d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CO2PR03MB2262;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2262:
X-Microsoft-Antispam-PRVS: <CO2PR03MB22620D27D1EF0A2EFEF59C02F9860@CO2PR03MB2262.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FOnZWXI7wTpVDeZ0tQB/JJaFJT2QCblRFy+VOS87TJQr9kJtSg2gpTnkrwITwIHYPq01Te6Iq3KSwybUTWEPlOG9xyVE1m6r9NEoWB9aUY3lue/9io26QZo1o/82y5fmupke25GHXiG/gEipGB2EsMFUHND3Snz8XKMoSu7fTga+VXnGTP+4e+4/vr3Y5MoQmaFUIa5WEYXZbSRmZDQFT05S4vDwQQB4673NFkWlgAjUWIRnf6T2KTJUW1A+88RhZ4imj+6ZOH/hE6/oG71A2beRZWTlNmK92t+lHE9SKB0eG7d3etuTyI8xEUZk8VyXW//7NktIwyRpnKlB59jOrEubyaGw9J37Mdo4pfEv1WR0GP/s3QmO0N020DjMjEZ9gpGimJv+7Yt8fQ6rWQeOwAMcHfA0GlkIV07eHTt/5EY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:35.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adebd68-1379-459c-4a9f-08d7426fa43d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2262
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The tegra114 driver has a weird/separate `tegra_spi_transfer_delay()`
function that does 2 delays: one mdelay() and one udelay().

This was introduced via commit f4fade12d506e14867a2b0a5e2f7aaf227297d8b
("spi/tegra114: Correct support for cs_change").

There doesn't seem to be a mention in that commit message to suggest a
specific need/use-case for having the 2 delay calls.
For the most part, udelay() should be sufficient.

This change replaces it with the new `spi_transfer_delay_exec()`, which
should do the same thing.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-tegra114.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 39374c2edcf3..8133dc49d34f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -984,17 +984,6 @@ static int tegra_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void tegra_spi_transfer_delay(int delay)
-{
-	if (!delay)
-		return;
-
-	if (delay >= 1000)
-		mdelay(delay / 1000);
-
-	udelay(delay % 1000);
-}
-
 static void tegra_spi_transfer_end(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
@@ -1098,7 +1087,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 complete_xfer:
 		if (ret < 0 || skip) {
 			tegra_spi_transfer_end(spi);
-			tegra_spi_transfer_delay(xfer->delay_usecs);
+			spi_transfer_delay_exec(xfer);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
 					&msg->transfers)) {
@@ -1106,11 +1095,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 				tspi->cs_control = spi;
 			else {
 				tegra_spi_transfer_end(spi);
-				tegra_spi_transfer_delay(xfer->delay_usecs);
+				spi_transfer_delay_exec(xfer);
 			}
 		} else if (xfer->cs_change) {
 			tegra_spi_transfer_end(spi);
-			tegra_spi_transfer_delay(xfer->delay_usecs);
+			spi_transfer_delay_exec(xfer);
 		}
 
 	}
-- 
2.20.1

