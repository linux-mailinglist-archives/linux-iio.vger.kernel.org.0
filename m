Return-Path: <linux-iio+bounces-11452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA969B2C7B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 11:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3C328138C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B821D0F44;
	Mon, 28 Oct 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQMHDrLQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CE1D5CCD
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110355; cv=none; b=QvdCfcQXSI9N2akXymHce/uOkplDGYlDV1qyL+dsY9deE1MDnY29MP/gmneG1kRFp8TF7qoJDyluEy7pxaD+/66VZTbQ3VutlqaMItBs9yYTXdwcuOFHdzDGplDp8Ead4lFDwHwAigzKzKVOEWMdbRvgCU1UQTFM1Gzc75Un5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110355; c=relaxed/simple;
	bh=NtTBjVPCukfy6qXUeEEjV+EaTIUrNtFyd0P2oXLNfLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HE8cCiCJ8XDinYk943UgDxVZ9XJj+9SSecI2PzvFVz1r8/WMBS4FB5cG91DcxISguqodcB0NzX3eUviAnY40BcsWvMBayiEZHfBaKOtirqg1IgvIGdiOO0DQcFKr4z5TIDp2iadtPzdGxQNMYHL9J/7D8abgch7ckWS76S5UzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQMHDrLQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1488fde46so327174585a.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110352; x=1730715152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYaDRZS7eycBx6nL/lvgNDYBfbu64MJ0DrtpIvQKBd8=;
        b=RQMHDrLQhO+d7sIe6iDrjc/BIR7bmFWgo+kwrzecqQ+FVGDDICatqCFL1feH8GYYLx
         cFxF77rFVzWQuCl65nUsHeIt+JXtmPVtS4lB2ADYBXvJSyEyX9/zgT3yiRaJovGsh3aa
         qHImNSge40P5mtGGMRC/COdvXRFQ2WZdSDdbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110352; x=1730715152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYaDRZS7eycBx6nL/lvgNDYBfbu64MJ0DrtpIvQKBd8=;
        b=eQ3y8Tpb/gaNL/pvI+bCZpmjbnM2pqvhOX8je/dvG3lRisaEjEYWeRv31lGjg4qNA/
         akKFkIGBORAVEjHbgq1RdQcHYcDwNyLWNwfN4RbsbuSyRW+/UR/nr+S57x2cgpa5p8ym
         peW/osf5Fknpxx/+/XMNszdKMlIGcNpTdr08TgbyLLX3ZDgnsADoAamF4jpntcmsS9pw
         TrWuv4bsFlkBQ6PzW/3GSYVCGBFwiIQgL9WmvDyW0KvFYpcBldtS8NgtjtN6FZc4yGuq
         y3yar0xGt/h35x3EqhGSppLsdt58EXO6UBfo3JsUxpXXmkdR4CfUApIRBzDtPfqyeGJB
         8avA==
X-Forwarded-Encrypted: i=1; AJvYcCUrY7WM1/YBQMqxTJhkUttqJKaxJcf5atQGjpM++dQq7AHI6LtseyGdayO/6Aep9z3Hu9iU1vj6d0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOBJeEt/H1wWDrjY8OOg+hJJyakYjeaZ4deH9wDlRDcKzUNEL
	UpOY3ZuY845/BnPF4qX76+lHbVNNgW4Dgwpr3hF0OpK2SiEcDVChSbad8PTr7Q==
X-Google-Smtp-Source: AGHT+IHNdqRNeM3bvpX5KZk4zUyVm0jdxPChZwsuv/lKavdxSlXErx5iCwCVNzmhBEo3DVOxqjQN6g==
X-Received: by 2002:a05:620a:2904:b0:7a9:a991:f6d7 with SMTP id af79cd13be357-7b193f4dcb4mr1057542585a.48.1730110352056;
        Mon, 28 Oct 2024 03:12:32 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Oct 2024 10:12:25 +0000
