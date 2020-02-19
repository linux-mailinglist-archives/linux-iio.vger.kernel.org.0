Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344BD16473D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBSOlH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:41:07 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:51780 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgBSOlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:41:07 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEaS9q006602;
        Wed, 19 Feb 2020 06:41:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=yWo4zX/wrZ92Uov4BTPS0Fy4HARYP0oDxSIizGEtNcU=;
 b=EKgwcYCWNeMgCw9qCwid77RwHh0Ta9J/5tDSlh3PhOGt60/Gmu9Ym7RuRa99TraYsGLv
 GdkXJ/antbSgzieypRrGoxR6IVZfSiz4bI2e9j/oKUo8ULciTJ6XHNBhG3XugyGSKPDG
 T+uX4/Ty5Qb4RLZ2lJfD0m88lE24BcqTye7u6THVOgmspNPNC0Ym7fUiGaZSzYLJOscL
 l/Or3cZaUKJ46QQYZJ0OrtI0G1e7b0eX1UHEA5/lNFunpCggkPlaWEwgLR11g4QSsfX0
 2oGPSvqrhHr/hOKTm6JeTlL65CcodqZlYTjrKU4wr72YxYUXNBT1ISTcP7LxoDg88jnQ dA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:41:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvMvYvxdoaGi5OayZVQQorn0XnPcSGYHd2f9a/pFxvkDdOBFy5NQZ+EvpR7SbkT0yhTstTmKCUeBvJcnasw/thjKnqWnojP847O6wY/yed8QQ2yjOELzqngr9nMq15wYkp468ocsS4HPXFDe6jfdBYtq5f0BeUiVN5Hy5lLeqodLOc0Nz4qj3BqlNxFjTo0KOxV8eUcjWS6miW/ADA2Y5aGrLEeiL3qJU7h4fI7XI6bOSj1KdfBZqjdWEigaiCzsr4B48fCL7rfMLNlluAemy6W127Ln0nxV6nXAp2xrvAWu7va3Who3K3R/1ea9Vr01gaAs7mZkrupa7P2b41Juhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWo4zX/wrZ92Uov4BTPS0Fy4HARYP0oDxSIizGEtNcU=;
 b=cYDVNzFfNPvoQkZslSujaK01uy5UbfJiDVA38VJv2nUkjIxiAuHXvkOm2wwDXS4QGvNNkIi4nEilMVkY+hEwQs/hyKnAx6fRIlL/insgNGwlP88tYsZ8s1Zy7qi5jzpXlSjYUNekOFBolgQ3aCdw0MLvvEvHKk7Mf1FW95nXp+mzIR3gCXHPGhgOtm8VSs+iTrQPGDTFIhgItj8rz2f6K2PRpuxgm1SEM+G6uwxyUVg3osVScdFUfzNVl5FeHRab2fJYpoOS1kD21Ur5samFiKv+kRd/13N30H7drNaoCFFkoitWo+uSXcawzszBX2UjgBU3LADkwMQzP4UaCYTr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWo4zX/wrZ92Uov4BTPS0Fy4HARYP0oDxSIizGEtNcU=;
 b=h1sEtP0qLxn33DqTplgOa5UfABnlN8H6Zs4IU0kMnu7Z2KTIVXB3y4Tb8Jt7yzU+eSn2MQMb3bfbSK1Ts5bekz9A6d2Vxl1ecI5PYhmohZWLCMK7t2EFrXegQSU/kIJ6vjrcQw+DpcR2TZdpc7sr3UzEfKs5xkeeRePZafoBWVM=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4134.namprd12.prod.outlook.com (20.180.6.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 14:41:02 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:41:02 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling interface
Date:   Wed, 19 Feb 2020 15:39:54 +0100
Message-Id: <20200219143958.3548-10-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:41:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e0fb04-cef6-44e5-7e76-08d7b549bdf0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB413496B4416E7D7876A1F8F2C4100@CH2PR12MB4134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39850400004)(366004)(136003)(199004)(189003)(107886003)(2906002)(66946007)(4326008)(26005)(66476007)(66556008)(316002)(81166006)(8936002)(81156014)(6486002)(36756003)(1076003)(8676002)(86362001)(7696005)(5660300002)(478600001)(52116002)(6666004)(956004)(2616005)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4134;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: poiVguOw2HHA+Ye+TQrXkaEy3931DaOsKBblRl8sfFpefvlzRx5NfozhlaD7UYFnxcshXA3JpMgD1gYzoCrmDm7IBeGTFJ4slb2T108HjVm+QXeWQpqyC5HlHouaWIRps5i+DvDbjsXo5hlOuwKGIHxD25CbZy8fHqEBNUVXYXV45oWw+dW1zFqTUuqCzR4131Mj2ZGH1Ng8dZDDo6sbsVeqftFWisuLL4OmpDwMU+He5h5DHyjIIulHswfiKMp1ldbmZ92VYgnGmiQ7A92cE1o5Tv0bObmSEaI8ekolffOh7rKmlG2TIkponJj1t5c88NAWL8cXLTSMv/5a128Yrxu9gfiL981U6m6Mebiut/a3z2wtN6o072XFxeebtD+L5dYzOzQAskuNrVQkfCP6SMhcLm8lyyiR99ic30ciz4hNKABtleZpHLOYiL04CEaT
X-MS-Exchange-AntiSpam-MessageData: Ep/uPgR109RhbW+VEsJhRpwYSmkhtin249Xr4JWNWsYz8WImR/vv2w+btQSbhfZPE6S13IG5WFslHZLaLAvxlh6Yf9yQ5+jSeiokxKOglo01x63UWZyaqRa8odik77RlgO08zJyMfJ7pgH7Uj953eQ==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e0fb04-cef6-44e5-7e76-08d7b549bdf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:41:02.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5hYZFlHxg4h55lciCbYDfXCN9V9SWDoAHWN9L9GVy8Uk4S5ft1zC3pxysONKOARCEjHsD0JyUylI2BrWZQNI01MpZxZSuNPSMmBKsDJ/S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

