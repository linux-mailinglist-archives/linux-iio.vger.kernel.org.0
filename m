Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964021C9064
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEGOnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:20 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:23002 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgEGOnT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:19 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Eegd6005564;
        Thu, 7 May 2020 07:43:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=1bOjF4OnTz74NnMsiumNubxHvSGSjvKYI03VWRA74XU=;
 b=mhUze55Sk5y25snO+6W00wnwxh946shaykrqFAzLrSoRm89sw2E5gHpV3dnTyQToNhuv
 k0wZhckKoi9tgYkQoSf1RDRyxqlXpeseA9qrcADbjYHHWneR/+NviGc/SexEjbCkj7o+
 gBYXimdl7WvYXshsDZ3Ks4u7FSw5QopofBWJptk8KP9eL8GrnRNrMjNJ7SNRZYGqxIri
 XxepbSyhJrYfZHoVhUJ963lkPev2D5nMhEy/niSDYMOLk1CBjFBXZjXsLExdRzYPEuk3
 XzLn00r6jvUzp9Ka+A1shDvBYa2HNVL2B8flHUOOy95+ykNUYNrRaaejr5fJoi4mHkTy 9g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00328301.pphosted.com with ESMTP id 30sfwdjs8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/J4roHpgG08xUz++aZUToAEOKlLElCFh83P/KUHrrhfapw6KGoJks5mX7qu+0vT+WdJjmeLIkNYSe8KTBTJBTXrI49yCzno6qlmBhNRbQQ92HXoEH5a96Gi1RCNnbCGCq5tFwhvCbvQLLioOk1Sfqj0mCrcS6xO5ga9NSXJFNgq/fzgU4jIwugyoC1nJlduJloOCBs+Cl4KXhD15pITX0w7h8qKBpnoKKojZTp+zGmctDKrzdrvDc5dy/di5M1TJP8HhlUbiXVVnpd3p+zVaHqSystx4qRQTNx6RDNm8nRAKs98xBpad9VRK6OLHbj7serRMNfQw0luuoK6EISjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bOjF4OnTz74NnMsiumNubxHvSGSjvKYI03VWRA74XU=;
 b=ej2CrkeRbFGbFTw1YrRYJ2aG9/fG1RAWW/9DQTBypzYrAdZmo74pZl7KAtWa6bqqjnVwGKjbl2C9iE+X/OG7MLEKWZvV4+OVb7ZsD7LAZdDyIh01OCHhzvxZe/kyz/KBmJYlFcnSwjNRL5QlVpTJQbTT/QDfIH7kRa4zZUA5q/lf5uSXlZ1ST/dsJ8KBDi4VVaiwos6Zrn9FWLKYvoSMohI7HWnPHoiujuVlqcTwVlGY59awnAl4S3D4FHUlsb8MUq6krNJCHRjB6idMZzDEiLvDv6T2nJQz7w1JcnFWVps7tMAWPv8NWWQAPIotXcDCtIWrechUf6IpZc9u02z/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bOjF4OnTz74NnMsiumNubxHvSGSjvKYI03VWRA74XU=;
 b=LRkYwmlYAdO8VE4wL85bubraBTHMP20qFoOP94R7Zg7oyM0Q8puvoqO0tVlNEteTli2KyKSdi9iBld256T5NGto22LoahFLMP7sBXm0LgthvhEuingXI4ck/JFX4BBaIRDnXUYcr0OJfExIbjP5O4bIFrFoOe20QFkNYDUe97OI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:14 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:14 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
