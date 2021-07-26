Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC94C3D557B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 10:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhGZHkS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhGZHkP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 03:40:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F452C061760;
        Mon, 26 Jul 2021 01:20:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b7so10000523wri.8;
        Mon, 26 Jul 2021 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6mgIBbDERHrkCfdLTeeBkkROy6MNNlPhpbr+IZWCG0=;
        b=rFmY6NC/1ICciysyH0pOMcEiVPE+jVNnPU0Ong/hacrndKCuwYdK8/8Q0GHjEvFvZP
         EANSRw4pK/MMv34L+iFt6u2IZVtJnmragV4fbi2JXqWKCP+x4oRTM0uVZBYGbvd6ITio
         6c3MiLl1Su8B/Qp9rHwFTBvQES6M/Hz259xoyOYo6qluF5tmUP1FSxPrY6JFiz5e26Gj
         oq20zSD3+h5dEhKeEAd9lMuwRpwzonFZ6JeOJsUexWcdu85M4iT+wQBW5hshujFYJV8k
         +cCMQEbOFSawuSL37YyzkSGznA8or24geKJDWneLg2BorDJvMW3vBM2GgZ1TJtQ7s4I5
         ozdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6mgIBbDERHrkCfdLTeeBkkROy6MNNlPhpbr+IZWCG0=;
        b=RqNDCWJQFvw91xIr3S0QTn3c0wwtO+fa6x8efPvSaUp3oEYaR8LwPTXcUycmrqd3D2
         7NGL88kryOG5sEj1dnQsod1D21OMMbV8z967uFOIiuPY6/5b9+o3G3whDxM9vlyK9cJ7
         qXwbwb2UPAivZrwJJ8Mr8S6FlLnOvH0GTNmxR4FTLWLytudu0aDXaBk2Xxs1l9pHcuav
         evu5QZLShpkG/226YFrO6LfV+lridbqgFgv9VOVmPsHxV6O+XT3ioblTRLUPdWpuuwvd
         Sya6M+Nx/H5nCzfol1edfyS5FlXtABjVIPkzorMYzXIlzJ0pfJSV5AOAOiVWngbJmjXB
         Qaww==
X-Gm-Message-State: AOAM533v0uW02y71afW55934fDApw8mIA/gIE6cZIzZlFDAD3XKH51jI
        17NEd11qGxLcz6bPp26WQ0Q=
X-Google-Smtp-Source: ABdhPJzCb5A+95ai6uFrnajvvwODvgN5KCENUy8i2k2pFjC30niNPp3EMMLi0xvye5leRvuI6BY/gA==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr17770943wrx.391.1627287641520;
        Mon, 26 Jul 2021 01:20:41 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id w13sm4799464wru.72.2021.07.26.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:20:41 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation
Date:   Mon, 26 Jul 2021 10:20:33 +0200
Message-Id: <20210726082033.351533-6-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726082033.351533-1-cbranchereau@gmail.com>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add both the jz4760 and jz4760b, plus a property to use the internal
divider on the b variant and document it.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../bindings/iio/adc/ingenic,adc.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index 433a3fb55a2e..3eb7aa8822c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
@@ -23,6 +23,8 @@ properties:
     enum:
       - ingenic,jz4725b-adc
       - ingenic,jz4740-adc
+      - ingenic,jz4760-adc
+      - ingenic,jz4760b-adc
       - ingenic,jz4770-adc
 
   '#io-channel-cells':
@@ -43,6 +45,23 @@ properties:
   interrupts:
     maxItems: 1
 
+  ingenic,use-internal-divider:
+    description:
+      If present, battery voltage is read from the VBAT_IR pin, which has an
+      internal 1/4 divider. If absent, it is read through the VBAT_ER pin,
+      which does not have such a divider.
+    type: boolean
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: ingenic,jz4760b-adc
+then:
+  properties:
+    ingenic,use-internal-divider: false
+
 required:
   - compatible
   - '#io-channel-cells'
-- 
2.30.2

