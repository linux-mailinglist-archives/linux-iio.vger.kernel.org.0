Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616684387D0
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJXJTO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 05:19:14 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com ([40.107.14.127]:14414
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231400AbhJXJTK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 05:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6YPtdFNGzojKEaMd7VvK19z0vFQbOqOFeifnwmi/GZjcyFUsGKVYVWLw+NtrRbJqvuCkgl26Ye7Bv2RPlNa85dxFJvjcS3ZvXAgH/9UVRFbg+MWd4Li7cvSFCBg+c10lx+JW3E40EpAC1KjyrWLrHExX2MuE8YVPRPeuCaCVf49s9E+r+dI/gYCoHDSlXM2Xsib4BQ+YRZbrPIHBTdLEX92xQCya0fFTnsxDj+tJYWbVESjk+mn7vd+vKJhM/AzWWqgPh24DWjkbp3oTCc08WyCBB/ebOKMUIvcmG80a8t6UUX3aesq7B+DBtkgWBQSZW005GewsH6MAHEOVx606g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1y8Z+b7v1MGw69LmxuD5UkfLdaW83/HUpUzn8oB59M=;
 b=NjsH02LQBu8tV9nhAjqZ3IAY46UYdb6ANQTAJfX6jQD8zrAfyFxvy/k7EICjgEnS7GF1vUJMW0UtgSb8pn10lgsQYE3LDsAiqxz0WhXA7xe3KgNMV6uOgZkp0vkG/Y5ffGgtGc1QUHE4KP+fD4KH3vQYqxC3cFosP4sIEgn4cY95aE6jp7eDHjwdPUOUfjLyb95ITLporB5H4CrIca9Ns/nzDu7htGdzKP9tLT+4rihcfmpyS53cB+kOqojbPSVM6QxtqnGvTU2h/y0pVFMP/96ZJIy4fjVseQHioxbEVSYpE9+/aZg8/Ly9lOndZBOg7sl5vhdCzc+k5YG1vIo4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1y8Z+b7v1MGw69LmxuD5UkfLdaW83/HUpUzn8oB59M=;
 b=UM4lpPLErcGRRtuJxRrStEryKodOJb/EzutPv7pcZMZrGY0XTznEeUsV9VhAKlguSFUDk5ZCdkkdcYvc4uoDXKUoYWl6xE0VaJE9H37TpWNLAY6v7p95zPy4AERXgg7KuFHY5FjqTMHpOCiabYaBX7gMjRueVhC9554fUKOmpM0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com, andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v7 2/2] iio/scmi: Add reading "raw" attribute.
