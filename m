Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2E15AEEE
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBLRlj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:39 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:3646 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgBLRli (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:38 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwnb003955;
        Wed, 12 Feb 2020 09:41:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=R+WbWyYcaS/YkPN7jz7RMcx5sWf3sbBJwhfCEYBZKMk=;
 b=kj9WS6QwgG/fAuFmvyYCn2zwA2xH/uDMYEH8udIlM1zlopW809UA7+MRLKyN47DS+Gma
 N9qU8gqNS6Dj1pOb+C/pgTDzSodirvl3/Uj7FlOsFWslFcqUy2RpvK1ioumRIZvetRgM
 Caj/6KXV+qk0+RkN1raMMAuYDwgKZ36iYHy9tLHamsxCKGTY2TvlH9MK5yEYC/X4RM9w
 Hu9t+8UmXtRWrsNraCiYwPcj3P8wrg2KoHmdThxnJ4ClSgwU52j1ktaGjgvu5e1e8Gwb
 l1Qvt6jrkwOuIQwTS4Qz5Hs7CUJy37gZvKzdGlkxSgS5PF4wBSKUGCQCHPSphKWfjTv2 3Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od0yTDadHLYeWwguxXEnQijQnn4IWz+TEBqiwftbvJRiqz5wFRH9QIVGSwV5lZkxBtdcT3TLbIgtDNo4THNJiRKK+1Dtik3MLNl0OgA/iCuDDhUCbai8V1Bz6Acnx0KP4lKh9b6zBnEq91UlZTW2AonopOZ52eyED9yE6LvwCFlvMwArPVT69mV4/GyDGfWt2FhO2qFKTYYh73unx23NVib9nicR/Jv53cCZQliueI0iaXWNW8FPwBTv2w8hC7d0DOTjKel+E+WlxWLxvJsGZRFJ+7xETPKV9H7K6Iusu35/4qlzexNn2ni+Ly2QKDkuV1pm+Gk9wE2dth/7hdVBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+WbWyYcaS/YkPN7jz7RMcx5sWf3sbBJwhfCEYBZKMk=;
 b=D3gnS2rckXRwH0LN6j8SQ5mwe31kM3Jpgn19ufCxPaDJFW9uEMwveRuqHJ9v2aTQ1dh2YdAUvniqb5cM5h007eOCTzT7stVvfcR7YcUuM4+PcKBDiSP/rhCevnBd7X7P03d/YUpa2DXL03JFVAYq2qF+vZav9kKGEwJtlntyETU0TY5QpZfThGVzLrmjrRRMJYaPPhRNcA3BlshjIAetjCX+u8fyF78CoCThmgEztS8XJ/Nd9wpFA8ocV+T4H/Pw+6/hLQxHQnjSpTU2kww1o4fQTJqF8hnHzMhvQ9p4FgwWRryAHZbuyVtqRlpKEjNxja2huZaUIbYvKXOacKqsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+WbWyYcaS/YkPN7jz7RMcx5sWf3sbBJwhfCEYBZKMk=;
 b=KunQyt72ZTJ18dfjKlOrvnMZOXnjCIE3ttKAl1+KCsI6EX+08M/Ze4ZM5CXfd/o2ayz+IzTaIkFhnbZr8xjANTQbtSpCxNcWfC7GUgdpTJse2C+yhStvw3QB4aQXma8S2hPUlOLaKW3wDsbGIWE2n6tR3hscDLiS/ajarj0mDH0=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:34 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:34 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 10/13] iio: imu: inv_mpu6050: factorize fifo enable/disable
Date:   Wed, 12 Feb 2020 18:40:45 +0100
Message-Id: <20200212174048.1034-11-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ec4f07-0998-45c8-4d68-08d7afe2cd86
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB407056B9B9253624C148423AC41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19a7piNIjIvcxKVktygXoh8aJGYN5s7IlKCuOt6Y4qTzN45rsLzQyTBlcDAQWXRgVuNNfUtzkXkioJLkZam7aXMG7iNRMuelkUq0xc2egJ5UYw34dfx4Xh9kARKC36teHrp2KHDPiPq9bd6c0rsAhbhIDressOOMPgVTzooRs2PzResun1y+e0XEcG91eKizLqH1hNFq9UUzZG182EHYy+T1Og4RRqJL/tmcjzW4EnY30g3H7efbJgqnMZdoInhf3syKhKft2sB+jJjnXNQEjkNMFnDVSAKJfaPl1WZBd/+wmvHOhWrON63fgFRts4f0HeAXc3t/q+ICdqO0w7X1q/4elOKFlo1ZeAEuOTiUO2sCDYsrPyAX7DcfRPefOI9xObzSWiBk1sxJ9iX1HLBOkZkzpaM6D1uwL1SvDuJ8VBsyRWigs6dON7UjQUDeu4Cm
X-MS-Exchange-AntiSpam-MessageData: Gt+ZlA/c+arSYo1nVQvEjg4UCQbDmMxq7nA511LYEl+XysXhbCF8v+4YGjuavxB51df1DVm6ojiO/lkrstizQ8JeL1ocA+OqU8FsAEMbab4Dqir5vI7NBS50g7vp8eevWUEC88EWXYqIPA//TRW0tw==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ec4f07-0998-45c8-4d68-08d7afe2cd86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:34.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNk5JkQKE+LG8t36uB84O48iKKx5G/yCe4jlCD/rtQjrg1BLz776mvevWUwShiZk8ssCakyFVb8dbCjrSz8DH+64yvESP5QUm4X6x5SPrYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=954
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rework fifo enable/disable in a separate function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 54 ++-------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 66 ++++++++++++++-----
 3 files changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index a578789c9210..e328c98e362c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -435,7 +435,7 @@ enum inv_mpu6050_clock_sel_e {
 
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
-int inv_reset_fifo(struct iio_dev *indio_dev);
+int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 			      unsigned int mask);
 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index d7397705974e..9511e4715e2c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -90,60 +90,14 @@ static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
 	return ts;
 }
 
