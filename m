Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C678CCDD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfHNHci (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 03:32:38 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:58394 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfHNHci (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Aug 2019 03:32:38 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7E7RwXj010368;
        Wed, 14 Aug 2019 03:32:16 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ucbuvrbwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 03:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8qqLQAYYjrRH57TXFqUR8gBdcgwT4sP+MRsSK0jqYQaG5aS/BwGKkK95laHuQOocqYVsHDBxgt5mMVWmYjI1SGPCedG1zhecm4bLgDD6fXUI4aCrsIvexdGSVnN2MJNkJSus+mQcYgQECiKhaB/W+9mQmFCYNVhsqdazuyHo6ba7y7sA6D7Df2eoJW6Wf4FScGTZGMdA6YVr6HhgQqWr60J+hpAE1FLK3G9ZSR40JI8JNc/120EeD0qcVUDeuECt5A4JVmdwSqCtW6bjHSWPDa0LGSKdRjlSNRrWf1IOewBR+Z/+7/t4XqY33tuc2u62HpJRpQJdrKoDdR8FYxijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErXO7WAdpxp6yer5aS/G/KdoOXzKkjRCRuy5C2SzKMY=;
 b=Cdi8dP5C9gfMfqwC7pUOE+BHyVmZ6hxFN99VnWteVXMV74HRNhzl0UyVLyeI2kVC40DhUZheRwFpgKAz9XuRJMskF6frhFjh+Q9h8ubQaRzFb82crr0+lF8q8xLTakstf2Lgau3AGdhQKsbBIGxtJt6ZpXyrcBHlllKWKP6a+X5LeyQqELw0IafF07uocX6Tts+d2mFESBeQ0mjwHmsj0o8/gh7C7gIPXMOVXWL2CABmFrFWZhufWQusuhds3SfMF59EXifVeeV8oudozFePocD4jxUUN9Avt/KQKnlF5VCedtLt9gBkD8afMQ/pBB9BUMRz625uzXLsRT7OhyJoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErXO7WAdpxp6yer5aS/G/KdoOXzKkjRCRuy5C2SzKMY=;
 b=iFQuvSQZMC7mkLOCZcdQrTOYMNX/qro/dcn4fZbjrf+Tfwb/zJrlAaWyDW1Rutsr/eALuIjrZJdbkFTLD4Ik7e3XaOU9huOPZ6ufANKxr5L1qcvSo/WFtEdgB+gX2+E/sF2+f+lz9LlVrg/7mf0YvPLcA6Sp+VykJXoNR6UgLXs=
Received: from DM3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:0:50::33) by
 BN6PR03MB3379.namprd03.prod.outlook.com (2603:10b6:405:40::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 07:32:09 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by DM3PR03CA0023.outlook.office365.com
 (2603:10b6:0:50::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18 via Frontend
 Transport; Wed, 14 Aug 2019 07:32:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 14 Aug 2019 07:32:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7E7W89b020968
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 14 Aug 2019 00:32:08 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Aug 2019 03:32:07 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 3/4] staging: iio: adc: ad7192: Add system calibration support
Date:   Wed, 14 Aug 2019 10:31:49 +0300
Message-ID: <20190814073150.4602-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814073150.4602-1-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(54534003)(189003)(199004)(106002)(7696005)(54906003)(7636002)(50226002)(246002)(70206006)(107886003)(478600001)(305945005)(70586007)(51416003)(76176011)(8936002)(14444005)(48376002)(4326008)(50466002)(86362001)(16586007)(2906002)(8676002)(426003)(446003)(44832011)(486006)(5660300002)(186003)(316002)(36756003)(11346002)(47776003)(356004)(6666004)(126002)(1076003)(476003)(2616005)(6916009)(2351001)(26005)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3379;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4b7c58-ccf9-43d8-5089-08d7208983bb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN6PR03MB3379;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3379:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3379437D1E80D0B8E75DDE3B81AD0@BN6PR03MB3379.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: szabSO9Lp0irtMRNYbIEodM5ysj7Af6CeiR/OQKxAXLZLMN5Y1hxJeHCJLuiW+0yrp2AfP4UZYID1D+lfu4j/xPiHb8W4v9oY62+Ujym5KWTYlp5MSdJMcur456I5JtajOPBhM5MoQIiLQ8e3m6Yhi2uub1gvHEW1eDphHG2/WUEbgcTqLbtgHnCFBjYE/5yB3+aaAHqElCgEjedhiqfZztLf1eJx7i+/wPvbgxovmi99rZ2KPQhS98Gze+DrxIiXWKd7RJcdyZLe8+9Mpo/jfD2nIfaXQfpSkkBsF9E+RM9IR2gtPkOFfLFJlCTKVKDfXjYD9GwAoOzSD5X2h+Divuh2GzhXex4O6of76f9MH6jwll22GgZYIZBDWRbqnHeIR6S/ZGXlcBGYgsTw3gYgaFRN816wPZFNU94y+TrNLE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 07:32:08.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4b7c58-ccf9-43d8-5089-08d7208983bb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3379
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch will add a system calibration attribute for each channel. Using
this option the user will have the ability to calibrate each channel for
zero scale and full scale. It uses the iio_chan_spec_ext_info and IIO_ENUM
to implement the functionality.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- no changes here

Changelog V3:
- no changes here

 drivers/staging/iio/adc/ad7192.c | 55 +++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d58ce08f3693..731072830f30 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -155,6 +155,11 @@
  * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
  */
 
+enum {
+   AD7192_SYSCALIB_ZERO_SCALE,
+   AD7192_SYSCALIB_FULL_SCALE,
+};
+
 struct ad7192_state {
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
@@ -169,10 +174,56 @@ struct ad7192_state {
 	u8				devid;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
+	u8				syscalib_mode[8];
 
 	struct ad_sigma_delta		sd;
 };
 
+static const char * const ad7192_syscalib_modes[] = {
+	[AD7192_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7192_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7192_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->syscalib_mode[chan->channel] = mode;
+
+	if (mode == AD7192_SYSCALIB_ZERO_SCALE)
+		ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_ZERO,
+				      chan->address);
+	else
+		ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_FULL,
+				      chan->address);
+
+	return ret;
+}
+
+static int ad7192_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+
+	return st->syscalib_mode[chan->channel];
+}
+
+static const struct iio_enum ad7192_syscalib_mode_enum = {
+	.items = ad7192_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7192_syscalib_modes),
+	.set = ad7192_set_syscalib_mode,
+	.get = ad7192_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
+	IIO_ENUM("system_calibration", IIO_SEPARATE, &ad7192_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("system_calibration", &ad7192_syscalib_mode_enum),
+	{}
+};
+
 static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
 {
 	return container_of(sd, struct ad7192_state, sd);
@@ -769,9 +820,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 		*chan = channels[i];
 		chan->info_mask_shared_by_all |=
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
-		if (chan->type != IIO_TEMP)
+		if (chan->type != IIO_TEMP) {
 			chan->info_mask_shared_by_type_available |=
 				BIT(IIO_CHAN_INFO_SCALE);
+			chan->ext_info = ad7192_calibsys_ext_info;
+		}
 		chan++;
 	}
 
-- 
2.17.1

