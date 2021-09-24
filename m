Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFA4173A0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhIXM7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 08:59:15 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:36388 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344441AbhIXM4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Sep 2021 08:56:16 -0400
X-Greylist: delayed 1333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 08:56:16 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O1ekVB030868;
        Fri, 24 Sep 2021 05:32:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt1; bh=WxJFbOhw3CONrnBoyMTSI+4SIX9ve1aVHqc+u7/FHBA=;
 b=TWt9FYTCT1TBMZStedy2QdSEu8oMMCMbuLDL2eHHQFwUVFpYIBq1ahz3A5TTYJQ+2UzA
 7WTq8ysIni8Tru/bf/BGBXgD+MysHovETVD//o9zzTTzFPO+LBr90tw/MJS8i6S1f4m7
 JhKjnlY2aE+HAsZIxP62tHzosgIcpFFxufSj8M5h0sNvIw5A97V/bdvnEzz+dhVXYRB6
 tJtNo/CTSa9/j4nA786RlijGyowoqNNHyJKu3BhYfjYFfmqNtiBer8fZ8THAg64oyoed
 8H6QAoJPLMGFh/uqZ+qqWI0/muwglmahB9bQ56pEDYDXROynXJgJxN3McRcvngXMdm0N NA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00328301.pphosted.com with ESMTP id 3b93fgged0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 05:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU4ki3Ibrc+p/P590/dAjsLek8ma1z9j0Ctw4r1VZ2iTftLjkD38dhfUqu+dCTxiN5n0sTZZH20J4G/Q7Jb77xoRLUqLtGo9NGqzVZhuO4ayW1ec/0o3sZVWQnGoqej88LLe2XAspT/R6i0zoqSxBoQIzA8rW17ZY4AjxKie+HIRX1Tt2cF4O1LCO67LxFIsWysFUptfaHci64mxup6AVmBD7uT+nwJzJ1GrGQir0jYlgMIzqf/sFE9sZOVuLoTcD1iCQ4fgTQ+AZ5MVPkepalhiVX108EcW6BoeMuycKl8qS5be3w+LWQq9lCDzrJ+qQhwlO44KqUnRoITvs5e3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WxJFbOhw3CONrnBoyMTSI+4SIX9ve1aVHqc+u7/FHBA=;
 b=fmnf72RFMZSnkFp4H+v+sPNJ4cxz3nlewapba3OV2UiBMLPSaSldW3tvzCpFpS9mtj1Qxf3cAFb49F249wxQs8U2qTE1Fs5/CgO8ZITthWT2vCpVmb6C39SkusDBSUh70ndL2p7JKw7P2kLPi8GmvMaKfAGEqHVaQiOntRkuRQ6eaHeKeTD3Hzw45EavXoLAT2zmCaKVy2vyi55WM++8diF0zW0Cn57sD2WUuWx7sMTUn5OpXVStBXP2Q9BC3vHOnKYrFAHZrvnnVw1vAQbNdx/rZvLLQpggahjDKBUt4tNtAKjOMCmZ8DSf29CVKm6x6QnpB4IqeKNPLtHz7Vs/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxJFbOhw3CONrnBoyMTSI+4SIX9ve1aVHqc+u7/FHBA=;
 b=UFNuIsnQsigZlQHVBB5hWPhRIUWrpXpPAE5Gwg5pusiNr5woY+/aIIKyjFLaPO0xDD3d7Gog8jaxchS0qQW5yAI4cl9KEuBbnIh3HBzorhObasOWLZSVeFIaO2cHPs8CyO2KqI0eDLBv+U5ij+EiGDmnEKgFuKmKYyorMjeVWU0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 12:32:13 +0000
Received: from BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::8880:75b:9bf:6d6b]) by BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::8880:75b:9bf:6d6b%5]) with mapi id 15.20.4523.023; Fri, 24 Sep 2021
 12:32:13 +0000
From:   Baptiste Mansuy <bmansuy@invensense.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Baptiste Mansuy <bmansuy@invensense.com>
Subject: [PATCH v2] iio: imu: mpu6050: add watermark support for icm20602/20690
Date:   Fri, 24 Sep 2021 14:31:24 +0200
Message-Id: <20210924123124.25831-1-bmansuy@invensense.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::8) To BYAPR12MB2901.namprd12.prod.outlook.com
 (2603:10b6:a03:138::32)