-int inv_reset_fifo(struct iio_dev *indio_dev)
+static int inv_reset_fifo(struct iio_dev *indio_dev)
 {
 	int result;
-	u8 d;
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 
-	/* reset it timestamp validation */
-	st->it_timestamp = 0;
-
-	/* disable interrupt */
-	result = regmap_write(st->map, st->reg->int_enable, 0);
-	if (result) {
-		dev_err(regmap_get_device(st->map), "int_enable failed %d\n",
-			result);
-		return result;
-	}
-	/* disable the sensor output to FIFO */
-	result = regmap_write(st->map, st->reg->fifo_en, 0);
-	if (result)
-		goto reset_fifo_fail;
-	/* disable fifo reading */
-	result = regmap_write(st->map, st->reg->user_ctrl,
-			      st->chip_config.user_ctrl);
-	if (result)
-		goto reset_fifo_fail;
-
-	/* reset FIFO*/
-	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
-	result = regmap_write(st->map, st->reg->user_ctrl, d);
-	if (result)
-		goto reset_fifo_fail;
-
-	/* enable interrupt */
-	result = regmap_write(st->map, st->reg->int_enable,
-			      INV_MPU6050_BIT_DATA_RDY_EN);
-	if (result)
-		return result;
-
-	/* enable FIFO reading */
-	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
-	result = regmap_write(st->map, st->reg->user_ctrl, d);
-	if (result)
-		goto reset_fifo_fail;
-	/* enable sensor output to FIFO */
-	d = 0;
-	if (st->chip_config.gyro_fifo_enable)
-		d |= INV_MPU6050_BITS_GYRO_OUT;
-	if (st->chip_config.accl_fifo_enable)
-		d |= INV_MPU6050_BIT_ACCEL_OUT;
-	if (st->chip_config.temp_fifo_enable)
-		d |= INV_MPU6050_BIT_TEMP_OUT;
-	if (st->chip_config.magn_fifo_enable)
-		d |= INV_MPU6050_BIT_SLAVE_0;
-	result = regmap_write(st->map, st->reg->fifo_en, d);
+	/* disable fifo and reenable it */
+	inv_mpu6050_prepare_fifo(st, false);
+	result = inv_mpu6050_prepare_fifo(st, true);
 	if (result)
 		goto reset_fifo_fail;
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index cfd7243159f6..f53f50d08b9e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -100,6 +100,54 @@ static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_state *st)
 	return skip_samples;
 }
 
+int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
+{
+	uint8_t d;
+	int ret;
+
+	if (enable) {
+		st->it_timestamp = 0;
+		/* reset FIFO */
+		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
+		ret = regmap_write(st->map, st->reg->user_ctrl, d);
+		if (ret)
+			return ret;
+		/* enable sensor output to FIFO */
+		d = 0;
+		if (st->chip_config.gyro_fifo_enable)
+			d |= INV_MPU6050_BITS_GYRO_OUT;
+		if (st->chip_config.accl_fifo_enable)
+			d |= INV_MPU6050_BIT_ACCEL_OUT;
+		if (st->chip_config.temp_fifo_enable)
+			d |= INV_MPU6050_BIT_TEMP_OUT;
+		if (st->chip_config.magn_fifo_enable)
+			d |= INV_MPU6050_BIT_SLAVE_0;
+		ret = regmap_write(st->map, st->reg->fifo_en, d);
+		if (ret)
+			return ret;
+		/* enable FIFO reading */
+		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
+		ret = regmap_write(st->map, st->reg->user_ctrl, d);
+		if (ret)
+			return ret;
+		/* enable interrupt */
+		ret = regmap_write(st->map, st->reg->int_enable,
+				   INV_MPU6050_BIT_DATA_RDY_EN);
+	} else {
+		ret = regmap_write(st->map, st->reg->int_enable, 0);
+		if (ret)
+			return ret;
+		ret = regmap_write(st->map, st->reg->fifo_en, 0);
+		if (ret)
+			return ret;
+		/* restore user_ctrl for disabling FIFO reading */
+		ret = regmap_write(st->map, st->reg->user_ctrl,
+				   st->chip_config.user_ctrl);
+	}
+
+	return ret;
+}
+
 /**
  *  inv_mpu6050_set_enable() - enable chip functions.
  *  @indio_dev:	Device driver instance.
@@ -121,24 +169,13 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			goto error_power_off;
 		st->skip_samples = inv_compute_skip_samples(st);
-		result = inv_reset_fifo(indio_dev);
+		result = inv_mpu6050_prepare_fifo(st, true);
 		if (result)
 			goto error_sensors_off;
 	} else {
-		result = regmap_write(st->map, st->reg->fifo_en, 0);
-		if (result)
-			goto error_fifo_off;
-
-		result = regmap_write(st->map, st->reg->int_enable, 0);
-		if (result)
-			goto error_fifo_off;
-
-		/* restore user_ctrl for disabling FIFO reading */
-		result = regmap_write(st->map, st->reg->user_ctrl,
-				      st->chip_config.user_ctrl);
+		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto error_sensors_off;
-
 		result = inv_mpu6050_switch_engine(st, false, scan);
 		if (result)
 			goto error_power_off;
@@ -150,9 +187,6 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 
 	return 0;
 
-error_fifo_off:
-	/* always restore user_ctrl to disable fifo properly */
-	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
 error_sensors_off:
 	inv_mpu6050_switch_engine(st, false, scan);
 error_power_off:
-- 
2.17.1