Date:   Thu,  7 May 2020 16:42:14 +0200
Message-Id: <20200507144222.20989-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e96971-22d8-4f7e-149e-08d7f294f82d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB426955BD8BA8F893CCC3650EC4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjQIsCVxWzvnzUHr3hBJOD1kUKlwyoGxB/yOYrmtKrHWXcWfW2klR2XkHWpUjS40ZsqqbDduq98RKfMDk3dRfAVUI5tjCcA3UbkRjLBMkprdGn/OPWv4iKUR6Y6vE1IIfDB4jaYGDVIuyqOLXGkzvQAe3HcHWROlCw+R+vgWeojBvD35qb8oIoY1yLzTGRPjgW1W68Ktgw3fqgJsyxx50LhuT4cyHazXfbHUbT+uYDn9FWBfptOmHc36g0+koUpZZgHqvCpdni7iItg463vpOzpF1y3GcNU78Qx4FVqEEsufQhCHXW32Di5Uil9yBH9ZH5aSDkkqIxS6wuRJYLshumIpAgX5SH5GG9RvCFd3VTsom1jo40zhrucoYzIX70FCIy1AIq7jHCq4UyTQL1653SSpiKNIitGaVomdHWSUbXyw8Z0jqolc+IpKHgnHQ2fWCkwgzBxMpySB3ubu3YufvlEUcGEMKCFi7KxFwY4wnkNs8WtquqV5jQHv0Tw8AU4tncO+XaMPjKDCFfj1D0z0zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(30864003)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J7bDtdj253sIw1hHVbsBVV4g4vR0uz5YJ8py4kk5vMq0suLqBgd+GjqMvJu7bKarXkD5bpgKvofj54QEaiDJNRugSDtGktoxdztK/krO6wWo8lZ29DnbJFd37iKw5AdQaFLOovuVo3Iu8yW6NS1S5mygPJR+ph2YOUw0EahVaBbp9j18Nj8QJbYzRESEz3bkazgkNRxpyLW6z5/qvXMqJuC0dm6WomxqIieQH4JaPF6YWr9fJB0RvEnD+5w36kaAzn26mRatbh0wtShCjQ49PgszEn0nbyWh2iinV2quy30RZvLjC6woUOYZePwkfIMI7PNIQwqgtChNZC/h+xxClHUHBGmc/vgXLZjpVbnC12mOQQHAe/fIyzF5e3bsyt4W/NFXTQ8uWkHMvy1O6UHMZowgRbTE6Uk8REdcFNhsFAU1fxYKPcLLqvTpg60RUjvymdnSk1ubWjpxCrnIhUy3mhJD0pTOHpHFS6WyYQF6+6s/0kFbIqHKonq2BmroWC6LR2Cya6cPCLUNzQlPRHIEpUcPA5Cac1hMzF48n4/3szg7PBeTT+N33a9H2lXmDgcAfXyW7YA6TV3UQBrQ6lo5KHqL5I6InGiG++9W+0Py4pT3cQP8l0f8Ou+9MYx5fGUvRAUudFpamT4+Ca0e0qtqaw5WzSyEWEYRi/YrGRplTAWAqeUmIQsrD8/6rHMxTipbsszB98kjqgTR19cOb0yTuEUYKJiLTP92LmP1UpOfnPMZ1D/kuL5LetU137j7ab6thX/dU8NF6c6xdukfDLjQqJv99h8NLe8JcHgzwZa0yzM=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e96971-22d8-4f7e-149e-08d7f294f82d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:14.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7YM6Seu+Pvj5xixFihT7BfWw1499Jn55+LXvE5qnUZrXFTFHpzB4eyuiFIZjraOQhhiYt1xx6oB4MwasyILfmv4KgovD35stE+gYZ0NqmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

Add IIO device for gyroscope sensor with data polling interface.
Attributes: raw, scale, sampling_frequency, calibbias.