Date:   Sun, 24 Oct 2021 12:16:27 +0300
Message-Id: <20211024091627.28031-3-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0035.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::15) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61bbfd94-ce80-4c3f-61e7-08d996cf006d
X-MS-TrafficTypeDiagnostic: AM5PR04MB3011:
X-Microsoft-Antispam-PRVS: <AM5PR04MB3011F7DD857EC2F86FE4F381E6829@AM5PR04MB3011.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soKIiuDWE1tBNFf27ZzwP/ZCpjOsSmVGqt1ndYsL90FHB64o//YgFXE9BkttKN/udSxVwCrvkmXy9AaRc1qhwm5pm84cNUmm13x/bOtZM71pn2nXemsjbwQ+Un6nGapT59Fr7lMi51jB/1aKwGfZslLVieKvRbL1ybSdPRvhvV5epovuDPwK83auMv62QkxdIpFIsdK5wKAwVVkRFLKINd76LYY0MmgX1Ygtfn5i81a3y6T2kpBZkO2p+wHqZn8eolvjqt4GYP2JmNCwDio+leUS058xBlw0TKATetkmnDAnTI9/xI5LYIQBL1wO2Me8wcvMw+Sr++3dfmKRnHydNR/l07M1sBuEpvd5Sd7f478hXREdBTLRnqbnQQ10QIgx2P0FV3l8aBeKB23ANIjXZMNh4HCNU1/drsRB8ELW2ohLdq5qel0TEeWzW9f/pF+yw7Aoxz9MfgHsqCJzTxhwMZa3F/ysyBeLNdVfYPb2a7GgBso9dYnO5zdB9QqQvghImk41h447WtZZ5jew6+1Zk8NkXaPPmy4+0yfowutxW1nCxtzHQu+QbJMOWdg/AQQIAvPUko0FLgSN4w1d8IyaV3K+G0N0uiLnVUKyyEY0FffXHGOkZtybXtCPjLBepihFgSPQMHjhmJHzRfmosOQuCkXGO6vHno/z816oFlhL0Up/2cCnevWDcK0o1SEcVQX01HpEZoM2heGAIVjZl2py8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39830400003)(38100700002)(26005)(66556008)(5660300002)(2616005)(66476007)(38350700002)(42186006)(66946007)(36756003)(55236004)(86362001)(316002)(83380400001)(44832011)(107886003)(4326008)(508600001)(2906002)(1076003)(186003)(8936002)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQ0r625cE+iM3YBDc6I0/+wqtAowcubg9lXo1iRbCdfgPjktnG4GyvkT9lxW?=
 =?us-ascii?Q?y7t/3I3plTdwTy/oUZu4lxE4DwGgiJ5cP6pDA2RsuRAQ2ntPoyOMwhjvonk0?=
 =?us-ascii?Q?vLEr6ALMy6oOSRDVRA2mDL1a0iLmAaCp62IUFVXEpc19loMRXoSJ/oHDkbW7?=
 =?us-ascii?Q?zt/Zukx4Xzb91XflnLxi8Lv0haDxzTNZsEaegN5iSNyLT9HEhLPScqme0SZf?=
 =?us-ascii?Q?5+t8PEUi0EN+OPzHPHG5ODZ1nzkw/zimyVKXum6maazAhxssGGUlGRoxIqB3?=
 =?us-ascii?Q?rCdC4t4+gqRSKWaC8Gzc1xDp4Ffw432PChaGxpuxnRyeKWBGwtU1p6GLnz70?=
 =?us-ascii?Q?ENw3RF10a6K5oD9jECdgUz9VEkvjyLbgGozkmfBEpf6XS2r1+fSJM1PWi43i?=
 =?us-ascii?Q?Kk2LsAXqE24JktHnTC8RHT9ouuNyRRGmV+u3uHIcUpPwCtgGF1FwvzffYhPV?=
 =?us-ascii?Q?cVX0VmkilxGUGn0zsMDBQNOXUejqnY6SwSqX6tEFkAd4qEsH1WzOQp5nHbtK?=
 =?us-ascii?Q?MRGmyviMh8sojx9O+Qnw/i51H8gcZqc0GZguy0CCg+glV5a6RfPKuhfVvCch?=
 =?us-ascii?Q?qK5o5SAx7tIlE99IkIhzOFmM1uhNWIA8ZZSyS2e3xiAtFCoFXfeYe4Rj0Zza?=
 =?us-ascii?Q?dbAHm1UnoxAyUXgAssiIodRltA7ZjY9OTznkMJLLJ9AYmtWmBuJZ7qS8Yrbz?=
 =?us-ascii?Q?B3tQTYcB8lsZ7uUhWPoQcps+/h2qAOErO5Z6Es+3aee1mMubFoYq4gbvzd6r?=
 =?us-ascii?Q?bBCYvMbt5xZ/DuOwLBI3J36jMN1x6kspoWePDGsOHAO/jOJurkLGI7y6yck+?=
 =?us-ascii?Q?l6OvtlBHN9z+o7jVFVHcxFkw9WDtFte8KIR1+cdUdOTxrtKxtjetVIGVRC+P?=
 =?us-ascii?Q?VDOO9BFUQRAgKY+AbDt+JQun1IVMHO4pV1fPQV6YcC8X5VGOvumwaDUfk8or?=
 =?us-ascii?Q?ItUUUIeKxlFRJ/XDg2ORTzhoK8a2K5qDPlWwcGnBnC8CYw/zjEy3A7l2wakP?=
 =?us-ascii?Q?F9rd4OFroyZPCQ4yG/lQ30OZCKWCflfUIRYRKGqt/DdwYtu8+9iAm0Sze8J3?=
 =?us-ascii?Q?ERdOyrkFoy6qI3HOcwGGP5iYGCEm9TF5Ak8Zj5lp2cnXA7Ab5Csh5lXSnzQW?=
 =?us-ascii?Q?eYnoLbci/b/ug71xO+YN2g1l8MdShwqTvO9qJr8QyNFLTw7RmVK7lBAcpSyi?=
 =?us-ascii?Q?/XIy7MZdkV+nxSPn9P8qBndjuqj43usCnYDrJaAeQlwOv0k66CAMUs9Yd2Cc?=
 =?us-ascii?Q?h9xjdwOM4VSBUMqM1c7eP0Y+wzoT6LJJ1H8OnVjGf2jRwVzgLso8UGRnD58o?=
 =?us-ascii?Q?aPAKRcYNKfO2WyAn+CYLYPdk?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bbfd94-ce80-4c3f-61e7-08d996cf006d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 09:16:46.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkibR600ULdG0/qxrKjuv04lSDCb9lysIIPbhvL4p9bWF+wf6E3Th1jQnabcOhn1Eg/d6x3Qvpd4xmaxoBW50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3011
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
reading "raw" attribute in scmi_iio_read_raw.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
Changes comparing v6 -> v7:
* split into two patches: one for changes in core functionality,
  another - for changes in the driver

