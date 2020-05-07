Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2881C907E
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEGOns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:48 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:36510 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbgEGOna (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:30 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Eegd7005564;
        Thu, 7 May 2020 07:43:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=E4/9MNCKw3gAe5FzYl5LeaML9JToSDiY4KYE8GjysP8=;
 b=F8fnmZoij68TX2owuC2+6Y1T1vC2CdbAMQCSnix+/gzeCcUUSVD38A0dZDs5Vb00ofGm
 6OYYxYgvsG4vG2b3PLAmfBGMteCp/KiQRb+Tg5KukhjjnUhJCOt1kuRr1KKSS2raLcza
 Yr631Qwhm/HytZc2ppMIXUM40pBgtFBTikSdVuE/DgvmjPXk7dxV0XLHErmpbbYc1GMA
 mWU2bbwJDm49IS6fLe73HsVKwCrp9CddGJ45i9zK2k9pKt+Gn7mQSZrzj06+xtZQDUBx
 IrCF5s/pGep9yOxPqV3aNs9S3JnrKlhTj2rjsOYFSucDIpeIRpS8UZx2SABjDSYdCYaa hA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00328301.pphosted.com with ESMTP id 30sfwdjs8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIw7LKylCEh+x0/l3VaNqTU8YZmJaZYdSURV0fZKOjXXO/jSKY+i1YB1DyLRLdB+RWUPNVFR+SSB7Eiffpqn97BuZ/1XHoAnXvlIAO5klnHfzEah6MJpXRPllPMG6eOhCvZ9YyFAlwQUxxc7K4yIB1zpFd73bdXLp1E6jREie0kyDTudO3msItKaNcJIxu4GrBcD+Zem8RN0LEX6S93uJPerK4TbNdpnLuFbANy/Uza2uoR7LkvR+Mm2ryp05+Dcn5gYoazyXXhHLwDaHW4wPSqIdnDrIH0mAlkHseTFlvoP+7/bdmUaR/Vf2Fx6kFqUYFixO5rJWwiRKxvcwW6IRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4/9MNCKw3gAe5FzYl5LeaML9JToSDiY4KYE8GjysP8=;
 b=X/rNCsVst5bNwm3Y5GFjoiE+uFItmFwnpAeoFgAe0Z78dFQpVXwtBTcEddkjoaYRsMhcWHImx1XRC6UBNmyQC4D8/KuwzL5d2kBbk/kySSpt7+K9GZtfMoq2Ln2lNxON21Boz+NAR2mGg4E1Li5DGEmaJ52VIlhrWtF21AFjbC62+F6Bg6o2LlHOtioHFZqnR/lawll2hGuweZKQjQR/laU/i0l9oLhrZBWrVuJsCFGiDsYsYRx1VrdpRT9/EbohvUJosbSpf2/v9eeLbGzDUM0cA19W+HpJ3YoVbGuCSeVTV4KrQKcqghybXDC6GrtK53PToTD0PExApby8071FYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4/9MNCKw3gAe5FzYl5LeaML9JToSDiY4KYE8GjysP8=;
 b=bxABE7PtrMiaRVX1IJf0OMoXwVSj0SDiJh5wd5j7ctebwesbQKFIPKFTRB8iAaJAsNAvX8dMA3ecmpSUDeQzmQVtOWX3I5/eqOfpEBj0Ldu86xq+LTbTmSqjx9ZwaPzFaHDyDIZvPr/wdPOoQ4mH0mXj05DmLc5GyHAOJp/qoAA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 14:43:23 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:23 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 09/12] iio: imu: inv_icm42600: add buffer support in iio devices