Gyroscope in low noise mode.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   5 +
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 549 ++++++++++++++++++
 3 files changed, 558 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 8da4c8249aed..ca41a9d6404a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -120,6 +120,7 @@ struct inv_icm42600_suspended {
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
+ *  @indio_gyro:	gyroscope IIO device.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -131,6 +132,7 @@ struct inv_icm42600_state {
 	struct iio_mount_matrix orientation;
 	struct inv_icm42600_conf conf;
 	struct inv_icm42600_suspended suspended;
+	struct iio_dev *indio_gyro;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -369,4 +371,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 			    inv_icm42600_bus_setup bus_setup);
 
+int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 35bdf4f9d31e..151257652ce6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -503,6 +503,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	/* create and init gyroscope iio device */
+	ret = inv_icm42600_gyro_init(st);
+	if (ret)
+		return ret;
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
new file mode 100644
index 000000000000..74aa2b5fa611
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -0,0 +1,549 @@
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
+#define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
+	{								\
+		.type = IIO_ANGL_VEL,					\
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
+enum inv_icm42600_gyro_scan {
+	INV_ICM42600_GYRO_SCAN_X,
+	INV_ICM42600_GYRO_SCAN_Y,
+	INV_ICM42600_GYRO_SCAN_Z,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
+	{},
+};
+
+static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
+	INV_ICM42600_GYRO_CHAN(IIO_MOD_X, INV_ICM42600_GYRO_SCAN_X,
+			       inv_icm42600_gyro_ext_infos),
+	INV_ICM42600_GYRO_CHAN(IIO_MOD_Y, INV_ICM42600_GYRO_SCAN_Y,
+			       inv_icm42600_gyro_ext_infos),
+	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
+			       inv_icm42600_gyro_ext_infos),
+};
+
+static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
+					 struct iio_chan_spec const *chan,
+					 int16_t *val)
+{
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int reg;
+	__be16 data;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42600_REG_GYRO_DATA_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42600_REG_GYRO_DATA_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42600_REG_GYRO_DATA_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	/* enable gyro sensor */
+	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	if (ret)
+		goto exit;
+
+	/* read gyro register data */
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
+static const int inv_icm42600_gyro_scale[] = {
+	/* +/- 2000dps => 0.001065264 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_2000DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_2000DPS + 1] = 1065264,
+	/* +/- 1000dps => 0.000532632 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_1000DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_1000DPS + 1] = 532632,
+	/* +/- 500dps => 0.000266316 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_500DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_500DPS + 1] = 266316,
+	/* +/- 250dps => 0.000133158 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_250DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_250DPS + 1] = 133158,
+	/* +/- 125dps => 0.000066579 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_125DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_125DPS + 1] = 66579,
+	/* +/- 62.5dps => 0.000033290 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_62_5DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_62_5DPS + 1] = 33290,
+	/* +/- 31.25dps => 0.000016645 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_31_25DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_31_25DPS + 1] = 16645,
+	/* +/- 15.625dps => 0.000008322 rad/s */
+	[2 * INV_ICM42600_GYRO_FS_15_625DPS] = 0,
+	[2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] = 8322,
+};
+
+static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state *st,
+					int *val, int *val2)
+{
+	unsigned int idx;
+
+	mutex_lock(&st->lock);
+	idx = st->conf.gyro.fs;
+	mutex_unlock(&st->lock);
+
+	*val = inv_icm42600_gyro_scale[2 * idx];
+	*val2 = inv_icm42600_gyro_scale[2 * idx + 1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state *st,
+					 int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_scale); idx += 2) {
+		if (val == inv_icm42600_gyro_scale[idx] &&
+				val2 == inv_icm42600_gyro_scale[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_scale))
+		return -EINVAL;
+
+	/* update gyro fs */
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&st->lock);
+	conf.fs = idx / 2;
+	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	mutex_unlock(&st->lock);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/* IIO format int + micro */
+static const int inv_icm42600_gyro_odr[] = {
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
+static const int inv_icm42600_gyro_odr_conv[] = {
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
+static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,
+				      int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	mutex_lock(&st->lock);
+	odr = st->conf.gyro.odr;
+	mutex_unlock(&st->lock);
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm42600_gyro_odr_conv); ++i) {
+		if (inv_icm42600_gyro_odr_conv[i] == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42600_gyro_odr_conv))
+		return -EINVAL;
+
+	*val = inv_icm42600_gyro_odr[2 * i];
+	*val2 = inv_icm42600_gyro_odr[2 * i + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
+				       int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_odr); idx += 2) {
+		if (val == inv_icm42600_gyro_odr[idx] &&
+				val2 == inv_icm42600_gyro_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_odr))
+		return -EINVAL;
+
+	/* update gyro odr */
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&st->lock);
+	conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
+	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	mutex_unlock(&st->lock);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
+					 struct iio_chan_spec const *chan,
+					 int16_t *val)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg;
+	uint8_t data[2];
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42600_REG_OFFSET_USER0;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42600_REG_OFFSET_USER1;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42600_REG_OFFSET_USER3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+
+	/* read gyro offset data */
+	mutex_lock(&st->lock);
+	ret = regmap_bulk_read(st->map, reg, &data, sizeof(data));
+	mutex_unlock(&st->lock);
+	if (ret)
+		goto exit;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		*val = (int16_t)(((data[1] & 0x0F) << 8) | data[0]);
+		break;
+	case IIO_MOD_Y:
+		*val = (int16_t)(((data[0] & 0xF0) << 4) | data[1]);
+		break;
+	case IIO_MOD_Z:
+		*val = (int16_t)(((data[1] & 0x0F) << 8) | data[0]);
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
+static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int val)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg, regval;
+	uint8_t data[2];
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42600_REG_OFFSET_USER0;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42600_REG_OFFSET_USER1;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42600_REG_OFFSET_USER3;
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
+		/* OFFSET_USER1 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		data[0] = val & 0xFF;
+		data[1] = (regval & 0xF0) | ((val & 0xF00) >> 8);
+		break;
+	case IIO_MOD_Y:
+		/* OFFSET_USER1 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		data[0] = ((val & 0xF00) >> 4) | (regval & 0x0F);
+		data[1] = val & 0xFF;
+		break;
+	case IIO_MOD_Z:
+		/* OFFSET_USER4 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER4,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		data[0] = val & 0xFF;
+		data[1] = (regval & 0xF0) | ((val & 0xF00) >> 8);
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
+static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int16_t data;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_gyro_read_sensor(st, chan, &data);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm42600_gyro_read_scale(st, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42600_gyro_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_gyro_read_offset(st, chan, &data);
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
+static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					const int **vals,
+					int *type, int *length, long mask)
+{
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = inv_icm42600_gyro_scale;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm42600_gyro_scale);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = inv_icm42600_gyro_odr;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm42600_gyro_odr);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int val, int val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_gyro_write_scale(st, val, val2);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42600_gyro_write_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_gyro_write_offset(st, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
+					       struct iio_chan_spec const *chan,
+					       long mask)
+{
+	if (chan->type != IIO_ANGL_VEL)
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
+static const struct iio_info inv_icm42600_gyro_info = {
+	.read_raw = inv_icm42600_gyro_read_raw,
+	.read_avail = inv_icm42600_gyro_read_avail,
+	.write_raw = inv_icm42600_gyro_write_raw,
+	.write_raw_get_fmt = inv_icm42600_gyro_write_raw_get_fmt,
+	.debugfs_reg_access = inv_icm42600_debugfs_reg,
+};
+
+int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct iio_dev *indio_dev;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
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
+	indio_dev->info = &inv_icm42600_gyro_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42600_gyro_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
+
+	st->indio_gyro = indio_dev;
+	return devm_iio_device_register(dev, st->indio_gyro);
+}
-- 
2.17.1

