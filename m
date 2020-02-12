Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3896815AEE7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgBLRlX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:23 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:53216 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728767AbgBLRlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:23 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwnZ003955;
        Wed, 12 Feb 2020 09:41:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=7FR7F8FgFtcmDyVSk+DOURDCQcMgO+uACeDc9tcm4rQ=;
 b=o/vW6gHxuCbJR+fBkkXDPzvVe3d1SMnvledfkbIiLF/ccDttCi39x+M6V2DKQ+pwOIlz
 4wXLvi4ADadGUtxKOrnjo5vqoCv/Rxfn0UMO+DDRviBwC1wrt0CtJjSvkMkQw2XBXWSa
 lm0Xm/4y7X1CtrP7sE+dQVRrhHiWtyAn/+P/VxfOFUP9/UP1wIsxsUMQI4d7kqsPWcbi
 Edb1PrSnQxtaS9dOgHgPb0TlfUf52qVv0Ju6nw3rvVmBhO+41HYM8xBPsgNwABq5UYR4
 06dACO4X/3XS1ZGO/qeupMczDlZI03A5Wq0+Q/ephmM6yruncfhioW8adUZlo0yRTNxz Hw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYjEsbdt4jnVy32t6h9QkGOJ5KeqkAxt1/BQpk04SP2w/+YpKdzYt4Kb+f+znBy05cyk8JWbd2Oa1iWVU+5HusnhCmpu103fUlaWKorHXoWBbrBFPV1ckgmLSScsu50XHawDz9x1dLeQXiZ49LPNiwRT1FfevEX3ZewPWAnexeXPYoiAwNQhBO29HePUxlkIyw9oCwQzMglrsas5+cCKZI/Ux410NpgcdOtDy2P+dTRSPf3cSeCiQluIj6YipkzzsD49BoruqvnNAk7o02dyeOHpdoTbTeVJQVVLFWrcUP2QxlvftF6cy0NwvdHbE38fA00cy7WdW1dVLa1/jDOcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FR7F8FgFtcmDyVSk+DOURDCQcMgO+uACeDc9tcm4rQ=;
 b=JxrBNYQZTZf2VG1/SCUB6hq1GqwFMMmem82a+Izmxc6jfx/cC04A0+EiOmOplAXJjHAEg1Bbhyhs4s2N8AwFmfSlJ9r2Z1SpE4kFFS9t3A6lKQz8VvAz8BAr9kL3bZ4W5cpgsLVTumtF0CALTf+TgM4nV7Wc+rWTVFDrpXHNqekJqnDRPPzdkgnSL+GNL90JfV2zEuWB+SoeBGtT8TsvsZ7Ce4uwQHJjyvvEupvtE1lqaxjU7VJZqFZKPHkJuPw3g8KpOInq4JOzFznnRG9UVMAGFPC/gAofF6XgoqiXzDjSYqCM8x3cxNVke+mLG+y1zE/P27k7xclpHIdkoO1dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FR7F8FgFtcmDyVSk+DOURDCQcMgO+uACeDc9tcm4rQ=;
 b=jIgvc0s6ecQSbqgb8JvVdpWoGEKFR6A9qmUEXt5/4czBQpqI80XvkdfysavCqeArDGwMKZTEaS5EfpSnqBD/qhyXvu8IjaL69LzZ6SzCqhiUH+X6YMbzuMIVSRvIwo0OfoELK7l+loDYFK+7vyUgGsf/MRsvBbSYhfkdV9CaqJg=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3925.namprd12.prod.outlook.com (52.132.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 12 Feb 2020 17:41:21 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:21 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 03/13] iio: imu: inv_mpu6050: set power on/off only once during all init
Date:   Wed, 12 Feb 2020 18:40:38 +0100
Message-Id: <20200212174048.1034-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 059b987f-8c34-44f8-0da9-08d7afe2c5cf
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925013417106730FE7EFC77C41B0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(26005)(36756003)(478600001)(66946007)(4326008)(186003)(66476007)(66556008)(107886003)(5660300002)(16526019)(52116002)(7696005)(956004)(8936002)(2906002)(86362001)(316002)(81166006)(2616005)(81156014)(8676002)(1076003)(6486002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3925;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kycWczDTDs1iGYG+ucuvz/+OLXZxjRiQPemKYiZHaqhaDHTrq/0vERhg7ODMp2MgDxDiKPegqzcSrhFVePv7Qse79xjER7iOiAcMBKG/uAUuUbOCRVX7Lgq4Rzuff0LjJmm6AIhn4+5SFEP6fqUor316P8c/iSYEGaoRQn32Qmq1XcXEe7/DImy46QBoU6dXXsx3I3sJnHhAtm0girDhzYA84UbWu4J6L0CtxXFPrhRyhyCyw/AHSw1QXHW5vHkpeCPjrt9EGG/4PjriroEL7XsFklo3Xs5KUJ1TOrjo+uWMzPJvXYPO1UOf70dcbqbjYdv1ch1la7wYL0TsUGmKTJlRDaWGrMj/+6v7/rkLeWJevpI/fnyMnuIPwXRjWu5tuyfOvrUyTdTeowlPvc6c4nDhiAyUG85iuPdT/Toi14KolV4TyWn5mPDXh/UMVIWe
X-MS-Exchange-AntiSpam-MessageData: dzpcdU+JMApQbJPUsoWpp4lskrosTwQUPctNmRnaccYSKY7jhsg/1Vmm4tKmed/IJ7K1PMpl2duqHmruymh2zhO9caSlC867uJlD5q1BdmXieFCbl7Bs2Wge1QI1tZ0IUMkhR7O8U0kJ5Nyr0vkw+Q==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059b987f-8c34-44f8-0da9-08d7afe2c5cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:21.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLZIe4lxCgctJD1inOm1j4g0rjOxePNQU9GFILxibIcyuM4+cIcr4Vs7e390GufcyhSM9xHSH5n/kERIOc/Sz5+rk342U4lIFpUUcx/9/e4=
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

