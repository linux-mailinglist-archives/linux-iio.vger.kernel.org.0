Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D97401B74
	for <lists+linux-iio@lfdr.de>; Mon,  6 Sep 2021 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhIFMzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 08:55:49 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:53750 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241892AbhIFMzs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2021 08:55:48 -0400
X-Greylist: delayed 1239 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Sep 2021 08:55:48 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 186Bma6R024997;
        Mon, 6 Sep 2021 05:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt1; bh=/CmgR9oAKtZXY477xQEswxlmGcij3vU92tzpfkTPa+0=;
 b=YQPSCHEKGGOK5n8gLz1LE4bjVTRPEmwNOIeElIDnVfx3gGnzLm7b+hr1pbTkXRv0RNaQ
 tNep5ScL2DxLMPP4IuXOJG+lKoda+UGkiURRXk2eFiSGwzlzVA4kGXXf12pzwoa2MWTb
 TXaeoplJ9RuQ2DxYHbSBgpLPfFCVCHkXhqzdpFEFo787O2fAqXCja97+NqsXrcFr9soi
 W1CEaoRNm8s6Q06NZrBXkgODx4wvp+jgkPpGrA00snPea4BWiXV5kk2A2bWxLXFtrSaV
 JSTFCsQZBSXuCBrqkR6jcvqvuGjz7pD5cHcl4XWSq37BHVRpoQOZ/GSIiqmdqO0YnR/j kg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00328301.pphosted.com with ESMTP id 3aw0ay8bxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVujfzRgBXtLMb45HJamDFgERmKvsnp8C2b72oNO1qLsLnVdI2pFHA/9kp2UEsp+gmcfDmGwPVgeREheD207q3p8fx2n8rXJWM1Y0ApsjVJuFtUziBiZXZA+5eRk8fck88K1yw9g3fAGWiQ+z0AZZQjTYpg5ITMvYxerm7lEabtMfU4xSfXyuPzjICD2z51R0GGIjIl1ifyp33/3F28vvFZPCMOMnYLZSMhzrIAfbJgmWQYSZdTQHp0F81MkwVeWw+ZjYGtCBuSL5WY2XtX18cZE68ThMFDCJTKHgPFnoqpf5igGiWYeYMBhGqq7DzIs8+rjKiGaTYSDzT0sGggxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/CmgR9oAKtZXY477xQEswxlmGcij3vU92tzpfkTPa+0=;
 b=dcdKDhuNx6ZutjwYc7aRVdVAl/ouIk04PCXbfXWUXEDsUk5tFMl61QckLSaqFPT6NqutNCLliTRBfgZ8fhiql18Z4Aq7t4gD0pf6mBYpz6vlp2Yk8/p2KO+L0iicL7HtmQi6r6Ef9qFs+cwyFbVSJRe87EBITmCWngpoEVRlvLcmVYL3Xtbz193vxSGuBB1MUS8qYx9/xWYBXFC4iDnq8DaZqTbpndfoNDlFortnrt64IQ6Xtmj6+fCTUbAOWcOaWLIlDvolEFno8SAlZjO9jSbvTtr5X0M+qiO4UJADe4F+NQ74K9n2+B3VTOqwQpnemwipo2ddPlFGwdYrxkLzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CmgR9oAKtZXY477xQEswxlmGcij3vU92tzpfkTPa+0=;
 b=R+WRUoYny2ekMqraYy8BOfnzpTFNJbR02Gbwd/YOftuutdW8NSbgw8QphdsEdatyBMNvwsbOo0UCwiLZMU1zrcHXolbTann1xMv3Zup0A3T9FZ49JbHGo5yf6cB0qwKUFnuwTkFhWsn8afW7cquIT95rFHYdGYRxOG7EfwV3tEM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32)
 by BYAPR12MB3046.namprd12.prod.outlook.com (2603:10b6:a03:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 12:33:48 +0000
Received: from BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::8880:75b:9bf:6d6b]) by BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::8880:75b:9bf:6d6b%5]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 12:33:48 +0000
From:   Baptiste Mansuy <bmansuy@invensense.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Baptiste Mansuy <bmansuy@invensense.com>
Subject: [PATCH] iio: imu: mpu6050: add watermark support for icm20602/20690
Date:   Mon,  6 Sep 2021 12:32:19 +0000
Message-Id: <20210906123219.3084706-1-bmansuy@invensense.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::24) To BYAPR12MB2901.namprd12.prod.outlook.com
 (2603:10b6:a03:138::32)
