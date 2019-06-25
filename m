Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4C52627
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfFYIMZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 04:12:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5932 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbfFYIMZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 04:12:25 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P87txm022170;
        Tue, 25 Jun 2019 04:12:04 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63g85y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 04:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfMF0bTr1uCshOEzYslamgRBa7qV8j7sOataMtvUWfA=;
 b=O/a50P3SIhgzx0ZsWS6f9vymK5uGt4Rf61YMNeNxoxo7Qzegu+2J2/S8MUCnhBPP9t9hz3RhENaoHrQI25fyJFcHC83U9HwF6WWWZ4LAR5zJQ1FqsRw0kQkiX1EBcpHU9T+XNfSQBMSCP1TV8/hj6XpXfZt1HPlqjtZXT7NVfZQ=
Received: from CY4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:903:33::31)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 08:12:02 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR03CA0021.outlook.office365.com
 (2603:10b6:903:33::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 08:12:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 08:12:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5P8C0oJ022699
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 01:12:00 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 04:12:00 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 3/5] iio: adc: ad7124: Shift to dynamic allocation for channel configuration
Date:   Tue, 25 Jun 2019 11:11:26 +0300
Message-ID: <20190625081128.22190-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625081128.22190-1-mircea.caprioru@analog.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(54534003)(7636002)(7696005)(77096007)(305945005)(246002)(186003)(14444005)(26005)(6666004)(107886003)(70206006)(16586007)(51416003)(6916009)(106002)(70586007)(316002)(356004)(36756003)(54906003)(86362001)(2906002)(8676002)(5660300002)(2351001)(8936002)(126002)(76176011)(47776003)(2616005)(476003)(11346002)(486006)(336012)(50466002)(50226002)(426003)(478600001)(44832011)(446003)(48376002)(4326008)(1076003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b71cc4-4757-4b74-2def-08d6f944cd5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB545A70049F21A8D83AE10DD81E30@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RLYfKWisgi/FKzqaPe4yU+VvuWV1zYEi2WMAYR7SaBHyqPMMt68mCWyCgCCzOMsa08ByboycRTbcxc+JzZ43fiTU7h/jcFAjmuXTWrjBjL43R32nTVzlVT6DdyW+a5EZgx3hVBvapW80LJ4IMHZYSw6w7HUV0QLPlLRiVp9yUX+x1SEctBYTeW3YZQXclDgc+D8vSTDcb/9xjvkw9yi02oxjBoKofQs7uSAUJYxsGUyJT9DTfMppXEKfUrxMcs9CiNSkLQDolVVepERmwbeGO9zT1eQcytjdAsycElnDdrbz9vKkJVvv/wBGtxAdAeevS2d6P45tOOKrL+q5Ep89fnWQ3iRjf7x6ffUYBMyE1zvXikfdLIldy8aMIvhwqRWJgOpWFnaC26uMJQM4IkTB4x9FZBHlO+vM52wG3NUAgTw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 08:12:01.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b71cc4-4757-4b74-2def-08d6f944cd5c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250067
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

Changelog v4:
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

