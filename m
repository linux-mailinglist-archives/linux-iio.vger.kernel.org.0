Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C6B19DA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbfIMIqb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22374 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387649AbfIMIqb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:31 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8h2qn016487;
        Fri, 13 Sep 2019 04:46:26 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2058.outbound.protection.outlook.com [104.47.50.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdksa6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7zxbLDRVpVfGH4NZMffWEIFeGc7eCzcWlzqBRBt+ecp7RJugGoD+N7ZMVq1ZbNTYO4tjJtUvtMMS9N9cVk+GIWMOqXTLRVW7dHD9GrH/pgcBEmigUJfY9a7sr3xwzirMuLbFiNCrML3wFYxUYwZZ+e1jdWEBm3Ap9LPAeoRHnPubEz9m14IJV0ma4llJl5ZK5MKwOcoA86ZvGpXlyKSfGXCoD01gm/o3x1z5I3RzJoFehRxkGJg7Z7DvfXdbcDs7q6DOPWy5JRU5FIOVaqHnfc3zIN85LvEZqZBoij8RIt2Y8fq9JxB7ieZkvVnL26gdsbLhst7cp3crVAN2uRlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayt80fwvpB829Bt6euVneY1BsrkmJUopnKwAKBkNrcE=;
 b=FmApK0hxrJrgTxgGEtZOXecSfYD9qLWkL498s3MjGnNXT8ANBDFQDu0sh51mAGQFSPTtPAO2MgvDbsKcYT58cRBwqj5lVl+2x4+kbp3ETdtg3NQjHbPR8VxQ4HQu9Fcrh/8UkecJLxgG9EWiIrkKArxFukfhxVcBpku+IQyQU7+/0mLp3j4X2ob+FvYPlfhzUjw6BrYAXFRq7ry+1GIJDpfhOw0zuI8locnUVaCwi5whR5oaI2BCrODXZbdyAu56QrD6O92eefkSOfArBG0Ldu62kLXDU0Ju10A5U6tIOZ4b1vIT01k9qKAql9YJ5gdVB47tfKV6LdDRnlVfUb2qnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayt80fwvpB829Bt6euVneY1BsrkmJUopnKwAKBkNrcE=;
 b=TLtwHFRh81pHhBhyfTpNvHyAnDVg7PnbKVcf4KCV0Kzqqtn+f2gHVN++rdz72gLavYnlmz5CqKRSj5r4Qe9fez5u96N+63M2Ohv6kR40Cjvy2usbciVPcVafPfeYZq+EPmVKqtBH2IfziQa5c32FfGlE93zUfyI9o5Sh3aiEjVk=
Received: from DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48)
 by BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Fri, 13 Sep
 2019 08:46:23 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM6PR03CA0071.outlook.office365.com
 (2603:10b6:5:100::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.19 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kHVR030654
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:17 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 05/15] spi: sprd: convert transfer word delay to spi_delay struct
Date:   Fri, 13 Sep 2019 14:45:40 +0300
Message-ID: <20190913114550.956-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(86362001)(5660300002)(7416002)(51416003)(54906003)(186003)(8936002)(50226002)(50466002)(1076003)(7636002)(305945005)(36756003)(107886003)(44832011)(7696005)(356004)(76176011)(8676002)(446003)(2616005)(47776003)(6666004)(476003)(426003)(486006)(2870700001)(70586007)(4326008)(48376002)(478600001)(26005)(2201001)(126002)(106002)(11346002)(316002)(70206006)(110136005)(2906002)(336012)(246002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3573;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 107d0e70-0a27-41c4-9a6c-08d73826db38
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR03MB3573;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3573:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3573C6B9A26B77BF9B6E9A37F9B30@BYAPR03MB3573.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RTs1JyH0lSdsPEwocnRu8pSs+Iq9U5+wL5NUE13roqg3YUq3vhJRpYGPxacQiqE5IKdeSNz5oJIOY/rWdQisEjgkSZQAByQc/PEs9nL32hffbIkdMS1bJUOzjRIKaVcy2shLLIcwXo2PvWiCEMK4FM7sUQCF1OeJXuZdG0mVat83qPU6QcGqiSgevQqMdaueo0xxT64255Av2Fqphu3Qzqwqq8OYZN3ESgapDBLjIMKX5F714CoOK5G22e4VtX0tSFdlQ84BhE3nQB5qPRNGylcLgwxvTljJsWfLZtg9dQGGHkBw5Wb/FXzwXQpl7y4F7WKPjSt0xkNRJx6MTt/79QZTBTKIGFPHFHoG/Wqz6m9dYxB0t/iDT/QF+3t2+Y0FGSbCsYG6bzNYLzerdH80w6bk7OFqxEXNFR3sa/FkTMM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:23.2665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107d0e70-0a27-41c4-9a6c-08d73826db38
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3573
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

The Spreadtrum SPI driver is the only user of the `word_delay` field in
the `spi_transfer` struct.

This change converts the field to use the `spi_delay` struct. This also
enforces the users to specify the delay unit to be `SPI_DELAY_UNIT_SCK`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-sprd.c  | 11 +++++++++--
 include/linux/spi/spi.h |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 1b7eebb72c07..5634cd3e4a8d 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -671,9 +671,13 @@ static void sprd_spi_set_speed(struct sprd_spi *ss, u32 speed_hz)
 
 static void sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 {
+	struct spi_delay *d = &t->word_delay;
 	u16 word_delay, interval;
 	u32 val;
 
+	if (t->unit != SPI_DELAY_UNIT_SCK)
+		return -EINVAL;
+
 	val = readl_relaxed(ss->base + SPRD_SPI_CTL7);
 	val &= ~(SPRD_SPI_SCK_REV | SPRD_SPI_NG_TX | SPRD_SPI_NG_RX);
 	/* Set default chip selection, clock phase and clock polarity */
@@ -686,7 +690,7 @@ static void sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 	 * formula as below per datasheet:
 	 * interval time (source clock cycles) = interval * 4 + 10.
 	 */
-	word_delay = clamp_t(u16, t->word_delay, SPRD_SPI_MIN_DELAY_CYCLE,
+	word_delay = clamp_t(u16, d->value, SPRD_SPI_MIN_DELAY_CYCLE,
 			     SPRD_SPI_MAX_DELAY_CYCLE);
 	interval = DIV_ROUND_UP(word_delay - 10, 4);
 	ss->word_delay = interval * 4 + 10;
@@ -719,13 +723,16 @@ static int sprd_spi_setup_transfer(struct spi_device *sdev,
 	struct sprd_spi *ss = spi_controller_get_devdata(sdev->controller);
 	u8 bits_per_word = t->bits_per_word;
 	u32 val, mode = 0;
+	int ret;
 
 	ss->len = t->len;
 	ss->tx_buf = t->tx_buf;
 	ss->rx_buf = t->rx_buf;
 
 	ss->hw_mode = sdev->mode;
-	sprd_spi_init_hw(ss, t);
+	ret = sprd_spi_init_hw(ss, t);
+	if (ret)
+		return ret;
 
 	/* Set tansfer speed and valid bits */
 	sprd_spi_set_speed(ss, t->speed_hz);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9ded3f44d58e..16397b210e0c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -759,7 +759,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *	the next transfer or completing this @spi_message.
  * @word_delay_usecs: microseconds to inter word delay after each word size
  *	(set by bits_per_word) transmission.
- * @word_delay: clock cycles to inter word delay after each word size
+ * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
  *      transfer this transfer. Set to 0 if the spi bus driver does
@@ -847,8 +847,8 @@ struct spi_transfer {
 	u8		word_delay_usecs;
 	u16		delay_usecs;
 	struct spi_delay	cs_change_delay;
+	struct spi_delay	word_delay;
 	u32		speed_hz;
-	u16		word_delay;
 
 	u32		effective_speed_hz;
 
-- 
2.20.1

