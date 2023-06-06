Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A57248E6
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjFFQWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjFFQWo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 12:22:44 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDD10D5
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 09:22:41 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3568m9s8005040;
        Tue, 6 Jun 2023 16:22:21 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2111.outbound.protection.outlook.com [104.47.23.111])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyxvgj55s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtKMVPAjO8fR5CaUowl7TYv/kG2p4zj3Rtidd5NzE51Q40UxQB0e9FXgt1Q1X2FSB1ZBNe7eCy5SCcBxumnQxVn+UCc20mgtX5kQURN54FrD3KYAH+74zDhhozxXSXYA3N49K6K3SPznIDkFgIdNkDH6ipODj7gjxAkg9ycUIQYz7TsJMGLrdRt7gZfP4nSpRyW4QLh8UmT2LPViSdsRmMsIU0ZiVoMkV4kfAcfmhrPVWE73DLQF0i5ikqBbXJwHlQw/pGNTcT2WmW/i2TEZP4Nn6wdP/e/kOCbP3i8jvBq2NtEgs6r/PeQKZA16Iogto2aULsJEIxe+Aq64btCONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5jwordiGFcx8XvzL9GZTFz+sKLUqev6iQpGV3INcA8=;
 b=PLj7c2g17J3Jm+lwwx2qXI4WgsMQAkjOfXMsaTPBXnNwkwWjM1WLvO+CqRuf9KaIW/oU1aMCihDGoNGYRTJ4upokdvvsJ4phIf0+jMHg5pr3IO/sLjELwBDAmrYMZqh3RmC+RZgA3/R2LUkIcXLtLJGd62q2PneG6Y0JlpmbsJBSTK/cSBWhBeSsYITu79vLQBcJNzMgBZpiZX05NGnCSQW02+oWM8aqk5eK8PEteRzPbx40SXTW7GqR3qpJh9NYUM+G+k40j//mI0MMRLzphZhIKCkjLfDHpWrreeYPiBQ7fIi/PMIiXE2DFwyIaZuFW+2BwNyTewasLaohJDYWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5jwordiGFcx8XvzL9GZTFz+sKLUqev6iQpGV3INcA8=;
 b=dODLl3lCDvYLCNzvP8nJF+vEKaRWAHGuKTLppa5MSAPs/R2NB23Fvm5NlR3m4c7EpiD+Ejf3bsuiF85dAga3SZVjwCVhYmDHm2G3XERdB5ZhhaPdLaCHfajDIqHTPdtE+GQTp/bHLUR4li7/Lay0tPRwdBuffsmywM8CUxtGfs/KyO/Ve30yYYS8YiQwIsc6ZKrHi+VCNLMLYnYxv+TFULRFnAe/z6iHcmawak3xA5Uj1fJZmR4dXuxwQptBWKi4yLOzz6UWRQZXVjpyxj7ql1VAWINFDVKLp05Ms+gDUYEi8Ax4WKurPXn0ygezxY4NkJNuXWTi9nBainNIPgj9kw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB2179.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 16:22:18 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:17 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 4/4] iio: imu: inv_mpu6050: use the common inv_sensors timestamp module
