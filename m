Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8005C1F2100
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFHUp1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:45:27 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:57840 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbgFHUn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:43:58 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KgJQB024908;
        Mon, 8 Jun 2020 13:43:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=JIkqp9s/Sl5PfSgpALjiZFm+rdbKd6fIXw3v6jjwm10=;
 b=apfa5WbaHPStpit4vTxyyFQW70G7CI+nPd27p1HyfgMnwlaA0zNgQIKsywq8HZpwHLww
 Mt6BAzbbi0CWBkzyxqoTQJC5a9uRfYggWaP1BiugB02D0dQ5qMbrHmFaMfbcORzROieD
 RWDdgVeos2N/BOjmzCkeefwEhAuJh4dZjb0SoOiHwJNomtHMMs9+1gJlcYWRludL7CTL
 k2r8cSwcPm6FQqBd5TPe8Vu38GdMxRiTw1GP9cGmqpvmtVFba2hgv+ys+EEuKehvk72r
 5sJZTKW+jfe3RzwHDWYs5SPkkHp++xsBAb1dMl2wqVcHyjcyUjoK8vpu1CeBIsaT3mX3 /g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:43:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0HhdwoKQQNpNCErptMVsKK1dShTLx6b1hz9RGGo9VDjzoSEjR7T9C5rJCsNSLHZ79wmKUvFD7KDxvj19+rxoqYHZgBmgIk9x96Ha3j170eUC9hWnD5IrPUppbugD3jqzvCBC09DM/kHE0fTUp6U96WLkTIqgZa9uK+0/6r+Wer7SOJMAQlKPku2fcMfpsfMekAUZwDJ+vJLxzshEEprv3BjnRukJipkrDKUJc4l6LSgNrI7rxIo7nEHj2Pg3BFWllY3/uXWi7RsBDC+60cWcPsUGZcOhxG5NQWT3+she1iHSvCgUA52m7cjvsK6N+uqCcqJzRtyI1CViJ1VjyeurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIkqp9s/Sl5PfSgpALjiZFm+rdbKd6fIXw3v6jjwm10=;
 b=Ckewxe0h3sLxsZmC2B7CA0tRs+LrP7WtRxe2TPDytm/DPIDqGKGNQ1sVsiEHXg4miT/6PRl3hD6TnuyVMEbtVSnKmj7Irv4HDnfjXurG3yYo9ecO7OZuvZ2NSBLahkD1+Hjgl+MVkg95H4WmTRUtbZZwD/pdNlcVc2pkT4yKGSQ0Dzl/eI0vpF0bb5qkG7vA/ZED9eKQLzgVXdEPhQnbEcWifmyXLdnhJ+L8o8HT0/NkJRntM8Fi8eRZucbOtdZrupuuI3JrrXjRoJ1OVKKh9N72oXYFIqJzxFNaBAxaWKUWbuKqo05cqLll4xAccW/vhG01Sg7Y7zvAKBk8501luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIkqp9s/Sl5PfSgpALjiZFm+rdbKd6fIXw3v6jjwm10=;
 b=ZAU15gUF06xIjU9iM+DF1Tzq7tCJGgDagxGmtXNOBby3FPO3cmYoFyX3w9x0TXvJ8im8w+Y9euUnkvXRiuJpQX0bvscFqqvWdQVCgOd4DSbnnr8tZrN8vC1gFsiHtkdqoTVHZV1qmx//Rl5hqcGORz7FaTMd4JnH71gky54OGVc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:43:53 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:43:52 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 04/13] iio: imu: inv_icm42600: add gyroscope IIO device
