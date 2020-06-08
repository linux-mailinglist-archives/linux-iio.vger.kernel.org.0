Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241C91F20D2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgFHUoH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:44:07 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:64458 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgFHUoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:03 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KgTii024950;
        Mon, 8 Jun 2020 13:44:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=SwOW0aQpapKUjHfRcVzqghBUixfD65S1rSp/rEKQx0E=;
 b=bXV1IBGsUvQ/ffEd5kbIGA37bzqi22ySlD0q8MT9jfv4ykFO6BnE/q3fZOaRNqq5F/WU
 BCyGYFP/usdW3m/JFdaI/b2jaJ3DvwOKYI8f4/4DWIJl67KyUgrObtAwxdjYHCyqlxdz
 ylvUENl0zeR4wmov9VaMa4fMN5DQi8dD9f+kz/e4heuw0aNu4SmLoaJo1tQnaG/am4Y0
 uP0gRn7MhsnIr44n4lMuZm/0OYOmsjYBCszYidRpetlHTovUNaK5ZLWyug/DpVqHh7C+
 iuyew4NR2VVVzEo/sT8VOLfaFTEftpij9/qPIoiJtY+umprynx2daMxtP9sm651CwdkV tQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkva68LNn1ThJPsgM+JdHrT7jqSDZcMCrzxhEljWng9aH5flB/zuZg8OJjwHqic+Vb3u9nS83ftmlMyd9CHsTIPhjZy/n7phb0IJWIrONs0TD05EDlNwtB9o0g+bZadub1B1v1fd+j7ijKX9wtHCw1T6J4Kge+6eceNiiI7jn+y31WyBu+yUjOOtznXzjBKiig26RPCV11nCAXf3T0LQA+7VshEX3yhQD1SvUyfASjjF+mHhw/WD5gwy/qVT1r6NyBbY8IZBYo7xZ+i8bf11wocdzJoiSOXs10VHvjuXCh03M0jgxaGuLV0HKtqgC4KOJQzWu3/fR99XzDs+cvE/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwOW0aQpapKUjHfRcVzqghBUixfD65S1rSp/rEKQx0E=;
 b=SXityR0taWO2HMn57EsGgG+kdFPJ6UaKjR61NDcVZ7kHqzYubiAMYN9yMqlTjMwY87JhZzkotZw5YyibS49ju2BWM3Md2CMHNYqEf8eHD0as2up4Fn+OZvIu4JCdio5dAjw0lvE8ol4xJKMJV52dGvC3w/3v2B2nXV06Px8rvdTekeabbvw/abObppob9XbfkIpllFt9ZC0ye/Ix93Ljad0GeGdu/HFzTaoZi+pv+J7vCs82EKO9Fjq+CKlGXlZG7oCMnJvV8ZFaowpboU2pZGn8U8Gvn3MCA+5DCpobuV0S+dpo9yF4prJnXkJd3qCuK1uq8e4fCrNtZ7NGpeQt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwOW0aQpapKUjHfRcVzqghBUixfD65S1rSp/rEKQx0E=;
 b=Wuk7ubMffhiPGDdc4ZoDqCQXQkEEqnhxLmcXqDL3hsKSERHGV8IKB5qFCoqIcixnrx8Un2G08R/CM2WGylXN4voWE3OfoKcfv5Rxx5QK2BHT+0n1ydmAZ6iHVhHLNEJgAr29QLZCTnqBxBKJGgmOKs1Qk88IeYuzAwMpmqKtjuM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:43:58 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:43:58 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor support
Date:   Mon,  8 Jun 2020 22:42:43 +0200
Message-Id: <20200608204250.3291-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fbce03-8d4c-47f6-6752-08d80becaa3c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395124CC9B2F651481FAB84CC4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: He8uJNmkxxtcqtP+r5umV1u95warqTw3DbDTNL9oiRCZFVvBp0M9pIoMEAToam3COvnU3VPBSAbGYxy2LzV1E6Fw3TT65KqoanCDV1JMhkwpAjS97aB2j2gY8yEuyyGpqlotf3W7D1K6kFhYiCs+cOqrc0yH936ReSQ5tavfeUAggKEliX6gP5ksu/FG+1mFWqTUjL9C8z8w7jBP864SejolZbKZHMLBJBF/s69kvL1IfHrSZSwULg778AC+PamxsqYFYBS8dSM39GepoXfinAC/6UrT4l0ZQ4r85j9I8iHQOwSNC++UYvJefBzgmvz4wGwqi9eXLB7vSCpe9o+UGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1PJ5Y4EdlZyyex3jETtECOoUH6Ehs3TaLELwHJJNmT3lZz2tPCYAUJBzDtHMdUwE7PRxgYCt8Ox7iFS8XUwwYZpvu6esXo3RCwBoL1wcZCYrf8TBNGi4woHXtLjwjsP485+XKxOtrUuvrmtP10/dqT+kMYP/GvcD1T2nMRJGRTD/aS/5CZJU3XMXr1z2O81iZk/UhHSTTooq8eyq2ji/Rnw6HHQu/L4Fl4egqVtSCahDh1twQqVdIe4rsmQ2BvpNfHB4AlHCuP4VuPfYmbD9lC3v8gqaN4PH6uG6kUDXQFNs0jylfQz3CbOMf9QnHe+TJAlcrV0sspCgDK76golpAmMUifoG2Ahd0zz3Ig7ED1g9oSFgImTbBnxEcSR68xIhLCmVrbPIeRZuSunCsTods6FkhKZFVtrcTX6F5HzKsPkJdLpay+ibONRaFXbrVZ65r9EoVaEZkNxtbSJe46oAYr0wWAlkntjMmNgbCM9hqVo=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fbce03-8d4c-47f6-6752-08d80becaa3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:43:58.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GiYQu1E2MhNqefTCjrBLiQsLjuATOV4g/FD8ZRKVH4NAlb974cny7p5C0lspnJXuJriANzrfG3w/6zCgjSl0l5bSw27wjyqZ9O6qXv7DNA=
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

