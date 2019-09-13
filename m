Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA597B19E4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfIMIqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28432 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387715AbfIMIqk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:40 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gsta001935;
        Fri, 13 Sep 2019 04:46:34 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2058.outbound.protection.outlook.com [104.47.34.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsa85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGmFx0b/y7/0tkBVloHzr44Zhknq2Y7C5lmAXJSwUVuJcK6ZK27a2lzHnxyfMERuGImWt/gxaK5uL1VNiXZz9YLXkSBdgEMknNOC+x/rzAI1kPIJPiXDa3ljYhHkk20Np0o+kcjc5rfIuGDqqzifbcZbmcWqUOaAj74fNrOoOC9Omy4PjmDhhbA8Mcu4uq+C5Rq0wV4IFf9rSQKscCapKtNzIWQrZtRwqnLvVE6Jq3w4PhXRZZmj31edooWuRhndJVMU61rBgpCt6tFyBmqt3EZikAsVp0v9u2jNVyHDmUKAPvvWuFL/eswzxTCaSlmIwW3tAHZ+TorqPQU73vk1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfHznp9C/uGwlBu8jzfVRiiAcVsPibiwgdWvzbHijTM=;
 b=A+ZxWru9mLGsc9w7sgFpv+C4Ge8Zg/AHUIet1RCfLYkmPjQ2ZzWozIDzRp0/XxUJ6cL9V2pHDG9dfVhPH1DWEnqVjLx/I5IqX4cIDRc9jNpw16jX0LDzO3WB+XjIRoSDIRoOOT6mzR1e81AwOMZIZumIj+w4HlalU8r2fRAebsRBuQ4g8xyBXL6J1taqifbEIr7WCH7xlz9MirLF9WkccWhy0nFRPqOH9aMSfFsYW1eiqkHa9Ba+y2c9fva8hIxcQ/iTTN6lQjhwTNtvun+efIaPj7noGElaoTV9tpigEphBMqsVvoxmVMDKY2QPTAIsy23G9BeOC1yN0i5oh0HUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfHznp9C/uGwlBu8jzfVRiiAcVsPibiwgdWvzbHijTM=;
 b=SpbpG12eqce0ul1uYaIwAOUvb4pELMWyv+n7FnEtP4XHJ9vKrM8RFF9xbg0dOSp3zcBtoX+Y/obv916/wpLDQwsC32mFZ3ta7+jwKf3ic9LJufns+TfxL9spLqjqypV3iRtnzMAez6+TUhS8rWt3Y3e/MdJH6CxC42WXrEKahA0=
Received: from CY4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:903:33::22)
 by BYAPR03MB4790.namprd03.prod.outlook.com (2603:10b6:a03:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Fri, 13 Sep
 2019 08:46:32 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR03CA0012.outlook.office365.com
 (2603:10b6:903:33::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.15 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kQkP030691
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:26 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 08/15] spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for spi_device
Date:   Fri, 13 Sep 2019 14:45:43 +0300
Message-ID: <20190913114550.956-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(2201001)(305945005)(76176011)(36756003)(14444005)(44832011)(2870700001)(54906003)(106002)(110136005)(8676002)(336012)(476003)(50226002)(478600001)(2906002)(5660300002)(4326008)(2616005)(70586007)(86362001)(186003)(70206006)(11346002)(486006)(7696005)(246002)(47776003)(7416002)(8936002)(356004)(107886003)(426003)(50466002)(316002)(446003)(48376002)(26005)(7636002)(51416003)(1076003)(6666004)(126002)(142933001)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4790;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 197dd7dd-8d79-4dfa-ee28-08d73826e025
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR03MB4790;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4790:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4790DB9658B1548E832BC453F9B30@BYAPR03MB4790.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hkzuZ4EgFWxaaRFAsuTbZ6xlrUqsy407WTj1MXXi+xT+oNtUuvuajs4yOnjsd25VLGQj2Od2+UfCv8N1XEk4AOFsth4x/BV33C5ptxcWEChBBRQAyFlh1iX3SEgV/rzDH0OHwIdmMbJFZxr9SJD6QgiUH2cFtIU1zLH+lv8ljjTQcCZPcGUYnhKfgtLRM+ceRMqw/dajB64vgjPKLhkSAnaCS+PEFWT9zFXcCW8qDYqEPggfGJcIEOySab/MLK0cQEFjoX7s+Pzu4bAnuN0VUzg0VahBGNcWrhZERQr3ii3QfH9rt1OCLGOhhPLDYwB602YZy9cBF//QGK8GYc2boXtftDU4ReRy4wg/530Zpc+qNJoozyxzOrohRBxdCTmFH3gtKzx/ccZaxTcb+z4tl6Jl4MYDccd7X9Qo+/6IysY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:31.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197dd7dd-8d79-4dfa-ee28-08d73826e025
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4790
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
index f00b367523cd..009bb4fb5e5f 100644
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
 
+	word_delay_csr = atmel_word_delay_csr(as, spi);
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

