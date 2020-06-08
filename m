Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905C91F20DD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFHUoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:44:15 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:8458 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgFHUoF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:05 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058Kcorf019143;
        Mon, 8 Jun 2020 13:43:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=kU+IuaD+USzK+7Uf0WSkAmmVYqlub7tjrL28klwo1KI=;
 b=Cb+8Pn6o9vUqGFkyN8Ghwp7NCwOd3aLOryH/In0g0RVxuB1fUaRUBIMY96xb/GMe5mqB
 53qEw7CEUkr/QmR95ANrhOb9Q8+hy3oVjiBEV4OxUCtOIFiYf6OqT8HWm+Iye4jgYJGO
 qR/JC6yNrvuzzJXjK5Dw1zYivp1W31RkHpCiKrY6ArD2u34Hej9Xeq1YlIRulX+Lbtij
 qY8lwMhXbR1GwLb4x1R+9bGYbF1p6cdR9ml/1ZYcDPXuba4VByv47uAjspoAA2CsRduV
 ShHFoVouPo0JjSAkYJWijQBIdxCGkMdK9b/GCqzwl3av/nRsVjT/RqJDn3TwZW10X/AN vQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0xvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:43:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWiZ5P73LvU2lKyK9gH+k8LZmqteB2JLaeuYAQWL9pHZFarSHP7eQo+ntrgc4QSbYKad2VFuBRVWwfLQ2bEUJcSLn+EC+w57+uKzc1FWTYE8/md8xkppbmE81jr2gSBBs3IwEitjz7DEiYqpjXOtTt0c10fVz90fi4AMB7F7aBOXeM4Vgoe5dzhk2AJABsm0L3fQfDL0YZVvhu9XIUcX2KrnhwLFxxGWfrRtTZRR7RwEPdhOkDnzpFTM4qlvdCsTJUWJOPMJ4nBeIBb3SKM5Cln+fRPbap70OInHv/LBQhYTRcmyk1RAdbSCJCVCYvln1SgN/NL6PY4M9itSCRqTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU+IuaD+USzK+7Uf0WSkAmmVYqlub7tjrL28klwo1KI=;
 b=KkWpHm3Kn4jzWVSpU6IAQqeEBZ8vuqaPbiJ3Qy+y3Dx6HhvpRmSaPPFOMonbBlQi1QuOiarg397wV7jvzuwX8iN2lLNisxP+Zfv8/HFXWYPZTH3RXDXNTkTAhWPkfmloJ10FSuIVhfI2xTWUIfQKTQQ0zDUHbEK2AFgH+LivgzQNDzXT0k1n089mnO/6x7LXwjTrfMddhNkWCRMbrJoRcjKYN3gn5bNyRMKPhbk5FwilxSISb3RsuGCyVu2u18NWYqh8YSpfWCKBJOmMIXTYP64kUPFDBKJlPndWH0PYdxyOSqPYxWtk2HlyXxAi65BtIGXlvLRguoIYAk7M87uvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU+IuaD+USzK+7Uf0WSkAmmVYqlub7tjrL28klwo1KI=;
 b=Nu1dhR4uxYyf5a8SK5+UvZ8YjA4Dp9RaIUHjQGQiIperqXbbSr6wV0uPV2pG9dldsTaw4i1l5j7GsIcrjA9BfGemEmeDVDkCe6ww0YdQ7nivrvlqt7iXyA9Z+3Z/afKxfT1zSGg8eh+2Wu4nKw5Q/MfpS8V7RHEMcIvrRnwnzhk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:43:55 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:43:55 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 05/13] iio: imu: inv_icm42600: add accelerometer IIO device
