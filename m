Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3158ABF04A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfIZKwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:45 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16080 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbfIZKwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:43 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqMeL030420;
        Thu, 26 Sep 2019 06:52:35 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2053.outbound.protection.outlook.com [104.47.49.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7cc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOc5DTXxtUBJLeskdoZmAAtQG2vtqkTWOZ1N3iPFgr1Pb5ySd00o7oa/LAV5fUaYkqaRv8ClGw8c3NiWFUzefI90vZZ7OyL4yUpPb3/mhA8YCRhMmx7vhNHEmTZdsNArSCBCkjGZJSnNmLbPUlYtsveg3ILHefL/CVM0089h0rks1gXyHrPPGNd44kg9uzS1ZWGS2X2Zf/OxampHtLhAiy4dzNp146GjW2YjJtmhTjt467F166nq56jFH1bWOkxRU9SohbI2IOoTTfT023yiaLBYTZqCJ54mUoFdwq63JYuVbWhxob6rNrzIV5I+b6fH6A4HZS8i9ihxhopwQzX2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi4om57DIw0BkZGNRK8c0W8ocv9K0HrzmvBKt34fAOQ=;
 b=CQZWTFK0RQMI7CysHgSH/h5Cx4fT9epwGHnF1GhND3OsIBxu7Z3YBgzfVEWi0vWyZL+hbmEU3uJ8x4Jp4iMwND34OSYcIm2YT71estnjWkk1iRuAd7jJI9cf5B2PXtYqhczQJMoq5Q0CAVBRfvyEadRcM/DHn5MNmgnk2oRCf3TQE63i5CA+9zUIrKA1zzxrcfIEdGJ5LSJ5u7ytfhPdiRYr9j5bJSppXZT/wU6Mf8ULYaJ17Fo61jlGn0rfqdqisNO4FtCH+IRxHqwPxBioJC+2JYQxpk57C33liq0siwkf9I6kShln87ZGxY8Rn9x6vQK1NnKGLixZpPXv9iFQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi4om57DIw0BkZGNRK8c0W8ocv9K0HrzmvBKt34fAOQ=;
 b=c7NhsIgHJimMC95917bN4VMuD2OihPYyHsy11YH7t2y2WNVKDg7mxskQcwFZChnFfcUquP7YEc8d+I26/CPvhM3FazApSyIROnf2k0WdgmjMQq8rR73RrL1hSubXjhfFqbDcrIJTaLnB8Bty4UvYRsTUFXSfGb+freUzfi/vdM0=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by BY5PR03MB5063.namprd03.prod.outlook.com (2603:10b6:a03:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Thu, 26 Sep
 2019 10:52:33 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:33 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:33 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqWOn014797
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:32 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:32 -0400
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
Subject: [PATCH v4 09/19] spi: use new `spi_transfer_delay_exec` helper where straightforward
Date:   Thu, 26 Sep 2019 13:51:37 +0300
Message-ID: <20190926105147.7839-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(8936002)(36756003)(478600001)(316002)(356004)(246002)(70206006)(70586007)(8676002)(110136005)(50226002)(107886003)(14444005)(4326008)(336012)(11346002)(126002)(305945005)(476003)(426003)(2616005)(2870700001)(446003)(486006)(44832011)(7636002)(7416002)(86362001)(47776003)(2201001)(48376002)(50466002)(106002)(1076003)(5660300002)(186003)(7696005)(26005)(51416003)(2906002)(76176011)(54906003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5063;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd76148-8bed-41ab-d5c7-08d7426fa2b9
X-MS-TrafficTypeDiagnostic: BY5PR03MB5063:
X-Microsoft-Antispam-PRVS: <BY5PR03MB50631C9C932C320C45AAF088F9860@BY5PR03MB5063.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWXpvjyW279mmV4e2q+THXrQk9jfMW5a/FRkOpVit7UsSuhdbYvV0Of0md+AivUhJ7Nofj0SKqhZVonyN2/D/YMZ0a/qkzMyB0wFuVyB9/UJyzAqipL9VaJ0khpaOwKXj+oOwsNPqb/S46GzzACG1/txEiKrN85gYfVnMRPR3ELWbFw7J9xCS1jeG9k10FUNFsi7FYgmSeesyiDSuTFbM98SRBORyN8CBYbbwtvtO70jQT/ONrYo81EbC2fRg9+cAb5hN9iEt2pKtv/6lB+v+1AuN5ayfpjPl0VLqf8OvGMPeRdM/lAfspXWfChu8f489hZGHOB5PRkyjjTP+HgLNrGTvMeuNkPLbdR+d7/lXYo+xYgyj3UZrXSNljp7hYf/IOAmYbCfXPd5btP3v8ycGkt4fi85BjJfuFdN1+91gbc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:33.3764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd76148-8bed-41ab-d5c7-08d7426fa2b9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260103
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
 drivers/spi/spi-atmel.c         |  3 +--
 drivers/spi/spi-bcm63xx-hsspi.c |  3 +--
 drivers/spi/spi-cavium.c        |  3 +--
 drivers/spi/spi-fsl-dspi.c      |  3 +--
 drivers/spi/spi-fsl-espi.c      |  3 +--
 drivers/spi/spi-fsl-spi.c       |  3 +--
 drivers/spi/spi-mpc512x-psc.c   |  3 +--
 drivers/spi/spi-mpc52xx-psc.c   |  3 +--
 drivers/spi/spi-omap-100k.c     |  3 +--
 drivers/spi/spi-pl022.c         | 25 +++++++++++--------------
 drivers/spi/spi-sc18is602.c     |  3 +--
 drivers/spi/spi-sh-hspi.c       |  3 +--
 drivers/spi/spi-topcliff-pch.c  |  7 +------
 drivers/spi/spi-txx9.c          |  3 +--
 drivers/spi/spi-xcomm.c         |  3 +--
 15 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f04b92791515..2f7388e53b82 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1389,8 +1389,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay_exec(xfer);
 
 	if (xfer->cs_change) {
 		if (list_is_last(&xfer->transfer_list,
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9a06ffdb73b8..949b59b6449f 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -291,8 +291,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (t->cs_change)
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index 5aaf21582cb5..6854c3ce423b 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -119,8 +119,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 			*rx_buf++ = (u8)v;
 		}
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay_exec(xfer);
 
 	return xfer->len;
 }
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 53335ccc98f6..736071e2b9d8 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -752,8 +752,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			dspi->waitflags = 0;
 		}
 
-		if (transfer->delay_usecs)
-			udelay(transfer->delay_usecs);
+		spi_transfer_delay_exec(transfer);
 	}
 
 out:
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f20326714b9d..732bf3195917 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -427,8 +427,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	ret = fsl_espi_bufs(spi, trans);
 
-	if (trans->delay_usecs)
-		udelay(trans->delay_usecs);
+	spi_transfer_delay_exec(trans);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1d9b33aa1a3b..139ab57aec99 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -417,8 +417,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 		}
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index a337b842ae8c..ea1b07953d38 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -311,8 +311,7 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 			break;
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (cs_change)
 			mpc512x_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index c7e478b9b586..17935e71b02f 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -234,8 +234,7 @@ static void mpc52xx_psc_spi_work(struct work_struct *work)
 				break;
 			m->actual_length += t->len;
 
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+			spi_transfer_delay_exec(t);
 
 			if (cs_change)
 				mpc52xx_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index b955ca8796d2..89608eb55f1f 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -321,8 +321,7 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 			}
 		}
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		/* ignore the "leave it on after last xfer" hint */
 
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 7fedea67159c..3024c30e7f2e 100644
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
+	spi_transfer_delay_exec(last_transfer);
 
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
+		spi_transfer_delay_exec(previous);
 
 		/* Reselect chip select only if cs_change was requested */
 		if (previous->cs_change)
