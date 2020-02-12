Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5694315AEE9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLRlY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:24 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:52522 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLRlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:23 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwnX003955;
        Wed, 12 Feb 2020 09:41:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=hLl3QPIq8SlVoRBagJpbEy83IJ5j7nGjeIIwQjYLbv4=;
 b=u+hrIzav6T29LSN/hfmXhLSv1p//QxQAO/l4YFqQJgj79r82ofVcFg/NwKEDuDnTy85w
 Ckrp2vaC5AdSUjqZw8/mfLUJft/EYLixs5uw61WTQUH9T1hdF1v9cJqX2fZ+afvo3uJU
 b/2yoDulvzVEEA+EyTMd+o9rRTU1alwFxzru3pfZWlVJtSR4+Fpx/7Ac7jgRgqq0EMjH
 kvBx6noz6ASS58VE0jKL6V5h1YyIGgG2eCRGn0Zm5BDW755mV4H683ZE/ycF7IwyHj9R
 R1iVTcG7v7KkCG5mna+BBzYiaJxS8+1m6GVVUvyLE5JmZI0CvTfHtRE8qfSXVUsge8Jm XA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK7q5qalEomsh6sZf2SBiHCGSqg+fUthx1Oxs3qqI3AhC1hI071uujDa5oyFkL2a6xIYMh5iHW/gO1ozs2Eg+xRhyzVLgou7vjWom83dZm1/MNJBf98QtbHyXTv9H/CpXtCro+aFHsC9YacI4NSGebeODX14Tulu12Jd6aQkrDfFpoLKbOLz9dULxHlBw5YDFYwlbgS3DrI+OdNQI4HIDYZqXRaVKBmB0X9BOydZ27wrJ9ZeA5kcon8vU9Gb/4WyEeAuR6tfVGlgduFe4ReSuo+oDFIrbrLWG3cGVtwVZu9bniRuZ+oAqGdfBGo+IiaT1cVbb7Eg8ovXrd+HH8jlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLl3QPIq8SlVoRBagJpbEy83IJ5j7nGjeIIwQjYLbv4=;
 b=eLQB7FZ747rnUejXIzT3L//bUgRuDsHzGeYIH48nfxxTqoqDsEchcKGAjXsDuMB4J4Uv+MSrgbVX1VKeJ1jI8rsF46izdSgwEuSDtQboVGwIx0WzesivSWGKWDp52zVw0GZ7XqNo/4r1b1F9ZqUa16ElR/CFck3YNaSrYRkoy5gEEo0DR2nTV49u6mZUUK6W4B3iwNs3FXWZA+nGKyWLmXyWoO8mivfrmUUDIQRdpQldQUoOWwcso52X1X6i4lrpUvahFuCBglmacT63JQl4tc+Zqg7z7V+/ykcq6Nx79RE3yAESLm9oqUpLqTbwBrPKZHn9gazznvZk3Z1D6VkV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLl3QPIq8SlVoRBagJpbEy83IJ5j7nGjeIIwQjYLbv4=;
 b=XvmrayjaHhhE3n7HyPmii0gLV2R203GVD73R3bmsihI2kTkKR+ac+e4rFVjqm/l1qQwC8YT9A4oY4E1Z0x+Jr7QM2LhGVgEO44XpXH2U29XJpvhfTwHE7cUTIOLUU3MK94jL1Onwh2ye7vTiYeuYFmybQnh/bvNH4VLWjSSwUQk=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3925.namprd12.prod.outlook.com (52.132.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 12 Feb 2020 17:41:19 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:18 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass only once
Date:   Wed, 12 Feb 2020 18:40:36 +0100
Message-Id: <20200212174048.1034-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff438a7c-0598-43fd-6c37-08d7afe2c3a2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925A3F8B9F73DF2B4FC28D6C41B0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(26005)(36756003)(478600001)(66946007)(4326008)(186003)(66476007)(66556008)(107886003)(5660300002)(16526019)(52116002)(7696005)(956004)(8936002)(2906002)(86362001)(316002)(81166006)(2616005)(81156014)(8676002)(1076003)(6486002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3925;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vrC+5bF7fDjRfprGjETmHpkzyhZz7vkfQ4/B4DVggeIhBAVPtCn92IVaNMNXfsVnB+oeY+Tcc+Ub8OLHUVg9QHXt0lpXph/cAaQeJ/D2Uiir6VMq6uZnCDdrcQAw+yKphGj7UMccIYMfeko6/3T4t7IV9KlPuIUuhp2k5m2JiPTEpavFPrqaJWHYdkwnAwEAiLQtzqMut2duG2wxZUiMEfQDrltMgrLTrAXbMXeT209lsc3YVFhrcOVLzLBhm6D5Xk51HPlTpYnvONl4l7sXNvAkN1kPbhs3iUBuXvAy1/xuuPHuVN+B0oOxXbsCI1YIQfXcYoh45yWhnS3/G4cDATiZERKMhcl1dD0OzxoT8r0W2kOI9fIjSKZ6bR3rlI69KApIuAvDx5q6CxDL7LqSCV6Tfv13iQ6PwIxIIZPwHCCDJlwU/Mbn0ykQmmzugK9
X-MS-Exchange-AntiSpam-MessageData: gUN6rA+xehKex/HIZ1rGcAgr51r+Q2OEcUlslZRQ2drLNbOJIwMXFc261OUTrPTBOuZ24SSOYv9vz6iRm239pAa1Y92xTrU+BGiqJ6Kcz1we3B1G5i2YWuo1HdRRH1z6BhNn6Ct9RcWU9DUaWFsbpQ==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff438a7c-0598-43fd-6c37-08d7afe2c3a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:17.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ax2gqjpo94zbPHdjq8RxyikDbZX+BLvg56vrTeEwfpqtqynTkMx92lpcW1fWMfUttxYWxGeAIBYa/lNDpPINtADKXCV2mlLVfABf1/tBEBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

i2c auxiliary mux is done by analog switches. You do not need to
set them for every i2c transfer.
Just set i2c bypass bit at init and do noting in i2c de/select.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 71 +++++++++--------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 1363d3776523..24df880248f2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -20,38 +20,6 @@ static const struct regmap_config inv_mpu_regmap_config = {
 
 static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->lock);
-
-	ret = inv_mpu6050_set_power_itg(st, true);
-	if (ret)
-		goto error_unlock;
-
-	ret = regmap_write(st->map, st->reg->int_pin_cfg,
-			   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
-
-error_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
-}
-
-static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
-{
-	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->lock);
-
-	/* It doesn't really matter if any of the calls fail */
-	regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
-	inv_mpu6050_set_power_itg(st, false);
-
-	mutex_unlock(&st->lock);
-
 	return 0;
 }
 
@@ -79,19 +47,20 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	}
 }
 
