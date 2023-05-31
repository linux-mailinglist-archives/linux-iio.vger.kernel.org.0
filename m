Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AF7184E3
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjEaO0c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjEaO0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 10:26:30 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD11136
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 07:26:12 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8wvYm008615;
        Wed, 31 May 2023 14:25:49 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2173.outbound.protection.outlook.com [104.47.23.173])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qub7gu0yx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua2NAy1neA8IWP9sc68zMXw69C/XF5NcJb5bLOe0JIaFZOeam6ib0RXiDg84LGNsVaHgrRSnPhqjZoOolCOOMwGKqt7yuxkq8quec20NsSqWcLqaqCZg2Ic0A4h7S/gIlP5lYetBQp+axmhFPP7i4v4HAQLaoA8/uDNHbxxGVoTRvPESinokjyZQKMLS1KX57RXpR3L5AQqyTNWAZ/UVmLm0p49RhafexdCY4RCn8hr8c1pF69nOXnvyUOf4ilI2mGgQ+nvD6WrXZLqZHsuFl/tQoBuNBCSPYS7I3g6k8DPKmcNuxM0DFGBwNN/+Pfo0OM6o+zYgauuRUnEGfOyc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au83NdEjf9ZHVl7L+rGDAyDho62J04fqx5rPo91TNnY=;
 b=FL8iD11ACRPHZytJZ/FuH+kJ+NGFBfZXFB7JM08TwPfRv8He4vL37cukLpYTFiyvPFn3f/Wn/AuqXravIx9l1gkR7KqbV6E/pSSXGftJqurS+L+x3W7Frbdir8E/33OVTiem89IusiI6Wiav7Lt86gAWagsvhbKb2P+l523tk+jrg0YgzXiGc7cl/OnCLVOLlDCACR+9fIs+2m8hvfeNTaJMzHD+c3vXGSk9gj2wle2e8QaYHGN/1pQpSQ2degFLbHevyZiCF7UlfQQjIX8Mob/kvNfoF4sIMVW8nSjzZoJSzWS/Tf05HzDXZoU37ULSLScRioHU4a7FAsF5mKwU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au83NdEjf9ZHVl7L+rGDAyDho62J04fqx5rPo91TNnY=;
 b=GQccO2GUHyWs1qg7Pr21i5ML6jTMKAiNdi7KLedM9hryoF6eO2E5o3Yoka7DXP25eTiB+GVykDDXO8x/FYi9Qb4rM+Wigx/rQvS+UPYJrIzFJpF30+fQGeQ2kR3kySzdmp1wf9zIQiATOFZixFQzVLYrLgsGYIkMGZ7c/qvBbHr4ZKupga+Hq/6MQ5ptYfYGkKkBgKIEl8WQW/BnTgrwjaBthuD53PshgN9h0y4T2w9RchtiZWoCbRWSKKuTlmFpuChoXINbCPS7NarPU1TLtHky717zFkoOPizdKWiQ+WxPzBpM9NN2sUkWyfFsyUFzijpRxUbX9N7/EI5GomXjdQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB3226.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:25:47 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:25:47 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors timestamp module