When reading data with the polling interface, we need to wait
at 1 sampling period to have a sample.
For gyroscope and magnetometer, we need to wait for 2 periods
before having a correct sample.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 36 ++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 21 -------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h |  3 ++
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index a51efc4c941b..aeee39696d3a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -563,9 +563,14 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	unsigned int freq_hz, period_us, min_sleep_us, max_sleep_us;
 	int result;
 	int ret;
 
+	/* compute sample period */
+	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	period_us = 1000000 / freq_hz;
+
 	result = inv_mpu6050_set_power_itg(st, true);
 	if (result)
 		return result;
@@ -576,6 +581,10 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 				INV_MPU6050_SENSOR_GYRO);
 		if (result)
 			goto error_power_off;
+		/* need to wait 2 periods to have first valid sample */
+		min_sleep_us = 2 * period_us;
+		max_sleep_us = 2 * (period_us + period_us / 2);
+		usleep_range(min_sleep_us, max_sleep_us);
 		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
 					      chan->channel2, val);
 		result = inv_mpu6050_switch_engine(st, false,
@@ -588,6 +597,10 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 				INV_MPU6050_SENSOR_ACCL);
 		if (result)
 			goto error_power_off;
+		/* wait 1 period for first sample availability */
+		min_sleep_us = period_us;
+		max_sleep_us = period_us + period_us / 2;
+		usleep_range(min_sleep_us, max_sleep_us);
 		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
 					      chan->channel2, val);
 		result = inv_mpu6050_switch_engine(st, false,
@@ -600,8 +613,10 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 				INV_MPU6050_SENSOR_TEMP);
 		if (result)
 			goto error_power_off;
-		/* wait for stablization */
-		msleep(INV_MPU6050_TEMP_UP_TIME);
+		/* wait 1 period for first sample availability */
+		min_sleep_us = period_us;
+		max_sleep_us = period_us + period_us / 2;
+		usleep_range(min_sleep_us, max_sleep_us);
 		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
 					      IIO_MOD_X, val);
 		result = inv_mpu6050_switch_engine(st, false,
@@ -610,7 +625,24 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 			goto error_power_off;
 		break;
 	case IIO_MAGN:
+		result = inv_mpu6050_switch_engine(st, true,
+				INV_MPU6050_SENSOR_MAGN);
+		if (result)
+			goto error_power_off;
+		/* frequency is limited for magnetometer */
+		if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) {
+			freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
+			period_us = 1000000 / freq_hz;
+		}
+		/* need to wait 2 periods to have first valid sample */
+		min_sleep_us = 2 * period_us;
+		max_sleep_us = 2 * (period_us + period_us / 2);
+		usleep_range(min_sleep_us, max_sleep_us);
 		ret = inv_mpu_magn_read(st, chan->channel2, val);
+		result = inv_mpu6050_switch_engine(st, false,
+				INV_MPU6050_SENSOR_MAGN);
+		if (result)
+			goto error_power_off;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
index 3f402fa56d95..f282e9cc34c5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -44,9 +44,6 @@
 #define INV_MPU_MAGN_REG_ASAY		0x11
 #define INV_MPU_MAGN_REG_ASAZ		0x12
 
-/* Magnetometer maximum frequency */
-#define INV_MPU_MAGN_FREQ_HZ_MAX	50
-
 static bool inv_magn_supported(const struct inv_mpu6050_state *st)
 {
 	switch (st->chip_type) {
@@ -321,7 +318,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val)
 	unsigned int status;
 	__be16 data;
 	uint8_t addr;
-	unsigned int freq_hz, period_ms;
 	int ret;
 
 	/* quit if chip is not supported */
@@ -344,23 +340,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val)
 	}
 	addr += INV_MPU6050_REG_EXT_SENS_DATA;
 
-	/* compute period depending on current sampling rate */
-	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX)
-		freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
-	period_ms = 1000 / freq_hz;
-
-	ret = inv_mpu6050_switch_engine(st, true, INV_MPU6050_SENSOR_MAGN);
-	if (ret)
-		return ret;
-
-	/* need to wait 2 periods + half-period margin */
-	msleep(period_ms * 2 + period_ms / 2);
-
-	ret = inv_mpu6050_switch_engine(st, false, INV_MPU6050_SENSOR_MAGN);
-	if (ret)
-		return ret;
-
 	/* check i2c status and read raw data */
 	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
 	if (ret)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
index f7ad50ca6c1b..185c000c697c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
@@ -10,6 +10,9 @@
 
 #include "inv_mpu_iio.h"
 
+/* Magnetometer maximum frequency */
+#define INV_MPU_MAGN_FREQ_HZ_MAX	50
+
 int inv_mpu_magn_probe(struct inv_mpu6050_state *st);
 
 /**
-- 
2.17.1

