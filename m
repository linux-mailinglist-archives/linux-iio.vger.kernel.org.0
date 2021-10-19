Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57866433051
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhJSICX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 04:02:23 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:43847
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231187AbhJSICS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 04:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYmVsfve281Rp8ChpnbsWrG1YaG4CPU/94RQlZDqscJqO51CzkauwNpaHnzKsGdEwH9jw6jc0vVHKPIychH3B5YbBYzDTjR57aX7rXz96WngtG9wV8JTxZ10EpB75ZBRXN5v5z8llydj5guKxJjQlPiqXv7UMY7CcIGnxstGQl/MOWCJpUEg9GJe+1BI91YAUcw298MnB7ZwhnIQJZYJK9tMPmM5gbzPrp4Yrire0bHR0HlfUtpis7gOj2y4F1iEgbHoMSJHymvamtayiE8F7Hy4EkVIq9nqZGgSt9VTvJyXlz5QOreWMWQwgcoMnqJJHQe2pccbysYn2tLS+jszhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zONO35YOcQjTs0NlO/NX6hazQl9fNoIjusPzglS2vQ=;
 b=CmI/HVPviYHBn/V8zL75IaO8yeI/syiZwKj7KiEE0X19V+8O5r7klqBbWaXYV3pDTc0PFOY9VPhNI5H1twxmMLxTDEza5Liz9G3vTQ4u8op5q1ITGXBAIZiwU9LWjj9MnOF/J8yFlgN9Yub17gE4xew7E3vUS7EN5mrCv1UQgzoFIgLjqO0QEMRLELfmm0j5Ht0bxGCse7R3YQpRGI+MY+tCRAvGKpfBeEW8zrS/5584pcrVGSleuZ6YO1zvC0Z7FhLpjIRyr0wjyRFG2bay8P3kcIGpLAhU78eUG5xB6I6kBgryIcZoKaRWPxJkFCNqLqsImX0YegcivCrXKqNUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zONO35YOcQjTs0NlO/NX6hazQl9fNoIjusPzglS2vQ=;
 b=DhSssu9OzlRs9Row6/QGa81tc96ydbfao4K0wTVW1CKReZkS/XdfSP3OjScPWhHpstK7wPLNuWPcJHg0VFVdZDm6ywa4SyzHoGPQgP+ce6w0rNVMBopIwziAsLXxDqHy+dexxyUj7ECFNoPMVykywa6Hdgb/u2HDM4gkrolb3Ks=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v6 1/1] iio/scmi: Add reading "raw" attribute.
