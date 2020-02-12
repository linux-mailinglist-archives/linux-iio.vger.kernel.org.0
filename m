Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6515AEEA
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLRla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:30 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:59952 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLRla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:30 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHLInC004094;
        Wed, 12 Feb 2020 09:41:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=MVVBtRXHr6LCuQTLaHsj3Nxg8sq2OgfadZ8gQWwmvQE=;
 b=O4pi12ARqPNvNN1UESXOhe2i5NNy/+iJebzl02UjSiS5U9xYCznXI7/4mB87TWmts0b0
 k0raIl1ruKh5kGmNP5UY8vOoqGX6Gyc8421gnHxV3XJZ6kjRCIw9r5fMfHUY7alzgHeb
 IYHYpEjqK2p3929mw1xAhLFMYiwDmps6Oi1qxGn/q9IQYT8kfJzqp15KhB8HpicBXxxJ
 lmkZAMXglvAMxPr2L9JQsDBgdSbljq8a/eSqIek1eM2D+7lMhbl8Q1inGWotBYxMLH2t
 PkFco5+SU8owJFw7RNNqvc19JBK1LFHoivWcn7GSrKtUSi3Vosw5oXouY1A56AWVwOf2 mw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX+fXriBEcFxj8zcZnJCH1RN9M4c2AYZ2Q6RexP1acj3vJZWP3gvb5j9g7k/Z7Ee4OWwLwZkY9So5bcovrmlJ80Dd89A2YXylISlygFCRbhpCTE7V60t4jBsH//TzwqALfNeY0F8UJ2G1lfA//724aKyjMLDLFwQVaZBkuvCL9Z27MMu2o5ssnq8cbb1E68GClfs409o5bN8DIaLGivFK0XAEYcz2v5bNdzujFTlUcFDLpX/3ySC8MIysS/Nu81cSN/vFgj3N6y1pinDLDtrx17z23v9159PEClSOEcbaE6aHUVYen4yI0PzMNowMCqZMyCyPw09YUY+7ych5mGQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVVBtRXHr6LCuQTLaHsj3Nxg8sq2OgfadZ8gQWwmvQE=;
 b=nrROzG2MlWyj9WIjZD43gtRklwPu3Ol+Fwyg/SVYA+7AwOYhNrntD9pV6sF/lH9Kgg9SDcVlvnfYAJ2j5gvTKNP6uZJQKnXiZzxsDYOJZBbFgI9NE599rcmNQJ0jK0L8ytrGNTK3xH6f7LCpx7bDJV0dU0Es+Reiti2zGqS3S/4Qw3/hOByzLQo3UzHVYPsjHVB32NVYkiqSMAL5+aYBENcldiv5Ni9cRYOd291nuH4YNOAZSyN47K5862W6S0m2SU44pDt5MNsyxrbIut0brtgZ/F5H+avrPJ1jo0Ufp/FkkC6PE4YNkIa0mbfXq65Pr7vcOLxig2jl3Qoe9zfG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVVBtRXHr6LCuQTLaHsj3Nxg8sq2OgfadZ8gQWwmvQE=;
 b=bap9TyIH6qTC+ibXJllaP2+GeMNehbjy0ntSPo449UNLUotPn1XFEV+dybffvUWDr1FQFDBgTq1XsAMnXwbqtr/YJiP0ZF5Md8Aa/rflLjzqKgpPXWaDvIzV4cFtbL/voCRl6i0mc17ktvCunrH3e4p7TcsZOh1fossVsNHyklI=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:25 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:25 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 05/13] iio: imu: inv_mpu6050: early init of chip_config for use at setup
