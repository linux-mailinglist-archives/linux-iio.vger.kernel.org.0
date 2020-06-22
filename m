Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F915203B1F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgFVPiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:25 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:5618 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729742AbgFVPiU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:20 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFa4C9021446;
        Mon, 22 Jun 2020 08:38:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=XHIDrMlShwcYhMmtooXywMhG5BaU+fNN6M8/5X7z1QA=;
 b=PeX3D6AxFu81kF2UBd+4uQcIVtw4/RlgkPFNVzggUDPa2MCZ035Hej/fD+clMyek83dd
 aa98SjyjfpC8N0uakvCQJonP/0yHLRXXKtq3VqZ6jB1bh9XI/Xj+bC0LNZRzdB5muzWh
 UMJDgZ6CvbGjCyzXKvAnDoDk8l2B/UbzWVesOJ0eXk2Dh4aEf9KsRNeU7EwiuUIwE4HZ
 fMlVeDLcsad5b4gIET7jONbbf+O2F1E9DZwNngD6xbQ5cKgZU4ECQO/I8azfblOfiilv
 h3FytTB0qVchBI/JnBxvV6eop/Yb3sQxMa4LPNaT2cnAq3O1xKDUq3A7wrjOkkckrqa+ cQ== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0a-00328301.pphosted.com with ESMTP id 31sdxnrty5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxmHnYSaXwAHVwwdU6m7tDyNcafZJF3iF0KJN/fWhzcLYxyQ6QTu9tS1c2GHCe7T5eY3G/sHqdP0d2AJabDd24iqb8gmHzWCbCCBsQpL4z+80kn+NGLu2RspfQ7c4cYgV4f6GoCxOJ5yxYETnGBCD+8CwH0uCsMDIfGFvey/D7e1lYXv5kRuynI4v6c4ms5hzL2RHhBJWXbB+nEAFr+uyFTZIdcZcuo+SNbb6t1JT+CNH06TbKkh/MMVmNXdvmmysbyyFWntw+QGReDA3oeQlEXcwkTegdAovJgjRUwrlMMyss251NvbMZ/3nbkUxnpcIAUsB+oibSDXPV1NV6xaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHIDrMlShwcYhMmtooXywMhG5BaU+fNN6M8/5X7z1QA=;
 b=k5M8DALnzWTO5IIiawd5eBLg89oS5XN3Ly3tLB5oinSNTcnPudMJmqy+jI5c8sFNFgCM0dvB87k9s/eH7BxiI3UArov5BX/f3XS0WA1iFfFHCI4tGMKUwUUppNKl6kCrFcvt8oPh05bB1qXmhe1YRDCJeYd0lXA1oZF2cXoWjNKgETMt+RUm0XBxQo6PKq8lqHjUYmUWLOo9MTWA1b61qo5jH91/PVvd5kw7v/RLfvdpUN0VnCAabeFeA+3p2ZULGQ4LIp6kQ1kFrvPhkaCn05a7lnnzLJASfdAISR6p20xT5dJAh/IAmI3rZXHX5Vk0Us7Zt/gBK/S/8VNHQvWoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHIDrMlShwcYhMmtooXywMhG5BaU+fNN6M8/5X7z1QA=;
 b=QMrmQhFvbjO2HVU9ejpZkhoPCeGbzUlUqpuYStk1eaYmt4seOXzFFieoEGL/stel1SVZNBYQE1HqnYFmrJRFjfttPaIJ9VA6wA+KYEYSFJXqD3zMjVjveaIwdW/hpDW5oIjFfV2urmKuVyL9jJdRVegYs/KebWFOTJweK4PfkQw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:13 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:12 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 11/13] iio: imu: inv_icm42600: add accurate timestamping