MIME-Version: 1.0
Received: from frgnb-gzcwd53.invcorp.invensense.com (77.157.193.39) by LNXP123CA0012.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 12:33:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec72922-688d-47fc-27e0-08d971329308
X-MS-TrafficTypeDiagnostic: BYAPR12MB3046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3046A99CC4DDEF05869C1089DED29@BYAPR12MB3046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yejnKSaKe3dbBVDDQ7d3xfk2VcXSGteVhBgI8vdFlXxrdWCGd1RGN1vOlrjOhvaiOLyfnoZ2Zo4ECvTH2WybZoNsfvEV9fQV2CCKrpQKaRcC+PuYiGdfCHNpYO3kyQhv2pCTsdGeJJn5T2gRMPexIEdVFNm+YitbIv+wC8wtr2Rbzf9pFdr/fQEDf56TP26sfcWCy+97UKScbSYQ0u/LKj2vKiwtf/fXUZVu4DFbCrpZhCBhjeNaN8mqx5+k94cDQegjDQY0OBgIMYIK53Jw9xg/kaThe35t4TMJJgAw/15XHDpoY41C1uNdW8zBYL5483Q6OcdtMPXmcdUMsT2NL0yWHcifZAbyHtx0poPkB/pOLrQVXvRvkIf/2ARkYnmbIW/Vb1jSTeetAWfao8ekTeB6UfmYW49RyUPlSXqBNxNZsfc4vmbx+wzgsPR9lTtm5P8M5E/8hfjs+pGykjBg/OW5tAKCXLQ2RQKzFtMgF/ApB3dMUMuFSPMke9eM9xjLSfTiGGUxTtUFKfdPz3MxsV+0RrbSZ3oW41LayhDygYdkf6Ch9upXnSJfA4itrdifZ8+wEassWK3fKPXSWZb7lpxIGcJKtzQgtk8/YpGeQ1vu7CaWqz/yYAH6uZhEq0Sbqub0VSCGCg4orWeraN7OzAQAbRl0uS8NjD6K9swYkXyJvGtWMmSO3WTtIheFRyx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39850400004)(136003)(346002)(396003)(5660300002)(36756003)(86362001)(66476007)(2616005)(956004)(8676002)(478600001)(26005)(1076003)(83380400001)(7696005)(30864003)(4326008)(8936002)(38100700002)(38350700002)(107886003)(186003)(6486002)(6666004)(316002)(66556008)(2906002)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFuy0aTyZlNUHHfEbaHSGZwmU+ljyB2XOl322zwkjw19L/69KbQZeILRV18d?=
 =?us-ascii?Q?Xy+TEu3QZyNoS2sSCSan6ivVTiR7r7qIelXgnyAlOdlGrEvZEoRwaE5pi4dq?=
 =?us-ascii?Q?AxQv32AWxh0UITodttEj9RB/e/MqS+A9mzL8YbC23c2/kKBODxDK+GAhKF1S?=
 =?us-ascii?Q?D59m0Dzyg44QsWhmheRCQHSWWiVOaaKxQDiAtvmbw1LlXgK0NKuweUj3BpGR?=
 =?us-ascii?Q?sf0+oI7gS0s33WZ0rLNJbKI251o4NTYqjP/cReIffZJ0nn9ObV7yXM+hkSVp?=
 =?us-ascii?Q?wwoxe9uBlFPRt2VZjqDfBID7Eb2PZolqWWBiwE3a8QH+NcMcRhA2/jz0VJMI?=
 =?us-ascii?Q?1TKHfRfapF3c6FJHaw3bvnJSXW1dcwdx2HyPx7oZQ0gk7o7zZC/IHLMiJ2RA?=
 =?us-ascii?Q?PpIfSNQukS5EApWc3bIISZdIUqH0vlHLgnn2zQJJxJCS8zYnG8dcV2TJVIMm?=
 =?us-ascii?Q?nwEjIKar3TNqtiZ9yTrCLtIkuxrtQCNTyXIlTYPMfbxxxzK09d6lnbHsW9sr?=
 =?us-ascii?Q?vNFMxHXgfOZwPNjUxXc6NPqUiSn5BayFE4/bEehvUaxCvX2UDkYU3EnJNtMK?=
 =?us-ascii?Q?0E4FYO6a1FEiTZHk2n/ArsMBIG3eQzqzCS6QUaiqTOcgqq+JfxkGxANWdyRe?=
 =?us-ascii?Q?fCUKUIhrvi4kICmqVAOWPBZlD+qXs7/Ibudj4HeoSR9vyKo5W8TbhoDOZFbP?=
 =?us-ascii?Q?grce/7rUtA2TekBbQH5dDYvK2z3zgfG4R+qATGGXcuEO+PkVupmHr+8J5cSM?=
 =?us-ascii?Q?R4p9d7oYBKgkQY7WcqMn2wkz48wZOnx7fHgkG+DNgZDyk9vDqZe25ZbBUawL?=
 =?us-ascii?Q?PMDs2hX394NNxhnM+qc6YIaXCnz6szWnS3OTgwSUEu84B69uF6372gwU1y6w?=
 =?us-ascii?Q?oN6ZcdTJj8TEQElYIxBBjYaa3L6T16STfWhqXZN7xeWZ9C/nWzA2P9qJWOBM?=
 =?us-ascii?Q?mt0yFhyTO5eKi9rGDjgXyheP+IrdwjbQ1Hs2BGYFIHDLthI7/4SlnQjhfFJt?=
 =?us-ascii?Q?vGGgEr/YgPW7rAAcRjLqGah+nz6enjCsshQFLbdxkDNWgBzLq1/Z1JFOiM7S?=
 =?us-ascii?Q?KNkh9wieO9B7UihA/vYE4Gc5xhFs2dZHymQR2JNOCI9QRFroybn94EOZkdng?=
 =?us-ascii?Q?2L3qdMZ9B2sgGWv169Iq6mtpAkK1Y1/8K2gw0TWXkwGvltMIBO1w3ik7+fz+?=
 =?us-ascii?Q?4Hd7IMEuJmKtsSYW9rysj4w7Vl0EJkILpkQychIpvl+wJNb8+imzxGXKD/Il?=
 =?us-ascii?Q?1YPB0u+9QID5TsiB1TOCUR/CXa+Dxsish/c1gK30c1NL4YfmsIx5xJ/d9zXA?=
 =?us-ascii?Q?bL9SZA6tXxLu9EtQvOZgqnOM?=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec72922-688d-47fc-27e0-08d971329308
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 12:33:48.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13MysccA10nzcZgrG9DahiPbldy5ZhXSU9vLF9JBdLf1XsACmS3Ul+YeB93QQl//RCNl/voZfwrtDikbmsIboQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3046
X-Proofpoint-ORIG-GUID: c33NXgZqkJrIxxegiDGtGi4cgd5OL6Uw
X-Proofpoint-GUID: c33NXgZqkJrIxxegiDGtGi4cgd5OL6Uw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-06_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060079
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add watermark support using FIFO interrupt for chips having this
feature. This allows the use of the watermark interrupt with the
posibility to change it's size. Change the timestamp computation
to be used with the watermark.