Date:   Tue,  6 Jun 2023 16:21:47 +0000
Message-Id: <20230606162147.79667-5-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606162147.79667-1-inv.git-commit@tdk.com>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB2179:EE_
X-MS-Office365-Filtering-Correlation-Id: 637cf58f-59f7-41c9-9814-08db66aa3129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8O/qO2iKfwlW74DMde4if3OZidYTm7XJo4JKPQQHVav3Sfx8ATTNCyXZ0F+UoB8hqpyw3iWZ7ST799UShC5EN7w0L7pl1Vftg7vKP7I5G4phj9e9GxY5rJyTeOkcvFSyCaZwLoiFSHDL2e3JfaeTIMx+VE5I4+PnX2CP4H+iNhERvI+ibVNQGsY+XiP2bOZfOb4AVuLjf86QPq85VhJMKXJqEuu3i+g66Cr0EFpW4qJndYz20v4GH30kFgVgIb1fwa2rcowILqZH8+YBbMn+QJp5J0mJZk0llq4IvXUO0/Wugo37NQr9Q1lVy0BLnu9ZQRZnS9p0E/K9EF23b+FnZjVNJP3gkANltaYCfYomDrU9EG9hasKKPQVGDufFKRz0CT1nHPy/l3/+yC/cb9aCBSj/Y5pYwIvld0Ln7MT3vnKnOfTv+FpyDWhqgO/nvEX1YWsfX09P9Nv1SGeF+7pslWyjKO0gEw/Rd/zuwwQS2Z8ne5rC256KA5BFhtOLyXSFf7c5Q14H5cJ0feTjfSgagplYm3U8EW2ywDafmNTg9wpxhj6TzctDXwGWlqDAgnwY4eFdaDzb1j1owc+JaGE/A9D8N63dNsAzNEOttytynfar0iNEpYodsgO0L8h+G49k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(5660300002)(6666004)(8936002)(8676002)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(2906002)(30864003)(1076003)(26005)(6506007)(6512007)(9686003)(86362001)(186003)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjGtuw32Ujx82h0ekUDvR7XJBEsIwlO/LMK0sqSTOhZY3RsjYtW0RgA168uM?=
 =?us-ascii?Q?jv01x8Y8kS1cR9OkkcXAxBN2Zfq3m+FXFiDeEKpvIRVpKI8ilF4KNy/b4kyc?=
 =?us-ascii?Q?m4o5XCvIWp6b+08USkRT4TrwLw26ja1ACVNt+UJGGTYvS9fed22VBpt3Sp/u?=
 =?us-ascii?Q?H+R0lWXENLV6Q18qr5lk6yDzhkvdFaJB/k/oWxl8Qkp0jsqcHVwYNsgJ+OP0?=
 =?us-ascii?Q?qVHWQN8p9QId91MoQ2EE9tIsDSw/hzQjdZ6BQrig9TBiJYrA7w/1FbT/tOJ2?=
 =?us-ascii?Q?Xcj1qIibQbkaoSM4rIzoI29QUnyd3wpczGEGgpP9dCEmHLWM0P8tkVYw/MFa?=
 =?us-ascii?Q?D5lj7dPLskivgGQ0byPvIXfUIkeBEI114+jFHXpbUzzIusXWnJLPWaHssQ27?=
 =?us-ascii?Q?yUF3BngVKNTOzuMoR+GG4VkH03BiCl5EYKpMoYT2399YBg1rgOnC1q+m1Zis?=
 =?us-ascii?Q?IAF3XIE/NqRy3e+Y/tf1C6zE7cLHqCmZLgWyoqXC4xalfTUraJDg2nF2HGPy?=
 =?us-ascii?Q?CvuCjOOPpBwFVXAP/1mAhgp7Pof0s0kfTgEaigKHAR5WHwiB37a6Rs6WaWuB?=
 =?us-ascii?Q?Wikm/WvpxfLtuR/AK+KFdbFxPXhNycKfijfenlYLZ+0vJXNQuIsUlMKRLywx?=
 =?us-ascii?Q?40lqO3DnHEe8e0IW67WkrRbEFQwpodnKjQr98nk4J6HliwrPVXuXMRJujuji?=
 =?us-ascii?Q?+34DZ9NVWtid6L2kont2JbxPwSqDqQPeQ6LranbEK7DxG2YhaK3CL1OGU/j2?=
 =?us-ascii?Q?npJ9uJFbLMI7eFf1KyJ/TnCQK5LocK+HNof7oid4gyzVnYE5c0qWQShHOxM0?=
 =?us-ascii?Q?8ceMxQsuASc09wkhPE8iQg+lPdC01OlY8HPiONgsz5pjAO0j/45bgsysO3uz?=
 =?us-ascii?Q?bfw1po36EXlYLHihUUBV3l72vLDfEJBgrDQKoTaPBX7gjaYaIqatMisdFuQb?=
 =?us-ascii?Q?lPMUbnUkAKyK3PWUhK+f+55J2WoD3WWs65xBH3Jd4w523Jhz/nWzYAXqH794?=
 =?us-ascii?Q?lXNf1y8Pu8G2h+UqGzD8E88tvUQD+J0wOWzh/pBGD82yMuZFJomlSKPKL3jt?=
 =?us-ascii?Q?VT9ObQX0kwms5PSmhp4csd5qPLg77XvpyTW8pCkRYAfl4uFZhgV+ioKUrZ+u?=
 =?us-ascii?Q?+xEFQg1KP9HfeBamakLw95IaDjXwFGxZyMdghqJehiErqzOztfr6rGnHxJM3?=
 =?us-ascii?Q?+h4V3zoQRvCRVUPMcX4r5jPpAnj8ppEyfEv2hk1VdU0pAyAssH5TzgUm2BaC?=
 =?us-ascii?Q?Wvoev2d/rDtK608woD/DplI7CoiPkH3LQ2YMLPILYYNTHSDZ9lVm+eIy24c7?=
 =?us-ascii?Q?phlQBe6mgOerjPLG3+Uu54TNSeKB6cdaH23cFVTqX81nu1pd+RZ+fB0KXEGV?=
 =?us-ascii?Q?c3RRcEh/FX2bqTpo+p0C52tSHctGNiEBlxQN0QzYKP3YnEP0C2poybRT2IbD?=
 =?us-ascii?Q?CGOz5rxBvLuSWtmhg23QFClybK6rzyXwkU++VsXKk6J7Tgyt43LUNhZMza86?=
 =?us-ascii?Q?VR2vPo6MZCPdkJJC/1wC0QcQuZn6EgyamG9322tWUGDy+6sv3Dk4h3vjV1ZN?=
 =?us-ascii?Q?eItOJUvRLNtjmj3Oi8Gy3DVL8hK2wn/kUfIkcBHz?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637cf58f-59f7-41c9-9814-08db66aa3129
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:22:16.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byc9zzBFcK5RK899gqLo0kWy/lDuzuUlqoqG0C4MSH2wo6fozsHAZAIPj8ga+ulas4Gm7MU8Sbdp/eWWaFTlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Replace timestamping by the new common inv_sensors timestamp
module. The principle behind is the same but the implementation in
the new module is far better providing less jitter and a better
estimation.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig           |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 30 +++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 18 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 83 ++-----------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 +-
 5 files changed, 45 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 64dd73dcc4ba..5f62e4fd475d 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -7,6 +7,7 @@ config INV_MPU6050_IIO
 	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_INV_SENSORS_TIMESTAMP
 
 config INV_MPU6050_I2C
 	tristate "Invensense MPU6050 devices (I2C)"
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 592a6e60b413..13086b569b90 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -12,12 +12,15 @@
 #include <linux/jiffies.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/iio/iio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+
 #include "inv_mpu_iio.h"
 #include "inv_mpu_magn.h"
 
