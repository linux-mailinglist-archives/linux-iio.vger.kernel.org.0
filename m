Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91E64CB2E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfFTJmi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:42:38 -0400
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:52437
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfFTJmg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAuFOPNCH51KU4B9qyEKHOmP9JFEhdxPDYZXO1DMeTE=;
 b=eVVsXf3S2sQwaoLl+dkwnmGuUVdZCYRWegjgsPNW9DT8TGHoqubAr1u9yKoX11lUw/+EhLsNqOj/u8/hmdqIuf60oHKOqP0uLRbBdgjE8yuEOaTzOw9b4jnC5TFL/guGU8ZkSPggqmhBMNeNS7Atp/dEsu+VJqTlam420w2x2is=
Received: from CY4PR03CA0005.namprd03.prod.outlook.com (2603:10b6:903:33::15)
 by BY2PR03MB555.namprd03.prod.outlook.com (2a01:111:e400:2c37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.15; Thu, 20 Jun
 2019 09:42:34 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR03CA0005.outlook.office365.com
 (2603:10b6:903:33::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.12 via Frontend
 Transport; Thu, 20 Jun 2019 09:42:33 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:42:32 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5K9gWqt013365
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:42:32 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:42:31 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [RESEND PATCH 3/4] iio: adc: ad7124: Shift to dynamic allocation for channel configuration
Date:   Thu, 20 Jun 2019 12:42:02 +0300
Message-ID: <20190620094203.13654-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620094203.13654-1-mircea.caprioru@analog.com>
References: <20190620094203.13654-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(446003)(246002)(336012)(6916009)(356004)(6666004)(70586007)(47776003)(50466002)(1076003)(70206006)(48376002)(8676002)(126002)(486006)(106002)(72206003)(2906002)(7696005)(8936002)(76176011)(54906003)(2616005)(316002)(16586007)(50226002)(478600001)(44832011)(51416003)(107886003)(26005)(186003)(86362001)(14444005)(4326008)(11346002)(5660300002)(7636002)(77096007)(305945005)(36756003)(476003)(426003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB555;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ccc48e-bbed-41cc-d8d7-08d6f5639e7c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR03MB555;
X-MS-TrafficTypeDiagnostic: BY2PR03MB555:
X-Microsoft-Antispam-PRVS: <BY2PR03MB555D8621A143AE29D7E353A81E40@BY2PR03MB555.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YnCVPHPMgn8FEri8SYfyhTN8ISX7U8WaLSJzqBwLSFPO9i3UiR8If3iAKNNFbPDaWcTY4IWiPCeCuF4zPpxvFH+CCs5JV7gXkVbZlQTPKcgRHL/9vUZ7VKO/n+pahq4xH4Am2LJaIgfDG94+AlG2iA0EIn+CWmWyumabuc73h1g1F+4a1a9e0MiLAqlsjYNmQsca8+kcnR87g8o6uJJND73TQshb8+5dbZxuMx+KQi66NhIRLB1QIgFQ+T4MiGMiGvEIVZ9RWwWrZyj3WIua0fPvNA3bxDVkGCYA6m8LZZ82hyQASwOjRz7NcvmAYnwav8bmGc+fM8+mFci+p9UDsisOH287jPO55n1vMbyxFurOwMytKGYngLxXbxB/znbsAOrMFZYIwnas62RxNvQYHsewIQ3bR0O1VhqgxBp06Aw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:42:32.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ccc48e-bbed-41cc-d8d7-08d6f5639e7c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB555
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch changes the channel configuration member of the device
structure from a fixed size array to a dynamic allocated one with a size
equal to the number of channels specified in the device tree. This will
ensure a more flexibility for compatible devices.

Ex. ad7124-4 - can have 4 differential or 8 pseudo-differential channels
ad7124-8 - can have 8 differential or 16 pseudo-differential channels

Also the device can suspport any other combination of differential and
pseudo-differential channels base on the physical number of inputs
available.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7124.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index ab52c5e9ecb1..edc6f1cc90b2 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -121,7 +121,7 @@ struct ad7124_channel_config {
 struct ad7124_state {
 	const struct ad7124_chip_info *chip_info;
 	struct ad_sigma_delta sd;
-	struct ad7124_channel_config channel_config[4];
+	struct ad7124_channel_config *channel_config;
 	struct regulator *vref[4];
 	struct clk *mclk;
 	unsigned int adc_control;
@@ -439,6 +439,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	struct ad7124_state *st = iio_priv(indio_dev);
 	struct device_node *child;
 	struct iio_chan_spec *chan;
+	struct ad7124_channel_config *chan_config;
 	unsigned int ain[2], channel = 0, tmp;
 	int ret;
 
@@ -453,8 +454,14 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	if (!chan)
 		return -ENOMEM;
 
+	chan_config = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
+				   sizeof(*chan_config), GFP_KERNEL);
+	if (!chan_config)
+		return -ENOMEM;
+
 	indio_dev->channels = chan;
 	indio_dev->num_channels = st->num_channels;
+	st->channel_config = chan_config;
 
 	for_each_available_child_of_node(np, child) {
 		ret = of_property_read_u32(child, "reg", &channel);
-- 
2.17.1

