Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F650442
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfFXIJq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 04:09:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30298 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbfFXIJq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 04:09:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O88SMH006110;
        Mon, 24 Jun 2019 04:09:25 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63cwwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 04:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNZ3hPJROK9jkkVwQhmEw11XkqP4EWF11iSxK1IAjlQ=;
 b=tw8MfGam/6Yb+8Cu0nJk2FhDcj51kB1JiHvuhriLZkxF76y3KQtKvIG210NZh169fquupPNY093Swrh+EJC4JG8qcK55yKtFS6SUQTI0yTraZ+v5UJut7gp9rvHzY4C4etOoXa+kt8W1ZPON8AVzkjB/mblISgHDrRSVO8SfErc=
Received: from BN6PR03CA0118.namprd03.prod.outlook.com (2603:10b6:404:10::32)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun
 2019 08:09:23 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR03CA0118.outlook.office365.com
 (2603:10b6:404:10::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Mon, 24 Jun 2019 08:09:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 08:09:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5O89Kba019170
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 01:09:20 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 24 Jun 2019 04:09:19 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 3/5] iio: adc: ad7124: Shift to dynamic allocation for channel configuration
Date:   Mon, 24 Jun 2019 11:08:43 +0300
Message-ID: <20190624080845.18537-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624080845.18537-1-mircea.caprioru@analog.com>
References: <20190624080845.18537-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(136003)(346002)(2980300002)(54534003)(199004)(189003)(246002)(11346002)(86362001)(50226002)(77096007)(186003)(6916009)(16586007)(72206003)(356004)(26005)(14444005)(54906003)(8676002)(1076003)(478600001)(8936002)(76176011)(2351001)(4326008)(50466002)(51416003)(7696005)(316002)(2616005)(5660300002)(336012)(48376002)(6666004)(106002)(446003)(47776003)(70586007)(44832011)(7636002)(305945005)(2906002)(36756003)(107886003)(126002)(486006)(476003)(426003)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9538ba3-1261-4e97-1620-08d6f87b4399
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR03MB553;
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Antispam-PRVS: <BY2PR03MB553C3A5E8D25F42BFCDD01981E00@BY2PR03MB553.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YHmSvMJ97rxg7J/th8r1MNT6x7z6W9palsywznJvITwBFlFzaZyVX8ioY4dQjnMO1hDc9zwBu0Y2/BPF+WzERtWLdaQenPOv6BagTeU11lTpt2wxOI9p0B8P1Jl4KtFxgUlVTEbGlV5KHKtQ++c7miNN5VQEdVuvr0fSEqKa5yfU/cRyhu00Jh/L11B6yUZZa1m1rGo96TvrWERmOgdGzybxkS1sqcdf0iKaQJtRRjC2LRTZ3mRjx4qH+vTejNfOqMNyKI2g0koILrouQrC5ofPKNmEeBMBb4oRHsuwsmdnBlEu4tbb2FJ/z2jFmWyHaHyIeJ/cVerenO8ifhYneb+KjV0oAzEqmk8v/V1ptMbg9lRBpA+uHZ3KURnyR1aEqD5cesPFXfIViuZnARchXTOTnsBZ4dPM1qJxK96bxuKw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 08:09:21.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9538ba3-1261-4e97-1620-08d6f87b4399
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240068
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

Changelog v2:
- nothing changed here

Changelog v3:
- nothing changed here

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