Date:   Thu,  7 May 2020 16:42:19 +0200
Message-Id: <20200507144222.20989-10-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ef73221-038d-431a-c6af-08d7f294fe69
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501F7C397B1281C82FD2FECC4A50@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bLM10Mdg9qA9y0ByvTTBxE+gB6vLRsygmWae2J36iqJXsdDmGqSHivk5rjXAhO4RPVjGJ2PANvcfohZ11IHZHG6OB/pCgMwGBLJUvl4mcFSNU0J8vPaaiWnV8kNnYFWNSTIk2qvy8HDhme6GxTFCGuM+wV961C6m6DB1t9n/qUrJhh6NQtX81c7w4bfAhMSApIpula80h6qrhyRTi5YROP9zmrbigzfqjdgrjAVymBXDDSlRjtS9l8L8dZwI2g2KjcvAatT6lOUOsXI0WIIq2Ejec4VAjqegqYxaCgZtQSkmwltvmmPc+wwBqzF52ioYOHXXg2IEwsyHfx8WWPkxED2D8NBerqsWAEwEUhFBbq1ZpwU00m2iwSd0y6l3GoSWKVcp+S0zgyHZxbcws7jgjCJD//vtCVEGWMG/Vk0dHI5yHCfMarQAc7DAVzn7Gaj7qUlcjs5K5HtHk14nhvwyZGQMKRBaHBn3u8pZPnrdKh/ib+593bG2QuYTnUtudhft2h1meduenkDkfzJfvKUTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(39850400004)(366004)(33430700001)(30864003)(107886003)(4326008)(8676002)(6486002)(2906002)(316002)(5660300002)(8936002)(1076003)(26005)(7696005)(33440700001)(66946007)(956004)(66476007)(52116002)(2616005)(86362001)(186003)(83320400001)(83280400001)(83310400001)(83290400001)(16526019)(478600001)(6666004)(36756003)(66556008)(83300400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3aAiZNoC8vcV3btvAFZ5yGcafNBgPnWZ3IqggzYErDUQSxn0grnouBK4nUtBTfcRM9FLPh+jr28zBirSeRMCaziR70PBH00k/1XvcUaeIWn8ws2Ox7qKqLaUR+uHz3JZX2gwYRR5KS65UyjiC+VZ8stMbiRk+Op9fOnMo5cGhrCS7sMyXDzHKalhajAxfpnE6hFxkDvNSqNtZ3d0U13UNSl/GPTQsebru+0CHrM5FFVadwBi7fUswTHOI4honDDP0meJXob58pFO5TMs1Ig5y+I1lAA6L8uu/+6PMNHF3cM42GK/49o/qyG4TyQ6KqXNcATEiWB5rtCXvG/F4+PkFRLO4yzckMe2/+DeHe40ZbeCiTwRR9CCcZm0aU/z8K0ekz84Poca9yGYcgpnD2fkR9ttS2Dachnap6Uw4FiZGtCRcoiCgSCCIdDpdpmjyqg3Z2Ue+R7G/NxQYiy2eOkE8/zcLKjVV8XF2t/2APeEzaYUDgmvwTcf7q2hYBedME1VEOdVN+ljtCtWyYDgMffjSAn7wKWdjL64AWrhOlQ/HQ0ccwA5t8a0Nf4DkX2/boXNGn+FXFiWjO56MTsD7IGTfC583qwtRAnZUQgWCN7tlPhRF1z3ErgM6P50UMzXe+vJQc0b1qptwd04qRsq6IpbmhRDjH9bZUtVf119ERTDAwJ2+kOeOqWHseRSJGbUtZzCgK5rpSAIH32abJMThUgEElB7JZCnhbt8Tp5FnoGMe3Wz8Xz7ByBZWjzAxMccAidhO1Pwo+vnfrZ8ghzNpIeNsgqmV7vS8P297644pzwIn4Q=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef73221-038d-431a-c6af-08d7f294fe69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:23.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7McbcaDRQjGx5iqtkJj65mKF2mDhgUfi5FsbhEM0oPk7r7gTpaAxyzn5xcCkIQBqXwkCds25XU0JwZMa1v1TzMbNbUXnBiaY4VE3E6sW+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use triggered buffer by parsing FIFO data read in device trigger.
Support hwfifo watermark by multiplexing gyro and accel settings.
Support hwfifo flush.

Simply use interrupt timestamp first.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/Kconfig          |   3 +-
 drivers/iio/imu/inv_icm42600/Makefile         |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   8 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 183 +++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 353 ++++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.h    | 162 ++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  23 ++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 183 +++++++++
 .../imu/inv_icm42600/inv_icm42600_trigger.c   |  15 +-
 9 files changed, 928 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h

diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
index 7b3eaeb2aa4a..8c0969319c49 100644
--- a/drivers/iio/imu/inv_icm42600/Kconfig
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -2,7 +2,8 @@
 
 config INV_ICM42600
 	tristate
-	select IIO_TRIGGER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config INV_ICM42600_I2C
 	tristate "InvenSense ICM-426xx I2C driver"
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index e1f2aacbe888..d6732118010c 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -6,6 +6,7 @@ inv-icm42600-y += inv_icm42600_gyro.o
 inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
 inv-icm42600-y += inv_icm42600_trigger.o
