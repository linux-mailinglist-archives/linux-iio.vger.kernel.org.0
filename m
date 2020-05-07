Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB91C9080
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgEGOnx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:53 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:34630 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726807AbgEGOn0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:26 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EeBq9009573;
        Thu, 7 May 2020 07:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=jKvwThIXd9hxjE3UeowRVGB++10GIiQYd9la+T+pXPs=;
 b=XxGx7sf7oAukNB4PgaAWgEKX4S7a1wkChInpUSTSQTvgtfM1gDdBBdt9j8BKHkHKL8rZ
 /AHZl9uQzXvXbDSrPA55N2jUpjhUeBSv3M9Cgy7MhV1mJT4IHglF9zG7Vc5HBEbunFVw
 j3BwfrYjN4Zk9AJuOEjiDCVkLYRwNmmSIByd1Nq6ms/7t6/ohH9Wpp6x2pfTuB0DUAII
 wv8komZ3XbFoPy+RJ/FhM3SpBpBl7ceEnJUIoiVjQlg/hRZY9OoBEEzjGQgIBJTztDbH
 MrhmeHVAi5r/0B+Gj9AWqzTOwE4rCJIeX1LyZh2zxwKIIr8dLsbvwhi1f+ObEY5cHJoJ wg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLEqywLsIAGdcvHf3FB6KXgb+1GCOMBgUoVBG3xJC7kNV8OdN3Eu5BSr3ot7hs/6V5e2zvt8/LbcIzIPTST631MO2I7DPn4TMG7TBgEkfPnWXI9hT0GOsyYGlmn8XuPbK18VgA8we50iuZS7k0OAkB+LAYT2VmLiB9GSvNRTMqV7chmWHNKFhSNfGmf5dLh/MQDUWid7MY6PiCX4xnJM/NRLUpDLnyX6Bev/QRNqQEKKYJUwoNbPCMaf//CvDguWYS6TBgN/P8xzNNkm5BAMVtnOhFv2PpJEbri94CbT8ej0Wlej3NYPbBflgWZfquB6+src5uUzUzmqZoyngA8TNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKvwThIXd9hxjE3UeowRVGB++10GIiQYd9la+T+pXPs=;
 b=TDgWMevRXZajH2d2QPeiBl6k6nbKLfQVC0SymwedqAinMv8HQDAEeToYagKbnIlwwKSoHFjW7Enrty+GgTD1wwvI4VcQNtD6eZt1z3JaN7V0GIVWNvNRTcnyqSKgWJHwhH+QCalYWBwPNcZ1MR2RsfOBwKSf8Y8K0ZfOFZKAV9pitMFM+Wj8MmV+0bu6vUQWL1ZNwfQ/WDt9Aag1JGjWDHBfEurYTmyxL/dOkUPEdIlgoeeTDIZO3MUpcUvF6Saaba1owgH489Iuuuq2D+SMt3gfhXSKNUhuy8Zhj3a7oILoPL/6NGQU08LKuTStpo/256UMHFSsXOQHYFn0tnGkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKvwThIXd9hxjE3UeowRVGB++10GIiQYd9la+T+pXPs=;
 b=Zg1bvf1c9+8fItG3I1P1c83fcznuaecNc7I4k+bUods5oRNVS2wNeBcuiTvQZCi708yhmwoKH9E7rUEpxg9vJ3qXyyeAzcQA1xYieTA0jSWaxryCqTjmLVHMzQHhe2Z5sbto3AJf+DOYZQ0D5lsQfucwpsFagWXa3CEs32vZIsE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:16 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:16 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 05/12] iio: imu: inv_icm42600: add accelerometer IIO device
