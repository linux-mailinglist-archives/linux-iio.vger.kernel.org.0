Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0013526
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfECWDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41260 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfECWDQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so3533365pfd.8
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRgm0qDqKkO9nHce1jIyvsnpRoCozsYkiM3QTeACa/M=;
        b=kEJQb8Ggi8JIZDAqIR6BEWhyS5Lgt+lE4RYW7XlvPt1CliAZqqtV+2ITRI3LROH6zs
         A6F83E8q0q+gHehhZZQR7Cjw1+X2/ImYD9jT61oBO5JVCVNGhLpIBXeEw9bJ1kjarp4E
         bOESk1a4FANb0XT56/qLll2M6G48CAUCCUr7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRgm0qDqKkO9nHce1jIyvsnpRoCozsYkiM3QTeACa/M=;
        b=Jf4deTxl8uV+YYQxxMH98KVFmGLQOPgqcalnJ+7pcUuOGRBVYw+H0hp7hMcpyLcgEf
         Qlpamm9jgNPqGMWvV6AyBS1G2xrEGUW7hyozd2yY/N44RPykldQZROsjEf333YxerFRi
         OBto1ln9SsoExsASchm699ZXZbeh/bRFkdK+Ql53wayM4gO296y0TnaSCxJHeWYeFkkD
         EC08FNToPZKNYNXXj7L/9SDrSM7PsW/wBGy5gfiNuKhm3UTV6mTRshAybdnhycD+ojGW
         XnS8Ut6kb88rN4mQwXkKVqDLrOu5mkJq9Y8wbhRQfiuBHev8fd3ADvG1vkfKf/d2xnEH
         /9FQ==
X-Gm-Message-State: APjAAAWzMMcQ3Q+AH2k4Cc7mUFWD9mcw1WiockWxZ+wKTkqM/AKIrYwl
        YbT3q94m9550f1hKpWawm23YMQ==
X-Google-Smtp-Source: APXvYqwaByD00JCRJ1cESt6WorgkKEhgWw8iTNslqdb3gvD3bAAKNZdW5kQrkcH2uhTSleBF+TTcZw==
X-Received: by 2002:a63:778b:: with SMTP id s133mr13727689pgc.198.1556920996213;
        Fri, 03 May 2019 15:03:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 132sm4148388pfw.87.2019.05.03.15.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:15 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 20/30] mfd: cros_ec: Add API for keyboard testing
Date:   Fri,  3 May 2019 15:02:23 -0700
Message-Id: <20190503220233.64546-21-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add command to allow keyboard testing in factory.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 4784f3634793..88d08aa85738 100644
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

