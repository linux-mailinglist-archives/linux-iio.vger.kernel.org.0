Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5558018880D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQOv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 10:51:56 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:5010 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgCQOv4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 10:51:56 -0400
X-Greylist: delayed 3268 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 10:51:55 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HEoABv023470;
        Tue, 17 Mar 2020 09:51:36 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00010702.pphosted.com with ESMTP id 2yrua11uk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 09:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR3MkPuYZW5PwF2xQQS3SJ6VOKFOlKvEBZfThgHuZdNMJCys0u4QfBkWMoVUsd985LbXiRh24zeYECzm5zNaTn3j45Ovh5TggLJv8ZKLUbtjpHIfIGzBDzPlVR9HYdcDr+unw5Ec/PSKtWYZ5B1SEzUoJeNsVGPMIHKTW+WoHSpsbTsNX8C8bm1t5ycvGysqwl0k/ohApAg31GELHFaezDX/7X6jUnSt+GTSiszISNR8B4jx7MENBmHaRBKDrZ1p8vWBYlT3JItDx2PUAX3Age71mRFJH4KjPOW/LBcBToWillKZfuTtCFCm2M5G3W7Jfxw4uIRsuG2uoRIGfIdn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5W2HDrk2IjnjnOoDhTwztdvEVEjrdwsyLjkXmhZJ8c=;
 b=oL8Qgx4T2xCqpqDBsewb79PPSwlfsDFKja6+9SQKRfTzaEhGW+YHsUH4XL2LfbUVOADKaFHpPF39mZy51GcrutxsNT2PeX8FDr5m0c4x3r7r6kWqjBrgVY82ayFTK69aGzhWQ91+9uY+gxF2pxoro0rccfN0yr8/GG3cqhwmq0kOO3hA8Y+4TZMBdArnKgRPF5Oc5itIsh1h0aACfM1JI3svIKgkU2Rhb8CDBXzJlK326dAkP+0Hu9YcWYbDO3ORImmzkcTwHfhcAcQBG+tkVI2M8oSmsv5VZlgFOANfyGFXAYyB/8kIr+1SaxxC/IIYD61MSlxUG/WjrLVA+Nkj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5W2HDrk2IjnjnOoDhTwztdvEVEjrdwsyLjkXmhZJ8c=;
 b=WW7VJ3eL+3i8hAZc+ettaSX0WjiuLCCjCUcKq722elwDQlrgCn7o6OSQiEv+1JuRpIJW0EFY3gEOqiJOL0T6MgpL1rg2JVJ6r1Bj4ZBtxuBmBNfgPjy0eWmVuKZA20Epd+exjj2bVMovBShPCkDctyobbXTWQ5eazqHN53Snmzc=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 17 Mar
 2020 14:51:34 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Tue, 17 Mar 2020
 14:51:34 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
