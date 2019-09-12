Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48551B0D57
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfILK6g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:36 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:16930 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730811AbfILK6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:35 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAtDEU012938;
        Thu, 12 Sep 2019 03:58:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=qSrvncP8uZjIPGyIqTJfnOHst250avxl5ofrnHdGELs=;
 b=il5JYNAGTm2TLk3qkfEpkaiQFhHfEKWtoRUCegYTIHpIGPOPzVf0hD0ZRevJf9NMK0h3
 mcfwWJ6OfbWyBhrjOeCoEVIf9ipWcFzhACRhVuV3/+fGaiI/tsUJrZh80YbXZSBwsHWf
 IQVVKxvHIiJaujaZf8O/NyuB1P9Sa8FWX9fxi91y5RhG0D1Cci3aZvha7OBFstoaGfXC
 Shn68SGNdJCGTVq8UOGjLJmqYZSWkLfebqQzpWzOWv83IenCMWHYzTt4qmNdUVfDRLEN
 KKS+OXH/V+H+SzvZou6LW9S0EqkAk9Di1SfOVx22YRg2CWs5AyxeGbB2ABUQb7YH4Au9 MQ== 
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2058.outbound.protection.outlook.com [104.47.50.58])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuT0vkQJei5XTEsWvjfy+lOcM+Da7d0LQKGAVqdApxAupq9bA2IjAuJpeRQcTNX3ZWVuj5ArbM06cnCqvVcI4TzgU+JVhKhqHYi6FeNUXHjaz5RFvbgFd4nVwvBu1dqTDh9a3SOUXnt6C/bFFWdp+RNUbppTDGgQIsRd9xd8PhtlsXA502MYGoJlJFdlfSNSHNTqiAAaZdWt4ywbYSAAo1qTUowVClrdphQoJKb5NFOX0G8+jJHqp88PdaL8XxXwaR1k3I9O1CV9RAe27SO45+LqctYDdRtQ3TI5OpUb8+Cdq8kiYXWbwRdGvlB1OsPLMpOvkS+e310Xl932X2XlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSrvncP8uZjIPGyIqTJfnOHst250avxl5ofrnHdGELs=;
 b=Jnj8mt20EATpjaaSBLCymXgAfTWGRYL2/ZWlHwOI60yNsEPCbfA7Lc6EM3M7IpJyTmCt/sBVPT4CFZ4jZViBDWBx+z/CSzx1RwTpXdsJy8UVSsBjbgryKX7HOp/qnMyj7z5qlOXh/4uWkYEvsgkoiAYDSwHjViMiFuhNq4/Dge0YMedAv64CMYrxe5tHcRgLjMagzyloxX+feUzV9thI85rDPSJevy0SDzkf+7C5qk6Sph+NDGhYlB7YZeyDyPKOb9QyrrvzXP6tW5QXAAXc/ub5SUynNBvAL1wE5KrUYT+AJIgdr5niLBLsA+swf9sEBAJLwkOUHjeL+dhvvG9nIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSrvncP8uZjIPGyIqTJfnOHst250avxl5ofrnHdGELs=;
 b=ZOGIRY7TfZLPyxxFpqEr8AhGnqwS7cyMjbs0CM4bj4eF++hO3FNQxA5WwHsMLhcDozvUuK/UilZR2YF0JzXvqhGRFITfT2J0ccLMIX/pMdt7b2qJRonm2DYi8A2K9vzVW6ys5ZDZq2oy5MjT/L1ncsONcWCvtP2DO2WL3xhstG8=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2973.namprd12.prod.outlook.com (20.178.243.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:31 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:31 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 3/7] iio: imu: inv_mpu6050: add defines for supporting
 9-axis chips
Thread-Topic: [PATCH v2 3/7] iio: imu: inv_mpu6050: add defines for supporting
 9-axis chips
Thread-Index: AQHVaVkDkc1zIGVDD0yrFYCm7/9tXw==
Date:   Thu, 12 Sep 2019 10:58:31 +0000
Message-ID: <20190912105804.15650-3-jmaneyrol@invensense.com>
References: <20190912105804.15650-1-jmaneyrol@invensense.com>
In-Reply-To: <20190912105804.15650-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224aeb75-3583-4e16-3606-08d737702629
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2973;
x-ms-traffictypediagnostic: MN2PR12MB2973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2973FE2FCCC206D03B42418DC4B00@MN2PR12MB2973.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(376002)(366004)(396003)(39840400004)(199004)(189003)(81166006)(80792005)(86362001)(76176011)(386003)(102836004)(6436002)(50226002)(26005)(4326008)(14444005)(256004)(6506007)(186003)(2501003)(99286004)(53936002)(66446008)(64756008)(1076003)(54906003)(66476007)(66556008)(5660300002)(486006)(14454004)(52116002)(66946007)(446003)(476003)(2616005)(316002)(11346002)(36756003)(2351001)(71190400001)(2906002)(478600001)(305945005)(107886003)(6512007)(25786009)(7736002)(81156014)(8676002)(5640700003)(71200400001)(66066001)(6486002)(6916009)(6116002)(3846002)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2973;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9SNb6m3LKbVJBVygQ0avfAC4QVED1fx6vnWTgxxVKemgO9aQlYf8TulZCsLjDD+Gh/h+ao33mDhXbrde7d/6Y91rPz5RwhaHAWzuSfcokH3sifBlfcDHhraeHi0RJb9Rb/ZdLP8RXojevyxm/daPF9E2/Dr0az3p8dtZYiMumwxWzNYym/GTQryqIA25kFo33ToPhI7Sn9CyFD33SRNn8nkr6OAggpluJtKro8EEsuletmgYJi0r53oGuMTf00QD9AanTdxofwwnTpGCyRzrafZsjOJmQRTB9436so3F5SrIQv/NV07xrHieLs63rnup2k/lnj+f3te9btJsWqbyk1814HRXney+TQV/PzD1yDSBpKubaumzNiCFa3i7my/GvwQfPlCfYgrs9yk1agyJLXMhTu+ubkh/uXtL68/9tDw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224aeb75-3583-4e16-3606-08d737702629
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:31.5932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUN4/ur43zaPeFaSnGSwY2OkMYyqbAsn+eLEPvWvbVdCovFCzt1n0e5bTpbS4UJSBsi8dIj3G4zLRX4r0gjntSGbns/b5a4CQM1LTl/i4vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_05:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909120116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add registers defines required for driving chip i2c master ip.
Add MPU9xxx magnetometer scan elements and update data bytes size.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 56 ++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index 7cfd3a05c144..04215bc6e8ab 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -164,9 +164,41 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_ACCEL_CONFIG        0x1C
=20
 #define INV_MPU6050_REG_FIFO_EN             0x23
