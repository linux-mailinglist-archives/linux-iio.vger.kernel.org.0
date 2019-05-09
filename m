Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7464819440
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfEIVOp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39126 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfEIVOm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so1955780pfg.6
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+h3ZCcM9MpDCep6vj98M9256/ZFO8iCeubysmTQphKw=;
        b=RPxSnOuaT+7NiAnWU9r2lkLt4O5o81vjUi5euxKDdMKugrsCE2PO3HyjiNWHXWobro
         JAuJTgafQ9RNgrozFxjdwHc1kWQfBcrGPHdytv4WtNPkGLt9GgUZ4PBrBEpEjCclkJcZ
         x5XJBT3pGWQw/ZdcC5V3Ca6RxmcMTyw5XlzZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+h3ZCcM9MpDCep6vj98M9256/ZFO8iCeubysmTQphKw=;
        b=mtYduZY+fNb4D8Z2DIw7lN7F1aOM6wuBQToZ8zGTaCNQhlWV0lLO/cJOsV5s0CLod2
         U2Va2RuQUQvmqJiML+ZBE2NZSjz6Vfup2g21eYKqay3EVAuH+E5TN6U52eLqhNvajlcH
         TRt4JAKpsA4hdOyhndI/ca0Vpl+yysXxfAqYQhDJIqoPuCRJImR/KAMkHhuHeiHZGv/x
         W08n3WkjbFij3cT9KUd8kgnR0HyeoNZ20vo62Ui5Y+Ri7Nq5nWRv9iG6yfdYu4yEFOt8
         jHXb7fU9mCr6TkAwj1Wd8X0mcNSkyZKRSh/bk6qSFl4VOGrs6ATAbRmDBad0PtWnOnZG
         tMxw==
X-Gm-Message-State: APjAAAXBOK/V9ggdkAOxEY+dq16Vj9r/eElwwRCcZcVQzJpDKEr06xtr
        0eXEkkmzpqUCc1a5xyM34M7Gn31d5tM=
X-Google-Smtp-Source: APXvYqybvV1SDSpdMntWVGN1RGD3itiZ/UQtphKXBoQYbxE0T7Kq2owXdemONr3wy8wdfEMwbhF3ug==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr8645706pgl.66.1557436481339;
        Thu, 09 May 2019 14:14:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y10sm4787693pfm.27.2019.05.09.14.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:40 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 25/30] mfd: cros_ec: Add API for Touchpad support
Date:   Thu,  9 May 2019 14:13:48 -0700
Message-Id: <20190509211353.213194-26-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API to control touchpad presented by Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
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

