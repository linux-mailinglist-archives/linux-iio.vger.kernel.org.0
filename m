Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BBD1352B
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfECWDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36391 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfECWDY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so3346674pgc.3
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av7W5ynTFf4qECgZY1aSKemrc6LUQhXC9NlzuZ12Hu4=;
        b=YoYGS1F1oQXjukBhnrK7t6lGE2Tg29COzefrmIkQ6mGImiL3BLJ92f4PEqNxBPM3fR
         Z5vPlUfkJg6BIHFdZwtNYXSnxzHjylfOhpq7wUl1budX4PbRRu1id/ExV8hy/jvjM9G8
         +ofIx9lhjnZP7HcFpfp6q/RUiDRDLCB16uM1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av7W5ynTFf4qECgZY1aSKemrc6LUQhXC9NlzuZ12Hu4=;
        b=ISezwY5A4wOZDE1ffqAYDzuT3Pgp6aMmZMSMqYLjoHlBMc8jvnaBXrTC++eVIZcjUp
         fvBcDgZJD1ARi7zfL2xYkENVqXZwqrXEARTjdzl0uUzv+bMRsnR8JJzBpf9zOx6fKH6V
         tPUIkOjgm6zG6pKn7iUFmxk9ZRM1F6yrSyEqaxv9gocBgDISJ71WO0iiYS8I0iwcSC6G
         yKKKt0ZpFLifysoqYphbYFaLDJN82Z8aMvgee7bspdAYJVwr8McpWts6bBVpvGVGSR/X
         kZYAmNs/exI/v8Ye2dgxs+fiS+jpfrtvWSmdII3xXwAGarfCFX9wJGFThX8M9r4d0in7
         9vwg==
X-Gm-Message-State: APjAAAX1hBWwZt7piotrskHp4fTyhrXmPLlA5xPSwz+a/6Wge+lBTW9q
        e/mhwal33Cp+xpGvIHkDOZIBGA==
X-Google-Smtp-Source: APXvYqwHuNR0rW4qS/p65gY4BZJtqs4GTLUnV/TC2lkxU7YO7LxbSGm8WH2nSWsutq1pXSfgqda8lA==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr14486184pfa.200.1556921004119;
        Fri, 03 May 2019 15:03:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a6sm4097402pfn.181.2019.05.03.15.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:23 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 25/30] mfd: cros_ec: Add API for Touchpad support
Date:   Fri,  3 May 2019 15:02:28 -0700
Message-Id: <20190503220233.64546-26-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API to control touchpad presented by Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 52fd9bfafc7f..1d0311df44d3 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,32 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/*****************************************************************************/
+/* Touchpad MCU commands: range 0x0500-0x05FF */
+
+/* Perform touchpad self test */
+#define EC_CMD_TP_SELF_TEST 0x0500
+
+/* Get number of frame types, and the size of each type */
+#define EC_CMD_TP_FRAME_INFO 0x0501
+
+struct ec_response_tp_frame_info {
+	uint32_t n_frames;
+	uint32_t frame_sizes[0];
+} __ec_align4;
+
+/* Create a snapshot of current frame readings */
+#define EC_CMD_TP_FRAME_SNAPSHOT 0x0502
+
+/* Read the frame */
+#define EC_CMD_TP_FRAME_GET 0x0503
+
+struct ec_params_tp_frame_get {
+	uint32_t frame_index;
+	uint32_t offset;
+	uint32_t size;
+} __ec_align4;
+
 /*****************************************************************************/
 /* EC-EC communication commands: range 0x0600-0x06FF */
 
-- 
2.21.0.1020.gf2820cf01a-goog

