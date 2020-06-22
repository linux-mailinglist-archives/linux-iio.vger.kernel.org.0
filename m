Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAB203B2E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgFVPiw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:52 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:40534 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729647AbgFVPiK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:10 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFWD46004964;
        Mon, 22 Jun 2020 08:38:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=GX+Z39CAjHCmycLvaMK+oUDm9TWzQpYNu+xxcfbCTv4=;
 b=SCdAfj8iMnHb2nMjuHSDsB8FSXafPZy8FowNsTsV7/e/QgK+j8aJPH5HAuBnw0NAkOne
 l7cQH2gYMIU7AQHjvZ2LzcY3829PP6lCypKd/3h9tAGMVX01Bzz0Re831cTbz9wQ+D0H
 2LktveSx/SQK+AZY4DK9+O48SMXUVQLuHNBwImUmhqE647sdy5cTz9EkHkzm/srbX2ag
 C1CdYQBdQhJlrSrr3h7fvpdDsLYvw7RWQw0w82diKjNN7fOEN2M/DngYKfWxwd5XRFLm
 LxTdeANuNlZPdSWl4+3r9f5BeMC2BEMY8Z38IXQ3KPwll5pLkYON5iF4FXl/EeftzoVW 6w== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0ukj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8oMUySjTxYk/TtXk/QQzYRj8MOStdD22go+HAYQd7IEz5O5HPCE9K3zeNdke2MMVSyt2CAk3bvtzHh2PlY87w+85Z2K2F9adW+BV1oPN6seo185DgDQYJgfMQO2jBO5UU1TKmeLwJQv3QFXscKShF6z8dw0nRU/ns/H9Gaf+yxM48muHu4eKukN6C1rGK/SoN9m0brqj8H95Vb6OoOW8DcvjXmRFSCgmZkyzw7gqJrCyD+W26IVKp3T6iqYDUkiQxDO3QlpDwqRfb/PUBj0ZqHsr8rFH6JTzOxalhwL6bUnZIECAozxrZteBM7urNb3paRuiCFToby4+JwE/Jcffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX+Z39CAjHCmycLvaMK+oUDm9TWzQpYNu+xxcfbCTv4=;
 b=Nwu4JoNOldFYCWKZANaacpxIqbIDo1gD2JccIev4zDw3snMQkapQChom8d2zzokU7oDExjb0X2DmVWZEoN3C7wyvMigxGQ1mbYV6wefmQ+4vdUGKkLm5Cm9+EvIaYYy2E+ppBB62KyBinMYx3O7Br/5XifP8T9He2F2Pl+AB/DHM3M7nGWz68BDoltjl1RsToS7NserUka/e31MDpNl9hKCi06lqD/T2y7QpIJ1rOGJE/E1DDU4q7ru4j0I2IQYtXeHTjHn+A0xeOeOjmo/aCSkWMPJ8vnWIG86GvzRDiUPrMBqwzfmOv0TaU4E0kw28NHgrv0jfL3Gg142VxSicrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX+Z39CAjHCmycLvaMK+oUDm9TWzQpYNu+xxcfbCTv4=;
 b=Bx3tiP1nPMOhDz4D8zPELLs1Y8ADfKFGQM9Hr6EhiphyXFgNC1cWCEBsY97zBntUEj+HkQlAmoj2pDFXX1aGNjkebaDCR8RxqRdG2yZlJQRWJOA7Y8VVey5zLlcEv9ez+2SPM4WSeRUvA7L1nRT4VxXHf8plt/MPBk6bqWvLxfc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:04 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:04 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 06/13] iio: imu: inv_icm42600: add temperature sensor support
