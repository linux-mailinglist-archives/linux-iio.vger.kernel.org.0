Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154E515AEEB
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBLRla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:30 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:60306 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgBLRla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:30 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHLInD004094;
        Wed, 12 Feb 2020 09:41:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=A2A/F5LZ0QhdPfyYutPKZ+T4auYI0oxbnMa0to7ZA0o=;
 b=H+JoUAREBFWYuXGL6c8OpQNpnsWDgtkcKX1+ig0N5fv3O8AXemSBxlGc+RabJ4+M7M7s
 RzckU73M8hnofUdRH3/JS/Q8BRuaclQQ5K+E0eaxt0yIPdn/Y6BRn7UwOaUSmJ7C4JB7
 vxQhqtOzwBK/hWk6OSGyM0tUJ0r9DItO+ECGg0PYDOPQUYiIxArrbtAkKJ4Wq8TF8+Yg
 FJhjOaWv2cVDafsD4+B3YiBX8rD6/thIWSWGpDVN6FlPJ0D0F2eqIhIqGib31o4NGz9w
 FnK7YtZRmOvrkgzfFUc9Z03hjUIR0TE98M8i4J2RdySkAP/hIt4eIUstcQmr5czZeOAr XQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0I1tCMoyz+jNw/w/auJNJQ+r8FjHR/JxaIR56EPLY7VO9wNXj+GKhOFicJZZwF8ooIY2XtqSxjX8SKc/HNvQ6JOrOHJopXKxZbsKz4JIxBp1zlKXPuTxulIT2pkAyux8oi+NZCzwDuvxGRak+efWAm2qRtsza1FNznsQrL3Wb2zXI+rVzo/AUUXz/NYfp0AeZsF8QU72yx2EvLH1wslsRm8GNqXyseEp4ZlyNO1vJSfhy7p/N1DW+BrLt9Nh8OOGYzPHa6tqNxphezUCxh+AegLgpbiVbzSAx5bRxM0sIaY8/kRFHf3m9xE7hqpIMYYLzPfMOVu62K6TYLIStqi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A/F5LZ0QhdPfyYutPKZ+T4auYI0oxbnMa0to7ZA0o=;
 b=W/hQWia4tqhhCLBYTFUN6LywvtckKXeLslPIy4nbilzlIRJF0mFhJKGwwliHWqiYKpn6Xs2bMKsbrw0p74XShHrNzoELAnZ63IglwAmcbgnSbUeCALutHbvzI/cvpjP5Bpgdwg7k038hI1C/2Bl43H1Pc8JSsPG9dUXwZ3dSvzIhFlhzhmkEtWXskGs2aMpQNbdWLi/8GTJKyd7jysYJTMcIa75jjMumdK1n3Otr5NH/M/e51fic2mCnUb9iDY1jEAHMTTDopRfnJzs+8elIqJqi2gD2E86xSbcDAdG3/tTZx1aG+YIXuXx6BznXjl1VxX3aEjT84/1mqZ9SL7/Rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A/F5LZ0QhdPfyYutPKZ+T4auYI0oxbnMa0to7ZA0o=;
 b=AxzgxeecjKEiCzz3ssUFyVDYIucq8LDscUNd5zGIF+Owa2yd1vNCF4rmh7oe7pkFGFKYntOgD+FCQ+STe87BcQSVDE3gQq3UsDgplZ9tN8J/0GP8tCYeQ2pwXn0xoCN9au8sCbOZa/QriPiR1H4vc4RQYVNKCd/qMtkImVO/MMs=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:27 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:27 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 06/13] iio: imu: inv_mpu6050: add all signal path resets at init
Date:   Wed, 12 Feb 2020 18:40:41 +0100
Message-Id: <20200212174048.1034-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5820d42f-f330-4ba1-4d9d-08d7afe2c912
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40707EAE986E5399B6010AE3C41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztcb6XT1zTG9fa/s1FDAzeMNRr9t9gDPOE+9zt3b3W1RanvNfH5hbXY+NoAgzVk81yf5ZOvnDoo2BlPnan2iiD+6HTOGM/JbWs+SkDNPHo4VuLbEYqxzLxPPZKXpWgh6VHqimhpM8NWlsNWIEcoMJuO/3VkV+FR0m0h31eBc40DOtm4Tq5AwTqnBcKOtZEgizG/nD8lEhqTM4LoIZDWxCbVa4TryJtlnMRgOr8olptPlkV4gY3a6LPl+qVUKD9rqyG/Fz0olWHt/F4kjcu0axOW4CTt8vyxKjZPPxc+BKtf9+CWKgJnaqCNqBlWRfHpFSKy8u/miw0aXU2J98TUJf43QS29RqHPWCoz2YQYVPq1qf8qmvS819iz+dxTImregQPyWIPrBuUvVvhoRYJg48giUocgsqX4Oaq8YA+vynvR7n2x0dAEs9wSv1bCEO+p+
X-MS-Exchange-AntiSpam-MessageData: uRcQG8+X7xEgvipZabZLe4Ijo90NHldXhgB87wS6e/IxBSdAccQLt1+nRVi5U6gqG+PaXSE0NqCJ3+wCo8k8ErwXfrpcMfF5AtjGK4uwDD3iqTNyKNGQ2nQyTlWlOtLmNP+UB3Hi/gDPmlDf0i4JDA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5820d42f-f330-4ba1-4d9d-08d7afe2c912
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:27.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6VgRy0TAFOg4oi9QIlmZeYrH01pt2LJFYFUoxAwFAuJSDQGT0KXwahtoL0j1hitC4Uy1jivEcvxattwNXN2Y0xuOdTcj6TblML3pqh9P2I=
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

