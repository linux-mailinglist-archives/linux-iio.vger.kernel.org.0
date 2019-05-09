Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412DB19454
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEIVPa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:15:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37471 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfEIVOf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1835877pgc.4
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcz1eqcuD73T/NcdIkbFXLwMtkZSGY486wHQZ5MgZj0=;
        b=Zfpt5xg3AxUyQfo8Abyg4ogJXok/St2aZrREtayCmA7BJtNKUrMRpzYLgQhVp8epax
         8X6De6AkM85K2V9mwGPumIuJ4JxnQtMTvXU5RGjInwp3/9deUJM/NvREnuT/LzCF1y91
         GofwX0UiSkq5Vx/fbHbbIFKCYEWUZ7+VXPRyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcz1eqcuD73T/NcdIkbFXLwMtkZSGY486wHQZ5MgZj0=;
        b=HRPYGvIUG7J+8SSXDlo1PvlMtmSA8mPUIPqFdtIO6f3TMKGdaFaWIJfigkFpI9bW3h
         4yWKdr3TLUHJi49TDBQDGqfxuIOkrCo4UaekfHeRrfK7Ooo7lTh7DLFx4863NeJzqOnF
         AqWbWVtHnV3aW8dVdkMF/fgrxJkLMf94YrL3ion6qw1sJTuY0fmb/QBQu0RoWVSEDLy0
         P0UHN27IQOC4qsiTjBUSyZ3iylpnoWRaKTs68AgxYu/gsA8jN7N8MUYqjF8WE9vwGhbN
         Tt/a7wZVknYb2ZEIaD0kFMpZdDS0J1veHZMg30Df6rhlVRaAXFUeRnpmrzIa1SOJeAJN
         sMDg==
X-Gm-Message-State: APjAAAXLVWYm4ahHJt6bONbaRR9J9KtrKO4oGN5v+WYwjFAmjBWjqMpJ
        x0/kXRFcNGL5ffdQxy4uC+ddcg==
X-Google-Smtp-Source: APXvYqz042zmYNJ4m/qpAeFzE/1gR0DwW34FrcjHP7YYL9ft7HjvOA7U92isJkKJvsl71wPm4dexyQ==
X-Received: by 2002:a65:5941:: with SMTP id g1mr8699957pgu.51.1557436474785;
        Thu, 09 May 2019 14:14:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id e8sm5128546pfc.47.2019.05.09.14.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 21/30] mfd: cros_ec: Add Hibernate API
Date:   Thu,  9 May 2019 14:13:44 -0700
Message-Id: <20190509211353.213194-22-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for controlling hibernation of the Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 72 +++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index cc054a0a4c4c..7f98c6e63ad1 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4045,6 +4045,40 @@ struct ec_params_dedicated_charger_limit {
 	uint16_t voltage_lim; /* in mV */
 } __ec_align2;
 
+/*****************************************************************************/
+/* Hibernate/Deep Sleep Commands */
+
+/* Set the delay before going into hibernation. */
+#define EC_CMD_HIBERNATION_DELAY 0x00A8
+
+struct ec_params_hibernation_delay {
+	/*
+	 * Seconds to wait in G3 before hibernate.  Pass in 0 to read the
+	 * current settings without changing them.
+	 */
+	uint32_t seconds;
+} __ec_align4;
+
+struct ec_response_hibernation_delay {
+	/*
+	 * The current time in seconds in which the system has been in the G3
+	 * state.  This value is reset if the EC transitions out of G3.
+	 */
+	uint32_t time_g3;
+
+	/*
+	 * The current time remaining in seconds until the EC should hibernate.
+	 * This value is also reset if the EC transitions out of G3.
+	 */
+	uint32_t time_remaining;
+
+	/*
+	 * The current time in seconds that the EC should wait in G3 before
+	 * hibernating.
+	 */
+	uint32_t hibernate_delay;
+} __ec_align4;
+
 /* Inform the EC when entering a sleep state */
 #define EC_CMD_HOST_SLEEP_EVENT 0x00A9
 
@@ -4052,7 +4086,9 @@ enum host_sleep_event {
 	HOST_SLEEP_EVENT_S3_SUSPEND   = 1,
 	HOST_SLEEP_EVENT_S3_RESUME    = 2,
 	HOST_SLEEP_EVENT_S0IX_SUSPEND = 3,
-	HOST_SLEEP_EVENT_S0IX_RESUME  = 4
+	HOST_SLEEP_EVENT_S0IX_RESUME  = 4,
+	/* S3 suspend with additional enabled wake sources */
+	HOST_SLEEP_EVENT_S3_WAKEABLE_SUSPEND = 5,
 };
 
 struct ec_params_host_sleep_event {
@@ -4116,6 +4152,36 @@ struct ec_response_host_sleep_event_v1 {
 	};
 } __ec_align4;
 
+/*****************************************************************************/
+/* Device events */
+#define EC_CMD_DEVICE_EVENT 0x00AA
+
+enum ec_device_event {
+	EC_DEVICE_EVENT_TRACKPAD,
+	EC_DEVICE_EVENT_DSP,
+	EC_DEVICE_EVENT_WIFI,
+};
+
+enum ec_device_event_param {
+	/* Get and clear pending device events */
+	EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS,
+	/* Get device event mask */
+	EC_DEVICE_EVENT_PARAM_GET_ENABLED_EVENTS,
+	/* Set device event mask */
+	EC_DEVICE_EVENT_PARAM_SET_ENABLED_EVENTS,
+};
+
+#define EC_DEVICE_EVENT_MASK(event_code) BIT(event_code % 32)
+
+struct ec_params_device_event {
+	uint32_t event_mask;
+	uint8_t param;
+} __ec_align_size1;
+
+struct ec_response_device_event {
+	uint32_t event_mask;
+} __ec_align4;
+
 /*****************************************************************************/
 /* Smart battery pass-through */
 
@@ -4361,12 +4427,14 @@ enum ec_reboot_cmd {
 	/* (command 3 was jump to RW-B) */
 	EC_REBOOT_COLD = 4,          /* Cold-reboot */
 	EC_REBOOT_DISABLE_JUMP = 5,  /* Disable jump until next reboot */
-	EC_REBOOT_HIBERNATE = 6      /* Hibernate EC */
+	EC_REBOOT_HIBERNATE = 6,     /* Hibernate EC */
+	EC_REBOOT_HIBERNATE_CLEAR_AP_OFF = 7, /* and clears AP_OFF flag */
 };
 
 /* Flags for ec_params_reboot_ec.reboot_flags */
 #define EC_REBOOT_FLAG_RESERVED0      BIT(0)  /* Was recovery request */
 #define EC_REBOOT_FLAG_ON_AP_SHUTDOWN BIT(1)  /* Reboot after AP shutdown */
+#define EC_REBOOT_FLAG_SWITCH_RW_SLOT BIT(2)  /* Switch RW slot */
 
 struct ec_params_reboot_ec {
 	uint8_t cmd;           /* enum ec_reboot_cmd */
-- 
2.21.0.1020.gf2820cf01a-goog