+inv-icm42600-y += inv_icm42600_buffer.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 175c1f67faee..947ca4dd245b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -15,6 +15,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
+#include "inv_icm42600_buffer.h"
+
 enum inv_icm42600_chip {
 	INV_CHIP_ICM42600,
 	INV_CHIP_ICM42602,
@@ -124,6 +126,7 @@ struct inv_icm42600_suspended {
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
  *  @trigger:		device internal interrupt trigger
+ *  @fifo:		FIFO management structure.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -138,6 +141,7 @@ struct inv_icm42600_state {
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
 	struct iio_trigger *trigger;
+	struct inv_icm42600_fifo fifo;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -378,8 +382,12 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts);
+
 int inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts);
+
 int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,
 			      int irq_type);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 74dac5f283d4..4206be54d057 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -10,9 +10,13 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
+#include "inv_icm42600_buffer.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -46,6 +50,7 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_Y,
 	INV_ICM42600_ACCEL_SCAN_Z,
 	INV_ICM42600_ACCEL_SCAN_TEMP,
+	INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
@@ -61,8 +66,100 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
 };
 
+/* IIO buffer data */
+struct inv_icm42600_accel_buffer {
+	struct inv_icm42600_fifo_sensor_data accel;
+	int8_t temp;
+	int64_t timestamp;
+};
+
+#define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
+	(BIT(INV_ICM42600_ACCEL_SCAN_X) |				\
+	BIT(INV_ICM42600_ACCEL_SCAN_Y) |				\
+	BIT(INV_ICM42600_ACCEL_SCAN_Z))
+
+#define INV_ICM42600_SCAN_MASK_TEMP	BIT(INV_ICM42600_ACCEL_SCAN_TEMP)
+
+static const unsigned long inv_icm42600_accel_scan_masks[] = {
+	/* 3-axis accel + temperature */
+	INV_ICM42600_SCAN_MASK_ACCEL_3AXIS | INV_ICM42600_SCAN_MASK_TEMP,
+	0,
+};
+
+static irqreturn_t inv_icm42600_accel_handler(int irq, void *_data)
+{
+	struct iio_poll_func *pf = _data;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	const size_t fifo_nb = st->fifo.nb.total;
+	int ret;
+
+	/* exit if no sample */
+	if (fifo_nb == 0)
+		goto out;
+
+	ret = inv_icm42600_accel_parse_fifo(indio_dev, pf->timestamp);
+	if (ret)
+		dev_err(regmap_get_device(st->map), "accel fifo error %d\n",
+			ret);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+/* enable accelerometer sensor and FIFO write */
+static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
+					       const unsigned long *scan_mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_accel = 0;
+	unsigned int sleep;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {
+		/* enable temp sensor */
+		ret = inv_icm42600_set_temp_conf(st, true, &sleep_temp);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42600_SENSOR_TEMP;
+	}
+
+	if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {
+		/* enable accel sensor */
+		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_accel);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42600_SENSOR_ACCEL;
+	}
+
+	/* update data FIFO write and FIFO watermark */
+	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	if (ret)
+		goto out_unlock;
+	ret = inv_icm42600_buffer_update_watermark(st);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	/* sleep maximum required time */
+	if (sleep_accel > sleep_temp)
+		sleep = sleep_accel;
+	else
+		sleep = sleep_temp;
+	if (sleep)
+		msleep(sleep);
+	return ret;
+}
+
 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
 					  struct iio_chan_spec const *chan,
 					  int16_t *val)
@@ -250,6 +347,8 @@ static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 	conf.odr = inv_icm42600_accel_odr_conv[idx / 2];
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	inv_icm42600_buffer_update_fifo_period(st);
+	inv_icm42600_buffer_update_watermark(st);
 	mutex_unlock(&st->lock);
 
 	pm_runtime_mark_last_busy(dev);
@@ -512,12 +611,51 @@ static int inv_icm42600_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						   unsigned int val)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	st->fifo.watermark.accel = val;
+	ret = inv_icm42600_buffer_update_watermark(st);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
+					   unsigned int count)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_buffer_hwfifo_flush(st, count);
+	if (!ret)
+		ret = st->fifo.nb.accel;
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info inv_icm42600_accel_info = {
 	.read_raw = inv_icm42600_accel_read_raw,
 	.read_avail = inv_icm42600_accel_read_avail,
 	.write_raw = inv_icm42600_accel_write_raw,
 	.write_raw_get_fmt = inv_icm42600_accel_write_raw_get_fmt,
 	.debugfs_reg_access = inv_icm42600_debugfs_reg,
+	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
 };
 
 int inv_icm42600_accel_init(struct inv_icm42600_state *st)
@@ -525,6 +663,7 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
 	if (!name)
@@ -541,7 +680,51 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = inv_icm42600_accel_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_accel_channels);
+	indio_dev->available_scan_masks = inv_icm42600_accel_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      inv_icm42600_accel_handler,
+					      &inv_icm42600_buffer_ops);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trigger);
 
 	st->indio_accel = indio_dev;
 	return devm_iio_device_register(dev, st->indio_accel);
 }
