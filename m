Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489E4194FF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhI0NX5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 09:23:57 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:54460
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234424AbhI0NX4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 09:23:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVXPNqdcckHt97WRRyD1x6MKs5DJos4Ms51ysOTqMdvC8yTOwh6/LCzgIbUjk1k6siugAP5yq0riumJCHCGDRbEys6V31DsrLceV2xO4l+xXhxzd7QZRIKHFL1ZIHkzDbJeTcZD0fQXhbTWHlR3mxOAas5qJ5/tZqT5P2JD20FdE54Tj09JFOf0X+FSgcaQ/FpQ5axvQafCQ+n0gD6ET99S0CAzNa9K3VfNx5E9l2lEgV1FauqeMty3apHK6Xj7dmKKfC4gr70ikHXCkJHwgUr+VYJHYSsR5CvA7zEFpbyhOfEJboYpEot0YC6BnUqEThDcgmQrBNpq7T+UH1qoPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Brlje/0FJwoJFZt+uMmejKRMFq+eWT/UqTQRzfgVDiA=;
 b=ayBO7EAtjOSasDsKgVRvsPLoleb7CQt4J0iGSaJ6h1lyiJTG70+iFUmvnMsMhlwZveDdmO8GddmNB28MaN29surTGgDsIN+HziKTDHes9Z/XfbYC+YyNkjqXKIfBq+Ioj6bZ64U+b9jJoDq6CCN5vTiYTIJ8ZmXDZ5+MVpILtkyWgib1+7MhaLU3wd97YOVKCLAIS7OwAA0wZaYifovElPZ2ywg3JBPjRSZtTy7cYe0imzavMARKuPLpib0mfGrboPzX47O7LeShKI7XRGCLPSRiKa2vhb9bTOcSpIWhMmO6SstlB74p3885EzU0E3IPWLzVci5tuClefAklEwLDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brlje/0FJwoJFZt+uMmejKRMFq+eWT/UqTQRzfgVDiA=;
 b=WV2V9uIoWi3aRb9Pc32ArCxqAYqE8eQ4TAymrIdxIXIk3QDYZ9WHnhA6W7bAlaJ5/SXaDtzQdkx6DEiE+g7MD7yoUT0z1pa2mQPQZAFa3FVgNdNpEgKDQ59cYEw4INdz6V7856OsEdZMin/QGnTuJHcKdToj9OVeushLEVsgAPI=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v2 1/1] iio/scmi: Add reading "raw" attribute.
