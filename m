Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0899E13523
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfECWDM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42349 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfECWDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so3227305pfw.9
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YdMBv2JbD+JMuVmqPdEWtBwMJQhsKyQHNFOHdvl1N0=;
        b=eJsxHrmwC2QbMKNCw6wdkeVDYXxoP1tLcZbMrimsNjsvUS6jk1V/T8nMJdqGAdD6Cb
         B9hGeT6WwVpKQxoKwO6oH1OJqRMIHPXQLbagoQP50PIyZfD+nWTiXKwprjiWq/lFhfo7
         Tn6cpGYiGzKxJrl9gc1Lmyxsq6ZtoT/uyFL9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YdMBv2JbD+JMuVmqPdEWtBwMJQhsKyQHNFOHdvl1N0=;
        b=CbVDtLosoStq56GrQdPgtoFKhNOr0MHBIIxErtytF/mAl5Zk7mj0kL+YI6GV17m7lO
         Y7ubUIFUAa51+SpYRnnfuGHFJjVyL/pWCDEi4ulqbnkm0LzlI+saK7D9MdyG0xvZisUu
         UGa1oD2Xox0RmTA1k+E7H8407DE8MSzFXvGcITXuqMC3dltyooKiXPx+N0G1bP9B2NIH
         1lJIvJVKPulQbU+yeMpxJ/EQobqFJJQynQhiSgcYVVQwF62+YAfn/H/CogeoeI16DNUT
         QNTmRNv4WPLY9V5LheEKmB94gvOmyPn1brlhzevGoHT48nzSNRI4lVne2TqR4mJDi9gt
         Y2qQ==
X-Gm-Message-State: APjAAAVAxzFqHCSQUOKJvPagxMJ9QirAh/UelMT54C1fANvY7jT9E6b7
        CR0SpGxWR6SuFHUSlxxO/xpT+g==
X-Google-Smtp-Source: APXvYqw5tCuqq+vYOC4kMN4VAag5nQaDGAjptCMcGAquI0SAsN4sRjIbD7bxOhn6RGSAe6MjN2PnOA==
X-Received: by 2002:a63:3dca:: with SMTP id k193mr13875616pga.146.1556920991276;
        Fri, 03 May 2019 15:03:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id g72sm8053070pfg.63.2019.05.03.15.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:10 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 17/30] mfd: cros_ec: Add fingerprint API
Date:   Fri,  3 May 2019 15:02:20 -0700
Message-Id: <20190503220233.64546-18-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for fingerprint sensors managed by embedded controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 2d59b4480876..399fedebc388 100644
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