+
+int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	const size_t accel_nb = st->fifo.nb.accel;
+	ssize_t i, size;
+	const void *accel, *gyro, *temp, *timestamp;
+	unsigned int odr;
+	struct inv_icm42600_accel_buffer buffer;
+
+	/* exit if no accel sample */
+	if (accel_nb == 0)
+		return 0;
+
+	/* parse all fifo packets */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		dev_dbg(regmap_get_device(st->map), "accel packet size = %zd\n",
+			size);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+		/* skip packet if no accel data or data is invalid */
+		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel)) {
+			dev_dbg(regmap_get_device(st->map), "skip accel data\n");
+			continue;
+		}
+		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
+		memcpy(&buffer.temp, temp, sizeof(buffer.temp));
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
new file mode 100644
index 000000000000..b428abdc92ee
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/math64.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include "inv_icm42600.h"
+#include "inv_icm42600_buffer.h"
+
+void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
+{
+	uint32_t period_gyro, period_accel, period;
+
+	if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)
+		period_gyro = inv_icm42600_odr_to_period(st->conf.gyro.odr);
+	else
+		period_gyro = U32_MAX;
+
+	if (st->fifo.en & INV_ICM42600_SENSOR_ACCEL)
+		period_accel = inv_icm42600_odr_to_period(st->conf.accel.odr);
+	else
+		period_accel = U32_MAX;
+
+	if (period_gyro <= period_accel)
+		period = period_gyro;
+	else
+		period = period_accel;
+
+	st->fifo.period = period;
+}
+
+int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
+				    unsigned int fifo_en)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* update only FIFO EN bits */
+	mask = INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC_EN |
+		INV_ICM42600_FIFO_CONFIG1_TEMP_EN |
+		INV_ICM42600_FIFO_CONFIG1_GYRO_EN |
+		INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
+
+	val = 0;
+	if (fifo_en & INV_ICM42600_SENSOR_GYRO)
+		val |= INV_ICM42600_FIFO_CONFIG1_GYRO_EN;
+	if (fifo_en & INV_ICM42600_SENSOR_ACCEL)
+		val |= INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
+	if (fifo_en & INV_ICM42600_SENSOR_TEMP)
+		val |= INV_ICM42600_FIFO_CONFIG1_TEMP_EN;
+
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CONFIG1,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	st->fifo.en = fifo_en;
+	inv_icm42600_buffer_update_fifo_period(st);
+
+	return 0;
+}
+
+static size_t inv_icm42600_get_packet_size(unsigned int fifo_en)
+{
+	size_t packet_size;
+
+	if ((fifo_en & INV_ICM42600_SENSOR_GYRO) &&
+			(fifo_en & INV_ICM42600_SENSOR_ACCEL))
+		packet_size = INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
+	else
+		packet_size = INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
+
+	return packet_size;
+}
+
+static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
+					     size_t packet_size)
+{
+	size_t wm_size;
+	unsigned int wm;
+
+	wm_size = watermark * packet_size;
+	if (wm_size > INV_ICM42600_FIFO_WATERMARK_MAX)
+		wm_size = INV_ICM42600_FIFO_WATERMARK_MAX;
+
+	wm = wm_size / packet_size;
+
+	return wm;
+}
+
+int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
+{
+	size_t packet_size, wm_size;
+	unsigned int wm_gyro, wm_accel, watermark;
+	uint32_t period_gyro, period_accel, period;
+	int64_t latency_gyro, latency_accel, latency;
+	unsigned int mask, val;
+	bool restore;
+	__le16 raw_wm;
+	int ret;
+
+	packet_size = inv_icm42600_get_packet_size(st->fifo.en);
+
+	/* get minimal latency, depending on sensor watermark and odr */
+	wm_gyro = inv_icm42600_wm_truncate(st->fifo.watermark.gyro,
+					   packet_size);
+	wm_accel = inv_icm42600_wm_truncate(st->fifo.watermark.accel,
+					    packet_size);
+	period_gyro = inv_icm42600_odr_to_period(st->conf.gyro.odr);
+	period_accel = inv_icm42600_odr_to_period(st->conf.accel.odr);
+	latency_gyro = (int64_t)period_gyro * (int64_t)wm_gyro;
+	latency_accel = (int64_t)period_accel * (int64_t)wm_accel;
+	if (latency_gyro == 0) {
+		latency = latency_accel;
+		watermark = wm_accel;
+	} else if (latency_accel == 0) {
+		latency = latency_gyro;
+		watermark = wm_gyro;
+	} else {
+		/* compute the smallest latency that is a multiple of both */
+		if (latency_gyro <= latency_accel) {
+			latency = latency_gyro;
+			latency -= latency_accel % latency_gyro;
+		} else {
+			latency = latency_accel;
+			latency -= latency_gyro % latency_accel;
+		}
+		/* use the shortest period */
+		if (period_gyro <= period_accel)
+			period = period_gyro;
+		else
+			period = period_accel;
+		/* all this works because periods are multiple of each others */
+		watermark = div_s64(latency, period);
+		if (watermark < 1)
+			watermark = 1;
+	}
+	wm_size = watermark * packet_size;
+	dev_dbg(regmap_get_device(st->map), "watermark: %u (%zu)\n",
+		watermark, wm_size);
+
+	/* changing FIFO watermark requires to turn off watermark interrupt */
+	mask = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
+	val = 0;
+	ret = regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
+				       mask, val, &restore);
+	if (ret)
+		return ret;
+
+	raw_wm = INV_ICM42600_FIFO_WATERMARK_VAL(wm_size);
+	ret = regmap_bulk_write(st->map, INV_ICM42600_REG_FIFO_WATERMARK,
+				&raw_wm, sizeof(raw_wm));
+	if (ret)
+		return ret;
+
+	/* restore watermark interrupt */
+	if (restore) {
+		mask = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
+		val = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
+		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+					 mask, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+
+	pm_runtime_get_sync(dev);
+
+	return 0;
+}
+
+static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int sleep = 0;
+	int ret;
+
+	if (indio_dev == st->indio_gyro) {
+		sensor = INV_ICM42600_SENSOR_GYRO;
+		watermark = &st->fifo.watermark.gyro;
+	} else if (indio_dev == st->indio_accel) {
+		sensor = INV_ICM42600_SENSOR_ACCEL;
+		watermark = &st->fifo.watermark.accel;
+	} else {
+		return -EINVAL;
+	}
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
+	if (ret)
+		goto out_unlock;
+
+	*watermark = 0;
+	ret = inv_icm42600_buffer_update_watermark(st);
+	if (ret)
+		goto out_unlock;
+
+	conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
+	if (sensor == INV_ICM42600_SENSOR_GYRO)
+		ret = inv_icm42600_set_gyro_conf(st, &conf, &sleep);
+	else
+		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	if (sleep)
+		msleep(sleep);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+const struct iio_buffer_setup_ops inv_icm42600_buffer_ops = {
+	.preenable = inv_icm42600_buffer_preenable,
+	.postenable = iio_triggered_buffer_postenable,
+	.predisable = iio_triggered_buffer_predisable,
+	.postdisable = inv_icm42600_buffer_postdisable,
+};
+
+int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
+				  unsigned int max)
+{
+	struct device *dev = regmap_get_device(st->map);
+	__be16 raw_fifo_count;
+	size_t max_count;
+	ssize_t i, size;
+	const void *accel, *gyro, *temp, *timestamp;
+	unsigned int odr;
+	int ret;
+
+	/* reset all samples counters */
+	st->fifo.count = 0;
+	st->fifo.nb.gyro = 0;
+	st->fifo.nb.accel = 0;
+	st->fifo.nb.total = 0;
+
+	/* compute maximum FIFO read size */
+	if (max == 0)
+		max_count = sizeof(st->fifo.data);
+	else
+		max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
+
+	/* read FIFO count value */
+	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
+			       &raw_fifo_count, sizeof(raw_fifo_count));
+	if (ret)
+		return ret;
+	st->fifo.count = be16_to_cpu(raw_fifo_count);
+	dev_dbg(dev, "FIFO count = %zu\n", st->fifo.count);
+
+	/* check and sanitize FIFO count value */
+	if (st->fifo.count == 0)
+		return 0;
+	if (st->fifo.count > max_count)
+		st->fifo.count = max_count;
+
+	/* read all FIFO data in internal buffer */
+	ret = regmap_noinc_read(st->map, INV_ICM42600_REG_FIFO_DATA,
+				st->fifo.data, st->fifo.count);
+	if (ret)
+		return ret;
+
+	/* compute number of samples for each sensor */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		if (size <= 0)
+			break;
+		if (gyro != NULL && inv_icm42600_fifo_is_data_valid(gyro))
+			st->fifo.nb.gyro++;
+		if (accel != NULL && inv_icm42600_fifo_is_data_valid(accel))
+			st->fifo.nb.accel++;
+		st->fifo.nb.total++;
+	}
+
+	return 0;
+}
+
+int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
+				     unsigned int count)
+{
+	int64_t ts_gyro, ts_accel;
+	int ret;
+
+	dev_dbg(regmap_get_device(st->map), "FIFO flush %u\n", count);
+
+	ts_gyro = iio_get_time_ns(st->indio_gyro);
+	ts_accel = iio_get_time_ns(st->indio_accel);
+	ret = inv_icm42600_buffer_fifo_read(st, count);
+	if (ret)
+		return ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro, ts_gyro);
+	if (ret)
+		return ret;
+
+	return inv_icm42600_accel_parse_fifo(st->indio_accel, ts_accel);
+}
+
+int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/*
+	 * Default FIFO configuration (bits 7 to 5)
+	 * - use invalid value
+	 * - FIFO count in bytes
+	 * - FIFO count in big endian
+	 */
+	mask = GENMASK(7, 5);
+	val = INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN;
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable FIFO partial read and continuous watermark interrupt.
+	 * Disable all FIFO EN bits.
+	 */
+	mask = GENMASK(6, 5) | GENMASK(3, 0);
+	val = INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD |
+	      INV_ICM42600_FIFO_CONFIG1_WM_GT_TH;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CONFIG1,
+				  mask, val);
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
new file mode 100644
index 000000000000..74b91c0e664b
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_ICM42600_BUFFER_H_
+#define INV_ICM42600_BUFFER_H_
+
+#include <linux/kernel.h>
+#include <linux/bits.h>
+
+struct inv_icm42600_state;
+
+#define INV_ICM42600_SENSOR_GYRO	BIT(0)
+#define INV_ICM42600_SENSOR_ACCEL	BIT(1)
+#define INV_ICM42600_SENSOR_TEMP	BIT(2)
+
+struct inv_icm42600_fifo {
+	unsigned int en;
+	uint32_t period;
+	struct {
+		unsigned int gyro;
+		unsigned int accel;
+	} watermark;
+	size_t count;
+	struct {
+		size_t gyro;
+		size_t accel;
+		size_t total;
+	} nb;
+	uint8_t data[2080];
+};
+
+/* FIFO header: 1 byte */
+#define INV_ICM42600_FIFO_HEADER_MSG		BIT(7)
+#define INV_ICM42600_FIFO_HEADER_ACCEL		BIT(6)
+#define INV_ICM42600_FIFO_HEADER_GYRO		BIT(5)
+#define INV_ICM42600_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
+#define INV_ICM42600_FIFO_HEADER_ODR_ACCEL	BIT(1)
+#define INV_ICM42600_FIFO_HEADER_ODR_GYRO	BIT(0)
+
+/* FIFO data packet */
+struct inv_icm42600_fifo_sensor_data {
+	__be16 x;
+	__be16 y;
+	__be16 z;
+} __packed;
+#define INV_ICM42600_FIFO_DATA_INVALID		-32768
+
+struct inv_icm42600_fifo_1sensor_packet {
+	uint8_t header;
+	struct inv_icm42600_fifo_sensor_data data;
+	int8_t temp;
+} __packed;
+#define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE		8
+
+struct inv_icm42600_fifo_2sensors_packet {
+	uint8_t header;
+	struct inv_icm42600_fifo_sensor_data accel;
+	struct inv_icm42600_fifo_sensor_data gyro;
+	int8_t temp;
+	__be16 timestamp;
+} __packed;
+#define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE		16
+
+static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)
+{
+	return be16_to_cpu(d);
+}
+
+static inline bool
+inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_data *s)
+{
+	int16_t x, y, z;
+
+	x = inv_icm42600_fifo_get_sensor_data(s->x);
+	y = inv_icm42600_fifo_get_sensor_data(s->y);
+	z = inv_icm42600_fifo_get_sensor_data(s->z);
+
+	if (x == INV_ICM42600_FIFO_DATA_INVALID &&
+			y == INV_ICM42600_FIFO_DATA_INVALID &&
+			z == INV_ICM42600_FIFO_DATA_INVALID)
+		return false;
+
+	return true;
+}
+
+static inline ssize_t inv_icm42600_fifo_decode_packet(const void *packet,
+		const void **accel, const void **gyro, const void **temp,
+		const void **timestamp, unsigned int *odr)
+{
+	const struct inv_icm42600_fifo_1sensor_packet *pack1 = packet;
+	const struct inv_icm42600_fifo_2sensors_packet *pack2 = packet;
+	uint8_t header = *((const uint8_t *)packet);
+
+	/* FIFO empty */
+	if (header & INV_ICM42600_FIFO_HEADER_MSG) {
+		*accel = NULL;
+		*gyro = NULL;
+		*temp = NULL;
+		*timestamp = NULL;
+		*odr = 0;
+		return 0;
+	}
+
+	/* handle odr flags */
+	*odr = 0;
+	if (header & INV_ICM42600_FIFO_HEADER_ODR_GYRO)
+		*odr |= INV_ICM42600_SENSOR_GYRO;
+	if (header & INV_ICM42600_FIFO_HEADER_ODR_ACCEL)
+		*odr |= INV_ICM42600_SENSOR_ACCEL;
+
+	/* accel + gyro */
+	if ((header & INV_ICM42600_FIFO_HEADER_ACCEL) &&
+			(header & INV_ICM42600_FIFO_HEADER_GYRO)) {
+		*accel = &pack2->accel;
+		*gyro = &pack2->gyro;
+		*temp = &pack2->temp;
+		*timestamp = &pack2->timestamp;
+		return INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
+	}
+
+	/* accel only */
+	if (header & INV_ICM42600_FIFO_HEADER_ACCEL) {
+		*accel = &pack1->data;
+		*gyro = NULL;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* gyro only */
+	if (header & INV_ICM42600_FIFO_HEADER_GYRO) {
+		*accel = NULL;
+		*gyro = &pack1->data;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* invalid packet if here */
+	return -EINVAL;
+}
+
+extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;
+
+int inv_icm42600_buffer_init(struct inv_icm42600_state *st);
+
+void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st);
+
+int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
+				    unsigned int fifo_en);
+
+int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st);
+
+int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
+				  unsigned int max);
+
+int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 1102c54396e3..689089065ff9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -14,6 +14,7 @@
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_buffer.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -515,6 +516,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 	if (ret)
 		return ret;
 
