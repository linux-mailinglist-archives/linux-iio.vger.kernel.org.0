Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2E34BA8D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 05:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhC1DhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 23:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhC1Dgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 23:36:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53493C0613B1
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 20:36:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m7so7215149pgj.8
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 20:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLO2XQIJs0BFINTqxacgVlSm3fGm5XvtqH/HUSlWzB8=;
        b=AznN/mLi9KYh42xAbSKgETGsGDLN14ZRd8rByffzefFb2TLbVn4WSB9yAwzL6Aip3n
         EuJzLpL+ZXTwyPV78Y74AHaxfNy81eDPJwJLAqr2BiZEAZ3u11n1jNgS37fNb70ERGg5
         +fYnx5rVEqVpMf5HQDkWw0nWDoqZPYI6r12A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLO2XQIJs0BFINTqxacgVlSm3fGm5XvtqH/HUSlWzB8=;
        b=f/wV0zvEI4fMM2f+x83Va9F2n7NTayHIjZtZZTtQ7FSmmQf2oPQoAbuwuaP7B8/vfn
         eiytvp6DZXe9mLnuShsEHN9yvtHx3L6eWS+oR8gznPytv+QVhhqYXYwn58V8zBvmOKVH
         M7VIDV09ON2K409K9J+n/mX1fm79T+Hd+CiAkAULyUIkLen6icUJecKO9AzGvZwAP8+S
         RYtqfoqIb+BBOGJdo3ewi0cNlXOdeR1zYO6I6pYt+AETonuGMGiH/GcQfAVXMKVNp51W
         SquOEpppcn/gphCi0Mmml4p/B5K+5PzcEPaQlzUr05Y0n9W9Zuz86nQ5JZbKCcg77ooJ
         Ss+Q==
X-Gm-Message-State: AOAM531tczg/s8Pm1Q+cP8HBbJOTOuHzBSBRpod/c3Nd3knKUeJIUopl
        /CTNipAoUoCuELXYoC89eXjv4A==
X-Google-Smtp-Source: ABdhPJyrZaFQPv51zD6UQhboi/sZZtgxy6MgA/kxKO0gUws0npIT84CLCO/o+HV/WMlkKX/BuHikrQ==
X-Received: by 2002:a63:f212:: with SMTP id v18mr16605363pgh.343.1616902607910;
        Sat, 27 Mar 2021 20:36:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5993:d227:a897:4c2a])
        by smtp.gmail.com with UTF8SMTPSA id g10sm12573048pgh.36.2021.03.27.20.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 20:36:47 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] dt-bindings: iio: sx9310: Add close/far debouncer strength
Date:   Sat, 27 Mar 2021 20:36:38 -0700
Message-Id: <20210328033639.1021599-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210328033639.1021599-1-gwendal@chromium.org>
References: <20210328033639.1021599-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Debouncer are used to prevent false positive: only when N measurement
are above/below the far/close threshold an event is sent to the host.

Define 2 new entries: a close and far debouncer.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../bindings/iio/proximity/semtech,sx9310.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index ccfb163f3d341..f2656f87e2c44 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -97,6 +97,24 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,close-debouncer-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 4, 8]
+    default: 0
+    description:
+      Number of samples need to trigger a transition from far to close event.
+      0 disables the debouncer, N is the number of samples needed under the
+      proximity threshold to trigger an event.
+
+  semtech,far-debouncer-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 4, 8]
+    default: 0
+    description:
+      Number of samples need to trigger a transition from close to far event.
+      0 disables the debouncer, N is the number of samples needed above the
+      proximity threshold to trigger an event.
+
 required:
   - compatible
   - reg
-- 
2.31.0.291.g576ba9dcdaf-goog

