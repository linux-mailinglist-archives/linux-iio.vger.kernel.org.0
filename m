Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A921F20E7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFHUox (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:44:53 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:11448 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbgFHUoP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:15 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KhpKM027834;
        Mon, 8 Jun 2020 13:44:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=U+WfKlX1pBEqEAzxwFCaXsG1vKYByv7xxbFBhsyUowo=;
 b=RmO1gGnOeSPQd5nYZOts78a+Oc0x7S4B9xvQxBIr7fuzfEl3qRu7Kfbe5+IBmHvMp3HX
 EMxnx96cgerpbhijXwOl2gcSpREsF9KLu7zBOX9TnG0xYTbDybdmqijR64ueV34LKp+v
 Y2iq2OfNl2ERi7wfTilN1ITyg6eM42zZf/MTWj1UMN86qgee9czQdciz+sAE+B6876aT
 baWy04nC0EB9dUpU6dk13Z38LYJOjAZex/4lYRzIXiGwqMU82q/BRypqpnwkCUsGXWi7
 jG7kXc7E4IoG9A+beWcsrgvdzzyOqF8fWqHktVkUsjHitMFlt1+7DkZlFy+VbjSyBpmE vA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhGTHtA9TYq5PDv0ngBehS729Nacd6SXdj8FoJTTuvAn51hO+yibxA+SXJR38XkP3ZouibvYiRdgsHsTPsuab7EUTKjxewLDcq5Hcf1Ote98qnYuDHAQ5Zl49xsGfxDIjXR8glHdPrJXuc9jjbhhQUaF+CLppYpdAiBXJhbhhV3SUlC0EnydRMnhFGCGKRUL82WyxATnwqjFnC535P3Spo6fdoaMj/nELNqbJT6ZGcKKKnavyZ+9tRqQ8cF/pvOpnZJpXUeCF/N7EfP77SbS/iRUt7FhIBxDr9jvgitMp5irlSeFjiX/ptuatFZswyeFZMqRa58JF3L/X8SK3/sJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+WfKlX1pBEqEAzxwFCaXsG1vKYByv7xxbFBhsyUowo=;
 b=fvjG+N5Q6mLzMUqZ5cSopeNrHhtgmeoVVkw5vBtgZNbqvMcfTbd8qe3Lf4N6C3IgWhrF5kHkfXh9D1YnhZwYsJ1J9KW5bQdqhRHNdqkWbBzHHnFOclLMaBidU3Xz9NeCFot53A1IZQ0SW6gcrxZz8cgE0Tw4BZ1uFEZJSliqAZIXPI3wD70wQTAxVduU4AuFhMfOWWxtoJqd07H6q8O45m4uk7QTgj3NE/dXQISpoOttpnilX8w4r5wVrJy9m+Tjmx4JNWJ2LEekOsf7sfJVfE/CRzFDMrtwNzEccOA6h6HAKFWXSssV+PBJWCX45sPMlXZ8kXrqAVDN+k0KqrPVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+WfKlX1pBEqEAzxwFCaXsG1vKYByv7xxbFBhsyUowo=;
 b=NKe4PBqUiMwDVacjTMMBvsYFViuiMn3Aq6hBGgBvPOLinOasha2ut9lZNcC/vLGCuiF6NPTwmTmH3iGOQz/jQiqHpUx4ep9MWwS31BofxMGXOGkrqaPXkqOLsOdONSmTspY6sYyUunC1DF1iu9Vd0kJWJRDx3rIEd22L/tZt/8Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:44:07 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:07 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 11/13] iio: imu: inv_icm42600: add accurate timestamping