Add the set_watermark and flush callbacks according to the iio
description.

Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 104 +++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  21 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 130 +++++++++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  24 +++-
 4 files changed, 237 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 597768c..9cdec62 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -47,7 +47,9 @@ static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
 	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
 	.temperature            = INV_MPU6050_REG_TEMPERATURE,
 	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
-	.int_status             = INV_MPU6050_REG_INT_STATUS,
+	.int_status             = INV_ICM20602_REG_FIFO_WM_INT_STATUS,
+	.wm_th_hb               = INV_ICM20602_FIFO_WM_TH_HB,
+	.wm_th_lb               = INV_ICM20602_FIFO_WM_TH_LB,
 	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
 	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
 	.int_pin_cfg            = INV_MPU6050_REG_INT_PIN_CFG,
@@ -56,6 +58,31 @@ static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
 	.i2c_if                 = INV_ICM20602_REG_I2C_IF,
 };
 
+static const struct inv_mpu6050_reg_map reg_set_icm20690 = {
+	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
+	.lpf                    = INV_MPU6050_REG_CONFIG,
+	.accel_lpf              = INV_MPU6500_REG_ACCEL_CONFIG_2,
+	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
+	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
+	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
+	.accl_config            = INV_MPU6050_REG_ACCEL_CONFIG,
+	.fifo_count_h           = INV_MPU6050_REG_FIFO_COUNT_H,
+	.fifo_r_w               = INV_MPU6050_REG_FIFO_R_W,
+	.raw_gyro               = INV_MPU6050_REG_RAW_GYRO,
+	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
+	.temperature            = INV_MPU6050_REG_TEMPERATURE,
+	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
+	.int_status             = INV_ICM20602_REG_FIFO_WM_INT_STATUS,
+	.wm_th_hb               = INV_ICM20690_FIFO_WM_TH_HB,
+	.wm_th_lb               = INV_ICM20690_FIFO_WM_TH_LB,
+	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
+	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
+	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
+	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
+	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
+	.i2c_if                 = 0,
+};
+
 static const struct inv_mpu6050_reg_map reg_set_6500 = {
 	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
 	.lpf                    = INV_MPU6050_REG_CONFIG,
@@ -115,6 +142,8 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
 	.magn_fifo_enable = false,
 	.accl_fs = INV_MPU6050_FS_02G,
 	.user_ctrl = 0,
+	.wm_val = 1,
+	.wm_size = 0,
 };
 
 static const struct inv_mpu6050_chip_config chip_config_6500 = {
@@ -132,6 +161,8 @@ static const struct inv_mpu6050_chip_config chip_config_6500 = {
 	.magn_fifo_enable = false,
 	.accl_fs = INV_MPU6050_FS_02G,
 	.user_ctrl = 0,
+	.wm_val = 1,
+	.wm_size = 0,
 };
 
 /* Indexed by enum inv_devices */
@@ -247,7 +278,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 	{
 		.whoami = INV_ICM20690_WHOAMI_VALUE,
 		.name = "ICM20690",
-		.reg = &reg_set_6500,
+		.reg = &reg_set_icm20690,
 		.config = &chip_config_6500,
 		.fifo_size = 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
@@ -264,6 +295,38 @@ static const struct inv_mpu6050_hw hw_info[] = {
 	},
 };
 
+int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int val)
+{
+	unsigned int nb_byte, new_size_byte;
+	int ret;
+
+	/* compute number of bytes inside FIFO */
+	nb_byte = 0;
+	if (st->chip_config.gyro_en)
+		nb_byte += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
+	if (st->chip_config.accl_en)
+		nb_byte += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
+	if (st->chip_config.magn_en)
+		nb_byte += INV_MPU9X50_BYTES_MAGN;
+	if (st->chip_config.temp_en)
+		nb_byte += INV_MPU6050_BYTES_PER_TEMP_SENSOR;
+
+	/* compute watermark size, use a threshold to keep some data space for read latency */
+	new_size_byte = val * nb_byte;
+	if (new_size_byte > ((st->hw->fifo_size * 4) / 5)) {
+		val = ((st->hw->fifo_size * 4) / 5) / nb_byte;
+		new_size_byte = val * nb_byte;
+	}
+
+	ret = inv_mpu6050_set_hw_watermark(st, new_size_byte);
+	if (ret)
+		return ret;
+
+	st->chip_config.wm_val = val;
+
+	return 0;
+}
+
 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
 					int clock, int temp_dis)
 {
@@ -1290,6 +1353,39 @@ static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int inv_mpu6050_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (st->chip_type) {
+	case INV_ICM20602:
+	case INV_ICM20690:
+		mutex_lock(&st->lock);
+		ret = inv_mpu6050_compute_hw_watermark(st, val);
+		mutex_unlock(&st->lock);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int inv_mpu6050_hw_flush_to_buffer(struct iio_dev *indio_dev,
+				      unsigned int count)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = inv_mpu6050_flush_fifo(indio_dev, 0, count);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info mpu_info = {
 	.read_raw = &inv_mpu6050_read_raw,
 	.write_raw = &inv_mpu6050_write_raw,
@@ -1297,6 +1393,8 @@ static const struct iio_info mpu_info = {
 	.attrs = &inv_attribute_group,
 	.validate_trigger = inv_mpu6050_validate_trigger,
 	.debugfs_reg_access = &inv_mpu6050_reg_access,
+	.hwfifo_set_watermark = &inv_mpu6050_set_watermark,
+	.hwfifo_flush_to_buffer = &inv_mpu6050_hw_flush_to_buffer,
 };
 
 /*
@@ -1618,7 +1716,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		 */
 		result = devm_iio_triggered_buffer_setup(dev, indio_dev,
 							 iio_pollfunc_store_time,
-							 inv_mpu6050_read_fifo,
+							 inv_mpu6050_interrupt_handler,
 							 NULL);
 		if (result) {
 			dev_err(dev, "configure buffer fail %d\n", result);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index c6aa36e..d925885 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -57,6 +57,8 @@ struct inv_mpu6050_reg_map {
 	u8 temperature;
 	u8 int_enable;
 	u8 int_status;
+	u8 wm_th_hb;
+	u8 wm_th_lb;
 	u8 pwr_mgmt_1;
 	u8 pwr_mgmt_2;
 	u8 int_pin_cfg;
@@ -121,6 +123,8 @@ struct inv_mpu6050_chip_config {
 	unsigned int magn_fifo_enable:1;
 	u8 divider;
 	u8 user_ctrl;
+	unsigned int wm_val;
+	unsigned int wm_size;
 };
 
 /*
@@ -264,8 +268,19 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
 
+#define INV_ICM20602_REG_FIFO_WM_INT_STATUS 0x39
+#define INV_ICM20602_BIT_FIFO_WM_INT        0x40
+
 #define INV_MPU6050_REG_EXT_SENS_DATA       0x49
 
+#define INV_ICM20602_FIFO_WM_TH_HB          0x60
+#define INV_ICM20602_BITS_FIFO_WM_TH_HB     0x03
+#define INV_ICM20602_FIFO_WM_TH_LB          0x61
+
+#define INV_ICM20690_FIFO_WM_TH_HB          0x5E
+#define INV_ICM20690_BITS_FIFO_WM_TH_HB     0x03
+#define INV_ICM20690_FIFO_WM_TH_LB          0x61
+
 /* I2C slaves data output from 0 to 3 */
 #define INV_MPU6050_REG_I2C_SLV_DO(_x)      (0x63 + (_x))
 
@@ -338,7 +353,6 @@ struct inv_mpu6050_state {
 #define INV_ICM20690_GYRO_STARTUP_TIME       80
 #define INV_ICM20690_ACCEL_STARTUP_TIME      10
 
-
 /* delay time in microseconds */
 #define INV_MPU6050_REG_UP_TIME_MIN          5000
 #define INV_MPU6050_REG_UP_TIME_MAX          10000
@@ -457,7 +471,7 @@ enum inv_mpu6050_clock_sel_e {
 	NUM_CLK
 };
 
-irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
+irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p);
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
 int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
@@ -468,5 +482,8 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
 extern const struct dev_pm_ops inv_mpu_pmops;
+int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned int wm_size_byte);
+int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int wm_size_byte);
+int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev, s64 timestamp_val, unsigned int count);
 
 #endif
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 45c3752..d6e6246 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -40,15 +40,16 @@ static void inv_mpu6050_update_period(struct inv_mpu6050_state *st,
 	if (st->it_timestamp == 0) {
 		/* not initialized, forced to use it_timestamp */
 		use_it_timestamp = true;
-	} else if (nb == 1) {
+	} else if (nb == st->chip_config.wm_val) {
 		/*
 		 * Validate the use of it timestamp by checking if interrupt
 		 * has been delayed.
-		 * nb > 1 means interrupt was delayed for more than 1 sample,
+		 * nb > wm_val means interrupt was delayed for more than 1 sample,
 		 * so it's obviously not good.
+		 * If watermark does not exist for the chip, wm_val = 1.
 		 * Compute the chip period between 2 interrupts for validating.
 		 */
-		delta = div_s64(timestamp - st->it_timestamp, divider);
+		delta = div_s64(timestamp - st->it_timestamp, divider) / st->chip_config.wm_val;
 		if (delta > period_min && delta < period_max) {
 			/* update chip period and use it timestamp */
 			st->chip_period = (st->chip_period + delta) / 2;
@@ -89,6 +90,25 @@ static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
 	return ts;
 }
 
+int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned int size)
+{
+	int ret;
+
+	if (size == st->chip_config.wm_size)
+		return 0;
+
+	ret = regmap_write(st->map, st->reg->wm_th_hb, (size >> 8) & 0xFF);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, st->reg->wm_th_lb, size & 0xFF);
+	if (ret)
+		return ret;
+
+	st->chip_config.wm_size = size;
+	return 0;
+}
+
 static int inv_reset_fifo(struct iio_dev *indio_dev)
 {
 	int result;
@@ -104,43 +124,33 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
-	result = regmap_write(st->map, st->reg->int_enable,
-			      INV_MPU6050_BIT_DATA_RDY_EN);
-
+	switch (st->chip_type) {
+	case INV_ICM20602:
+	case INV_ICM20690:
+		result = inv_mpu6050_set_hw_watermark(st, st->chip_config.wm_size);
+		break;
+	default:
+		result = regmap_write(st->map, st->reg->int_enable,
+				INV_MPU6050_BIT_DATA_RDY_EN);
+	}
 	return result;
 }
 
-/*
- * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
- */
-irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
+int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev,
+				      s64 timestamp_val, unsigned int count)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	size_t bytes_per_datum;
-	int result;
 	u16 fifo_count;
 	s64 timestamp;
-	int int_status;
+	int result;
 	size_t i, nb;
-
-	mutex_lock(&st->lock);
-
-	/* ack interrupt and check status */
-	result = regmap_read(st->map, st->reg->int_status, &int_status);
-	if (result) {
-		dev_err(regmap_get_device(st->map),
-			"failed to ack interrupt\n");
-		goto flush_fifo;
-	}
-	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
-		goto end_session;
+	size_t bytes_per_datum;
 
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
 		st->chip_config.magn_fifo_enable))
