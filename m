Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B95241B3A8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbhI1QV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 12:21:57 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:10304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241697AbhI1QV5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Sep 2021 12:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA1osaOb4Nt+ntaZbTUu1nQI9xJepFz17TWexxpIyheaWmbQqV+q8L0Y1gQsLfIgzuHIELlQGGeRpqIV6/Gh9+J0r6XrjfuOiknbB5cHgyS39fUsro0RfKfzlyzr0Y07ZH+VfJfY+sSy6YcMTiZdtQjIiKD4XpJx39cOu4TTQ0mro3FXRjslvzb0ol3ZIXXp26qAFXxy7wGzAJnOTtruJyKt1llSjP90Jc1cUdP2mKt5zNnyht1KqkzZ1gChkAKjr4+2fwZ/rlXiclIr/AYzUILsApXwc8rVRtlI0SZDEnrydrkNaRAu3GEojDPMP5AT75qFM29AGXYN9Gl/2WLjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TZz3U7IKxoUue+UOVWl/95prRpdxPUlIbsOCSNjHLhw=;
 b=FjvVV594c2FgzlE26iO7i3JYPCWtxaDPek8FHYRDzo93CM6xBbvOPlmAte5lY9Gdao/uJTJte5FWXCgrG7SDWnFZvp0HJS3WkzHqhDr8xGtHOGxDWhVamMnH3g3vQwcDa6J8NtbfJFXiu6tcS7muQA1s6pmegCmuFCsIiP0TwqSHVIWOF7AlVHl+ptlOoLZuG5BEnsOI5+7dnkrY3PU5ICTZl1FAoCawlRkn8WLqyghkkG+TR4n4UkSNAt//hz01TShOUmWQcrjUpvW4AohKYgehYyJ5jfaQfJNtGltn57R4f3ZlLEv3nZBnVEApC30FBlmeKUGAaABe49AWfibUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZz3U7IKxoUue+UOVWl/95prRpdxPUlIbsOCSNjHLhw=;
 b=GNbhPNgGdk0Rr0XY1Y+t3Ahi23a7Oq9oGDjyuiN2k86yPvl4CXwKCr4J6xpRHk+jLakQ7VgHFXb0hDxZYXhJa6q0rWA6nFwNpAqFF5O5omGP/7PbHRqYzgALFsndN4rsATyXjC/fGv0ZOnQzyQlDwvI92m997ox8drgtn3fVPkU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v3 1/1] iio/scmi: Add reading "raw" attribute.
