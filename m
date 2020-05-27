Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142151E4D97
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgE0S54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:57:56 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:41772 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728831AbgE0S5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:55 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIuQjQ001589;
        Wed, 27 May 2020 11:57:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=pKHlcanZQtJVY3YRi4kOcjzuGCISfQFFyDumixdxgAU=;
 b=fMx1LI5J24sPr3iIfSGfn+LNvpyYe9nQ/gYjOsoQvBQ9tzL4bBnsQzqudSFRXZaMpEnC
 Myu6aQ3quazKwMrIFVcIlE1+R8GFh+nOoplEMcaEVZVE3HVKytL0TIQ9uH5BaxAK1Yl+
 bbPTVEp6cZ/ytRbgb6WYeso2a3cmJCgRfeBdYluWfowvhvNGwg0i18UOQDG7sJ4xjSy8
 WZkPa3bV9dK7/+O/nsW5cMzhKCTxQC2EPbL4NxxGQpG//XMW8PIUfWkqb++yk1zlMMvl
 aaKNeMQqUdkxjkJTqt+2FqZ83L5iIU4+fkyW0H7WgaFYy665n0SPTvnReoffgaTQs5/g gA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00328301.pphosted.com with ESMTP id 3194qh0ncv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlOo7IX8etA6xoV9tzt3qLIe+48nun5bwj/IlvJyZOneGNw9VqRvqt9bxlItSdCyAbLtjceH0avpU/CcnwDq+q+ITE81OtZO8Plcc7e1EUHxhrxe0FemhwFgjsDPZK0Rs7ah7ZjSwAL/zJfIZyyheEcPu9O2tD395AMC1Peh4cwYuJVmzC5MczABDlQ5eEZ+v/oS2X2FvfFzNG08yPbW5NIK39NhhthSp2GWk4QlEVuJMIRtEvo05jixPEId2ifDFC+H2A5bdKOj5pGETzdkOqlyo/cCfcNYxrwkDX/CLyChEN7UJclep1PeTCIgTDA065IuMuShHtiyfqo1wHWf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKHlcanZQtJVY3YRi4kOcjzuGCISfQFFyDumixdxgAU=;
 b=R/TsA1ObYFzBBKQ8dn8Ja1QUHWtz46SJuQHLOfT9G9zuCxQd89LYMqsEraeENr3DUYuAZ51qnN5LgajH2M+VBzu3Zy2AZlnnr5mC/SSTmun1l1JMZa9jZXO55Jskv0/GvRr/cF4DVhX4CZzeaG5m2fKvlyLu1xiWuj5CIgYbWOF/+661TNt7Hv9URIAsHSofXWdCLzThiEhsyxEU2Z4wgqfmD9rYwgmRPyf5lwbkAdVzDUpJnE+NNHHQ43PLYfJzQats3eAHRn+sSu1r9LBGkiXiDJ3g6DR4bQRGPltiQd5+b9zvyv3gUToSsCWczhB68xDK9tH53JOK4YAT0zruOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKHlcanZQtJVY3YRi4kOcjzuGCISfQFFyDumixdxgAU=;
 b=JR9Cc41TkH8uOeS2TnIhSjfEknHQxymCujy1NXkbIwc+vz6+DE3FdT+yUgvPVDTrx+fbAHmfdICsRVJqyTW21Ia+x+8v7yTZe6Jr2469/gvzOAbJ3d9BqVzwgf1LiCwYOvVqu0nPF5K6anZV9Z1LnJKcItZ5xpGPPoXCb8GJkeg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3470.namprd12.prod.outlook.com (2603:10b6:208:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:57:48 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:47 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 05/12] iio: imu: inv_icm42600: add accelerometer IIO device
Date:   Wed, 27 May 2020 20:57:04 +0200
Message-Id: <20200527185711.21331-6-jmaneyrol@invensense.com>
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
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75179961-e2ec-4965-f4b5-08d8026fd8e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34706AAC4ABC7859966B3903C4B10@MN2PR12MB3470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1TskFjDvYJAiIzLmGyQvEUGawl2ezxSSPnZRgN1BiJ+cG5dT5hl/R7W1BXt0fDnPzPpet18cRkwR3FY6RECyAxFrReQYoBD2txrlCLeUvjyXF0k9zJ3ODnnkza8qGlw4vUt0XgSFXf7s1bemhpXJpRPM/CiNRhHANwcggohfIKWgV0SY1ie2mmfpKaNllkGZl2ucoBNAvDn78OJIdyAOBQ/XFdxzkLeSBl5n3Elw8IfU0I56z7fApSBCHyJpupLy3GUfXq3bf2n5JhO0nUa6yOHLBp03+2bxjvfeY6CvbhZKrriw7Nt1W8n+u+G6BwkEIeA55t1U/9Z5cv/NvMuiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(136003)(346002)(366004)(376002)(8936002)(66476007)(66556008)(36756003)(66946007)(5660300002)(316002)(30864003)(86362001)(186003)(52116002)(7696005)(26005)(8676002)(478600001)(4326008)(16526019)(1076003)(2616005)(107886003)(6666004)(956004)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: df0rpi08lSa5ZB23jU166ptDshDIAp5X/CfriWyJYsK8krrrXoKV4pVmqn2Sj9ocKZPnDmZ5VCPUXYf4bgXXFr2OkU1AUavA5pYr6ez5Ll1fYrFb1tyPuSQacaaGwa/kgxnAXNmJjIf9dS3pangI9+qwKBPFRYTEIsZrp4x1hksgz5732Wx3UO00aMa4HxfyozeEcg7JaNLOcsdkO1ZALVZnwb/LiV8IKyiCsnb0pnls2loKYjB8E08k+H/JkT3HUeqCjQ8NJ5iWjwwdyDaccVfK5bLjQZuEz9M49aazmPNWrUhkdZpnUtTBKg5/y8uKdhwK2rHvnqYzT9yq1LFE3R32ZZjOO0B12WV0hOotuBvpkuCfsK9y8Yni3HKp7SZ63j45F35/q3ukPA/SoS9XkZ4gEpPLsRC9gpFF9rsrT9hIJQq81FHGsWxHiCH7yk9JCHY7i1OkF9nR4JXBXVonRMKqRRJMcuAuJzJd7KXBbxc=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75179961-e2ec-4965-f4b5-08d8026fd8e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:47.8704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSRkd2fu0ofv5UlHvkYlZ01mWExcrSYWhN41JuIocTgaGs5aG5pjbnHAcfSZRvnCbBf48+sHm6Nc+ciU3SSb883hwlKOygdot0zhWXIB+hI=
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

Add IIO device for accelerometer sensor with data polling
interface.
Attributes: raw, scale, sampling_frequency, calibbias.

Accelerometer in low noise mode.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 589 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   4 +
 3 files changed, 597 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c1023d59b37b..c534acae0308 100644
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
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_accel_init(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
new file mode 100644
index 000000000000..7620ce1958e0
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -0,0 +1,589 @@
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
index dccb7bcc782e..e7f7835aca9b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -514,6 +514,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	ret = inv_icm42600_accel_init(st);
+	if (ret)
+		return ret;
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
-- 
2.17.1

