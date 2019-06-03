Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614793381F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFCSe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfFCSe1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so8773392pgc.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78EuSAUxvk0eTVYgfPD6z4ab5WOs+lKw0I62++Yl618=;
        b=CsQ8HbTO8IlzQQKGlsM5+fJLbWEI2MJos78k7DutwaUcPfUG0iDsrElkrHoxz2qj1U
         c/NU1Nw/+fAWm57iDd+5sZn+ZnpB95rOe1yUoI+CxyhX2iyPnRmH5w7ZC/FHgXCc+sfN
         3gnF5Q0BZ8ZdFu6cj4VgaxajLMJlW1Who0h34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78EuSAUxvk0eTVYgfPD6z4ab5WOs+lKw0I62++Yl618=;
        b=Dxt5pBFn3KV701pzpbOJ0ZgjiljHn98uFLpt+YqQeRltizBj6w//klHXiuqCUTXJOf
         w03CZp33uP0N1okgjVbR5CQpV1Xk65VALSvy81Y21NNC6Zky27UUZTVudkpSqVITU2aN
         ieDm4vA+97ERe7rPurFXgh/7LY0xGYi5Hdw41RuPGhioKc1UN0epM2QYLORyyRZoJHbx
         HL0/gq9qFwVDsJ665jAm7FblzMNEyuwLE46XKtwCZ+k8GPJhzOIiMmsgvNuwJAkGQQfD
         35RnbLu5pIO/BQcuMw013V8Q43F5d79ahEi5y+DJF3OgaF8pkVwRVh0UTcvXz+4PijUg
         B4PA==
X-Gm-Message-State: APjAAAUSGGUfZ8WA++g7cpddCP5YgWmXWCCO+Nyr0NQBjP93lZJF1TxH
        0ChMW4SVBj++XW4jN2ZggFIPaA==
X-Google-Smtp-Source: APXvYqxd1tp2oLCjAOIPaRZ+9YiuZUB3isblM3Mx87v1tZEuxJrfwDiG40+SIdeWFfdBs8nbLS6C2Q==
X-Received: by 2002:aa7:8705:: with SMTP id b5mr10340371pfo.27.1559586866606;
        Mon, 03 Jun 2019 11:34:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id x66sm17074409pfx.139.2019.06.03.11.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:26 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 13/30] mfd: cros_ec: Expand hash API
Date:   Mon,  3 Jun 2019 11:33:44 -0700
Message-Id: <20190603183401.151408-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve API to verify EC image signature.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 0ff1941288cf..76943e64998a 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2018,8 +2018,15 @@ enum ec_vboot_hash_status {
  * If one of these is specified, the EC will automatically update offset and
  * size to the correct values for the specified image (RO or RW).
  */
-#define EC_VBOOT_HASH_OFFSET_RO 0xfffffffe
-#define EC_VBOOT_HASH_OFFSET_RW 0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_RO		0xfffffffe
+#define EC_VBOOT_HASH_OFFSET_ACTIVE	0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_UPDATE	0xfffffffc
+
+/*
+ * 'RW' is vague if there are multiple RW images; we mean the active one,
+ * so the old constant is deprecated.
+ */
+#define EC_VBOOT_HASH_OFFSET_RW EC_VBOOT_HASH_OFFSET_ACTIVE
 
 /*****************************************************************************/
 /*
-- 
2.21.0.1020.gf2820cf01a-goog

