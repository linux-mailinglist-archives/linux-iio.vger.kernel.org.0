Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916191E4D9E
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgE0S6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:16 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:18356 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387505AbgE0S6M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:58:12 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIw4r2009036;
        Wed, 27 May 2020 11:58:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=adTOVxfFk239g0IguKBJRwJ3v1k5cthu91P2HPJKIcs=;
 b=ddM37bsA5oy+7Jv8cywHPhVXQzif0vrKwEnygjz0nhJh0SaGN5sow7FVax2IAAqv+SvX
 EbZ17aFhFX6m6uQ/I/+A10bFzabPBzChMdUpqJYaxARl4C+2eH4UR2zSDEONlyCj1N5T
 sF5kw+M4pPIACVKFeSJhmd7do1s2MbBNtnSNzK7MCCAYBKAkJTGCpsoi2MC1N+sWX4rI
 NiMkfoXg1UgfCrw/d39X4vASZyyuYIkdwGTeUNSAIC/R0Mn65YPLoQ/Ro58V/SdTbJ6U
 89PNZ/6h0j/+Vcu3l/RCjshm642w9moMOCdExoztCv7oioutux/Aaby8tTZiIv4Ek+sM 4Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ewx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er+RSAZJ6zmEDcAJChn2dlAUz9IVcxWWdKG6TjI5AmDp4jtPJTt2qZc/CHCsnUhwFvJIbIxSwbaUaaxo2F5VNnQ+5QTqVdCimgcAyMhJIODdXUfpOHVv5ANHWMoWTFG1mBZBfZENqwiiL3ODQ+nEA8J/QBQ9biv/MPPqytxao7lk8OIrgZo/H8kH5EbKaJCcvv6SWFStyXDqKndr82HC2kv2QiMDOzbOQQwDtTdSGKjwQcIttVJC8z4WkaDfa0btuALQhGpeF6PCot7GZouxqvsNNm+X2jk8O1We+m2xZXgW3UsBCOBhH11cgnYB3SN4WBvNfmtRQm6ZCcvH1JpqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adTOVxfFk239g0IguKBJRwJ3v1k5cthu91P2HPJKIcs=;
 b=MqAV1SJjy+zJfmBwSVuw7E36RuKsHg/QbxChg3ezmOOEcpgbOsAn3HWRec33KfjoSoXgPRKxtTOrath7c/NBdgfJJ2QRbXuTP+EWzyW6LSXg6GoVQOVfRiL77YI0/XcykqLh7pohe0UOO0Bl4gh5KZW0Kd3SvJ/buqlwTuYhTd8dO27La7fIU7MvNt7pRVrEjEoGGKGPQQyAxDdjdJNdnPU4vDUOrqhcORQVjKkPdXfGvl3TnAyJqR1Iu6Mxkpw5yUqeIkI4bl2rJafkS/dAxPRnP9qj4mp7KGFbHffeBzS/ThJ9hjzhM99/IFc6v3Oax3wszun3r+CHeDTH6ryPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adTOVxfFk239g0IguKBJRwJ3v1k5cthu91P2HPJKIcs=;
 b=XmNol9kLnUJ3HKbC7sjFKgsYUrZkfBnLhckQUkcrX8PBlBjT1A+YgS/pA3CYnwkfTUIvk2IkhPfPzeBCW9go4OzX6f6FjaL31c4F0w3frD6zxjFYVdM++k9h/b8U8PnbgJH3qFNLwChb44ZslqJXSpvd78PnPyUGvRCNr6MurMI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:57:56 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:56 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 10/12] iio: imu: inv_icm42600: add accurate timestamping
Date:   Wed, 27 May 2020 20:57:09 +0200
Message-Id: <20200527185711.21331-11-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f21f344-f43d-482a-c053-08d8026fde04
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31510FBFE138D0EF96959C76C4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpkWM2VoMndUqaSCsfL9V0+//VtxZH/pv7AbZkAsZRUQv+no9y6zh65y+S1Jj9Hf7ml7+qH1ADgFAex9xx9bkq4eZAVwujZIUCW+4UeJcHXE/Dz5aOoiNCbCdEhGLTm8Z1D9HQRfg0/lSBf8RXuEe2jTc/Rvjzb+k+2mXbC94wxr6CQOXDTTyhxyeWr8eNjmi1Gfjez4tKVjmZKdSV8oFgF0QgXbxWwBz1bE5hQhLGpZFhfow2IPFeLeObV8N1TBKDUm9/KGPOQCLNtirCbKeiI3hVz4GzXYs+OTnDbVjKGAEYe6NOqCuoGikT00Z8WzrAvfLCYFvPD1QRB58IEn/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(6666004)(6486002)(30864003)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iStrqtjSoJlWWKGSiSXmCvP8aD9rlmdRqLEhm0/VvHA1rU8gmR6Q/KR6tZwch0GCNjNqGmWQtYUY0O4vb062IC+uLZ+feYsxR7tjnowcdoAlUGfolthDwadezOJZ1PGc1EZpU5dKfDOhDX7MnhBlZ/M0rSB8uXYPknwiZ948KT/Tb0/LPIG7PgAXyp/TV3fbGf+LoRN1TytSc1WktET/BbuVRCSTO2jGoMX3LDvGzNgV28HivjadQDLCIP3SsPVmsF6Ic23HQXJDtwNkpRYiV//Yb85QWuZH7IeeMDLZniFT75L/VWRaseov3c+onqb7OMHT2yyHRKNWbfqWEqRQ5oHeo84cZwUGaJHGg7MpbDXFIzYfhuwmiFMIivdaZKQlPN0btfgIEnvwRmmDJqbPiceuFPNdHlv+sBf7Qlny4dKo0fFL8RiggNkqjAX6XrPmOR4jSQFBeIUm+VBfowxPyQ8fPj1oOHvdOMulyBWHwlM=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f21f344-f43d-482a-c053-08d8026fde04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:56.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o07b0JbMfn0Gg6XMc6z8RhLeKWdOlb5KonOkBFJZr1pVs2CZ8/03rvQGWl47aEHbtNzZm6hoiZrw7xhJhLG6BqwbpbLWV+hUygQ9Owr+KPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=2 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270145
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
 8 files changed, 398 insertions(+), 13 deletions(-)
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
index 4d5811562a61..2de0dd7675fb 100644
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
index c73ce204efc6..ec1d124c1471 100644
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
@@ -65,13 +67,15 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
 };
 
