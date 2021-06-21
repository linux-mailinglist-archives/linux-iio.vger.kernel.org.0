Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8365A3AE5A7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jun 2021 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFUJMd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Jun 2021 05:12:33 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:39376 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhFUJMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jun 2021 05:12:33 -0400
X-Greylist: delayed 732 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 05:12:33 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 15L4Sm5t015228
        for <linux-iio@vger.kernel.org>; Mon, 21 Jun 2021 01:58:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt1; bh=5XqIwTvdZ61QZ7iHb2lSUEy+v7L4M1ccLUYGM0myQEA=;
 b=wHwlwTQ4075xPRT8r69OeqqRjvhV0FtRI2V4EJ7+zq6YIDDvSksw+hGNrEpxEX261ENX
 uGnIPkgAl6SEF6iDtd+e3vlOvIFazcQLuzqyE8m7JA3aC6cdZlHw86Z/SKYLP4h1jiFG
 pb+5KkcutkseScnYFNLYQGyvQUQ4jf95rc9IW/mNOg8t+ZuUy7L+ymfXfBUY/ztKv64A
 1J4NGq02UIDDVNJOVNFDtNP/I/BWGNtmhrhcpEuPfgBwoL1NoP0C3Y29vTFU36+ufT22
 EZlA0IlN5nFWYlac/2/7ixsyVOOkZo1HRxdBrZC5cm1GtuqWIe6k4YRNCSh8fHODRyz2 7A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00328301.pphosted.com with ESMTP id 39a8fu0a5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 21 Jun 2021 01:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKTlzk8HZrtV73bpWfXTWuRPtHlpdcKmyI2R0I8xMp6HL7dibnNLNHhXEsso29SaccZEx48uo0g35p/TpbiFzMENuSkgyxFEAMAMQujhjiWu8lAbwkCm38pjoi7lB83Y+//cPZjdkSwSDpBIEl1KgZqHUwmm+ez/8YIVDVP9TFc0uOvUjo/Xsg4f+OS8w2oS+7UHfeZikD3JuU15ka/JgeKiLkQV9tyZ4PzV/ow9Ztrn3W9mJ0qCCfgevDmTpFDrk452Tgpfp5onC16Cq1JnGPA1/GcS8ZixDC8ADooSnyh2lmfKKRPezyLnKY1zq4DKSRLEDi5OpZZGyxkt8jjFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XqIwTvdZ61QZ7iHb2lSUEy+v7L4M1ccLUYGM0myQEA=;
 b=Ou7FSoQy5axp4IoOUaYtTvOVuRJCea6pOLf1ZDRmemL0rHrT62imBqszQn4F74Rfjp5lIGz/d1JBHI7mHx47nCqUO5TpD+zKdDDT4ontH/hjbLCPN9xrS1sZSqLEgVnoCWmXMlkoW1tInWUFsr4ckOmEz26zLYX/mGEmUxnVoEm6+RrToFn/jpJNYsSN4BJZ5f1c65z3keoAhUlbE7x8DkTZ4o3v0L7dfdNnJfAhWnEaPGBTrygA86Beg4qccrPMrgx/E7G4lGW5vhFZqNp7/Ej+t9InJ76fY9K/Kv8IhMRZkXvLBsZontyxGbbQyPEPs/kYQhayJBiDR8NhKMN3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XqIwTvdZ61QZ7iHb2lSUEy+v7L4M1ccLUYGM0myQEA=;
 b=cQOMfKSPw+mdubaXjSK3rBGa7k1xN8blbgvZqLLASrBKcMMsmj2suwjzb7telYa+nS2atWIRDb3gyMaFn/QTNuKuF9tL86PAl47hftlpoUL6jWeQka6FIWndqw4VntO3Yb9a4mGkxt5cC7Tbp46iX6x4f1MK8QnnJ2My5i4sPB4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=invensense.com;
