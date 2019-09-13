Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B26B19D8
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfIMIqa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18892 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387594AbfIMIqZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:25 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gaUA015969;
        Fri, 13 Sep 2019 04:46:20 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdksa67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh/R5u66BOW4fOT4zHO2FmbX9DZOdZP6ITD0O1i2rE+fdXVKJK+V5SwPl+BUvtEpmC5DdemMT2XRPYoAzk+h45bY2qgScgKxRzzeBrQVpqwNmLBK3A7Q+wt8w0HRHew6VW7h4IxHCnQTUKnhw+BL9sw6ot3KI8MR+FLu+oJg8zHGeq5kcSY+mqPXz3xeuXyK91V6hve/1UOkr+eG97Z/D0L5HJKvdRRMseoOJMjAJf15iMt3Q2JaFvzS4XedO8jvhdUhgAbwIC6K2/joXiqB+Fn63qQg4i61CgGvyKtFNJFyNg5Em8TZMchg+Itx3Mqt2X5sZHdT2nN4q/pgZanFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DSsgUaiyPcfIXlk2vetnOMbPD9B8m8+una/987DFjo=;
 b=OcaoCo4RPgYCP0sn2BDBMFBC1+SjsSYz5u6Bje3PRviFrNuJNl+LjDuy003jEeIk3WzwlElfVfjswkGZYip7bbW5Ez7SacmQuR4VAR+MiMDnjbKovBwEfq79XuJAWROc17WKys5RG6IqAjGGTWE5B8m7TJgHwM1chjt17Av1Oi992Dbqv7tN2WLKDmJ2VZzttRwUqLVZohEU4yzjyYJd/Go2EE173XUmby+h4p4KKxYe+SNOB/HVlZSXaaH4aj219snSjjesc2P8NF28VzRBmocvQQKBXLNduDSVBqf7w8MN8NgeRQOMObmFnigcT23kh6p1SgR9BQaYoBWxAeCsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DSsgUaiyPcfIXlk2vetnOMbPD9B8m8+una/987DFjo=;
 b=3KuqL4b3L3isNwlAC8nXgAma5s4Z3sUoHP09rMB6GpVZAm63RLHKqkvsSeZsKRh6Pj2xvIYryi3lxKWeTDoUOcTkwGZJowJ5JPrOGvRfXscFM9zs+NgveVOH2Gil6FjMc+GyBYy7gpmjATRN2c6A0BOiEVk/oLjkvs1y6BGfLEw=
Received: from CY1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:600::15) by
 SN6SPR01MB0060.namprd03.prod.outlook.com (2603:10b6:805:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.14; Fri, 13 Sep
 2019 08:46:18 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY1PR03CA0005.outlook.office365.com
 (2603:10b6:600::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.14 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:18 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Fri, 13 Sep 2019 08:46:17 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kCeq030628
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:12 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:17 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of the `spi_delay` logic
Date:   Fri, 13 Sep 2019 14:45:38 +0300
Message-ID: <20190913114550.956-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(70206006)(70586007)(54906003)(316002)(110136005)(336012)(2616005)(486006)(476003)(126002)(356004)(6666004)(106002)(7416002)(2906002)(26005)(186003)(2870700001)(5660300002)(48376002)(50226002)(426003)(44832011)(11346002)(446003)(7636002)(51416003)(8936002)(4326008)(50466002)(76176011)(2201001)(7696005)(8676002)(86362001)(36756003)(107886003)(305945005)(478600001)(246002)(1076003)(47776003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6SPR01MB0060;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11085ce2-6d45-40c4-7d8f-08d73826d805
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN6SPR01MB0060;
X-MS-TrafficTypeDiagnostic: SN6SPR01MB0060:
X-Microsoft-Antispam-PRVS: <SN6SPR01MB0060646728E67E614BBCA615F9B30@SN6SPR01MB0060.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: j2m2rWa7j8CxH4VtpCixydB4gjddpAPlkd41KEc70a3ZoXEMweSSMPkm03yj4X1v1lQwSJu1O9iGCxKPSUHDSDmaLN5v8plfyK7iip4oFIICAMSwFTy9b4rzTmAnduG1rOjMgjqm39hZXVgLjdk4wVBGY05LSx+zsoJZu+ZovdtbjvpSHXj7O59ewszgGobq6wNhGO8HXeZju9x7wmRR4/aTMLyUXNNEovV3wjW4uw25UgPXqU6BdrNZ7Q5+0VP171wJXW7grq9xq1tAvB76tvyHr/wU2vRHP4RYudP3kNPyx5C5iTt53KhLgQFbS6SWuMfyAmk0NIq7aW1SZdXRncc9HEqK5HIMt10PK/hRCYppX+eOLEQU4QhBYyK9C/U0GWvpTkBTGRBjvisw2OAmMS7tZKJEobaHhCftXfdRhNE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:17.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11085ce2-6d45-40c4-7d8f-08d73826d805
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6SPR01MB0060
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the logic for `spi_delay` struct + `spi_delay_exec()` has been copied
from the `cs_change_delay` logic, it's natural to make this delay, the
first user.

The `cs_change_delay` logic requires that the default remain 10 uS, in case
it is unspecified/unconfigured. So, there is some special handling needed
to do that.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 28 +++++++---------------------
 include/linux/spi/spi.h |  4 +---
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1883de8ffa82..d0bf0ffca042 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1160,9 +1160,9 @@ EXPORT_SYMBOL_GPL(spi_delay_exec);
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
-	u32 delay = xfer->cs_change_delay;
-	u32 unit = xfer->cs_change_delay_unit;
-	u32 hz;
+	u32 delay = xfer->cs_change_delay.value;
+	u32 unit = xfer->cs_change_delay.unit;
+	int ret;
 
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay) {
@@ -1171,27 +1171,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		return;
 	}
 
-	switch (unit) {
-	case SPI_DELAY_UNIT_USECS:
-		delay *= 1000;
-		break;
-	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
-		break;
-	case SPI_DELAY_UNIT_SCK:
-		/* if there is no effective speed know, then approximate
-		 * by underestimating with half the requested hz
-		 */
-		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
-		delay *= DIV_ROUND_UP(1000000000, hz);
-		break;
-	default:
+	ret = spi_delay_exec(&xfer->cs_change_delay, xfer);
+	if (ret) {
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
-			     xfer->cs_change_delay_unit);
-		delay = 10000;
+			     unit);
+		_spi_transfer_delay_ns(10000);
 	}
-	/* now sleep for the requested amount of time */
-	_spi_transfer_delay_ns(delay);
 }
 
 /*
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c18cfa7cda35..9ded3f44d58e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -754,7 +754,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
- * @cs_change_delay_unit: unit of cs_change_delay
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -847,8 +846,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u8		word_delay_usecs;
 	u16		delay_usecs;
-	u16		cs_change_delay;
-	u8		cs_change_delay_unit;
+	struct spi_delay	cs_change_delay;
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

