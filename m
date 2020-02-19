Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2168B164738
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBSOkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:46 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:59430 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOkq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:46 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEdZsI016944;
        Wed, 19 Feb 2020 06:40:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=jFPSXbujM9lLcbXjIsL1hv1vTOO0fm/ny77cSG39Ok8=;
 b=l9SldotHg6vLQbzH9mQFSq9IiOLRYS8hozyzlaP7T4TOOUQJAcoiRM3Keh/0pHPG5hZO
 pcJjDiV9zPkFRpcQPFwAFo/21/l8dsRKpd4koctE1nmTAQZRLqLr9C/qrk6t5jToNukq
 7TFbPfQOYL+bQdlFRej0tCuZe08F7Jsi6XpwmFC95djXEYC8BNms8CIZC7HW3wAoPrb1
 P/VGfeRXt7sJgU5hvX8Uk1wd3x/qFlFgFIl/uDe4hE1e50AdwiF78Zam4fnwEra9nre2
 x6/TnCe6gskNCyg5Nlmrf3x7furSPuKN1RuOP4VbP2khyPWcoS3+OgVzSR9ILAoDeaSD FA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem892j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFX9HtnIq6IlHIqGVImydeWlXZ0hf51oyHwJ9slIzgW0vlyJuLuO5toU4TA0AhG2dfdGx8EPkY9oSqUAAk/cPfItygfBYcMmO3JZDHdivamumOVh1bRtXWsLK8JiIPZMnivZ9Y+8AfBExqtC7OsRU8O8o0kWEAY693qI/cBmY8EUKNaRmvrUDc7+OqgwucnsWLSWTQQggyin1fPK8k/J61enPnTESB77ULiz9RCyBR7qiAonmXAkch4gT7sgZaFnumdU7gPV0BxhZUpcSZq5N6wNvgw+0AAb0DS/Dup08aOpRYPmBk7Ah76a0/PAOeN/w8AKNNBx1hTPp98vWYGt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFPSXbujM9lLcbXjIsL1hv1vTOO0fm/ny77cSG39Ok8=;
 b=jWvgK2gPwNkDajGC1AT1qE/unmG2qjfOSl/lZzYZRb0yXAI0KcORBPlmPcWknnQk8/z0138OQecyS8NE9Woi8qVuqhzM8O/KosEZfLEdO3qv88nDIZlA6WlRAHkuIxkwej/DxUoDB28twaJ4JuuoB9n6J2aZZRzkpLzTi0j1k7opsxQ+dhZSSbVGHxPRtYFrGvaAJG46NXqTw5laTKrZkkrnYK5DQ+bQgKhdbB+Eba+L+1jvNEDDI8zdb68uO23+zzKYH7DBAktPM3bHbuwHpyX5f5lt9BMeP4dnWBCSpMaLFq5rGBV02fFEAzYrlGH3UwcpJ1myWMiO+5kfvIvVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFPSXbujM9lLcbXjIsL1hv1vTOO0fm/ny77cSG39Ok8=;
 b=URkD6Xg3trTUwH77YpAPvtcCniNNdZvTxN8Lhj+r+/2W5bW6PZSbGkhx3U0XDmPuRR4ngXPStqSCdqEH3cEiNFkTRr8i4nfS3b1rbEqfL6JDj0kt+5fvTt3X1MuHSGhiPa5MwHsnwwUWoP8vPesrBbJ/OP/APhnpZtR/jpd2ZcM=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:40:43 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:43 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 04/13] iio: imu: inv_mpu6050: simplify polling magnetometer