Date:   Mon, 27 Sep 2021 16:22:02 +0300
Message-Id: <20210927132202.17335-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
References: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::24) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bc57a2-4c2b-467e-f977-08d981b9d336
X-MS-TrafficTypeDiagnostic: AM7PR04MB6950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB695056DF45035CB41196C233E6A79@AM7PR04MB6950.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FutX4uyo7p8Nm2obUp8IKrytEl1pD8fB1b+PKFR7V9Crqb+RfJCTKsYpihlTCU70jinCCeKF8TBHjV2CKwSU+pG/pqF0mPgTLzYluJ0iS+3iYT2D5iyBg85CnAlF1RlqFipPhkKT1urOYIZ+b3Wm1HDJuyJD/+k/OjqRm3xhWnLVwma0f3z0DPxtOXlwaRFWy9tRovK9TI1wDxySR5XTxY5djQR76q/OnkcLtoJhmrW3oz/00qVr028vgYYxm7TKriLw+/YfPq1elFIGeWkKQOyiBSqz7oDwUCL8ZbdNFN356ttR0mT/Ut+W3L1KO6hz7cXo3xlqGg1OZCHJiO1h1xXkL75MdWQ5janglxiuAW1RH/zr7ecaGOflCH7a83LNbeSlp/xgS57SxxapUUJqmYgesbI/3nqX8G4/1W6SpbtQvAh0alP+GSQU8pCANQZnxb/RYIfwDBNhuDWLpoQQNlLIRydPhlGbOJbjSpzRmQkRrSj+QHoFJPjt85vkFjsZOhk0666mmpquNsf8M8C4MDjB5EVNAUdfm3N5Pap7dhK4cOx9o3F8iCEN9LpVWeN8yHENBh3BkZ+H0JTwPO6k1Q+KG9H146caNYkuCEu5+SmRbxme0oD40qGGvVI3/Hb02fbb2EcsnvmzOw6+nRswvGu0+hSTcrVCtVSwhpC2EWv4deLm1gYhqn+PzGrV7rge/PrXfWBvJUD+BJgGLHoODQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39840400004)(366004)(136003)(38100700002)(38350700002)(26005)(508600001)(107886003)(186003)(8936002)(44832011)(4326008)(2906002)(52116002)(66476007)(42186006)(2616005)(5660300002)(8676002)(86362001)(316002)(1076003)(55236004)(83380400001)(66946007)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+Pv264OctAw/XLcS2VTQxsfqB5bB0HgvtzqXWgy8VhyfSEnim55lKFFCsXT?=
 =?us-ascii?Q?dMzW1xj9Pmzy5nNGNZEeXBxjNWrWbuNaR+930crznhJxwySs2+YmjmhFHYBy?=
 =?us-ascii?Q?g6SJM/Inpceg0X/KCvaNtmcE04pE1b3E2d2/M6hXMyzAOl4Z4EN1bFTKZwLk?=
 =?us-ascii?Q?J+3xmryMKUstRDtCS2i7BThx4nq9j2EouWVtNXyx/3b00b32Ftd1GCXKPSd2?=
 =?us-ascii?Q?KtddnlHCOSzCexOVKHxlKh2dPfqewxNBR2tG77kUi1r6O8ClTofDML7Rqoju?=
 =?us-ascii?Q?Drr6kNR8tTQ26tlv7pK4HGyYbbA+IiFpewjPPFMaI4Js5Pn82WhxBs5tT182?=
 =?us-ascii?Q?VRNqWtgdkAJ0nvMrfICDY9/QlT7IYcSpkbnAbDL6/AdJAk3aQnuSvOTL6Krq?=
 =?us-ascii?Q?PnGinBHN9vieGG0bR32C+4RnI7vuyaAHiQ5Tns9KRuUlqcM01sCJF0cy2vmr?=
 =?us-ascii?Q?AevlpNnFDHejzDMAQsv8maMvjY2yluqKUu+3qLbRoEtxA1aC4TeE9BeEa39N?=
 =?us-ascii?Q?4gnM+4cxrC+FeL30UtxV/S8FbwXTp4wx+K506iy7WwwfaLm3yMma0fqHec5K?=
 =?us-ascii?Q?Sr5+iPBcLZUoINssN8Vfl8/f3St6LVDS+m8XYJzNhlfT6mKUIFmIHIm4G20F?=
 =?us-ascii?Q?LtJ6UIMgujEZkZpEb5Olco0Og9xvl+DqJAWYPrk9CasTshdhR3vj/6uFiZL/?=
 =?us-ascii?Q?IAqPLFhEwWfRtkY1sCIdVuJe2A6Y+9oTA9uGqAuL6L+Gsf4HTvl2Biu3wwYR?=
 =?us-ascii?Q?dkssyXDo8zxQYffKyWJA9/tX5LE9jLQthCjdKLG4zadcZYkZjxaegbGoJieY?=
 =?us-ascii?Q?ANkiHJq0uoPwljETuNzbvTo4XmTRXms3wHnhpsjUccQZ4igq52z58M9wqQxw?=
 =?us-ascii?Q?LoiHxIG2lnnVX6N1XUe4cos9Nz0G5WK+YbTBJlcSkrRgi42Sio9CF1+cPCUd?=
 =?us-ascii?Q?RQCvYiMFUWO4WHe5Gk1BppZ0thqomOUO0GrxQIDtC5GA+hAscWPpy4/HYVtH?=
 =?us-ascii?Q?viECwZwzlihFRQxPcD3aba0xLSLBGWbKFuMGnO3Z5jaoukscnohZiRqmA0i5?=
 =?us-ascii?Q?KEQWcKUhRkaGD09BM8w+h32lotcukfoMRoLMmwaaZGOQZY63UbjHlp6VbEI8?=
 =?us-ascii?Q?CoG4sJprJFswPxIr0PQk4AIAYKItoKt+KdplkN4lL73FyCyuYScRKtEJnZLW?=
 =?us-ascii?Q?CiuuU33QAAgHmu85r4WOPieVGWzwJbyPeY+07gUHoT7rcsZnWaiXipxaX8cK?=
 =?us-ascii?Q?+YH/Otcdx87CliKDyScldii1Q62DwdBdrUmDqagAMZxWIhEdXFXnU9893VIU?=
 =?us-ascii?Q?1Ek1VWiQ8gkYPy+NSGpfuuil?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc57a2-4c2b-467e-f977-08d981b9d336
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 13:22:16.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPT/sszgA3lwBgzSo1loM9++vX2kBpK7fyZcYAjYxvErsl2hEM0C49sEj3y+j7HZojGzqTYR7ZxTpp83IFYlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6950
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
reading "raw" attribute in scmi_iio_read_raw.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..c6a9dc6ad140 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -286,6 +286,9 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
 	s8 scale;
 	int ret;
+	int err;
+	u32 sensor_config;
+	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -300,6 +303,45 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_RAW:
+		sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+					   SCMI_SENS_CFG_SENSOR_ENABLE);
+		err = sensor->handle->sensor_ops->config_set(
+			sensor->handle, sensor->sensor_info->id, sensor_config);
+		if (err) {
+			dev_err(&iio_dev->dev,
+				"Error in enabling sensor %s err %d",
+				sensor->sensor_info->name, err);
+			return err;
+		}
+
+		err = sensor->handle->sensor_ops->reading_get_timestamped(
+			sensor->handle, sensor->sensor_info->id,
+			sensor->sensor_info->num_axis, readings);
+		if (err) {
+			dev_err(&iio_dev->dev,
+				"Error in reading raw attribute for sensor %s err %d",
+				sensor->sensor_info->name, err);
+			return err;
+		}
+
+		sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+					   SCMI_SENS_CFG_SENSOR_DISABLE);
+		err = sensor->handle->sensor_ops->config_set(
+			sensor->handle, sensor->sensor_info->id, sensor_config);
+		if (err) {
+			dev_err(&iio_dev->dev,
+				"Error in enabling sensor %s err %d",
+				sensor->sensor_info->name, err);
+			return err;
+		}
+		/* Check if raw value fits 32 bits */
+		if (readings[ch->scan_index].value < INT_MIN ||
+		    readings[ch->scan_index].value > INT_MAX)
+			return -ERANGE;
+		/* Use 32-bit value, since practically there is no need in 64 bits */
+		*val = (int)readings[ch->scan_index].value;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -381,7 +423,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
 	iio_chan->type = type;
 	iio_chan->modified = 1;
 	iio_chan->channel2 = mod;
-	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
+	iio_chan->info_mask_separate =
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
 	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	iio_chan->info_mask_shared_by_type_available =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ);
-- 
2.17.1