Date:   Tue, 28 Sep 2021 19:19:57 +0300
Message-Id: <20210928161957.24628-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0273.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::13) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc47726-9601-4dc1-aec1-08d9829bd98d
X-MS-TrafficTypeDiagnostic: AM6PR04MB5879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB58793F309A5DB2D097008B66E6A89@AM6PR04MB5879.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSpe/iyDfIPIA0GGNk4GQ9uEkjpdJrPq+R7tjjTzT575fCFmlYeDuFjyE0tzIFmSIt929Zl34IMXcfilJY+H2bdA9/wc3nqIO90D5NKtNvaCKuRFRhj5oSo33T2mV+gvqoYG3ueuHkzFXNhzsY1l6G2XgyFz40Fd+FTTRUJm7tH1cGN6QXE4TBS2PuVByyPg5SgK6o5hBQzR9D5+GoKstNjrdQBk9/Zsm28i/zSHGm1mBWWPMQNLUlMw/b+8TUp/vZZm2n1d78Ztq2BM8uSjVORDLqIdrbXtOMh3/QzwXc9tG9mgWaVgpMhSub4bl9RKJwvsG1s81v6bomFasfhci5TJlii7wWtwn3iaJQBLrfvKDtfU4XO88RalAE2A/NQQBOEmrf6i1otuX53TcsTQcnERH0q5la87fyhsRjzwcOiYCzJx/yNUlCCrNqtZjqmifFp2FQrxNCLbF7pdexEuEa891fHrGa5H6v3eo5Zs8lEy5W/e+9sEJsdsLutRvgJ+pbd+f8xPIeWa6ApqGbnhyJr0Hfm+7b8yP5Kuwnoo9amCB8z9MJt88MYfVl7qqJHJgaP0HY51F0aDyZoDx0yDM4aDe5IzcPMAgxbD0nYt1kzgJbTyIKL0J3dI/OeQvQEnQTjd4S+/K4qlNE24kUCdejkBPGArd9OBujicMWxh/jqgVZdejyF8XrtN5lgnMg7lx5RjFgJnF+tIhUOUxDIwvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(376002)(346002)(396003)(366004)(4326008)(8676002)(52116002)(55236004)(186003)(1076003)(83380400001)(44832011)(38100700002)(38350700002)(107886003)(26005)(2616005)(66476007)(2906002)(5660300002)(66946007)(316002)(86362001)(8936002)(66556008)(42186006)(36756003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMbKLITlD2cJZqM2mYrzuYgtygyBCbHqB3e5Tf95JFd/0qZpus2PxkN686CW?=
 =?us-ascii?Q?gFMO34YgqrRHKXJlCdybtfqZ5Fgf2hWz8nAlxgBIMzgmyi7WAttoP1vcjHz9?=
 =?us-ascii?Q?6msgqIhuOM2wJd3Nw3Fd6sVvEayv3D6byfoXJLLI0ijTUCWZvd7cDYBp4Q8O?=
 =?us-ascii?Q?JfvRF3wpiUtcxaEUtPz9FKCBiy0WNogKU8HckxLExN373WPxStUPo6xF00B8?=
 =?us-ascii?Q?+osGVceAgNa+Nv061q2Bts9lXNcvCxupCUXHmJiQgOGZ4eEkfv0hghbWTjp5?=
 =?us-ascii?Q?99oHN2E3W+9rjoyAXhiFG017+Nvd+CyaYEs6X0pAKYb24Hm3k3F01tBeAY2O?=
 =?us-ascii?Q?wXpJjPzjNzfJ7H14IWs21e5Z3rt0UG/lDpoPhTatpMcvjUIC2CV5fYGWZXzY?=
 =?us-ascii?Q?5ZvXpvdNKPtijrQw0w0IoJoPCw2U1cHg1m7nQFVhQs2+aMaW4HsO/KsCrQCG?=
 =?us-ascii?Q?U5rSvtxLMOukNjRF/EIA4A5ghKbtIN1wLsbeRXmDt2RIzl0Z6AgPl7H3qPK+?=
 =?us-ascii?Q?xe9qRoZA5CEi2IwUMjHHZNejwUxDMPLl7p/3PJuQ71lGeGYQ4bcHqgDANZbO?=
 =?us-ascii?Q?3nRfBAwyIbee4lrKL7yeER1e2Mja6tmO0429Sjtqtml7eYrgfsLySHvDII3L?=
 =?us-ascii?Q?efE+1b6TCznd6kyzER1BEFp4yB0MDSiiHxRHg4QcYSePoHmyYxoZojLoDZiM?=
 =?us-ascii?Q?wcDk3hZm/X6ckB7yWXMxeHRibVphn+SaAgKvREcWMLXNbPfySu/sGWHqyanb?=
 =?us-ascii?Q?KIxLpOWMBm+r5X3iXr9kYXYVU5Mix0JtPmYSPvTxS4/DSnt8Uox/CDX+J4ad?=
 =?us-ascii?Q?EPwfPwd99vE9Pk0yvqKpY1GwlXsiyhzZdiT8Z4d5EDrlF7G/6/F6NuKxkDEi?=
 =?us-ascii?Q?zB16mdTskSDtUxJUelDEGUDQfcazELYp0o4l0LNMkwGKdlC8yMfHKhnQeCwM?=
 =?us-ascii?Q?v9pofcdLxANB3/zBdG0ZQvsfYF9iOnDQD1v3bDLWr2DdCVwIEyojbNqfi6D3?=
 =?us-ascii?Q?fHxOYQmeaYCoowt2031oxK/JIPRxAGVBhwRl1wEy2a0ePKIic2URPixBhIiF?=
 =?us-ascii?Q?3B9RdBrJ3FudoNafi41JPax2twwOdO9wasmklaUUA04TfDnJz8kOHQb4mx49?=
 =?us-ascii?Q?FDdKhuKuPaDOj7K7ooKFGUY4RKiX5JbZ087IQ9yZ21nOw15zmNbjJlnSVpup?=
 =?us-ascii?Q?kiMFUtBWEztYVa7/UJC/m0bRkBgpXqoT3cxk2s1db5HI4iYD4BzjHvMdqYjM?=
 =?us-ascii?Q?ZftkCrrsB3GxAV85fr817apjWCa7Etnkc+v4avzxsRpOzM8JtjwpUkT/nfDm?=
 =?us-ascii?Q?+kA6n9tK8gTqQo/BD8D3oVci?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc47726-9601-4dc1-aec1-08d9829bd98d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:20:13.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd/f+cSHo69LSX+6fWpXa4oHo0NOVgh0bPzj55bZIgdgCSx8zfxRuv8VGJG0uhEmmfN/R5P1JI5IV+Es4HP+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5879
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
index 7cf2bf282cef..7ea52186ad50 100644
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
+		err = sensor->sensor_ops->config_set(
+			sensor->ph, sensor->sensor_info->id, sensor_config);
+		if (err) {
+			dev_err(&iio_dev->dev,
+				"Error in enabling sensor %s err %d",
+				sensor->sensor_info->name, err);
+			return err;
+		}
+
+		err = sensor->sensor_ops->reading_get_timestamped(
+			sensor->ph, sensor->sensor_info->id,
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
+		err = sensor->sensor_ops->config_set(
+			sensor->ph, sensor->sensor_info->id, sensor_config);
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

