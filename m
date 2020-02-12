Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB39115AEF0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLRln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:43 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:7118 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728833AbgBLRlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:42 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwnc003955;
        Wed, 12 Feb 2020 09:41:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=xdxUJvAYn5bJ4BS61bqktYriuNGgmqeKxzLVNjcotnM=;
 b=TFWjDQi/uzt0pHqfT6XBGZMW8g4RR/DmPOzZEnAcApToqjL6aBMiVO2R/N4kQ/XpD3Ui
 WUlfmFlQWDCHsWNERMEO6dZNtg71gagINXQYMlc/llYO67N8XuhYIIVkJ1jNfwLgQB/+
 JPxGDbpWAwBAzUT0rnz1FcGQUsA3Z6dPqFOuJGaDNGyrxWNdTxhRbePyhRnBXpt7v0kN
 EjJkuNbqyGHtcAVMNULRytPGbGuZhbxA2y8v8sGWllyBiIIgcrwy22WUlJJs+REwH8Qr
 lg/G17hbnXrUE7M2ArDC8U0OtTnjCLkKAvvNrMPF40d/ThLRvV98LrgeLCKarSuwD70o ZA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alA+ZX/w6wI6yZ5JDnlL4wl4ie2S/pMOubgJduYctNMWWgrIvZ2YM0qOEJELSXsuWfk1cMV61jkG5C6+fXu+pyhmHHSbl/IgW9Ou9q6Xwh47hsgUiLioRMs+eeKDLG9R+3Y0OjjC/w+A2T6f70Wh1YCS/Vc2xdpijR5wPtuu+tSgnKViJSYb80AVn3kDSRc3SguyxBTiHeFPmkrAe3z3rx7iywrEOAr0/zcDIkeoXtaHPdMs1OPwiebFt+0Z1Au9R/vLVXNXv7FU5FaIEFrX0+3a2DKG2NGOJfGh8foZ2lnKuTQAgBM2swm3ztduEkUJnfHsxKFjtfiMYMJg51GKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdxUJvAYn5bJ4BS61bqktYriuNGgmqeKxzLVNjcotnM=;
 b=aJd+l7g8GBoSjeAJwNxuA6Uv1CVyrDRk0mnpuNA858ZOWUZM578p5RZlRmhxrLHeuCKTkOdeTHC/U+Vp1eJigio4l0RzeNCXp9BQw9xJMmeGsO+QbmLzYzyMhjhCQiZsctyiqStAGxAynJfAe+IQDX/9KY6K/0zUbkP4gLLM0gumIVDD1jyLvbcVVXyFU32DdQTazWO2dpKRNgojXP4q0gGGfkL8p9Yj7Kb1A3IlqRJwPmffu2h92RYP/d7z90a+fY1uGvZT7gj1v9ac671KfpiSWKoWVQdB13MYQQA7EMEE/VPWQo1p/3UdcLFx9Ie+O/BsVXtHAyT3+DJQ3tCVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdxUJvAYn5bJ4BS61bqktYriuNGgmqeKxzLVNjcotnM=;
 b=HZILOkZ/XLopiSdK6CzJ1Ni8d4WPJ1p8/ah8WTzZCEA1skpsA597bDAKrNSbwfIRKzNHnQDP9HjyZwZ6qee7LUojC2bxinxWfjMa3BupwIuB6JGjjOC81CgBLtnOOgriSPE67NmxPpZRckiQ1ZxNjHsLqPWd22XRDeUUZmRBXhM=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:38 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:38 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 12/13] iio: imu: inv_mpu6050: use runtime pm with autosuspend
