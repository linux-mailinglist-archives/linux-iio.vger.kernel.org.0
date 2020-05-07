Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2491C906D
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEGOn0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:26 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:36142 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727032AbgEGOnY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:24 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Eb4lb005942;
        Thu, 7 May 2020 07:43:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=vx8zKfnK39Y2G7jVI/7YNtma6l/Y6g3qWBZ7ad+TqMs=;
 b=FHX889XKGAn4W99unMe1koCC7N9kJ9nueeUCgxEZpe7o5xUscOixzLPxu4EylLpDiiDn
 YGprj4979MzabqLbIjcGqMljFLY+D1UrZkQsllwOg/Tkppr6yX8vm6cyegggwMSv1uaT
 eJ0gZc+7s++dKyKRFkkL2H045mQ7DZv7Oaq+yG4VBvO8RSGqJJJYY6tdzizgciRojC3P
 ZH5PEIgvGFcpgsWWixE+nE82xC7/cA5VX+SCBkxGAQlsAlRexZ2OZfFQUXVHTNWoUIN7
 i+P1mAkAaP/grkwGHSC8/xUNq1EA2KjnQoghe8uEJetHhiaQPsaErN9OzHtwk469A6ZK aQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpyROuIoTrJbQLwAGkbY8p0KNFkLA1hGsnyMWYr135Z56YeNOWbHQnSmzPyAV217HwTweFGRrIiqTid8jDogWJUV2DjQXuRCDVmakBtzBOw1kgndDVDY21B3HbXqly5iGaAjz0fbXEkycIQMkpYrCVZiup9ndi+HwczP/49RN++eAjAAAPuJpaAIne1WaJYBTG6CQfec6+R5S+tB9AHuOil1hSw3/Lk36JSRTXF18tUlyHL9tejn4S1x4FthyW+JinF9RqsfJg2wN1pyRVxD9OdqGDI2wG8T6loChmkyQu7aye2jlsh1CKlhoOAXE5GmvOEDt9/D1nbPccadNZ3p5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx8zKfnK39Y2G7jVI/7YNtma6l/Y6g3qWBZ7ad+TqMs=;
 b=hP2wsvLd31OthoCdJAg/3cTPc4JKbndwMkpCKIuVJt3xAeR2B6Ia+fDlsUY28P5o2vVxN85SXs1FHQz7RMDBpJcfC94cUrEXWSo3M+5UWw8iT8aPWT/BSMVvVnsVJUziSZTmef7E/ECWr6rp7l/v02ZvbazQmsDTfM9hSanFDJbn2y8ufWNTrPCT0lMdG4amleBmfvqFehK7FymaFml2SAUFHSpGuk3u6ut8zMQn9rK2e7BL03/lSDMUoPLLOnB/EthnymUHzoeexuyixxKNGRZsnethHd8Sw6JaDDMvjJVCxcvpSo0u1hgyIAGe1MDjSG+GjNey2ybg2r6M6tpzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx8zKfnK39Y2G7jVI/7YNtma6l/Y6g3qWBZ7ad+TqMs=;
 b=KTLmrV/wFQxiGXKoSTQViPw1evhYBVOFyDonX7NF6YkCOO6IOjNVccA0BrOCSTPuo5e4ydj83FNQc/2Q1RUxZiGlnLSha7YSZ64m2u2u1LkuqfV3M7HD9rWpvQ6O1+hjaZGUL3hUHnNgFJBhehuDMVqPstGBzAb80O21As6QLfw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:18 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:18 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 06/12] iio: imu: inv_icm42600: add temperature sensor support