+	/* setup FIFO buffer */
+	ret = inv_icm42600_buffer_init(st);
+	if (ret)
+		return ret;
+
 	/* setup interrupt trigger */
 	ret = inv_icm42600_trigger_init(st, irq, irq_type);
 	if (ret)
@@ -559,6 +565,16 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 		goto out_unlock;
 	}
 
+	/* disable FIFO data streaming */
+	if (iio_buffer_enabled(st->indio_gyro) ||
+			iio_buffer_enabled(st->indio_accel)) {
+		/* set FIFO in bypass mode */
+		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+				   INV_ICM42600_FIFO_CONFIG_BYPASS);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
 					 INV_ICM42600_SENSOR_MODE_OFF, false,
 					 NULL);
@@ -594,6 +610,13 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
+	/* restore FIFO data streaming */
+	if (iio_buffer_enabled(st->indio_gyro) ||
+			iio_buffer_enabled(st->indio_accel)) {
+		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
+
 out_unlock:
 	mutex_unlock(&st->lock);
 	return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index c0164ab2830e..dafb104abc77 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -10,9 +10,13 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
+#include "inv_icm42600_buffer.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -46,6 +50,7 @@ enum inv_icm42600_gyro_scan {
 	INV_ICM42600_GYRO_SCAN_Y,
 	INV_ICM42600_GYRO_SCAN_Z,
 	INV_ICM42600_GYRO_SCAN_TEMP,
+	INV_ICM42600_GYRO_SCAN_TIMESTAMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
@@ -61,8 +66,100 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),
 };
 
