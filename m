Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21F1352D
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfECWD2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32904 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfECWD1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so3327606plp.0
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqldmXxauyhkjN+cmd6rsXcdSJy2DQw8nApvvLnMwiY=;
        b=JDf99JEQRfx0Cx33Wp9McW5W66XB/ORRYg1ryMaOk8WYyCkfpEFT6m+p6p/iuoVz3A
         nRoVB6X5NNxqouyMIutQjcjLirSPQst8jP5ek8GqYt+dEmrnVHPjDsjbhUPzaq5I5RSb
         JmyISC2jg/MdruxzFCTJwulITIteXEpHW3FbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqldmXxauyhkjN+cmd6rsXcdSJy2DQw8nApvvLnMwiY=;
        b=mztJigGRCagZqpFM8Y7YnytEf0sEtaQXuE4J9x5e9oovlIeCoUtpk8s9ZWguSs6Arf
         3WcZtz6JLt/VJRg2lsk1+Bs3JdbTZPmDVpliUUIeK+pXEurFkBzFkKY0UmYizjqQ8O7+
         iu/mpTgCR5Z3B2+Mace44NuY1bkYQaB84Fysnsnjs3xe2jSLY2qEkkm6uiVMVAAr/bwE
         EjPYGWFuFwr0ZvgaT6wbMAd8AaaOzVmdb4+/hZpP/DtggYCrySaui2bZJjH0Kc85ScMn
         uMfJfURJatcFtkhVdFIRHD4Px8g53tn24lYWxt93HGs1cGnMUEL304t0GsLypyjb5Psy
         LdQA==
X-Gm-Message-State: APjAAAUzwdnuNdiYXxalBOCWSMH2wMKS7QsKQH7VWugajc/rVIuCs26b
        SLm+RQP1yRCr14gD9IeQFtMhCw==
X-Google-Smtp-Source: APXvYqw7tV0azTVEBxn5kH4OCN7wzuXYAelyzUoomae87dAK3qQRrv4nBkkR8IfYh/pfjlrFS2NthA==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr13867898plr.84.1556921007113;
        Fri, 03 May 2019 15:03:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id u5sm4540867pfa.169.2019.05.03.15.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:26 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 27/30] mfd: cros_ec: Add API for rwsig
Date:   Fri,  3 May 2019 15:02:30 -0700
Message-Id: <20190503220233.64546-28-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add command to retrieve signature of image stored in the RW memory
slot(s).

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

