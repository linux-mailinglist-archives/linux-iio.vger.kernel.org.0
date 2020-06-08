Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260C71F20FB
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFHUpL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:45:11 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:9434 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgFHUoO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:14 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KhpKL027834;
        Mon, 8 Jun 2020 13:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=hWAVXgMs92459rC0CMPai7GsTydLjrzCCf3U3IL/E1o=;
 b=nIG1Ye4rtrBmkBU/81psa9SL7BU9qOpZwUIrsYZ7wD5hddE7xyAXp7bpB4afPawVp4sg
 lTCzD07E+0ypRA4RfabaOQb7tt/fKK7XiXp9ONV/v3vXg/MslIm6b9jIhw8OyV7fmJly
 0VDibF1oqxmFeaGLzgXiCnQ2YnJ2i3Ho74Yt55qQzv/dvgbieOz839V5CQwY7WgJUa2e
 YGSxMFuH4RjOHzdrhjDsrYQDiLSl4aKC+nM02NQ9XuPc0WM6OffWS78tNpIlIhfpH4PD
 lz4geZgXe4JB0p1ZLGmOAnGdfjYBOMrUjwFWNOWj8XuD7isnOJfQnTyjwrSoXeK2ufcU Gw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1xgAH4/bsorC0jmZuUw+++iucqQsShGHTd3NRqIiw9wnoCqr4J04xF1XwriGoonJubR+EzLBSfX/8boV2huzjMsBQcl3mChYY4Mk4VRxsOFs+nwACecFWsYxbzrY4jDchfBVaJ8JuJz70MiH57qOiRa4Mklm7ZU86yGtKVYvXC4+uo5Jxy4ufroLAds+3XxY49ydzAjJH4oeVmLhuq97TVF5ad2z8X4wmzK7IOO4uI53GQ5vcCpW5G33A2x6zLsxEa+zvddMV0Yn6te4r6ji2QOSHHPMCkuZl2ceTEkOdQIJoKdWH8DVjBksuZ6Up09NwQStdwk09YH9s1/qm5qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWAVXgMs92459rC0CMPai7GsTydLjrzCCf3U3IL/E1o=;
 b=FzRiqU02FIsREnxzc+9WE4lIXdcyBmth630Uzi5nY7bwSowcI/li6ScMmOmasT4+WxoranqkVETX7lotienOSDvjJxGiOPWzx9yrycn5Q6hb2Z8/pEqABPPRq8sJhelEDskGXESaaRu3cEJhIlZPQCjqvXr2NFZR+kRoe/yIQXWOTThODhpDFZsGCTyT2SObKm0vBkU+1ZJfNrPs+91QDXjv+W9Eyi10OUtRbOVi1bDdCrlR9xfOj/+FJYCmqLlWojETGeAKtFIRWvjarJovYTteNW+bT7ZJ3rkGIgVpPTJPw8cdEM5KFu+/ZwM92ja7x+iovVSWtZ+3qdjnRI34lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWAVXgMs92459rC0CMPai7GsTydLjrzCCf3U3IL/E1o=;
 b=AdPxBEQjFxyvcnNzIUcxbUGkkyaBsZwQf9xKU4MG0oybJAs1aiiJdFkDLxpyAwMM8DWfpvC62txVR08GhPddwyoAc9kmWicjU7jm3/rh+DLWJ9ajdMBY7VmvrdeNzX5CE7ac13izURnyA05C7FRzu7qMycvdUhOuZ0/dOr2iK10=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:44:06 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:06 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 10/13] iio: imu: inv_icm42600: add buffer support in iio devices
