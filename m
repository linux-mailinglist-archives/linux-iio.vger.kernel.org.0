Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305A4B1A00
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfIMIrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:47:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39290 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387581AbfIMIq6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:58 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gds8001890;
        Fri, 13 Sep 2019 04:46:53 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsa8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcwrP4QnIjetMkoH5NLf0ibgB9XU8/pdiylNwS3t6rOtwBkduCCGpuk8Is56K34nb1SPkn6hIr62CBxeabWWWoGVvdRzxMbl1wb3C7tZuslc6373drm33AhmhZhm1zxKX3+Bn1sYH1SfxwgQdL6dim+cb6x2pP/KWXn0qq3FhgOKFKyGi70igoDXwMCEGI8uN/idIXAeIBq6jlFlLAy0o1Xy1hAndD0hM4P79+CqH3eX7556mNJ+cJR3UZlayCx4yO+LDRJ3u2zwFX5z9W6TQ6TXGLS4CpLqq/jZjcOKmN0MJWImEgFhHCNEiOk4uIt4iAy6ssjDSS1BXUY/faWnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SJm80TJlRotqx116nuGen8V9eGqdAKty0mbD7a8DOQ=;
 b=XNga6HYc2Kcgx5P195thaxhG2CSVGlOnmHVy4vYEZETvUGQbLxbtRVzIRuZB0mcz/LlkVb220hmQ45kQ2wwvcDrJK1ioVIpN8bstPT95hmI7nXBVNutKrPnw899YH+IrwSXLWJ1x1oJgjFGkHhcFadGnw/rZS9eEpE0sbTTop04o+nfYLlEKHcPYe6d2jIdaphDz+zFnM3X9ky/84TPRvrs8i0xtnHfXjrbJ8X+DOvGHoLOM4FqDuiEjV0rBoahBWC3b98hkv5gOgCaacelQ6aB9ZMtZXbEbk2R72bdmmKztnVhpZzeoe14AQSr0TKrRsJgB87Rii0c582j82kGHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SJm80TJlRotqx116nuGen8V9eGqdAKty0mbD7a8DOQ=;
 b=YMfbWMvCIS24KwC8FESpwzHFLIw802RdIEKduP+Iq7T/elCOnj0tBGgkvSahy5x6SCV9RHaI6M/vOh8g0hrLpa5rRYVBDOJZq9kEe2jlFrl4s3XPtUTRXlKOZKGnKhbfYh+z0SsC3ueGfOLJMWCs/dDw7yOZJUZkMBJ9wuHmiL4=
