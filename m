Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B2B371D1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFFKeQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 06:34:16 -0400
Received: from mail-eopbgr800051.outbound.protection.outlook.com ([40.107.80.51]:31360
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbfFFKeP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jun 2019 06:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkD0mykydMG2xog1W+mKR30qJyKaz+CoWGdwd1dx1Gw=;
 b=sq5Rp2nWeUPIkLR7z2wCO8fm6LYOGhzsBkUjz9x51y690fYocine0pjLA0WlxPcESyOCeDy973rAtbw2dMXIbbZ4P5s45CtOeGpdYIb/YjIjIjSVKWJPad6KHJ0BGfQ3D+w5wI8aGoFWh1A+1ut9lADO9MMxUocwKv8+GKCisT8=
Received: from BN6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:404:23::13)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Thu, 6 Jun
 2019 10:34:13 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR03CA0003.outlook.office365.com
 (2603:10b6:404:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.14 via Frontend
 Transport; Thu, 6 Jun 2019 10:34:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:34:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x56AYCJh011284
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 6 Jun 2019 03:34:12 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Jun 2019 06:34:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] staging: iio: ad2s1210: Remove platform data NULL check in probe
Date:   Thu, 6 Jun 2019 13:34:09 +0300
Message-ID: <20190606103409.28160-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(136003)(376002)(2980300002)(199004)(189003)(50226002)(70586007)(486006)(47776003)(6916009)(36756003)(51416003)(7696005)(7636002)(246002)(44832011)(2351001)(305945005)(356004)(77096007)(5660300002)(4744005)(50466002)(70206006)(426003)(126002)(106002)(86362001)(478600001)(2616005)(186003)(1076003)(476003)(316002)(336012)(2870700001)(48376002)(2906002)(8936002)(26005)(8676002)(107886003)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc8ed57-c20a-40d6-9261-08d6ea6a848c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Antispam-PRVS: <BL2PR03MB546D3F7E6C81BBF9F514B31F9170@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9leNdfVMv/98dBiMBSYgOoa0v4/9vvh9BTWcFfx37tsIW9ZVVBz091oqeLWwCEKGQAzFDB+lMGOqR62FB1+zuWidEo5D6sHqfsrELIEm9SovX5bms3ELK7B9lHn3LjFxSuI2GqhG3Zw/1efBfE8yhb+TS01NgNwyFIum92wrH7iBxu1iVEmnjohITsW57M/0FYNqzUUzCCBdpFZ7tWCsLE4B0QZ8hAs2/Fa0V8WgekfsU0mYJqVDbQ7hgju4VbtzWEJg4kIxxkqQDeMqW+UZMyOk2cZOQD+dyYw9rJw5YJSYxBs7zl4NZQwF/fXVY4SWBbDTCUlZTiqP4weRzierhXkzadVznjfeRSo/7yGaU4XcsUZYLGSBMS6rTyk+GS/KNBv0nPCtVw1XxZQkRe1AK3AYA0y9S378jc5WBYRWAhU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:34:12.7879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc8ed57-c20a-40d6-9261-08d6ea6a848c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver only needs to access GPIOs via GPIOLIB. And SPI can be
configured via device-tree or ACPI.

The platform data is a remnant from another time, and should not cause the
driver to error out during probing if it is NULL.
Also, it's not used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index b6be0bc202f5..0c1bd108c386 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -647,9 +647,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	struct ad2s1210_state *st;
 	int ret;
 
-	if (!spi->dev.platform_data)
-		return -EINVAL;
-
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.20.1

