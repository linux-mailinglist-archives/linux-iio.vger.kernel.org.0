Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBFEB1A06
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfIMIrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:47:13 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:8302 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387715AbfIMIqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:46 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8giVD017273;
        Fri, 13 Sep 2019 04:46:39 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h9b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF9QV9QMJ8UfyTzFcn9HlErtTaL3SEKGhqjhHSAiPtOlGQkxwTrBe8uVMcJWj3mDyYyQbej9XH+96P1DDuQ0FMTXnhbpPOihnap5y6VoHXbJpIoygHDIsiv/PsQss8iVHERfsvj5OSS1BLcRQ/k2VGkpHsHhrhhJsHjnnqd5jTp2VN9pdGQndWADDIQay/gfGbJ3wOuMx/md1Cg/bLAn+hycKl1efP5XKRN1XgLOrXMeQsofN1yXGXY4PMEo71XtjimsF83D+x75BIU/Kdb2H+GOA10leiS5gjMUE1KkT2e4u1x63UD+vcrMkD1DPo4xGnGcLn/5uUqcj/bT5ii1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpKiYYuwdSMIyBrVg+DpNvJAloR/Z2RTpZzqG3TLjyo=;
 b=DkLW+G4z25t2UeuTVV5wO8ezs98BvFvaXzC8hTN6XDcidIUCFBERd9TBKVfWjeTVrHKeJSYZwsfZ2ogy4wmw1tgJDx1sR3YvtSJJF13pjBz+O2fS7i5jSsKmR8Klzm/Q2aU4bMl+q2ICu97kZodfkUO/BiqK9kGS+QE4B79iUnKukuu4Z1ycGSPl74f4/TLShNZ6XfFwLUEhB6aJ1na0nqRkN2kJHb8/bxChBWA0rO/V4G4T0O5Sk7kIheGDnZCXG4WJb4hTuD8lISVgksKXJyPzYdABu+iwj8kF6kJ+1H+T/07M6jvzLZ5RGJqTjQyEtCTEt0cB4gCNmb2Du93aNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpKiYYuwdSMIyBrVg+DpNvJAloR/Z2RTpZzqG3TLjyo=;
 b=iJD2IC2RjRJR7ecwWM87FKF36dBNlv3sYPoSkRSk00P9xa4FQBZDyFqhgcD+kxXDIlBNKILtR0HGay4s2horWGELKAmukeNlDq8FNYcQHLKnXfaDWulRtFMjY65jP/5MPOeLEa43Ko8nrGlrubxTIJMc88EOsl6TjAlNZr77K7E=
Received: from CH2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:59::14)
 by BYAPR03MB4869.namprd03.prod.outlook.com (2603:10b6:a03:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Fri, 13 Sep
 2019 08:46:37 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CH2PR03CA0004.outlook.office365.com
 (2603:10b6:610:59::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kVhA030711
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:31 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 10/15] spi: use new `spi_transfer_delay` helper where straightforward
Date:   Fri, 13 Sep 2019 14:45:45 +0300
Message-ID: <20190913114550.956-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(2616005)(305945005)(8676002)(336012)(50226002)(70586007)(186003)(86362001)(107886003)(110136005)(54906003)(446003)(106002)(5660300002)(478600001)(316002)(7636002)(7416002)(246002)(14444005)(6666004)(356004)(44832011)(36756003)(2870700001)(70206006)(2906002)(26005)(2201001)(486006)(48376002)(126002)(476003)(4326008)(50466002)(11346002)(7696005)(76176011)(426003)(8936002)(47776003)(1076003)(51416003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4869;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aa3495a-1bf0-4d6f-4f1d-08d73826e361
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR03MB4869;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4869:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4869479A2D0D5A146E414F32F9B30@BYAPR03MB4869.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2RMcB2cx2er62QduEC8VmS2E1rrrqxwDUPB2H+OLcsgyjeX5zUc6cl0yJa0RHqhEFoxsSv9eSDtbICjvA1ZVMwOrQWdDgyVgXv4yC+c1oi8/WNeF97NzVGxZtcpHXSQv0kcKVJVluR55oe9byl68up0RBrcu5rde9mS1usF/0WJDukaCWQpi/YobWTkoPROJQDE346Rv1Ywl8BY41H/P7NYYLvGHPjb+BnBady2YbLuq2eg0mOu3uwRkij0AMFrOmYRELmAQIL9fh4SMDP86y/G6AMthHaoUukSTZ7/Z50/Kzhzx7QirHNnbSGxwda5Xr6hoGEWIIVkkdeWPrEqyDKGy3G/4fXXpWIlCEFwkQSbLhj93s43nWPRPmXiOM1+jsOUGVAd5pWvOIaJ7pNPIb6hQ4eKrda389cmx1A6Xiek=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:36.9661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa3495a-1bf0-4d6f-4f1d-08d73826e361
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For many places in the spi drivers, using the new `spi_transfer_delay`
helper is straightforward.
It's just replacing:
```
  if (t->delay_usecs)
     udelay(t->delay_usecs);
```
with `spi_transfer_delay(t)` which handles both `delay_usecs` and the new
`delay` field.

This change replaces in all places (in the spi drivers)  where this change
is simple.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-atmel.c          |  3 +--
 drivers/spi/spi-bcm63xx-hsspi.c  |  3 +--
 drivers/spi/spi-cavium.c         |  3 +--
 drivers/spi/spi-fsl-dspi.c       |  3 +--
 drivers/spi/spi-fsl-espi.c       |  3 +--
 drivers/spi/spi-fsl-spi.c        |  3 +--
 drivers/spi/spi-mpc512x-psc.c    |  3 +--
 drivers/spi/spi-mpc52xx-psc.c    |  3 +--
 drivers/spi/spi-omap-100k.c      |  3 +--
 drivers/spi/spi-pl022.c          | 25 +++++++++++--------------
 drivers/spi/spi-sc18is602.c      |  3 +--
 drivers/spi/spi-sh-hspi.c        |  3 +--
 drivers/spi/spi-tegra20-sflash.c |  2 +-
 drivers/spi/spi-topcliff-pch.c   |  7 +------
 drivers/spi/spi-txx9.c           |  3 +--
 drivers/spi/spi-xcomm.c          |  3 +--
 16 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 009bb4fb5e5f..f51af930c7a4 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1389,8 +1389,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay(xfer);
 
 	if (xfer->cs_change) {
 		if (list_is_last(&xfer->transfer_list,
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9a06ffdb73b8..d9f5c241e2aa 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -291,8 +291,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (t->cs_change)
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index 5aaf21582cb5..db7f5f94c525 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -119,8 +119,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 			*rx_buf++ = (u8)v;
 		}
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay(xfer);
 
 	return xfer->len;
 }
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 53335ccc98f6..0b761352c16a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -752,8 +752,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			dspi->waitflags = 0;
 		}
 
-		if (transfer->delay_usecs)
-			udelay(transfer->delay_usecs);
+		spi_transfer_delay(transfer);
 	}
 
 out:
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f20326714b9d..a3af12127c40 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -427,8 +427,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	ret = fsl_espi_bufs(spi, trans);
 
-	if (trans->delay_usecs)
-		udelay(trans->delay_usecs);
+	spi_transfer_delay(trans);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1d9b33aa1a3b..9352b127d5b8 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -417,8 +417,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 		}
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index a337b842ae8c..329bbdd1f15f 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -311,8 +311,7 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 			break;
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (cs_change)
 			mpc512x_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index c7e478b9b586..dd79d7fd3687 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -234,8 +234,7 @@ static void mpc52xx_psc_spi_work(struct work_struct *work)
 				break;
 			m->actual_length += t->len;
 
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+			spi_transfer_delay(t);
 
 			if (cs_change)
 				mpc52xx_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index b955ca8796d2..eb5b51bd5126 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -321,8 +321,7 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 			}
 		}
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		/* ignore the "leave it on after last xfer" hint */
 
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 7fedea67159c..42cf800073e4 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -485,12 +485,11 @@ static void giveback(struct pl022 *pl022)
 					struct spi_transfer, transfer_list);
 
 	/* Delay if requested before any change in chip select */
