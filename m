Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0342215AF01
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgBLRqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:46:36 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:62646 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLRqf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:46:35 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 12:46:35 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHGhil003675;
        Wed, 12 Feb 2020 09:41:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=jFPSXbujM9lLcbXjIsL1hv1vTOO0fm/ny77cSG39Ok8=;
 b=nhP8xh4cYvGTbRcMTdTKg3OTSKmNZCn4ly3wLu3W0U0GK2yPtl0/tAYC+bsTBadfpZ4u
 PbJR5QAwvJRpJ+Efc9LFh26IEcjriS6AkszKuOcAG3hRASd9jVkNNRdP0B9iQG8dieBY
 lif3+aV9Gmn1tVK5TM5fsckM5fkUSACLuT7F1qHtec5KnPOt9mG2B7Sn5PKPpNmC/KYl
 YG7XoV7UsqCuNgeGYHTGtQyZt0htCAesd8zG3HTizVE7mJdq8cmoaoQVhuIaRIjC+POA
 /OdOMVc1P4SLsbvXjPtbvdoFMHaAfiuCosaPnuvm4gZELBWq8GYFwEW9HIo00nKn+nPN 0g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-00328301.pphosted.com with ESMTP id 2y47mwrcyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juDG0R4g7mGMR6JVAxoRGJjbMen9PrOwNyssuWlEma6rOv8ajTwFyyWdMP4Q2BAQPWoI80f/07B2ieEVJRvDrbgRC17u8Qq77+YqkmheKwD5hbZEOjYe2mAJnuqFAUFdqGmOhSXWONdkRqqM+JlknY9lajrpDCI5FUgN5tXJj9F4u88oY3xoOFiwYIbQ7bVDYPilOK1/zP3Amj0OPV/JXbBiTRkzvkyeRnCeLGIX3gJx5nmUbEDf+HVJS6h7bUnHwX9dN5vYaJKgt2dR+/j2C0fO8SCrtMwfdONeJoM4p6r75fxRkLd12X435rp8QjmD12HgHXe1Uswkw3v8Tj1UbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFPSXbujM9lLcbXjIsL1hv1vTOO0fm/ny77cSG39Ok8=;
 b=QPofdv3NLgj7Ok/6omVX4ZdyP3Y3e0NFtL7VvNTtXJ4CYC3FmbydAEh6qOI38wCpbKv3SfIhsez+Qzvh4DpsoVGR1/vYX6mDNie+nvYrs0kLTz6sLcdfyh/P9PPHKYLb2xjTgkMBWsdu9M+y207caoNuBUppfjoOpYxAtnyO2CAw4lU86ZAQ5n/KwvIbHenbp7yOpB2XOvLUBQ8p+bXoaxh5QiIHMtqXiisaQP7hicxRsKT67Dxw7IPrWapIPq2S9IxuK8Xi/3rzHXDpbUJdMuQXdRYHJrxACqhmxmM7AM5GDaCRX8bHpFj1bvuCzV+AiiCd312ucLi1MR3s1SqzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFPSXbujM9lLcbXjIsL1hv1vTOO0fm/ny77cSG39Ok8=;
 b=a6Udh8JIYVdTmfLil57n9rTQ6aJNQoocAVLtV8CuqPjNG0fM6Pdg9boh0rb3Ba22ACIcYDfAWJ72u+M+IBWkz+B6VLhcJPBDBnKM6E26uLjlVDeJ/Qa8CNctK2CkMvQidly/vvdCih+0yBqEUbaf8mie+fYtuBSOAp7rogmEvq4=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3925.namprd12.prod.outlook.com (52.132.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 12 Feb 2020 17:41:23 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:23 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 04/13] iio: imu: inv_mpu6050: simplify polling magnetometer
Date:   Wed, 12 Feb 2020 18:40:39 +0100
Message-Id: <20200212174048.1034-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c18a45a-00f5-4386-f9ee-08d7afe2c6e5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB392595CE76F043621CC4F071C41B0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(26005)(36756003)(478600001)(66946007)(4326008)(186003)(66476007)(66556008)(107886003)(5660300002)(16526019)(52116002)(7696005)(956004)(8936002)(2906002)(86362001)(316002)(81166006)(2616005)(81156014)(8676002)(1076003)(6486002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3925;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9C21uWzk55gJ7bWCq0846VY/dv0D3sxTFsX90my+z4R0i+n4k8Rk4m5BVS4P3ngSsd9+WWDNSdUlsDm3KPAVqFFiNNfQXIOfwpu9iEVuXCJEO+dP4w6DI30XAkjkg0OLHE2ZZr6r9GlWPK4XTkYxVqGz9wmE2tUbvsVmw7KNFhkWVS57DC9bLvU3n9OL2Z+kC0Bzxr5g5xjDLUYPA0mKFA/ptARfEfM2qdT5GsLaUNUlEvHHo1HJYULSwlVvq0EllhfbgNWd7WGPMeSC9+13GpPJgYCoSqubiXG4praQtRYY/nUU9+T9oLL0H48DdcN10iYDT0h8KVAVFqNJcwvvj+ghxGmqIDn8nxTvUMcGCgZkMBb3ZIXO7BSS4xOvqrdEaXBevJVVK7VRMl9NWYp7CE2BVgMGpZvCVOav1tyRpqeobRNmWnu1h1MEOVglebl1
X-MS-Exchange-AntiSpam-MessageData: 7nBXnOeOuzK/luFfJMqHPsOKUM3Iqre8WPSggWy4+mLaA3rWDRk2vQ7tBle/iARWL5xVLUrvmaUbe19SPgOB+IVobDE27DQcIuBNIIYATVZoKJffMyiyWEUuEkF8Nj/s1vexSxkK5dlIEsG9xH2CKQ==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c18a45a-00f5-4386-f9ee-08d7afe2c6e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:23.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jsx1tNO+yiC/cVmIr0/PKZZMMQ2Uhl8VhfykGTSLH+bz6+VUoIOQL1j0tnFObJaqJK1Oy29RBMAN9rtqcaf3oLxkoFo4YTwq8XV5nE1014s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
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