Date:   Thu,  7 May 2020 16:42:15 +0200
Message-Id: <20200507144222.20989-6-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630e27e3-3b12-4e59-8ed1-08d7f294fa1d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB426954B6428ECCF97DD2C665C4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9/EOLK7xPnzdF4LjQsAhQUOHYehN8RYs8fHeIpQy2dYWKfkaNmEHSfc7czUO5nVZpAqzkKDHmeJBQ1DyunH6kNhx1y9TP18sUkCUut6wYQhvgQVhus4HkihZLN+fP02mdaaDulldaJYAJrOSBxHqdkKhZGVH+0lcTS81JWOXAgBkPqvwYV52jvHwRiTYKDd9fOTZTKBwZV3dMcImBfKhoqtYnKmxXTPgTRV0dYyYMSfeb78X2CK+etlQDpmYv7OqdQthaDZSME7h7kjjZpw1Cs0gSfYMo0qaTUXxf4dXBL7Q0DE4wNde4QMXoxRadxzy59t9y1TgtMOeQtvvl3X5rzv/d8rhQGvqBabftgmyt78TX3OxPCubF45Y3z7XPFOyeAH/ckdTC1AMBliVqFDRZ+UuGtxOEKD/s1Ls3UG9rE4c4f4cKJEyvACmQOs3JgD8h4zcE4yGqkCFqM18cMY0WUSscqIERKSVnbHQ8SU5K46Bjo37l8awdrJ4ehv5UiqG/51hf7oB8EcJ0S20q6z2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(30864003)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qZZs2vBJ5cPPgSm5IVJmMY+9vwk1NB7SZCEZxiUQbgGxA8pDuDJGdllmSGrLiIfvzV4FjJQeBW6E2Skz/LAGu6gbBR9bKEc3p2el+2gNWwOVnzm1SB3SiLeXuv/zGiTb16XSHn5miE4BWhTN+LoFe+N63Js8glUIcA+13DF2ZsiOurRoLuOwTggKQ1o36jUPjTDmVKMfbj155txHm7KuNU8qQ+rqOBnw8xtEsD+f6AJrP9N3Gn12EZbpiZmC3nizxEgDuRd7MKUHWRiaxgje8qJbZdj1i1NR8H43D4fa8IfKOudR2c2KyX5oC+o4KO0XT8dlWwAzo4dlZWTIfcQeC/r+ZEyZ24699gfpiIBLwUy0W4zMrSpJYQXfUBPshQZU5hza9XNt6YKGzLOXYyLypALyozbpbo6gU4//bT9ymKqMsA4KpqDWw4JK32y3pwumNzd96ki+vIAWa7uQL4SZuE0qqXvx2GR24A2FAKvgGI71WcN171Y825GFRDwFxVHZ3aqIi2DEHQ1JB4YdeRlLZETGBgFaybGB/XOALGJoU3YmAScQmYFSq9D6v60PtwumNVJ9NX9I8uX/hpbooFz8r5fZp0N+n4zssMQy662zbmirpawXWHNFx1bvSwp7FWKFy8QjIhfQecvLrMBqqSobdp4z8YLJGxR7uupEzsf2KjnzTOfSKTHTsDX+NEkx19xbzq5zA+WIXsIV9RWrFPH0+lqICix6jFDDiIe/n0oJBsXzEJ/PjKBVFz7EK17ifq9ILtj9E5PejnJK2I3KkV4cr9oz4knoZ6j2tw4uazlGSMI=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630e27e3-3b12-4e59-8ed1-08d7f294fa1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:16.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByZKg8hNHeeBZK7wtnBTvr3w7HQmvOOLLakIMvv+PS0IMWANUidfwc3BaSKMaUuHU0LnTng7weTJ7NBflGfwpgU8IVhmfrLnX5qzqSw6gmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add IIO device for accelerometer sensor with data polling
interface.
Attributes: raw, scale, sampling_frequency, calibbias.