Date:   Mon,  8 Jun 2020 22:42:47 +0200
Message-Id: <20200608204250.3291-11-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:44:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ddb07f2-ee37-4caf-fcb2-08d80becaf57
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39515B2D7FA7994D6C6A17F7C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCLyeGKzG8QteKMoaQqHqYPq6kZfVomYcvFx9Y2HO2KBvJu91dvibFnSzcixxWsYO+GvFm5pXZeeeGdAuAetpTpOiR8TkCSeZirOO4zZcz2YJ6FYHWo3/W8l83KM3rALqUzKQe1+bp+b3iRIBU6jysOQCaLDhP79SPVr5Bko2FSPdv9EpxRhykcztFXJem38WfT5bc26z3X6RcthZuE7yK4VXWkn5hBnA5QeAjr1kvZLhUwo0qGaitD6A65NQ9TbPW+akuFb0AQYlLHafJyIy/O1ZRSzl4l+TjuKLPs5GJgXfh1ESx7JhBs/I7TNzBZeET2se6DTmWLERSYKF4OTFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(30864003)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JN6OoK+KZZDr6O5jwizPjR6nOS1377r2gJH+XXjjJZvpRY2t+54l5+9r/nFG0nX7Eot+s9De72gKBeAO29Y2ejwaKOC09ornB12FqPn7qpXoWvN//lo8tBhXK+/ZOfRBd54y0tcraR0c0PU5XzZwqf35kNwytgI1PU/VqD6tnzdtDgYJ3Lu0ZnF7BlSbcATgQeOmqINBH57h1qbjkbCqORlzrMsup5Iyjy8MYbVkhorgujT2ZQ0DA9NqR18FFu1lVMxlL1+ijTiW4FDEG5iEJm+4OsVgSNo1V+hyopkmriWfBeI9xOyoqSv9LuHYrJDl5VHmRaFotGl8LYx9T3BOktCRWs7XVdtvKVMHGcvDIniFqYYFPFe7qn/9r8YwEdD3EfWksjxp/X7nvbng4L9mP2eOz9DO4vhF5BYZcXfs+v89plTBQf8JTcrcAmi4uEgBsxll7ynoVAHQ34wt2YmLZJ5ssT7+SpRggUt3EePncqw=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddb07f2-ee37-4caf-fcb2-08d80becaf57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:05.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t7azQf5WJ7Sd7pbMi8Z/YgmELyfdpdUMYlZ7rRdIl9vtpqbSb8TplSblogZivUYjiHmLR2X4GIjZmgiFOc8FjSUUm9lvKvQJmFPc6NNr8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 cotscore=-2147483648 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add all FIFO parsing and reading functions. Add accel and gyro
kfifo buffer and FIFO data parsing. Use device interrupt for
reading data FIFO and launching accel and gyro parsing.

Support hwfifo watermark by multiplexing gyro and accel settings.
Support hwfifo flush.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/Kconfig          |   1 +
 drivers/iio/imu/inv_icm42600/Makefile         |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   8 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 164 ++++-
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 573 ++++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |  98 +++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  30 +
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 164 ++++-
 8 files changed, 1037 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h

diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
index 22390a72f0a3..50cbcfcb6cf1 100644
--- a/drivers/iio/imu/inv_icm42600/Kconfig
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -2,6 +2,7 @@
 
 config INV_ICM42600
 	tristate
+	select IIO_BUFFER
 
 config INV_ICM42600_I2C
 	tristate "InvenSense ICM-426xx I2C driver"
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index 48965824f00c..0f49f6df3647 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -5,6 +5,7 @@ inv-icm42600-y += inv_icm42600_core.o
 inv-icm42600-y += inv_icm42600_gyro.o
 inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
+inv-icm42600-y += inv_icm42600_buffer.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 148894c888cc..7b52d92739c3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -14,6 +14,8 @@
 #include <linux/pm.h>
 #include <linux/iio/iio.h>
 
