Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0A164737
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBSOko (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:44 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:22564 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOko (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:44 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEc7kj009174;
        Wed, 19 Feb 2020 06:40:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=7FR7F8FgFtcmDyVSk+DOURDCQcMgO+uACeDc9tcm4rQ=;
 b=leZ0PEh0e05qknTlToFyVdmJf8ntyrou3r2qwUxtVIPwLIAPHMqfOH/0ceLPjnWrgmaY
 NCLinWTGVc57QMSj4EDhG+JWWiIIII4pYGAp8tYqxgnoK0V9zymDB8j2SV4m1ha6T1Sv
 Nd0Ke+Zakbse52URxv/gkbgXzTOAkcHwhtH+iW4MUmyqq5BcW2sXxfYlDRlCDvwblGTG
 hRX8dPQR+GL1tDsq7tQ30OoCSkbRjG7dS1AEoOJsxZGp8qj03GiHjZgXVTiVrxrZS/RN
 zG+v+0xDewWsUny3EsydgHV6CkyrJYU48wPn0HitXwA5rCTLyutkrD7i3KqEc3aqqDIS pQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEQRzIhsLlUAkbBxO/iRkH/E1tOTb8oEJqnWC0W30ZMT0YY1LMrlnxAo2x7yJ7tC2raTIR5Ccwa1Ny2GY+/U8i9xyXJQcChkeHLvi+31E8iPjhZd7x0gwUEkNMDMw016KvWX0rji6SElYpnVtmkmpsyrcZdyRliRAuNJ34T2dWMmQWhl8XX2GeyWAQ8qP9qnv1zMkJvzXYDvvuzUQb7E+R/x228DldlEuNzPAuWtQ4DbO2gZqFIULJLHMBaTFB2QeZGFVBzQZtgMfXtPS09GW2qC7/HhX7UX/4zDOihdBVFkXihltQWu+ufNXhf792RvgOTuUq6MK1tqjvjtyIeJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FR7F8FgFtcmDyVSk+DOURDCQcMgO+uACeDc9tcm4rQ=;
 b=jkdTQINofAhnxMhrPWHUkMBdfLNg/ymf9wJq7xXOfn14A7xHmD3T03+UIpp0BiIf4r1R8kmvRPvedUWUtd6EJuSZclwplxrXjfl2d9ZRnlV/LO1y1xwWpKTEbSiro4QaH7spy5PEao/Qs3duZocm3SoUeS4Ph8uBElksGd4gVDC/8oVt8ErAO9W4Z0cw85FaPpD59eifbJ6IvNlibkHhkSXnKKVgofYGJT/YXJ4Od5izxA/LA7Q2PKk1MHQWyKvxr48T1y+3m7/A+UzKPtCbN7S3DOuj9i38olKlGtjaiV0faroyuNTXXKzc5zdCVsp6p8eAamf7MYPg1/lePJLlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FR7F8FgFtcmDyVSk+DOURDCQcMgO+uACeDc9tcm4rQ=;
 b=RERouhd4VUQFE3bkbMMGjhv6BI5K2LhZVC/UOJ5OVQIvrR+KyjLk5NoNEV6WDz9R9tygM6KdKj6hARqX2hS7kYAw/gSMmrhsIRcD3aHdJdvY80elUm5zIT8kQIF+xJgls5o7NbYt312LNWkTnYD0BSND+r2oHzwND2/zXrX1LJ0=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3878.namprd12.prod.outlook.com (52.132.245.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 14:40:39 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:39 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 03/13] iio: imu: inv_mpu6050: set power on/off only once during all init
Date:   Wed, 19 Feb 2020 15:39:48 +0100
Message-Id: <20200219143958.3548-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ebdd95-b0a9-4ab3-c962-08d7b549b065
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878A349434080BB22B0D61EC4100@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(2906002)(5660300002)(7696005)(36756003)(16526019)(6666004)(81166006)(26005)(956004)(2616005)(52116002)(186003)(1076003)(81156014)(8936002)(86362001)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(107886003)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3878;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUhz6tjItsTU034MsgbaVHwETh/qI/iYeA8+zigVURFjX+I5uvw7Ce5EGLtBvbPcL3VxZh0z1Mc9nAFfZX2DGerhh1zzjIl5WNi+mtk9uT/c5UMOZsVjm2p61cwBBezNgu+3PYhL9c/T0JyuMJW/j2TGvY8fZynIDrwPLQmNy8wsc61GZuYh6IT8nG/uV4l+2j2HGQknuZ2CPYVr9MgcRue6o9Zp2COOwuJnYUWeqNVM9YG7SKeDT+ayxnby9FsQzFirXTmIeqkH9ucXr/cpjioW5hEkquqLfFUGTgKDMgmktTN795WdH2LiThp2R/PZBN4xSCsb8sTJlJ2NfPCvyOBaEco+5BtDMANLdrgHVy9oXoJ6HoYx3me3QaJ6dDrX1Xxgun+0TQrPeTfexNQf/vX9ELdoT1PHpvlgC0arVF3FUaP53mglmX9ZXG9ugb4V
X-MS-Exchange-AntiSpam-MessageData: Hl1j1HYXwr8DqhIocQuSQhe68rEML9hKlsLH2J7aDBpoptf7CIDEOmsEZuWyG87FFkpsEjy3TIQkZWxU8MtvyU/swX+aNWNyIo15ikSNvAHTEh5CVZkw16R/vEinr+LFvWj9D2PW5CgQR86rdf9+Jg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ebdd95-b0a9-4ab3-c962-08d7b549b065
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:39.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7nTfjQnOwncxQlJDQ7DR867TviaxKHGRIJHDC7ku3ffZVTrPztwIyveYuNVIUWVunFt14CIi+9HxKV7Jhc/E4EMnE3IBoNCtTKpObDxLMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This way there is no need anymore to export the power function to
i2c and spi modules.
Bus setup is done inside init when power is on and the result is
now checked.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 41 ++++++++++++----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 11 +-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 10 +-----
 3 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index c4db9086775c..0b06d6aa6469 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -301,7 +301,6 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
 
 static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
 				    enum inv_mpu6050_fsr_e val)
@@ -371,27 +370,23 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	u8 d;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
-		return result;
-
 	result = inv_mpu6050_set_gyro_fsr(st, INV_MPU6050_FSR_2000DPS);
 	if (result)
-		goto error_power_off;
+		return result;
 
 	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
 	if (result)
-		goto error_power_off;
+		return result;
 
 	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE);
 	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