-	if (last_transfer->delay_usecs)
-		/*
-		 * FIXME: This runs in interrupt context.
-		 * Is this really smart?
-		 */
-		udelay(last_transfer->delay_usecs);
+	/*
+	 * FIXME: This runs in interrupt context.
+	 * Is this really smart?
+	 */
+	spi_transfer_delay(last_transfer);
 
 	if (!last_transfer->cs_change) {
 		struct spi_message *next_msg;
@@ -1401,12 +1400,11 @@ static void pump_transfers(unsigned long data)
 		previous = list_entry(transfer->transfer_list.prev,
 					struct spi_transfer,
 					transfer_list);
-		if (previous->delay_usecs)
-			/*
-			 * FIXME: This runs in interrupt context.
-			 * Is this really smart?
-			 */
-			udelay(previous->delay_usecs);
+		/*
+		 * FIXME: This runs in interrupt context.
+		 * Is this really smart?
+		 */
+		spi_transfer_delay(previous);
 
 		/* Reselect chip select only if cs_change was requested */
 		if (previous->cs_change)
@@ -1520,8 +1518,7 @@ static void do_polling_transfer(struct pl022 *pl022)
 			previous =
 			    list_entry(transfer->transfer_list.prev,
 				       struct spi_transfer, transfer_list);
-			if (previous->delay_usecs)
-				udelay(previous->delay_usecs);
+			spi_transfer_delay(previous);
 			if (previous->cs_change)
 				pl022_cs_control(pl022, SSP_CHIP_SELECT);
 		} else {
diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 11acddc83304..13cb992df712 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -211,8 +211,7 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 	}
 	m->status = status;
 	spi_finalize_current_message(master);
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 7f73f91d412a..4edad22c222e 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -190,8 +190,7 @@ static int hspi_transfer_one_message(struct spi_controller *ctlr,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index cd714a4f52c6..00593096cfed 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -344,7 +344,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 		if (xfer->cs_change && xfer->delay_usecs) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
-			udelay(xfer->delay_usecs);
+			spi_transfer_delay(xfer);
 		}
 	}
 	ret = 0;
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index f88cbb94ce12..645b086eece8 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1229,12 +1229,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 			"%s:data->current_msg->actual_length=%d\n",
 			__func__, data->current_msg->actual_length);
 
-		/* check for delay */
-		if (data->cur_trans->delay_usecs) {
-			dev_dbg(&data->master->dev, "%s:delay in usec=%d\n",
-				__func__, data->cur_trans->delay_usecs);
-			udelay(data->cur_trans->delay_usecs);
-		}
+		spi_transfer_delay(data->cur_trans);
 
 		spin_lock(&data->lock);
 
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 51759d3fd45f..65aa736783ae 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -248,8 +248,7 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 			len -= count * wsize;
 		}
 		m->actual_length += t->len;
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (!cs_change)
 			continue;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index a3496c46cc1b..3aaae32b0384 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -188,8 +188,7 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		is_first = false;
 	}
-- 
2.20.1