Date:   Mon, 22 Jun 2020 17:37:27 +0200
Message-Id: <20200622153729.12702-12-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed8a655c-0ada-4753-3d0f-08d816c245c8
X-MS-TrafficTypeDiagnostic: BL0PR12MB2338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23385CA712C9548BF2009F49C4970@BL0PR12MB2338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6LTTRsJHJC+BethotsL7f+V7YydfaxjDZj5cbI2UXZcLeiQct47ZZkdzIfEx6APIcXOK7RCbD8d8+8Z4i4T6UeKcCYaNMbKbdxC+1R9vD52CJuEbTkRR1ao9fpna1DZIlVNLOgARv64yDo5bbwLfL9p07MlbloRNZ6lHfOemShoDfpXhfABoOsjUmEbCUPvHGJFFI8BIo1HKpbtx3FwiWflDoSRLBt1OhTe/gWwljdLQ6VcP+U289asaOfOngz/vlPwBexeiMO2mq9vxGAu9IYiouQfqDqRQs2uRjyj8/TiYxW5BYz5xWQHrsPIbYcJta2ZbM68BknGpFc8Tx88uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(136003)(376002)(39850400004)(6486002)(36756003)(2906002)(30864003)(107886003)(16526019)(186003)(8936002)(956004)(2616005)(83380400001)(26005)(8676002)(6666004)(478600001)(86362001)(1076003)(66556008)(52116002)(7696005)(66476007)(5660300002)(4326008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W39hTG1Da6V7gWjKdYfcFcTeG+5OoNOaZLPd7hAUjj+98u8+PDd8bIi2NZIRc4hj3SMNFxN2FNHcTidwhvBBPLtt1j6UfUozvsXkSxh97xnUc4eQ7aeh2aecQN4pn1CIGLE6Req0YWsbm1BmVWU3ck9z3+SN9XITdCZ567jcRiH0PrEud67G8AAr1mnF7UvMdlA7AeUrLhl2Su2Wg+Qa6qgpvivVW8c6DeZXXTOP2uLSS0K71O17iyuL+yxWPpmz3stnOhwbRLRhVwWGXjXBeJa7i2GPmX9iz9SLpxBtf3qfl+ypSYkF4cInXjLAFkCQpxxgPyuXyKQzbq6mNT8SoJnN11aa+AnI78BAdZYTgqIFusvpovXfmxVr8E6L/h7II8uX946AIYibpOFyP75Iy5A0FJYwlIZSPw32YSSVIrSBZx4tQ2WP/dLxFo/tNhvyjU3RzDajhDZKZH2KHNndc1TKwLfBKwZThWHkXwhkwkw=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8a655c-0ada-4753-3d0f-08d816c245c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:12.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PmMUdv/a88N9z9t2nWLacFmQ4mokIlNpQCAxGOX0/8Wj0RZ+oSQLLCfnvhn/aivujZa0j4L0RybotqmIQFyAL3ZqDcJRiY0rjbBtMt6tKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 cotscore=-2147483648 suspectscore=2
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a timestamping mechanism for buffer that provides accurate
event timestamps when using watermark. This mechanism estimates
device internal clock by comparing FIFO interrupts delta time and
device elapsed time computed by parsing FIFO data.

Take interrupt timestamp in hard irq handler and add IIO device
specific timestamp structures in device private allocation.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/Makefile         |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   5 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  40 +++-
 .../imu/inv_icm42600/inv_icm42600_buffer.c    |  28 +++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  17 +-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  40 +++-
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 195 ++++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 ++++++++
 8 files changed, 396 insertions(+), 15 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h

diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index 0f49f6df3647..291714d9aa54 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -6,6 +6,7 @@ inv-icm42600-y += inv_icm42600_gyro.o
 inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
 inv-icm42600-y += inv_icm42600_buffer.o
+inv-icm42600-y += inv_icm42600_timestamp.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 7b52d92739c3..c0f5059b13b3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -126,6 +126,7 @@ struct inv_icm42600_suspended {
  *  @indio_accel:	accelerometer IIO device.
  *  @buffer:		data transfer buffer aligned for DMA.
  *  @fifo:		FIFO management structure.
+ *  @timestamp:		interrupt timestamps.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -141,6 +142,10 @@ struct inv_icm42600_state {
 	struct iio_dev *indio_accel;
 	uint8_t buffer[2] ____cacheline_aligned;
 	struct inv_icm42600_fifo fifo;
+	struct {
+		int64_t gyro;
+		int64_t accel;
+	} timestamp;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index fbc029bd6e72..3441b0d61c5d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -17,6 +17,7 @@
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -50,6 +51,7 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_Y,
 	INV_ICM42600_ACCEL_SCAN_Z,
 	INV_ICM42600_ACCEL_SCAN_TEMP,
+	INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
@@ -65,15 +67,17 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
 };
 
 /*
- * IIO buffer data: size must be a power of 2
- * 8 bytes: 6 bytes acceleration and 2 bytes temperature
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 6 bytes acceleration, 2 bytes temperature, 8 bytes timestamp
  */
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int16_t temp;
+	int64_t timestamp __aligned(8);
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
@@ -94,6 +98,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -121,6 +126,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -301,9 +307,11 @@ static int inv_icm42600_accel_read_odr(struct inv_icm42600_state *st,
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 					int val, int val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -322,6 +330,11 @@ static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
+	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+						iio_buffer_enabled(indio_dev));
+	if (ret)
+		goto out_unlock;
+
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 	if (ret)
 		goto out_unlock;
@@ -611,7 +624,7 @@ static int inv_icm42600_accel_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_accel_write_odr(st, val, val2);
+		return inv_icm42600_accel_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
@@ -694,6 +707,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_timestamp *ts;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	int ret;
@@ -702,7 +716,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev = devm_iio_device_alloc(dev, 0);
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
@@ -710,6 +724,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
+	ts = iio_priv(indio_dev);
+	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.accel.odr));
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_accel_info;
@@ -731,14 +748,17 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
+	unsigned int no;
 	const void *accel, *gyro, *timestamp;
 	const int8_t *temp;
 	unsigned int odr;