Received: from BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 08:57:56 +0000
Received: from BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::f02a:9efc:d2a7:912a]) by BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::f02a:9efc:d2a7:912a%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 08:57:56 +0000
From:   Baptiste Mansuy <bmansuy@invensense.com>
To:     linux-iio@vger.kernel.org
Cc:     Baptiste Mansuy <bmansuy@invensense.com>
Subject: [PATCH] Add startup time for each chip using inv_mpu6050 driver
Date:   Mon, 21 Jun 2021 10:57:31 +0200
Message-Id: <20210621085731.9212-1-bmansuy@invensense.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [77.157.193.39]
X-ClientProxiedBy: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To BYAPR12MB2901.namprd12.prod.outlook.com
 (2603:10b6:a03:138::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from FRGNB-2THMRC2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 08:57:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821286bb-ab6b-4edb-c71e-08d93492a972
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39374B6AFBD89553AF6241CFDE0A9@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VL4W0wVrRy1S3fDvw9pG4UO3zPjd7QQh9+Bqzutl6Bji/JxZENYd5uMDU390Hn29aorFLyOjP6z4s+YDQr0bJoCJUODdWkPM6xKFtYvfbTtx6Rt1ifQSgSY6l1ZF6IY/0/JuFzRc62DZAGNNhkLdOu5xwQxB+PhZ+yzD9RdhiDaMU1Od5sreqlOcLKRUbuUM+3KGIaxBZyKvpI/pu87haypHl74J9g7nogcemlIpKnnexUWAtWswM37riRfBuRfCIVYc1Q48e8iYjRyuZ8oUKpAjn1x2/v+YIXG4QtIQ/J96mVE985hI0h/6SQzNpyItSpOXJ7RBOAYdoDfPtOpKNj5rA/kazYTaXSESvvE6z2K4llUIdPEHnukNU4/i05tTykCh2/uTXfhTxLC+13nJxi9+s9/s5A24KHuVxdYSJXM6TwEDY/6f5fvDVz0yBfFD3sNVU8INnc2GMhpcLqWF/N8ZQMgqm66J8ABKC2Hr4JG3b2bYSSW8qZ8Yk7Ltx+tPdjsrpK8xi6eh9jqbulA0q0sRRYI46Y156fnjnX0v5dEhIwInUE8PuLC/EmtcY/jskHA33rfJKWeNKQfFcn8pexNVSz/wm7awfRoRgKcWF2MZIDlAX4kFCj5Wjn1wU1crBmngJAOYw3T79aAp8YTrNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(346002)(376002)(366004)(86362001)(6486002)(36756003)(83380400001)(4326008)(2616005)(956004)(16526019)(38100700002)(6916009)(107886003)(8936002)(8676002)(1076003)(66476007)(66556008)(66946007)(2906002)(38350700002)(26005)(186003)(7696005)(52116002)(478600001)(316002)(5660300002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OwsupBOsBL8IHNSKtyVLsxZJTGSz2XLSebGUHqvoyq/shTqYWLfGiaiuiCy0?=
 =?us-ascii?Q?ul+gU6Bo8Mr8GznkvrK4A3wvyy98Mec2bfcHbVKIpOWgSD0ik6mOwSku1VTk?=
 =?us-ascii?Q?rKTU4VEDoL6+Pvu3IfQXN7ryg+4W/nQhf1lR6d4E3zzCPTh8Cj4E7SOLP+FU?=
 =?us-ascii?Q?PiTGkbeS/Z4qwfq0toGAGRaGF2wgYkvQoNlzSM5/nLZeP0dOgkIcw5pbYcbW?=
 =?us-ascii?Q?L/NwUyRUcqWFO7vdea7v1RG8MQ8enCQ2L78RQNCUgMPIOEgOE6lCef+xtCrU?=
 =?us-ascii?Q?5fWt6AwNmYEEghX/eMTGH6W90Vq6FfY2RIYDLSdHIea3Kh1eH0OMRqcFHam2?=
 =?us-ascii?Q?QoPPHfTnFDkfWSZcy8jCZ3R03L3YzYufw+TQe3Gi/Ce9eDb/MNBn6IDQdU5W?=
 =?us-ascii?Q?UtpxnRXSh3XJ6EEyFuA2f5On/gxup2RW6UMMO9T8ds7JoLhs29vvAPnHYjgR?=
 =?us-ascii?Q?sTT9Zby+4zF9v8iJWn/y6GK2QDCIWIPUXgZiCWzMPTsQ6L75Y8B23q2l8L6S?=
 =?us-ascii?Q?PhAPvdM+Gbd29j2d7PhOnXNu5yNYfxpYz4TSHw+rPiYFr/86d5mm1QZKTYjc?=
 =?us-ascii?Q?+4FErcobgcTgnx+mgvZlNxQDt8/NEUGTEQN9vzwJfcZXIoaLFkfHbJkZnRV1?=
 =?us-ascii?Q?jIdGVSdE/hVZqrdqrc67/chSW8+/yhUz5hVTVyEH15Dq8IlKePYlAMe5UKLl?=
 =?us-ascii?Q?1+W64zj+HaVJsxSO6ZBjwXxITOMJzDmjCwhsnyNRgYPifWgdT3Cun9b62WDf?=
 =?us-ascii?Q?3z+YOpefmyyhOC+27LHeets2A81HEL5Vr8Xswfu1XyftQhvq6jukwGF2pvPU?=
 =?us-ascii?Q?Aq1D582HQeItuoxqjIUlLqJj6LrUurLH4JGICnxZ/USUF3JqTnbEdiKQfQZa?=
 =?us-ascii?Q?CrOsGhTJObN6GmjCs+iPeu9u8UprBusntvUyjoFnm3tuoEEXERJup69rcOtL?=
 =?us-ascii?Q?7qew0Hv5o1/VsvVVwWQEWKebvfAOFaeEgKnlHk+HlJ8O2IMrX5ZpaEhufZ1u?=
 =?us-ascii?Q?PweNUjuYs9GaFQ3WF7sr6ivxeSL+C0t0H0vLN6uXbgCrLZ/Z5gHQ9K8VwYaW?=
 =?us-ascii?Q?XFBrYlSd/mf+NSQYhWCKx2XKi1lFcmo1MXkfrXUc/pyPegsst6djhU4c9dMP?=
 =?us-ascii?Q?bXojcToUAqRTFxo/NKGoaZ3GItOphnx56IAh7O3KitmOdfil6hacrwxwRx8T?=
 =?us-ascii?Q?sUA3zthL9HA+/DisTdYYNqpgQnArnlfVq4/SJc17RS4NrPQOzlyEXmKWdcxr?=
 =?us-ascii?Q?jvT2LVQ66K6ppoe7iyhynrwwxrZOdrQRE7qWYsZv726pzyyNJcCewcIdL80f?=
 =?us-ascii?Q?3MRa0xbc+cUb+7t4rW4+dzUj?=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821286bb-ab6b-4edb-c71e-08d93492a972
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 08:57:56.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zJgp6KFQ6P1HdNJ+wEy2rweNJ+CWJ/n5kyvVfmuqte0pVKQFY2Jvt2uhJRV0ZEGaaqGY5NW9xlb79IBvOJkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
X-Proofpoint-ORIG-GUID: YHj7_T0lkCj5FOOLnJgRUgVpYef8Bd_w
X-Proofpoint-GUID: YHj7_T0lkCj5FOOLnJgRUgVpYef8Bd_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.136,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-06-21_03,2021-06-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add startup time for each chip familly. This allows a better behaviour of 
the gyro and the accel. The gyro has now the time to stabilise itself 
thus making initial data discarding for gyro irrelevant.

Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 22 +++++++++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 18 +++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 15 ++-----------
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6244a07048df..50be32b60f19 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -143,6 +143,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
 		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
+		.startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU6500_WHOAMI_VALUE,
@@ -151,6 +152,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU6515_WHOAMI_VALUE,
@@ -159,6 +161,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU6880_WHOAMI_VALUE,
@@ -167,6 +170,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4096,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU6000_WHOAMI_VALUE,
@@ -175,6 +179,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
 		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
+		.startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU9150_WHOAMI_VALUE,
@@ -183,6 +188,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
 		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
+		.startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU9250_WHOAMI_VALUE,
@@ -191,6 +197,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_MPU9255_WHOAMI_VALUE,
@@ -199,6 +206,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_ICM20608_WHOAMI_VALUE,
@@ -207,6 +215,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_ICM20609_WHOAMI_VALUE,
@@ -215,6 +224,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_ICM20689_WHOAMI_VALUE,
@@ -223,6 +233,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
@@ -231,6 +242,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 1008,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_ICM20602_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_ICM20690_WHOAMI_VALUE,
@@ -239,6 +251,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},
 	},
 	{
 		.whoami = INV_IAM20680_WHOAMI_VALUE,
@@ -247,6 +260,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
 };
 