+/* IIO buffer data */
+struct inv_icm42600_gyro_buffer {
+	struct inv_icm42600_fifo_sensor_data gyro;
+	int8_t temp;
+	int64_t timestamp;
+};
+
+#define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
+	(BIT(INV_ICM42600_GYRO_SCAN_X) |				\
+	BIT(INV_ICM42600_GYRO_SCAN_Y) |					\
+	BIT(INV_ICM42600_GYRO_SCAN_Z))
+
+#define INV_ICM42600_SCAN_MASK_TEMP	BIT(INV_ICM42600_GYRO_SCAN_TEMP)
+
+static const unsigned long inv_icm42600_gyro_scan_masks[] = {
+	/* 3-axis gyro + temperature */
+	INV_ICM42600_SCAN_MASK_GYRO_3AXIS | INV_ICM42600_SCAN_MASK_TEMP,
+	0,
+};
+
+static irqreturn_t inv_icm42600_gyro_handler(int irq, void *_data)
+{
+	struct iio_poll_func *pf = _data;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	const size_t fifo_nb = st->fifo.nb.total;
+	int ret;
+
+	/* exit if no sample */
+	if (fifo_nb == 0)
+		goto out;
+
+	ret = inv_icm42600_gyro_parse_fifo(indio_dev, pf->timestamp);
+	if (ret)
+		dev_err(regmap_get_device(st->map), "gyro fifo error %d\n",
+			ret);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+/* enable gyroscope sensor and FIFO write */
+static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
+					      const unsigned long *scan_mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_gyro = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {
+		/* enable temp sensor */
+		ret = inv_icm42600_set_temp_conf(st, true, &sleep_temp);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42600_SENSOR_TEMP;
+	}
+
+	if (*scan_mask & INV_ICM42600_SCAN_MASK_GYRO_3AXIS) {
+		/* enable gyro sensor */
+		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+		ret = inv_icm42600_set_gyro_conf(st, &conf, &sleep_gyro);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42600_SENSOR_GYRO;
+	}
+
+	/* update data FIFO write and FIFO watermark */
+	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	if (ret)
+		goto out_unlock;
+	ret = inv_icm42600_buffer_update_watermark(st);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	/* sleep maximum required time */
+	if (sleep_gyro > sleep_temp)
+		sleep = sleep_gyro;
+	else
+		sleep = sleep_temp;
+	if (sleep)
+		msleep(sleep);
+	return ret;
+}
+
 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
 					 struct iio_chan_spec const *chan,
 					 int16_t *val)