+	int64_t ts_val;
 	struct inv_icm42600_accel_buffer buffer;
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		/* quit if error or FIFO is empty */
@@ -749,12 +769,18 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel))
 			continue;
 
+		/* update odr */
+		if (odr & INV_ICM42600_SENSOR_ACCEL)
+			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
+							 st->fifo.nb.total, no);
+
 		/* buffer is copied to userspace, zeroing it to avoid any data leak */
 		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-		iio_push_to_buffers(indio_dev, &buffer);
+		ts_val = inv_icm42600_timestamp_pop(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
 	return 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index e58e6f0c5698..99576b2c171f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -13,6 +13,7 @@
 #include <linux/iio/buffer.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_timestamp.h"
 #include "inv_icm42600_buffer.h"
 
 /* FIFO header: 1 byte */
@@ -374,6 +375,7 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
+	struct inv_icm42600_timestamp *ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
@@ -383,9 +385,11 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (indio_dev == st->indio_gyro) {
 		sensor = INV_ICM42600_SENSOR_GYRO;
 		watermark = &st->fifo.watermark.gyro;
+		ts = iio_priv(st->indio_gyro);
 	} else if (indio_dev == st->indio_accel) {
 		sensor = INV_ICM42600_SENSOR_ACCEL;
 		watermark = &st->fifo.watermark.accel;
+		ts = iio_priv(st->indio_accel);
 	} else {
 		return -EINVAL;
 	}
@@ -413,6 +417,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!st->fifo.on)
 		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
 
+	inv_icm42600_timestamp_reset(ts);
+
 out_unlock:
 	mutex_unlock(&st->lock);
 
@@ -498,17 +504,26 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
 int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 {
+	struct inv_icm42600_timestamp *ts;
 	int ret;
 
 	if (st->fifo.nb.total == 0)
 		return 0;
 
+	/* handle gyroscope timestamp and FIFO data parsing */
+	ts = iio_priv(st->indio_gyro);
+	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					 st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
 	}
 
