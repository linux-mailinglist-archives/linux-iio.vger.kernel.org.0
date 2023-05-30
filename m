Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA07C7157AC
	for <lists+linux-iio@lfdr.de>; Tue, 30 May 2023 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjE3Hx6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 May 2023 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjE3Hxq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 May 2023 03:53:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B002F0;
        Tue, 30 May 2023 00:53:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so26869735e9.3;
        Tue, 30 May 2023 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685433217; x=1688025217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mizo9gnkF3NdkFdByq3QjeHMqHH/cKSCHXOmzX7m6qI=;
        b=CiTz7HwUaUiU19fDMjGcyNpQMym6AXUPkMPMO8RN85jgjhc8V2EJRvcFAuKM3jkWlR
         mOxCIveZEZgC8sB4XDVKw0wAkALSGqd8UT2yl+ppK9eEeS7MIEuKZMQ+M+302iwfoD4U
         O/cgGQdpm8a9V9Ss/woUm+e0X+pS8ahcLrwEut9BeePMmuql/voi0pHsmB1bSSmro5tr
         HQcbtuwU4ZZaGUAuyWlKwEiMF0xcbu6sDrZA9aLcdgN48iOIy5Y3q9eHQPlVz2dd5UE7
         1z862mWoekHg4sXcd8PcAMdmHcLuN0s9OlMhE4cbcF4ySmRtjcdzSJT7iThX8Z1IvR0I
         NaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433217; x=1688025217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mizo9gnkF3NdkFdByq3QjeHMqHH/cKSCHXOmzX7m6qI=;
        b=Y2r1Vw0tps22k1GmyvPbyVb8cvbAMMm3blyAxfQyDYMcHWsZo7wbBUX7oolWfxtoum
         8LqbvxTAZ9MFYzK54tCrgdYsGCkb/EI4jOD2e5RO8aRnxeje8ZLWdZv8tUPDNRSpPmQ9
         sC88L0WUEh5EXV+eqfYb320MB74WofQY1GPPNm8uRPwpajXWEuX+zP54iVxm6gFZ451f
         B3rxwfW5cO6ssjB4LdaEsfEsSBLiky2CH658T+SYLj8QDSNxLbGEMEI1jjovvybDN4OX
         CdiZ0zaeNeIQprHPtQU+6yLjw8s1/4MeVsbkA+DiG+0Ld494c9qIp8HMb6f+J0Dd6fWq
         XfZA==
X-Gm-Message-State: AC+VfDxg2DOfbaOf7iTiT29YsQ09V9lnEGCOtGY0UIEPh4CDmYKeqyI5
        zchvnGdI8uuA7Ba4qSz36ws=
X-Google-Smtp-Source: ACHHUZ4fRMBvqH4YW/Lcvfr+6QshvSlLHZ4Nnu6ybEKSJsxCfYPhuZP5/HGTlW0Nx89qpSvv7m/aPg==
X-Received: by 2002:a1c:7716:0:b0:3f4:298b:d925 with SMTP id t22-20020a1c7716000000b003f4298bd925mr805890wmi.41.1685433217367;
        Tue, 30 May 2023 00:53:37 -0700 (PDT)
Received: from PC-UT2.ad.ennebielettronica.com ([78.152.97.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm16561275wmj.12.2023.05.30.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:53:37 -0700 (PDT)
From:   fl.scratchpad@gmail.com
To:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 5/5] dt-bindings: iio: ad7192: Allow selection of clock modes
Date:   Tue, 30 May 2023 09:53:11 +0200
Message-Id: <20230530075311.400686-6-fl.scratchpad@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530075311.400686-1-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

AD7192 supports external clock sources, generated by a digital clock
source or a crystal oscillator, or internally generated clock option
without external components.

Describe choice between internal and external clock, crystal or external
oscillator, and internal clock output enable.

Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..f7ecfd65ad80 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -32,7 +32,8 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: |
+      Master clock (mclk). If not set, internal clock is used.
 
   clock-names:
     items:
@@ -50,6 +51,17 @@ properties:
   vref-supply:
     description: VRef voltage supply
 
+  adi,clock-xtal:
+    description: |
+      Select whether an external crystal oscillator or an external
+      clock is applied as master (mclk) clock.
+    type: boolean
+
+  adi,int-clock-output-enable:
+    description: |
+      When internal clock is selected, this bit enables clock out pin.
+    type: boolean
+
   adi,rejection-60-Hz-enable:
     description: |
       This bit enables a notch at 60 Hz when the first notch of the sinc
@@ -84,11 +96,12 @@ properties:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
+dependencies:
+  adi,clock-xtal: ['clocks', 'clock-names']
+
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
   - avdd-supply
@@ -98,6 +111,13 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      required:
+        - clocks
+        - clock-names
+    then:
+      properties:
+        adi,int-clock-output-enable: false
 
 unevaluatedProperties: false
 
@@ -115,6 +135,7 @@ examples:
             spi-cpha;
             clocks = <&ad7192_mclk>;
             clock-names = "mclk";
+            adi,clock-xtal;
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             dvdd-supply = <&dvdd>;
-- 
2.34.1