-/* IIO buffer data: 8 bytes */
+/* IIO buffer data: 16 bytes */
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int8_t temp;
 	uint8_t padding;
+	int64_t timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
@@ -92,6 +96,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -119,6 +124,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -299,9 +305,11 @@ static int inv_icm42600_accel_read_odr(struct inv_icm42600_state *st,
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
@@ -320,6 +328,11 @@ static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
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
@@ -609,7 +622,7 @@ static int inv_icm42600_accel_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_accel_write_odr(st, val, val2);
+		return inv_icm42600_accel_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
@@ -692,6 +705,8 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_timestamp *ts;
+	uint32_t period;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 
@@ -699,7 +714,7 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!name)
 		return -ENOMEM;
 
-	indio_dev = devm_iio_device_alloc(dev, 0);
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -707,6 +722,10 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return -ENOMEM;
 
+	ts = iio_priv(indio_dev);
+	period = inv_icm42600_odr_to_period(st->conf.accel.odr);
+	inv_icm42600_timestamp_init(ts, period);
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
@@ -726,16 +745,19 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
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
 	struct inv_icm42600_accel_buffer buffer = {
 		.padding = 0,
 	};
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		/* quit if error or FIFO is empty */
@@ -746,10 +768,16 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
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
index c91075f62231..3c8b1b19de15 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -14,6 +14,7 @@
 #include <linux/iio/buffer.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_timestamp.h"
 #include "inv_icm42600_buffer.h"
 
 /* FIFO header: 1 byte */
@@ -356,6 +357,7 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
+	struct inv_icm42600_timestamp *ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
@@ -365,9 +367,11 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
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
@@ -395,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!st->fifo.on)
 		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
 
+	inv_icm42600_timestamp_reset(ts);
+
 out_unlock:
 	mutex_unlock(&st->lock);
 
@@ -480,17 +486,26 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
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
@@ -503,8 +518,13 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
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
@@ -513,12 +533,20 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
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
index 6f1c1eb83953..c0d676219fc7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -19,6 +19,7 @@
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -413,6 +414,16 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
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
@@ -493,7 +504,7 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 	if (ret)
 		return ret;
 
-	return devm_request_threaded_irq(dev, irq, NULL,
+	return devm_request_threaded_irq(dev, irq, inv_icm42600_irq_timestamp,
 					 inv_icm42600_irq_handler, irq_type,
 					 "inv_icm42600", st);
 }
@@ -613,6 +624,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
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
index b05c33876b8d..76d92a550278 100644
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
@@ -65,13 +67,15 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),
 };
 
-/* IIO buffer data: 8 bytes */
+/* IIO buffer data: 16 bytes */
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
 	int8_t temp;
 	uint8_t padding;
+	int64_t timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
@@ -92,6 +96,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -119,6 +124,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -311,9 +317,11 @@ static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,
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
@@ -332,6 +340,11 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
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
@@ -620,7 +633,7 @@ static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_gyro_write_odr(st, val, val2);
+		return inv_icm42600_gyro_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
@@ -703,6 +716,8 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_timestamp *ts;
+	uint32_t period;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 
@@ -710,7 +725,7 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!name)
 		return -ENOMEM;
 
-	indio_dev = devm_iio_device_alloc(dev, 0);
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -718,6 +733,10 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return -ENOMEM;
 
+	ts = iio_priv(indio_dev);
+	period = inv_icm42600_odr_to_period(st->conf.gyro.odr);
+	inv_icm42600_timestamp_init(ts, period);
+
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
@@ -737,16 +756,19 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
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
 	struct inv_icm42600_gyro_buffer buffer = {
 		.padding = 0,
 	};
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		/* quit if error or FIFO is empty */
@@ -757,10 +779,16 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
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

