Return-Path: <linux-iio+bounces-17395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A59A75EA7
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D39D165280
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799719CC20;
	Mon, 31 Mar 2025 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObGQu3Cj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D4194080;
	Mon, 31 Mar 2025 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400118; cv=none; b=fN3Oq68PIgEeYZw/6FNQPZ1SCtOcTBn+KGYBbxQ8grMS2howlAvILeJJL0EByoD6kd80BSqqvS4sF2kJzzrqstQPsX1+Bu6Lnyf8R/mUUS/ZJ8Vz3bnqxweROfLf4M1dMYUo4d6EoaGwT7Mli8n5zT74G2bY+3Ho2zUGwgLvgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400118; c=relaxed/simple;
	bh=+vxKVhsvhJkHa6QNu4XEE4U75KysTMqB44JBfd5QGwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOK1DPXR7E1rkT1LAxLGcRa+M3o7tMgYBaEw576/TW5fNdXT25DzYqe/1p/0gbJ0X6a1xiNSqdkta2PoDc3bRYy/rykKpEZNBLNJeaQUnjYPszecv8T8HETyx38fR/RJmN2KQpiP638Kl2Xoc66k4v53d4957sVRW+He7EVFulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObGQu3Cj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743400116; x=1774936116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vxKVhsvhJkHa6QNu4XEE4U75KysTMqB44JBfd5QGwA=;
  b=ObGQu3CjCpHP3ViZ5CYoAIJARjiXmkXHSmVrTGxM8uPDThpMy5JL3qn0
   ktUhMJCr72Dh43e18J0J9tzjyDNKDGNdHxuRkvR2/7dwDt5ECB/d8ixAy
   +zu3XZ3m9tj19U8vMvTz7stMLyDvEiXD4xb9j5XfkcpsnqHazhUpQkvAX
   qNWrBrUo3AyYdyuZnq4DrPlgDM2OcAz5iyRaFOw9fu+iaJGFHCmELBgnN
   //M4AINNZOGznZK0EAdAJM+w+LlqLSiW/3f9/hgmMw/KkiS8/66/6kxgs
   kLKIxoZuWYu4FwkwgT6jg617HybICx5DPLWFlWLwDHb+rDafucC2jJyX1
   g==;
X-CSE-ConnectionGUID: Y8jK15LkSmK3Qei51nstSg==
X-CSE-MsgGUID: XD+HKFhxQrOfK/6QUDKBXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="70037949"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="70037949"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 22:48:36 -0700
X-CSE-ConnectionGUID: jwL4HYIwSDSATlsZTHuaig==
X-CSE-MsgGUID: dm8/mrYhRxuREh2GUmHTEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131210240"
Received: from iscp-l-lixuzha.sh.intel.com ([10.239.153.157])
  by orviesa005.jf.intel.com with ESMTP; 30 Mar 2025 22:48:34 -0700
From: Zhang Lixu <lixu.zhang@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	peterz@infradead.org,
	gregkh@linuxfoundation.org,
	ribalda@chromium.org,
	archana.patni@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: lixu.zhang@intel.com,
	even.xu@intel.com
Subject: [PATCH 2/3] iio: hid-sensor-prox: support multi-channel SCALE calculation
Date: Mon, 31 Mar 2025 13:50:21 +0800
Message-ID: <20250331055022.1149736-3-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331055022.1149736-1-lixu.zhang@intel.com>
References: <20250331055022.1149736-1-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of multi-channel support in commit 596ef5cf654b
("iio: hid-sensor-prox: Add support for more channels"), each channel
requires an independent SCALE calculation, but the existing code only
calculates SCALE for a single channel.

Addresses the problem by modifying the driver to perform independent
SCALE calculations for each channel.

Cc: stable@vger.kernel.org
Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../hid-sensors/hid-sensor-attributes.c       |  4 ++++
 drivers/iio/light/hid-sensor-prox.c           | 24 ++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index ad1882f608c0..2055a03cbeb1 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -66,6 +66,10 @@ static struct {
 	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
 	{HID_USAGE_SENSOR_HINGE, 0, 0, 17453293},
 	{HID_USAGE_SENSOR_HINGE, HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},
+
+	{HID_USAGE_SENSOR_HUMAN_PRESENCE, 0, 1, 0},
+	{HID_USAGE_SENSOR_HUMAN_PROXIMITY, 0, 1, 0},
+	{HID_USAGE_SENSOR_HUMAN_ATTENTION, 0, 1, 0},
 };
 
 static void simple_div(int dividend, int divisor, int *whole,
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 1dc6fb7cf614..941508e58286 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -34,9 +34,9 @@ struct prox_state {
 	struct iio_chan_spec channels[MAX_CHANNELS];
 	u32 channel2usage[MAX_CHANNELS];
 	u32 human_presence[MAX_CHANNELS];
-	int scale_pre_decml;
-	int scale_post_decml;
-	int scale_precision;
+	int scale_pre_decml[MAX_CHANNELS];
+	int scale_post_decml[MAX_CHANNELS];
+	int scale_precision[MAX_CHANNELS];
 	unsigned long scan_mask[2]; /* One entry plus one terminator. */
 	int num_channels;
 };
@@ -116,9 +116,12 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		*val = prox_state->scale_pre_decml;
-		*val2 = prox_state->scale_post_decml;
-		ret_type = prox_state->scale_precision;
+		if (chan->scan_index >= prox_state->num_channels)
+			return -EINVAL;
+
+		*val = prox_state->scale_pre_decml[chan->scan_index];
+		*val2 = prox_state->scale_post_decml[chan->scan_index];
+		ret_type = prox_state->scale_precision[chan->scan_index];
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = hid_sensor_convert_exponent(
@@ -249,6 +252,10 @@ static int prox_parse_report(struct platform_device *pdev,
 					     st->prox_attr[index].size);
 		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
 			st->prox_attr[index].report_id);
+		st->scale_precision[index] =
+			hid_sensor_format_scale(usage_id, &st->prox_attr[index],
+						&st->scale_pre_decml[index],
+						&st->scale_post_decml[index]);
 		index++;
 	}
 
@@ -257,11 +264,6 @@ static int prox_parse_report(struct platform_device *pdev,
 
 	st->num_channels = index;
 
-	st->scale_precision = hid_sensor_format_scale(hsdev->usage,
-						      &st->prox_attr[0],
-						      &st->scale_pre_decml,
-						      &st->scale_post_decml);
-
 	return 0;
 }
 
-- 
2.43.0


