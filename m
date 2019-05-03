Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA213529
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfECWDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35447 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfECWDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so2960267pfa.2
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7jf11BSROJYGYWGaMhdpSMdF9KlDBwardIcOhZ2vpE=;
        b=EYBs6j1u0ar6LZWMBPa86O/T+vhocQtHOspqto4ssJRYHXEOM+oclp5oo9qqEVSXJE
         iGjb5qXVAba/toGOcYwwd08qubZYp4aic0BGEbf+ZZXh+YqF0c0t++xBwveBanRismxc
         MG7ABlf5AgEJukxjvW/dfWTIhwFyPp/IFVWXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7jf11BSROJYGYWGaMhdpSMdF9KlDBwardIcOhZ2vpE=;
        b=IjNy87rVrCkjIV/z/DxbZ8iCw/qjq0UpI9fYlLgJl4nqKCg/Hjjxyu3IYCHFb+H7fi
         mxD9F4uMjPbTALGMOM1SQxv95kMnuqKicu3HqqChjFw8OPRqeKspiBMI7StsWBHePbsi
         Cpicj9fGjVGoL9zb+Yrl+BK4yUMVDzVp4tgZjT1jBhpeEETsxrSiepqFbXbgdfjWUjQc
         1j0iGkPv+Y4GLagMpC8cRRXl0exWh2WOG38tLkhOGtAhLgiRLi4mozkcr0YGLTWemcvh
         cPvr5jvn4DsdpEVU+UcncxXkKQ3p8MB3OG7/I2WQZROQqaVdlVp/BL6N5hQsADGhnpqi
         0ibw==
X-Gm-Message-State: APjAAAWbNVPIpxZQmt0Q/uAOCM5bWVm+F7l++w9TPqoPCK6HE0pkqZwn
        W/k/Ujl+wUyfRgDv290rEpnNhw==
X-Google-Smtp-Source: APXvYqxg3DK7BDo0zppzRV9+Yt/49X75Nmj33RT+e5uAVKjOE1je0wqzV6pqO1AUwhuUXWk6YH9LOw==
X-Received: by 2002:a65:4c07:: with SMTP id u7mr13282550pgq.93.1556921000826;
        Fri, 03 May 2019 15:03:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m131sm7612238pfc.25.2019.05.03.15.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:20 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 23/30] mfd: cros_ec: Add I2C passthru protection API
Date:   Fri,  3 May 2019 15:02:26 -0700
Message-Id: <20190503220233.64546-24-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Prevent direct i2c access to device behind EC when not in development mode.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

