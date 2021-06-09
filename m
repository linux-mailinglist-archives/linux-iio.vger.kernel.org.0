Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0054A3A1DCD
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhFITkf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 15:40:35 -0400
Received: from mail-mw2nam12on2113.outbound.protection.outlook.com ([40.107.244.113]:31968
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhFITkf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 15:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtvEZZzxreFrxLjtn+PU/9dZrthwG2G+VJoqZYji27n9Ckqfb22POTSsF9ctqyB3aS9ndbDcVtR28qJHJ0rXRL/gVNXt5AFyB/EVxZR+87Mz61pDwwEQ5RcjlCa3w7MIubh4+4AGlhW41cVzzQ6pfEVwg3Tc5pvxBTlsPhpmzI8m5sk3kIFnWFEI7ryqnlGVOwhpUGvE/yg4g2cPRvheC8kmkDvKaHGLMb3e4kQQO0oZIHOooIuvmcNWj1N9gb1pvSkK8xRkTdd/Ho/EJPKyHtupoqtaU54Hmtm6YGbEPLxwnqMmBnDmoDWrQgXtCR1u4AKaFtabYfMiKvDJOIs1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc63O1d9EuIUiKmpTjLZ1vmfMurDC9RuOf7LNPNSHqM=;
 b=bxbP/Kkz2h9b6hHXFp5u6nMPiR3UFJy5lTxX5rPhU/r4KT6dIGCV0sWrx+Z+0mNQQ3wxRlBO3jObzBV/uiUPglo3jbDgDXleRG0+V/eTLhLfljvJMrPUtyOuBa9lVKUG8Q4KFwhORyt2kKecSMfbtx/U5iGC2oV6gxT6lMrNH1iodonzRSeQtruDZFzNvT6c4KU+EKqes8YmOo7RikpSPu3g8R1pjI532h9gcFqZVUUIHZ82MYem4pqNgFlweLfzBOzUHLsp430k5ORy2eolFJWIh9uOcH39T7GwA2NVZcIsHIz5ybSalUx6lkkNaRPWzI8AnA9anMRhEhKIvNca3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc63O1d9EuIUiKmpTjLZ1vmfMurDC9RuOf7LNPNSHqM=;
 b=uwQ3YTEzTqt+qdPmNh36EX5uwmXnH6Pi4AiyWrL2OEMuIgExmtkdau+zzUrh0V3sgv42a1KZqWuxQLJ1BHql4wOKjyPB83PpsLEj6UO4luBeKVD5P8dM/U+DVZyqVizd5KGUOOT32TeIwuMP40y6/yjOigWHzxBYIAX9due/LvM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=licor.com;
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21) by SN6PR08MB4879.namprd08.prod.outlook.com
 (2603:10b6:805:76::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 19:38:37 +0000
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::2429:8693:e618:f534]) by SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::2429:8693:e618:f534%6]) with mapi id 15.20.4219.022; Wed, 9 Jun 2021
 19:38:37 +0000
