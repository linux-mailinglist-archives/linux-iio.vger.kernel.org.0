Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5183D4CA94
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfFTJTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:19:51 -0400
Received: from mail-eopbgr780084.outbound.protection.outlook.com ([40.107.78.84]:43904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTJTv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pv2UHx8Ba7okxCOOxIYWIe1cSD6oxWxUIusS95Vhf8=;
 b=gvlMw/PTOL/c7uWwiP4TG7BslCKlx9jmLSCjwb1U53B2TZpUtBK58Wwsv2DY40yurrE//ze8VjRiE/V1/cgvdHLZvIKZF+l4C6FgqMTO6wbWhn9Tq6U5Dh8emVJVYEMvEZiVc1Qg9v4c7RE5cPWQNgY9lyLk+Qnw1VV3/3PEKY4=
Received: from BN8PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:94::35)
 by DM2PR03MB558.namprd03.prod.outlook.com (2a01:111:e400:241d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13; Thu, 20 Jun
 2019 09:19:48 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN8PR03CA0022.outlook.office365.com
 (2603:10b6:408:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Thu, 20 Jun 2019 09:19:48 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:19:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5K9JkfW023159
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:19:46 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:19:46 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/4] iio: adc: ad7124: Add buffered input support
Date:   Thu, 20 Jun 2019 12:19:06 +0300
Message-ID: <20190620091908.12041-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620091908.12041-1-mircea.caprioru@analog.com>
References: <20190620091908.12041-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(199004)(189003)(246002)(486006)(7636002)(5660300002)(50466002)(4326008)(72206003)(48376002)(36756003)(86362001)(305945005)(478600001)(356004)(1076003)(107886003)(6916009)(7696005)(446003)(50226002)(6666004)(51416003)(8936002)(336012)(11346002)(76176011)(8676002)(186003)(44832011)(2616005)(2351001)(70586007)(426003)(126002)(476003)(54906003)(26005)(16586007)(70206006)(2906002)(316002)(106002)(77096007)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB558;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026547da-4f70-48ad-99c8-08d6f56070e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM2PR03MB558;
X-MS-TrafficTypeDiagnostic: DM2PR03MB558:
X-Microsoft-Antispam-PRVS: <DM2PR03MB558580434739D24816A831B81E40@DM2PR03MB558.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HjDfu6f6iAt+nxikzZBSBDVA0yWxT+G0cmYaF0V/xwuvrxEuPzavaQq5wsanNalZM/IvdW+dviFllW8sFZlJJnBECiN4rzTNdQnpy8RBfMNl+OEDV13AGfHal23VR99I7WXztgS0qXIRUHMuivs2Nj4LFdrocEKLaF+XohEnYG+cd0lNJ8NdmC/2EZCVUTiUoUxjBHgSxTSQbo77LQfm/LvbDVzQR+gd++poBCa2WHJwNU6xyDMoKofW8bJKZuilSDlwbqrkNelEz9E4y5+/cD9FxS2Golf4t4jPQbTBWjwWm5oQExa0yvjtNPDUFZPzL+N+c1lm3VUTAU/ZHsq0lHwe+8iaNq0FUgm7Mq1vOYr7oOPN5B64S77yzzUtjAiqf5IyCXjSua89HC9ceGCptfQo34epfL0tX0tF9Kf/gT4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:19:47.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026547da-4f70-48ad-99c8-08d6f56070e1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB558
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