@@ -262,6 +359,8 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 	conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	inv_icm42600_buffer_update_fifo_period(st);
+	inv_icm42600_buffer_update_watermark(st);
 	mutex_unlock(&st->lock);
 
 	pm_runtime_mark_last_busy(dev);
@@ -524,12 +623,51 @@ static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						  unsigned int val)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	st->fifo.watermark.gyro = val;
+	ret = inv_icm42600_buffer_update_watermark(st);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
+					  unsigned int count)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_buffer_hwfifo_flush(st, count);
+	if (!ret)
+		ret = st->fifo.nb.gyro;
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info inv_icm42600_gyro_info = {
 	.read_raw = inv_icm42600_gyro_read_raw,
 	.read_avail = inv_icm42600_gyro_read_avail,
 	.write_raw = inv_icm42600_gyro_write_raw,
 	.write_raw_get_fmt = inv_icm42600_gyro_write_raw_get_fmt,
 	.debugfs_reg_access = inv_icm42600_debugfs_reg,
+	.update_scan_mode = inv_icm42600_gyro_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm42600_gyro_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm42600_gyro_hwfifo_flush,
 };
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
@@ -537,6 +675,7 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
 	if (!name)
@@ -553,7 +692,51 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = inv_icm42600_gyro_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
+	indio_dev->available_scan_masks = inv_icm42600_gyro_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      inv_icm42600_gyro_handler,
+					      &inv_icm42600_buffer_ops);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trigger);
 
 	st->indio_gyro = indio_dev;
 	return devm_iio_device_register(dev, st->indio_gyro);
 }
