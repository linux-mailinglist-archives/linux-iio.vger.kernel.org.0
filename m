Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908061E4D91
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgE0S5z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:57:55 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:41698 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728822AbgE0S5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:53 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIuQjR001589;
        Wed, 27 May 2020 11:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=ifQLSNUEar3fKvbuL13xuy+kkdbA2WLCRxsr+Qj844w=;
 b=JsvxgfIr0QjgFHdhnVuOt6zsUicDpFqnOVtRIZNkPX21f3SK/01vZkPeAYW7KrfTSYQh
 22EFaH1ISc3qE48hmU4JF+rhTnYNowCzzueAZbov94+x5ejtGK4Ls6q08NVkEtrmZ/hb
 Mht7aS/La8e+sYMIMEoJfjR2pRRgSai4JB3hIQ2046UfGWULBcJs7/mPWr1xVIxmTTGA
 a9EwCQy69Ub2HLcBcYpJ5SLGeqOT1b1VUlDZn7D0FzocLp7YY56lBippipjNsQpqW9x7
 DiYMCEqQiv6Dwgk+XqsuB/MjuyQBEkAl4eXQYlm+7k7YnpKDuQzBJUQ2Ier+CJMpQCZo fA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00328301.pphosted.com with ESMTP id 3194qh0ncv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpUL4S7GP7Ts1vAnOmted+KibJSdDs+wlHi0f45lzCKyDSug44vC7RvyUSUauIZ/BX4Xw/O2W0RT+3yS63CEQ2idLFWYN8b2yhxA1i8MYiAfcoVeX5944AA4axP2weUkW2qPqaQX5ZrboBGJqydpVePGDjyfu8dwJ3hg7AxNe6eOfFK/uK77pDPbA4uTMRhLK/qU2HewL0KX+Ezar4JR3XTW1NbdULEy+AyK3c7YJLKyimvniBX2Stl5lFIU7jdla7xlfWBpeczPosaki80HH/ui8lD9UVCvIBvC84BMsGML2Azt/RBir+oe1NqvyXV9IJSDZfIWvbqnR4BbsOM67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQLSNUEar3fKvbuL13xuy+kkdbA2WLCRxsr+Qj844w=;
 b=RUdZGqXtw/a/HGab66hGLE9ahJcBIXq87AzIcdjUk8bE/Bm8UjThkl/T+3txv03PkmnIlZ0tul5xOG+Dpqq22gFp1sC6eKfuCsgExl0elFTNdcL0EOMUw9EaJpUBoC3aIKvAAtK52rsjgYd4L/ifL+8NtqTQIlom9YBASwBu0zwN0AkrDZLyGFoWuonhCTQWiwenHO4Y69F6+DJcrRyfRC/bjg8PhlecWNV3smAqpDDPt7JobmdfbvFcz+vl2S8E8IQGdBC9Z/oSm00dybkND0Ph0AcgPKCA3zu+SlUSVsWJc/cj/72fDGdh05K4Hmvt9/4MC2l5lZWYXeDqYPGgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQLSNUEar3fKvbuL13xuy+kkdbA2WLCRxsr+Qj844w=;
 b=GtRaxR76+498RyI1qPh0M3yZf4Z3+u4Q+YflYdx9btymw9XHoN8xEpnys97hrOt1SXvqcuo2uGoguuOPlU1qzVSjopEIj2cf+3WH99NdL1SrYM+q9Cpxuzji1xeGtUR5mwfTKssf9AxehZ/GZZUMq7hOtI/sR1zajRSHDOlZALM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3470.namprd12.prod.outlook.com (2603:10b6:208:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:57:49 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:49 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 06/12] iio: imu: inv_icm42600: add temperature sensor support