Date:   Wed, 31 May 2023 14:25:13 +0000
Message-Id: <20230531142513.48507-5-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531142513.48507-1-inv.git-commit@tdk.com>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcc9a1b-c87f-4d26-8b06-08db61e2ed31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TX9hc7gpr7EC++z/cvQmY/qp4JzRq5MCxP12+9/Xct5BID7egYck6NI6vTqnfsLzOQ16XQtkAUqh4T6Pd7P0AN5f+m1/MkNuINiJMjPErxryFh9PivbRSps5/LQWMaHhKYevIlTvbPXIEq7zcJe9YJGDQfNmp0lvePXJ1/P47VyZGPpLKSVDIDnpRfhH55XEH7IHLmHB+ADub1SPaGBWT2IL/Y4SmJIat/DjwPM0rGHYUWIBQvl1U2Iry78wZy0jBZKk9N9GeNKLgHLEIbw/7L62PTeuB3WMLuKiHOYWtelFBLCDMC6Q7UhbWT1Fqmx8yIe37Wbqxmt0FvITNbPQViybttO3twXwMXWuB/fxOqh8EaFYXmH95L1tfroNC+v54VDDtoFABa277JSxw7drAAhWfdo9TxRpvxx6Ogs56t4O6OPHQpMMZtGAj3YQNZ5hlkPu/Po1L1hQSNuBdWUPq1ETK7xvFucxiG24Qoi2DOQVBobUzwXy7epj2JfziePKLCsUoMroEcYcv8LTuug6M3gHuGVhs337IhNWsXdnQEi5YIqOlPieibnWD/D0OqpIigN6DR0U6HjJsoOLltI1MH7OJeplK36EGPbo5u47DjJ3yJS29Kr3lFF3xtAN7ENW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(2616005)(2906002)(186003)(83380400001)(36756003)(38100700002)(38350700002)(8936002)(8676002)(41300700001)(86362001)(478600001)(4326008)(66556008)(66476007)(66946007)(5660300002)(6486002)(52116002)(6666004)(316002)(6512007)(9686003)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8zdhlRqffR3NuYcp5ZUrLit/kjaUen0dwwKK1K6wk4HXnt2972SXVYA/IFT?=
 =?us-ascii?Q?JHgKac4hmjm+QfdVuw9I0EZQoEqO3kHf1uvRvJ0v1QETrc3JtkF08ztd5IjN?=
 =?us-ascii?Q?vRa+v6+6St8BuaHPJoyyfNtf8Rss39HJwc5PqYuawfg7bUaC0EsqatByRB+w?=
 =?us-ascii?Q?xnkUsYDUcx+kwmucUHcnT2u+U9Y9Guy2B6MRtvbnhcAYEL6unUQNsTSYsgdJ?=
 =?us-ascii?Q?TiEUKL4V4nhH20/WmPeBzHok6AMDIaLIMLYhf3hoWMGKK086YC6pM4XDCy75?=
 =?us-ascii?Q?ypNnbCsDq8xexZ7gT0+Lbj9KU2YUS17LAL6R7Onb2Ggn8GYqxmk2WT/IggwF?=
 =?us-ascii?Q?GGRORRhz1G5EkxJWnIZUfkKd8gJpsvgvMtKqIm1y+ySYvhqzJFXDDTO8+5tN?=
 =?us-ascii?Q?JHU9lauFCNJHUZgIipYmH6VSXOVuGzrHglt7EyZM56dr1sLAupKPkqbH+kk/?=
 =?us-ascii?Q?YJp5/YRjHR0MzsJQ5Dx4/lbbLBXJci/n2YOoJDHabbEDingyaFjYXa9j3wj0?=
 =?us-ascii?Q?IhrCU08e0nWVuV10ZWsaQHCayX3zr+a5ZMXveMf6y4MTJTC1mkUxDFPDJgF2?=
 =?us-ascii?Q?ts3OqV9MqixotYmQblnPqg3gmbNt1/tsplM55i8safxy1VwGfuFVOHxo4trJ?=
 =?us-ascii?Q?TZ72TUyq2sQtt4QWe6IhXWb/UCeOLpZKReFWlasxudOc/bFNJ76+Y4JCUAf4?=
 =?us-ascii?Q?QisrJECcn3Ks7jz2WcMhcv/Qj1bQY+JxaPzSfXc6JZZWg68QX9OzCrmfeUW+?=
 =?us-ascii?Q?Ea8Z2BTtiQrEe9TASSmic7vUVNyTkjEDnNFT0BVbMBOEdD5zD0x6jqxmC/Fn?=
 =?us-ascii?Q?u+ZsENWVQSbgsH5PmD8dOQj3X4gwDr2KWuKdxUA+qHKyT2fcGkHTJ6Ea9TXk?=
 =?us-ascii?Q?PzOpXNlvA+Wk/Jl2lrTRt8V0m8es0k3AXS7VLx9rg/vh5ISVGTyq3T96iVX7?=
 =?us-ascii?Q?XWKpUyMt2Z5eVeUasXg3RyBBzFJ4r3EeEGB3oo3BC0gt6AlmXQhjM4stXLxb?=
 =?us-ascii?Q?jmZaY0QrXuFNxKYC+svwq3zve/0lxMPRhYo2mzyT7SGBcXCRrGiU/xMH3WQF?=
 =?us-ascii?Q?GtfboWAaiFRfVG/psV/rGQEgwpDkjyUw5oWGuXJRICYzrcq5xpUNBsU3PFoD?=
 =?us-ascii?Q?/puCm5q2ibxlAUJI6bIRG0KmwtbiNxROYjXtmk+6vAIgdbsFo7NDPohnj77n?=
 =?us-ascii?Q?37oKOhb5DEjKNadclFS5otntwwBb5ai3jJwv2U7W1WwBoYlqxzvJeaF6KbtE?=
 =?us-ascii?Q?hla1vDvH1CvDW/15pXE+XLm93mltDA3tCiqjQtReYOqzAvqumQ1EsVmi3EaN?=
 =?us-ascii?Q?UE5WsrRbgZTzo5KqVeU7OeGHmDfHkgmd7UnVaok4PYwUh7V8zqILk0JrfhcU?=
 =?us-ascii?Q?g7CNjYB+KP+gn7BtgVTonk4tZ1W0cay0OmPRh0/BUiAp2374GRbLsOW7ibXq?=
 =?us-ascii?Q?FXsTzobrdtISKpFYOXXC1QcM3iWOoxSjnQfY41dLCw3efXgFyTsOfj2bHpD6?=
 =?us-ascii?Q?3+xpIqr6MPW3nbGqnkckwsnq4soqMYRwUaeNj341EQgQ1ZLHR3kAvrZXCyv7?=
 =?us-ascii?Q?tlzn90NoDNofumZQi5QjtMhD4KvUmMrRlMplx4rW?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc9a1b-c87f-4d26-8b06-08db61e2ed31
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:25:47.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3nut+RVRkrccWc1T8jDBmfFtjTHa4wEU3ORYfoEQigsCDuutx0sv9WPhTxuKpBUmAEPRl/CJc3tjMyaCh7jEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_09,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Replace timestamping by the new common inv_sensors timestamp
module.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig           |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 26 ++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  9 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 83 ++-----------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  3 +-
 5 files changed, 33 insertions(+), 89 deletions(-)

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
index 592a6e60b413..022bc314f4a8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -521,6 +522,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	int result;
 	u8 d;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp_chip timestamp;
 
 	result = inv_mpu6050_set_gyro_fsr(st, st->chip_config.fsr);
 	if (result)
