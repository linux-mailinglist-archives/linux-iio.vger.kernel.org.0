Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDAB19FB
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfIMIq6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:14452 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387812AbfIMIq5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:57 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8giVE017273;
        Fri, 13 Sep 2019 04:46:51 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h9bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBZWMGO8l2pm/51MaVABH2hP5W7pVShWY9pXXYEmkqk2H3o0P20vvZUfs76b5GPW+yNaHaKWge+R6ll9z3NRzOQ0AXLEarb+OJz88umLBeBgUnlCDobnq+XNHlGckqCJfZEQsDihTEgfzHiEeWRi26iNYmxO/2iCaaDnvj3HScrOqLk94YJYc/aJWGrkn1uPfI/hmhu3uTVrYXldep9JQd8ceSE/bnuPcCliDdKabdnU8vqFyCJ9TtLFVHL3eOzMOtOKpo/7H+imCkSZWR33NE9+hoViR+ejzWtNl+2IlSt39xq4LuwjI/JSSQs92rXD/Bx+GgfRJcfJyMyGYxqEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXLRuMGRfkk1Xiwfr0phB9Pf8l/4nkEANrVfU4Zp1dA=;
 b=H+d+moC9lrZLhi/8IL6wApY91LTwb8/JuDbksnU4zQOln4k66QK52Q1whGnoev14QZgkEGRv1yZ78I47jPEMbYK9W9NSbyXS3EjF5ji6cJxkfbQLWsRc/Vh70iDOnUfdYDYj8goADUxVsEa6418ag0bqlwcsFW/i+wu0N2L50vrhDCRR2rQsF1kpm+DXYmnPZNZYz9FZ98Bpsxl7F418nGRU//FUjHKtJ+hg7Hqq6SyOr2VaLg5Mc56e+DyEDfgj3gkYg5y1ZVA2HMzTPXmBXFzADy5mj8SWAWWOQt9H44P/qMwf91jdQ5VFAqjokAC6NhwJoahJpJ171Xj9/Xs5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXLRuMGRfkk1Xiwfr0phB9Pf8l/4nkEANrVfU4Zp1dA=;
 b=aHUq47n5Px4RKQrB/Qjf0UCc1//RS4hdhWNPZ7tyCje7qt83oCBGhH9/HtHzLgEbyT+vjXw8QRY6l4nkYgMrj/wAyKPsiVNx8mkwsemabgwBEV4whN5rN3rEmDIdOl09HH5wYAEalf8j6f+SdCtmVIzPPEmocvEqN6IR6vElLIM=
Received: from DM6PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:100::34)
 by DM5PR03MB2699.namprd03.prod.outlook.com (2603:10b6:3:42::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Fri, 13 Sep
 2019 08:46:48 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR03CA0057.outlook.office365.com
 (2603:10b6:5:100::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kgvi030749
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:42 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:46 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 14/15] spi: tegra114: change format for `spi_set_cs_timing()` function
Date:   Fri, 13 Sep 2019 14:45:49 +0300
Message-ID: <20190913114550.956-15-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(76176011)(478600001)(356004)(2870700001)(2906002)(70586007)(70206006)(50226002)(48376002)(8936002)(8676002)(5660300002)(51416003)(47776003)(7696005)(7636002)(305945005)(246002)(1076003)(186003)(7416002)(426003)(54906003)(110136005)(50466002)(446003)(26005)(106002)(126002)(107886003)(11346002)(476003)(2201001)(336012)(316002)(486006)(36756003)(44832011)(2616005)(4326008)(86362001)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2699;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8ff26b-05fb-43d8-69c9-08d73826e9ec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM5PR03MB2699;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2699:
X-Microsoft-Antispam-PRVS: <DM5PR03MB26997C0D2F88FAAA99514BF5F9B30@DM5PR03MB2699.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BMOwiUHJ6lFKwFUh/wjkeNutWxfRs+D9IxdHltSEBwwOorhw0VRZJAHZYOAem8VQstEUwfTSUbrFTjA9Q7AAqp1UVTux6ZC/WWKjpD7lzMM/Pgd5LbqF1DoFIjD6htMhOxYm8Fz0VOhTPx7RTK8+6O1YVY2O86fr+oZY3d4F1NGe0CrYkbmmpnVEWI+0jBOM6w1YflteLEYIT60nYED8/+JSrP1Te+EgzeYRBL+dCBOj463PiL1i65GpRfXlS07eTv3gxri5+uE1KU7QYa/i/EMrch3kof3mjoiBlyOB3w4YGj0DYK8iVMLvM0C4TJHFUCsnLzP/AJ1HWeLWgew/x3nJYeOPdDGeafeulYaL2pcEDz/jH6OjEKC6tvPs59WQnQyDFCAsE8E/uiZHmmpIycyMtxWSf4f3DW/RkTqMB3o=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:47.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8ff26b-05fb-43d8-69c9-08d73826e9ec
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2699
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The initial version of `spi_set_cs_timing()` was implemented with
consideration only for clock-cycles as delay.

For cases like `CS setup` time, it's sometimes needed that micro-seconds
(or nano-seconds) are required, or sometimes even longer delays, for cases
where the device needs a little longer to start transferring that after CS
is asserted.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++++++--
 drivers/spi/spi.c          | 16 ++++++++++------
 include/linux/spi/spi.h    |  9 ++++++---
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 5ac2ceb234fc..d8db4af08fff 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -723,15 +723,31 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
-static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
-				       u8 hold_dly, u8 inactive_dly)
+static int tegra_spi_set_hw_cs_timing(struct spi_device *spi,
+				      struct spi_delay *setup,
+				      struct spi_delay *hold,
+				      struct spi_delay *inactive)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	u8 setup_dly, hold_dly, inactive_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
 	u32 inactive_cycles;
 	u8 cs_state;
 