Accelerometer in low noise mode.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 537 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   5 +
 3 files changed, 546 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index ca41a9d6404a..bc963b3d1800 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -121,6 +121,7 @@ struct inv_icm42600_suspended {
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
+ *  @indio_accel:	accelerometer IIO device.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -133,6 +134,7 @@ struct inv_icm42600_state {
 	struct inv_icm42600_conf conf;
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
+	struct iio_dev *indio_accel;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -373,4 +375,6 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_accel_init(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
new file mode 100644
index 000000000000..397e3d0fd42b
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+
+#include "inv_icm42600.h"
+
+#define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_type =				\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.info_mask_shared_by_type_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.info_mask_shared_by_all =				\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.shift = 0,					\
+			.endianness = IIO_BE,				\
+		},							\
+		.ext_info = _ext_info,					\
+	}
+
+enum inv_icm42600_accel_scan {
+	INV_ICM42600_ACCEL_SCAN_X,
+	INV_ICM42600_ACCEL_SCAN_Y,
+	INV_ICM42600_ACCEL_SCAN_Z,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
+	{},
+};
+
+static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
+	INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
+				inv_icm42600_accel_ext_infos),
+	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42600_ACCEL_SCAN_Y,
+				inv_icm42600_accel_ext_infos),
+	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
+				inv_icm42600_accel_ext_infos),
+};
+
+static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int16_t *val)
+{
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int reg;
+	__be16 data;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42600_REG_ACCEL_DATA_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42600_REG_ACCEL_DATA_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42600_REG_ACCEL_DATA_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	/* enable accel sensor */
+	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		goto exit;
+
+	/* read accel register data */
+	ret = regmap_bulk_read(st->map, reg, &data, sizeof(data));
+	if (ret)
+		goto exit;
+
+	*val = (int16_t)be16_to_cpu(data);
+	if (*val == INV_ICM42600_DATA_INVALID)
+		ret = -EINVAL;
+exit:
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+/* IIO format int + nano */
+static const int inv_icm42600_accel_scale[] = {
+	/* +/- 16G => 0.004788403 m/s-2 */
+	[2 * INV_ICM42600_ACCEL_FS_16G] = 0,
+	[2 * INV_ICM42600_ACCEL_FS_16G + 1] = 4788403,
+	/* +/- 8G => 0.002394202 m/s-2 */
+	[2 * INV_ICM42600_ACCEL_FS_8G] = 0,
+	[2 * INV_ICM42600_ACCEL_FS_8G + 1] = 2394202,
+	/* +/- 4G => 0.001197101 m/s-2 */
+	[2 * INV_ICM42600_ACCEL_FS_4G] = 0,
+	[2 * INV_ICM42600_ACCEL_FS_4G + 1] = 1197101,
+	/* +/- 2G => 0.000598550 m/s-2 */
+	[2 * INV_ICM42600_ACCEL_FS_2G] = 0,
+	[2 * INV_ICM42600_ACCEL_FS_2G + 1] = 598550,
+};
+
+static int inv_icm42600_accel_read_scale(struct inv_icm42600_state *st,
+					 int *val, int *val2)
+{
+	unsigned int idx;
+
+	mutex_lock(&st->lock);
+	idx = st->conf.accel.fs;
+	mutex_unlock(&st->lock);
+
+	*val = inv_icm42600_accel_scale[2 * idx];
+	*val2 = inv_icm42600_accel_scale[2 * idx + 1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42600_accel_write_scale(struct inv_icm42600_state *st,
+					  int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_scale); idx += 2) {
+		if (val == inv_icm42600_accel_scale[idx] &&
+				val2 == inv_icm42600_accel_scale[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_scale))
+		return -EINVAL;
+
+	/* update accel fs */
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&st->lock);
+	conf.fs = idx / 2;
+	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	mutex_unlock(&st->lock);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/* IIO format int + micro */
+static const int inv_icm42600_accel_odr[] = {
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+	/* 1kHz */
+	1000, 0,
+	/* 2kHz */
+	2000, 0,
+	/* 4kHz */
+	4000, 0,
+};
+
+static const int inv_icm42600_accel_odr_conv[] = {
+	INV_ICM42600_ODR_12_5HZ,
+	INV_ICM42600_ODR_25HZ,
+	INV_ICM42600_ODR_50HZ,
+	INV_ICM42600_ODR_100HZ,
+	INV_ICM42600_ODR_200HZ,
+	INV_ICM42600_ODR_1KHZ_LN,
+	INV_ICM42600_ODR_2KHZ_LN,
+	INV_ICM42600_ODR_4KHZ_LN,
+};
+
+static int inv_icm42600_accel_read_odr(struct inv_icm42600_state *st,
+				       int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	mutex_lock(&st->lock);
+	odr = st->conf.accel.odr;
+	mutex_unlock(&st->lock);
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm42600_accel_odr_conv); ++i) {
+		if (inv_icm42600_accel_odr_conv[i] == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42600_accel_odr_conv))
+		return -EINVAL;
+
+	*val = inv_icm42600_accel_odr[2 * i];
+	*val2 = inv_icm42600_accel_odr[2 * i + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
+					int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_odr); idx += 2) {
+		if (val == inv_icm42600_accel_odr[idx] &&
+				val2 == inv_icm42600_accel_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_odr))
+		return -EINVAL;
+
+	/* update accel odr */
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&st->lock);
+	conf.odr = inv_icm42600_accel_odr_conv[idx / 2];
+	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	mutex_unlock(&st->lock);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int16_t *val)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg;
+	uint8_t data[2];
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42600_REG_OFFSET_USER4;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42600_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42600_REG_OFFSET_USER7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+
+	/* read accel offset data */
+	mutex_lock(&st->lock);
+	ret = regmap_bulk_read(st->map, reg, &data, sizeof(data));
+	mutex_unlock(&st->lock);
+	if (ret)
+		goto exit;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		*val = (int16_t)(((data[0] & 0xF0) << 4) | data[1]);
+		break;
+	case IIO_MOD_Y:
+		*val = (int16_t)(((data[1] & 0x0F) << 8) | data[0]);
+		break;
+	case IIO_MOD_Z:
+		*val = (int16_t)(((data[0] & 0xF0) << 4) | data[1]);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+exit:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
+					   struct iio_chan_spec const *chan,
+					   int val)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg, regval;
+	uint8_t data[2];
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42600_REG_OFFSET_USER4;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42600_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42600_REG_OFFSET_USER7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* value is limited to 12 bits signed */
+	if (val < -2048 || val > 2047)
+		return -EINVAL;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		/* OFFSET_USER4 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER4,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		data[0] = ((val & 0xF00) >> 4) | (regval & 0x0F);
+		data[1] = val & 0xFF;
+		break;
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER7,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		data[0] = val & 0xFF;
+		data[1] = ((val & 0xF00) >> 8) | (regval & 0xF0);
+		break;
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER7,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		data[0] = ((val & 0xF00) >> 4) | (regval & 0x0F);
+		data[1] = val & 0xFF;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = regmap_bulk_write(st->map, reg, data, sizeof(data));
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int *val, int *val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int16_t data;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_accel_read_sensor(st, chan, &data);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm42600_accel_read_scale(st, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42600_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_accel_read_offset(st, chan, &data);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42600_accel_read_avail(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 const int **vals,
+					 int *type, int *length, long mask)
+{
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = inv_icm42600_accel_scale;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm42600_accel_scale);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = inv_icm42600_accel_odr;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm42600_accel_odr);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42600_accel_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_accel_write_scale(st, val, val2);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42600_accel_write_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_accel_write_offset(st, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42600_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
+						struct iio_chan_spec const *chan,
+						long mask)
+{
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info inv_icm42600_accel_info = {
+	.read_raw = inv_icm42600_accel_read_raw,
+	.read_avail = inv_icm42600_accel_read_avail,
+	.write_raw = inv_icm42600_accel_write_raw,
+	.write_raw_get_fmt = inv_icm42600_accel_write_raw_get_fmt,
+	.debugfs_reg_access = inv_icm42600_debugfs_reg,
+};
+
+int inv_icm42600_accel_init(struct inv_icm42600_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct iio_dev *indio_dev;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
+	if (!name)
+		return -ENOMEM;
+
+	indio_dev = devm_iio_device_alloc(dev, 0);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42600_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42600_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_accel_channels);
+
+	st->indio_accel = indio_dev;
+	return devm_iio_device_register(dev, st->indio_accel);
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 151257652ce6..4e33f263d3ea 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -508,6 +508,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	/* create and init accelerometer iio device */
+	ret = inv_icm42600_accel_init(st);
+	if (ret)
+		return ret;
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
-- 
2.17.1

