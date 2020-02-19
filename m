Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF30164739
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBSOku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:50 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:63542 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOku (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:50 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEdVSN016934;
        Wed, 19 Feb 2020 06:40:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=MVVBtRXHr6LCuQTLaHsj3Nxg8sq2OgfadZ8gQWwmvQE=;
 b=v8JwbKYwEvof1hDCkN+q1mVjMJB6Q6lLi/jKcCT1o7WQZ7OtRnVkN5nFCElk532jdpop
 YNCNg6faf3NlEo5i3CsM0Bc6wZR1tyb13Sc2pFDsMh6VYzi36M18kPvfLXvRTsx7xmHq
 PcL0MQDGPi/heJB69053BPdlKxyYZOFgQC37HypUatlrpA8hTKUcYqnPcpgxek7ewGLJ
 VagF4mobFKdZM4Uh+iTkGieue4gpoT/zdVBhDhHxg0Idof6dOeiZK4qU0pRbSyZsJnrV
 hcYLaSOasrr5KmTnftHI6oF9TbUjCaS5h0FxX0lyHN8f8OCBtgWxIJH7weSNqSZh1vDY Rw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem892q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njqeWHKf3kpq6EFMNsbsJTo2T88JZWubfJfNlKnyINwAdZFWHZ479UcDvX3AGOOCFrmkgBMpwZCELoeQbl+WO3mVlJq37snjbzRUjDbqPdl6B7eT3+5NxozNvpR10h3S9+oXJwWqx2zFYmeBgex9+2IxtMem8+Cx8sd/58X5sgdjbu3eCxBJcuxYAe+xJeVE9rJ5SjWpgy4e2KcTbovXA0TrvU3YC+SXnIGOD/fMKi4NsnAl/pGwVQGQDPHJIoRJ3uAHc+MaSNGn3VkUhxJdGH1qJIP2pqacgufOU8LWDRdvswWe2IEL1pYPPs2on2wFNkRnJLexM9+omJlx0vsfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVVBtRXHr6LCuQTLaHsj3Nxg8sq2OgfadZ8gQWwmvQE=;
 b=gAYUy/R8DOcV8MJxRS/8z3Bt35NpLN0wq/iDElf8AnYkfZZjjNhEqX6UfzsLgcfL/C9ppCdCVPzKKWP1Ar65EvZwJRIqgWeA1dAgliosaq7Jp/0e3u2Y03WQbpK2KTmQYW4qNiOLzYtCzqxIN+kJP3up6Oyha0O5699E3X0rst9+PekkxK8+H8S22bMxEjxRv1pZb1Ml/RjUpZrOwjKfhBb22bs+dkRZoF5ao5h2GqLzB6VLwnoCYxwsY9xeKdCm6LB1iW7KR0S43u4dP6AVuoJXTPAY/+hX9YKYOSXCmOUhplpEhOFi1MIB1UKq21wRn03xOwdXzh0iJjaoAz/wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVVBtRXHr6LCuQTLaHsj3Nxg8sq2OgfadZ8gQWwmvQE=;
 b=UXxrzl4GRKrcvT+vrhIreIHqwRkOAYTmLOUe20NT0deVoSurrbEaJchbo1qzTkB93OMVkKMBb9RMSdPCeblJo8hNax1KmS7tLaANzzfNAf9rKMqXJKaVgYQ4CWpm5gGDmeq9E/vlv6JoXhgIsVvXCmESQuVwkaCzSgxsTTFXEIo=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:40:47 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:47 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 05/13] iio: imu: inv_mpu6050: early init of chip_config for use at setup
Date:   Wed, 19 Feb 2020 15:39:50 +0100
Message-Id: <20200219143958.3548-6-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9eba5d1-c89d-46d3-f21f-08d7b549b517
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4213EEFD5D19CEBB4BDDE627C4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(2906002)(36756003)(16526019)(6666004)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5G6vU1j9HO645ePdqzwfwSCHl2YM96A6aW46yfrmSfMqpxRfklhxjn/dLNrpplIzTHRIrjvFBuTLHV+FMfgJrisIQobPZ0W4p6cDoKocJP/q6IZfeuUx7dnV6ASKe1xzBiRNXSKUKOwIlvmuT5fQ7KId1HXY4P5fSBxpSFSN5HPq5dHSWDykMMmT7Gxh7CpR4gXo07asMMylQKU6dQyERyc28veI5aW3nOYmGPbvYm3OVyq5UBB1uNYSjD57ma0wERV5Z4xIC2ihJsBu66U49+pXKZyuRwMMcbdapeScr+1wL/ZO8h0H3zuxpeVdeXS9/GEutcfgEHqkIuDQE7a+2C5seJph2rq6lSQ8MEs7wV+keEQQaE57BfxOP7XiA1Rx0eN4gA2YPk2iq5dxNYQHTfNc9Om4EHQXRHaXEMSEEnFxoPbob8dVf1c/7TOZql1o
X-MS-Exchange-AntiSpam-MessageData: zTw8uhMUpD3W1MS1ngNmBzVw05lT7snJjswo5VChfZRdu7b9dP5q9HSHce8O2wOkOzzGmIm9OQWWW1VrXOnB/eVQGSikKicLoP6Xj8g+uX+Fs6RAD2VVmjY86CCKXF02ICwZkRDwNme8HVFbfrkzMw==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eba5d1-c89d-46d3-f21f-08d7b549b517
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:47.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h5HL6qIBM7oubFfUZw+6XyRzcWMcC4/kf5u2QU5s6jFjeHBIDPDc/b7RWVU9XzQpHnuu8xB6BT4jrRd9acwBDiNh1kMCq6yivA04r+Jbvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=907 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190113
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

