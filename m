Return-Path: <linux-iio+bounces-1514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B494828BA9
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 19:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE2B1C2498D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2FD3BB53;
	Tue,  9 Jan 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfXMYMK2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA823BB25;
	Tue,  9 Jan 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704823221; x=1736359221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxuf2qv5qNCQwDrG+FQheyibqpQ4k7NBlmbN6ka5nqM=;
  b=lfXMYMK2uPAJmEFYDIHSgWra9t91SoSqWPJp6mCjch8lhI0TYaEck9NM
   8FrpQpbKMkD1Fi9VlBci8z0A6vjdj7RjluUiokGCtxgwslwkWHO/dL7dM
   UBFRsniJQ9z1PVTDKl4+yUpfqKOQi6WkQZ+5qhDXLPX2a1wjeTcW/mzNO
   6cmKjOaA6t5VionqWt63KTIRD3l8Ncm5Ae88Jjwcl70nId5zVURxI0wfB
   ABEvnpqRXAYACj/Ef5BX1yzDX9pbp2SHqW+BGEWWMZIVohyKlh7rUHwo1
   5ptKHq/Ci3MYq6iqzk3vA/ZUP346FQujjOxQmYUjfKFtW09geAgAVPvGk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429458612"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="429458612"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852269564"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="852269564"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2024 10:00:18 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/4] iio: hid-sensor-als: Assign channels dynamically
Date: Tue,  9 Jan 2024 10:00:04 -0800
Message-Id: <20240109180007.3373784-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of assuming that every channel defined statically by
als_channels[] is present, assign dynamically based on presence of the
respective usage id in the descriptor. This will allow to register ALS
with limited channel support. Append the timestamp as the last channel.

When not all usage ids are present, the scan index is adjusted to
exclude unsupported channels.

There is no intentional function changes done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
Addressed comments from Jonthan:
	- Remove channel allocation and move to iio_priv()
	- Parse all usage IDs in a single loop and continue
	for failure. This way the temperature and chromaticity
	will not need any special processing to parse usage ids.
	- Don't leave empty channel indexes

v2:
New change

 drivers/iio/light/hid-sensor-als.c | 56 +++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 5cd27f04b45e..72a7c01c97f8 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -25,17 +25,26 @@ struct als_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info als[CHANNEL_SCAN_INDEX_MAX];
+	struct iio_chan_spec channels[CHANNEL_SCAN_INDEX_MAX + 1];
 	struct {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
+		u32 scan_index[CHANNEL_SCAN_INDEX_MAX];
 		u64 timestamp __aligned(8);
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	int num_channels;
 	s64 timestamp;
 };
 
+/* The order of usage ids must match scan index starting from CHANNEL_SCAN_INDEX_INTENSITY */
+static const u32 als_usage_ids[] = {
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
+};
+
 static const u32 als_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_LIGHT,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
@@ -216,11 +225,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 	struct als_state *als_state = iio_priv(indio_dev);
 	int ret = -EINVAL;
 	u32 sample_data = *(u32 *)raw_data;
+	int scan_index;
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_LIGHT_ILLUM:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_INTENSITY] = sample_data;
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
+		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_INTENSITY];
+		als_state->scan.illum[scan_index] = sample_data;
+		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_ILLUM];
+		als_state->scan.illum[scan_index] = sample_data;
 		ret = 0;
 		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
@@ -237,27 +249,39 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
 				unsigned usage_id,
 				struct als_state *st)
 {
-	int ret;
+	struct iio_chan_spec *channels;
+	int ret, index = 0;
 	int i;
 
+	channels = st->channels;
+
 	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 						HID_INPUT_REPORT,
 						usage_id,
-						HID_USAGE_SENSOR_LIGHT_ILLUM,
+						als_usage_ids[i],
 						&st->als[i]);
 		if (ret < 0)
-			return ret;
-		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
+			continue;
+
+		channels[index] = als_channels[i];
+		st->scan.scan_index[i] = index;
+
+		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
+		++index;
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
 			st->als[i].report_id);
 	}
 
+	st->num_channels = index;
+	/* Return success even if one usage id is present */
+	if (index)
+		ret = 0;
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
@@ -293,15 +317,7 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
-					   sizeof(als_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		return -ENOMEM;
-	}
-
 	ret = als_parse_report(pdev, hsdev,
-			       (struct iio_chan_spec *)indio_dev->channels,
 			       hsdev->usage,
 			       als_state);
 	if (ret) {
@@ -309,8 +325,14 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->num_channels =
-				ARRAY_SIZE(als_channels);
+	/* Add timestamp channel */
+	als_state->channels[als_state->num_channels] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
+	als_state->channels[als_state->num_channels].scan_index = als_state->num_channels;
+
+	/* +1 for adding timestamp channel */
+	indio_dev->num_channels = als_state->num_channels + 1;
+
+	indio_dev->channels = als_state->channels;
 	indio_dev->info = &als_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0


