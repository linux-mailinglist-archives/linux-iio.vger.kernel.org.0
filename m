Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8728562C
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJGBR4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgJGBRp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:17:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F526C0613D2
        for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2020 18:17:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i2so334828pgh.7
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2020 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3b5vsX7ezYRrPD7MIrHHFYiH7Fjfq1VpNyAfa7YYMs=;
        b=TxYZNSrk4fijdF8OlyZfUbDEsKkWlbTvkerk0i9KIlYHeZ8KC3c63ldolEDrzF8P9G
         4u0Sq9sSF2HE9LX4sV+8Qa8zHRRwv/ZIJ8+KRG7YimA8YEkGLvxFMOnUsV3B4Kcdc8Ip
         tHjD7+ImhdbxCcYUTYz/toLYjccbJYmYYQ9xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3b5vsX7ezYRrPD7MIrHHFYiH7Fjfq1VpNyAfa7YYMs=;
        b=te0whsdOqNuW3ArO+ChGyBtWQCL2ZxAIvWW6Ua4FtIi0e34P+vD4gDvgTC0/MO9Ox8
         5Csb+ZmXJOHBXv/gp8/qtIoSh11bTTFR+0lbzg/NyJoFqCD5HTl4vx62dzss3/wSawfK
         Rg65KviHM1CBBKm3rJPAQ0CKpNtQjyl/6Hvbnxou8vd8Ei7AEccTLTlZWy7qKIVaidOd
         f8AxwFDrGw9ncQnXhaQEMgXJrwNIxpzRVhhrmJTUv75lp/8LHhwZnwUeJuM/in+Dal7+
         WhDbxf2ggYe8aNg94+VOeC8tbTk/CIS5IpwrEgRRynIOdEW+gospv2O4PL1NdQxwHHBV
         EGRQ==
X-Gm-Message-State: AOAM5302XyT0K5ScPZCgR1tHcP85YEBvODj1g68tdOhtoO5snBS3icO/
        s6dxx+ZZaFikAwqxcP8fLrykGA==
X-Google-Smtp-Source: ABdhPJxCY7qloRtr55WTd3OKPpExkfS+8Yq9WlyeWs/4TAodbENQfjN9NxBtw5KFtw8YA8PjZL+svA==
X-Received: by 2002:a62:301:0:b029:13c:1611:6587 with SMTP id 1-20020a6203010000b029013c16116587mr674460pfd.4.1602033463974;
        Tue, 06 Oct 2020 18:17:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3 5/6] dt-bindings: iio: sx9310: Add various settings as DT properties
Date:   Tue,  6 Oct 2020 18:17:34 -0700
Message-Id: <20201007011735.1346994-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201007011735.1346994-1-swboyd@chromium.org>
References: <20201007011735.1346994-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to set various bits in the hardware registers for this device to
operate properly depending on how it is installed. Add a handful of DT
properties to configure these things.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../iio/proximity/semtech,sx9310.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index 5739074d3592..ccfb163f3d34 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -40,6 +40,63 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  semtech,cs0-ground:
+    description: Indicates the CS0 sensor is connected to ground.
+    type: boolean
+
+  semtech,combined-sensors:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      List of which sensors are combined and represented by CS3.
+      Possible values are -
+      3        - CS3 (internal)
+      0 1      - CS0 + CS1
+      1 2      - CS1 + CS2 (default)
+      0 1 2 3  - CS0 + CS1 + CS2 + CS3
+    items:
+      enum: [ 0, 1, 2, 3 ]
+    minItems: 1
+    maxItems: 4
+
+  semtech,resolution:
+    description:
+      Capacitance measure resolution. Refer to datasheet for more details.
+    enum:
+      - coarsest
+      - very-coarse
+      - coarse
+      - medium-coarse
+      - medium
+      - fine
+      - very-fine
+      - finest
+
+  semtech,startup-sensor:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+    description:
+      Sensor used for start-up proximity detection. The combined
+      sensor is represented by the value 3. This is used for initial
+      compensation.
+
+  semtech,proxraw-strength:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 2, 4, 8]
+    default: 2
+    description:
+      PROXRAW filter strength. A value of 0 represents off, and other values
+      represent 1-1/N.
+
+  semtech,avg-pos-strength:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
+    default: 16
+    description:
+      Average positive filter strength. A value of 0 represents off and
+      UINT_MAX (4294967295) represents infinite. Other values
+      represent 1-1/N.
+
 required:
   - compatible
   - reg
@@ -61,5 +118,11 @@ examples:
         vdd-supply = <&pp3300_a>;
         svdd-supply = <&pp1800_prox>;
         #io-channel-cells = <1>;
+        semtech,cs0-ground;
+        semtech,combined-sensors = <1 2 3>;
+        semtech,resolution = "fine";
+        semtech,startup-sensor = <1>;
+        semtech,proxraw-strength = <2>;
+        semtech,avg-pos-strength = <64>;
       };
     };
-- 
Sent by a computer, using git, on the internet

