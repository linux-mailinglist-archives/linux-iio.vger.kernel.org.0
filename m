Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C82744C7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIVOzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 10:55:38 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:64350 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVOzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 10:55:38 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 10:55:36 EDT
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08MEd0XZ005740;
        Tue, 22 Sep 2020 09:46:05 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by mx0b-00010702.pphosted.com with ESMTP id 33ney16nxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:46:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejCLUi6HysN6drUlKyDcXb5XsuHYl1h6yksLm+nr/ePtiIqugMXOhxIvpwR+1BabOKkWSvWpogDY4bM2HVeAfJK0ZyHn629L4TMF7eQXTHGYaniVsc2BYiCPtTHkY86jj6pyQ3+jGhHrh42RRzjWLX9obKFOYj1Yi1eGwwA+x8ovAAqDzqak+9mlRDYteLfgvauUty8AoLwST0P0ZYf2IXAqbRsll3PH/+aEZ8JdA3CeAVuuOTp5ujCdOn9QnNNGIRIdFm0frtuJXGFdp8xNK9kOuRpCx1kWA6bjJukRmCbzA23vYbcOuc1DtO/+Q4DoyGdoahV46uyFl5uxXZj1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSwRI9NXEpwht8N+WxOxPL31mFvWdruoCXXS6x65RkA=;
 b=LaSGlepwH2mxSoFaiAkwzMQujfsC/xCvtm2yTIEX/zbqncTiz9QSl1xr2NR5B/WK2TEWAYJzxixga2R0z7yndwtfLdRwQqcwyYJnZz/tfrNu1LUJVEJiFwkAM3YyQkqlnnYKQ/KWBZvHGNj5knusU6hFBCARbMKQX5V02/ehmv1eGe/lcM2vYwfHnqB1QTjsQFSokyEpAQ/mejQFw9cAKSAKe/0Rvtw2ENVQOrKqREl46ZbZMwxibgJ4iEEjv3ypUYLiTV4w1jiGqsO0WQWQYt/zAXZQ0Nr8mHSSxw+RE5+7hhuCMtostmBcgK1imFJqdz86ry9cHJjDQKgE7Qa5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSwRI9NXEpwht8N+WxOxPL31mFvWdruoCXXS6x65RkA=;
 b=h7mqv4X9ARxxNVIro+y6C/gVtnFo3aikaQZFhwJEfJU6PC44TQGPs9dkVshXJr0DvUNdJZ64yViWOF34LnPaFwsDH1k8cXDKYwn93m3pChdfxFRhk2NR7qRIa1zjT9au1l5MJJKCKDh0Lxhm2P9ucksxiC7KHqaE1V/JAbdyZzw=
