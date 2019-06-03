Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241BA33812
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFCSgA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:36:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfFCSej (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so10396334pfa.5
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nb+PgCRBJxop3uf8r602eq6y1vRy3WUbzAXUz/wfEs8=;
        b=Exrmzr0Pv/rn0cesaXFdN43DSBj2vNYxvfrY407IBv+l8PAtUViJ4o5BsGkSd8hC1e
         dAXXdBgfcyfXEF2tE1H04cZ3qv0MBzYhXVTP3RDpCW8LxKcV9D3VTTiTQPpKPO/guJpF
         ATlu/13n9et54oqDsAQD54G0uDMLDZCKGG29Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nb+PgCRBJxop3uf8r602eq6y1vRy3WUbzAXUz/wfEs8=;
        b=cLo9ocAF83XX6YyKcG7/RWJzG0+1U3lkURPs21IJB38Qao35Z5Ffvk6qbREgeJXLOh
         Z/pzKKIcQYoOWJkboCP/S9n0KHaecA4N8yIn5R0apgL9DjTJFKDQBrJ95dKkWIZ+Qas7
         g12I1HbH0i7jUND3hJni3OWylRw2++BU1FMF+9vG3QbNusj9EEcikTPeNoIi4F8MY/Eu
         KQ4MeoX12BrAmN5MnI7+nDIPqeBEjWzMWsL+2E8fm4apg0urKRhhadI1zOvEHweFDuD4
         7l9P9u1o+zZ3EN+Vz152sTFp+P3zr3JEzQfJlMkpHVGl7MTGqxP78rH2ynArC4YYVXow
         WMbg==
X-Gm-Message-State: APjAAAVt4S46gHBm7RydAt10Y+pE7f1GRKVnnAWBtdqUugs00KcUxCUf
        9Asi5qEhKyJVY9egRShhnzP2VA==
X-Google-Smtp-Source: APXvYqzg2GsQdPQCqzTAsGUqBYg9mmxxW5ZwdJcwGOJjC1wRZk/Qg4qCH7oPmmhSJS7pMvVSqynP6A==
X-Received: by 2002:a17:90a:af8a:: with SMTP id w10mr32552517pjq.132.1559586878476;
        Mon, 03 Jun 2019 11:34:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j22sm21415275pfn.121.2019.06.03.11.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 20/30] mfd: cros_ec: Add API for keyboard testing
Date:   Mon,  3 Jun 2019 11:33:51 -0700
Message-Id: <20190603183401.151408-21-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add command to allow keyboard testing in factory.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
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