Date:   Mon, 22 Jun 2020 17:37:22 +0200
Message-Id: <20200622153729.12702-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e07611e-25b7-4f4d-403d-08d816c240cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450110BFA1C43CC6C8AB9540C4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnF/O0GP88UIdIYl41kmb95cVDSo9xDo90uER/RByozSpVfIvbLaXRas+CzYOJfaqsrXDTkSEDYHMX02FxkxvK3tUNlohmaB49aFB3afwJyKlvf+I7O8+Hz3e7jSDx0R/rjdmvVnaZ9b4dAsbRn+FB4fiB6wXsCzY54ePUuJ1GebzL8MdlNFW1Ht1z9pyFDuOn7Clszcw7DW4V7dPhBryyfIC2qLE3ZSnv+cVVQ/x08bgSpLNwMzeO5CrRhMDJKKf0JDYmgtWNIkcIBTCtoVYvM4lSMPWUf+zexXkgN1Em98H16+pOR3TloaRNqOfhDY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(83380400001)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wia8Neb6Gvqqvzg4gpB6D9tR3dI3TRYBqUMDmXQDoiz0SzbMGSPSCWS+sJOoVWL1J2ldK1AyEV4+eG61BemHgWH2WnOWmQfSxfTyL+NcycMH7w7nM0xKc4LFQ71Qt/gEUGXuHx0vyR08BQ+sYzz2EpQODN2a1EaygngKwunEP+Ey6oCWqERkXy8wZB086L09mqwwXX+nU8RK7gH0qSEQ6nll2Jg1ctrhV0ICTZ2M1CUAMiGSwNMct17hOqR5+csZS3Y6hriuxstoohT4i5w5BkO0qySeZgwYfZa5yH0efXZDEvQdSuRWeVq2I7TS5Glbkml635q/B5AZTovomUAdpdjmwAhpwV4sixfpRRh8XS5GhRKkMd3vFHnHuMvN/WOk/CJqE9GkuQsBgHMFaMbPMRku4MADQwcLKttwk+qALgqgOK5MS/grGRS4GGHfX2q4wXFlAO9dtdWV2Q6oITMZjmwU+kXTAAXGetHXeNeja2o=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e07611e-25b7-4f4d-403d-08d816c240cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:04.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLM5ovDPCsjkYg/iYQjYs/ppGHqv6p2ojVtKlYI9ZiD60aCCIY5rc9/AivNYP7nFOwc87/5KOFop1/suc7Pi4+hgYo1hR9caQQaxZdtK6jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add temperature channel in gyroscope and accelerometer devices.

Temperature is available in full 16 bits resolution when reading
register and in low 8 bits resolution in the FIFO. Return full
precision raw temperature with corresponding scale and offset.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 11 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 11 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  | 84 +++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  | 30 +++++++
 4 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 717c6b0869fc..3f214df44093 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_temp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -45,6 +46,7 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_X,
 	INV_ICM42600_ACCEL_SCAN_Y,
 	INV_ICM42600_ACCEL_SCAN_Z,
+	INV_ICM42600_ACCEL_SCAN_TEMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
@@ -59,6 +61,7 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
+	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
 };
 
 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
@@ -450,8 +453,14 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 	int16_t data;
 	int ret;
 
-	if (chan->type != IIO_ACCEL)
+	switch (chan->type) {
+	case IIO_ACCEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2, mask);
+	default:
 		return -EINVAL;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 3875ecbee67e..6a0e7661fa48 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_temp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -45,6 +46,7 @@ enum inv_icm42600_gyro_scan {
 	INV_ICM42600_GYRO_SCAN_X,
 	INV_ICM42600_GYRO_SCAN_Y,
 	INV_ICM42600_GYRO_SCAN_Z,
+	INV_ICM42600_GYRO_SCAN_TEMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
@@ -59,6 +61,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
+	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
 };
 
 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
@@ -461,8 +464,14 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
 	int16_t data;
 	int ret;
 
-	if (chan->type != IIO_ANGL_VEL)
+	switch (chan->type) {
+	case IIO_ANGL_VEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2, mask);
+	default:
 		return -EINVAL;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
new file mode 100644
index 000000000000..213cce1c3111
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -0,0 +1,84 @@
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
+#include <linux/iio/iio.h>
+
+#include "inv_icm42600.h"
+#include "inv_icm42600_temp.h"
+
+static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *temp)
+{
+	struct device *dev = regmap_get_device(st->map);
+	__be16 *raw;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_set_temp_conf(st, true, NULL);
+	if (ret)
+		goto exit;
+
+	raw = (__be16 *)&st->buffer[0];
+	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_TEMP_DATA, raw, sizeof(*raw));
+	if (ret)
+		goto exit;
+
+	*temp = (int16_t)be16_to_cpup(raw);
+	if (*temp == INV_ICM42600_DATA_INVALID)
+		ret = -EINVAL;
+
+exit:
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int16_t temp;
+	int ret;
+
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_temp_read(st, &temp);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * T°C = (temp / 132.48) + 25
+	 * Tm°C = 1000 * ((temp * 100 / 13248) + 25)
+	 * scale: 100000 / 13248 ~= 7.548309
+	 * offset: 25000
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 7;
+		*val2 = 548309;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h
new file mode 100644
index 000000000000..3941186512fb
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_ICM42600_TEMP_H_
+#define INV_ICM42600_TEMP_H_
+
+#include <linux/iio/iio.h>
+
+#define INV_ICM42600_TEMP_CHAN(_index)					\
+	{								\
+		.type = IIO_TEMP,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_OFFSET) |			\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+		},							\
+	}
+
+int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask);
+
+#endif
-- 
2.17.1