Authentication-Results: rocketlab.co.nz; dkim=none (message not signed)
 header.d=none;rocketlab.co.nz; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB3856.namprd04.prod.outlook.com
 (2603:10b6:805:3f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 14:46:01 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Tue, 22 Sep 2020
 14:46:00 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     j.lamorie@rocketlab.co.nz, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: adc: ad7291: convert to device tree
Date:   Tue, 22 Sep 2020 09:44:20 -0500
Message-Id: <20200922144422.542669-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:3:13d::17) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by DM5PR20CA0031.namprd20.prod.outlook.com (2603:10b6:3:13d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 14:45:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 496bfa97-8ea5-41d1-8a73-08d85f06390e
X-MS-TrafficTypeDiagnostic: SN6PR04MB3856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB3856BBF9E6BFD9A2290E688C873B0@SN6PR04MB3856.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVTmePTM7ZoBJDuACfTbCJLRgDMniJki2JPP895wln1YyRKdMkUFogs9exsGjV1LECYPqUOZUbpER5ojC2YDeCZi3VVD6xAN5cYj3cR3abjwgbx2UDQnnaMabnXu2lKOE9fgT5tzdL7yDhrKTJudBux+WjP8cS8quKdn7AcJZTZCpXFmSUahgRtW/Y9eiR22g1k0VgSFNWeEdN/NpRifQEWtQxh40m26RTxdWVujs9hyF3vCGgEiDvVxUNypM9pEKVt+VAMs6ecxX39Qd5c4B1DdI6lmz1JCKQvivNqqpLdbSsaMQLEdJc1hnKeYnsXaAzjwe98LMKC+2/RBm7SV7ZTPuhXtiqncew8cqr8/PmHausb7uuagL6vGc0DPiDzO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(478600001)(6512007)(186003)(16526019)(66946007)(2906002)(1076003)(6486002)(86362001)(66476007)(66556008)(6666004)(36756003)(5660300002)(316002)(8676002)(8936002)(4326008)(110136005)(44832011)(2616005)(83380400001)(69590400008)(52116002)(7416002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: C6U9Gaygz2JhNDaUeEabN8TjGkFKJq9QTR6ftozMgOwTJ2vPDGz8NO+pjwj4LVmtaNs/bbUnf8qq8yIdODGdIzAo7oPhTiqcRPOAh84zphQTHe3DEPs2qwPHBMG9WcX89DufC1BbZb6VIvhr8EJLfadICWvzuSUCadK1Hx7DdfOWDc9SLS9Vym2WKSnyErSGQuoiaf9U0LCBar/1/8rd9JJ5TtWpgcvyx0go+QPUGA1+sT5O1VyaRA3WYBIKHC5ebTGwmOmmLxv80RtWTnEC01RBTDkKq1+POEEOGfa6qxhhOCABDob+P6n6xuM3q8p+EemFw16KbPR4XS+Dly0KV/TAV3edznVx6+gOZRdJ4eAQK558NfbW9frAVVfSf5rWInNQPcivM0bUAAyIdjJQTS8sURnCozyLfx5qJjDGUO3+CJLcn/Kj60HCeoRGCkfYi3VArI1pcntUWkdKdVq1irQqGHk1rgFXFlK1Bw0ojcfFDkJYsPvTbhmvWexMZeRdZtPf/9MO9HVhxCRZdp/7u7pyWWGXXvMoA4WH2Xlt6XCxbb7nE5fpGMKJ8tRkWqqFmm5BmFCcKDvTKt5KlHldZdNIGy2bGvHbwuYhradydydJbIj5Dzw/98Y1YxA4kz8MWTOQz98DXBhAovoQfyHcAOeGC+9cknocvSn94YNxSvgaqi7U3SNqS8r/8VpMo0cbQjDaHO1lzojG8qZyefCa5g==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496bfa97-8ea5-41d1-8a73-08d85f06390e
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 14:46:00.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PLANbNg+PoVPJBTh6vrRtPV0rU3RYX9jVHDrFf/7Y1hR+EaFl3IboCasRHtWPrIthqlfslDkc+aCgyTzdF7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3856
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_13:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1011
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are no in-tree users of the platform data for this driver, so
remove it and convert the driver to use device tree instead.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>

---
Changes since v1:
- Fix regulator handling as suggested by Lars
v2:
- use positive conditional for regulator error path
- drop of_match_ptr
- drop trailing comma

 drivers/iio/adc/ad7291.c             | 35 +++++++++++++++++-----------
 include/linux/platform_data/ad7291.h | 13 -----------
 2 files changed, 21 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/platform_data/ad7291.h

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index 62fde2aad282..2301a0e27f23 100644
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
@@ -495,8 +482,21 @@ static int ad7291_probe(struct i2c_client *client,
 			AD7291_T_SENSE_MASK | /* Tsense always enabled */
 			AD7291_ALERT_POLARITY; /* set irq polarity low level */
 
-	if (pdata && pdata->use_external_ref)
+	chip->reg = devm_regulator_get_optional(&client->dev, "vref");
+	if (IS_ERR(chip->reg)) {
+		if (PTR_ERR(chip->reg) != -ENODEV)
+			return PTR_ERR(chip->reg);
+
+		chip->reg = NULL;
+	}
+
+	if (chip->reg) {
+		ret = regulator_enable(chip->reg);
+		if (ret)
+			return ret;
+
 		chip->command |= AD7291_EXT_REF;
+	}
 
 	indio_dev->name = id->name;
 	indio_dev->channels = ad7291_channels;
@@ -567,9 +567,16 @@ static const struct i2c_device_id ad7291_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad7291_id);
 
+static const struct of_device_id ad7291_of_match[] = {
+	{ .compatible = "adi,ad7291" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad7291_of_match);
+
 static struct i2c_driver ad7291_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = ad7291_of_match,
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
2.25.1