@@ -521,6 +524,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	int result;
 	u8 d;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp_chip timestamp;
 
 	result = inv_mpu6050_set_gyro_fsr(st, st->chip_config.fsr);
 	if (result)
@@ -544,12 +548,12 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	if (result)
 		return result;
 
-	/*
-	 * Internal chip period is 1ms (1kHz).
-	 * Let's use at the beginning the theorical value before measuring
-	 * with interrupt timestamps.
-	 */
-	st->chip_period = NSEC_PER_MSEC;
+	/* clock jitter is +/- 2% */
+	timestamp.clock_period = NSEC_PER_SEC / INV_MPU6050_INTERNAL_FREQ_HZ;
+	timestamp.jitter = 20;
+	timestamp.init_period =
+			NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	inv_sensors_timestamp_init(&st->timestamp, &timestamp);
 
 	/* magn chip init, noop if not present in the chip */
 	result = inv_mpu_magn_probe(st);
@@ -936,6 +940,8 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int fifo_rate;
+	u32 fifo_period;
+	bool fifo_on;
 	u8 d;
 	int result;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -952,12 +958,21 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(fifo_rate);
 	/* compute back the fifo rate to handle truncation cases */
 	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(d);
+	fifo_period = NSEC_PER_SEC / fifo_rate;
 
 	mutex_lock(&st->lock);
 	if (d == st->chip_config.divider) {
 		result = 0;
 		goto fifo_rate_fail_unlock;
 	}
+
+	fifo_on = st->chip_config.accl_fifo_enable ||
+		  st->chip_config.gyro_fifo_enable ||
+		  st->chip_config.magn_fifo_enable;
+	result = inv_sensors_timestamp_update_odr(&st->timestamp, fifo_period, fifo_on);
+	if (result)
+		goto fifo_rate_fail_unlock;
+
 	result = pm_runtime_resume_and_get(pdev);
 	if (result)
 		goto fifo_rate_fail_unlock;