Changes comparing v5 -> v6:
* revert v5 changes since with scmi_iio_read_raw() the channel
  can't be used by in kernel users (iio-hwmon)
* returned to v3 with direct mode
* introduce new type IIO_VAL_INT_64 to read 64-bit value

Changes comparing v4 -> v5:
* call iio_device_release_direct_mode() on error
* code cleanup, fix typo

Changes comparing v3 -> v4:
* do not use scmi_iio_get_raw() for reading raw attribute due to 32-bit
  return value limitation (actually I reverted the previous v3)
* introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
  64-bit value
* enabling/disabling and reading raw attribute is done in direct mode

Changes comparing v2 -> v3:
* adaptation for changes in structure scmi_iio_priv (no member
  named 'handle')

Changes comparing v0 -> v2:
* added an error return when the error happened during config_set
* removed redundant cast for "readings"
* added check if raw value fits 32 bits

 drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..d538bf3ab1ef 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	return 0;
 }
 
+static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
+			     struct iio_chan_spec const *ch, int *val, int *val2)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	u32 sensor_config;
+	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
+	int err;
+
+	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+					SCMI_SENS_CFG_SENSOR_ENABLE);
+	err = sensor->sensor_ops->config_set(
+		sensor->ph, sensor->sensor_info->id, sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in enabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	err = sensor->sensor_ops->reading_get_timestamped(
+		sensor->ph, sensor->sensor_info->id,
+		sensor->sensor_info->num_axis, readings);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in reading raw attribute for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+					SCMI_SENS_CFG_SENSOR_DISABLE);
+	err = sensor->sensor_ops->config_set(
+		sensor->ph, sensor->sensor_info->id, sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in disabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	*val = lower_32_bits(readings[ch->scan_index].value);
+	*val2 = upper_32_bits(readings[ch->scan_index].value);
+
+	return IIO_VAL_INT_64;
+}
+
 static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 			     struct iio_chan_spec const *ch, int *val,
 			     int *val2, long mask)
@@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(iio_dev);
+		if (ret)
+			return ret;
+
+		ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
+		iio_device_release_direct_mode(iio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
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