Date:   Wed, 12 Feb 2020 18:40:47 +0100
Message-Id: <20200212174048.1034-13-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f91ecaa7-19d3-4b4d-3931-08d7afe2cfae
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4070D142E078EEBFEFCD705EC41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(30864003)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sakiRnIxRdlq0S3d46UPHcSv1ZSAU+8P7deMXbcdLkS1+Lj4Xx87lMjh57xv4+j4eGBknfmj7FSlZZi5e5UsMDKhH0i5wvvJTNs8GE7zZYH5HllczCkIJmMb+Q7PvxdEddTX31mvtnvfBEFSs/3wuizwKyRmN/OW2FLoVfx/Hqpun7To+ujVm9xOMUHh9mG400+AZCMek/grXzUtr5yy2CDHbnpum7opeJ68Yp04p9HM8lkqyqxqDdXzADB4NHu6A7TTb4nQaOuHMH22EXRCr8uaRsSyZkwk4vdygq6DLa19Z9CaoyUwBo72V0Ro08febOGbcX+duqcz7kk7z15/5SkaVL6Iyq0M7WqzoWrQNFidYWa4xg36TYLVrbiLcMq4Zo5L1hrEyTuxKeAuJaKmDa7RTtNOI0nQHL3Awumgo2840u5wg5y5l87bgJcfpcTQ
X-MS-Exchange-AntiSpam-MessageData: wudqQ/X4E/d905iSa6vR1zAtGQJlIkQu4LD6QDuphVu6YnuQBkKVAGwtipGP3yYqdPXNJUpwP1wscAKCi6BIcVKEhNT7pM7DT+FlpT8xHrEI6uDnH7UhcIQYxLpOlNKP33BqQT6meHwH693qWZ/QcA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ecaa7-19d3-4b4d-3931-08d7afe2cfae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:38.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxIqdagWy8nnfME0T6PMQUV2cggrArkCQF7HlJSWwjajopSVF14fKXgLnXSMVmD+Op9gZukf5khm236M7uT+KrSNGQNSfTAfpNldL5MS9T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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

Use runtime power management for handling chip power and
sensor engines on/off. Simplifies things a lot since pm
runtime already has reference counter.
Usage of autosuspend reduces the number of power on/off. This
makes polling interface now usable to get data at low
frequency.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 265 ++++++++++++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  29 +-
 3 files changed, 191 insertions(+), 108 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index f33fd04671cc..f698d2aa61f4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -16,6 +16,8 @@
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include "inv_mpu_iio.h"
 #include "inv_mpu_magn.h"
 
@@ -400,26 +402,13 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 {
 	int result;
 
-	if (power_on) {
-		if (!st->powerup_count) {
-			result = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, -1);
-			if (result)
-				return result;
-			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
-				     INV_MPU6050_REG_UP_TIME_MAX);
-		}
-		st->powerup_count++;
-	} else {
-		if (st->powerup_count == 1) {
-			result = inv_mpu6050_pwr_mgmt_1_write(st, true, -1, -1);
-			if (result)
-				return result;
-		}
-		st->powerup_count--;
-	}
+	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1, -1);
+	if (result)
+		return result;
 
-	dev_dbg(regmap_get_device(st->map), "set power %d, count=%u\n",
-		power_on, st->powerup_count);
+	if (power_on)
+		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
+			     INV_MPU6050_REG_UP_TIME_MAX);
 
 	return 0;
 }
@@ -563,6 +552,7 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
 	unsigned int freq_hz, period_us, min_sleep_us, max_sleep_us;
 	int result;
 	int ret;
@@ -571,92 +561,85 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	period_us = 1000000 / freq_hz;
 
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
+	result = pm_runtime_get_sync(pdev);
+	if (result < 0) {
+		pm_runtime_put_noidle(pdev);
 		return result;
+	}
 
 	switch (chan->type) {
 	case IIO_ANGL_VEL:
-		result = inv_mpu6050_switch_engine(st, true,
-				INV_MPU6050_SENSOR_GYRO);
-		if (result)
-			goto error_power_off;
-		/* need to wait 2 periods to have first valid sample */
-		min_sleep_us = 2 * period_us;
-		max_sleep_us = 2 * (period_us + period_us / 2);
-		usleep_range(min_sleep_us, max_sleep_us);
+		if (!st->chip_config.gyro_en) {
+			result = inv_mpu6050_switch_engine(st, true,
+					INV_MPU6050_SENSOR_GYRO);
+			if (result)
+				goto error_power_off;
+			/* need to wait 2 periods to have first valid sample */
+			min_sleep_us = 2 * period_us;
+			max_sleep_us = 2 * (period_us + period_us / 2);
+			usleep_range(min_sleep_us, max_sleep_us);
+		}
 		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
 					      chan->channel2, val);