Date:   Tue, 17 Mar 2020 09:51:12 -0500
Message-Id: <20200317145113.12413-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317135649.8876-1-michael.auchter@ni.com>
References: <20200317135649.8876-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:3:115::17) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by DM5PR11CA0007.namprd11.prod.outlook.com (2603:10b6:3:115::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 14:51:33 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74ddfd8-afd9-4672-e3ca-08d7ca82afbe
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3519:|SN4PR0401MB3519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3519E966B420B1F8152C4B4C87F60@SN4PR0401MB3519.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(4326008)(110136005)(7416002)(478600001)(81156014)(6666004)(6486002)(2906002)(16526019)(186003)(36756003)(26005)(956004)(316002)(8936002)(44832011)(66946007)(86362001)(1076003)(5660300002)(6506007)(8676002)(52116002)(6512007)(81166006)(2616005)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3519;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7D3/Evm8b9D2pt0yKyCRhEQHlJSQ6Pi+E9VW9YxSsfVcsQEezjViNkg1VLHCciN2tXWJK8UQ5oaZkU3s5UPAq3mSN5BKK/B81foFxPRbTDuE4gLBNQACjuyqQX8g2hcFo5o5eUSNf4kWwmTzhkzWQiGGWhr9Mk1DSCzm7LEWF8dyFPDqwLXcjh5xh9/7WAIS68FF8Ei8AgKA5dg6t1wBi2WJlDxanJcrfAc4GPmFp5h3QulKiMbNAEYSQBK7roxZH6d8X/5xPMsk0ScInTgphCr2kajel64zt6arRGJvqTA+F3vKnWGgunBvRRDY7JeRvme4mlKqeL8Aqgt14vubZ0YPim36YjGvVrIGoApJOR8/wq2RCykm9cf6pA7VbIR4ENGaHn3VdB3yc8RdNyGLPmLarWQ5BffZ4idIlxHrj0UeCp1NT4R9MUyFfKmttgp
X-MS-Exchange-AntiSpam-MessageData: /iiB0i3VAY2+Fc6psmX3MO2ZC2U4R1nDP/gfyhbECj7s6MlLiCCmHUrX0yHbtLVd9moV1DgruHgZbo1QGjDqOp0rbZalJ2oK3L4wwPpdhEFAXZCIN21+f0ogFSZEhYeaLaURs0keNeZvxiKzDy/kBQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74ddfd8-afd9-4672-e3ca-08d7ca82afbe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 14:51:34.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzpekQKYxx09uq3UuJRZZJsX7dnAPdKxAhSJ+B8q0QmzbuFiLbQk74tqVPxf93Vzu/IsyV1CZjRmfdvyOX9VCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_06:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003170062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are no in-tree users of the platform data for this driver, so
remove it and convert the driver to use device tree instead.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---

Changes since v1:
- Fix regulator handling as suggested by Lars

 drivers/iio/adc/ad7291.c             | 33 ++++++++++++++++------------
 include/linux/platform_data/ad7291.h | 13 -----------
 2 files changed, 19 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/platform_data/ad7291.h

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index b2b137fed246..43a201fb4f34 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -20,8 +20,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 
-#include <linux/platform_data/ad7291.h>
-
 /*
  * Simplified handling
  *
@@ -465,7 +463,6 @@ static const struct iio_info ad7291_info = {
 static int ad7291_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	struct ad7291_platform_data *pdata = client->dev.platform_data;
 	struct ad7291_chip_info *chip;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -475,16 +472,6 @@ static int ad7291_probe(struct i2c_client *client,
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 
-	if (pdata && pdata->use_external_ref) {
-		chip->reg = devm_regulator_get(&client->dev, "vref");
-		if (IS_ERR(chip->reg))
-			return PTR_ERR(chip->reg);
-
-		ret = regulator_enable(chip->reg);
-		if (ret)
-			return ret;
-	}
-
 	mutex_init(&chip->state_lock);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
@@ -495,8 +482,19 @@ static int ad7291_probe(struct i2c_client *client,
 			AD7291_T_SENSE_MASK | /* Tsense always enabled */
 			AD7291_ALERT_POLARITY; /* set irq polarity low level */
 
-	if (pdata && pdata->use_external_ref)
+	chip->reg = devm_regulator_get_optional(&client->dev, "vref");
+	if (!IS_ERR(chip->reg)) {
+		ret = regulator_enable(chip->reg);
+		if (ret)
+			return ret;
+
 		chip->command |= AD7291_EXT_REF;
+	} else {
+		if (PTR_ERR(chip->reg) != -ENODEV)
+			return PTR_ERR(chip->reg);
+
+		chip->reg = NULL;
+	}
 
 	indio_dev->name = id->name;
 	indio_dev->channels = ad7291_channels;
@@ -569,9 +567,16 @@ static const struct i2c_device_id ad7291_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad7291_id);
 
+static const struct of_device_id ad7291_of_match[] = {
+	{ .compatible = "adi,ad7291", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad7291_of_match);
+
 static struct i2c_driver ad7291_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(ad7291_of_match),
 	},
 	.probe = ad7291_probe,
 	.remove = ad7291_remove,
diff --git a/include/linux/platform_data/ad7291.h b/include/linux/platform_data/ad7291.h
deleted file mode 100644
index b1fd1530c9a5..000000000000
--- a/include/linux/platform_data/ad7291.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __IIO_AD7291_H__
-#define __IIO_AD7291_H__
-
-/**
- * struct ad7291_platform_data - AD7291 platform data
- * @use_external_ref: Whether to use an external or internal reference voltage
- */
-struct ad7291_platform_data {
-	bool use_external_ref;
-};
-
-#endif
-- 
2.24.1