+#include "inv_icm42600_buffer.h"
+
 enum inv_icm42600_chip {
 	INV_CHIP_ICM42600,
 	INV_CHIP_ICM42602,
@@ -123,6 +125,7 @@ struct inv_icm42600_suspended {
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
  *  @buffer:		data transfer buffer aligned for DMA.
+ *  @fifo:		FIFO management structure.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -137,6 +140,7 @@ struct inv_icm42600_state {
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
 	uint8_t buffer[2] ____cacheline_aligned;
+	struct inv_icm42600_fifo fifo;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -377,6 +381,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 
 struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev);
+
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 3f214df44093..77cdad99de91 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -11,9 +11,12 @@
 #include <linux/delay.h>
 #include <linux/math64.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
+#include "inv_icm42600_buffer.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -64,6 +67,79 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
 };
 
+/*
+ * IIO buffer data: size must be a power of 2
+ * 8 bytes: 7 bytes data (accel 6 + temp 1) + 1 byte padding
+ */
+struct inv_icm42600_accel_buffer {
+	struct inv_icm42600_fifo_sensor_data accel;
+	int8_t temp;
+	uint8_t padding;
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
+	/* update data FIFO write */
+	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	if (ret)
+		goto out_unlock;
+
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
@@ -248,7 +324,12 @@ static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		goto out_unlock;
+	inv_icm42600_buffer_update_fifo_period(st);
+	inv_icm42600_buffer_update_watermark(st);
 
+out_unlock:
 	mutex_unlock(&st->lock);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -563,12 +644,51 @@ static int inv_icm42600_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
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
 
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
@@ -576,6 +696,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
 	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
 	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
@@ -586,12 +707,20 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
+	buffer = devm_iio_kfifo_allocate(dev);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_accel_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = inv_icm42600_accel_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_accel_channels);
+	indio_dev->available_scan_masks = inv_icm42600_accel_scan_masks;
+	indio_dev->setup_ops = &inv_icm42600_buffer_ops;
+
+	iio_device_attach_buffer(indio_dev, buffer);
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
@@ -599,3 +728,36 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 
 	return indio_dev;
 }