Date:   Mon,  8 Jun 2020 22:42:41 +0200
Message-Id: <20200608204250.3291-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed01275c-6afe-47e7-8d0a-08d80beca7bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39511378EE0E3C72CB4BD5EDC4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JR5AqwUXwhkBkGsNUi8fO8Lf7rAVgFC9rYHJIbk8FcS8LJnCmu96d8IJKhAJSzR2VdZZuxRAPa2wN7UD0HMjT7VNT3bSC/woSi7bRgVyyQ3FI0PQGy3hhir1eb/v+uy3EuA06aocUyLasped61FsdiueLi4Ar378LxYm3wbs/5AtbzcLO4/5AO64A5XQ1rudl9Th977fg6eM+R8QlLCzlGYiJb26LuchAaHwMfoCAjzTKWehShBND0FqCu/RjzLtvk9mEQd0NhEynSKF2af/31yUm6iglDU+uefeJgqLNUys8o+yZESb3u0uImZi8e2ucVdqoNYDxCncGCsN31Zk8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(30864003)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QGhrrjyrTBM3s8E+zZSBepSt1KXdAaLUhtSLefkYAw5I9x8AG0KSoS/EZW4HUHYYX8IQvgNpKVVI3eeFZN+MnqXRs4JOfQTn8RqrLtey/aQyTPKvsRzuItZukhEFwd5ef/KfFgYNEsN6Zmz4tts0mI5BYvjRqIyEXkGIFvP6sWgWyqNzHVA3M/9gXGDJqcCth3ZQacB+o9lPj5ihVioN1gj42aNDy9MSCzHyBj/Xk1EpxKCia0UteYXD7x8dyjMqGdaJt0Q3D2J/pYhXfWMlcrrjgsHq4pEa0wG052tZW/SegsLaK8D1fA2q1yQWebBSukS3RXXahPRBp2MI/BQ64wAyz176lk1yubl7aLxmMlRff4VJ5xhsggmE4TeL2II4aRmIZ1gnrlFXCSWUNLgDUaWUZlT1c6QKu/w2d9Mjbn5hHVRGyK/4lNWb5mxs+bcZIwML7Q84WXv6anwQavv8O+hC79J/OGgPMSk6FHf1ABg=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed01275c-6afe-47e7-8d0a-08d80beca7bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:43:52.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mLCtoN3lVMqppGrThUH03g/NhUS40mgpsf5Dq4nyv7m5jKSA4aAmRhhPqmTQTgjXivr6aJ3jVYAZ3tkT6UmmL7CbYUvukmnjMkAP44vdoU=
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

Add IIO device for gyroscope sensor with data polling interface.
Attributes: raw, scale, sampling_frequency, calibbias.

