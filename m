Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB99188773
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 15:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCQOZ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 10:25:26 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:10754 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQOZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 10:25:26 -0400
X-Greylist: delayed 1686 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 10:25:25 EDT
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HDdYPd016250;
        Tue, 17 Mar 2020 08:57:00 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-00010702.pphosted.com with ESMTP id 2yrv7yrgt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 08:57:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPiMz+yzhOzapvCK1oFAoonSIG3EF+gWkOUva9gsoQX0JNxMrqq+0vgIoCcQ7qZU6Gv9tsvihsmi3HlWuWdEkt5qrpgm2VivlmMU5BIkA0rszDAiiFyo92wDBcIh3aO8hLumQVHmhLoJYL5nPWgR/wSO+c+he7Jv3dzmtEce+v3fqGqy1UdHO2MfoDPhH5KZe5fL7BKOChHSpvPuVpX07t2xkr8JJziYhcPXc6U7l6XNUDWR5ZAluvXaGhfB9K6zW1yAVrptndQz5vrEfqpP/An7ClkeYbyid6uWW8t0R+oEVluxoO6rBdaIHPlx5/gEbVixvgwrJSpkv9pSnQ0D9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l5aLNEki9ZFpEdtjpTUKTOppPhOtJdsdsNw0WOwhoM=;
 b=KuUiUgQIgHqCCSPaovOUM3CLIm3KK7Weq8N3NHc4HMGxNZvG3RNvxnKllF/ELOA9h2jUvwzOL8nuPSugeaD0ACqqObpBPKvlxmck+6NDifrWwKYWRebIQMxVQF4c8DRVrngbdLiwR/CVMLqPjjb4GEnU0iWt8aYN73XZ+Yl8Xt4ZnHdNBWjbcalsjT4VFubW4MRGsHqLvKKnYccU/H8gtfeq2aNZciYOkPW0ZbChLzXbhMoZ2QPjNvVhnbGeJsTJL1EAYcL18sx8uL/lXucqpWsX3wr18huV4pG6AfXx74vOyG4CjkPZ1Pp20+qmwY/hL8B/+OvAVAIVkaYbxarnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l5aLNEki9ZFpEdtjpTUKTOppPhOtJdsdsNw0WOwhoM=;
 b=MLWJ9SsHva+R5fYrEkUl3PFeRBazKLyepjmuczT26ugytIPSnQwmiMpIAEvZbI/0yR8eU1QScHR8fedbTHZkI7QvzkiC8eVGmINSDPdU7kXrnMKVrJDq6Bd20Hcp06jugo1Zsor6eFrn4/XbhGfvc6hPH2dPhl68qnD8DRiejuw=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 17 Mar
 2020 13:56:59 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Tue, 17 Mar 2020
 13:56:59 +0000
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
Subject: [PATCH 1/2] iio: adc: ad7291: convert to device tree
Date:   Tue, 17 Mar 2020 08:56:48 -0500
Message-Id: <20200317135649.8876-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by SN4PR0401CA0034.namprd04.prod.outlook.com (2603:10b6:803:2a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 13:56:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84482265-6754-4f5e-e173-08d7ca7b0f97
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3567:|SN4PR0401MB3567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB356770C5794BF740806F457A87F60@SN4PR0401MB3567.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(6666004)(110136005)(2906002)(6512007)(186003)(66476007)(2616005)(956004)(44832011)(6506007)(5660300002)(478600001)(52116002)(4326008)(316002)(26005)(1076003)(7416002)(16526019)(66556008)(36756003)(81156014)(81166006)(8936002)(8676002)(6486002)(66946007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSKTuYIKTc1hCSGi6W8AeONFf3CqUn+1O3geajmsxiuVLnUOJP7Y/qLPWiIpbOje4kD0EgXMEfPWr7waPgpIka+ETGE9LGKzrekP617U/lrDw+qL0n1mv+DxTTdRzaTKmU2/55wqfBJM9Il3gH35CSePA1Ghs7Gvo0xvHwmF8nrmDZm3Ay4TQ1V4ET6KCmNB7knWNLXoUugFv4OmbVJ/smaMPMiN9l2zzZr4U05FlzgOaVCX5zCCFOTZIuMN9/NohznNBecKKOEPPxJis2I2nx+jQfaf/iUU26r7JcKJmT9VD8IMNSdEfBXzYxgvddOPnxuO55mNK2JeyubT0XewmrxnEEekBJAAh9Vlso4aiwclg5bQy7gSvfEH/lDCWxQdf8e8EfH338JjXAPW7Cu3ZsicPz8JPpXsWbvSjIEOP6pfArSawL8T3IMbQpxlTlUe
X-MS-Exchange-AntiSpam-MessageData: vH4EHDiME/INafscMrRJ1+7fw4DjPdKEoe1lFRh4Tc1QBHMsyvhzt6VQopewRT2rh4rElYbXAD979QtUe8KNgPBQ7vvx4DpOqeJ6LrzGLJ2cEmpBWCUp0urihReN7iNOA4gam1zaU/YRkiGlCSerYg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84482265-6754-4f5e-e173-08d7ca7b0f97
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:56:59.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6//nGCv0zCSVpwcTp5lXz64AyRy8JNOQZYZIbymZ9iLw16AKmPU/QC1Spx1KvD1S6A2AXwx2jnI9fp/gfc/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003170060
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are no in-tree users of the platform data for this driver, so
remove it and convert the driver to use device tree instead.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/iio/adc/ad7291.c             | 33 ++++++++++++++++------------
 include/linux/platform_data/ad7291.h | 13 -----------
 2 files changed, 19 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/platform_data/ad7291.h

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index b2b137fed246..536e31862309 100644
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
+	if (IS_ERR(chip->reg)) {
+		if (PTR_ERR(chip->reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		chip->reg = NULL;
+	} else {
+		ret = regulator_enable(chip->reg);
+		if (ret)
+			return ret;
+
 		chip->command |= AD7291_EXT_REF;
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