Date:   Tue, 19 Oct 2021 10:59:49 +0300
Message-Id: <20211019075949.17644-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df83b4af-1b2b-4424-4ec5-08d992d6748d
X-MS-TrafficTypeDiagnostic: AM6PR04MB5159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5159C4919C3A2872442670F5E6BD9@AM6PR04MB5159.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1/nCqJIyUKhfZl6zDCFl22mL3ytymUrFCqXFv9zvqMX/JSVljVKeHoFSFaHGLukvXpEbb9sPnVhRnYnmV1OwKLqg71p8qcMoiwHKqB9bH19bTI5dvtciTUHqQniF21OSYptYWYXVW1F9UAyfx8FXXgFu+ZQ0rAIWLsyEwc7iML4ojZc+au0e1gGmjNCyNY5aFx5RZOdKQHuqj05E0ssHnFi8gXasL5LlsPXURiAvA+DQ4tEBcnc3h68upWj7ppRSY0oe1G3PLtTWJAzpwdOlNq1t+SyP+C7EJ0iUZTabSsoABF0atJl/Oj850y94XmvQHTHcRVVCJoiOmNHCo3IyjDVjbIRtTO4PqihHgHn/bJX4AmEOjJA+JzkiRPaHd2LnEmfBXlW6cN5f160ra+F+ccYmzTLMFLmvISH4uKXtcuT7a033JLJwibAHIM8RN5YsvwcAbnD2SD29IXQJfaqv1NWj83UTb8wDmcorrkqaqo/k1dLkX8JcUySGeFK9KbgA855kKpT8/H4CxahaKUoPgb/XlHUjWZsI448+KiTsEOHHmqi6Xd3kstntW9PdYvStoishvPhutvgEVXhxNZxDNndyZMAdALjIwW8RUJef51tC/kirtKgijZLklLpn05JhJl3PNSkStLL40F+UjVqi9ziPlYFDzLDeZmFAxxijjcqnmXW/EA+GoOgwz3d+7dRv1xRfHPO/JkpblPGg5BmYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39830400003)(396003)(366004)(52116002)(107886003)(4326008)(66476007)(2616005)(44832011)(83380400001)(8936002)(42186006)(38100700002)(1076003)(8676002)(2906002)(55236004)(86362001)(66946007)(316002)(26005)(5660300002)(66556008)(186003)(36756003)(38350700002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+U0cpDEsU6Ga4JaiLSwXN/NYUinhQa1F5WW6goqB6nvgXuvWkC9P7slJFbD?=
 =?us-ascii?Q?/dsBwySaZSRpdurRYAx8p7sF+7l8UNqv7++k0JRmguZN8RhDAqwgMEBG7CEa?=
 =?us-ascii?Q?Kx9FlBjn9fCA9UQZeQwHo3V1gko9DwE9qZshcEu5tTEs2js/0aRnlfz7xWfQ?=
 =?us-ascii?Q?CFncnNN38sIh6oODdUzc5GZ6DRGCeWpSe9Ena+xgdUJdSNi4nEF+8GWOOhzz?=
 =?us-ascii?Q?rCuYKWoYA3fC9tCkEqUoqrtfHc1nTh9Lqhx31O0ApOELoIO59hqMybYEWQJc?=
 =?us-ascii?Q?IAnAjbee6XRFgFshGEpv5oc2p8I3uIyUJOCPX2a8lvuCiMr/47W5IEgv1uAB?=
 =?us-ascii?Q?/Mcn5gu4xIsFjFHOetckZbqjiSdtFcM+YlF0CHCF4M9ZIBSx/YC04CE9baMS?=
 =?us-ascii?Q?hs7ZJxst+UTjAjmunpj9KWD2PNChySPpiYA2qEgz9jg7MBatN4MAuhTQKKK7?=
 =?us-ascii?Q?dIKeeT2pwM4C7Xm7F7aUJouAojtwJcStbAT0aiwj2lANlEYWG5ipheIDTzWj?=
 =?us-ascii?Q?LhwjXEYG4B8Tc/NHprwu+5SdHlPopNwKRWlLRuhyCJKDc7YVtujh8wwupWOU?=
 =?us-ascii?Q?ebFNAWxUtPzZ1ZkIcI5Fc1AmU/YTCrkuhbhAZZuLqxg7cqiRFHyebEZY8F82?=
 =?us-ascii?Q?WlOmpBfkXnwhaVdSxORdYKUWWrJ00FNb8lJLUDoZZrC0C3hAd0qkqBtbDWiw?=
 =?us-ascii?Q?kEWk65HO+FaR3yz60iWo/5vU0KJs8qo4AdN9yloFCCYPyHO8Wxdx/5O0h3Xb?=
 =?us-ascii?Q?xhrz0s6pufjhG5E2ehs7urLWBokrcWNu6Sx0iOP+/qoEge7lqE9oXeCQnxai?=
 =?us-ascii?Q?TBcCZAh4/1Tyoiyrx2L5JhX1tByBYKomZY3rQ7E0q/HD6R0Xcf30wWLlf0j/?=
 =?us-ascii?Q?E1vulip5C2K034ors3NJWbuvlx2xPV4XrQo9onR1Yo99LAb4IDM1h7EoKghl?=
 =?us-ascii?Q?/5l5FbFmyBrdACr7Q8oeS8SKR41MNi1YuDExUM0Mxf5921q+2vmDYEuuVJx+?=
 =?us-ascii?Q?BtuV4pCaP7xqlwHXnQVaJPoR86fObla9HtQFK8sG3A2Bga6YsuCCFf89pf+m?=
 =?us-ascii?Q?3CQnbPiJIQGbl1XRls3GooL1bW9E8GUzDup6BbRDO5DGI7D0WBo6yz1RLdC4?=
 =?us-ascii?Q?cQObsnv79M6FJyyGJnFlg7zki8oSUdVxPBq4kMUFupOT7mU1TIKaPL6+5Foi?=
 =?us-ascii?Q?fR+3+uknOaE25XMzxHkQxzDWblygRWuAmX0C0KaFE6XjMmtaijqx4puijP5M?=
 =?us-ascii?Q?0jrE87PT1T5IcBqmqsCfwiaRjOvupHpSEDIpj2b67b87cbCMXiQDCJ/kpaiY?=
 =?us-ascii?Q?c5i+AiOP6ZSHkLF2MnNdNQOu?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df83b4af-1b2b-4424-4ec5-08d992d6748d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 08:00:02.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glat@opensynergy.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5159
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
reading "raw" attribute in scmi_iio_read_raw.
Introduce new type IIO_VAL_INT_64 to read 64-bit value
for "raw" attribute.

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

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
 drivers/iio/industrialio-core.c            |  3 ++
 include/linux/iio/types.h                  |  1 +
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..2c1aec0fd5ff 100644
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
+	*val = (u32)readings[ch->scan_index].value;
+	*val2 = (u32)(readings[ch->scan_index].value >> 32);
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
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6d2175eb7af2..49e42d04ea16 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	}
 	case IIO_VAL_CHAR:
 		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
+	case IIO_VAL_INT_64:
+		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
+		return sysfs_emit_at(buf, offset, "%lld", tmp2);
 	default:
 		return 0;
 	}
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 84b3f8175cc6..e148fe11a3dc 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -24,6 +24,7 @@ enum iio_event_info {
 #define IIO_VAL_INT_PLUS_NANO 3
 #define IIO_VAL_INT_PLUS_MICRO_DB 4
 #define IIO_VAL_INT_MULTIPLE 5
+#define IIO_VAL_INT_64 6
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 #define IIO_VAL_CHAR 12
-- 
2.17.1

