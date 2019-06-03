Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15953380F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFCSfp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:35:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46080 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfFCSeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5564415pls.13
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gs3RkhSChaOfEUoWHB9Wz2G7G555U9/P3rBO605JBRM=;
        b=jzLnNqUS1j/McakM7dg5wqpGsZjd5lvealKhrH4q5I1IIhBtPcIlxlaBPTEedX6adW
         GzH72gNQOZ1KJE6gr2mbOcPyeW7bR/sY5i/w9aBB4ooOFORL6rKUprtreKDSfkwOgBi5
         voW3FV0wNq8EN/qc3z2pFHS2adS7OmK0zyQH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gs3RkhSChaOfEUoWHB9Wz2G7G555U9/P3rBO605JBRM=;
        b=AvMizjPqH84tdRyqJpDD310V1WZ0mxvve22GxRdurs1W+VCozQAUHKbex748QovaTl
         pgZV8FbTBR+qC9vjZVcZtQAQRfGfMqh6tZE+y5Y3aYA+G9cTHhH+8EsFJKL9Z45imsvz
         wpkyNNPI0mHvm4DvodVl43/fr4XUK9QGkEm6QhjG49MSBtRh5X38aBIdZrdmXfDOoGug
         kvZm5XdU+sWEb9fe4nFy105SZY59u2KRKuJ4hbmXvZUAiUlXEgLUGP4aFKt7iatmMMXh
         oA6S2HAym0LznWixzEEJ6WvHRcS+OHyutp6Icqm3DpWt+gASFUEf0b/Xg74bL+kNm3Il
         CpwQ==
X-Gm-Message-State: APjAAAVHU9Uq++6u0qHaq/LVPZDb3iENcNk/PWErMAjerkxiu6N4zZIo
        UizANrbAMxTpA7HBRYHkHoOjjg==
X-Google-Smtp-Source: APXvYqxq8uujpPU3jbwev5Ux1pYfEvT9ZB98ctNiwsVil0Ysy3tky345FtKg8p3JCm6w7b44q+kQqw==
X-Received: by 2002:a17:902:934b:: with SMTP id g11mr18872897plp.245.1559586889595;
        Mon, 03 Jun 2019 11:34:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id g9sm12570406pgs.78.2019.06.03.11.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:49 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 27/30] mfd: cros_ec: Add API for rwsig
Date:   Mon,  3 Jun 2019 11:33:58 -0700
Message-Id: <20190603183401.151408-28-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add command to retrieve signature of image stored in the RW memory
slot(s).

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 4a9ac3861bdd..3d3a37b11002 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,32 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/* Run RW signature verification and get status */
+#define EC_CMD_RWSIG_CHECK_STATUS	0x011C
+
+struct ec_response_rwsig_check_status {
+	uint32_t status;
+} __ec_align4;
+
+/* For controlling RWSIG task */
+#define EC_CMD_RWSIG_ACTION	0x011D
+
+enum rwsig_action {
+	RWSIG_ACTION_ABORT = 0,		/* Abort RWSIG and prevent jumping */
+	RWSIG_ACTION_CONTINUE = 1,	/* Jump to RW immediately */
+};
+
+struct ec_params_rwsig_action {
+	uint32_t action;
+} __ec_align4;
+
+/* Run verification on a slot */
+#define EC_CMD_EFS_VERIFY	0x011E
+
+struct ec_params_efs_verify {
+	uint8_t region;		/* enum ec_flash_region */
+} __ec_align1;
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.1020.gf2820cf01a-goog

