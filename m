Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74F1351F
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfECWDF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43011 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfECWDF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id e67so3528053pfe.10
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gD0rOjpw9ms8AskrbFlvCfQcUbKxm7TEx3UNlNN04U=;
        b=KH+5ig0DFc1zTwYKNJYOfHBjhc2PDb4Cds1wnM6NJoj1pelSlCwD/PCI21VlyaKWeJ
         WBphiyOpclP72T09Qs/LHN9XCItuX2i3ZLjMOvbJRxd9GWum9L7g5DWHl98Vbr0P2SMq
         vrgaz8+K8v6/032e198xX5xM0XwAzfnEb13YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gD0rOjpw9ms8AskrbFlvCfQcUbKxm7TEx3UNlNN04U=;
        b=JjuFeNhLdt+USyjVp1y+2Xv4B318KXKXGtio1bgHXJs4o2WnSmW57+VrY71aTugi+7
         wNWkayXhnQ00KBbrj0CeAC+N0cIG3F6Vmbwe5PzCjH0Xt3F5OMN6PAgOsWB7N250J/gt
         iZIDOvPLYce4GQXr7DBVVs7Ovy1QtQToQGRszSQuYdA5KJTWmh9muhOJpKn7a6mXQlIS
         oR4acjCQ0IzP6tyyfxyzZdRf5egRGQfbPa8qZDQ/uGqX4EV5c1sT8KJTpDcLzJw+i39X
         TTDQMsVV8vOiGs7NQ4spc0kwvY4UXW+YZmmn+Uz2zOk7eL7+1QTSDq8Irdq7FO4xoTLT
         Nv1Q==
X-Gm-Message-State: APjAAAXaOcxZfoCbhwAjbv6WBNHz6Qy6yKe6ib7s1txTwgLfV8bGhY/L
        iKZpTv7NkiV/hlPTZk0qXQTRGg==
X-Google-Smtp-Source: APXvYqwRZYTa/D/WqinOmvSIQQW6Xl5SMl55y+eG88O+PeZB5rLTHyfZLrobLweqWzUamBC3Cj9fRQ==
X-Received: by 2002:aa7:9085:: with SMTP id i5mr11520540pfa.209.1556920984859;
        Fri, 03 May 2019 15:03:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f22sm3884355pgv.45.2019.05.03.15.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 13/30] mfd: cros_ec: Expand hash API
Date:   Fri,  3 May 2019 15:02:16 -0700
Message-Id: <20190503220233.64546-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve API to verify EC image signature.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d55f155eb735..29a996832af0 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1988,8 +1988,15 @@ enum ec_vboot_hash_status {
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

