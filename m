Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CDC100389
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKRLJW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 06:09:22 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:65318 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfKRLJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 06:09:22 -0500
X-Greylist: delayed 2067 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Nov 2019 06:09:21 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIAYBRD009043;
        Mon, 18 Nov 2019 02:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=SYRkL6VXqVYgfiYaIoQcYWjnIcIbHCBw8Le4rFPpD1s=;
 b=dznLj6O0ZfozY47XaWkz3lmgJfEozDqDZ78W2QBHtOAg7+k2sjfYrJJ10Z9F6Girw+Dc
 4Mwfjdx3yMlejp+NFWvS+TmU8EYwUDlTBlyFLBY2LREhVhPWzUEBa90H1OACtBmom4aB
 HQYwaL1Yb/OIzNL2ZEOjpdjGJKMNC0tvZ8wNU1q1ULkzIwo95avfjMtLNQupnLdxS7lK
 X9QE29tcx6imhQlpiRPVnrJd3cuy2BiqJkQdyYI0Z7oHv1YjvyH+LSJlMeDQ5xSn2lTf
 oUJDH2ztJZJHbbcBXXQBJMzz5hV/msgTwr/Zrpry4eVUmv3tlR6ExhMcJ9ZsstwodEg2 BQ== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-00328301.pphosted.com with ESMTP id 2wbb1h0bhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 02:34:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3G/+PFzSzLV4JnjGLCs6y0JxI0R/w1azdpkvYeRs5xWcKlRnfJqKqvQynUUWgJfwCCt6Rv7UE6vPV4BBU/oQc88RggDIJNvl3PkaNWSOJQGcmlabD4U/buEfOd2dr/wobvYE3LESIAEe0Y/MKMjhVXcJfssZyWvqRFYXQonL4BG3nOgn3sdCAEUfqbn2TNiQGNNIjQZ5oYwZstNgBmFQwd8VBHEfGWWr+hT7OfUS3YKfijKEEo0rF8N1skdWOwLvKdU9NL8RfDAizhFOfB+hf2VoU7og2EALDHR4SkhKUAPNtiA2v98rLePLmC4FAHkGj0Caf835YuJj0fBEeAIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYRkL6VXqVYgfiYaIoQcYWjnIcIbHCBw8Le4rFPpD1s=;
 b=lIazUj9SNjli4ahMRG6gjJthkXXZCCKYbV3qJNb36Fj/X52Hq6TnoKXQePINieerpLwZgxg1kvZNynIqpkmSCJ6ibisGNcPUn0zicH5TP7U9jv++u/+C04Q2MSiUIN8IyDaKHt47nh/Kceo8fy4lXfQGK+Ca5tamShqlD4FKSLCG3LeJnFebH8kNQTvm9WGQV9kMxekS5iG1A/hDiKCeMIYg8gaq8AhvLUV5Hst/BZU967ZbP1dEFBX/IiWphdrFR2+EShsvbvUo1CbU3yMlWpQu+0qAl89Wq3JDU2k0VCNYmYPrRRwFhCeh3be+sz91Q0A+NJbaoW2G0otkBs5A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYRkL6VXqVYgfiYaIoQcYWjnIcIbHCBw8Le4rFPpD1s=;
 b=Nh3uO1Mu2N9bRU/TzJyUsfwEMwgSYecZ4ntg3QtHLREn4wFLWHVMNQvCWzBfKHITEOHQ5gjVuALtCKrPBFgK4ryIKLOQKwifA8++DkXpF587DAQ0XK+t87nZAsqjkGALXzJN/c5ng8n+ehEY2ZZxOUl9NZd4kE86dRe3lB3TGR8=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3248.namprd12.prod.outlook.com (20.179.80.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 10:34:40 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 10:34:39 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 1/2] iio: imu: inv_mpu6050: fix temperature reporting using bad unit