+	/* handle accelerometer timestamp and FIFO data parsing */
+	ts = iio_priv(st->indio_accel);
+	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					 st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -521,8 +536,13 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 				     unsigned int count)
 {
+	struct inv_icm42600_timestamp *ts;
+	int64_t gyro_ts, accel_ts;
 	int ret;
 
+	gyro_ts = iio_get_time_ns(st->indio_gyro);
+	accel_ts = iio_get_time_ns(st->indio_accel);
+
 	ret = inv_icm42600_buffer_fifo_read(st, count);
 	if (ret)
 		return ret;
@@ -531,12 +551,20 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 		return 0;
 
 	if (st->fifo.nb.gyro > 0) {
+		ts = iio_priv(st->indio_gyro);
+		inv_icm42600_timestamp_interrupt(ts, st->fifo.period,
+						 st->fifo.nb.total, st->fifo.nb.gyro,
+						 gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
 	}
 
 	if (st->fifo.nb.accel > 0) {
+		ts = iio_priv(st->indio_accel);
+		inv_icm42600_timestamp_interrupt(ts, st->fifo.period,
+						 st->fifo.nb.total, st->fifo.nb.accel,
+						 accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 9e1f6e65fd45..8bd77185ccb7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -19,6 +19,7 @@
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -412,6 +413,16 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	return inv_icm42600_set_conf(st, hw->conf);
 }
 
+static irqreturn_t inv_icm42600_irq_timestamp(int irq, void *_data)
+{
+	struct inv_icm42600_state *st = _data;
+
+	st->timestamp.gyro = iio_get_time_ns(st->indio_gyro);
+	st->timestamp.accel = iio_get_time_ns(st->indio_accel);
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
 {
 	struct inv_icm42600_state *st = _data;
@@ -495,7 +506,7 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 	if (ret)
 		return ret;
 
-	return devm_request_threaded_irq(dev, irq, NULL,
+	return devm_request_threaded_irq(dev, irq, inv_icm42600_irq_timestamp,
 					 inv_icm42600_irq_handler, irq_type,
 					 "inv_icm42600", st);
 }
@@ -617,6 +628,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 	if (ret)
 		return ret;
 
+	ret = inv_icm42600_timestamp_setup(st);
+	if (ret)
+		return ret;
+
 	ret = inv_icm42600_buffer_init(st);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 3b1f7594b60b..aee7b9ff4bf4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -17,6 +17,7 @@
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -50,6 +51,7 @@ enum inv_icm42600_gyro_scan {
 	INV_ICM42600_GYRO_SCAN_Y,
 	INV_ICM42600_GYRO_SCAN_Z,
 	INV_ICM42600_GYRO_SCAN_TEMP,
+	INV_ICM42600_GYRO_SCAN_TIMESTAMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
@@ -65,15 +67,17 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),
 };
 
 /*
- * IIO buffer data: size must be a power of 2
- * 8 bytes: 6 bytes angular velocity and 2 bytes temperature
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 6 bytes angular velocity, 2 bytes temperature, 8 bytes timestamp
  */
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
 	int16_t temp;
+	int64_t timestamp __aligned(8);
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
@@ -94,6 +98,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -121,6 +126,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -313,9 +319,11 @@ static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
+static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 				       int val, int val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -334,6 +342,11 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
+	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+						iio_buffer_enabled(indio_dev));
+	if (ret)
+		goto out_unlock;
+
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
 	if (ret)
 		goto out_unlock;
@@ -622,7 +635,7 @@ static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_gyro_write_odr(st, val, val2);
+		return inv_icm42600_gyro_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
@@ -705,6 +718,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_timestamp *ts;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	int ret;
@@ -713,7 +727,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev = devm_iio_device_alloc(dev, 0);
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
@@ -721,6 +735,9 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
+	ts = iio_priv(indio_dev);
+	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.gyro.odr));
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_gyro_info;
@@ -742,14 +759,17 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
+	unsigned int no;
 	const void *accel, *gyro, *timestamp;
 	const int8_t *temp;
 	unsigned int odr;
+	int64_t ts_val;
 	struct inv_icm42600_gyro_buffer buffer;
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		/* quit if error or FIFO is empty */
@@ -760,12 +780,18 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 		if (gyro == NULL || !inv_icm42600_fifo_is_data_valid(gyro))
 			continue;
 
+		/* update odr */
+		if (odr & INV_ICM42600_SENSOR_GYRO)
+			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
+							 st->fifo.nb.total, no);
+
 		/* buffer is copied to userspace, zeroing it to avoid any data leak */
 		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-		iio_push_to_buffers(indio_dev, &buffer);