-		goto end_session;
+		return 0;
+
 	bytes_per_datum = 0;
 	if (st->chip_config.accl_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
@@ -161,7 +171,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	result = regmap_bulk_read(st->map, st->reg->fifo_count_h,
 				  st->data, INV_MPU6050_FIFO_COUNT_BYTE);
 	if (result)
-		goto end_session;
+		return 0;
 	fifo_count = be16_to_cpup((__be16 *)&st->data[0]);
 
 	/*
@@ -171,18 +181,31 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	 */
 	nb = 3 * bytes_per_datum;
 	if (fifo_count >= st->hw->fifo_size - nb) {
-		dev_warn(regmap_get_device(st->map), "fifo overflow reset\n");
-		goto flush_fifo;
+		dev_warn(regmap_get_device(st->map), "fifo overflow\n");
+		inv_reset_fifo(indio_dev);
+		return -1;
 	}
 
 	/* compute and process all complete datum */
 	nb = fifo_count / bytes_per_datum;
-	inv_mpu6050_update_period(st, pf->timestamp, nb);
+	/*
+	 * As fifo_size may differ according to the chip unsigned
+	 * count = 0 is used to choose the max value for count
+	 */
+	if (count == 0)
+		count = st->hw->fifo_size / bytes_per_datum;
+	if (timestamp_val != 0)
+		inv_mpu6050_update_period(st, timestamp_val, nb);
+	if (nb > count)
+		nb = count;
 	for (i = 0; i < nb; ++i) {
 		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
 					   st->data, bytes_per_datum);
-		if (result)
-			goto flush_fifo;
+		if (result) {
+			inv_reset_fifo(indio_dev);
+			return result;
+		}
+
 		/* skip first samples if needed */
 		if (st->skip_samples) {
 			st->skip_samples--;
@@ -192,6 +215,45 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 	}
 
+	return i;
+}
+
+/*
+ * inv_mpu6050_interrupt_handler() - Transfer data from hardware FIFO to KFIFO.
+ */
+irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int result;
+	int int_status;
+	int int_status_bit;
+
+	mutex_lock(&st->lock);
+
+	/* ack interrupt and check status */
+	result = regmap_read(st->map, st->reg->int_status, &int_status);
+	if (result) {
+		dev_err(regmap_get_device(st->map),
+			"failed to ack interrupt\n");
+		goto flush_fifo;
+	}
+
+	switch (st->chip_type) {
+	case INV_ICM20602:
+	case INV_ICM20690:
+		int_status_bit = INV_ICM20602_BIT_FIFO_WM_INT;
+		break;
+	default:
+		int_status_bit = INV_MPU6050_BIT_RAW_DATA_RDY_INT;
+		break;
+	}
+	if (!(int_status & int_status_bit))
+		goto end_session;
+
+	inv_mpu6050_flush_fifo(indio_dev, pf->timestamp, 0);
+
 end_session:
 	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 8825468..c685ed4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -131,10 +131,28 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 		if (ret)
 			return ret;
 		/* enable interrupt */
-		ret = regmap_write(st->map, st->reg->int_enable,
-				   INV_MPU6050_BIT_DATA_RDY_EN);
+		switch (st->chip_type) {
+		case INV_ICM20602:
+		case INV_ICM20690:
+			/* watermark interrupt is enabled by setting the watermark value */
+			ret = inv_mpu6050_compute_hw_watermark(st, st->chip_config.wm_val);
+			break;
+		default:
+			ret = regmap_write(st->map, st->reg->int_enable,
+					INV_MPU6050_BIT_DATA_RDY_EN);
+			break;
+		}
 	} else {
-		ret = regmap_write(st->map, st->reg->int_enable, 0);
+		switch (st->chip_type) {
+		case INV_ICM20602:
+		case INV_ICM20690:
+			/* watermark interrupt is disabled by setting the watermark value to 0 */
+			ret = inv_mpu6050_set_hw_watermark(st, 0);
+			break;
+		default:
+			ret = regmap_write(st->map, st->reg->int_enable, 0);
+			break;
+		}
 		if (ret)
 			return ret;
 		ret = regmap_write(st->map, st->reg->fifo_en, 0);
-- 
2.25.1

