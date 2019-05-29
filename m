Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805062DDA4
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfE2NBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 May 2019 09:01:17 -0400
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:13149
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfE2NBQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 May 2019 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmdc9cfmSCiwteBibCGrmJIWUXu4ek5G/F99l00EITg=;
 b=vmweGfGUNPcjQlKqjbSF0uOaAsklyQjTx3qWLJ1A87f5Y/Aqows3E+FZT9acg1FnXQyV/VPjx5+Mry+NPYmmz6Z+NkqWXPd+FbWrvjObeOOSfoZIqEf2FVZu7VcOwJZ0AtWRzvM977xXurpk4CS+LBXhksmet/2wyeIRifKm6j4=
Received: from BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30)
 by CY1PR03MB2268.namprd03.prod.outlook.com (2a01:111:e400:c614::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.18; Wed, 29 May
 2019 13:01:13 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BYAPR03CA0017.outlook.office365.com
 (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Wed, 29 May 2019 13:01:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Wed, 29 May 2019 13:01:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4TD1B3u028020
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2019 06:01:11 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 29 May 2019
 09:01:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adxl372: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Wed, 29 May 2019 16:01:08 +0300
Message-ID: <20190529130108.30331-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(2980300002)(199004)(189003)(51416003)(126002)(6666004)(356004)(6916009)(426003)(336012)(2870700001)(486006)(316002)(186003)(7696005)(476003)(5024004)(26005)(478600001)(77096007)(5660300002)(1076003)(2616005)(8676002)(86362001)(8936002)(48376002)(70586007)(36756003)(2351001)(2906002)(246002)(305945005)(7636002)(44832011)(50466002)(53416004)(106002)(107886003)(4326008)(50226002)(47776003)(70206006)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2268;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf6346b0-a994-443c-2765-08d6e435ba35
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:CY1PR03MB2268;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2268:
X-Microsoft-Antispam-PRVS: <CY1PR03MB2268B6A32B5FA79035B13B8DF91F0@CY1PR03MB2268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0052308DC6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xTZBzgFG88k2XtAwzuYR0T2CACGrgt8i5bTX/jB4XpOP0CNtq5lF4WyWN+5DRJCtTZlDB/eTk1MgqMq/G9R3b8EvTFEdYV2n5Ocr4S1baitYYbRWNKWZgDP1VifKbT6WqHOnB41pBv7lGfkKqDovX3E6tgZjsjoR824irGniaZ+hDw54r3jMPQnlM6yVQZb2Mtp6KNryqwzqJtEUt6KDEYo0J6I7O/7aOIBgwvg2Rw7qP0+5PnVh/4UxoAEb6CCalI8rO3a9SH8cH7PXNu0eBDdkU4m3cMqj1wc408qPt0Elge9Kvb6SBKIgWog+AFzEjoBiD94Z+6VHk51/+K3OaYqPHQkw7FJhukLNMdIb1N92985XS3nSHv3s4m6hxsy0CmRjkFQfx9jONIXUUWHQgn6X+AcK+b/JOFooU4Pz0LI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2019 13:01:12.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6346b0-a994-443c-2765-08d6e435ba35
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2268
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 3b84cb243a87..055227cb3d43 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -782,10 +782,14 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	unsigned int mask;
 	int i, ret;
 
-	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	ret = iio_triggered_buffer_postenable(indio_dev);
 	if (ret < 0)
 		return ret;
 
+	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	if (ret < 0)
+		goto err;
+
 	mask = *indio_dev->active_scan_mask;
 
 	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
@@ -793,8 +797,10 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(adxl372_axis_lookup_table))
-		return -EINVAL;
+	if (i == ARRAY_SIZE(adxl372_axis_lookup_table)) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
@@ -814,26 +820,25 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret < 0) {
 		st->fifo_mode = ADXL372_FIFO_BYPASSED;
 		adxl372_set_interrupts(st, 0, 0);
-		return ret;
+		goto err;
 	}
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
+
+err:
+	iio_triggered_buffer_predisable(indio_dev);
+	return ret;
 }
 
 static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
 
 	adxl372_set_interrupts(st, 0, 0);
 	st->fifo_mode = ADXL372_FIFO_BYPASSED;
 	adxl372_configure_fifo(st);
 
-	return 0;
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
-- 
2.20.1