MIME-Version: 1.0
Received: from FRGNB-2THMRC2.invcorp.invensense.com (77.157.193.39) by LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:192::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 12:32:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8392e37-9644-4b6f-3eee-08d97f5755e9
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-LD-Processed: 462b3b3b-e42b-47ea-801a-f1581aac892d,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016B2BB4CCCDF3D866F96E6DEA49@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxBMjYYgG4OA6qfiwxwlA0gUfv/TE8dxP1Y1rKIRfHI7t1CQUjtFjPwYnO0if2/RZv5mCgMH2/i4RxFp2T3p72llb1AKJCoRvaJ8AcX7Nf+b+rGTMNDI+6B5tGuNJfeLpFknaAtNPyyOZdocz8dfGON5S1oxSIA+uesqLGSoTSshZPe0K4tMHM2CIRQvs7JrR+gA7DC6PG9qZwWCmol6ePs4asWkrcflgWdewHbzpXRSlf48Plct9JBeC1x6a+oTZgjElcTcM5pLvDLl+X2iBivnDI8u1akJK4e8uLkoO940xa3ImUByktBAbVruslPOdkx3oxCOVZljXV6vVIneVJTpLEncWm2uVN6nA/NEnuKIQ8VfPbTrtNQWw3O2yEnppW8atfrVErsMYoZwzeKDtZCq4nr6PN5Pvklfqjls1t1SOVSKXFSmfSNFmbOJ5PATV7MEP+FlmJe9H7vbRVArGm6B2WctlOneM9Q5zi0fko1z70F6UAKGPesvEWnUsL9aCzTxUAv750ypKOGwf7OIkh+2IY5QW3Rk85O/UYJ02wUKqJrlhzBkM1Xvw9RtAdSEojgVnJNhqXW6A+gLLQIacCj7jC5+47sVRLi6nl48t6magZ5fLqwmIuuqJc6zIkwMRBv4WgW8Nii8VYRYYgDqEMbu7hu6aPYxfhaVH5SLIs4MtyzVBgvZzJkY4Yh3VFKm95MQux6haX0kxSDUIKmk+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(107886003)(508600001)(30864003)(66476007)(83380400001)(186003)(1076003)(36756003)(38100700002)(26005)(956004)(66556008)(66946007)(38350700002)(4326008)(7696005)(6666004)(86362001)(2906002)(316002)(8936002)(2616005)(6486002)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7PREabRtH+ruqhDhUqAQrY+o+O2ux8PEm+b+63eLrV3zzMPvxkg7M23oplb?=
 =?us-ascii?Q?CJlVIvdk/4EUxf52Z3ySdO9iCT0YmKnjq8qroNKc95l4jlCUHUBNq4PxKGDr?=
 =?us-ascii?Q?2933ZXafCiZOpPJp9gSW0gqz8UMhXWMVzRN2JvsuqzBOAMUnHYMMOQoePwmf?=
 =?us-ascii?Q?FHpdpOHmnH/lzyM+kjQRFybdffpcOwNmxlkIUAbQyRovh5F4hHaAfFwDKRZ7?=
 =?us-ascii?Q?vtNlcTjpk2d1KGE2Su4UhcjYp0egTc8eXOO3BIAEmaKmE1zk/WDJYGVHdtMH?=
 =?us-ascii?Q?qRDO+pigcfj/iz8E8y+jpymJYzU5zmM7c0f4v/LeerkOfBICYpKUsIv2rf1g?=
 =?us-ascii?Q?aoqiVNWU4nGKa7leRtFuBXJOv59LbxCHFIP46lgHDCTyruQ/iZtGStdxzidi?=
 =?us-ascii?Q?67KWoQ42iJLkp9ebo7+yc3xoU0UjzUAlTDVXFXGsVVCworH1m8RlwRjGNbX/?=
 =?us-ascii?Q?TGj4LJO+n9mh+HnKxvM+tcZUmbx2E3RcqgYOWtAyevKxxiLnLTZl8mdpqJQ3?=
 =?us-ascii?Q?9SnMwFiSOtYp3AWZJIlyLlR4+wA1LOXr6Cbz4ptYPTR4zbF8V9JDniXwMr5i?=
 =?us-ascii?Q?OtKt01o5R2pSjMOK7403+IAkuwI02Vw4PjZayBB+lGZ6D9POPEM8DjbhsRQ9?=
 =?us-ascii?Q?PcPS1qaOVkCnT3QwczCittvT83T2CJqB9rbsh4hFN3IEG/lx4h/jgydKyXJ+?=
 =?us-ascii?Q?OGd4k2aiAPToRCBbn/FZ0H+gFNPjjNaVWPSBaLSq3/m/nBKzJWt2FwUP/tHQ?=
 =?us-ascii?Q?uN2E5Dl1qPbRZT+Iy+n2xkTLVKAiu1EfkeJJQQREVC0VaKncDu2ccAD6fSLr?=
 =?us-ascii?Q?xJsjysoYt8Kc/J9ho4qKzoRYFMJe/ucV7EM3+Hl9EgAii0CvZXBcilF/RN1B?=
 =?us-ascii?Q?6cRYRAAZ+/cvBb1hKoBs0Gj86D+YV8x5BIn9Ktqqy61HkE7v4G3d/jonKmKr?=
 =?us-ascii?Q?md9gO7AQJpsDj0zCnR7PARsmrjsaw6IDDG+H9FBn9Ny4H9Is2ZxGEAZK8GGd?=
 =?us-ascii?Q?pQfiN0cxURyJxOXHgGD0ddSNZHbFCVy2x4lYj5v+17DlM9KxXZKjOei+U/bC?=
 =?us-ascii?Q?tNxbUmJnK0OXHjOld3GRDrP2TYWwn2V5nr6XMcdVpezARSSfrnkaXzMRgHiX?=
 =?us-ascii?Q?eXM9oTAMwtvPIJOsCkgV2Hnp7VY39qjYBotonbqePKgoEpLmIscv9u5TJkxh?=
 =?us-ascii?Q?pTqnjByNAHJIqWWXw9AsjcGkr/rMdhrjsGBZbFbYZss3ogYMCN2/3DwySqYE?=
 =?us-ascii?Q?rlQiScWrzE82Ipu+/nscUFwK+Sj5xJ6u655zIbAbiiNhyrHizz+xsYWc6ljN?=
 =?us-ascii?Q?Tp9pF8R9bcWo9ACKVXFznFeV?=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8392e37-9644-4b6f-3eee-08d97f5755e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 12:32:13.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qQkI3NkzQdhq3YElvBJGnBNNQeNla9Vu7BoG4pfD7jdHuxfwetmuDToopccBeyLVsIqpsFtQNTrNHatXDfQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