-/*
- * MPU9xxx magnetometer support requires to disable i2c auxiliary bus support.
- * To ensure backward compatibility with existing setups, do not disable
- * i2c auxiliary bus if it used.
- * Check for i2c-gate node in devicetree and set magnetometer disabled.
- * Only MPU6500 is supported by ACPI, no need to check.
- */
-static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
+static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
 	struct device_node *mux_node;
+	int ret;
 
+	/*
+	 * MPU9xxx magnetometer support requires to disable i2c auxiliary bus.
+	 * To ensure backward compatibility with existing setups, do not disable
+	 * i2c auxiliary bus if it used.
+	 * Check for i2c-gate node in devicetree and set magnetometer disabled.
+	 * Only MPU6500 is supported by ACPI, no need to check.
+	 */
 	switch (st->chip_type) {
 	case INV_MPU9150:
 	case INV_MPU9250:
@@ -107,7 +76,24 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
 		break;
 	}
 
+	/* enable i2c bypass when using i2c auxiliary bus */
+	if (inv_mpu_i2c_aux_bus(dev)) {
+		ret = inv_mpu6050_set_power_itg(st, true);
+		if (ret)
+			return ret;
+		ret = regmap_write(st->map, st->reg->int_pin_cfg,
+				   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
+		if (ret)
+			goto error;
+		ret = inv_mpu6050_set_power_itg(st, false);
+		if (ret)
+			goto error;
+	}
+
 	return 0;
+error:
+	inv_mpu6050_set_power_itg(st, false);
+	return ret;
 }
 
 /**
@@ -151,7 +137,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	}
 
 	result = inv_mpu_core_probe(regmap, client->irq, name,
-				    inv_mpu_magn_disable, chip_type);
+				    inv_mpu_i2c_aux_setup, chip_type);
 	if (result < 0)
 		return result;
 
@@ -160,8 +146,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 		/* declare i2c auxiliary bus */
 		st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
 					 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
-					 inv_mpu6050_select_bypass,
-					 inv_mpu6050_deselect_bypass);
+					 inv_mpu6050_select_bypass, NULL);
 		if (!st->muxc)
 			return -ENOMEM;
 		st->muxc->priv = dev_get_drvdata(&client->dev);
-- 
2.17.1