+
+int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	ssize_t i, size;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	/* buffer is copied to userspace, set padding to 0 to avoid data leak */
+	struct inv_icm42600_accel_buffer buffer = {
+		.padding = 0,
+	};
+
+	/* parse all fifo packets */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* skip packet if no accel data or data is invalid */
+		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel))
+			continue;
+
+		/* fill and push data buffer */
+		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
+		buffer.temp = temp ? *temp : 0;
+		iio_push_to_buffers(indio_dev, &buffer);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
new file mode 100644
index 000000000000..e58e6f0c5698
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+
+#include "inv_icm42600.h"
+#include "inv_icm42600_buffer.h"
+
+/* FIFO header: 1 byte */
+#define INV_ICM42600_FIFO_HEADER_MSG		BIT(7)
+#define INV_ICM42600_FIFO_HEADER_ACCEL		BIT(6)
+#define INV_ICM42600_FIFO_HEADER_GYRO		BIT(5)
+#define INV_ICM42600_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
+#define INV_ICM42600_FIFO_HEADER_ODR_ACCEL	BIT(1)
+#define INV_ICM42600_FIFO_HEADER_ODR_GYRO	BIT(0)
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
+ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const int8_t **temp,
+					const void **timestamp, unsigned int *odr)
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
+	    (header & INV_ICM42600_FIFO_HEADER_GYRO)) {
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
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CONFIG1, mask, val);
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
+	    (fifo_en & INV_ICM42600_SENSOR_ACCEL))
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
+/**
+ * inv_icm42600_buffer_update_watermark - update watermark FIFO threshold
+ * @st:	driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * FIFO watermark threshold is computed based on the required watermark values
+ * set for gyro and accel sensors. Since watermark is all about acceptable data
+ * latency, use the smallest setting between the 2. It means choosing the
+ * smallest latency but this is not as simple as choosing the smallest watermark
+ * value. Latency depends on watermark and ODR. It requires several steps:
+ * 1) compute gyro and accel latencies and choose the smallest value.
+ * 2) adapt the choosen latency so that it is a multiple of both gyro and accel
+ *    ones. Otherwise it is possible that you don't meet a requirement. (for
+ *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
+ *    value of 4 will not meet accel latency requirement because 6 is not a
+ *    multiple of 4. You need to use the value 2.)
+ * 3) Since all periods are multiple of each others, watermark is computed by
+ *    dividing this computed latency by the smallest period, which corresponds
+ *    to the FIFO frequency. Beware that this is only true because we are not
+ *    using 500Hz frequency which is not a multiple of the others.
+ */
+int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
+{
+	size_t packet_size, wm_size;
+	unsigned int wm_gyro, wm_accel, watermark;
+	uint32_t period_gyro, period_accel, period;
+	uint32_t latency_gyro, latency_accel, latency;
+	bool restore;
+	__le16 raw_wm;
+	int ret;
+
+	packet_size = inv_icm42600_get_packet_size(st->fifo.en);
+
+	/* compute sensors latency, depending on sensor watermark and odr */
+	wm_gyro = inv_icm42600_wm_truncate(st->fifo.watermark.gyro, packet_size);
+	wm_accel = inv_icm42600_wm_truncate(st->fifo.watermark.accel, packet_size);
+	/* use us for odr to avoid overflow using 32 bits values */
+	period_gyro = inv_icm42600_odr_to_period(st->conf.gyro.odr) / 1000UL;
+	period_accel = inv_icm42600_odr_to_period(st->conf.accel.odr) / 1000UL;
+	latency_gyro = period_gyro * wm_gyro;
+	latency_accel = period_accel * wm_accel;
+
+	/* 0 value for watermark means that the sensor is turned off */
+	if (latency_gyro == 0) {
+		watermark = wm_accel;
+	} else if (latency_accel == 0) {
+		watermark = wm_gyro;
+	} else {
+		/* compute the smallest latency that is a multiple of both */
+		if (latency_gyro <= latency_accel)
+			latency = latency_gyro - (latency_accel % latency_gyro);
+		else
+			latency = latency_accel - (latency_gyro % latency_accel);
+		/* use the shortest period */
+		if (period_gyro <= period_accel)
+			period = period_gyro;
+		else
+			period = period_accel;
+		/* all this works because periods are multiple of each others */
+		watermark = latency / period;
+		if (watermark < 1)
+			watermark = 1;
+	}
+
+	/* compute watermark value in bytes */
+	wm_size = watermark * packet_size;
+
+	/* changing FIFO watermark requires to turn off watermark interrupt */
+	ret = regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
+				       INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
+				       0, &restore);
+	if (ret)
+		return ret;
+
+	raw_wm = INV_ICM42600_FIFO_WATERMARK_VAL(wm_size);
+	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
+	ret = regmap_bulk_write(st->map, INV_ICM42600_REG_FIFO_WATERMARK,
+				st->buffer, sizeof(raw_wm));
+	if (ret)
+		return ret;
+
+	/* restore watermark interrupt */
+	if (restore) {
+		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+					 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
+					 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
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
+/*
+ * update_scan_mode callback is turning sensors on and setting data FIFO enable
+ * bits.
+ */
+static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	/* exit if FIFO is already on */
+	if (st->fifo.on) {
+		ret = 0;
+		goto out_on;
+	}
+
+	/* set FIFO threshold interrupt */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
+				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
+	if (ret)
+		goto out_unlock;
+
+	/* flush FIFO data */
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		goto out_unlock;
+
+	/* set FIFO in streaming mode */
+	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+			   INV_ICM42600_FIFO_CONFIG_STREAM);
+	if (ret)
+		goto out_unlock;
+
+	/* workaround: first read of FIFO count after reset is always 0 */
+	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT, st->buffer, 2);
+	if (ret)
+		goto out_unlock;
+
+out_on:
+	/* increase FIFO on counter */
+	st->fifo.on++;
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	/* exit if there are several sensors using the FIFO */
+	if (st->fifo.on > 1) {
+		ret = 0;
+		goto out_off;
+	}
+
+	/* set FIFO in bypass mode */
+	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+			   INV_ICM42600_FIFO_CONFIG_BYPASS);
+	if (ret)
+		goto out_unlock;
+
+	/* flush FIFO data */
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		goto out_unlock;
+
+	/* disable FIFO threshold interrupt */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN, 0);
+	if (ret)
+		goto out_unlock;
+
+out_off:
+	/* decrease FIFO on counter */
+	st->fifo.on--;
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_sensor = 0;
+	unsigned int sleep;
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
+		ret = inv_icm42600_set_gyro_conf(st, &conf, &sleep_sensor);
+	else
+		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_sensor);
+	if (ret)
+		goto out_unlock;
+
+	/* if FIFO is off, turn temperature off */
+	if (!st->fifo.on)
+		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+
+	/* sleep maximum required time */
+	if (sleep_sensor > sleep_temp)
+		sleep = sleep_sensor;
+	else
+		sleep = sleep_temp;
+	if (sleep)
+		msleep(sleep);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+const struct iio_buffer_setup_ops inv_icm42600_buffer_ops = {
+	.preenable = inv_icm42600_buffer_preenable,
+	.postenable = inv_icm42600_buffer_postenable,
+	.predisable = inv_icm42600_buffer_predisable,
+	.postdisable = inv_icm42600_buffer_postdisable,
+};
+
+int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
+				  unsigned int max)
+{
+	size_t max_count;
+	__be16 *raw_fifo_count;
+	ssize_t i, size;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
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
+	raw_fifo_count = (__be16 *)st->buffer;
+	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
+			       raw_fifo_count, sizeof(*raw_fifo_count));
+	if (ret)
+		return ret;
+	st->fifo.count = be16_to_cpup(raw_fifo_count);
+
+	/* check and clamp FIFO count value */
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
+int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
+{
+	int ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	if (st->fifo.nb.gyro > 0) {
+		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
+	if (st->fifo.nb.accel > 0) {
+		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
+				     unsigned int count)
+{
+	int ret;
+
+	ret = inv_icm42600_buffer_fifo_read(st, count);
+	if (ret)
+		return ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	if (st->fifo.nb.gyro > 0) {
+		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
+	if (st->fifo.nb.accel > 0) {
+		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	/*
+	 * Default FIFO configuration (bits 7 to 5)
+	 * - use invalid value
+	 * - FIFO count in bytes
+	 * - FIFO count in big endian
+	 */
+	val = INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN;
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				 GENMASK(7, 5), val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable FIFO partial read and continuous watermark interrupt.
+	 * Disable all FIFO EN bits.
+	 */
+	val = INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD |
+	      INV_ICM42600_FIFO_CONFIG1_WM_GT_TH;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CONFIG1,
+				  GENMASK(6, 5) | GENMASK(3, 0), val);
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
new file mode 100644
index 000000000000..de2a3949dcc7
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -0,0 +1,98 @@
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
+/**
+ * struct inv_icm42600_fifo - FIFO state variables
+ * @on:		reference counter for FIFO on.
+ * @en:		bits field of INV_ICM42600_SENSOR_* for FIFO EN bits.
+ * @period:	FIFO internal period.
+ * @watermark:	watermark configuration values for accel and gyro.
+ * @count:	number of bytes in the FIFO data buffer.
+ * @nb:		gyro, accel and total samples in the FIFO data buffer.
+ * @data:	FIFO data buffer aligned for DMA (2kB + 32 bytes of read cache).
+ */
+struct inv_icm42600_fifo {
+	unsigned int on;
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
+	uint8_t data[2080] ____cacheline_aligned;
+};
+
+/* FIFO data packet */
+struct inv_icm42600_fifo_sensor_data {
+	__be16 x;
+	__be16 y;
+	__be16 z;
+} __packed;
+#define INV_ICM42600_FIFO_DATA_INVALID		-32768
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
+	    y == INV_ICM42600_FIFO_DATA_INVALID &&
+	    z == INV_ICM42600_FIFO_DATA_INVALID)
+		return false;
+
+	return true;
+}
+
+ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const int8_t **temp,
+					const void **timestamp, unsigned int *odr);
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
+int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st);
+
+int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 95b2a6d91e5b..9e1f6e65fd45 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -18,6 +18,7 @@
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_buffer.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -428,6 +429,18 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
 	if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)
 		dev_warn(dev, "FIFO full data lost!\n");
 
