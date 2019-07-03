Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7CB5E316
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbfGCLsP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 07:48:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:24552 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbfGCLsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 07:48:15 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 07:48:14 EDT
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BXKa3029103;
        Wed, 3 Jul 2019 07:37:44 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tgk51gy10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 07:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utZtk5fMZ0Ttd9A9AVAAGyqFhuSTF5XdbESVP4n+UY8=;
 b=Oo5Bn75zlBTijWgWLIJA1qwE/bt7/C2R31bA0GopYY4eDN4/hT5F25zMZ/W211fsICnpQDb2gScmFNz9HEiQhDLtR+UdiukrJVtcxc63/Gz+K+FA8DFRFRqIEZ/JDoEJmzvBurw4d/2iU4tQLgn78YeaMhJiamfzLUzthxy0EpI=
Received: from MWHPR03CA0034.namprd03.prod.outlook.com (2603:10b6:301:3b::23)
 by MWHPR03MB3278.namprd03.prod.outlook.com (2603:10b6:301:42::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Wed, 3 Jul
 2019 11:37:41 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR03CA0034.outlook.office365.com
 (2603:10b6:301:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Wed, 3 Jul 2019 11:37:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Wed, 3 Jul 2019 11:37:41 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x63Bbftk016768
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 3 Jul 2019 04:37:41 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Jul 2019 07:37:40 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 5/5] iio: adc: ad7606: Add debug mode for ad7616
Date:   Wed, 3 Jul 2019 17:36:48 +0300
Message-ID: <20190703143648.24402-5-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703143648.24402-1-beniamin.bia@analog.com>
References: <20190703143648.24402-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(199004)(4326008)(70206006)(36756003)(70586007)(107886003)(486006)(126002)(478600001)(5660300002)(54906003)(72206003)(47776003)(2870700001)(6916009)(316002)(2906002)(44832011)(446003)(426003)(8676002)(5820100001)(106002)(50226002)(7696005)(23676004)(246002)(476003)(11346002)(2616005)(8936002)(26005)(7636002)(356004)(77096007)(305945005)(14444005)(336012)(186003)(76176011)(2351001)(86362001)(50466002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3278;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6842d580-4a8b-46e8-477c-08d6ffaadba8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR03MB3278;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3278:
X-Microsoft-Antispam-PRVS: <MWHPR03MB3278859A134E218140F5B7C4F0FB0@MWHPR03MB3278.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 00872B689F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bCQSexs1eH8QEuOz5T5P5VlFJHt12Wxg9rYTHKpLT9N1VmxKNY9kFEATU6KU6c3RQGr2nS0om43Xs5mFTcm8NMHn3qVm5vZqbxXlN+McyW3o7ElF9GxbIR1eoUE43PuJl4qk3kTvG0TsKM1WFFllKplbb0o9cMohX3mbJtSJ2y2ZnBks0SgrRQcuiQL28NeZcPOLGwsMwmOfjjqqp9+09U7Z11IHdknAk/RKZpElOzG9o2/JCTq1eLGvf4yVKj+wUAHl6GR90LpSP6hcKVL9OI5ENDVp1b2bWBi1ou8AlwBIlYpFJWd/2DLAmP4mnCzYB0IMvC6iAKtO+3J6+mpyhrHMDfKgmAFLl+3c4z3QwnjMzTY5/B6ha5z7qks/JqRH2TMwOj9Hx8Bkv6NtE3sPxCkyy0rwO4bCzu+McsZ4rl0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2019 11:37:41.3274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842d580-4a8b-46e8-477c-08d6ffaadba8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3278
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for register access was added for devices which have software
mode.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index be2330c8b277..ed2d08437e5d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -60,6 +60,29 @@ static int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
+static int ad7606_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval) {
+		ret = st->bops->reg_read(st, reg);
+		if (ret < 0)
+			goto err_unlock;
+		*readval = ret;
+		ret = 0;
+	} else {
+		ret = st->bops->reg_write(st, reg, writeval);
+	}
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels;
@@ -501,6 +524,14 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
+static const struct iio_info ad7606_info_os_range_and_debug = {
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.debugfs_reg_access = &ad7606_reg_access,
+	.attrs = &ad7606_attribute_group_os_and_range,
+	.validate_trigger = &ad7606_validate_trigger,
+};
+
 static const struct iio_info ad7606_info_os = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
@@ -617,7 +648,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 
 		/* After reset, in software mode, ±10 V is set by default */
 		memset32(st->range, 2, ARRAY_SIZE(st->range));
-		indio_dev->info = &ad7606_info_os_and_range;
+		indio_dev->info = &ad7606_info_os_range_and_debug;
 
 		ret = st->bops->sw_mode_config(indio_dev);
 		if (ret < 0)
-- 
2.17.1

