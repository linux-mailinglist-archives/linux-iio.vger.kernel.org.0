Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5E2309474
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhA3KZV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 05:25:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:19457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231886AbhA3KZN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jan 2021 05:25:13 -0500
IronPort-SDR: IbdchUpkXVIjw2jSzcHirdzlawuQtDHjTVJxU0pomHw/z+zIOW/z34oiLbSpXkZ/iYsYt5LNu7
 sWUUqBebEAiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="244611581"
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="244611581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 02:24:30 -0800
IronPort-SDR: o1tgIpkYB/O50xQ1coZMJY5zsLOgYRvlA1ejoavRPDWa3seVBDCoXLzJX/4qSyME1Oyay7xbe/
 xc3hZeEZhWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="577066775"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2021 02:24:28 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2] iio: hid-sensor-prox: Fix scale not correct issue
Date:   Sat, 30 Jan 2021 18:25:30 +0800
Message-Id: <20210130102530.31064-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, the proxy sensor scale is zero because it just return the
exponent directly. To fix this issue, this patch use
hid_sensor_format_scale to process the scale first then return the
output.

Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
v2:
  - Add Fixes tag

---
 drivers/iio/light/hid-sensor-prox.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 4ab285a418d5..4abcfe48f1d4 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -23,6 +23,9 @@ struct prox_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info prox_attr;
 	u32 human_presence;
+	int scale_pre_decml;
+	int scale_post_decml;
+	int scale_precision;
 };
 
 static const u32 prox_sensitivity_addresses[] = {
@@ -98,8 +101,9 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		*val = prox_state->prox_attr.units;
-		ret_type = IIO_VAL_INT;
+		*val = prox_state->scale_pre_decml;
+		*val2 = prox_state->scale_post_decml;
+		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = hid_sensor_convert_exponent(
@@ -221,6 +225,11 @@ static int prox_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
 			st->prox_attr.report_id);
 
+	st->scale_precision = hid_sensor_format_scale(
+				hsdev->usage,
+				&st->prox_attr,
+				&st->scale_pre_decml, &st->scale_post_decml);
+
 	return ret;
 }
 
-- 
2.17.1

