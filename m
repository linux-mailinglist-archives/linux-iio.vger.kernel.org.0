Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2516B19EC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbfIMIqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30204 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387649AbfIMIqn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:43 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gstb001935;
        Fri, 13 Sep 2019 04:46:37 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsa86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POfPkCTzfnBqkTgIS+LIJzC0/5jAJH3lnhFtSgpJaZ0p8UbYD0u9t5cWcEQ6zR9CpCQnmhDgTqTRbRFOXLKrBJZj2uvJtDZXXeIydiRMPrI/hDndJD32Ia4sN7xuPRdnG5Vq3/uuVL8E0JxchyZ0slj9BmFWoy6o3EbiCULJi11cx4QPmhoMr3VmaQOa8wBYdBUNCsfbyi+9DQKs9Yu6lhmjHJevkAnLzoL0ZSoxqflakP0ZyaS/wHKFcF121XNx6dKkju2YFqXdC/DlLRdKjqCdzIMsLH2TdlS80t38zVlA8MT7uhZY5AOEZ/Keg1DGI53Z/hu5HX3nUn3IRKSUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y3GGrVxMcz7PgGfQOjRf7e5LOWNqoiJ34Iy5XvCBqM=;
 b=kJJUX4gVQKnI1CxeAtxYE7JAkGsE/FUeuy67j3pdqtY5YPbayF+XcYnhKUVnmwAqYZp0KrJYzJwEY/zbA23ZnJqX+SuMKBoHKkzZe13grludony72xGJuLCQK59i/GuUjuTt9UxAFpr0kiAnn+PdqbnEsXLLmyTa3ZArHvf6uoMkAYg58joDDOVFGExIn7GT/C5l7nwMhYzs9rFX4LduA86lYEow1iPpTHK+6unF5t/d1X9j4/NuYdenBgVFGDGUYs4g/6GQ4No8eFsPM6C4HVzGgoSfUK89692a1ETlkhH6PP5F2W99lXEOjJCjFRQ8LBnhzo+YAQzpzlUvdrL0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y3GGrVxMcz7PgGfQOjRf7e5LOWNqoiJ34Iy5XvCBqM=;
 b=7i2mRiJqkAEMHbnOGwKQQYIvR0RVuGd3lz32BzlFaLfVLMBWYZNyO4J3jx2n95pW4aUyCbiePKtYHBmlKyEwbikJMtPq/5hHFlV1KnpTFo/ESqiFj0j+ZlswxL0/H5wiblo6Ixw22YcvV6ZQPEpG/SUDc+TO1s7BX+1lM/eU4Wo=
Received: from BN6PR03CA0104.namprd03.prod.outlook.com (2603:10b6:404:10::18)
 by BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Fri, 13 Sep
 2019 08:46:34 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR03CA0104.outlook.office365.com
 (2603:10b6:404:10::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kSYS030701
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:28 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 09/15] spi: introduce `delay` field for `spi_transfer` + spi_transfer_exec()
Date:   Fri, 13 Sep 2019 14:45:44 +0300
Message-ID: <20190913114550.956-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(2616005)(8936002)(2870700001)(7636002)(110136005)(1076003)(50226002)(54906003)(106002)(7416002)(356004)(305945005)(478600001)(8676002)(2906002)(7696005)(86362001)(6666004)(2201001)(476003)(126002)(44832011)(36756003)(26005)(446003)(4326008)(47776003)(246002)(70206006)(76176011)(70586007)(316002)(48376002)(5660300002)(107886003)(486006)(426003)(336012)(50466002)(51416003)(186003)(11346002)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0529882-af6e-498b-1bc3-08d73826e1b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN6PR03MB2625;
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2625849739EEE7E7845D6040F9B30@BN6PR03MB2625.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Byzk5bfCKwdXmhFwyaU7nM59K3yxS4+f9qdL8jCOsUR++UKAd7VwI7XJiJknW4LwVAeUeHAdA3TMvaVOpjL8gEIPolnIxJFYBEAlOe3hrC/wkuXbYtLb4FJCMBsfKcKoNM4p+POj28jIgxPZsI4X0RbKYkNh436OX0BiBabl3oZ97SBQ1yALyyil6CoYJFUPzEpMjgBufoTm7q2qOWQM18YShShqQGqMBiuRsocIhsu1n89hC/MP5svMpimYgTvYOXhzM1z9AhOQTb+wKuDzRjMuxDp47y1RxZ/BvGx1uGWNZRoJlqmPOaCyCnDhe9p2/uN/+QY63BsgrzoSFos/kUNanw7RTRLcN1t8JBG/W8qWxIt5V0R0bptl8ShNBivJTMSDZ6PzmX0w7Kr2Ds3vT1Ly2jPRbXxHRxWN0S63+1A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:34.1815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0529882-af6e-498b-1bc3-08d73826e1b9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
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

The change introduces the `delay` field to the `spi_transfer` struct as an
`struct spi_delay` type.
This intends to eventually replace `delay_usecs`.

But, since there are many users of `delay_usecs`, this needs some
intermediate work.
A helper called `spi_transfer_delay()` is also added, which maintains
backwards compatibility with `delay_usecs`, by assigning the value to
`delay` if non-zero.
This should maintain backwards compatibility with current users of
`udelay_usecs`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       |  6 +++---
 include/linux/spi/spi.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ba8731b77753..c55d55acbbb0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1238,8 +1238,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (msg->status != -EINPROGRESS)
 			goto out;
 
-		if (xfer->delay_usecs)
-			_spi_transfer_delay_ns(xfer->delay_usecs * 1000);
+		spi_transfer_delay(xfer);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
@@ -2904,10 +2903,11 @@ struct spi_replaced_transfers *spi_replace_transfers(
 		/* add to list */
 		list_add(&xfer->transfer_list, rxfer->replaced_after);
 
-		/* clear cs_change and delay_usecs for all but the last */
+		/* clear cs_change and delay for all but the last */
 		if (i) {
 			xfer->cs_change = false;
 			xfer->delay_usecs = 0;
+			xfer->delay.value = 0;
 		}
 	}
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e7ec0be16a82..c7f90a0129be 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -754,6 +754,9 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
+ * @delay: delay to be introduced after this transfer before
+ *	(optionally) changing the chipselect status, then starting
+ *	the next transfer or completing this @spi_message.
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -843,6 +846,7 @@ struct spi_transfer {
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
 	u16		delay_usecs;
+	struct spi_delay	delay;
 	struct spi_delay	cs_change_delay;
 	struct spi_delay	word_delay;
 	u32		speed_hz;
@@ -942,6 +946,20 @@ spi_transfer_del(struct spi_transfer *t)
 	list_del(&t->transfer_list);
 }
 
+static inline int
+spi_transfer_delay(struct spi_transfer *t)
+{
+	struct spi_delay d;
+
+	if (t->delay_usecs) {
+		d.value = t->delay_usecs;
+		d.unit = SPI_DELAY_UNIT_USECS;
+		return spi_delay_exec(&d, NULL);
+	}
+
+	return spi_delay_exec(&t->delay, t);
+}
+
 /**
  * spi_message_init_with_transfers - Initialize spi_message and append transfers
  * @m: spi_message to be initialized
-- 
2.20.1

