Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8FC19457
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEIVPj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:15:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42220 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfEIVOd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so1949212pfw.9
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWvAY4K5cYu5xkAR+mJg2cVJek8r16jFV7NVls6qS9c=;
        b=JpW4Ryw8tqmPFPFAchXp1X9VT4fU2cbiQ0yBmM7ndRPotHYeBOZKfsSPNorkN5JNj/
         0KOUSxFVFO9NUTZwpAc+eWHb8oeSW2rxjUaX84f4sJrZLr4cf3xKCyVnTY72YV6/ZKoZ
         aJSIj+srJzho+5meGrzG3KMT73SBpeJy3StIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWvAY4K5cYu5xkAR+mJg2cVJek8r16jFV7NVls6qS9c=;
        b=l+f1pdKkq5N42nlzOesW4Pudz9Kb3YqeCkhiPBvE5p8TVLFF2O/7tQxg21ENXhkrd2
         jrUPuSQ5OOwUFeoi0MddvdarK3gW45P4LqlcsO+DyHKXkIaocAM3y7sNQ8KvmpN4PWBw
         S1Z+9RtDXkjoF3wDEHyRh+VFHsfF5Kv9PXPUSXP835TxVcgqtRzviEz9T2LRfOXoIHNh
         4PYmzBHKypaPwezf2RHdCsg88cZlLIiFxBh93V0M+BSuk/YLd6GwkpGudMKHuet3qaW/
         fO+qWYS0tzTli3DERW9xMNPDQg9LA7rkk+SbDFTo9EVZtuYjWneJNdmdJXdN28B9m5G/
         7u+w==
X-Gm-Message-State: APjAAAUxE+d7bhjusc+dhxYIK2hGqjX8OGrktXYEKpiCDlUDeqHaXyHX
        Yx10RhizBvIFFEGIGbX09oVByg==
X-Google-Smtp-Source: APXvYqx1Iq1e/sNoyrlAeNXcTzecx8lWKa66VICbey3qV9o32uy+N6ac81klOjDvLhAs0TAsGCsmhA==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr8570279pff.94.1557436473285;
        Thu, 09 May 2019 14:14:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n15sm6777740pfb.111.2019.05.09.14.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:32 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 20/30] mfd: cros_ec: Add API for keyboard testing
Date:   Thu,  9 May 2019 14:13:43 -0700
Message-Id: <20190509211353.213194-21-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add command to allow keyboard testing in factory.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index e05cdcb12481..cc054a0a4c4c 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3142,6 +3142,17 @@ struct ec_params_mkbp_simulate_key {
 	uint8_t pressed;
 } __ec_align1;
 
+#define EC_CMD_GET_KEYBOARD_ID 0x0063
+
+struct ec_response_keyboard_id {
+	uint32_t keyboard_id;
+} __ec_align4;
+
+enum keyboard_id {
+	KEYBOARD_ID_UNSUPPORTED = 0,
+	KEYBOARD_ID_UNREADABLE = 0xffffffff,
+};
+
 /* Configure keyboard scanning */
 #define EC_CMD_MKBP_SET_CONFIG 0x0064
 #define EC_CMD_MKBP_GET_CONFIG 0x0065
@@ -3390,6 +3401,13 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
 
+/* Run keyboard factory test scanning */
+#define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
+
+struct ec_response_keyboard_factory_test {
+	uint16_t shorted;	/* Keyboard pins are shorted */
+} __ec_align2;
+
 /* Fingerprint events in 'fp_events' for EC_MKBP_EVENT_FINGERPRINT */
 #define EC_MKBP_FP_RAW_EVENT(fp_events) ((fp_events) & 0x00FFFFFF)
 #define EC_MKBP_FP_ERRCODE(fp_events)   ((fp_events) & 0x0000000F)
-- 
2.21.0.1020.gf2820cf01a-goog