From:   Chris Lesiak <chris.lesiak@licor.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lesiak <chris.lesiak@licor.com>
Subject: [PATCH] iio: humidity: hdc100x: Add margin to the conversion time
Date:   Wed,  9 Jun 2021 14:37:48 -0500
Message-Id: <20210609193748.1709308-1-chris.lesiak@licor.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2607:da00:300:7::2]
X-ClientProxiedBy: PR1PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::18) To SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bee.local (2607:da00:300:7::2) by PR1PR01CA0005.eurprd01.prod.exchangelabs.com (2603:10a6:102::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 19:38:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d6984f-4767-44c4-a4ef-08d92b7e2d13
X-MS-TrafficTypeDiagnostic: SN6PR08MB4879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB4879E3B5867A0F703078AB769A369@SN6PR08MB4879.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zW3mJLLzeAAP8umm0q5imnRXDBSME1LWH/UZPQSTq6peKyaE9oAPpg7jM3QVWyE5V0vpQ++KsfDCQ8Jm3lyZXKCC5U6cKiX22UX18hiJy7HeFz+yncFQWTy7jRiGzpPjtgyRapxysZcOfXXT0M+FCsB/gHdC2K8cgPzE4NsLD/fmBJG6r/e4nqqAHl3sMBXV+cWSEftPcohcdA8tN8pWpfViHnQk16kOimpIPikfNPPmfmS1jHIAHR6vt/TgrqEh+c1FZF+oVWRAeXvKidyyV/Kmnulobd++moQXdR1SuUbpvdQzlj/Wu7f/4d/KZ/NlrQTwcRhb9YZV5PW03ghHqdoa+ISW1Znq/2veK5BjVV1zHgd6VRclS3SQXqQveDM0f1jDTdWo1wccYs+dFYtgTeL6mAZmgKu39lpFyUPOc1r40txFcSO0CSk75roGsCf0syvls8+7r1eknNEkYtmsr5Z6P7RLDn592e1aTIxG8VA3izb41oDKYqLmNJ0ZU8VyjwIVYsxknSfz/uUQYj3oh8XMu1lRv5dMV0RfOLc4SPXhmoi+dOmwqL5PkvfG8cExrwCiVxFgTVDEOqAmWn5y/fFtdFmrcn7vnT18vII5Qeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR0801MB2223.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39850400004)(366004)(346002)(6666004)(316002)(2906002)(6486002)(8676002)(6916009)(5660300002)(107886003)(52116002)(66946007)(66556008)(66476007)(38100700002)(83380400001)(1076003)(8936002)(478600001)(2616005)(36756003)(86362001)(4326008)(186003)(6512007)(6506007)(16526019)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9b/MXe8xLbXVjyixY2y2j05fJeL48JclqjKUnB7DYCZQra5P0NfSEwnjXauN?=
 =?us-ascii?Q?Tx36CGhn9xV57F6oT8qiIZifcIK15Y4S2+YnLtc5W6adcKdRaM999kj4mSsq?=
 =?us-ascii?Q?8QklEg6tPrLoNTtZ4xl7cbQIvjPjkl049MsAL1r6UmSRg2s8RD2JLE6cnOJX?=
 =?us-ascii?Q?w936/tr8zHf6bWmdBaN0V24H/XHXUqWht5kmPZdFazBFO4+lOGHqReuSuw/c?=
 =?us-ascii?Q?BbvyjRPawzqo9QODnIo++QDwQ4Ebm+UqYoRlFIwyLpEBlnXDwx15nNAAmn9N?=
 =?us-ascii?Q?WezHJ/0yprUeCCdEYKMpsVf/qnXpqoXZhqWdgPka1Zbsr2JG4sSWltzjHLWF?=
 =?us-ascii?Q?fjXP6tCqjk03cB5w9603k3w8eaZq8VsB6RIRWOUx/h/6H4b3JfzWerCQipLB?=
 =?us-ascii?Q?NjCB2pl8UiV55RVnVpNFBwzfEDltHMVKBFMrsuGX+yMsqqWH/P0x8IQPpWJf?=
 =?us-ascii?Q?5visuqFC4b4GwwXFpbAOrYll3oZ9lgWtaIpEFBZRLRhxBCtNzeB5QVIbBeUn?=
 =?us-ascii?Q?WAJiS3Z8J/KAhk/lXNty7KwG2kdziKExtaZ3McYzz4N/+WKzkBHqvzkBqSFl?=
 =?us-ascii?Q?uRzR8aRgivvJy7DWaFexmlExNGDzxeFtoec8ey9/z8gxqBntWBc2f/66s44S?=
 =?us-ascii?Q?X0jmlEIS40F6CF8N+n2/ZR3Du0iYLpp7m0sZzxCfB9MdsT8k9n+7X74UmRQ6?=
 =?us-ascii?Q?x2s4Cvqc6GV0pZwTq03LYqCyyqJGhEsdMbMK1nYRIlx3HXR7XJILu2k0N9Vp?=
 =?us-ascii?Q?RWRJWlJnndvi2Ey5Eb3odCYN383S8iCCmRVHfkLbdm1lXKmj+Pv34lUxBZbW?=
 =?us-ascii?Q?O4/CFjmFeUULUTwNhUvhhdVXEoU6O6wtRpFZ2VOIXMNblk4SFTV0mAb9ysIF?=
 =?us-ascii?Q?PAOzLob44yWHNHENm9V+PLCBPPNlj/j3zKHCvOTeddO0Lswu5tn0x0Tboe3y?=
 =?us-ascii?Q?/PvfjZ0RQthV8lSlhpLlLoJPqWNniqVAgjzQ8mWn6UTeq5N2PYlDEhCzAtDl?=
 =?us-ascii?Q?m90p/HBalowhhl49DBtLBq8YMkdN6a483M/yZ5X4+3c7Zc6L8je8GUM4rccJ?=
 =?us-ascii?Q?1A3lxTxLUzZWx95TiPSUwQOXI0+OZAoiOCVLOxoQAyrZxvYcU7cGeqTGquCY?=
 =?us-ascii?Q?dYGHOTzqCp/I1Mmkrb8A1UaM8jCrsEA/KBpxQMKRCQf9PEah61cZJDqPpKUB?=
 =?us-ascii?Q?ark6TcRwU0CIVPSKC5kIVwX/Si6vWPkTz3Un4RViKcbxHbm/goIAtaf1ZVKr?=
 =?us-ascii?Q?/uNhqbF9wyYG9iWXa3vMtCxKS/CjqImbFeql8/d1TgbHa7ZLsEILN6tgWvlE?=
 =?us-ascii?Q?h3sl4vW97y26+mDETQaqgb8VZUPRqbU8coZX8z7CyUmg+A=3D=3D?=
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d6984f-4767-44c4-a4ef-08d92b7e2d13
X-MS-Exchange-CrossTenant-AuthSource: SN2PR0801MB2223.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 19:38:37.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dJmRVGRFtaUAg6bdVVXKjIeREbzjf345mb0IXBJqxKoMTuzCtOs49LDqSAhiaVMi6nQ3oab4/PZ0wOXsYc5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4879
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The datasheets have the following note for the conversion time
specification: "This parameter is specified by design and/or
characterization and it is not tested in production."

Parts have been seen that require more time to do 14-bit conversions for
the relative humidity channel.  The result is ENXIO due to the address
phase of a transfer not getting an ACK.

Delay an additional 1 ms per conversion to allow for additional margin.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/iio/humidity/hdc100x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 2a957f19048e..91790aa8beeb 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -166,7 +166,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
 				   struct iio_chan_spec const *chan)
 {
 	struct i2c_client *client = data->client;
-	int delay = data->adc_int_us[chan->address];
+	int delay = data->adc_int_us[chan->address] + 1000;
 	int ret;
 	__be16 val;
 
@@ -316,7 +316,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	int delay = data->adc_int_us[0] + data->adc_int_us[1];
+	int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2000;
 	int ret;
 
 	/* dual read starts at temp register */
-- 
2.26.2

