Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22952F7E2
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE3HZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 03:25:51 -0400
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:29321
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfE3HZv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 03:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQCDNo4GmW1rvQt9DuOFeD3LZmPPnYj1nqcFPy4S7YY=;
 b=4dRruM5AEDuzBkOPRDqRF+N0iDLRxPOPYhu3AG4LfjvSqrUtbDs7tF+1pPJBYWPFyza0ctzGpZvojMreK+InlTUYGYmdLQ9PCIX9v4yuS+/uruJW39FcVgk+O5PmelOr9Dk8OWQhpRRif+sCIoajhQYDAZ5RUEOYAC07Ck5CyRY=
Received: from MWHPR03CA0004.namprd03.prod.outlook.com (2603:10b6:300:117::14)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.22; Thu, 30 May
 2019 07:25:47 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR03CA0004.outlook.office365.com
 (2603:10b6:300:117::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Thu, 30 May 2019 07:25:46 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 07:25:46 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4U7PjEY006308
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 00:25:45 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 03:25:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: return directly in ad_sd_buffer_postenable()
Date:   Thu, 30 May 2019 10:25:41 +0300
Message-ID: <20190530072541.22268-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(199004)(189003)(2616005)(44832011)(5660300002)(478600001)(7636002)(14444005)(53416004)(47776003)(316002)(246002)(2870700001)(2351001)(6666004)(2906002)(356004)(476003)(50226002)(8676002)(486006)(86362001)(7696005)(48376002)(107886003)(6916009)(126002)(4326008)(305945005)(186003)(4744005)(70206006)(70586007)(77096007)(26005)(336012)(51416003)(1076003)(426003)(8936002)(106002)(50466002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e02835f-cab5-4124-8bd8-08d6e4d00860
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:BLUPR03MB552;
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Antispam-PRVS: <BLUPR03MB5520766281DA861700A7F62F9180@BLUPR03MB552.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jpfGJVCetM6kAuyOd4VO5HQc1zay/TQMCBC2TfMuwYXU5AuSsJaUw+X3XWqZyoZCSjAxJEUWVAV83D1D2SNbhTZV38J6RpaLTj4kZko6l7ex33qaDGcXp+26p8G7wdaNvuh4+1VL/JtFf0rT85USI2oVon5PgHzwehw7ZeKYW6YseNVvArHW7vYKStnuTTd1iMmUAt34fO15nA1RrnR5P8F1BSZcJ6eTvlbC7pnEX30ltvQV3vH7bS/iEovKjFzHe6gyhsTX3fHwyz/Cztot0bqNyQfMfWKbD+Az0ExC4cyX9NbvX+Qj89KC0EQh/V5pk2RUD5si5Sxltxr4gYGjKUv9oNZMFnRDt6FpfBD+FGK70aX6L7lBlWn9iQnEPL3FoaGypdoXO1+kZNpWvmpAwIXjzWHG3S+OSDRlP62pJg4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 07:25:46.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e02835f-cab5-4124-8bd8-08d6e4d00860
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is nothing being done after the `err_predisable` label, so just
remove it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a4310600a853..ec0e38566ece 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -358,7 +358,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	ret = ad_sigma_delta_set_channel(sigma_delta,
 		indio_dev->channels[channel].address);
 	if (ret)
-		goto err_predisable;
+		return ret;
 
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
@@ -375,7 +375,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 err_unlock:
 	spi_bus_unlock(sigma_delta->spi->master);
-err_predisable:
 
 	return ret;
 }
-- 
2.20.1