Subject: [PATCH v2 5/5] iio: hid-sensor-prox: Add support for more channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-hpd-v2-5-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
In-Reply-To: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Egis620 supports 3 channels: presense, proximity and attention.

Modify the driver so it can read those channels as well.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iio/light/hid-sensor-prox.c | 171 ++++++++++++++++++++----------------
 1 file changed, 95 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 0f12a8a83790..e6f81d40a492 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -13,16 +13,31 @@
 #include <linux/iio/buffer.h>
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
-#define CHANNEL_SCAN_INDEX_PRESENCE 0
+static const u32 prox_usage_ids[] = {
+	HID_USAGE_SENSOR_HUMAN_PRESENCE,
+	HID_USAGE_SENSOR_HUMAN_PROXIMITY,
+	HID_USAGE_SENSOR_HUMAN_ATTENTION,
+};
+#define MAX_CHANNELS ARRAY_SIZE(prox_usage_ids)
+
+enum {
+	HID_HUMAN_PRESENCE,
+	HID_HUMAN_PROXIMITY,
+	HID_HUMAN_ATTENTION,
+};
 
 struct prox_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
-	struct hid_sensor_hub_attribute_info prox_attr;
-	u32 human_presence;
+	struct hid_sensor_hub_attribute_info prox_attr[MAX_CHANNELS];
+	struct iio_chan_spec channels[MAX_CHANNELS];
+	u32 channel2usage[MAX_CHANNELS];
+	u32 human_presence[MAX_CHANNELS];
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
+	unsigned long scan_mask[2]; // One entry plus one terminator.
+	int num_channels;
 };
 
 static const u32 prox_sensitivity_addresses[] = {
@@ -30,18 +45,23 @@ static const u32 prox_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_PRESENCE,
 };
 