Received: from BN6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:404:4c::34)
 by MN2PR03MB4669.namprd03.prod.outlook.com (2603:10b6:208:ab::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Fri, 13 Sep
 2019 08:46:51 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR03CA0072.outlook.office365.com
 (2603:10b6:404:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kjL3030753
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:45 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:49 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 15/15] spi: implement SW control for CS times
Date:   Fri, 13 Sep 2019 14:45:50 +0300
Message-ID: <20190913114550.956-16-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(476003)(2870700001)(70206006)(44832011)(6666004)(50226002)(356004)(336012)(316002)(47776003)(76176011)(7416002)(70586007)(8936002)(305945005)(478600001)(51416003)(186003)(48376002)(5660300002)(50466002)(1076003)(26005)(14444005)(2201001)(86362001)(7696005)(54906003)(36756003)(107886003)(126002)(486006)(4326008)(2616005)(2906002)(11346002)(446003)(110136005)(7636002)(246002)(106002)(426003)(8676002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4669;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1bd2e00-ffbe-4a16-3d62-08d73826eb84
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MN2PR03MB4669;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4669:
X-Microsoft-Antispam-PRVS: <MN2PR03MB4669DA5A59EFFA12608DBBFBF9B30@MN2PR03MB4669.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MtOCtlAqxM26bNa3hsjw+2gnJn3dlX2tC865y3toh/UR92xJvEcH4zTQ3qBcIvlw51PFY6rbQmo3et2T7zrak2eQP2GTXm6MKiXnJQn4tlpXXCz1BQQajZfAj/O2Gv5phiZujog/UPXp8UYrupPM8E1UEIcHsr/RpxnwQ7PO7Tq4omIKmf9GsH/3N3Ivpz4LhkB/+o6UDTqgxPUaQCpIoSlEhlFURksYMMdL7LFZtVFx8AN+kg60kHgON2/RZNrffzjZYDOustViWlCUWcXWopu90ZIZAW/bDdQbvJOOIoQQjnrR4PyZLkNy/EpFRPXwistSZaFdrW76bkVKWGqhUziPjdKx60sFL2OFyW1FWrEUyhR+c1Ep1T+BFpYRT8c2Mb2/PdJFw3zdR6rXAPBjjY5nTQKiUIofQVGWXf3vjto=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:50.6098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bd2e00-ffbe-4a16-3d62-08d73826eb84
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4669
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change implements CS control for setup, hold & inactive delays.

The `cs_setup` delay is completely new, and can help with cases where
asserting the CS, also brings the device out of power-sleep, where there
needs to be a longer (than usual), before transferring data.

The `cs_hold` time can overlap with the `delay` (or `delay_usecs`) from an
SPI transfer. The main difference is that `cs_hold` implies that CS will be
de-asserted.

The `cs_inactive` delay does not have a clear use-case yet. It has been
implemented mostly because the `spi_set_cs_timing()` function implements
it. To some degree, this could overlap or replace `cs_change_delay`, but
this will require more consideration/investigation in the future.

All these delays have been added to the `spi_controller` struct, as they
would typically be configured by calling `spi_set_cs_timing()` after an
`spi_setup()` call.

Software-mode for CS control, implies that the `set_cs_timing()` hook has
not been provided for the `spi_controller` object.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 50 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  5 +++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 54d00c0a26d2..acbbfee837ed 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -775,6 +775,15 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
+	bool enable1 = enable;
+
+	if (!spi->controller->set_cs_timing) {
+		if (enable1)
+			spi_delay_exec(&spi->controller->cs_setup, NULL);
+		else
+			spi_delay_exec(&spi->controller->cs_hold, NULL);
+	}
+
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
@@ -800,6 +809,11 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	} else if (spi->controller->set_cs) {
 		spi->controller->set_cs(spi, !enable);
 	}
+
+	if (!spi->controller->set_cs_timing) {
+		if (!enable1)
+			spi_delay_exec(&spi->controller->cs_inactive, NULL);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
@@ -3144,6 +3158,11 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
+static inline bool _spi_delay_clock_cycles(struct spi_delay *d)
+{
+	return d && d->unit == SPI_DELAY_UNIT_SCK;
+}
+
 /**
  * spi_set_cs_timing - configure CS setup, hold, and inactive delays
  * @spi: the device that requires specific CS timing configuration
@@ -3156,10 +3175,39 @@ EXPORT_SYMBOL_GPL(spi_setup);
 int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
 		      struct spi_delay *hold, struct spi_delay *inactive)
 {
+	size_t len;
+
 	if (spi->controller->set_cs_timing)
 		return spi->controller->set_cs_timing(spi, setup, hold,
 						      inactive);
-	return -ENOTSUPP;
+
+	if (_spi_delay_clock_cycles(setup) ||
+	    _spi_delay_clock_cycles(hold) ||
+	    _spi_delay_clock_cycles(inactive)) {
+		dev_err(&spi->dev,
+			"Clock-cycle delays for CS not supported in SW mode\n");
+		return -ENOTSUPP;
+	}
+
+	len = sizeof(struct spi_delay);
+
+	/* copy delays to controller */
+	if (setup)
+		memcpy(&spi->controller->cs_setup, setup, len);
+	else
+		memset(&spi->controller->cs_setup, 0, len);
+
+	if (hold)
+		memcpy(&spi->controller->cs_hold, hold, len);
+	else
+		memset(&spi->controller->cs_hold, 0, len);
+
+	if (inactive)
+		memcpy(&spi->controller->cs_inactive, inactive, len);
+	else
+		memset(&spi->controller->cs_inactive, 0, len);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 292e752ce34a..def49a76299f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -602,6 +602,11 @@ struct spi_controller {
 	/* Optimized handlers for SPI memory-like operations. */
 	const struct spi_controller_mem_ops *mem_ops;
 
+	/* CS delays */
+	struct spi_delay	cs_setup;
+	struct spi_delay	cs_hold;
+	struct spi_delay	cs_inactive;
+
 	/* gpio chip select */
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
-- 
2.20.1