+	/* FIFO threshold reached */
+	if (status & INV_ICM42600_INT_STATUS_FIFO_THS) {
+		ret = inv_icm42600_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			goto out_unlock;
+		}
+		ret = inv_icm42600_buffer_fifo_parse(st);
+		if (ret)
+			dev_err(dev, "FIFO parsing error %d\n", ret);
+	}
+
 out_unlock:
 	mutex_unlock(&st->lock);
 	return IRQ_HANDLED;
@@ -604,6 +617,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 	if (ret)
 		return ret;
 
+	ret = inv_icm42600_buffer_init(st);
+	if (ret)
+		return ret;
+
 	st->indio_gyro = inv_icm42600_gyro_init(st);
 	if (IS_ERR(st->indio_gyro))
 		return PTR_ERR(st->indio_gyro);
@@ -649,6 +666,14 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 		goto out_unlock;
 	}
 
+	/* disable FIFO data streaming */
+	if (st->fifo.on) {
+		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+				   INV_ICM42600_FIFO_CONFIG_BYPASS);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
 					 INV_ICM42600_SENSOR_MODE_OFF, false,
 					 NULL);
@@ -688,6 +713,11 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
+	/* restore FIFO data streaming */
+	if (st->fifo.on)
+		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+				   INV_ICM42600_FIFO_CONFIG_STREAM);
+
 out_unlock:
 	mutex_unlock(&st->lock);
 	return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 6a0e7661fa48..d53c604ae1de 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -11,9 +11,12 @@
 #include <linux/delay.h>
 #include <linux/math64.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
