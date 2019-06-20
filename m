Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00F64CA96
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfFTJT6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:19:58 -0400
Received: from mail-eopbgr680049.outbound.protection.outlook.com ([40.107.68.49]:39811
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTJT6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAuFOPNCH51KU4B9qyEKHOmP9JFEhdxPDYZXO1DMeTE=;
 b=zjyXloi4WnHgfyEVtFaVx4Q7N3FFpDr/b25N/nVaaoEK7uRTKHhU+gXy/VtCncwsn9DcKSQwauC93jIxKihdmXPsH/T8yXxR3rqkyLWbrxO/n9vJ9xQ/IeKPnD/eFBQTQr/zyJaGsB/KfXu7yQOL5EH1erJwcAziEC991C/CrTE=
Received: from BN8PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:94::49)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bbf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Thu, 20 Jun
 2019 09:19:55 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN8PR03CA0036.outlook.office365.com
 (2603:10b6:408:94::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Thu, 20 Jun 2019 09:19:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:19:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5K9Jpwk023177
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:19:51 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:19:50 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 3/4] iio: adc: ad7124: Shift to dynamic allocation for channel configuration
Date:   Thu, 20 Jun 2019 12:19:07 +0300
Message-ID: <20190620091908.12041-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620091908.12041-1-mircea.caprioru@analog.com>
References: <20190620091908.12041-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(2351001)(50466002)(48376002)(6666004)(107886003)(356004)(36756003)(4326008)(6916009)(47776003)(336012)(70206006)(8936002)(246002)(70586007)(8676002)(14444005)(50226002)(186003)(76176011)(51416003)(7696005)(7636002)(305945005)(16586007)(316002)(2906002)(54906003)(106002)(44832011)(478600001)(86362001)(77096007)(26005)(5660300002)(486006)(126002)(426003)(446003)(476003)(1076003)(72206003)(2616005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0088bad-515c-4c8d-98ec-08d6f56074d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-Microsoft-Antispam-PRVS: <BN3PR03MB225837404ED630544EC71B0B81E40@BN3PR03MB2258.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PtO5Z8J5mCv9rR6WQv+d8nwxNTIz6LwqIr+eBpMpSEgvg3VB1IOE/Jh8v7fcSB7esslBic2cdFmO+a/FMVXJ0BPxP2syJCHcvL4JBWAmr+HSz1N23m1ucjSzjevsDDGFmBZYq66lWy9aJsV3XqyiqJg+/lNC6S1/H4lYCFu8fELPy8dca7hvx/NuBL4QJBHbZOuSgI0TV8HrijhlXftcbtaydb0pa5foc1m0Iv+Knhepk6H+RuzJ1iQ02v/nXclKoHWZkgCr2kf5alDN2fzhKOOEBYXeyMHRvB15VMrhS8qKscc7aDb0aqc7IQtNvXcLJvSog4Luwn/V3WpS4KBawyJS4f7S5yOGUx7nl+M1BwPza+1aTk/zojlIy5kmbPLs+EyzR+6FfgMsfGsVygv0p7JkW2fbB//qD0QT85Mn7Ho=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:19:52.5835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0088bad-515c-4c8d-98ec-08d6f56074d6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
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

