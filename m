Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9902AB1A46
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfIMI4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:56:08 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13206 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387751AbfIMI4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:56:08 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8rTTV004334;
        Fri, 13 Sep 2019 04:56:05 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2056.outbound.protection.outlook.com [104.47.42.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h9q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:56:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgtLSUsYMFTCxC5emv74DNFCMLaewZQT6TojjbMEjpZDFeVdq5tEGmnrrC214NRb/xF12MZZpFqI5IDxyIr+6QJbOCxALXcZp43eaXRg09K6D7tM73VT3gNmP5A96z/Jll5tBHBGOgjAbr/EBaqkR9yqR2uXO2kGAO95VGrLLnoIW1h3NIjr8HSWR+BMYK56RbJO/rg2QCGIGWa2bzxfTe++IklmN94HfZZBdHWMhEIqWxpVzpqPe3YM/UcegdpaXKdAXKX/YHZ6JstGdwAR0Y/W1tSGicJlIZDN+6SzKuEFoN3g6TxPc/yncGxf3TjnTmDi3KjjT+zMKqqMUHELlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DSsgUaiyPcfIXlk2vetnOMbPD9B8m8+una/987DFjo=;
 b=KbsSVUgvWbCVFy0H1BITVbXbvF8uX/c+bbxF55CwEhj8qoviivk8Ma6CCB/P2q27xqw71Dk5qKHLzH2QgPu/9024AdLryCC6VfuVi/YF8SGme8WUfkN3bHvPAXJoksjNil0shdSHuSU8wSJtvlGM5xSwi+2no5QyymjEyBapzFzc0EGwC/nNq5MRHnX/0+KRLqOwHFaMc31oCoy3E96WnIImtAi7KvXzYJ8a32Q6t+UGAEshIT97TcJyZc4bA1ipsD/iUUejEEQZ1Mo23Z/jXH9vqLhaaQbFepHpPwRCkaFQZPX2TY47FNsH1znoqSx6N0fSlWnXX/jQWsf6bzZk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DSsgUaiyPcfIXlk2vetnOMbPD9B8m8+una/987DFjo=;
 b=Nj85MhK5JEZ+RTRS5dDPQekEeAADWZGXeee+aLkvSbE7HJLa2UBTtuKhUF8detmjQKlu2cWYTwn2n4KB24itdtbKLAAwn8DDTQxmzKtwz2AaeT/3kioinXM8VdNBmwS+t6r4i/Xym3h676Pw9Dko9C9DSe7Zdn5k+8rS0i0akyM=
Received: from DM3PR03CA0018.namprd03.prod.outlook.com (2603:10b6:0:50::28) by
 BL0PR03MB4033.namprd03.prod.outlook.com (2603:10b6:208:61::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 08:56:03 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM3PR03CA0018.outlook.office365.com
 (2603:10b6:0:50::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17 via Frontend
 Transport; Fri, 13 Sep 2019 08:56:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:56:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8tvnU000413
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:55:57 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:56:01 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/4] spi: make `cs_change_delay` the first user of the `spi_delay` logic
Date:   Fri, 13 Sep 2019 14:55:48 +0300
Message-ID: <20190913115549.3823-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913115549.3823-1-alexandru.ardelean@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(50226002)(6666004)(356004)(2906002)(478600001)(7636002)(70206006)(426003)(5660300002)(2201001)(1076003)(446003)(48376002)(2616005)(126002)(50466002)(476003)(70586007)(44832011)(11346002)(86362001)(47776003)(2870700001)(51416003)(7696005)(110136005)(26005)(54906003)(76176011)(336012)(36756003)(486006)(107886003)(106002)(316002)(4326008)(8676002)(8936002)(305945005)(186003)(246002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4033;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f37ace9e-843f-4660-d276-08d7382834d1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL0PR03MB4033;
X-MS-TrafficTypeDiagnostic: BL0PR03MB4033:
X-Microsoft-Antispam-PRVS: <BL0PR03MB403312A1747ED7966935ADBCF9B30@BL0PR03MB4033.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: W9xLfVXyZRRfb87bz4azRK122lhnLjgjB0oMO1E6bITrtGvrxUU/V5pab9nswXadt1e4gFdTZTpc29pxEOkpFK9OqDV6zfL8TPsWQ7R2mMwTXX5YVaqCTyalnYRFpqNjpv0EhTEM3o6PdHe2k8kZgcaGqp/nN3YUYDq3/fHONe0F9wTIjNGYdscAoK02AhkGnVZ3B3GshJ9UdMFN5VqBrjceq1BG8pZdy6E4u8fgloemWm3tGNUEJ7mFBztpmdu9UABcz+FP/geJnDlPQOlPp+PHxZbRqZGTtILGI5d4QNftvhPMRAxHSJMmMpQwOr+BxwMas3rSFzq1bOU9NdxOe40Hrp7tftcOiBG7wXLjFV24ku3nE6S2tavK7If0tIgFr1zRnBKiz37m89EnE6juUI/OT4EltrU6oVfPghJWnck=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:56:03.0986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37ace9e-843f-4660-d276-08d7382834d1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130085
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