Date:   Mon, 18 Nov 2019 11:34:05 +0100
Message-Id: <20191118103406.9353-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55067a39-bdc3-4a93-91a1-08d76c12ea5b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB324804B72F8EE09B9E917915C44D0@MN2PR12MB3248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39850400004)(136003)(396003)(189003)(199004)(1076003)(2906002)(5660300002)(2361001)(4326008)(476003)(16586007)(107886003)(36756003)(50466002)(6512007)(48376002)(316002)(14454004)(6666004)(7736002)(25786009)(6116002)(305945005)(80792005)(2351001)(486006)(6486002)(52116002)(81166006)(51416003)(8676002)(3846002)(99286004)(6436002)(186003)(26005)(6916009)(8936002)(478600001)(47776003)(2616005)(86362001)(6506007)(386003)(50226002)(81156014)(66946007)(66066001)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3248;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW4b6nCuzRSMcQNOpMDwtKF5/cNQsVo8Xvd9+J22zXsXG/YCJA6eu5L9I2WpLMxsYiIdLoxVd4t8WvFVY3YnIxx13wpxmBV1p6zsvA/3dE/4qhtA2FoSokiRH85m41iom+32JhNcD7c2g8/Xsce7sR9N+fIRz3lnVKQ1ZqL2iVqkZVAbYMxeoXeUtgRHmknIbPWD2hLPXWeJpIc9wHf8QYp1cYVH4EPKjBOrWIsGHoeDTrG/88lPelBV75xiYEopOI32Lef8aDhJzgl8pP9ycF9dCf1SIg1S2pqIbMsJw9akhIp8zNx8es6F3y5tQZfPS4VauEAD4kklypPKSZOuinWPfPTgTlaANf1B1Rv0M35XaCNJ4d0j5gwaH+9em3kkSmqdfJJsd8zwSYCXJ4av0UmmOO7YAEZ+KZY+XmgfVRj9EoJN390pkRJCu8RdbCCt
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55067a39-bdc3-4a93-91a1-08d76c12ea5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 10:34:39.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9OMTrbV6N33rNZMyxc2LRvUJdvvTq3ItyqMRhw8yBoa8Q1Mnqlp4N7OD0tyY/NtDD0n6vIo1LBZQQtuBWLP2uJcaZQpPkv0VR//+MulzW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=1 clxscore=1015 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Temperature should be reported in milli-degrees, not degrees. Fix
scale values to use the correct unit.
Fix round-up offset value for MPU6050 and add the values for
MPU6500 family (different from MPU6050).

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 23 +++++++++++-----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 16 +++++++++++----
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 23c0557891a0..268240644adf 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -117,6 +117,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
+		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_MPU6500_WHOAMI_VALUE,
@@ -124,6 +125,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 		.fifo_size = 512,
+		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_MPU6515_WHOAMI_VALUE,
@@ -131,6 +133,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 		.fifo_size = 512,
+		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_MPU6000_WHOAMI_VALUE,
@@ -138,6 +141,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
+		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_MPU9150_WHOAMI_VALUE,
@@ -145,6 +149,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
+		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_MPU9250_WHOAMI_VALUE,
@@ -152,6 +157,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 		.fifo_size = 512,
+		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_MPU9255_WHOAMI_VALUE,
@@ -159,6 +165,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 		.fifo_size = 512,
+		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_ICM20608_WHOAMI_VALUE,
@@ -166,6 +173,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 		.fifo_size = 512,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 	},
 	{
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
@@ -173,6 +181,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_icm20602,
 		.config = &chip_config_6050,
 		.fifo_size = 1008,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 	},
 };
 
@@ -481,12 +490,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = 0;
-			if (st->chip_type == INV_ICM20602)
-				*val2 = INV_ICM20602_TEMP_SCALE;
-			else
-				*val2 = INV_MPU6050_TEMP_SCALE;
-
+			*val = st->hw->temp.scale / 1000000;
+			*val2 = st->hw->temp.scale % 1000000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_MAGN:
 			return inv_mpu_magn_get_scale(st, chan, val, val2);
@@ -496,11 +501,7 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			if (st->chip_type == INV_ICM20602)
-				*val = INV_ICM20602_TEMP_OFFSET;
-			else
-				*val = INV_MPU6050_TEMP_OFFSET;
-
+			*val = st->hw->temp.offset;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index f1fb7b6bdab1..b096e010d4ee 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -107,6 +107,7 @@ struct inv_mpu6050_chip_config {
  *  @reg:   register map of the chip.
  *  @config:    configuration of the chip.
  *  @fifo_size:	size of the FIFO in bytes.
+ *  @temp:	offset and scale to apply to raw temperature.
  */
 struct inv_mpu6050_hw {
 	u8 whoami;
@@ -114,6 +115,10 @@ struct inv_mpu6050_hw {
 	const struct inv_mpu6050_reg_map *reg;
 	const struct inv_mpu6050_chip_config *config;
 	size_t fifo_size;
+	struct {
+		int offset;
+		int scale;
+	} temp;
 };
 
 /*
@@ -279,16 +284,19 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_UP_TIME_MIN          5000
 #define INV_MPU6050_REG_UP_TIME_MAX          10000
 
-#define INV_MPU6050_TEMP_OFFSET	             12421
-#define INV_MPU6050_TEMP_SCALE               2941
+#define INV_MPU6050_TEMP_OFFSET	             12420
+#define INV_MPU6050_TEMP_SCALE               2941176
 #define INV_MPU6050_MAX_GYRO_FS_PARAM        3
 #define INV_MPU6050_MAX_ACCL_FS_PARAM        3
 #define INV_MPU6050_THREE_AXIS               3
 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
 
-#define INV_ICM20602_TEMP_OFFSET	     8170
-#define INV_ICM20602_TEMP_SCALE		     3060
+#define INV_MPU6500_TEMP_OFFSET              7011
+#define INV_MPU6500_TEMP_SCALE               2995178
+
+#define INV_ICM20608_TEMP_OFFSET	     8170
+#define INV_ICM20608_TEMP_SCALE		     3059976
 
 /* 6 + 6 + 7 (for MPU9x50) = 19 round up to 24 and plus 8 */
 #define INV_MPU6050_OUTPUT_DATA_SIZE         32
-- 
2.17.1