Gyroscope in low noise mode.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   6 +
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 603 ++++++++++++++++++
 3 files changed, 613 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 14c8ef152418..d155470d770a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -120,6 +120,8 @@ struct inv_icm42600_suspended {
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
+ *  @indio_gyro:	gyroscope IIO device.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -131,6 +133,8 @@ struct inv_icm42600_state {
 	struct iio_mount_matrix orientation;
 	struct inv_icm42600_conf conf;
 	struct inv_icm42600_suspended suspended;
+	struct iio_dev *indio_gyro;
+	uint8_t buffer[2] ____cacheline_aligned;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -369,4 +373,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 			    inv_icm42600_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 2eb25c5f77f8..84e9ff320b3b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -509,6 +509,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	st->indio_gyro = inv_icm42600_gyro_init(st);
+	if (IS_ERR(st->indio_gyro))
+		return PTR_ERR(st->indio_gyro);
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
new file mode 100644
index 000000000000..3875ecbee67e
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -0,0 +1,603 @@
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
+#include <linux/math64.h>
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
+			BIT(IIO_CHAN_INFO_SCALE) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_all =				\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
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
+	__be16 *data;
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
+	data = (__be16 *)&st->buffer[0];
+	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
+	if (ret)
+		goto exit;
+
+	*val = (int16_t)be16_to_cpup(data);
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
+	idx = st->conf.gyro.fs;
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
+		    val2 == inv_icm42600_gyro_scale[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_scale))
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+
+	mutex_unlock(&st->lock);
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
+	odr = st->conf.gyro.odr;
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
+		    val2 == inv_icm42600_gyro_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_odr))
+		return -EINVAL;
+
+	conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/*
+ * Calibration bias values, IIO range format int + nano.
+ * Value is limited to +/-64dps coded on 12 bits signed. Step is 1/32 dps.
+ */
+static int inv_icm42600_gyro_calibbias[] = {
+	-1, 117010721,		/* min: -1.117010721 rad/s */
+	0, 545415,		/* step: 0.000545415 rad/s */
+	1, 116465306,		/* max: 1.116465306 rad/s */
+};
+
+static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
+					 struct iio_chan_spec const *chan,
+					 int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64;
+	int32_t bias;
+	unsigned int reg;
+	int16_t offset;
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
+	mutex_lock(&st->lock);
+
+	ret = regmap_bulk_read(st->map, reg, st->buffer, sizeof(data));
+	memcpy(data, st->buffer, sizeof(data));
+
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	case IIO_MOD_Z:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * convert raw offset to dps then to rad/s
+	 * 12 bits signed raw max 64 to dps: 64 / 2048
+	 * dps to rad: Pi / 180
+	 * result in nano (1000000000)
+	 * (offset * 64 * Pi * 1000000000) / (2048 * 180)
+	 */
+	val64 = (int64_t)offset * 64LL * 3141592653LL;
+	/* for rounding, add + or - divisor (2048 * 180) divided by 2 */
+	if (val64 >= 0)
+		val64 += 2048 * 180 / 2;
+	else
+		val64 -= 2048 * 180 / 2;
+	bias = div_s64(val64, 2048 * 180);
+	*val = bias / 1000000000L;
+	*val2 = bias % 1000000000L;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64, min, max;
+	unsigned int reg, regval;
+	int16_t offset;
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
+	/* inv_icm42600_gyro_calibbias: min - step - max in nano */
+	min = (int64_t)inv_icm42600_gyro_calibbias[0] * 1000000000LL +
+	      (int64_t)inv_icm42600_gyro_calibbias[1];
+	max = (int64_t)inv_icm42600_gyro_calibbias[4] * 1000000000LL +
+	      (int64_t)inv_icm42600_gyro_calibbias[5];
+	val64 = (int64_t)val * 1000000000LL + (int64_t)val2;
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * convert rad/s to dps then to raw value
+	 * rad to dps: 180 / Pi
+	 * dps to raw 12 bits signed, max 64: 2048 / 64
+	 * val in nano (1000000000)
+	 * val * 180 * 2048 / (Pi * 1000000000 * 64)
+	 */
+	val64 = val64 * 180LL * 2048LL;
+	/* for rounding, add + or - divisor (3141592653 * 64) divided by 2 */
+	if (val64 >= 0)
+		val64 += 3141592653LL * 64LL / 2LL;
+	else
+		val64 -= 3141592653LL * 64LL / 2LL;
+	offset = div64_s64(val64, 3141592653LL * 64LL);
+
+	/* clamp value limited to 12 bits signed */
+	if (offset < -2048)
+		offset = -2048;
+	else if (offset > 2047)
+		offset = 2047;
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
+		st->buffer[0] = offset & 0xFF;
+		st->buffer[1] = (regval & 0xF0) | ((offset & 0xF00) >> 8);
+		break;
+	case IIO_MOD_Y:
+		/* OFFSET_USER1 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		st->buffer[0] = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		st->buffer[1] = offset & 0xFF;
+		break;
+	case IIO_MOD_Z:
+		/* OFFSET_USER4 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER4,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		st->buffer[0] = offset & 0xFF;
+		st->buffer[1] = (regval & 0xF0) | ((offset & 0xF00) >> 8);
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = regmap_bulk_write(st->map, reg, st->buffer, 2);
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
+		return inv_icm42600_gyro_read_offset(st, chan, val, val2);
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
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = inv_icm42600_gyro_calibbias;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_RANGE;
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
+		ret = inv_icm42600_gyro_write_offset(st, chan, val, val2);
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
+		return IIO_VAL_INT_PLUS_NANO;
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
+struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, 0);
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42600_gyro_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42600_gyro_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
-- 
2.17.1