-		result = inv_mpu6050_switch_engine(st, false,
-				INV_MPU6050_SENSOR_GYRO);
-		if (result)
-			goto error_power_off;
 		break;
 	case IIO_ACCEL:
-		result = inv_mpu6050_switch_engine(st, true,
-				INV_MPU6050_SENSOR_ACCL);
-		if (result)
-			goto error_power_off;
-		/* wait 1 period for first sample availability */
-		min_sleep_us = period_us;
-		max_sleep_us = period_us + period_us / 2;
-		usleep_range(min_sleep_us, max_sleep_us);
+		if (!st->chip_config.accl_en) {
+			result = inv_mpu6050_switch_engine(st, true,
+					INV_MPU6050_SENSOR_ACCL);
+			if (result)
+				goto error_power_off;
+			/* wait 1 period for first sample availability */
+			min_sleep_us = period_us;
+			max_sleep_us = period_us + period_us / 2;
+			usleep_range(min_sleep_us, max_sleep_us);
+		}
 		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
 					      chan->channel2, val);
-		result = inv_mpu6050_switch_engine(st, false,
-				INV_MPU6050_SENSOR_ACCL);
-		if (result)
-			goto error_power_off;
 		break;
 	case IIO_TEMP:
-		result = inv_mpu6050_switch_engine(st, true,
-				INV_MPU6050_SENSOR_TEMP);
-		if (result)
-			goto error_power_off;
-		/* wait 1 period for first sample availability */
-		min_sleep_us = period_us;
-		max_sleep_us = period_us + period_us / 2;
-		usleep_range(min_sleep_us, max_sleep_us);
+		if (!st->chip_config.temp_en) {
+			result = inv_mpu6050_switch_engine(st, true,
+					INV_MPU6050_SENSOR_TEMP);
+			if (result)
+				goto error_power_off;
+			/* wait 1 period for first sample availability */
+			min_sleep_us = period_us;
+			max_sleep_us = period_us + period_us / 2;
+			usleep_range(min_sleep_us, max_sleep_us);
+		}
 		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
 					      IIO_MOD_X, val);
-		result = inv_mpu6050_switch_engine(st, false,
-				INV_MPU6050_SENSOR_TEMP);
-		if (result)
-			goto error_power_off;
 		break;
 	case IIO_MAGN:
-		result = inv_mpu6050_switch_engine(st, true,
-				INV_MPU6050_SENSOR_MAGN);
-		if (result)
-			goto error_power_off;
-		/* frequency is limited for magnetometer */
-		if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) {
-			freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
-			period_us = 1000000 / freq_hz;
+		if (!st->chip_config.magn_en) {
+			result = inv_mpu6050_switch_engine(st, true,
+					INV_MPU6050_SENSOR_MAGN);
+			if (result)
+				goto error_power_off;
+			/* frequency is limited for magnetometer */
+			if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) {
+				freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
+				period_us = 1000000 / freq_hz;
+			}
+			/* need to wait 2 periods to have first valid sample */
+			min_sleep_us = 2 * period_us;
+			max_sleep_us = 2 * (period_us + period_us / 2);
+			usleep_range(min_sleep_us, max_sleep_us);
 		}
-		/* need to wait 2 periods to have first valid sample */
-		min_sleep_us = 2 * period_us;
-		max_sleep_us = 2 * (period_us + period_us / 2);
-		usleep_range(min_sleep_us, max_sleep_us);
 		ret = inv_mpu_magn_read(st, chan->channel2, val);
-		result = inv_mpu6050_switch_engine(st, false,
-				INV_MPU6050_SENSOR_MAGN);
-		if (result)
-			goto error_power_off;
 		break;
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
-	result = inv_mpu6050_set_power_itg(st, false);
-	if (result)
-		goto error_power_off;
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
 
 	return ret;
 
 error_power_off:
-	inv_mpu6050_set_power_itg(st, false);
+	pm_runtime_put_autosuspend(pdev);
 	return result;
 }
 