@@ -1520,8 +1518,7 @@ static void do_polling_transfer(struct pl022 *pl022)
 			previous =
 			    list_entry(transfer->transfer_list.prev,
 				       struct spi_transfer, transfer_list);
-			if (previous->delay_usecs)
-				udelay(previous->delay_usecs);
+			spi_transfer_delay_exec(previous);
 			if (previous->cs_change)
 				pl022_cs_control(pl022, SSP_CHIP_SELECT);
 		} else {
diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 11acddc83304..5497eeb3bf3e 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -211,8 +211,7 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 	}
 	m->status = status;
 	spi_finalize_current_message(master);
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 7f73f91d412a..a62034e2a7cb 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -190,8 +190,7 @@ static int hspi_transfer_one_message(struct spi_controller *ctlr,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index f88cbb94ce12..223353fa2d8a 100644
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
+		spi_transfer_delay_exec(data->cur_trans);
 
 		spin_lock(&data->lock);
 
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 51759d3fd45f..83daaa597acc 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -248,8 +248,7 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 			len -= count * wsize;
 		}
 		m->actual_length += t->len;
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (!cs_change)
 			continue;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index a3496c46cc1b..1d9b3f03d986 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -188,8 +188,7 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		is_first = false;
 	}
-- 
2.20.1

