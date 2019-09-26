Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A05BF029
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfIZKw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:26 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3596 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfIZKwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:25 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqKSO030417;
        Thu, 26 Sep 2019 06:52:20 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7cbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VivbJmud6ByJYrDBdzWcC+RpIVURhbJeNQcgbGstohXF2t9luMDHYQJAE9rKqi+edbOhv0JjwADBknRSdR3NBlSKSPT+8phFJbA1u95j689HgnRlA8/zx7L2R8XHUFXY7K97B0F66LhGuzpj2rqsGspBDoXQY4ET63M5vQggmbaUsVfM15ZwDIAlNlRhun3VG0sv5YHMfe0/tItpNOSiF75QdPDc0QfAo2fvLPhcLGL2a9VigdhBkht+ATwGaU5uXicTT3zy5iGsDRO9fDcbtTu48W4jsk/v3LBzCeHOXRd/X+q7km9gL9qFqJSF1d0NtOONj6oC8fLo5REupirLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaM1SxqT2GWMH5PNNJdquphJwaB2Lq4IgSpM3l/5FJI=;
 b=YDmEQEffZaPcuBTpOZ9RwDjNSXtmrm+Ybo9E1knbWtdXsZdChiZjvzCyhkB3TtDomhImWyG05L6+4XAEyY5lvk4pxJsqUzlpQYnqTvf4URfD1rkZiElVhOMhY6bULfrcMi8neQ3OaAVagv9JVoT3J3wJTArjClA0AKb5r7JLRZu9NTYlKw7twz1x/eyNUau9GLmIgwzqgeaJpR7A/W+Q67PKZdbM3l6HvhNURg49IFJ4oaBe8MAyVYrbh9tmSB1NZh/6uHbHLK0Dvd18GgsS7QvYh56Yo+eHrbRED7naPwEP7Ec8O0bLbNTMzhaJhAza5ja4j/W9aZWz6BUpP91wNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaM1SxqT2GWMH5PNNJdquphJwaB2Lq4IgSpM3l/5FJI=;
 b=3/l/VCH+BCngiD77hSFqSVpj4jdDFTcqvWu3pavKiwmio4deOFUNawIEM2ZmbH72a5rHC/K++uXBZwHGE/wI0DYVRSkrQByZLpQ6hs660+UH+Kxb8HPhwo9e818mb9WAo8eJygmEOZSpCeWUJTpRQxSUAVPClbJye632MQQ9ITA=
Received: from BYAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:a02:a8::28)
 by BN6PR03MB2737.namprd03.prod.outlook.com (2603:10b6:404:5c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 10:52:17 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BYAPR03CA0015.outlook.office365.com
 (2603:10b6:a02:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqGeE014768
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:16 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:16 -0400
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
Subject: [PATCH v4 03/19] spi: make `cs_change_delay` the first user of the `spi_delay` logic
Date:   Thu, 26 Sep 2019 13:51:31 +0300
Message-ID: <20190926105147.7839-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(486006)(2616005)(126002)(476003)(44832011)(106002)(356004)(6666004)(51416003)(426003)(2201001)(47776003)(5660300002)(316002)(48376002)(446003)(86362001)(11346002)(50226002)(14444005)(1076003)(7696005)(4326008)(107886003)(336012)(186003)(246002)(76176011)(110136005)(50466002)(478600001)(26005)(54906003)(8676002)(7416002)(8936002)(70586007)(7636002)(36756003)(2906002)(70206006)(305945005)(2870700001)(81973001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2737;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e7f4c9c-8ec1-49e6-be27-08d7426f98cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN6PR03MB2737;
X-MS-TrafficTypeDiagnostic: BN6PR03MB2737:
X-Microsoft-Antispam-PRVS: <BN6PR03MB27379217F183707392352F0BF9860@BN6PR03MB2737.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: h5VDl3iQaXPEaXDE/NSUW4iDltv336fvMRQJRkcBZFn9Il1sFWm1rxvF/+F2Qh6T39fs2IWi0F3v21EJAjJeBLF/33esh84BNlhDlPVfGO09Crcg/zaoyCTMrhbNL/sbB9DnItNH4kNsrAzLLNzjSdfN0xmkHiavIHgzIYvAGvImzBDh2MagAAsIAaKxS7ekRcuv/yefflWj9SL9WcxJyjtEEStyZ/pJEXAsQwMKWb0UP9ROjWm4KQH7FFTfvFfNyExSO5iyC24+UjTQ4OuiHRyfm4eFZZrP266gRNGTmNMOHclOIHDTE6LQLl4Od8/IZO3iE7RLPqdThzZ7FslPQVWQa2pVmu/0c/sAPtEO70AV09DswN03AMRNSsa5iTwkcqV1yjZYMX0YLJ+Hz12MWXrH2mCfWarxVe7F9KRlvn4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:16.7936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7f4c9c-8ec1-49e6-be27-08d7426f98cb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2737
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

Since the logic for `spi_delay` struct + `spi_delay_exec()` has been copied
from the `cs_change_delay` logic, it's natural to make this delay, the
first user.

The `cs_change_delay` logic requires that the default remain 10 uS, in case
it is unspecified/unconfigured. So, there is some special handling needed
to do that.

The ADIS library is one of the few users of the new `cs_change_delay`
parameter for an spi_transfer.

The introduction of the `spi_delay` struct, requires that the users of of
`cs_change_delay` get an update. This change also updates the ADIS library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c  | 24 ++++++++++++------------
 drivers/spi/spi.c       | 28 +++++++---------------------
 include/linux/spi/spi.h |  4 +---
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..2cd2cc2316c6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,24 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -139,16 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -156,8 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
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

