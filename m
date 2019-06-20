Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668D64CB29
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfFTJme (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:42:34 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:55630
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfFTJme (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pv2UHx8Ba7okxCOOxIYWIe1cSD6oxWxUIusS95Vhf8=;
 b=NLXzd0hhZ5h46g9CEHBpyXNfxF3qOaRxl8AdrrTZQqtP1caUn6EPlCL3++81/izX2TjJlglUyvRFIMPNd0RBLeUipzidXdFnx+x4UgrONRSLV1gpylQRR6Wdk5kVwlI3wBx+CoIkLzevrdiysZ26y9+mOhdrBkl8DTX7+wQa76I=
Received: from BN3PR03CA0106.namprd03.prod.outlook.com (2603:10b6:400:4::24)
 by CY1PR03MB2266.namprd03.prod.outlook.com (2a01:111:e400:c637::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Thu, 20 Jun
 2019 09:42:31 +0000
Received: from CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN3PR03CA0106.outlook.office365.com
 (2603:10b6:400:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Thu, 20 Jun 2019 09:42:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT046.mail.protection.outlook.com (10.152.74.232) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:42:29 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5K9gTov013336
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:42:29 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:42:28 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [RESEND PATCH 2/4] iio: adc: ad7124: Add buffered input support
Date:   Thu, 20 Jun 2019 12:42:01 +0300
Message-ID: <20190620094203.13654-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620094203.13654-1-mircea.caprioru@analog.com>
References: <20190620094203.13654-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(7696005)(48376002)(5660300002)(107886003)(426003)(4326008)(478600001)(2616005)(106002)(47776003)(476003)(305945005)(86362001)(11346002)(8936002)(246002)(126002)(486006)(44832011)(7636002)(50226002)(8676002)(70206006)(336012)(50466002)(2906002)(446003)(6916009)(1076003)(26005)(72206003)(54906003)(186003)(36756003)(70586007)(16586007)(356004)(51416003)(316002)(6666004)(2351001)(77096007)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2266;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f06e42fc-2cc4-4e04-b6d5-08d6f5639d0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY1PR03MB2266;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2266:
X-Microsoft-Antispam-PRVS: <CY1PR03MB2266BF92218FD965C71DAFC181E40@CY1PR03MB2266.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uZOSJieKJEz/2If3FQ+sdApBTycSCV2Cu7tHz2cDmfPk0OtVs17Sw1dBuV85P2iPKI2Zwny5scTe4Hxx8oS2HGjb0b8Jp+c6ZSCjZm0iwOpPIhV0Tpemr4yECWQDMk5ptsTYkxy7fa23tzXbYh/tSk+ufr0CDNjnsrNGWfuJK7SH3mlpB3Eh/co07I6PBK6QiW+8Bxq2xgGz/lYE0QMBPxxwV39cpBTttInExLfcIe/Zg+p2Kmz7hcHox9QBzbspo/kJfIXyqpM67RxtmxjsDrO0n0tDMT6t0xKZFuA97v0IJpkYK6C61qoyZ5W1+BrF+v69wF/Evy2Lk3nPCxZkM/TyuA162s7EpEyujskxxAHvYNoyk2r3OSpcTiV/nyoL4CKldGIKY71JzPtptfu5qZ3LvcgCBbl/vxmwgu8HgzA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:42:29.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06e42fc-2cc4-4e04-b6d5-08d6f5639d0b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2266
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds the option to enable the buffered mode for positive and
negative inputs. Each option can be enabled independently.

In buffered mode, the input channel feeds into a high impedance input stage
of the buffer amplifier. Therefore, the input can tolerate significant
source impedances and is tailored for direct connection to external
resistive type sensors such as strain gages or RTDs.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7124.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 810234db9c0d..ab52c5e9ecb1 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -61,6 +61,8 @@
 #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
 #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
 #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
+#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
+#define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
 
 /* AD7124_FILTER_X */
 #define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
@@ -108,6 +110,8 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	enum ad7124_ref_sel refsel;
 	bool bipolar;
+	bool buf_positive;
+	bool buf_negative;
 	unsigned int ain;
 	unsigned int vref_mv;
 	unsigned int pga_bits;
@@ -473,6 +477,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		else
 			st->channel_config[channel].refsel = tmp;
 
+		st->channel_config[channel].buf_positive =
+			of_property_read_bool(child, "adi,buffered-positive");
+		st->channel_config[channel].buf_negative =
+			of_property_read_bool(child, "adi,buffered-negative");
+
 		*chan = ad7124_channel_template;
 		chan->address = channel;
 		chan->scan_index = channel;
@@ -492,7 +501,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	unsigned int val, fclk, power_mode;
-	int i, ret;
+	int i, ret, tmp;
 
 	fclk = clk_get_rate(st->mclk);
 	if (!fclk)
@@ -525,8 +534,12 @@ static int ad7124_setup(struct ad7124_state *st)
 		if (ret < 0)
 			return ret;
 
+		tmp = (st->channel_config[i].buf_positive << 1)  +
+			st->channel_config[i].buf_negative;
+
 		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
-		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel);
+		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
+		      AD7124_CONFIG_IN_BUFF(tmp);
 		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
 		if (ret < 0)
 			return ret;
-- 
2.17.1