-/* Channel definitions */
-static const struct iio_chan_spec prox_channels[] = {
-	{
-		.type = IIO_PROXIMITY,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-		.scan_index = CHANNEL_SCAN_INDEX_PRESENCE,
-		.indexed = true,
+#define PROX_CHANNEL(_type, _indexed, _channel) \
+	{\
+		.type = _type,\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
+		BIT(IIO_CHAN_INFO_SCALE) |\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
+		BIT(IIO_CHAN_INFO_HYSTERESIS),\
+		.indexed = _indexed,\
+		.channel = _channel,\
 	}
+
+/* Channel definitions (same order as prox_usage_ids) */
+static const struct iio_chan_spec prox_channels[] = {
+	PROX_CHANNEL(IIO_PROXIMITY, true, HID_HUMAN_PRESENCE),
+	PROX_CHANNEL(IIO_PROXIMITY, true, HID_HUMAN_PROXIMITY),
+	PROX_CHANNEL(IIO_ATTENTION, false, 0),
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -63,7 +83,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 {
 	struct prox_state *prox_state = iio_priv(indio_dev);
 	struct hid_sensor_hub_device *hsdev;
-	int report_id = -1;
+	int report_id;
 	u32 address;
 	int ret_type;
 	s32 min;
@@ -72,29 +92,20 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		switch (chan->scan_index) {
-		case  CHANNEL_SCAN_INDEX_PRESENCE:
-			report_id = prox_state->prox_attr.report_id;
-			min = prox_state->prox_attr.logical_minimum;
-			address = HID_USAGE_SENSOR_HUMAN_PRESENCE;
-			hsdev = prox_state->common_attributes.hsdev;
-			break;
-		default:
-			report_id = -1;
-			break;
-		}
-		if (report_id >= 0) {
-			hid_sensor_power_state(&prox_state->common_attributes,
-						true);
-			*val = sensor_hub_input_attr_get_raw_value(
-				hsdev, hsdev->usage, address, report_id,
-				SENSOR_HUB_SYNC, min < 0);
-			hid_sensor_power_state(&prox_state->common_attributes,
-						false);
-		} else {
-			*val = 0;
+		if (chan->scan_index >= prox_state->num_channels)
 			return -EINVAL;
-		}
+		address = prox_state->channel2usage[chan->scan_index];
+		report_id = prox_state->prox_attr[chan->scan_index].report_id;
+		hsdev = prox_state->common_attributes.hsdev;
+		min = prox_state->prox_attr[chan->scan_index].logical_minimum;
+		hid_sensor_power_state(&prox_state->common_attributes, true);
+		*val = sensor_hub_input_attr_get_raw_value(hsdev,
+							   hsdev->usage,
+							   address,
+							   report_id,
+							   SENSOR_HUB_SYNC,
+							   min < 0);
+		hid_sensor_power_state(&prox_state->common_attributes, false);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -104,7 +115,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+			prox_state->prox_attr[chan->scan_index].unit_expo);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -179,48 +190,63 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct prox_state *prox_state = iio_priv(indio_dev);
-	int ret = -EINVAL;
-
-	switch (usage_id) {
-	case HID_USAGE_SENSOR_HUMAN_PRESENCE:
-		switch (raw_len) {
-		case 1:
-			prox_state->human_presence = *(u8 *)raw_data;
-			return 0;
-		case 4:
-			prox_state->human_presence = *(u32 *)raw_data;
-			return 0;
-		default:
+	int chan;
+
+	for (chan = 0; chan < prox_state->num_channels; chan++)
+		if (prox_state->channel2usage[chan] == usage_id)
 			break;
-		}
-		break;
+	if (chan == prox_state->num_channels)
+		return -EINVAL;
+
+	switch (raw_len) {
+	case 1:
+		prox_state->human_presence[chan] = *(u8 *)raw_data;
+		return 0;
+	case 4:
+		prox_state->human_presence[chan] = *(u32 *)raw_data;
+		return 0;
 	}
 
-	return ret;
+	return -EINVAL;
 }
 
 /* Parse report which is specific to an usage id*/
 static int prox_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
-				unsigned usage_id,
 				struct prox_state *st)
 {
+	struct iio_chan_spec *channels = st->channels;
+	int index = 0;
 	int ret;
+	int i;
+
+	for (i = 0; i < MAX_CHANNELS; i++) {
+		u32 usage_id = prox_usage_ids[i];
+
+		ret = sensor_hub_input_get_attribute_info(hsdev,
+							  HID_INPUT_REPORT,
+							  hsdev->usage,
+							  usage_id,
+							  &st->prox_attr[index]);
+		if (ret < 0)
+			continue;
+		st->channel2usage[index] = usage_id;
+		st->scan_mask[0] |= BIT(index);
+		channels[index] = prox_channels[i];
+		channels[index].scan_index = index;
+		prox_adjust_channel_bit_mask(channels, index,
+					     st->prox_attr[index].size);
+		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
+			st->prox_attr[index].report_id);
+		index++;
+	}
 
-	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
-			usage_id,
-			HID_USAGE_SENSOR_HUMAN_PRESENCE,
-			&st->prox_attr);
-	if (ret < 0)
+	if (!index)
 		return ret;
-	prox_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESENCE,
-					st->prox_attr.size);
 
-	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
-			st->prox_attr.report_id);
+	st->num_channels = index;
 
-	return ret;
+	return 0;
 }
 
 /* Function to initialize the processing for usage id */
@@ -251,22 +277,15 @@ static int hid_prox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, prox_channels,
-					   sizeof(prox_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		return -ENOMEM;
-	}
-
-	ret = prox_parse_report(pdev, hsdev,
-				(struct iio_chan_spec *)indio_dev->channels,
-				hsdev->usage, prox_state);
+	ret = prox_parse_report(pdev, hsdev, prox_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
 	}
 
-	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
+	indio_dev->num_channels = prox_state->num_channels;
+	indio_dev->channels = prox_state->channels;
+	indio_dev->available_scan_masks = prox_state->scan_mask;
 	indio_dev->info = &prox_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.47.0.163.g1226f6d8fa-goog


