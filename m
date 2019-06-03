Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88A337FA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfFCSes (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44791 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfFCSer (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so8756821pgp.11
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11H9eJ6PsDChSyARkFGWtgFkqyq4bAPSq9amltsDDFQ=;
        b=PxfEqanv/PRY0M/VY4e1O9gn4s07yciX2RzwRkNeh2FKLAo974fldUJFmzbdHU2msY
         K3lfwXtSqyTQ4zAiun8HPxjjxJrltz8yAHX07HNCkwUY0jfcMtNFSEFkGliOFj5oLdeF
         P9dZuni3OAWZrcPdCd1G1IhAEd9Zk+/7Sbpw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11H9eJ6PsDChSyARkFGWtgFkqyq4bAPSq9amltsDDFQ=;
        b=PJI09qXs/rNSuqi9f2jvloo+xYV8qVdNO1jcN+HlLD9rfYcXbALntSVKPSdgHJX/lK
         HH6rSE0/Xym5VQYQYzdduuPhDjB1pYXZpClw8ATYqmKpPo14GecC6FCMKFrgvWY/WlBA
         sd+03J0kAhlvVC/JLM7RYHmyLEiSgn/nJgM4q9z/d29PtI0cHixV5Yvq6bP3/HENN3bc
         BvUYVmaaH1OJ1NHmLTsaY1jo6n1/zWASDTqIhmzZpWSFwfOd0j2BO5pEiZT6flr+nZUH
         HqJPweXD/7tP9+hB6547D0MZXHcAFdol/T9Rvt2t0uI9n/UxuqGuCZH8OMPr3SDBuz41
         E72A==
X-Gm-Message-State: APjAAAX/sUfeR2fij+N+qDQ9ttIW1gz6Hp20fIG2xeID1S9CObZT+dNq
        raJ4+gJbcMQ2NrvezLOeNj/Ekw==
X-Google-Smtp-Source: APXvYqwuAAvudQpkCNvX1FttFw+zwQdqr4m3Inozl8aJNBtybkzM7fS5SzEiIecujKL7X9T3XIFYuQ==
X-Received: by 2002:a62:a508:: with SMTP id v8mr32386909pfm.87.1559586886463;
        Mon, 03 Jun 2019 11:34:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 12sm5195115pfi.60.2019.06.03.11.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:45 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 25/30] mfd: cros_ec: Add API for Touchpad support
Date:   Mon,  3 Jun 2019 11:33:56 -0700
Message-Id: <20190603183401.151408-26-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API to control touchpad presented by Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
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