@@ -1785,3 +1800,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_mpu_pmops, IIO_MPU6050) = {
 MODULE_AUTHOR("Invensense Corporation");
 MODULE_DESCRIPTION("Invensense device MPU6050 driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index b4ab2c397d0f..a51d103a57ca 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -9,15 +9,17 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/mutex.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
+#include <linux/platform_data/invensense_mpu6050.h>
 #include <linux/regmap.h>
-#include <linux/iio/sysfs.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/platform_data/invensense_mpu6050.h>
+#include <linux/iio/sysfs.h>
 
 /**
  *  struct inv_mpu6050_reg_map - Notable registers.
@@ -170,9 +172,7 @@ struct inv_mpu6050_hw {
  *  @map		regmap pointer.
  *  @irq		interrupt number.
  *  @irq_mask		the int_pin_cfg mask to configure interrupt type.
- *  @chip_period:	chip internal period estimation (~1kHz).
- *  @it_timestamp:	timestamp from previous interrupt.
- *  @data_timestamp:	timestamp for next data sample.
+ *  @timestamp:		timestamping module
  *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply	I/O voltage regulator for the chip.
  *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
@@ -196,9 +196,7 @@ struct inv_mpu6050_state {
 	int irq;
 	u8 irq_mask;
 	unsigned skip_samples;
-	s64 chip_period;
-	s64 it_timestamp;
-	s64 data_timestamp;
+	struct inv_sensors_timestamp timestamp;
 	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	bool magn_disabled;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 45c37525c2f1..d83f61a99504 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -13,81 +13,10 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/math64.h>
-#include "inv_mpu_iio.h"
-
-/**
- *  inv_mpu6050_update_period() - Update chip internal period estimation
- *
- *  @st:		driver state
- *  @timestamp:		the interrupt timestamp
- *  @nb:		number of data set in the fifo
- *
- *  This function uses interrupt timestamps to estimate the chip period and
- *  to choose the data timestamp to come.
- */
-static void inv_mpu6050_update_period(struct inv_mpu6050_state *st,
-				      s64 timestamp, size_t nb)
-{
-	/* Period boundaries for accepting timestamp */
-	const s64 period_min =
-		(NSEC_PER_MSEC * (100 - INV_MPU6050_TS_PERIOD_JITTER)) / 100;
-	const s64 period_max =
-		(NSEC_PER_MSEC * (100 + INV_MPU6050_TS_PERIOD_JITTER)) / 100;
-	const s32 divider = INV_MPU6050_FREQ_DIVIDER(st);
-	s64 delta, interval;
-	bool use_it_timestamp = false;
-
-	if (st->it_timestamp == 0) {
-		/* not initialized, forced to use it_timestamp */
-		use_it_timestamp = true;
-	} else if (nb == 1) {
-		/*
-		 * Validate the use of it timestamp by checking if interrupt
-		 * has been delayed.
-		 * nb > 1 means interrupt was delayed for more than 1 sample,
-		 * so it's obviously not good.
-		 * Compute the chip period between 2 interrupts for validating.
-		 */
-		delta = div_s64(timestamp - st->it_timestamp, divider);
-		if (delta > period_min && delta < period_max) {
-			/* update chip period and use it timestamp */
-			st->chip_period = (st->chip_period + delta) / 2;
-			use_it_timestamp = true;
-		}
-	}
 
-	if (use_it_timestamp) {
-		/*
-		 * Manage case of multiple samples in the fifo (nb > 1):
-		 * compute timestamp corresponding to the first sample using
-		 * estimated chip period.
-		 */
-		interval = (nb - 1) * st->chip_period * divider;
-		st->data_timestamp = timestamp - interval;
-	}
+#include <linux/iio/common/inv_sensors_timestamp.h>
 
-	/* save it timestamp */
-	st->it_timestamp = timestamp;
-}
-
-/**
- *  inv_mpu6050_get_timestamp() - Return the current data timestamp
- *
- *  @st:		driver state
- *  @return:		current data timestamp
- *
- *  This function returns the current data timestamp and prepares for next one.
- */
-static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
-{
-	s64 ts;
-
-	/* return current data timestamp and increment */
-	ts = st->data_timestamp;
-	st->data_timestamp += st->chip_period * INV_MPU6050_FREQ_DIVIDER(st);
-
-	return ts;
-}
+#include "inv_mpu_iio.h"
 
 static int inv_reset_fifo(struct iio_dev *indio_dev)
 {
@@ -121,6 +50,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	size_t bytes_per_datum;
 	int result;
 	u16 fifo_count;
+	u32 fifo_period;
 	s64 timestamp;
 	int int_status;
 	size_t i, nb;
@@ -177,7 +107,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 
 	/* compute and process all complete datum */
 	nb = fifo_count / bytes_per_datum;
-	inv_mpu6050_update_period(st, pf->timestamp, nb);
+	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
+	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
+	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
 	for (i = 0; i < nb; ++i) {
 		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
 					   st->data, bytes_per_datum);
@@ -188,7 +121,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			st->skip_samples--;
 			continue;
 		}
-		timestamp = inv_mpu6050_get_timestamp(st);
+		timestamp = inv_sensors_timestamp_pop(&st->timestamp);
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 	}
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 882546897255..676704f9151f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -4,6 +4,9 @@
 */
 
 #include <linux/pm_runtime.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
 #include "inv_mpu_iio.h"
 
 static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
@@ -106,7 +109,8 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	int ret;
 
 	if (enable) {
-		st->it_timestamp = 0;
+		/* reset timestamping */
+		inv_sensors_timestamp_reset(&st->timestamp);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
-- 
2.34.1