X-Proofpoint-GUID: 64MN4d4RymT1F5-EpV6WiC5V_wktDSJ6
X-Proofpoint-ORIG-GUID: 64MN4d4RymT1F5-EpV6WiC5V_wktDSJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_04,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240078
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
 V1 -> V2: Changed watermark computation following the latest ABI
 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 195 +++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  23 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 138 ++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  24 ++-
 4 files changed, 339 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 597768c..2f70991 100644
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
@@ -264,6 +295,53 @@ static const struct inv_mpu6050_hw hw_info[] = {
 	},
 };
 
+unsigned int inv_mpu6050_get_sample_size(struct inv_mpu6050_state *st)
+{
+	unsigned int nb_byte;
+
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
+	return nb_byte;
+}
+
+int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int val)
+{
+	unsigned int nb_byte, new_size_byte;
+	int ret;
+
+	nb_byte = inv_mpu6050_get_sample_size(st);
+
+	/*
+	 * Compute watermark size.
+	 *
+	 * Use a threshold when watermark size is not supported by the chip
+	 * to prevent overwriting the first samples of the fifo.
+	 * The threshold creates latency for the computing of the interrupt.
+	 * When using a sampling frequency of 500Hz, the max latency is 12ms.
+	 */
+	new_size_byte = val * nb_byte;
+	if (new_size_byte > st->hw->fifo_size) {
+		val = ((st->hw->fifo_size * 7) / 8) / nb_byte;
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
@@ -1018,6 +1096,70 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
 	}
 }
 