+		ts_val = inv_icm42600_timestamp_pop(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
 	return 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
new file mode 100644
index 000000000000..7f2dc41f807b
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/math64.h>
+
+#include "inv_icm42600.h"
+#include "inv_icm42600_timestamp.h"
+
+/* internal chip period is 32kHz, 31250ns */
+#define INV_ICM42600_TIMESTAMP_PERIOD		31250
+/* allow a jitter of +/- 2% */
+#define INV_ICM42600_TIMESTAMP_JITTER		2
+/* compute min and max periods accepted */
+#define INV_ICM42600_TIMESTAMP_MIN_PERIOD(_p)		\
+	(((_p) * (100 - INV_ICM42600_TIMESTAMP_JITTER)) / 100)
+#define INV_ICM42600_TIMESTAMP_MAX_PERIOD(_p)		\
+	(((_p) * (100 + INV_ICM42600_TIMESTAMP_JITTER)) / 100)
+
+/* Add a new value inside an accumulator and update the estimate value */
+static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
+{
+	uint64_t sum = 0;
+	size_t i;
+
+	acc->values[acc->idx++] = val;
+	if (acc->idx >= ARRAY_SIZE(acc->values))
+		acc->idx = 0;
+
+	/* compute the mean of all stored values, use 0 as empty slot */
+	for (i = 0; i < ARRAY_SIZE(acc->values); ++i) {
+		if (acc->values[i] == 0)
+			break;
+		sum += acc->values[i];
+	}
+
+	acc->val = div_u64(sum, i);
+}
+
+void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
+				 uint32_t period)
+{
+	/* initial odr for sensor after reset is 1kHz */
+	const uint32_t default_period = 1000000;
+
+	/* current multiplier and period values after reset */
+	ts->mult = default_period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->period = default_period;
+	/* new set multiplier is the one from chip initialization */
+	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+
+	/* use theoretical value for chip period */
+	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
+}
+
+int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
+{
+	unsigned int val;
+
+	/* enable timestamp register */
+	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
+	      INV_ICM42600_TMST_CONFIG_TMST_EN;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
+				  INV_ICM42600_TMST_CONFIG_MASK, val);
+}
+
+int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
+				      uint32_t period, bool fifo)
+{
+	/* when FIFO is on, prevent odr change if one is already pending */
+	if (fifo && ts->new_mult != 0)
+		return -EAGAIN;
+
+	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+
+	return 0;
+}
+
+static bool inv_validate_period(uint32_t period, uint32_t mult)
+{
+	const uint32_t chip_period = INV_ICM42600_TIMESTAMP_PERIOD;
+	uint32_t period_min, period_max;
+
+	/* check that period is acceptable */
+	period_min = INV_ICM42600_TIMESTAMP_MIN_PERIOD(chip_period) * mult;
+	period_max = INV_ICM42600_TIMESTAMP_MAX_PERIOD(chip_period) * mult;
+	if (period > period_min && period < period_max)
+		return true;
+	else
+		return false;
+}
+
+static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
+				    uint32_t mult, uint32_t period)
+{
+	uint32_t new_chip_period;
+
+	if (!inv_validate_period(period, mult))
+		return false;
+
+	/* update chip internal period estimation */
+	new_chip_period = period / mult;
+	inv_update_acc(&ts->chip_period, new_chip_period);
+
+	return true;
+}
+
+void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      size_t sensor_nb, int64_t timestamp)
+{
+	struct inv_icm42600_timestamp_interval *it;
+	int64_t delta, interval;
+	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+	uint32_t period = ts->period;
+	int32_t m;
+	bool valid = false;
+
+	if (fifo_nb == 0)
+		return;
+
+	/* update interrupt timestamp and compute chip and sensor periods */
+	it = &ts->it;
+	it->lo = it->up;
+	it->up = timestamp;
+	delta = it->up - it->lo;
+	if (it->lo != 0) {
+		/* compute period: delta time divided by number of samples */
+		period = div_s64(delta, fifo_nb);
+		valid = inv_compute_chip_period(ts, fifo_mult, period);
+		/* update sensor period if chip internal period is updated */
+		if (valid)
+			ts->period = ts->mult * ts->chip_period.val;
+	}
+
+	/* no previous data, compute theoritical value from interrupt */
+	if (ts->timestamp == 0) {
+		/* elapsed time: sensor period * sensor samples number */
+		interval = (int64_t)ts->period * (int64_t)sensor_nb;
+		ts->timestamp = it->up - interval;
+		return;
+	}
+
+	/* if interrupt interval is valid, sync with interrupt timestamp */
+	if (valid) {
+		/* compute measured fifo_period */
+		fifo_period = fifo_mult * ts->chip_period.val;
+		/* delta time between last sample and last interrupt */
+		delta = it->lo - ts->timestamp;
+		/* if there are multiple samples, go back to first one */
+		while (delta >= (fifo_period * 3 / 2))
+			delta -= fifo_period;
+		/* compute maximal adjustment value */
+		m = INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
+		if (delta > m)
+			delta = m;
+		else if (delta < -m)
+			delta = -m;
+		ts->timestamp += delta;
+	}
+}
+
+void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      unsigned int fifo_no)
+{
+	int64_t interval;
+	uint32_t fifo_mult;
+
+	if (ts->new_mult == 0)
+		return;
+
+	/* update to new multiplier and update period */
+	ts->mult = ts->new_mult;
+	ts->new_mult = 0;
+	ts->period = ts->mult * ts->chip_period.val;
+
+	/*
+	 * After ODR change the time interval with the previous sample is
+	 * undertermined (depends when the change occures). So we compute the
+	 * timestamp from the current interrupt using the new FIFO period, the
+	 * total number of samples and the current sample numero.
+	 */
+	if (ts->timestamp != 0) {
+		/* compute measured fifo period */
+		fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+		fifo_period = fifo_mult * ts->chip_period.val;
+		/* computes time interval between interrupt and this sample */
+		interval = (int64_t)(fifo_nb - fifo_no) * (int64_t)fifo_period;
+		ts->timestamp = ts->it.up - interval;
+	}
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
new file mode 100644
index 000000000000..4e4f331d4fe4
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_ICM42600_TIMESTAMP_H_
+#define INV_ICM42600_TIMESTAMP_H_
+
+#include <linux/kernel.h>
+
+struct inv_icm42600_state;
+
+/**
+ * struct inv_icm42600_timestamp_interval - timestamps interval
+ * @lo:	interval lower bound
+ * @up:	interval upper bound
+ */
+struct inv_icm42600_timestamp_interval {
+	int64_t lo;
+	int64_t up;
+};
+
+/**
+ * struct inv_icm42600_timestamp_acc - accumulator for computing an estimation
+ * @val:	current estimation of the value, the mean of all values
+ * @idx:	current index of the next free place in values table
+ * @values:	table of all measured values, use for computing the mean
+ */
+struct inv_icm42600_timestamp_acc {
+	uint32_t val;
+	size_t idx;
+	uint32_t values[32];
+};
+
+/**
+ * struct inv_icm42600_timestamp - timestamp management states
+ * @it:			interrupts interval timestamps
+ * @timestamp:		store last timestamp for computing next data timestamp
+ * @mult:		current internal period multiplier
+ * @new_mult:		new set internal period multiplier (not yet effective)
+ * @period:		measured current period of the sensor
+ * @chip_period:	accumulator for computing internal chip period
+ */
+struct inv_icm42600_timestamp {
+	struct inv_icm42600_timestamp_interval it;
+	int64_t timestamp;
+	uint32_t mult;
+	uint32_t new_mult;
+	uint32_t period;
+	struct inv_icm42600_timestamp_acc chip_period;
+};
+
+void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
+				 uint32_t period);
+
+int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st);
+
+int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
+				      uint32_t period, bool fifo);
+
+void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      size_t sensor_nb, int64_t timestamp);
+
+static inline int64_t
+inv_icm42600_timestamp_pop(struct inv_icm42600_timestamp *ts)
+{
+	ts->timestamp += ts->period;
+	return ts->timestamp;
+}
+
+void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      unsigned int fifo_no);
+
+static inline void
+inv_icm42600_timestamp_reset(struct inv_icm42600_timestamp *ts)
+{
+	const struct inv_icm42600_timestamp_interval interval_init = {0LL, 0LL};
+
+	ts->it = interval_init;
+	ts->timestamp = 0;
+}
+
+#endif
-- 
2.17.1