Date:   Wed, 27 May 2020 20:57:05 +0200
Message-Id: <20200527185711.21331-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb52fa3-7a58-4c83-2326-08d8026fd9e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3470BF256A26C214119DDA1AC4B10@MN2PR12MB3470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9J2VXsb6yKNBkJSLM0/Dh+ujqroDseXc0kNdehHtpEdLNYy3Aly4zmWLVc4CfZ75AsLqgFNFWthTZlJKXF7D2CrzC1w7b5Od/VXILX4Z5vtG9WMTmQCkUA4n9SvD3zvEbtUdk6fRq4aUB7/FhRFzVnYel5Kulj0nKZq7kk/A0gao2RaKxBhztAVmaP8Oo7l1H+4Bf/FfsGm9k1PbDDEB+ExMA6HVr4U4beH8nBRZY4tVRcF6hGnwHEOnI+c23dPgbB+AATK23vbx+VaFR1/9OjnWc7pz0Lekhy8eb0OdQSV/WKZp7TXN1nMvsH9L7qNrV/OOkag/atK2XMLX8Ukfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(136003)(346002)(366004)(376002)(8936002)(66476007)(66556008)(36756003)(66946007)(5660300002)(316002)(86362001)(186003)(52116002)(7696005)(26005)(8676002)(478600001)(4326008)(16526019)(1076003)(2616005)(107886003)(6666004)(956004)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 556BqEPS31b0L4/WpgXCMZckC0amxBoyYmYrE8b+SyCzHAbP71yXBB1inH9eevGZaRlxaeBRn9pO8TxLOq2EBI8Q+iyt7q26Agh1NXv6m3JvDbnlTbDaCiLaMSqpBuxU1SVeHU16xqcc1KeX1UCgwUH+LZXk7DmdREwCqatQPWWZwGOkhbv4d0x1nuyb2oyhw7sfCbCvc5P79dW98bh8+1YC3FFm3ITdGUw9bczeHjgL79yBKZmkEZuTgseL/TkQ1TYuoZq3elimrAG47+6qb+9e7DnjcTix2L6Y7XFpRwvY+rdayHN7q5PK8JAtHwNE+s7yTL2hFcIknv6supi2MtAlxvJ73QIcJFJf9sztVznaRh26gIJacuLnjqp52d5tUiyUKK6QiDx/5Ka/4ZuychGXgAHMCXmovSCVBAEeK/yX6DJUxMR+cj0fX86VQ3Sit2NxPTQZHxFP4Bk1g3lm5u7VjYhMNMKNdgnp7uY2XNY=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb52fa3-7a58-4c83-2326-08d8026fd9e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:49.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23KL1jHcMNTWXEoGz7VJWPNitYN9g13hEe7eVIHpcYWjezB+jSkNRl4l/dwchK7WGcQXba8eMFnxkKeJHvtFaJ6S2N3/S/9adMwQ9exZRg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3470
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 cotscore=-2147483648 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add temperature channel in gyroscope and accelerometer devices.

Temperature is available in full 16 bits resolution as a processed
channel. Scale and offset attributes are also provided for the low
8 bits resolution raw temperature found in the FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 11 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 11 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  | 87 +++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  | 30 +++++++
 4 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7620ce1958e0..6a615d7ffb24 100644
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
index 9d9672989b23..38654e0d217b 100644
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
index 000000000000..b0871352fe39
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -0,0 +1,87 @@
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
+#include <linux/math64.h>
+#include <linux/iio/iio.h>
+
+#include "inv_icm42600.h"
+#include "inv_icm42600_temp.h"
+
+static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int32_t *temp)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t data;
+	__be16 *raw;
+	int16_t val;
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
+	val = (int16_t)be16_to_cpup(raw);
+	if (val == INV_ICM42600_DATA_INVALID) {
+		ret = -EINVAL;
+		goto exit;
+	}
+	/*
+	 * T°C = (val / 132.48) + 25 = ((val * 100) / 13248) + 25
+	 * Tm°C = (val * 100 * 1000) / 13248 + 25000
+	 */
+	data = (int64_t)(val) * 100LL * 1000LL;
+	*temp = div_s64(data, 13248) + 25000;
+exit:
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int32_t temp;
+	int ret;
+
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_temp_read(st, &temp);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 483;
+		*val2 = 91787;
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
index 000000000000..2c3a932faa94
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
+			BIT(IIO_CHAN_INFO_PROCESSED) |			\
+			BIT(IIO_CHAN_INFO_OFFSET) |			\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 8,					\
+			.storagebits = 8,				\
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

