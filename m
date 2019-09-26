Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0681DBF03F
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfIZKwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48994 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbfIZKwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:35 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqQhH002867;
        Thu, 26 Sep 2019 06:52:29 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2050.outbound.protection.outlook.com [104.47.49.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96rbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDLW/tGwdIAyE9HGxZyehcMBMae/sQ0ZFMe4A0Yv+pJkMOiMJeE+MjSAYM9eBHIFlAXi++ega0Emp/9XLwFvZQDTcObS1R5oNLls9ncJzagbCmCo1C6RnFgkFkncphW8QwcFF61XlXdMbsZ9F8Mo5edNbFJT0Gt2GP/OcyTPCjKEg6LGSdEnhytx/JlRqPplHFvKWF6wjWqYytWUqBhCM0vV5lAL3kuj9vGT+30ktsMSIEEMX8YZQ1yo4uzeXZG9mE+qFhHz1jYyakhR1D9XWDlyb8/qaXTT6nCrl6QBfA9Xf0ZoazlO10Uj01X27VB4rFoR41iMoGEccvwmT2rHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IA+1Fc7lyDOHCZvoYR1tS+uwKA95J512v8EqcOR0dI=;
 b=OeghTfIcM/0pdQT4k+rZ2Th/hnDcnLHzYCD1bCjdgExpjx4VYvgl+ysEUK6QePAafNlRj8XBcVarc3VADh80brJUswAt+lpcqAlw4nFGeua4Dy7wJ8aH5R4yLgwskqkqUrLhAvwg6tmRCEqa1sto0xKEsLhOnXhQDamm4WV+OQ6easdq0MdPEh4AkjQiGHP09KW7vlcLbGgfmJAmVBZPpTnvz4RB39tdioQseQeTKbHyvruULmDe9mU7p9PHCf4Dfc+LSQePDPOvu0Xmt9AowxYRP5v4XoMrNaHio3KndE0ChpjSwf5AkWLFtLF6soMlRogG0qDs+s9KhqZdsfC2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IA+1Fc7lyDOHCZvoYR1tS+uwKA95J512v8EqcOR0dI=;
 b=0ZE4dl978d07kvBUlFeWYo2lEPgbGAfXjfQKkwCXPCQyPyuGmgR+4VJf1q1ol3j9c3W9iWzKjJRYgegUPLyty2SuibXC2iZ3S0BJ8fm8Ss5lNI/Xml4ctC0KHnHQ3y1J8TSekApuWu7KvTKQc7AMSTciHU+iKfaAGySTVIap7G8=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Thu, 26 Sep
 2019 10:52:28 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqReg014787
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:27 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:27 -0400
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
Subject: [PATCH v4 07/19] spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for spi_device
Date:   Thu, 26 Sep 2019 13:51:35 +0300
Message-ID: <20190926105147.7839-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(54906003)(47776003)(48376002)(86362001)(2201001)(50466002)(7636002)(2616005)(44832011)(446003)(11346002)(486006)(336012)(126002)(476003)(426003)(2870700001)(305945005)(7416002)(76176011)(51416003)(2906002)(186003)(7696005)(26005)(5660300002)(1076003)(106002)(6666004)(316002)(478600001)(70586007)(70206006)(356004)(8676002)(246002)(8936002)(36756003)(50226002)(14444005)(4326008)(107886003)(110136005)(81973001)(142933001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5049;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d80d7d5c-58f0-4981-dd3f-08d7426f9f5f
X-MS-TrafficTypeDiagnostic: DM6PR03MB5049:
X-Microsoft-Antispam-PRVS: <DM6PR03MB50496E2AB129B1FF3A267F49F9860@DM6PR03MB5049.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xsCoYiglvStMp0h95uj3P3leALEqEgF5SZgI+MqY6OCwl1wzIdPk8xIitHIfopJqrwK1l67ngFraTMoEdifc2p2jCSWYDDuB5eXRE+oPRFuW4Lii9jOdttgwi0zUSz9Qz/iCHd+yeq3esKW3r3Ta3FLMe6lXxx/fMhV+mgc7PriqRscTOlxN/ni1TqNRQMr5uMh/83LgehMKUykexnZjDwsePd2eBhvxChphyy/SDvP1qmtJzFhBbnD9BwRIOG+0MHc9bpkFfcziTpS+qm6zKybhBSiA6x5hl9s9A1J6S8LO8HZPmsx4mdw3RpR+muD88G7iFnNh0GoXrX0QHzahwnZhlyEp7Logc3LYBX8ZzgK73nn8qyWNk54PsN2qL7lo4NqL9sK5nl+vdtg69PvuK+MYb/vTIaXtXrRjy+RmUg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:27.8297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80d7d5c-58f0-4981-dd3f-08d7426f9f5f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change does a conversion from the `word_delay_usecs` -> `word_delay`
for the `spi_device` struct.

This allows users to specify inter-word delays in other unit types
(nano-seconds or clock cycles), depending on how users want.

The Atmel SPI driver is the only current user of the `word_delay_usecs`
field (from the `spi_device` struct).
So, it needed a slight conversion to use the `word_delay` as an `spi_delay`
struct.

In SPI core, the only required mechanism is to update the `word_delay`
information per `spi_transfer`. This requires a bit more logic than before,
because it needs that both delays be converted to a common unit
(nano-seconds) for comparison.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-atmel.c | 26 ++++++++++++++++++++++++--
 drivers/spi/spi.c       | 24 ++++++++++++++++++++++--
 include/linux/spi/spi.h |  7 ++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f00b367523cd..f04b92791515 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1172,12 +1172,31 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+static int atmel_word_delay_csr(struct spi_device *spi, struct atmel_spi *as)
+{
+	struct spi_delay *delay = &spi->word_delay;
+	u32 value = delay->value;
+
+	switch (delay->unit) {
+	case SPI_DELAY_UNIT_NSECS:
+		value /= 1000;
+		break;
+	case SPI_DELAY_UNIT_USECS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return (as->spi_clk / 1000000 * value) >> 5;
+}
+
 static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
 	struct atmel_spi_device	*asd;
 	u32			csr;
 	unsigned int		bits = spi->bits_per_word;
+	int			word_delay_csr;
 
 	as = spi_master_get_devdata(spi->master);
 
@@ -1201,11 +1220,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 	 */
 	csr |= SPI_BF(DLYBS, 0);
 
+	word_delay_csr = atmel_word_delay_csr(spi, as);
+	if (word_delay_csr < 0)
+		return word_delay_csr;
+
 	/* DLYBCT adds delays between words.  This is useful for slow devices
 	 * that need a bit of time to setup the next transfer.
 	 */
-	csr |= SPI_BF(DLYBCT,
-			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
+	csr |= SPI_BF(DLYBCT, word_delay_csr);
 
 	asd = spi->controller_state;
 	if (!asd) {
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d0bf0ffca042..ba8731b77753 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3159,6 +3159,26 @@ void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
+static int _spi_xfer_word_delay_update(struct spi_transfer *xfer,
+				       struct spi_device *spi)
+{
+	int delay1, delay2;
+
+	delay1 = _spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (delay1 < 0)
+		return delay1;
+
+	delay2 = _spi_delay_to_ns(&spi->word_delay, xfer);
+	if (delay2 < 0)
+		return delay2;
+
+	if (delay1 < delay2)
+		memcpy(&xfer->word_delay, &spi->word_delay,
+		       sizeof(xfer->word_delay));
+
+	return 0;
+}
+
 static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
@@ -3294,8 +3314,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 		}
 
-		if (xfer->word_delay_usecs < spi->word_delay_usecs)
-			xfer->word_delay_usecs = spi->word_delay_usecs;
+		if (_spi_xfer_word_delay_update(xfer, spi))
+			return -EINVAL;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 16397b210e0c..e7ec0be16a82 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -138,7 +138,7 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	the spi_master.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
- * @word_delay_usecs: microsecond delay to be inserted between consecutive
+ * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
  *
  * @statistics: statistics for the spi_device
@@ -188,7 +188,7 @@ struct spi_device {
 	const char		*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
-	uint8_t			word_delay_usecs; /* inter-word delay */
+	struct spi_delay	word_delay; /* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -757,8 +757,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
- * @word_delay_usecs: microseconds to inter word delay after each word size
- *	(set by bits_per_word) transmission.
  * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
@@ -844,7 +842,6 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
-	u8		word_delay_usecs;
 	u16		delay_usecs;
 	struct spi_delay	cs_change_delay;
 	struct spi_delay	word_delay;
-- 
2.20.1

