Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CCDA1EB8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfH2PSn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:18:43 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:30760 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfH2PSn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:18:43 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9qr9024048;
        Thu, 29 Aug 2019 08:18:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=VyS37ZNowLyKTstbciYHFo2MfPB7Kn/zrUWZHaPMV5g=;
 b=fHmesJPPCLqVP0crAxQp39oxvbovv686rLhxFz7wR8tfVMNJ0ZfjB8AJCPDaDq8IBEO3
 LXabNwyaA6QY9XrkQYIvI6Xac7lCJhBAyuF8QWwQpSL4g2d25YFsdC+zHWrHZJ4rTtPF
 w4IMws/lDHRTNEu9Hb/QJOm5B0jwc0WqjyZ96yAGoilK627dyX02uWq+kRljhnhV6gNz
 EDp54+rp+5DQmgL205dFkskMZGL77Vw8nXV+wDysDB4mMz1+jIZ0peqnRnffzZe3MkFC
 vfAuPZXY1MOlAAY9cONpaOYWjUQnY7+arDPnH1GXPOd1HVWvsAgqqh+dpHbIULaWdOkz XQ== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2up71c88kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNxKBzKEGkn1kEw524iMWpJnGDHbtVZJ2aZXwRiaA4gBVN/Oxr/SToE/3QmZZbR9srldOeJmwf5x6uMr/EQ1wsfzEGIBoKF+GSBJ8N4H4VKCYAgYsUcvqiLTfOvgCYEeQzwJJuEO/+TRLW6EbpugvstOQuyrgRu3JmvLo/1/LUZF6Kquhudy/r7aQEwF7gaJjnnmAqIm/NQcB884geowAs53w389tbPqOFE/hr3cTjSKbCS5/2PGsne8sHqi4PGVQGCJAxdqG/bsJPm9bcoSDw5/XyE3fyqctC2L2DIfdU6kJQw5I6Qr9FNYK43tAiATTx9eeIT8eZRy3cckrjg71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyS37ZNowLyKTstbciYHFo2MfPB7Kn/zrUWZHaPMV5g=;
 b=kePmlOgh8aarJAgXmBa5VAdP9TE8lb33zKuR95ubzCSCaX81z31/Y7DVrZoAo6Z0TY3k3QT87nnVewGSzef0JLRywPcqs0LEyvtVdrmOdNhoDBX6oLMDGzK/MqRKnsoUuKY0VUqEO8UJ33sJD3RaUX6f6kqPOdvASTTYktTRo2/q7coIQgvI7vCXNotQ5TMUw8aPsAXoyTqdXmqn5RYR8LqCGrlk0i0FXYWwUV+e/SuaUAS39Ya2bFw/x7W4HesLPWVVXpzNAv2e0XAcM8SIapVJAmIKH0e2vdAs1pWC75KDUm+LAB2WFx2LHMSc4yEUt8Y0ESKrfPY8RfCLlquy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyS37ZNowLyKTstbciYHFo2MfPB7Kn/zrUWZHaPMV5g=;
 b=WA5LJGjbfuiaKBqzNdQxkiV9WcqWC7uHZGnHuxCc911CTWF+fJiDg082wulPEa+gXa0XJppA2wmzqV8Q3ara82qVnOYUNFcn4iIxjlRZaHjMQOHD+v8HVpYIvZdfJcn6u3Znsfs8+9A10pRz+nQRei6jaLwGtOc06ixStopHMJw=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 15:18:39 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:38 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 3/8] iio: imu: inv_mpu6050: add defines for supporting 9-axis
 chips
Thread-Topic: [PATCH 3/8] iio: imu: inv_mpu6050: add defines for supporting
 9-axis chips