@@ -544,12 +546,12 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
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
@@ -936,6 +938,8 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int fifo_rate;
+	u32 fifo_period;
+	bool fifo_on;
 	u8 d;
 	int result;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -952,12 +956,21 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
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
@@ -1785,3 +1798,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_mpu_pmops, IIO_MPU6050) = {
 MODULE_AUTHOR("Invensense Corporation");
 MODULE_DESCRIPTION("Invensense device MPU6050 driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index b4ab2c397d0f..1dc2d4e451a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/regmap.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/kfifo_buf.h>
@@ -170,9 +171,7 @@ struct inv_mpu6050_hw {
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
@@ -196,9 +195,7 @@ struct inv_mpu6050_state {
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
index 45c37525c2f1..6a6cee0f535b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -13,82 +13,9 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/math64.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include "inv_mpu_iio.h"
 
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
-
-	if (use_it_timestamp) {
-		/*
-		 * Manage case of multiple samples in the fifo (nb > 1):
-		 * compute timestamp corresponding to the first sample using
-		 * estimated chip period.
-		 */
-		interval = (nb - 1) * st->chip_period * divider;
-		st->data_timestamp = timestamp - interval;
-	}
-
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
-
 static int inv_reset_fifo(struct iio_dev *indio_dev)
 {
 	int result;
@@ -121,6 +48,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	size_t bytes_per_datum;
 	int result;
 	u16 fifo_count;
+	u32 fifo_period;
 	s64 timestamp;
 	int int_status;
 	size_t i, nb;
@@ -177,7 +105,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 
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
@@ -188,7 +119,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			st->skip_samples--;
 			continue;
 		}
-		timestamp = inv_mpu6050_get_timestamp(st);
+		timestamp = inv_sensors_timestamp_pop(&st->timestamp);
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 	}
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 882546897255..c26bb9988d7a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -106,7 +106,8 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
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

