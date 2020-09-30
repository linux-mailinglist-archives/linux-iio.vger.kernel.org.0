Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA96527E31E
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgI3H5o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgI3H5j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:57:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00BFC0613D7
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t13so534749plb.10
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDEcWHlyapYQvTzBGPWxhwlFd+2hXwYzlj+sRCbxoP0=;
        b=n7gSOYsXocsjgth2CDy902uJFO1zzt0WyA1PedfCq8fZFumii1yZIkBzQd99o57jeL
         OQJLRxvfPxFjb5pxCc6/SWUIc0ANPF1xnntYLbHiOqCe2iDjCy0kvr6dJPP8ST465npn
         4IM5KOnFkw++/7cFqA/INBXSOPysUEWZ2Gmz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDEcWHlyapYQvTzBGPWxhwlFd+2hXwYzlj+sRCbxoP0=;
        b=ZRk/qRlq96FOAgZvooYtludm6EsLGajxgxilZpv0JX9GsRqk2IndKovutqIU2cZ4qg
         rGC0mCUCJahZlS70BI10wNkHjWQ8gSG20TnGv4jPPz9kiv7sjSrImK1D2VHGraXVKF4x
         Ahdv8I7uZ19NdlemuizXGBVFxKxV3OqS+ES4JHdbgmI++rXFlJ651sL2f9YCWTZMERnA
         Haqfp6eymFvVxtHVTpTv9kzCIR9Ub2QC8sUTq96CF3F3Y/fwwJjHzNWMJpWoHaKf7y22
         u3iL+xG6Kd1CKdrH7C47jON8FPcJSUhwgpf1K62SXWeGgN/nr72EePKVN3dKWgUBmDQE
         hkaA==
X-Gm-Message-State: AOAM531v4jUatHBMwY9qxDpzcLKCLVoqCkBJYXpJ+rsXAlV4Nzv1UxAa
        5XXhyPED11KaKZsnCLXvoECz6A==
X-Google-Smtp-Source: ABdhPJz0F1CB/zSe1XmZdBhGdtw+r/P5uj6z+DERjylbMqGq6vqic9eQqPdxtS+2HxwNxFDNzDkNkA==
X-Received: by 2002:a17:90a:ae12:: with SMTP id t18mr1488011pjq.147.1601452655437;
        Wed, 30 Sep 2020 00:57:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l21sm1272131pjq.54.2020.09.30.00.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:57:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 5/6] dt-bindings: iio: sx9310: Add various settings as DT properties
Date:   Wed, 30 Sep 2020 00:57:27 -0700
Message-Id: <20200930075728.2410327-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930075728.2410327-1-swboyd@chromium.org>
References: <20200930075728.2410327-1-swboyd@chromium.org>
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
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../iio/proximity/semtech,sx9310.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index 5739074d3592..a85b8fa25861 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -40,6 +40,61 @@ properties:
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
@@ -61,5 +116,11 @@ examples:
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

