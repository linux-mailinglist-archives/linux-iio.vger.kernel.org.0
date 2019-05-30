Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2B2FC15
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfE3NSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 09:18:22 -0400
Received: from mail-eopbgr720050.outbound.protection.outlook.com ([40.107.72.50]:3802
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfE3NSW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 09:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO/bcZDCRaN8q62TyTkRmVhEwCcDp6w+4lCAwjrM+1M=;
 b=l9E1yUaLVih8E2vl0wABlJ9TDDG0TJqfMFr30EupnMVjRC6u3BZwdTrvFeWJODosXX8vd9LzyClwJCeRZuXYyD69/gKZxGuRaXPW4By5CZbjcws4e2MxhHGa7cROB/pJ/lfpTAFBCSuqYFZHzGi0N0j+tYsO32Ugw2M2kEOaiXI=
Received: from BN6PR03CA0084.namprd03.prod.outlook.com (2603:10b6:405:6f::22)
 by DM2PR03MB560.namprd03.prod.outlook.com (2a01:111:e400:241c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.17; Thu, 30 May
 2019 13:18:19 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0084.outlook.office365.com
 (2603:10b6:405:6f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Thu, 30 May 2019 13:18:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 13:18:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4UDIImo024223
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 06:18:18 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 09:18:18 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/5] iio: amplifiers: update license information
Date:   Thu, 30 May 2019 16:18:08 +0300
Message-ID: <20190530131812.3476-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(199004)(189003)(8676002)(14444005)(2870700001)(186003)(50226002)(8936002)(2616005)(305945005)(1076003)(6916009)(44832011)(246002)(36756003)(86362001)(7636002)(336012)(5660300002)(77096007)(2906002)(26005)(50466002)(476003)(2351001)(106002)(70206006)(53416004)(15650500001)(486006)(316002)(4326008)(47776003)(6666004)(51416003)(7696005)(426003)(48376002)(107886003)(126002)(478600001)(70586007)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB560;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e74167-df49-4c2f-c5d6-08d6e5014858
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM2PR03MB560;
X-MS-TrafficTypeDiagnostic: DM2PR03MB560:
X-Microsoft-Antispam-PRVS: <DM2PR03MB56049104D1E18F15BCC5BDBF9180@DM2PR03MB560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: z55HagO/cxG+uL2u7bMNk6rDTvo7/JgPBodBdDEpDcpv3T0/hsHw00k6EMgEHdytQ7JFBVC1o+3mSmD80tqYXGoQARvZzWkRNT1U/aFZXpPEAZDIpy4LzQzhneak0Jycm4fwrgmWdczWD5vyLL8FtSQ+jx4AzYq5RbExJ3Zec5rPD65Wmr3YQqhBKWpfQ/OhRRzA+aNl8M93Mp12Y7kSDuSqjGts/WmZgbGaY9g54X1K2X/fsfkklxiZLwg6gy67g3m0HlgRNGgA/QCtwGkVwuHuQlT6m+QYHKtaS8MDVZIhwY6CHtfA7vNU/9waNu5GmSkqkHKh5zMWb4WmjTFQgCn4auhV5Bn84lJ3CL1JB1JyfwktUiWhVeWlcE3i/vO+S2Vpbo5JWyxlQyPrvccBGQ5TKZDKFSCx8RKJ1UQeg2k=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 13:18:19.0058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e74167-df49-4c2f-c5d6-08d6e5014858
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB560
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the new `SPDX-License-Identifier` tag to specify the license.
For ad8366, also update copyright years in the header part.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/Kconfig  | 1 +
 drivers/iio/amplifiers/ad8366.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index e9c5f2cd9257..da5830da9bcf 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Gain Amplifiers, etc.
 #
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 4b76b61ba4be..82ac15914ff3 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
  *
- * Copyright 2012 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
+ * Copyright 2012-2019 Analog Devices Inc.
  */
 
 #include <linux/device.h>
-- 
2.20.1