Date:   Mon,  8 Jun 2020 22:42:48 +0200
Message-Id: <20200608204250.3291-12-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:44:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a017edb-d0bd-4915-1f78-08d80becb09b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395125037113590CFBD91C94C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUeNebeEQT3Loymc9jeHgDSHzk+8JQZRBOKOo19IDJA6pysWEKdemQXsIbUVwWs/WoZa/C03QF+raBuPaYXnlibbeC65OVjr/RrdX5vWsGHGXpoDzltE+hjAobkypS2m+AWLLLYRshOnGSJRP9jQ9+QmC7e9yHcNvEDTVCM3HSa8/H+85mOiqmG1fJX4YogtCTZvy5Jbo6/gNn0RpCJ9GlR0UvmZuY9xRFdJOYqP7FVJLko1qpWuBHgSQj3ewZ0+JpbV1aL+wr1BXQGSSFAve7mqsbpc2aRQPwj/SrSAfvMu9x6JUO0D7zXpgXB6ki8PaCoLUgRRhdZuw1ASmkYysg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(30864003)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TJOFcz/XftS14yuHIxrpWQGVbUX7RvhW5oXCvR4n5fVAmN/mtpSK9dBq+6kXPWy4Jrl14DvaMG3GnnaIW76snGJHN9EXQX44RgoYXJcD/J53Wp5UWtkdQR1sX7lBStytELECzkViJfTQKtJT/H4iupCOQ0Qdmx23C3qPOQjZ4OLpiXI+Ub/w7cRrGY0y6pwRfn9PDpAoMQ+z3f8+iRKtf1TTlymRvavVOXEcQLT3fkPg71PzjQniG3CRkQuP6tca9zj+vWjumSv1L6lefmhR8ARKctR9IPW0N46z1lq6zJrJgYPD+F0KWV/Yl4RlIs07DOqkyqXGXJqQWqLGmYP421WPAchBvRhJCUzm11ymgObd5hiIip2WbXTYEj2Sl1FOE80ksFTszU5VMi447vIlrWl7SrLWJLCVl7K4Xfr09BvydYJle4U4TkJunCL9TbrGCRLQcLEAayLlERvf8g7TzoWhVQFZ46zC2Rl0bZ1QjMI=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a017edb-d0bd-4915-1f78-08d80becb09b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:07.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1TXhiewLxI7Ba5WRE8yEou3IciEaj8rjoiZkIegENbmtbYts+LvswJySKSNdOowZPSkXjB1KgBJQ6puiaS4VeUD+VKh0B1a2TSs0o8Ckvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=2 priorityscore=1501
 malwarescore=0 clxscore=1015 cotscore=-2147483648 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
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
index 77cdad99de91..e51e15029116 100644
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
@@ -65,16 +67,18 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
 };
 
 /*
- * IIO buffer data: size must be a power of 2
- * 8 bytes: 7 bytes data (accel 6 + temp 1) + 1 byte padding
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 7 bytes data (accel 6 + temp 1) + 1 byte padding + 8 bytes timestamp
  */
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int8_t temp;
 	uint8_t padding;
+	int64_t timestamp __aligned(8);
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
@@ -95,6 +99,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -122,6 +127,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -302,9 +308,11 @@ static int inv_icm42600_accel_read_odr(struct inv_icm42600_state *st,
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
@@ -323,6 +331,11 @@ static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
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
@@ -612,7 +625,7 @@ static int inv_icm42600_accel_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_accel_write_odr(st, val, val2);
+		return inv_icm42600_accel_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
@@ -695,6 +708,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_timestamp *ts;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	int ret;
@@ -703,7 +717,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev = devm_iio_device_alloc(dev, 0);
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
@@ -711,6 +725,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
+	ts = iio_priv(indio_dev);
+	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.accel.odr));
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_accel_info;
@@ -732,17 +749,20 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
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
 	/* buffer is copied to userspace, set padding to 0 to avoid data leak */
 	struct inv_icm42600_accel_buffer buffer = {
 		.padding = 0,
 	};
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		/* quit if error or FIFO is empty */
@@ -753,10 +773,16 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel))
 			continue;
 
+		/* update odr */
+		if (odr & INV_ICM42600_SENSOR_ACCEL)
+			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
+							 st->fifo.nb.total, no);
+
 		/* fill and push data buffer */
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		buffer.temp = temp ? *temp : 0;
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
index d53c604ae1de..1924b0b528df 100644
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
@@ -65,16 +67,18 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),
 };
 
 /*
- * IIO buffer data: size must be a power of 2
- * 8 bytes: 7 bytes data (gyro 6 + temp 1) + 1 byte padding
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 7 bytes data (gyro 6 + temp 1) + 1 byte padding + 8 bytes timestamp
  */
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
 	int8_t temp;
 	uint8_t padding;
+	int64_t timestamp __aligned(8);
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
@@ -95,6 +99,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -122,6 +127,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -314,9 +320,11 @@ static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,
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
@@ -335,6 +343,11 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
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
@@ -623,7 +636,7 @@ static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_gyro_write_odr(st, val, val2);
+		return inv_icm42600_gyro_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
@@ -706,6 +719,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_timestamp *ts;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	int ret;
@@ -714,7 +728,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev = devm_iio_device_alloc(dev, 0);
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
@@ -722,6 +736,9 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
+	ts = iio_priv(indio_dev);
+	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.gyro.odr));
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_gyro_info;
@@ -743,17 +760,20 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
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
 	/* buffer is copied to userspace, set padding to 0 to avoid data leak */
 	struct inv_icm42600_gyro_buffer buffer = {
 		.padding = 0,
 	};
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		/* quit if error or FIFO is empty */
@@ -764,10 +784,16 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 		if (gyro == NULL || !inv_icm42600_fifo_is_data_valid(gyro))
 			continue;
 
+		/* update odr */
+		if (odr & INV_ICM42600_SENSOR_GYRO)
+			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
+							 st->fifo.nb.total, no);
+
 		/* fill and push data buffer */
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		buffer.temp = temp ? *temp : 0;
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