Date:   Wed, 12 Feb 2020 18:40:40 +0100
Message-Id: <20200212174048.1034-6-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3963f36e-f22d-4735-23cc-08d7afe2c7fc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40700C1FD86D27B4753968CBC41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkOxr4X26giGE1I7VbPezIBMtLxfoF0eSuRM1modMkSN/jKXLqcDT3Rwqhh3jwAXt+v+AMef60HJIYVWmUoisgu0lEYooimgp/d/t+Yu5bHj+9Exp5qF+uOFAus0lyg/ACA9kN7OvnQ0JTpQb2XaBpS79ciInZSMIF1UqwiFQ4rSvdLfKeYp02OLqravH0nHsLInDvVAxYaGB1DLFCcR9kqYra4tU9FlqjW1gW9WLFWkXjyk0V3mmEzkRUhz4yoRAXJUw6NC99rT4wiCm70SJXz4QgD3xIRTRc4H7gCt/9bc16kJMD+vje1QMxtq1lJsNDU0v3Zoh9LzNAIZ9dPE6Dwtq+DfbbY44z/O8rKayAPAA3aDpoHJGeaanb4+99BYgTyyIRbOwhrVZ7TeGRjsfv01f+I4PDaI4hZjLEHfbBus4fbMTF1XYkMLwhnjnPZo
X-MS-Exchange-AntiSpam-MessageData: yuqxGaBxpaZ2nGqKCNF7vBGJ30dLNxD0j8SaX9X1IH7jmJQZpyeBIE43Jq3gOxmTIK0byla4pNYsYrAdOlPJS/7s5hu2M0xdQ8yxWxeV5Gc1eNwivhuVb0FIXM0qQTkCWGgX4Ehhs0No4pd1kGvolg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3963f36e-f22d-4735-23cc-08d7afe2c7fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:25.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+s7d44BLyYq0qZ9tSev1y4BvGL2TAvDKwNzYwsItbCVc93hvgDNOdggKid/vY9v/pQztbYnsoedbmL0oTS3G5TDhG35NFAPQVPvmoBtZxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=921
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Init chip_config early and use its values for initial setup.
More coherent, prevent possible mistakes.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 15 +++++++--------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0b06d6aa6469..85872e55154f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -101,7 +101,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
 static const struct inv_mpu6050_chip_config chip_config_6050 = {
 	.fsr = INV_MPU6050_FSR_2000DPS,
 	.lpf = INV_MPU6050_FILTER_20HZ,
-	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE),
+	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(50),
 	.gyro_fifo_enable = false,
 	.accl_fifo_enable = false,
 	.temp_fifo_enable = false,
@@ -370,20 +370,20 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	u8 d;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
-	result = inv_mpu6050_set_gyro_fsr(st, INV_MPU6050_FSR_2000DPS);
+	result = inv_mpu6050_set_gyro_fsr(st, st->chip_config.fsr);
 	if (result)
 		return result;
 
-	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
+	result = inv_mpu6050_set_lpf_regs(st, st->chip_config.lpf);
 	if (result)
 		return result;
 
-	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE);
+	d = st->chip_config.divider;
 	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
 		return result;
 
-	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
+	d = (st->chip_config.accl_fs << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
 	result = regmap_write(st->map, st->reg->accl_config, d);
 	if (result)
 		return result;
@@ -392,9 +392,6 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	if (result)
 		return result;
 
-	memcpy(&st->chip_config, hw_info[st->chip_type].config,
-	       sizeof(struct inv_mpu6050_chip_config));
-
 	/*
 	 * Internal chip period is 1ms (1kHz).
 	 * Let's use at the beginning the theorical value before measuring
@@ -1116,6 +1113,8 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 
 	st->hw  = &hw_info[st->chip_type];
 	st->reg = hw_info[st->chip_type].reg;
+	memcpy(&st->chip_config, hw_info[st->chip_type].config,
+	       sizeof(st->chip_config));
 
 	/* check chip self-identification */
 	result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 9a81098a8b4d..d5edf903c076 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -321,7 +321,6 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_TS_PERIOD_JITTER	4
 
 /* init parameters */
-#define INV_MPU6050_INIT_FIFO_RATE           50
 #define INV_MPU6050_MAX_FIFO_RATE            1000
 #define INV_MPU6050_MIN_FIFO_RATE            4
 
-- 
2.17.1