Date:   Mon,  8 Jun 2020 22:42:42 +0200
Message-Id: <20200608204250.3291-6-jmaneyrol@invensense.com>
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
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8370aba5-d967-41cc-a3bf-08d80beca8c3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39512BFBC0C3E5FE811B764BC4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYrpQjD8MYk1JdEvRbxY+aziMQnk9nAJtsWvweABW+J6EG56yfF/MUb+Ro6raCJi2K1lsx1Bqj9ziqXhSBbN/zh0Bd7YVA7MHADUYxH4A99s40oNW+zOSKKP0xGUCLig1iyiKznNf5C7Lt54kfVjyMIDao8qgvLas1mrw5pgdtAY+lUuhLQW9qh9ffzbXnKAuEYW/LyRGN+PcRUyuRBqMCebA7+1kjp6SMP4efwJr4fK+gdnHjRTm86qIcC02UuELlMYmGINkal6w9uABU/srIGqmgwrTWIlxiz6Rt0A67uBh/S1t1WgaAd9zTjoGvRHzN9uxM8xh4x8ZaD/36iSXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(30864003)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mAPrJuwo0QyEh6g0kKLDFAbhSKKl/d0lSBVmRNo1FyBMbYnsmI6AczFD3UA20LLbT8PLwN+NppxGlytyc225qtwuUUWqtDVeVA0XwCnVKIcHo1JfmoCEc5i+Fel421+jF6k3a5OYClndaDo5KGRmUFZ00AuJjrMUGlG466kAIB7Y4e8ONuqH+z8aWx3vweIU5EO/jVCCzNPOhabnCgXb7LnILHN9nOYxY21Xdj6tMyHCD75MR2J4H4BaS/WporIl28STF9NX6Vvq+EcUay8TGP+FmLRXLI+mR2oXB5xCja6NQkbsh3wpmADkGnRoeJNzH9/kwFBndNvJ+SbTGAUCijynasMCWre5hB30fIYgHn6/TOSGa5PuUhdKxq37xkEYPUYj6eSFIw00vbfZ5XozwQxYMPsjVtoOAhrJ49Rfa4gI7kFYDvNqBsQozpLERVYmfaQQ4YG59sVem6U78dhmC4nCDEOTaBDyYrMwm9sGYNo=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8370aba5-d967-41cc-a3bf-08d80beca8c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:43:55.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFw3EcG9k3O60CqJ8mtekRoE/nvBmJTCPk2TYsVSNQjyHcgLVWxHnNe2Fdw8mRaZLggqWNy50UNqxWPHojtCGVV5LsE9XojOGkSPCIDjsrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
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
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 592 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   4 +
 3 files changed, 600 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index d155470d770a..3b190461a2b6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -121,6 +121,7 @@ struct inv_icm42600_suspended {
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
+ *  @indio_accel:	accelerometer IIO device.
  *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
@@ -134,6 +135,7 @@ struct inv_icm42600_state {
 	struct inv_icm42600_conf conf;
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
+	struct iio_dev *indio_accel;
 	uint8_t buffer[2] ____cacheline_aligned;
 };
 
@@ -375,4 +377,6 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 
 struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
+struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
new file mode 100644
index 000000000000..717c6b0869fc
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -0,0 +1,592 @@
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
+	__be16 *data;
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
+	idx = st->conf.accel.fs;
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
+		    val2 == inv_icm42600_accel_scale[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_scale))
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+
+	mutex_unlock(&st->lock);
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
+	odr = st->conf.accel.odr;
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
+		    val2 == inv_icm42600_accel_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_odr))
+		return -EINVAL;
+
+	conf.odr = inv_icm42600_accel_odr_conv[idx / 2];
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static int inv_icm42600_accel_calibbias[] = {
+	-10, 42010,		/* min: -10.042010 m/s² */
+	0, 4903,		/* step: 0.004903 m/s² */
+	10, 37106,		/* max: 10.037106 m/s² */
+};
+
+static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64;
+	int32_t bias;
+	unsigned int reg;
+	int16_t offset;
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
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	case IIO_MOD_Z:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (int64_t)offset * 5LL * 9806650LL;
+	/* for rounding, add + or - divisor (10000) divided by 2 */
+	if (val64 >= 0)
+		val64 += 10000LL / 2LL;
+	else
+		val64 -= 10000LL / 2LL;
+	bias = div_s64(val64, 10000L);
+	*val = bias / 1000000L;
+	*val2 = bias % 1000000L;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
+					   struct iio_chan_spec const *chan,
+					   int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64;
+	int32_t min, max;
+	unsigned int reg, regval;
+	int16_t offset;
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
+	/* inv_icm42600_accel_calibbias: min - step - max in micro */
+	min = inv_icm42600_accel_calibbias[0] * 1000000L +
+	      inv_icm42600_accel_calibbias[1];
+	max = inv_icm42600_accel_calibbias[4] * 1000000L +
+	      inv_icm42600_accel_calibbias[5];
+	val64 = (int64_t)val * 1000000LL + (int64_t)val2;
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * convert m/s² to g then to raw value
+	 * m/s² to g: 1 / 9.806650
+	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
+	 * val in micro (1000000)
+	 * val * 10000 / (9.806650 * 1000000 * 5)
+	 */
+	val64 = val64 * 10000LL;
+	/* for rounding, add + or - divisor (9806650 * 5) divided by 2 */
+	if (val64 >= 0)
+		val64 += 9806650 * 5 / 2;
+	else
+		val64 -= 9806650 * 5 / 2;
+	offset = div_s64(val64, 9806650 * 5);
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
+		/* OFFSET_USER4 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER4,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		st->buffer[0] = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		st->buffer[1] = offset & 0xFF;
+		break;
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER7,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		st->buffer[0] = offset & 0xFF;
+		st->buffer[1] = ((offset & 0xF00) >> 8) | (regval & 0xF0);
+		break;
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 register is shared */
+		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER7,
+				  &regval);
+		if (ret)
+			goto out_unlock;
+		st->buffer[0] = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		st->buffer[1] = offset & 0xFF;
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
+		return inv_icm42600_accel_read_offset(st, chan, val, val2);
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
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = inv_icm42600_accel_calibbias;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
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
+		ret = inv_icm42600_accel_write_offset(st, chan, val, val2);
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
+		return IIO_VAL_INT_PLUS_MICRO;
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
+struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, 0);
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42600_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42600_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_accel_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 84e9ff320b3b..a35ff21f50bb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -513,6 +513,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (IS_ERR(st->indio_gyro))
 		return PTR_ERR(st->indio_gyro);
 
+	st->indio_accel = inv_icm42600_accel_init(st);
+	if (IS_ERR(st->indio_accel))
+		return PTR_ERR(st->indio_accel);
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
-- 
2.17.1