+#include "inv_icm42600_buffer.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -64,6 +67,79 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
 };
 
+/*
+ * IIO buffer data: size must be a power of 2
+ * 8 bytes: 7 bytes data (gyro 6 + temp 1) + 1 byte padding
+ */
+struct inv_icm42600_gyro_buffer {
+	struct inv_icm42600_fifo_sensor_data gyro;
+	int8_t temp;
+	uint8_t padding;
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
+	/* update data FIFO write */
+	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	if (ret)
+		goto out_unlock;
+
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
@@ -260,7 +336,12 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	if (ret)
+		goto out_unlock;
+	inv_icm42600_buffer_update_fifo_period(st);
+	inv_icm42600_buffer_update_watermark(st);
 
+out_unlock:
 	mutex_unlock(&st->lock);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -574,12 +655,51 @@ static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
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
 
 struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
@@ -587,6 +707,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
 	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
 	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
@@ -597,12 +718,20 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
+	buffer = devm_iio_kfifo_allocate(dev);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_gyro_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = inv_icm42600_gyro_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
+	indio_dev->available_scan_masks = inv_icm42600_gyro_scan_masks;
+	indio_dev->setup_ops = &inv_icm42600_buffer_ops;
+
+	iio_device_attach_buffer(indio_dev, buffer);
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
@@ -610,3 +739,36 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 
 	return indio_dev;
 }
+
+int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	ssize_t i, size;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	/* buffer is copied to userspace, set padding to 0 to avoid data leak */
+	struct inv_icm42600_gyro_buffer buffer = {
+		.padding = 0,
+	};
+
+	/* parse all fifo packets */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* skip packet if no gyro data or data is invalid */
+		if (gyro == NULL || !inv_icm42600_fifo_is_data_valid(gyro))
+			continue;
+
+		/* fill and push data buffer */
+		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
+		buffer.temp = temp ? *temp : 0;
+		iio_push_to_buffers(indio_dev, &buffer);
+	}
+
+	return 0;
+}
-- 
2.17.1

