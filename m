Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4921D19438
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEIVOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43927 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfEIVOX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so1943106pfa.10
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0IPEAAZhLi1gys+2LirQge8UODqrAqbS/22Qm4bF1s=;
        b=cH+VBwgKsOunqPxtWlu1VRhFgLfNjKBoEnzFUBNyyHA8/Q8GAPqkdWGZXT5t4vH9V2
         G7V2bOhe0nuB+Dqyq7vpAWNVFoM6BhSlslYT1S/UqsnkcFDQjGsa+iOhjVOkVaVJsyBu
         POIUoG2DRasIPlM2Ukm0TaLG42f5fSOJ30za0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0IPEAAZhLi1gys+2LirQge8UODqrAqbS/22Qm4bF1s=;
        b=nmt8ztMo5VpuOcfOadbOfm9WjO1IGLDZy8em2BdOriOATPOncOY/MSVvmOyggXq9fI
         1aNZu01nFjKVgHOsO6f/AMAfS5gbFVTx9vUqe0DoX9juqE5GayaypasuPyS35o/ZaJfy
         22f9R1REpveVjAaZz4jeKERuKqoN0O54uw9PeB8WmJtSpNGXFiLY//auqF1lI0AqAwm/
         4IHzAWCzlJwq1ntVniemG8JOryNjzkfxaCv6vRN8PlxAbZhnTFyJvkVTfbKik4Tcp1O5
         WMQU5sfK04Wv0OtlcQK8wiOLqSkaCUdJhhKqTvuDRfTWC+ltxhdUwgsstjDAD1gVuP3K
         t2kQ==
X-Gm-Message-State: APjAAAXe/87+xxUQzgId5XOu8X77fNuVCdOutyQp+3SUl2CQ9hWz+FQw
        zCJyfvwDZVqagAJ99AL5rBYkvw==
X-Google-Smtp-Source: APXvYqyE6f1XisQgbEH3d5hrLdGWQVIy/zvCRIyERSNmqjO7MmtzNljBiI83zTxtJqG/PDRN7/ThIQ==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr8667284pfe.29.1557436462597;
        Thu, 09 May 2019 14:14:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id g2sm4443402pfd.134.2019.05.09.14.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:22 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 13/30] mfd: cros_ec: Expand hash API
Date:   Thu,  9 May 2019 14:13:36 -0700
Message-Id: <20190509211353.213194-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve API to verify EC image signature.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
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

