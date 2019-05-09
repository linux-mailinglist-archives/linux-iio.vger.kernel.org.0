Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581AA1944A
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEIVOm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38597 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfEIVOi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so1836485pgl.5
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Km0HSMOyBXYCQtJGjyx5C/OgWQFqPAevnijYAPrBruQ=;
        b=mzdmu5oOdFep4gcvfDlsS3/z7Xp98Kueq+NJT4yQ8eLemoMaje+ZFPhC1hF4Xmt0MO
         FlnpG7OR6OEC+2tq8H6RiGxHlQgXAyJN0Vt/blua1hUYuac79zrX6sA4oVkjdL8Ccnuu
         BwOBjczt3BSVPk3wJozhJcqeFgqU17fJxUWV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Km0HSMOyBXYCQtJGjyx5C/OgWQFqPAevnijYAPrBruQ=;
        b=cV5SGSjVCuBdHK+DNC01B3vWdrZxkea8uQ/nH3HgFluqXeCbrIHJmlMt/R/ar6+4j4
         YrgDdu+JpC1BZt1uXTYtUVRawS9VpYF3zF1vgvqchtJcdVaBNZG5CpOUszuCsM1cAVX/
         0992EQ3rg8vVHJ+FhPyNv/IMlhiwHI3Hn8GJiJs9V6RqH6XHzXjRzAnWg308qvk84EBt
         gycOm2Xna0D8pDBLMqY3K5q9k/Zfvzj6Lv6e0NM924RsPHw7/5dEv/MKzJW9qT3eh7Na
         gegBuzknTadG0uOn7dIYJ7eJKBkN2Q/iXNupUm3F/KyGOWAKd81DW1QpMZmtvbDxHpuD
         uWaw==
X-Gm-Message-State: APjAAAWfCAN60gkqrUbLdVI+SYNi7EjIh6yEardoAljcoJU9fkPuucWw
        S8ehhzNe7l5T/ntC+egUb7Vo+g==
X-Google-Smtp-Source: APXvYqyX9kpfnQLUoODDaqEll/D8VDVJQLK3jZJAbZP8QNPZVQaHK3XCjgPRR2kicSM8uffpRvofKw==
X-Received: by 2002:a62:304:: with SMTP id 4mr8255011pfd.99.1557436477869;
        Thu, 09 May 2019 14:14:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a3sm3250265pgl.74.2019.05.09.14.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 23/30] mfd: cros_ec: Add I2C passthru protection API
Date:   Thu,  9 May 2019 14:13:46 -0700
Message-Id: <20190509211353.213194-24-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Prevent direct i2c access to device behind EC when not in development mode.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 49ea905cfd18..59ad6bae3f9b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4316,6 +4316,28 @@ struct ec_params_entering_mode {
 #define VBOOT_MODE_DEVELOPER 1
 #define VBOOT_MODE_RECOVERY  2
 
+/*****************************************************************************/
+/*
+ * I2C passthru protection command: Protects I2C tunnels against access on
+ * certain addresses (board-specific).
+ */
+#define EC_CMD_I2C_PASSTHRU_PROTECT 0x00B7
+
+enum ec_i2c_passthru_protect_subcmd {
+	EC_CMD_I2C_PASSTHRU_PROTECT_STATUS = 0x0,
+	EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE = 0x1,
+};
+
+struct ec_params_i2c_passthru_protect {
+	uint8_t subcmd;
+	uint8_t port;		/* I2C port number */
+} __ec_align1;
+
+struct ec_response_i2c_passthru_protect {
+	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
+} __ec_align1;
+
+
 /*****************************************************************************/
 /*
  * HDMI CEC commands
-- 
2.21.0.1020.gf2820cf01a-goog