+
+int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	const size_t gyro_nb = st->fifo.nb.gyro;
+	ssize_t i, size;
+	const void *accel, *gyro, *temp, *timestamp;
+	unsigned int odr;
+	struct inv_icm42600_gyro_buffer buffer;
+
+	/* exit if no gyro sample */
+	if (gyro_nb == 0)
+		return 0;
+
+	/* parse all fifo packets */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		dev_dbg(regmap_get_device(st->map), "gyro packet size = %zd\n",
+			size);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+		/* skip packet if no gyro data or data is invalid */
+		if (gyro == NULL || !inv_icm42600_fifo_is_data_valid(gyro)) {
+			dev_dbg(regmap_get_device(st->map), "skip gyro data\n");
+			continue;
+		}
+		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
+		memcpy(&buffer.temp, temp, sizeof(buffer.temp));
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
index 7a5e76305f0b..5667e0204722 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
@@ -13,6 +13,7 @@
 #include <linux/iio/trigger_consumer.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_buffer.h"
 
 static irqreturn_t inv_icm42600_trigger_timestamp(int irq, void *_data)
 {
@@ -45,8 +46,18 @@ static irqreturn_t inv_icm42600_trigger_int_handler(int irq, void *_data)
 		dev_warn(dev, "FIFO full data lost!\n");
 
 	/* FIFO threshold reached */
-	if (status & INV_ICM42600_INT_STATUS_FIFO_THS)
-		iio_trigger_poll_chained(st->trigger);
+	if (status & INV_ICM42600_INT_STATUS_FIFO_THS) {
+		ret = inv_icm42600_buffer_fifo_read(st, 0);
+		if (ret)
+			dev_err(dev, "FIFO read error %d\n", ret);
+	} else {
+		st->fifo.count = 0;
+		st->fifo.nb.gyro = 0;
+		st->fifo.nb.accel = 0;
+		st->fifo.nb.total = 0;
+	}
+
+	iio_trigger_poll_chained(st->trigger);
 
 out_unlock:
 	mutex_unlock(&st->lock);
-- 
2.17.1