+	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive && inactive != SPI_DELAY_UNIT_SCK)) {
+		dev_err(&spi->dev,
+			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
+			SPI_DELAY_UNIT_SCK);
+		return -EINVAL;
+	}
+
+	setup_dly = setup ? setup->value : 0;
+	hold_dly = hold ? hold->value : 0;
+	inactive_dly = inactive ? inactive->value : 0;
+
 	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
 	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
 	if (setup_dly && hold_dly) {
@@ -758,6 +774,8 @@ static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
 		tspi->spi_cs_timing2 = spi_cs_timing;
 		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING2);
 	}
+
+	return 0;
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c55d55acbbb0..54d00c0a26d2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3147,15 +3147,19 @@ EXPORT_SYMBOL_GPL(spi_setup);
 /**
  * spi_set_cs_timing - configure CS setup, hold, and inactive delays
  * @spi: the device that requires specific CS timing configuration
- * @setup: CS setup time in terms of clock count
- * @hold: CS hold time in terms of clock count
- * @inactive_dly: CS inactive delay between transfers in terms of clock count
+ * @setup: CS setup time specified via @spi_delay
+ * @hold: CS hold time specified via @spi_delay
+ * @inactive: CS inactive delay between transfers specified via @spi_delay
+ *
+ * Return: zero on success, else a negative error code.
  */
-void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
-		       u8 inactive_dly)
+int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
+		      struct spi_delay *hold, struct spi_delay *inactive)
 {
 	if (spi->controller->set_cs_timing)
-		spi->controller->set_cs_timing(spi, setup, hold, inactive_dly);
+		return spi->controller->set_cs_timing(spi, setup, hold,
+						      inactive);
+	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c7f90a0129be..292e752ce34a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -517,8 +517,8 @@ struct spi_controller {
 	 * to configure specific CS timing through spi_set_cs_timing() after
 	 * spi_setup().
 	 */
-	void (*set_cs_timing)(struct spi_device *spi, u8 setup_clk_cycles,
-			      u8 hold_clk_cycles, u8 inactive_clk_cycles);
+	int (*set_cs_timing)(struct spi_device *spi, struct spi_delay *setup,
+			     struct spi_delay *hold, struct spi_delay *inactive);
 
 	/* bidirectional bulk transfers
 	 *
@@ -1007,7 +1007,10 @@ static inline void spi_message_free(struct spi_message *m)
 	kfree(m);
 }
 
-extern void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold, u8 inactive_dly);
+extern int spi_set_cs_timing(struct spi_device *spi,
+			     struct spi_delay *setup,
+			     struct spi_delay *hold,
+			     struct spi_delay *inactive);
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
-- 
2.20.1