Thread-Index: AQHVXn0IoHuQuPiY50GrnsE0SJyHHw==
Date:   Thu, 29 Aug 2019 15:18:38 +0000
Message-ID: <20190829151801.13014-4-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
In-Reply-To: <20190829151801.13014-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::29) To BYAPR12MB3366.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::15)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459d75ce-9c8a-4fc9-c54a-08d72c942b14
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB363890F1CF672EF58D8BFF91C4A20@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(4326008)(6486002)(256004)(14454004)(1076003)(14444005)(316002)(26005)(102836004)(81166006)(66066001)(81156014)(386003)(6506007)(305945005)(86362001)(2351001)(6916009)(186003)(2501003)(80792005)(7736002)(36756003)(50226002)(2616005)(6512007)(8676002)(478600001)(71190400001)(71200400001)(64756008)(54906003)(66946007)(2906002)(66446008)(6116002)(52116002)(76176011)(66476007)(99286004)(66556008)(8936002)(446003)(486006)(107886003)(5640700003)(53936002)(11346002)(476003)(6436002)(5660300002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7kD+MrSZqA9aTOl2a7UcA6mL0CF0qpaQwZK6eQpr9pngYO2gRYf0H3lAgf6FW0Tolxt1iB5+piJxkP4+EyVD8U3pdtIS2kkb2fEwn7AxgA/tEJQDGH213/bfMFKq+1ZTddHY8ZSH090Oywldk7AevRKDFS02oNqi7B3VJ172UOQ6D17HS75kFEcgahjAb36MZpb5tbonTqf8wIqEDcSlyzVaRxgZys1ktG0a2MfYDCAgAt6RtcUt3VYyxWWFPvmyHCSxFBSP/+l99UmrNeFcSWCKz4ShZVuktfYFP2WA9y/zSDTU1yPHulz9yhEVMezDGCmNQ/mnGNkNw2gr/Hzq8l2IzDIEBK3MB5Lz7Q1qwZa3ZZVRgxd95pY4LQIjBNoy6c+n4DgnTCIAItGahWejsPD+MZyP7FU/c4c/Egws2U4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459d75ce-9c8a-4fc9-c54a-08d72c942b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:38.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1kxJ9ch3C1Y9d7O0qBSJyZTYMOKfL1jNGYM/NIRJ41IVVrOC+aF3GX/oM1tLf0rJF8LONmxFKBZH+cxRg+sjz2vsdx7qwLpl9UFWPZHUxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_07:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908290164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add registers defines required for driving chip i2c master ip.
Add MPU9xxx magnetometer scan elements and update data bytes size.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 65 ++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index e64eb978e810..82669ecb4735 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -162,9 +162,41 @@ struct inv_mpu6050_state {
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
@@ -177,6 +209,18 @@ struct inv_mpu6050_state {
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
@@ -204,6 +248,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
=20
+/* MPU9X50 9-axis magnetometer */
+#define INV_MPU9X50_BYTES_MAGN               7
+
 /* ICM20602 FIFO samples include temperature readings */
 #define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
=20
@@ -231,8 +278,8 @@ struct inv_mpu6050_state {
 #define INV_ICM20602_TEMP_OFFSET	     8170
 #define INV_ICM20602_TEMP_SCALE		     3060
=20
-/* 6 + 6 round up and plus 8 */
-#define INV_MPU6050_OUTPUT_DATA_SIZE         24
+/* 6 + 6 + 7 (for MPU9x50) round up and plus 8 */
+#define INV_MPU6050_OUTPUT_DATA_SIZE         32
=20
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_ACTIVE_HIGH		0x00
@@ -283,6 +330,20 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_TIMESTAMP,
 };
=20
+/* scan element definition for MPU9x50 devices */
+enum inv_mpu9x50_scan {
+	INV_MPU9X50_SCAN_ACCL_X,
+	INV_MPU9X50_SCAN_ACCL_Y,
+	INV_MPU9X50_SCAN_ACCL_Z,
+	INV_MPU9X50_SCAN_GYRO_X,
+	INV_MPU9X50_SCAN_GYRO_Y,
+	INV_MPU9X50_SCAN_GYRO_Z,
+	INV_MPU9X50_SCAN_MAGN_X,
+	INV_MPU9X50_SCAN_MAGN_Y,
+	INV_MPU9X50_SCAN_MAGN_Z,
+	INV_MPU9X50_SCAN_TIMESTAMP,
+};
+
 /* scan element definition for ICM20602, which includes temperature */
 enum inv_icm20602_scan {
 	INV_ICM20602_SCAN_ACCL_X,
--=20
2.17.1