Date:   Thu,  7 May 2020 16:42:16 +0200
Message-Id: <20200507144222.20989-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f879c516-b3b5-46a8-65e1-08d7f294fb35
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4269A93E73FBC56F883BCFD4C4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6giz5YXjBMB64YoaTGFcu668cm/l/HOzDVGXnEct+u7NR4Ip9vhkJF10W4C9p2ImCjo7NoaPAQub3ipOwQXkz67wDUtI7ZuY+YoBASiT4wPq3X2QOM5hlC/5UK7sTJ7uem7ewdINAKQsTmgczf4HCj50OkCLQdr1c7Sv3VASQPmhKkUPcJZLLNf0x0Ex4nH9Y7PvdEP4uf/+OeAlkLTBK92Q+TM+JW/Zyj72+d3ngcougJU9+YggYJWGUTfxJNf+5x+AZqB1sXIcGX3nze+ccoIdInzSkFLqNB7HLKuZX1zRDHqEtAVLgSVCnZUTyGC23TQ/NB8r8DcRrdiZnPS1DifAZCv9eabegiY2KXzfkBDqtyzFyXv1b3hIWjsZvU3GmyhVZGJgWZCTDp1C0BiSEwwY7On5SYXqCwBsF1jKuzwMUnu0LVGycMZA65Crto9ssmUCVJLA7NlhhWic58WybWJP5HHI8n/H+H9coB5hdFyYDAiKOGDVsi/jrLO/GoJNjogdeO1wq7G9+XW5gj+1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +RNptZ1QAUG6MsNLzuspjbmysinzHmqbFANYgxak4KDPCSwRVsKuLM1L1eBihByY4Hr7p1DxVDBrfy4aCHqeNrlxHmWVC4DnmDa0YO5uJbYpp2J8WOF21TifOpJjZLRTj0hhRwA3Wrdky6d+OVpvn2QEZZrbjgJ6xHATA99/MOMajgi2ajKNcNIRiJvWKOAcT2JjnQqHcJwdteV3CWTzgvMsgf72xekmEtqkWYnWYp2JDJPFm46ZXbZ2aY9yW0fYRKgaj9lU+AZQIBTgpOVetAOwQt+DvVGkznZEWW3UeYnp58VrA50v2H+eK/SOzqNxyPLUvYMmQZf5u4qz0uOEchWk/lw2n9vfZ56NkusgFslXIlFZR0BZUnxhRVge0yMV0QM1QGBCbdEWSZr2/ecveGuaisXob3C3i8ZuF2dyQVcFLbsyRWsIEOzy4GNSpM/k35PF+0KaVLQjAQPhif7dr8O4Jmt938t23Qconxt6SDZHCkPl8kcByA4jA71SUD0JCbRIE+VtQDiImyTliNmr8ybwIb0OBcMsy/ecMZd2OKNZzpz4huInWm2WcL/7Naxtjp7fAZQof+YA8slgx8G8V0OhpvTKytp89EFP43oFFZU6FXdB5+sSVibumdH9DJ+wqQ9gQYomrQGYwmDrp6ux1NPc3jXYtZwor6uVN0WQqeF5unoIBi/+l2dqy9nmiG9WLfnUsCtsiqgqZGZ30axqWSztM8ScqY9gecCUsIMl7bVlJ6MziRPPXILahohh2qEToGbiTRhebXluwFgtu6Lq2aTcM9XXQouVb3RS5jej3MY=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f879c516-b3b5-46a8-65e1-08d7f294fb35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:18.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQg9oGEU9Vt2358yxZdsQac2eDHFSbZWCv8Y0b/KgFpv2BjAUJErHaccZtZLy3BdJoOOuZPzY7dgi/P+6QeImEC2HBfCnsjo7a+31p7452E=
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

Add temperature channel in gyroscope and accelerometer devices.

Temperature is available in full 16 bits resolution as a processed
channel. Scale and offset attributes are also provided for the low
8 bits resolution raw temperature found in the FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 12 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 12 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  | 86 +++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  | 32 +++++++
 4 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 397e3d0fd42b..74dac5f283d4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_temp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -44,6 +45,7 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_X,
 	INV_ICM42600_ACCEL_SCAN_Y,
 	INV_ICM42600_ACCEL_SCAN_Z,
+	INV_ICM42600_ACCEL_SCAN_TEMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
@@ -58,6 +60,7 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
+	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
 };
 
 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
@@ -394,8 +397,15 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 	int16_t data;
 	int ret;
 
-	if (chan->type != IIO_ACCEL)
+	switch (chan->type) {
+	case IIO_ACCEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2,
+						  mask);
+	default:
 		return -EINVAL;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 74aa2b5fa611..c0164ab2830e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_temp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -44,6 +45,7 @@ enum inv_icm42600_gyro_scan {
 	INV_ICM42600_GYRO_SCAN_X,
 	INV_ICM42600_GYRO_SCAN_Y,
 	INV_ICM42600_GYRO_SCAN_Z,
+	INV_ICM42600_GYRO_SCAN_TEMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
@@ -58,6 +60,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
+	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
 };
 
 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
@@ -406,8 +409,15 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
 	int16_t data;
 	int ret;
 
-	if (chan->type != IIO_ANGL_VEL)
+	switch (chan->type) {
+	case IIO_ANGL_VEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2,
+						  mask);
+	default:
 		return -EINVAL;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
new file mode 100644
index 000000000000..e5407b17c407
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
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
+	__be16 raw;
+	int16_t val;
+	int64_t data;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_set_temp_conf(st, true, NULL);
+	if (ret)
+		goto exit;
+
+	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_TEMP_DATA,
+			       &raw, sizeof(raw));
+	if (ret)
+		goto exit;
+
+	val = (int16_t)be16_to_cpu(raw);
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
index 000000000000..7c0854d38e1e
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_ICM42600_TEMP_H_
+#define INV_ICM42600_TEMP_H_
+
+#include <linux/device.h>
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
+			.shift = 0,					\
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