+#define INV_MPU6050_BIT_SLAVE_0             0x01
+#define INV_MPU6050_BIT_SLAVE_1             0x02
+#define INV_MPU6050_BIT_SLAVE_2             0x04
 #define INV_MPU6050_BIT_ACCEL_OUT           0x08
 #define INV_MPU6050_BITS_GYRO_OUT           0x70
=20
+#define INV_MPU6050_REG_I2C_MST_CTRL        0x24
+#define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D
+#define INV_MPU6050_BIT_I2C_MST_P_NSR       0x10
+#define INV_MPU6050_BIT_SLV3_FIFO_EN        0x20
+#define INV_MPU6050_BIT_WAIT_FOR_ES         0x40
+#define INV_MPU6050_BIT_MULT_MST_EN         0x80
+
+/* control I2C slaves from 0 to 3 */
+#define INV_MPU6050_REG_I2C_SLV_ADDR(_x)    (0x25 + 3 * (_x))
+#define INV_MPU6050_BIT_I2C_SLV_RNW         0x80
+
+#define INV_MPU6050_REG_I2C_SLV_REG(_x)     (0x26 + 3 * (_x))
+
+#define INV_MPU6050_REG_I2C_SLV_CTRL(_x)    (0x27 + 3 * (_x))
+#define INV_MPU6050_BIT_SLV_GRP             0x10
+#define INV_MPU6050_BIT_SLV_REG_DIS         0x20
+#define INV_MPU6050_BIT_SLV_BYTE_SW         0x40
+#define INV_MPU6050_BIT_SLV_EN              0x80
+
+/* I2C master delay register */
+#define INV_MPU6050_REG_I2C_SLV4_CTRL       0x34
+#define INV_MPU6050_BITS_I2C_MST_DLY(_x)    ((_x) & 0x1F)
+
+#define INV_MPU6050_REG_I2C_MST_STATUS      0x36
+#define INV_MPU6050_BIT_I2C_SLV0_NACK       0x01
+#define INV_MPU6050_BIT_I2C_SLV1_NACK       0x02
+#define INV_MPU6050_BIT_I2C_SLV2_NACK       0x04
+#define INV_MPU6050_BIT_I2C_SLV3_NACK       0x08
+
 #define INV_MPU6050_REG_INT_ENABLE          0x38
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
@@ -179,6 +211,18 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
=20
+#define INV_MPU6050_REG_EXT_SENS_DATA       0x49
+
+/* I2C slaves data output from 0 to 3 */
+#define INV_MPU6050_REG_I2C_SLV_DO(_x)      (0x63 + (_x))
+
+#define INV_MPU6050_REG_I2C_MST_DELAY_CTRL  0x67
+#define INV_MPU6050_BIT_I2C_SLV0_DLY_EN     0x01
+#define INV_MPU6050_BIT_I2C_SLV1_DLY_EN     0x02
+#define INV_MPU6050_BIT_I2C_SLV2_DLY_EN     0x04
+#define INV_MPU6050_BIT_I2C_SLV3_DLY_EN     0x08
+#define INV_MPU6050_BIT_DELAY_ES_SHADOW     0x80
+
 #define INV_MPU6050_REG_USER_CTRL           0x6A
 #define INV_MPU6050_BIT_FIFO_RST            0x04
 #define INV_MPU6050_BIT_DMP_RST             0x08
@@ -206,6 +250,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
=20
+/* MPU9X50 9-axis magnetometer */
+#define INV_MPU9X50_BYTES_MAGN               7
+
 /* ICM20602 FIFO samples include temperature readings */
 #define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
=20
@@ -233,8 +280,8 @@ struct inv_mpu6050_state {
 #define INV_ICM20602_TEMP_OFFSET	     8170
 #define INV_ICM20602_TEMP_SCALE		     3060
=20
-/* 6 + 6 round up and plus 8 */
-#define INV_MPU6050_OUTPUT_DATA_SIZE         24
+/* 6 + 6 + 7 (for MPU9x50) =3D 19 round up to 24 and plus 8 */
+#define INV_MPU6050_OUTPUT_DATA_SIZE         32
=20
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_ACTIVE_HIGH		0x00
@@ -283,6 +330,11 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_GYRO_Y,
 	INV_MPU6050_SCAN_GYRO_Z,
 	INV_MPU6050_SCAN_TIMESTAMP,
+
+	INV_MPU9X50_SCAN_MAGN_X =3D INV_MPU6050_SCAN_GYRO_Z + 1,
+	INV_MPU9X50_SCAN_MAGN_Y,
+	INV_MPU9X50_SCAN_MAGN_Z,
+	INV_MPU9X50_SCAN_TIMESTAMP,
 };
=20
 /* scan element definition for ICM20602, which includes temperature */
--=20
2.17.1

