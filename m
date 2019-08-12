Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4889926
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfHLJBN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 05:01:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6068 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbfHLJBN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 05:01:13 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C8wsWk005544;
        Mon, 12 Aug 2019 05:00:50 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2050.outbound.protection.outlook.com [104.47.34.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u9tu6mm0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 05:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBlUIR8bqp0Cu3P3g2BCWBY0EWJPtGT35n6GMLtknnZv481dlHbYEWKk5SA0hugXAUjiQOdfMTIqBJaOL6t+bFqllAJvERa7M8KJlvkm3UAaqKtVM+Racz7P36Xol5/HyHR9SsQoIwvV/VuPiNBTQarDz4luIdEMBlBRCkU5rULbH06uNS+7wwP2MOt6dMBApcROqF0uPWhcMZ1pyxviUgyXu2u+y+DnWls3tuHKYJA3BzZTKgjAQ3CXhidd7VayxoDcmuwssLgs2PprOYu2mSjXDKLjR5Z+WSEwZWQ+MWjyk9HMji0+Vzo+V12ckLEe8i5FxbpRUPQppJmNjzjpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ3jOC3BcruAnx3mzNXR+eXYowISk9eZTffynHomYcw=;
 b=J+lFBPP6vcrajKEKVP97+mWRmKqAC6fXaAx88F6RdH+Bvva0mk9XU0i2U6IbG2XxJxl5GbhNL4Y9gva33DoCTBTMOt2e9/rtBPjxq+n/+CnKzpVYHEU7S6/s4dJJ+FM12adamA+pNJP3hEL0djI3zYP2YxQGTz1es7y/qIIbAFqCwtu0pC02m+7ZQLDr4hZOl4uZLHRpQkqlLo2Ktt71ddfgvzNLMh0DDKOAnvWplcdvJEjX59utjCyDjheNWKXzJ95AMQ2byxKaVYGtlApQZ5v8QX2l/+nVPpPQ+aWmOW7TDZHBfCjQKcuQTWczEycCT9+Xj6GB83vZYwTpqN5J/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ3jOC3BcruAnx3mzNXR+eXYowISk9eZTffynHomYcw=;
 b=ORW3LkB38ckhdyojzJtKDP1kuyoqsBuk/PrM/CiavzSPqnvPE+C4DLlihgF+szb10mhFBVosSkF0FXWa9+WfdU0WPWh4tdpxuaMUdch9tkbISWhTSxI+AexhwSxTqa0waPkUd40f+hpOX6To+zjCpHxzeKgNNZkTrjMVDCkCkAI=
Received: from CY4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:910:4d::28)
 by MN2PR03MB5200.namprd03.prod.outlook.com (2603:10b6:208:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14; Mon, 12 Aug
 2019 09:00:48 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR03CA0087.outlook.office365.com
 (2603:10b6:910:4d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Mon, 12 Aug 2019 09:00:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Mon, 12 Aug 2019 09:00:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7C90lir008334
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 12 Aug 2019 02:00:47 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Aug 2019 05:00:46 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] staging: iio: adc: ad7192: Remove platform data
Date:   Mon, 12 Aug 2019 12:00:34 +0300
Message-ID: <20190812090034.26769-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(199004)(189003)(47776003)(7636002)(246002)(14444005)(4326008)(478600001)(426003)(336012)(26005)(186003)(486006)(44832011)(126002)(305945005)(2616005)(476003)(1076003)(8676002)(7696005)(51416003)(107886003)(2351001)(50226002)(5660300002)(316002)(16586007)(8936002)(36756003)(86362001)(50466002)(2906002)(6916009)(48376002)(6666004)(356004)(54906003)(70586007)(106002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5200;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 571db007-db00-47b2-27e9-08d71f039114
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR03MB5200;
X-MS-TrafficTypeDiagnostic: MN2PR03MB5200:
X-Microsoft-Antispam-PRVS: <MN2PR03MB52007514D25A6AA4C17EE1D481D30@MN2PR03MB5200.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 012792EC17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JpE0K0s4gg5PDeVW1kcMJdnXG6JumzmJnnJNcExfDG0oOlupexWt6r7/1NXDF/xEFsp6aZVwktlGe0ro0RfA9tl9YJy1EfOixHFCYptXbkOb1bx/2ktKFoEo48qi8ffJztlJUe6bpLAslm5B0Kxobgc78i6HHjDhtoz5YhlW7aIbq11VmgON0NyjIX1GRTTNqSpkpo0jBFpdOCYl+vYrRYSRMqR4DhOZYLSHoJy/AldpvssrO7nz9HxymCtIZXyHIfp2vkrcrYMgHrzdbQ8pWr4ajNbAXKZu46/d3AbknyMREftToMYr+WNK/MFvxH2T2U+M2qcUkNyz2jGFfln7yaC8ls+DL3dMxTokNFpkhhN5jyAdLZbvRW6cLNZgoBC6DViD+3wSY7jTZd7MWw/wXXJON8+8XHuZs2+ibcyoJNs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 09:00:47.4673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571db007-db00-47b2-27e9-08d71f039114
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5200
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch removes the reference voltage entry from the platform_data
structure. This is no longer needed since the reference voltage is obtained
from the device tree. With this we also remove the entire ad7192.h file.

The undefined reference voltage warning is promoted to an error signaling a
problem with the device tree.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 14 ++----------
 drivers/staging/iio/adc/ad7192.h | 37 --------------------------------
 2 files changed, 2 insertions(+), 49 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/ad7192.h

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index df06e0570f9b..81ea2639c67c 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -25,8 +25,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
-#include "ad7192.h"
-
 /* Registers */
 #define AD7192_REG_COMM		0 /* Communications Register (WO, 8-bit) */
 #define AD7192_REG_STAT		0 /* Status Register	     (RO, 8-bit) */
@@ -666,16 +664,10 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 
 static int ad7192_probe(struct spi_device *spi)
 {
-	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ?\n");
 		return -ENODEV;
@@ -713,12 +705,10 @@ static int ad7192_probe(struct spi_device *spi)
 
 	voltage_uv = regulator_get_voltage(st->avdd);
 
-	if (pdata->vref_mv)
-		st->int_vref_mv = pdata->vref_mv;
-	else if (voltage_uv)
+	if (voltage_uv)
 		st->int_vref_mv = voltage_uv / 1000;
 	else
-		dev_warn(&spi->dev, "reference voltage undefined\n");
+		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
 
 	spi_set_drvdata(spi, indio_dev);
 	st->devid = spi_get_device_id(spi)->driver_data;
diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
deleted file mode 100644
index f3669e1df084..000000000000
--- a/drivers/staging/iio/adc/ad7192.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * AD7190 AD7192 AD7195 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-#ifndef IIO_ADC_AD7192_H_
-#define IIO_ADC_AD7192_H_
-
-/*
- * TODO: struct ad7192_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad7192_platform_data - platform/board specific information
- * @vref_mv:		the external reference voltage in millivolt
- * @clock_source_sel:	[0..3]
- *			0 External 4.92 MHz clock connected from MCLK1 to MCLK2
- *			1 External Clock applied to MCLK2
- *			2 Internal 4.92 MHz Clock not available at the MCLK2 pin
- *			3 Internal 4.92 MHz Clock available at the MCLK2 pin
- * @ext_clk_Hz:		the external clock frequency in Hz, if not set
- *			the driver uses the internal clock (16.776 MHz)
- * @refin2_en:		REFIN1/REFIN2 Reference Select (AD7190/2 only)
- * @rej60_en:		50/60Hz notch filter enable
- * @sinc3_en:		SINC3 filter enable (default SINC4)
- * @chop_en:		CHOP mode enable
- * @buf_en:		buffered input mode enable
- * @unipolar_en:	unipolar mode enable
- * @burnout_curr_en:	constant current generators on AIN(+|-) enable
- */
-
-struct ad7192_platform_data {
-	u16		vref_mv;
-};
-
-#endif /* IIO_ADC_AD7192_H_ */
-- 
2.17.1

