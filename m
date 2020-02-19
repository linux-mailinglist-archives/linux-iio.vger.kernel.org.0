Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41716473E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSOlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:41:11 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:56426 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgBSOlL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:41:11 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEc7kq009174;
        Wed, 19 Feb 2020 06:41:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=R+WbWyYcaS/YkPN7jz7RMcx5sWf3sbBJwhfCEYBZKMk=;
 b=ijQzh9ncls7s/zvahpUlO9D8JdbsOrFlogtGHMwygurnBNOpMV/zWQ/BjFPLITHaPJPm
 WR2a/mP8dyHFeGgZA3l8Bkklz/Ts8isRZ9iscYmOWlMcrLMLimN+5wH0mJKsS7uhaqH8
 iH5Y+973WYVrbp56UZ8FvtuMqazbNWgnt3VLWgJLxbOtlu3u1asz1hC1WN1vuqbhtX8j
 j+Gx5tQ/XuNPD/6gYOJVXAhIB2vSbtEyAlDJMgwdKAymyFs5Ddv7YLfn8wTi8ywmrVOl
 WrPTEEv93/haJMXEiQ6MuiA+bKMkMEjRH+D6UpcU7g8J/tSM/T6RLqKsCkjnv/1vOJx2 7Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:41:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSExrUnUVClpsTlYGxPVxlfcAGmv+xJNHd+uCNsev9YRgZQMOxufnGJ/qKYMdgyfgxBKponPQB/mXiPBcDUf/wPPdL/w43z2EWyI4eKjNcK3rfv1vnPwV9Yg59qd7L6JtIAghhUETeyUE9IfUq5MwQ70gIIXzpvoYKgi1WNQD6+hpuxRUxkP7QmPuBLqFTGzWuy6GR9ngt9TO8ihqRhmjupfzclmcOjX4UPoj6gM+oSEDiRRWidxyGcR4ET0uVIrSq64gIIUoOBkcoFFJJUI7efzl2c0UjvwTpJUiJSQWVysVpKfzsZN1bncUM0beCMzDiw+IpauzjItZibDgHEL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+WbWyYcaS/YkPN7jz7RMcx5sWf3sbBJwhfCEYBZKMk=;
 b=dqzdDSGyF5Pzl8eS21GLGTWyNtUucs0+V+WxQ7Oisgc6PqWdvucx4i+jRZuqbHVj6QH8pRg+WInBa4AXdZKjJ+Y9i5087YrCk0ZHat9kera7sOPyFZmhQzHBwDuoB8mBMDMzHlwaL5lpO7I3tfnxDRLeE36ggrLHeOOaMAEIcVophAUc0QhGABiVjW3RisRg9aXCtoKA+ixFhWaS4+/OfGbjCzAzYrYLLrqURoK2O9BppTN5Qg4IlCIzmNloXDrlfEpbtsjPVPjG04CxmvVRis6XwdC/BRkJwzw9rsyb0fUjAOivxotu426dhcn4jC0R4c79dWUp8KAUPRPaZisrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+WbWyYcaS/YkPN7jz7RMcx5sWf3sbBJwhfCEYBZKMk=;
 b=kwSEMGJCF0G5Pv2ueqBfOUlLG161hBYWpz6ow9jGJD8ZgoEfr2wmksVDOwSsT9dqxUCey6xZKDc+hNQ4CyJwMixIoXiryxz/hdZjjICXNKhWLg/4T904Rd9r1tNi1FNLT7dOKRNsTRLcvmUFRz68nE1Ps1qlgmGW9Yqo7yMaUYU=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:41:06 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:41:06 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 10/13] iio: imu: inv_mpu6050: factorize fifo enable/disable
Date:   Wed, 19 Feb 2020 15:39:55 +0100
Message-Id: <20200219143958.3548-11-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:41:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d641c44-2eb4-49d2-5733-08d7b549c080
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42130653EA6EEAB6A07437B7C4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(2906002)(36756003)(16526019)(6666004)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vB4DeWrgNsfeiV0ERCtZIeuk63p/bnDwRNAeFRtcG6zjWKOM2Q+7C99Hl0KB/9X/0lb0/bTcoUyhWiSlX1PNpdtN/GXL74Xha9X1yYrQNMxpCG+ThrwLkMw4zb+yXKDU1OQdtjB5Dz6RC2f21nkWagbrS/71vVLC1DyN6IxZtIJkTN9vfqo9nCelkyrN8rCBfZu/SHOfY3icc5Zy+jtZc4+MdzIBjIPXKhMCtzxyLNjY5z0wzF5pGASaAkANU+TqCf20y/pbcuz8X9CR7FkrFwdSzOGrAMDyVz30BkY3zzQ39PyDJ6JO5EX3TaRPjKe5EeZ6u+Lps93MOGNQA+7uDp8A9iEEOMH3hwXM0m1KZzKHbCn9I/ogoIXDrj+9kOyMhRFe9UihcuJQMHmQfNkadKKZ4pp8EVJvgeUWeoTwK8h3nO41ehrD5uM48U2R1jF1
X-MS-Exchange-AntiSpam-MessageData: nVUuf8OSV+767vk6nw/aDCqN/zBPR45f6pHLZKHFXB+3Nm2NrD9BnyY9yJI2PAiztG5MdqdXTvW10FxzVwpN2kZ5l9jZNBH3pu2o1YSLGj4v2uCC3qbi1QQQcTgTwvUIiHKqYKrcccnRmCtLsQ8b6w==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d641c44-2eb4-49d2-5733-08d7b549c080
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:41:06.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHXr/v6yTwPiqdTz9nne9spgeDYTyLTfkgWz4J+w3oipjbaVbBfbxGp4bdwfzX8jjbinnwbwbmNb/SyOnmOBErUGqHjugLFB3IaCplGncNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=936 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190113
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

