Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189D933818
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfFCSed (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfFCSed (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so11118206pfd.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Q5ohVO1OqabqQIYEP+a5LR6P7rjV/1FiAk0nQ9dg3U=;
        b=kIWkGoGsBf1Dn+PIecWL9cDlTWMG7FvB/qjVHEvNLOFEttLco3j/IDldjRGe+RwZxq
         sqn9soI42IBFQ4wXfpA3zVYMHnMLm3tESmLRt+Yf7cI548y96bycVrt9H3rOpq53B7Dl
         mj3VTM+BmnhETSiiLyp90jpaLp2T1omtAeobk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Q5ohVO1OqabqQIYEP+a5LR6P7rjV/1FiAk0nQ9dg3U=;
        b=sVC/OBFhvcKgPW5Ev/mLLgEV4zg9KRA+FbWCnWtQLUonQohXMbgGWVj8DRiuob+nh8
         QXa2pqxVi5R1wF+EUpwD0RHTNltD3tkE4iHSx7ITz0NiGaj3tE/n+jto6P80a8rNEZC7
         yhL1MKWTTdKGsD+EFmQd6mRRRxJZVkQEoylN8FxvrEBdK4gDwt4juoIiQXTwo4yUSrhX
         74ukKywbcTBNL81OE7UIUeHId3DYfutD0SIu9QxkwLSC1noM8mv3sZgkjUTE84F7q5ko
         vSW86W2kP3+tVW638WK6DV27Vf6sLp51X9rLVoIJUzQQ5MDrSSGDSVvjkDpTGzE/Wv2l
         Ff7w==
X-Gm-Message-State: APjAAAX/l4G3gu870pvF2fFMA6zK/XXvjbjrYs/SLoK7m61YlmSKCPTY
        D8Yq9gzFHMmyGFtmeB4/t/spXzdBrHS09g==
X-Google-Smtp-Source: APXvYqy1aXQOOsXURiPC60xUrdJvpoRoNA6SZNM0qFgd8ipXN5iejhpvYrpeS+rZu7uoZ6kx7PqY7w==
X-Received: by 2002:a63:e50c:: with SMTP id r12mr30150157pgh.284.1559586872406;
        Mon, 03 Jun 2019 11:34:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m1sm14088745pjv.22.2019.06.03.11.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:31 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 17/30] mfd: cros_ec: Add fingerprint API
Date:   Mon,  3 Jun 2019 11:33:48 -0700
Message-Id: <20190603183401.151408-18-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for fingerprint sensors managed by embedded controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 51fe65170ce6..d5d07a9957ec 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3339,6 +3339,40 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
 
+/* Fingerprint events in 'fp_events' for EC_MKBP_EVENT_FINGERPRINT */
+#define EC_MKBP_FP_RAW_EVENT(fp_events) ((fp_events) & 0x00FFFFFF)
+#define EC_MKBP_FP_ERRCODE(fp_events)   ((fp_events) & 0x0000000F)
+#define EC_MKBP_FP_ENROLL_PROGRESS_OFFSET 4
+#define EC_MKBP_FP_ENROLL_PROGRESS(fpe) (((fpe) & 0x00000FF0) \
+					 >> EC_MKBP_FP_ENROLL_PROGRESS_OFFSET)
+#define EC_MKBP_FP_MATCH_IDX_OFFSET 12
+#define EC_MKBP_FP_MATCH_IDX_MASK 0x0000F000
+#define EC_MKBP_FP_MATCH_IDX(fpe) (((fpe) & EC_MKBP_FP_MATCH_IDX_MASK) \
+					 >> EC_MKBP_FP_MATCH_IDX_OFFSET)
+#define EC_MKBP_FP_ENROLL               BIT(27)
+#define EC_MKBP_FP_MATCH                BIT(28)
+#define EC_MKBP_FP_FINGER_DOWN          BIT(29)
+#define EC_MKBP_FP_FINGER_UP            BIT(30)
+#define EC_MKBP_FP_IMAGE_READY          BIT(31)
+/* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_ENROLL is set */
+#define EC_MKBP_FP_ERR_ENROLL_OK               0
+#define EC_MKBP_FP_ERR_ENROLL_LOW_QUALITY      1
+#define EC_MKBP_FP_ERR_ENROLL_IMMOBILE         2
+#define EC_MKBP_FP_ERR_ENROLL_LOW_COVERAGE     3
+#define EC_MKBP_FP_ERR_ENROLL_INTERNAL         5
+/* Can be used to detect if image was usable for enrollment or not. */
+#define EC_MKBP_FP_ERR_ENROLL_PROBLEM_MASK     1
+/* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_MATCH is set */
+#define EC_MKBP_FP_ERR_MATCH_NO                0
+#define EC_MKBP_FP_ERR_MATCH_NO_INTERNAL       6
+#define EC_MKBP_FP_ERR_MATCH_NO_TEMPLATES      7
+#define EC_MKBP_FP_ERR_MATCH_NO_LOW_QUALITY    2
+#define EC_MKBP_FP_ERR_MATCH_NO_LOW_COVERAGE   4
+#define EC_MKBP_FP_ERR_MATCH_YES               1
+#define EC_MKBP_FP_ERR_MATCH_YES_UPDATED       3
+#define EC_MKBP_FP_ERR_MATCH_YES_UPDATE_FAILED 5
+
+
 /*****************************************************************************/
 /* Temperature sensor commands */
 
-- 
2.21.0.1020.gf2820cf01a-goog