-		goto error_power_off;
+		return result;
 
 	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
 	result = regmap_write(st->map, st->reg->accl_config, d);
 	if (result)
-		goto error_power_off;
+		return result;
 
 	result = regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
 	if (result)
@@ -410,13 +405,9 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	/* magn chip init, noop if not present in the chip */
 	result = inv_mpu_magn_probe(st);
 	if (result)
-		goto error_power_off;
-
-	return inv_mpu6050_set_power_itg(st, false);
+		return result;
 
-error_power_off:
-	inv_mpu6050_set_power_itg(st, false);
-	return result;
+	return 0;
 }
 
 static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
@@ -1176,7 +1167,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	if (result)
 		goto error_power_off;
 
-	return inv_mpu6050_set_power_itg(st, false);
+	return 0;
 
 error_power_off:
 	inv_mpu6050_set_power_itg(st, false);
@@ -1341,7 +1332,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	result = inv_mpu6050_init_config(indio_dev);
 	if (result) {
 		dev_err(dev, "Could not initialize device.\n");
-		return result;
+		goto error_power_off;
 	}
 
 	dev_set_drvdata(dev, indio_dev);
@@ -1353,8 +1344,16 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->name = dev_name(dev);
 
 	/* requires parent device set in indio_dev */
-	if (inv_mpu_bus_setup)
-		inv_mpu_bus_setup(indio_dev);
+	if (inv_mpu_bus_setup) {
+		result = inv_mpu_bus_setup(indio_dev);
+		if (result)
+			goto error_power_off;
+	}
+
+	/* chip init is done, turning off */
+	result = inv_mpu6050_set_power_itg(st, false);
+	if (result)
+		return result;
 
 	switch (chip_type) {
 	case INV_MPU9150:
@@ -1413,6 +1412,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	return 0;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
 EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 24df880248f2..6993d3b87bb0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -78,22 +78,13 @@ static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
 
 	/* enable i2c bypass when using i2c auxiliary bus */
 	if (inv_mpu_i2c_aux_bus(dev)) {
-		ret = inv_mpu6050_set_power_itg(st, true);
-		if (ret)
-			return ret;
 		ret = regmap_write(st->map, st->reg->int_pin_cfg,
 				   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
 		if (ret)
-			goto error;
-		ret = inv_mpu6050_set_power_itg(st, false);
-		if (ret)
-			goto error;
+			return ret;
 	}
 
 	return 0;
-error:
-	inv_mpu6050_set_power_itg(st, false);
-	return ret;
 }
 
 /**
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index bc351dd58c53..673b198e6368 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -21,10 +21,6 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	ret = inv_mpu6050_set_power_itg(st, true);
-	if (ret)
-		return ret;
-
 	if (st->reg->i2c_if) {
 		ret = regmap_write(st->map, st->reg->i2c_if,
 				   INV_ICM20602_BIT_I2C_IF_DIS);
@@ -33,12 +29,8 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
 		ret = regmap_write(st->map, st->reg->user_ctrl,
 				   st->chip_config.user_ctrl);
 	}
-	if (ret) {
-		inv_mpu6050_set_power_itg(st, false);
-		return ret;
-	}
 
-	return inv_mpu6050_set_power_itg(st, false);
+	return ret;
 }
 
 static int inv_mpu_probe(struct spi_device *spi)
-- 
2.17.1

