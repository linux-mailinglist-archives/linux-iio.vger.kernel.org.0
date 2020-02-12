Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7F15AF02
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBLRqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:46:36 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:62654 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgBLRqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:46:36 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHGiKI003685;
        Wed, 12 Feb 2020 09:41:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=Zy6hrLoYUNeSxq67AWm2fxqIMqnPKPnoMerImyrZcEg=;
 b=tCE3yaw8LUjG8TfFAStILyEQoX7e0cJX4/2F+HZPh3YGx/Rm/noWqpAiH6zSucKt5l0C
 mlrLoM1ggLbuL8C3pti99bO9QAt8LzLwIllkYce/kKJtjhtoFnFgNmjeGpDr3hiEeanW
 53t0nAVN7vocED7qfJTehloTgrJorIBRVKgo7hGo/Ybkw7GrdFI9gMNft7/tY2rRSzhL
 qKh7CQcvUFBoJmn5RUWDVDD1HYh0zVWYTWvRRYUzgTTB9OiuANiGyE6wOxDVln8KTrw1
 uUu6n4KPhRQhhIeX58pg63Hrdo1TeIS8ip34hVuUmPpSF3mSP0WWmWlDTs70nY2Yhhte Ww== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0b-00328301.pphosted.com with ESMTP id 2y47mwrcyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyQG2WShsg6aUTfyzzbqd2TATMxkyrEO1UyRDVbsF5mbS5Sk2JntGYEqnZVHFko5JchUWrRjmZHjs66Xdg9JjPBGy8IPk9YOcC9Dsp4048/pNRPFqIml6Mc86b/lwjUKNuc9gbQJ26urtw6t3AZXueU+/h9ITKQ8Y2wZ3x6gqxQUkBWVMXigEbXFqjR8rH4UdrY92kyyrAw1HcMSP1deXzpywZuu6b58F/d+wvzOtvoV2wVoAzZraskb+qdMmisd++G6GBrbx1U1+2VrVbgqE4RoL7IXpgK75eejKbGGIQCcBFD1NXppFP0I5p+8jVJBFq8Zy1jvaqa0HKjY325d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy6hrLoYUNeSxq67AWm2fxqIMqnPKPnoMerImyrZcEg=;
 b=SDU6wiTWSGiVMG+dG/D+145AGLHeiD7kgGD9KBf+4tn581Z1XT9AIDmnzO4rivOtLWq8ukYw01NjUwYkgqI6CVAcTMygWf/rspRkGDa+Xim0xmzxQ5Anw/4ZwminYKzWFGSXlu33L7qnDKfm/0ziVNc3xgLUbI4VF3uYti7meOrGjO/oEZDJAvB/BZnm1xU+Xc3ugLidvGR6CfzkjqhD5xCUP9HWp9wHFl89nrv5p0RpDo/e7ZYXBmmMjhvycidcg8bFJxdznkS3/aml7lgsn4bUJO8N3qBreftjMClvaJJVUkCrMEfyMieX358F2mLWUEJTpwvNRJM3OtlxtgjPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy6hrLoYUNeSxq67AWm2fxqIMqnPKPnoMerImyrZcEg=;
 b=FqESqsaIC1awfqeAAWBQfboc7rFH2g5ALw/KXnvDXbLnnJzo0TGlOZHgM+mdPhY9VoE90PJrWEuVwUjCD5yANewNDT4yW56I/YmgCPQvBtbB1G0GZ2ioslCdukoGLD3Y85yfjswtdyK0Zt5Wc7C3Wj82lm8l37QT3++xMHu1msU=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:32 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:32 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 09/13] iio: imu: inv_mpu6050: fix data polling interface
Date:   Wed, 12 Feb 2020 18:40:44 +0100
Message-Id: <20200212174048.1034-10-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2827e2-9343-4f16-f635-08d7afe2cc71
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB407008690A92FCF7935DE3D1C41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TZRoe1vg3thi+aSpYCfAZD4ZhG/39wbsGElfb45mLUDxhTw/8B3vAThFjUwh+oduZZc/LIByl7hnbiO9GcKwzClcrNKg+12NxMuKvL98b8sMef5xVi1PP9sLh/fMh/R8BYKrbvIbcOIVpW6LNB1uEmON78J2JgMahWuHYz+cnBkCWblTVfEh5qEVPNlWjE4av6/s1J4Or1EsAVd7Pj2+WivIKKNnnD0ZGUOMNb5B+n6oj04EuSwBusj54ALcaapIlC6VX2TCLRyVK9BDSlpjyh6qR7vt05+tvLQhFDU5iInFhGyBgjqpSeFra9mi4si6Czzq+4zZZv2AG3iQzckaJU9MM6q9DKXl4ObHdOG4ojxtpwooUhVT+Tz41e77ev/VlEvN0jq8mt6F68LLOpA6yX6TVPQeXibNqcC1TCo6NaNtBTZbT/jDGSgp3BCos84
X-MS-Exchange-AntiSpam-MessageData: 9ziY/KFlFdiEr0e0v3LYrA1nQm+kmqWZ+tsppXQ4HgejGHc9as5M9ExCpvf8lQSSlctReogP0aBOzChPjPqq3Twy82IEqLHS3hhpKOz85c/JR3UtfSLr7n2G9rvVytvrkY1UMh+f272bXJ+WzCzfQA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2827e2-9343-4f16-f635-08d7afe2cc71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:32.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk4GQJgeMYaRM6LmAIz6dpme6f81+uLMyFWGKSei8Npvu+Ovz2yqg8W13N3RGXadE9IppVAe4M+TwmjXvR/1iO+iQJnBYP6wlvIDFrf83cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
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
index a51efc4c941b..28f8079d4599 100644
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

