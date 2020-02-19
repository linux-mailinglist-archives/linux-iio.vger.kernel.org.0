Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250B516473A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBSOky (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:54 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:36028 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:54 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEandX007777;
        Wed, 19 Feb 2020 06:40:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=A2A/F5LZ0QhdPfyYutPKZ+T4auYI0oxbnMa0to7ZA0o=;
 b=r4LcNwu8R2QgaYFyJt99Tgz3Egc//UqxVI8a8EuLSlI9hHgo0py2YMNuel+Liq4kEtMh
 R4ZB8W/3M6SKs5jW/VFgwgaL21vaOlySenK6Xk3h+4X07EP5jFHTTj0RmxpHok+B4hkr
 6wnoOcVhpIYesMhsxpgFLmHEtrRHBDTq5h2EyLtObosiLhaNCAS0xSc3IpVuzxutwDpT
 kDvJryCL/BbK+1CIignQ3uAZ21nBcSAoQTkTecllgIWl2iYqkTjyIZfK+R5AAsQjvKa+
 xhYQHvcRDDGvD3INpVztA3GmK4Vae8Coq3v0Msjp+7qpX8rMxzyTkOLw8rhCCClzczwS Ew== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehAPG8H5TmBfzoAkTzhDqwt9+fcTEBAe7mlY6W93UmPheImjvD76NTGg0MI/r8fou3iDXzTK22pTn7X642U9wAFdx3yxRUOkdlxbAO8wlCfm818Xn/u9mxoZgeHkxHI/aMFkiDWlm7mqj+5Yj/quFdVFVGSpK9kPoRNs8cQ4FzaYOO5fN36dv9nj/WaIG8HTZ6vncyeRx89WQinvxHMrpPksgEzBBEj+FY7GHpxL1MfuOgf0wmijgA2xTfmOCOD4dcOGBesQK39zh2PrAMFeLSeANsr/7AnRs6matHSeN2HWjnLPGd1SxKjTMGBoRbK5nEE42hBxIvckeuQqS4+QEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A/F5LZ0QhdPfyYutPKZ+T4auYI0oxbnMa0to7ZA0o=;
 b=OtiFs6Rs8ErikJ2lzWFlJdGgC0LB6TRossLDRcMEjupHXbX/VXssJp6rAT9noVCnR2ziJWELUmleD+jlZ4sMxJjhSkrGM9jLhDP52EoBcfE8yudpWMtsyucpyudlE6p2dh7x1GmF321/T6Qfqp4CPy/vcASUknG+2GZxVfxVcOCeU+IV9SxYR7/nEL+zhuJ6pdFaade4SyQJ2n3OWHs5KQ8b8W3L7s/loScJi3XcQRZVtAQJybyFnpZVDq6XlQRMhg1dj03qLpesXjpAb0goGXyfzP1JFGpu0bXAwBCeiqg8aEAgnE2NpuDD1khhUMWtXu/EQaFtGqtzZ7mjd2crHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A/F5LZ0QhdPfyYutPKZ+T4auYI0oxbnMa0to7ZA0o=;
 b=YhpknAJse7KdG4+/p4WZY6aebkM/P/5llamgpDeT3WdeCP6RtsTQQtFjQeQuO8KR9hPGKERZnizfQyL74AqtmTPh2iSyERplkQYOk8lEItOaV6HYCA6/oKy5EmlGR/EAt1Vxjf4ET8XwROhl9V9y6VHlTXyoD53/w+mBIoTUBCs=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3878.namprd12.prod.outlook.com (52.132.245.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 14:40:51 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:51 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 06/13] iio: imu: inv_mpu6050: add all signal path resets at init
Date:   Wed, 19 Feb 2020 15:39:51 +0100
Message-Id: <20200219143958.3548-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a9af2f-df74-4425-54e7-08d7b549b783
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878179F2045D22ECB3FDFF9C4100@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(2906002)(5660300002)(7696005)(36756003)(16526019)(81166006)(26005)(956004)(2616005)(52116002)(186003)(1076003)(81156014)(8936002)(86362001)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(107886003)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3878;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhRtlE55lwWKzUADmEdqUQgNYj+Rt3cxpSUmWUdhHQKzb96I56EFzhceotbU3X2OLQHCnrwKmuWNF3ovn1SoCNWoUf2CZGYOdT9CIIpRO6Ch0+mMb/yHVS+M9LT/mWPb6t4d57oNVbe0E8JQQZ7kX6V970FxEZeZkxGqc8PyyVn5Xz8h/mzr2zxf1mWfKu5tVjis2bel/JGH49VfsEpWNEV3IcuzkyEc8Jr21xurQ+NhYsB6HUNAumoWRCWSmMpMAKiabjOyHx7stFR1txrFvYvmVDBEmnYVggX/xshT4rBjR/cHFfn/FxFkuZBXSShDG1M5klLNmT1YoAXrN2LmAb5bHxV6HegT+CaCJqiGcdR9gOBLhDZQak9oAVsWLbsnx2ab6vg8xzckTOmWPpoQQdHGslC/vb46axgd8//uojqAdpnKizmXCSkDPv34Ye8R
X-MS-Exchange-AntiSpam-MessageData: cGOj6nm/FjDGsPG3xug6pOyT5O+D7jcMhbxLDi8TNfQD8s3ncJjMCSv1IAm+SMkdbxZL1MAC4F+PwkSXA9bbYVkf2E8gdsNs+nRA3IZBwnj5DqKTKpdQn7Eg2WNZG8NZBq7hRFiZ7kgMMeoxv1j70A==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a9af2f-df74-4425-54e7-08d7b549b783
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:51.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+qRQPYZFidds+fcJRNctJOtQt3YmPN9ivpGD+ZGl6rXvE0HENiaoQ8vOL1Aa+08y6wXXOqk8dLN0YmoPDQ/xAQp42CzI81vj98Puc6pdyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Old chips using spi require for a full reset to manually reset
all signal path. This does not harm when using i2c so do it
inconditionally. Exclude i2c only chips.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 18 ++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 85872e55154f..3502b996671c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1146,6 +1146,24 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	if (result)
 		return result;
 	msleep(INV_MPU6050_POWER_UP_TIME);
+	switch (st->chip_type) {
+	case INV_MPU6000:
+	case INV_MPU6500:
+	case INV_MPU6515:
+	case INV_MPU9250:
+	case INV_MPU9255:
+		/* reset signal path (required for spi connection) */
+		regval = INV_MPU6050_BIT_TEMP_RST | INV_MPU6050_BIT_ACCEL_RST |
+			 INV_MPU6050_BIT_GYRO_RST;
+		result = regmap_write(st->map, INV_MPU6050_REG_SIGNAL_PATH_RESET,
+				      regval);
+		if (result)
+			return result;
+		msleep(INV_MPU6050_POWER_UP_TIME);
+		break;
+	default:
+		break;
+	}
 
 	/*
 	 * Turn power on. After reset, the sleep bit could be on
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index d5edf903c076..17f1f6a15f95 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -245,7 +245,13 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_I2C_SLV3_DLY_EN     0x08
 #define INV_MPU6050_BIT_DELAY_ES_SHADOW     0x80
 
+#define INV_MPU6050_REG_SIGNAL_PATH_RESET   0x68
+#define INV_MPU6050_BIT_TEMP_RST            BIT(0)
+#define INV_MPU6050_BIT_ACCEL_RST           BIT(1)
+#define INV_MPU6050_BIT_GYRO_RST            BIT(2)
+
 #define INV_MPU6050_REG_USER_CTRL           0x6A
+#define INV_MPU6050_BIT_SIG_COND_RST        0x01
 #define INV_MPU6050_BIT_FIFO_RST            0x04
 #define INV_MPU6050_BIT_DMP_RST             0x08
 #define INV_MPU6050_BIT_I2C_MST_EN          0x20
-- 
2.17.1