Date:   Wed, 19 Feb 2020 15:39:49 +0100
Message-Id: <20200219143958.3548-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 354fb49d-0e47-41dd-d723-08d7b549b2ba
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4213EEB239658250EDA94162C4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(2906002)(36756003)(16526019)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64ameCA4jGudLUQRKmyUcAnbIT5mjsfhZak4zK0A2a0nd4YensUeZEaWeRElvx64rrgWeKGpXj4dYNN4DXBjpKMeeOy6EIwYiW+xhR9APJBOhOiCMkbbbDPKpXIgCeMlpGBhgeKvS/bLvQSUU/0laxkHGKSbU5gtypiv40KUzsuKuXihkD7M6MigjV0/J1/nrnbZkFiGLQp0OQ/Ath2BUF79n1DKTHgnf1oBSb4ujoZXDEjczjE7dmaPuBX/QHZNzQhoyJgN6RIPjIyT+ahA5M24qRGtsK2xK1Nfll2iiCVwjFttguxFCGxGe5192Cdfch5YUfmB/EnxuKBdL32WQ6Kb5cLCUOKvw4vlvgaNbB1NZwI8ae9c3GWUSyNcSvWcvturayUWTpI/nH5YdnHP6bRbtURducbvWH4R1ifFVILtC1Jbd9SaYHTfcKCNf4n6
X-MS-Exchange-AntiSpam-MessageData: 7C3FFUzrTFsSRYx3/VDmGtg45NVv9GNYM8dx0BtzzPVJrgs0fKWkjOWK5vRXBiB9F8MrIOq0c6+fE2a8DDlGOYHAUAzYXAM07vS7ZIeYGdzSKinyXcc37ApF+KF0owfYuTt6BMU/V2Htimp+wBSx4g==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354fb49d-0e47-41dd-d723-08d7b549b2ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:43.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8+Xlq3CWBuFC9MEAhx1ME4Rn0hJTRk3uhzFL/16hnyXo3RFV4LJndPjEpgPdUa75L+NAuXIhkFnwN4kv6dx/8C9rwkbYz8QH9efMLYAkUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Do not change the sampling rate value. Let userspace decide what
is the sampling rate to use.
Read only the requested axis.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 34 +++++++++-------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
index 4f192352521e..607104a2631e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -319,36 +319,36 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
 int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
 {
 	unsigned int user_ctrl, status;
-	__be16 data[3];
+	__be16 data;
 	uint8_t addr;
-	uint8_t d;
-	unsigned int period_ms;
+	unsigned int freq_hz, period_ms;
 	int ret;
 
 	/* quit if chip is not supported */
 	if (!inv_magn_supported(st))
 		return -ENODEV;
 
-	/* Mag data: X - Y - Z */
+	/* Mag data: XH,XL,YH,YL,ZH,ZL */
 	switch (axis) {
 	case IIO_MOD_X:
 		addr = 0;
 		break;
 	case IIO_MOD_Y:
-		addr = 1;
+		addr = 2;
 		break;
 	case IIO_MOD_Z:
-		addr = 2;
+		addr = 4;
 		break;
 	default:
 		return -EINVAL;
 	}
+	addr += INV_MPU6050_REG_EXT_SENS_DATA;
 
-	/* set sample rate to max mag freq */
-	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU_MAGN_FREQ_HZ_MAX);
-	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
-	if (ret)
-		return ret;
+	/* compute period depending on current sampling rate */
+	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX)
+		freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
+	period_ms = 1000 / freq_hz;
 
 	/* start i2c master, wait for xfer, stop */
 	user_ctrl = st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
@@ -357,19 +357,12 @@ int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
 		return ret;
 
 	/* need to wait 2 periods + half-period margin */
-	period_ms = 1000 / INV_MPU_MAGN_FREQ_HZ_MAX;
 	msleep(period_ms * 2 + period_ms / 2);
 	user_ctrl = st->chip_config.user_ctrl;
 	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
 	if (ret)
 		return ret;
 
-	/* restore sample rate */
-	d = st->chip_config.divider;
-	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
-	if (ret)
-		return ret;
-
 	/* check i2c status and read raw data */
 	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
 	if (ret)
@@ -379,12 +372,11 @@ int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
 			status & INV_MPU6050_BIT_I2C_SLV1_NACK)
 		return -EIO;
 
-	ret = regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
-			       data, sizeof(data));
+	ret = regmap_bulk_read(st->map, addr, &data, sizeof(data));
 	if (ret)
 		return ret;
 
-	*val = (int16_t)be16_to_cpu(data[addr]);
+	*val = (int16_t)be16_to_cpu(data);
 
 	return IIO_VAL_INT;
 }
-- 
2.17.1

