Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16E52F829
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfE3H7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 03:59:21 -0400
Received: from mail-eopbgr720087.outbound.protection.outlook.com ([40.107.72.87]:36016
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfE3H7V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 03:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWakkjqMu25r+qG4TN1DC5m85Mr0k16qxNZ9eWf5B4Q=;
 b=RlypevZ+9aVcqR/7FL3NuRK3EfmBngpQvKeLRORY4K6SkWW8HOU6z9HO5fcmF28lBbyzaeIwSvCUx1X/Kdc8h2dozNqV8TW/lJD/nxRRW2x8HBzQljqGH3Y69j/PG1GcFK0qHbFl/x/EmrtcxJvrAOLTFpG82PVhma7XIYcoFQI=
Received: from CY1PR03CA0027.namprd03.prod.outlook.com (2603:10b6:600::37) by
 BY2PR03MB555.namprd03.prod.outlook.com (2a01:111:e400:2c37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.20; Thu, 30 May
 2019 07:59:17 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY1PR03CA0027.outlook.office365.com
 (2603:10b6:600::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Thu, 30 May 2019 07:59:17 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 07:59:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4U7xFdV003602
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 00:59:15 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 03:59:15 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: allocate data dynamically for samples
Date:   Thu, 30 May 2019 10:59:11 +0300
Message-ID: <20190530075911.6032-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(189003)(199004)(7636002)(336012)(486006)(476003)(2351001)(316002)(246002)(126002)(53416004)(47776003)(356004)(50226002)(6666004)(305945005)(2870700001)(2906002)(48376002)(478600001)(7696005)(14444005)(51416003)(70586007)(70206006)(50466002)(106002)(44832011)(36756003)(26005)(6916009)(4326008)(426003)(77096007)(5660300002)(8936002)(186003)(1076003)(86362001)(8676002)(107886003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB555;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4fe0be-1ba3-4d86-146d-08d6e4d4b6b4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BY2PR03MB555;
X-MS-TrafficTypeDiagnostic: BY2PR03MB555:
X-Microsoft-Antispam-PRVS: <BY2PR03MB55531A2FCA72F26D0F5CFD6F9180@BY2PR03MB555.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5g9gH2ymntNUi1IuiQurif5c+Le/jXA/l7HHpR7ivbY4VrqDIVn51hbsbuZU5ICh0ZMmnhl0UAvdIy1QMtsjuREtDIJKTZWkFy5s4bbm9PrppD/Fewl3jLCZQ0JktCOvxo2esee8rQH35Rf1JRRLPkS8eQOvlTSSbZCdJJXmHWQw/f3eF73//HaGRpS5jMsC9dXS3ZU96NLu73MfW1G1jkqtcMjK/jUNr0wPLo2oTx53Rk//Be0ag9SxkG+a9fdUln+moT+PL+HDgMTjhoGLZRKhF5DYPud6t0+OkdCLkJ96L7hqCOxvd9R2UucBcWAlNMw3VI2XvjNf08W3GagX+RLo78WRWI/Idjy/PWqwjnhgaOZ/PTfOgm8c5LUVWwcofWANtMYDDwyOn8cpWjHndEtQMgJAMzO5z6vJWfufQLQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 07:59:16.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fe0be-1ba3-4d86-146d-08d6e4d4b6b4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB555
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change has a few parts:
1. Remove the buffer from the trigger handler's stack
2. Having it dynamically allocated means it should be cache-aligned
3. The buffer would now adapt to the actual number of bytes needed,
   whether it's more than 16 bytes, or less
4. Having it in the heap somewhere, allows it to work with DMA

This is a fix + enhancement in one.

Fixes: af3008485ea03 ("iio: ad_sigma_delta: allocate data dynamically for samples")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 12 ++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ec0e38566ece..91d5dda53d29 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -360,6 +360,11 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	kfree(sigma_delta->buf_data);
+	sigma_delta->buf_data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (!sigma_delta->buf_data)
+		return -ENOMEM;
+
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
@@ -403,12 +408,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	uint8_t *data = sigma_delta->buf_data;
 	unsigned int reg_size;
 	unsigned int data_reg;
-	uint8_t data[16];
 	int ret;
 
-	memset(data, 0x00, 16);
+	memset(data, 0x00, indio_dev->scan_bytes);
 
 	reg_size = indio_dev->channels[0].scan_type.realbits +
 			indio_dev->channels[0].scan_type.shift;
@@ -568,6 +573,9 @@ EXPORT_SYMBOL_GPL(ad_sd_setup_buffer_and_trigger);
  */
 void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev)
 {
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+
+	kfree(sigma_delta->buf_data);
 	ad_sd_remove_trigger(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 }
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 6e9fb1932dde..36dc49b8dfd5 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -75,6 +75,8 @@ struct ad_sigma_delta {
 
 	const struct ad_sigma_delta_info *info;
 
+	uint8_t			*buf_data;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
-- 
2.20.1