@@ -379,12 +393,12 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 		sleep = 0;
 		if (en) {
 			if (mask & INV_MPU6050_SENSOR_ACCL) {
-				if (sleep < INV_MPU6050_ACCEL_UP_TIME)
-					sleep = INV_MPU6050_ACCEL_UP_TIME;
+				if (sleep < st->hw->startup_time.accel)
+					sleep = st->hw->startup_time.accel;
 			}
 			if (mask & INV_MPU6050_SENSOR_GYRO) {
-				if (sleep < INV_MPU6050_GYRO_UP_TIME)
-					sleep = INV_MPU6050_GYRO_UP_TIME;
+				if (sleep < st->hw->startup_time.gyro)
+					sleep = st->hw->startup_time.gyro;
 			}
 		} else {
 			if (mask & INV_MPU6050_SENSOR_GYRO) {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 58188dc0dd13..c6aa36ee966a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -149,6 +149,10 @@ struct inv_mpu6050_hw {
 		int offset;
 		int scale;
 	} temp;
+	struct {
+		unsigned int accel;
+		unsigned int gyro;
+	} startup_time;
 };
 
 /*
@@ -320,11 +324,21 @@ struct inv_mpu6050_state {
 /* delay time in milliseconds */
 #define INV_MPU6050_POWER_UP_TIME            100
 #define INV_MPU6050_TEMP_UP_TIME             100
-#define INV_MPU6050_ACCEL_UP_TIME            20
-#define INV_MPU6050_GYRO_UP_TIME             35
+#define INV_MPU6050_ACCEL_STARTUP_TIME       20
+#define INV_MPU6050_GYRO_STARTUP_TIME        60
 #define INV_MPU6050_GYRO_DOWN_TIME           150
 #define INV_MPU6050_SUSPEND_DELAY_MS         2000
 
+#define INV_MPU6500_GYRO_STARTUP_TIME        70
+#define INV_MPU6500_ACCEL_STARTUP_TIME       30
+
+#define INV_ICM20602_GYRO_STARTUP_TIME       100
+#define INV_ICM20602_ACCEL_STARTUP_TIME      20
+
+#define INV_ICM20690_GYRO_STARTUP_TIME       80
+#define INV_ICM20690_ACCEL_STARTUP_TIME      10
+
+
 /* delay time in microseconds */
 #define INV_MPU6050_REG_UP_TIME_MIN          5000
 #define INV_MPU6050_REG_UP_TIME_MAX          10000
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index e21ba778595a..28416a09c462 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -91,22 +91,11 @@ static unsigned int inv_scan_query(struct iio_dev *indio_dev)
 
 static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_state *st)
 {
-	unsigned int gyro_skip = 0;
-	unsigned int magn_skip = 0;
-	unsigned int skip_samples;
-
-	/* gyro first sample is out of specs, skip it */
-	if (st->chip_config.gyro_fifo_enable)
-		gyro_skip = 1;
+	unsigned int skip_samples = 0;
 
 	/* mag first sample is always not ready, skip it */
 	if (st->chip_config.magn_fifo_enable)
-		magn_skip = 1;
-
-	/* compute first samples to skip */
-	skip_samples = gyro_skip;
-	if (magn_skip > skip_samples)
-		skip_samples = magn_skip;
+		skip_samples = 1;
 
 	return skip_samples;
 }
-- 
2.25.1