+/*
+ * inv_mpu6050_get_fifo_watermark_max() - Get the max watermark size of current chip.
+ */
+
+static ssize_t
+inv_mpu6050_get_fifo_watermark_max(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int nb_byte;
+	size_t watermark_max_size;
+
+	mutex_lock(&st->lock);
+	nb_byte = inv_mpu6050_get_sample_size(st);
+
+	/* Use default value of accel + gyro + temp sample */
+	if (nb_byte == 0)
+		nb_byte = 2 * INV_MPU6050_BYTES_PER_3AXIS_SENSOR
+				+ INV_MPU6050_BYTES_PER_TEMP_SENSOR;
+	watermark_max_size = st->hw->fifo_size / nb_byte;
+	mutex_unlock(&st->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%zu\n", watermark_max_size);
+}
+
+/*
+ * inv_mpu6050_get_fifo_state() - Get the state of the hwfifo.
+ *
+ * Watermark is disabled when the watermark size is set to 0
+ */
+
+static ssize_t
+inv_mpu6050_get_fifo_state(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int fifo_state = 0;
+
+	mutex_lock(&st->lock);
+	if (st->chip_config.wm_size > 0)
+		fifo_state = 1;
+	mutex_unlock(&st->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_state);
+}
+
+/*
+ * inv_mpu6050_get_fifo_watermark() - Get the current watermark size.
+ */
+
+static ssize_t
+inv_mpu6050_get_fifo_watermark(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int watermark;
+
+	mutex_lock(&st->lock);
+	watermark = st->chip_config.wm_size;
+	mutex_unlock(&st->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", watermark);
+}
+
 /**
  * inv_mpu6050_validate_trigger() - validate_trigger callback for invensense
  *                                  MPU6050 device.
@@ -1258,6 +1400,14 @@ static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
 static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
 	ATTR_ACCL_MATRIX);
 
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_DEVICE_ATTR(hwfifo_watermark_max, S_IRUGO,
+	inv_mpu6050_get_fifo_watermark_max, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
+	inv_mpu6050_get_fifo_state, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
+	inv_mpu6050_get_fifo_watermark, NULL, 0);
+
 static struct attribute *inv_attributes[] = {
 	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,  /* deprecated */
 	&iio_dev_attr_in_accel_matrix.dev_attr.attr, /* deprecated */
@@ -1265,6 +1415,10 @@ static struct attribute *inv_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
 	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
 	NULL,
 };
 
@@ -1290,6 +1444,39 @@ static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
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
@@ -1297,6 +1484,8 @@ static const struct iio_info mpu_info = {
 	.attrs = &inv_attribute_group,
 	.validate_trigger = inv_mpu6050_validate_trigger,
 	.debugfs_reg_access = &inv_mpu6050_reg_access,
+	.hwfifo_set_watermark = &inv_mpu6050_set_watermark,
+	.hwfifo_flush_to_buffer = &inv_mpu6050_hw_flush_to_buffer,
 };
 
 /*
@@ -1618,7 +1807,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		 */
 		result = devm_iio_triggered_buffer_setup(dev, indio_dev,
 							 iio_pollfunc_store_time,
-							 inv_mpu6050_read_fifo,
+							 inv_mpu6050_interrupt_handler,
 							 NULL);
 		if (result) {
 			dev_err(dev, "configure buffer fail %d\n", result);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index c6aa36e..660ebda 100644
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
@@ -105,6 +107,8 @@ enum inv_devices {
  *  @temp_fifo_enable:	enable temp data output
  *  @magn_fifo_enable:	enable magn data output
  *  @divider:		chip sample rate divider (sample rate divider - 1)
+ *  @wm_val:		watermark size in number of data
+ *  @wm_size:		watermark size in bytes
  */
 struct inv_mpu6050_chip_config {
 	unsigned int clk:3;
@@ -121,6 +125,8 @@ struct inv_mpu6050_chip_config {
 	unsigned int magn_fifo_enable:1;
 	u8 divider;
 	u8 user_ctrl;
+	unsigned int wm_val;
+	unsigned int wm_size;
 };
 
 /*
@@ -264,8 +270,19 @@ struct inv_mpu6050_state {
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
 
@@ -338,7 +355,6 @@ struct inv_mpu6050_state {
 #define INV_ICM20690_GYRO_STARTUP_TIME       80
 #define INV_ICM20690_ACCEL_STARTUP_TIME      10
 
-
 /* delay time in microseconds */
 #define INV_MPU6050_REG_UP_TIME_MIN          5000
 #define INV_MPU6050_REG_UP_TIME_MAX          10000
@@ -457,7 +473,7 @@ enum inv_mpu6050_clock_sel_e {
 	NUM_CLK
 };
 
-irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
+irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p);
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
 int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
@@ -468,5 +484,8 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
 extern const struct dev_pm_ops inv_mpu_pmops;
+int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned int wm_size_byte);
+int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int wm_size_byte);
+int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev, s64 timestamp_val, unsigned int count);
 
 #endif
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 45c3752..4c558cf 100644
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
@@ -104,43 +124,44 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
-	result = regmap_write(st->map, st->reg->int_enable,
-			      INV_MPU6050_BIT_DATA_RDY_EN);
-
+	switch (st->chip_type) {
+	case INV_ICM20602:
+	case INV_ICM20690:
+		return inv_mpu6050_set_hw_watermark(st, st->chip_config.wm_size);
+	default:
+		return regmap_write(st->map, st->reg->int_enable,
+				INV_MPU6050_BIT_DATA_RDY_EN);
+	}
 	return result;
 }
 
-/*
- * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
+/**
+ * inv_mpu6050_flush_fifo() - Flush fifo
+ *
+ * @indio_dev:		Device driver instance.
+ * @timestamp_val:	the interrupt timestamp
+ * @count:		Number of data to flush
+ *
+ * This function flushes the fifo using count as the number of data to flush.
+ * As fifo_size may differ according to the chip unsigned
+ * count = 0 is used to set the max size of the fifo for count.
  */
-irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
+
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
@@ -161,7 +182,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	result = regmap_bulk_read(st->map, st->reg->fifo_count_h,
 				  st->data, INV_MPU6050_FIFO_COUNT_BYTE);
 	if (result)
-		goto end_session;
+		return 0;
 	fifo_count = be16_to_cpup((__be16 *)&st->data[0]);
 
 	/*
@@ -171,18 +192,30 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
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
+	nb = min(nb, count);
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
@@ -192,6 +225,45 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
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

