Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC81E4D98
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgE0S6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:04 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:41024 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728742AbgE0S5y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:54 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIuQjP001589;
        Wed, 27 May 2020 11:57:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=gtSwqTtO9ukhzvARnknbqS3F3iKZcfW6tzOqlJOI/Zg=;
 b=iKkDZEObnyhpPWW3WU1/BMyi7/vld6WJ3Rs5KjsLMUaBlw3iCD+EM/6I+4UgcDeYmCoJ
 afw5oqVHot+NHGlZWIhlJNOFqS6RVJXqtuw+7RdlHcNM8nLlzLt6Bte6euI0TxFAzT0b
 rhDepDGnBUzMQZXauTqy0xC9EE06JeesCBFbT4lux8CFcfCJPmbwB2kIq/i5n83Lqwh1
 itLk+/ei+QNlooIQODNyFnGeGwffsCXEgW9lCfBtgelzb4gBQaxFJ1iZcIFoMKYfEpTV
 Pe0NOGyhslVNs3Rsmz8tVOnKuAacamy39eUxmYGaXSMg/8l18IbvOPNC8+178JHocwAa IA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00328301.pphosted.com with ESMTP id 3194qh0ncv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+HIPSkRYsFoSUIlVEytknE3EVCMG9GqXkzvIgX2IH+GLMpSfk3DHG6eIJIQk+bU/xMlaBR1i8ZVnXivTJpWYN+j/yVDtbzyfGJ4uGkcb0E4zceh6ecZ3cf4dLa8ipfYSK+kO+JrnIdLmDPW4kVD4A2KRfXRFzSAHZX52AghqQl+vcKmDsTrk6f/784L4a7qarBK9dJBeRaBgU9OANo6CgMLvKCNS0e6iz3m0bwOMeYAxQ2CPLgNGysIDVSjp3qkuDN4J9A9LJMhuprXXb8ZRT8RloVNcv6+K6avvYRfStZ1cZniJxv4927CMI7w3OO2vobGqCU4CQOFZy89dRiGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtSwqTtO9ukhzvARnknbqS3F3iKZcfW6tzOqlJOI/Zg=;
 b=WJx1fa8hlBrjUe+CAw1qZpv/pE+5MD8bVtI/Wzmaj9SQlu3Gv0SzC86cIktplKnlz6AE8qoLM5PHkeMcjhd07EjL6E57Mt9DtkqiClokEpBeXwRO3pBo2Rwh503S0mMv2LkKqb49KP0IOvTbiUsb8QHApAzbrwhJkMny8XzxGslC+UWpWQB9hgunyWlOYiyoQ7PcpYMPOI9qoV7FIGjm5SanbWVxM0YkFk71AYjQpa8cWNtOWt7nOSVnxjtDL4RCPdehflvcz0Wczwl/YptCJxO8fULZLIPgzgpHzcWeE0AwhoNPLXqgjZPwts4akBkFnbbQGGkcsQCJ1ziYHlfUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtSwqTtO9ukhzvARnknbqS3F3iKZcfW6tzOqlJOI/Zg=;
 b=PTGlOyg2afOcbyLNVO8+sS661MshXJbWe3twY7bFT1dL5WSTFt2/6M5C1w9LNw7G14zvMdXe93L507flTJoUUyUNuGy5sCrEAN8/YYm78QzqCH1DDu3YJT1bJ9oUYzLWkVlqIgTULo9T1/91uvNBVPZwXDWiwATXRW0KAyuB0zg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3470.namprd12.prod.outlook.com (2603:10b6:208:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:57:46 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:46 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
Date:   Wed, 27 May 2020 20:57:03 +0200
Message-Id: <20200527185711.21331-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c48c9dcf-168f-40ae-b2cd-08d8026fd7e2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3470343F5738B39922ED7638C4B10@MN2PR12MB3470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XniHn++/qDa6rHDwFx3pYj7LWFxk11EQKAupXdBeTTycXdgXHhN6iHjVhcrRxMSKn6Q419tnCjNun80/zK+xBxjyKiDrJSnnHbLMCImtP/RuYKjUFk3RaEsP09iXdWtgTMF5vIAIP6wvJURDt5jyWZ+YosNtyx6EPPwbSENotarOpL/WRwkYkgGLkYry/FLGQpenrgm1YuEASW04Qaingfd4fpFjPXT1+QKrruQztTbcD5QGf3A1kfGBqQwAXhNxeoxQOQJ49q2gx1Nf2mNXKvI5eoQEuVm3UaxMSk6RtYVyIYJeJuimyOiwwvaJmhCMM6BLn62fCLOIME8mCG+HbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(136003)(346002)(366004)(376002)(8936002)(66476007)(66556008)(36756003)(66946007)(5660300002)(316002)(30864003)(86362001)(186003)(52116002)(7696005)(26005)(8676002)(478600001)(4326008)(16526019)(1076003)(2616005)(107886003)(6666004)(956004)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uUaRctVgb3YNtoVcoPW0bEKW4ClPSG9BL+OWPdo9Pkh8exL1VUBR4xi3wuvTuD5CkZwwWBKBLNrhCfg5N9MIrUB2KRDq7VOk46KD5IWaxTZfs77io6ITz/EftjUHDOG7lMQRFUlGepOiQ274uP87cQVkZTeeI+xpj2loA/Zid5y6dMXRoPgR1kvHiZW8ULUgJ86vXFKoD5musor9+pl7NWuPGbTvlNl+Kb7HSrh9YdVCf0yGxmi4gekljTVWkRQ/CqlaM1yylOXftI/7xdVGgkC48ORI1mJ6J9sMZqX/2BmjAA546lda6BGH1mNVuwgLMzbneG+ob8Ie0pKbEgVuDaPYrjTfSqqAl01kZIrP53fGtQoDip0Zl8R9WnsLJPlC+tgIm6jtZANehHYeQB2A2S7/49Wu7Pdh1OFEyg1JHW/0OC5kcaTg6pYUx4KNBZarDhGgqXGgb03FcJJwpupNy96hFDbP4HR5UUMpbfJ71eY=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48c9dcf-168f-40ae-b2cd-08d8026fd7e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:46.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOo9w+14hsGPMfn4b69GI1W+L3HiVz0rnS08dIGH5jn3t79xsHAjmcFtvNnul2YchzVxE/5f3yP8awbE/CFY6DqJun/8fbMV1aEWND5kL7g=
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

Add IIO device for gyroscope sensor with data polling interface.
Attributes: raw, scale, sampling_frequency, calibbias.

Gyroscope in low noise mode.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   6 +
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 600 ++++++++++++++++++
 3 files changed, 610 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 14c8ef152418..c1023d59b37b 100644
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
 
+int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 81b171d6782c..dccb7bcc782e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -510,6 +510,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	ret = inv_icm42600_gyro_init(st);
+	if (ret)
+		return ret;
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
new file mode 100644
index 000000000000..9d9672989b23
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -0,0 +1,600 @@
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

