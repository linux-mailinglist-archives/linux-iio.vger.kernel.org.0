Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A929C337F9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfFCSer (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34807 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfFCSeq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so5530418pgg.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NaNtriandagKTH+nKDm0iG18Zrt/l9rmC8aTpCwi3m0=;
        b=OGHKEUdhveeHs3KKm9jsMUUqV3TljN9BF6iAyRlHPGgaEaNKf+wsSy0rrxeYx1IquL
         W1Yksoj0D7V9psraLBm7Taq6Icr47mJw8xZildScfr8WO988FbWVy33YFyIPTHxImauI
         f7c1jfLYFPo5PB3z3gR00r0pTh28T526nOdg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NaNtriandagKTH+nKDm0iG18Zrt/l9rmC8aTpCwi3m0=;
        b=FwQM3bOaLk8WlRnZMZkcxtQoTD6Hn1ekZeAzttgTovV++XTuy0bfoZOFPqPVof/yfF
         3Yp8hlFV9XLdYd2JTEwUQLfcPRtUjLWBzotx38Ifc/X+bb4ymz+l9hOCddNxZIccDf8s
         i5isxf0EKqeKlQ24JYJ+bA/2MQ+uE9bkEjxPg3QaAsqDKLegiNv8N8WkgxeQYKgBq5KI
         LNAUJYoiqNNUFK2kBVhrRIZYI8xmMybBi5fiSmvymbQ07WLjb7mykl5izslENEJHiZZz
         +1PB39HifIguKUJxr5edFviuzeC7lTJfr8acrGZwsUmvFWy41fF76lemIh5YVSuVGyop
         Lx5w==
X-Gm-Message-State: APjAAAXj2y3cBjTNcRssE5NlZOcezAN9+VLKkPvB3rpCfX9SRvedWnUk
        RHVU9r1EYVUsgWVUaPb1T/cCUg==
X-Google-Smtp-Source: APXvYqw02F/8+mcF+7TMVGY3mnFmSOL1CqYIDjvPQDFSSjVFvMq6Q0dTaZKJw5mvCLSVQDGJ5ugDFA==
X-Received: by 2002:a63:9548:: with SMTP id t8mr30121025pgn.256.1559586884983;
        Mon, 03 Jun 2019 11:34:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id w62sm2394356pfw.132.2019.06.03.11.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:44 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 24/30] mfd: cros_ec: Add API for EC-EC communication
Date:   Mon,  3 Jun 2019 11:33:55 -0700
Message-Id: <20190603183401.151408-25-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow EC to talk to other ECs that are not presented to the host.
Neeed when EC are present in detachable keyboard.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 59ad6bae3f9b..52fd9bfafc7f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,101 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/*****************************************************************************/
+/* EC-EC communication commands: range 0x0600-0x06FF */
+
+#define EC_COMM_TEXT_MAX 8
+
+/*
+ * Get battery static information, i.e. information that never changes, or
+ * very infrequently.
+ */
+#define EC_CMD_BATTERY_GET_STATIC 0x0600
+
+/**
+ * struct ec_params_battery_static_info - Battery static info parameters
+ * @index: Battery index.
+ */
+struct ec_params_battery_static_info {
+	uint8_t index;
+} __ec_align_size1;
+
+/**
+ * struct ec_response_battery_static_info - Battery static info response
+ * @design_capacity: Battery Design Capacity (mAh)
+ * @design_voltage: Battery Design Voltage (mV)
+ * @manufacturer: Battery Manufacturer String
+ * @model: Battery Model Number String
+ * @serial: Battery Serial Number String
+ * @type: Battery Type String
+ * @cycle_count: Battery Cycle Count
+ */
+struct ec_response_battery_static_info {
+	uint16_t design_capacity;
+	uint16_t design_voltage;
+	char manufacturer[EC_COMM_TEXT_MAX];
+	char model[EC_COMM_TEXT_MAX];
+	char serial[EC_COMM_TEXT_MAX];
+	char type[EC_COMM_TEXT_MAX];
+	/* TODO(crbug.com/795991): Consider moving to dynamic structure. */
+	uint32_t cycle_count;
+} __ec_align4;
+
+/*
+ * Get battery dynamic information, i.e. information that is likely to change
+ * every time it is read.
+ */
+#define EC_CMD_BATTERY_GET_DYNAMIC 0x0601
+
+/**
+ * struct ec_params_battery_dynamic_info - Battery dynamic info parameters
+ * @index: Battery index.
+ */
+struct ec_params_battery_dynamic_info {
+	uint8_t index;
+} __ec_align_size1;
+
+/**
+ * struct ec_response_battery_dynamic_info - Battery dynamic info response
+ * @actual_voltage: Battery voltage (mV)
+ * @actual_current: Battery current (mA); negative=discharging
+ * @remaining_capacity: Remaining capacity (mAh)
+ * @full_capacity: Capacity (mAh, might change occasionally)
+ * @flags: Flags, see EC_BATT_FLAG_*
+ * @desired_voltage: Charging voltage desired by battery (mV)
+ * @desired_current: Charging current desired by battery (mA)
+ */
+struct ec_response_battery_dynamic_info {
+	int16_t actual_voltage;
+	int16_t actual_current;
+	int16_t remaining_capacity;
+	int16_t full_capacity;
+	int16_t flags;
+	int16_t desired_voltage;
+	int16_t desired_current;
+} __ec_align2;
+
+/*
+ * Control charger chip. Used to control charger chip on the slave.
+ */
+#define EC_CMD_CHARGER_CONTROL 0x0602
+
+/**
+ * struct ec_params_charger_control - Charger control parameters
+ * @max_current: Charger current (mA). Positive to allow base to draw up to
+ *     max_current and (possibly) charge battery, negative to request current
+ *     from base (OTG).
+ * @otg_voltage: Voltage (mV) to use in OTG mode, ignored if max_current is
+ *     >= 0.
+ * @allow_charging: Allow base battery charging (only makes sense if
+ *     max_current > 0).
+ */
+struct ec_params_charger_control {
+	int16_t max_current;
+	uint16_t otg_voltage;
+	uint8_t allow_charging;
+} __ec_align_size1;
+
 /*****************************************************************************/
 /*
  * Reserve a range of host commands for board-specific, experimental, or
-- 
2.21.0.1020.gf2820cf01a-goog