@@ -795,6 +778,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 				 int val, int val2, long mask)
 {
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
 	int result;
 
 	/*
@@ -806,9 +790,11 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 		return result;
 
 	mutex_lock(&st->lock);
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
+	result = pm_runtime_get_sync(pdev);
+	if (result < 0) {
+		pm_runtime_put_noidle(pdev);
 		goto error_write_raw_unlock;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -846,7 +832,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-	result |= inv_mpu6050_set_power_itg(st, false);
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
 error_write_raw_unlock:
 	mutex_unlock(&st->lock);
 	iio_device_release_direct_mode(indio_dev);
@@ -903,6 +890,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	int result;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
 
 	if (kstrtoint(buf, 10, &fifo_rate))
 		return -EINVAL;
@@ -920,9 +908,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 		result = 0;
 		goto fifo_rate_fail_unlock;
 	}
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
+	result = pm_runtime_get_sync(pdev);
+	if (result < 0) {
+		pm_runtime_put_noidle(pdev);
 		goto fifo_rate_fail_unlock;
+	}
 
 	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
@@ -938,8 +928,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
 
+	pm_runtime_mark_last_busy(pdev);
 fifo_rate_fail_power_off:
-	result |= inv_mpu6050_set_power_itg(st, false);
+	pm_runtime_put_autosuspend(pdev);
 fifo_rate_fail_unlock:
 	mutex_unlock(&st->lock);
 	if (result)
@@ -1385,6 +1376,14 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
 	inv_mpu_core_disable_regulator_vddio(st);
 }
 
+static void inv_mpu_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_put_sync_suspend(dev);
+	pm_runtime_disable(dev);
+}
+
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -1409,7 +1408,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->chip_type = chip_type;
-	st->powerup_count = 0;
 	st->irq = irq;
 	st->map = regmap;
 
@@ -1521,8 +1519,16 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 			goto error_power_off;
 	}
 
-	/* chip init is done, turning off */
-	result = inv_mpu6050_set_power_itg(st, false);
+	/* chip init is done, turning on runtime power management */
+	result = pm_runtime_set_active(dev);
+	if (result)
+		goto error_power_off;
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+	result = devm_add_action_or_reset(dev, inv_mpu_pm_disable, dev);
 	if (result)
 		return result;
 
@@ -1594,36 +1600,113 @@ EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
 
 static int inv_mpu_resume(struct device *dev)
 {
-	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int result;
 
 	mutex_lock(&st->lock);
+
 	result = inv_mpu_core_enable_regulator_vddio(st);
 	if (result)
 		goto out_unlock;
 
 	result = inv_mpu6050_set_power_itg(st, true);
+	if (result)
+		goto out_unlock;
+
+	result = inv_mpu6050_switch_engine(st, true, st->suspended_sensors);
+	if (result)
+		goto out_unlock;
+
+	if (iio_buffer_enabled(indio_dev))
+		result = inv_mpu6050_prepare_fifo(st, true);
+
 out_unlock:
 	mutex_unlock(&st->lock);
-
 	return result;
 }
 
 static int inv_mpu_suspend(struct device *dev)
 {
-	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int result;
 
 	mutex_lock(&st->lock);
+
+	if (iio_buffer_enabled(indio_dev)) {
+		result = inv_mpu6050_prepare_fifo(st, false);
+		goto out_unlock;
+	}
+
+	st->suspended_sensors = 0;
+	if (st->chip_config.accl_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
+	if (st->chip_config.gyro_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_GYRO;
+	if (st->chip_config.temp_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
+	if (st->chip_config.magn_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
+	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
+	if (result)
+		goto out_unlock;
+
 	result = inv_mpu6050_set_power_itg(st, false);
+	if (result)
+		goto out_unlock;
+
 	inv_mpu_core_disable_regulator_vddio(st);
-	mutex_unlock(&st->lock);
 
+out_unlock:
+	mutex_unlock(&st->lock);
 	return result;
 }
 #endif /* CONFIG_PM_SLEEP */
 
-SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
+#ifdef CONFIG_PM
+static int inv_mpu_runtime_suspend(struct device *dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
+	unsigned int sensors;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	sensors = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
+			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;
+	ret = inv_mpu6050_switch_engine(st, false, sensors);
+	if (ret)
+		goto out_unlock;
+
+	ret = inv_mpu6050_set_power_itg(st, false);
+	if (ret)
+		goto out_unlock;
+
+	inv_mpu_core_disable_regulator_vddio(st);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int inv_mpu_runtime_resume(struct device *dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = inv_mpu_core_enable_regulator_vddio(st);
+	if (ret)
+		return ret;
+
+	return inv_mpu6050_set_power_itg(st, true);
+}
+#endif
+
+const struct dev_pm_ops inv_mpu_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)
+	SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime_resume, NULL)
+};
 EXPORT_SYMBOL_GPL(inv_mpu_pmops);
 
 MODULE_AUTHOR("Invensense Corporation");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e328c98e362c..cd38b3fccc7b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -164,6 +164,7 @@ struct inv_mpu6050_hw {
  *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
  *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
  *  @magn_orient:       magnetometer sensor chip orientation if available.
+ *  @suspended_sensors:	sensors mask of sensors turned off for suspend
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -174,7 +175,6 @@ struct inv_mpu6050_state {
 	enum   inv_devices chip_type;
 	struct i2c_mux_core *muxc;
 	struct i2c_client *mux_client;
-	unsigned int powerup_count;
 	struct inv_mpu6050_platform_data plat_data;
 	struct iio_mount_matrix orientation;
 	struct regmap *map;
@@ -189,6 +189,7 @@ struct inv_mpu6050_state {
 	bool magn_disabled;
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
+	unsigned int suspended_sensors;
 };
 
 /*register and associated bit definition*/
@@ -312,6 +313,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_ACCEL_UP_TIME            20
 #define INV_MPU6050_GYRO_UP_TIME             35
 #define INV_MPU6050_GYRO_DOWN_TIME           150
+#define INV_MPU6050_SUSPEND_DELAY_MS         2000
 
 /* delay time in microseconds */
 #define INV_MPU6050_REG_UP_TIME_MIN          5000
@@ -439,7 +441,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 			      unsigned int mask);
 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
-int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
 int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index f53f50d08b9e..9eab39042443 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -3,6 +3,7 @@
 * Copyright (C) 2012 Invensense, Inc.
 */
 
+#include <linux/pm_runtime.h>
 #include "inv_mpu_iio.h"
 
 static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
@@ -156,41 +157,39 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
 	unsigned int scan;
 	int result;
 
-	scan = inv_scan_query(indio_dev);
-
 	if (enable) {
-		result = inv_mpu6050_set_power_itg(st, true);
-		if (result)
+		scan = inv_scan_query(indio_dev);
+		result = pm_runtime_get_sync(pdev);
+		if (result < 0) {
+			pm_runtime_put_noidle(pdev);
 			return result;
+		}
+		result = inv_mpu6050_switch_engine(st, false, ~scan);
+		if (result)
+			goto error_power_off;
 		result = inv_mpu6050_switch_engine(st, true, scan);
 		if (result)
 			goto error_power_off;
 		st->skip_samples = inv_compute_skip_samples(st);
 		result = inv_mpu6050_prepare_fifo(st, true);
 		if (result)
-			goto error_sensors_off;
+			goto error_power_off;
 	} else {
 		result = inv_mpu6050_prepare_fifo(st, false);
-		if (result)
-			goto error_sensors_off;
-		result = inv_mpu6050_switch_engine(st, false, scan);
-		if (result)
-			goto error_power_off;
-
-		result = inv_mpu6050_set_power_itg(st, false);
 		if (result)
 			goto error_power_off;
+		pm_runtime_mark_last_busy(pdev);
+		pm_runtime_put_autosuspend(pdev);
 	}
 
 	return 0;
 
-error_sensors_off:
-	inv_mpu6050_switch_engine(st, false, scan);
 error_power_off:
-	inv_mpu6050_set_power_itg(st, false);
+	pm_runtime_put_autosuspend(pdev);
 	return result;
 }
 
-- 
2.17.1

