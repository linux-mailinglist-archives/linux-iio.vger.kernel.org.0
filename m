Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569B4264C38
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIJSGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIJSFr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 14:05:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBABC061757;
        Thu, 10 Sep 2020 11:05:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so5091875pfi.4;
        Thu, 10 Sep 2020 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEwZSmSPM9tJPXbfj/hisKYRPYb4G1wKBGhUAXFVXQE=;
        b=t28s2ohAlSG3nVPgGmhJ9BtHHniLCxcuBl1dSx2uX8dRKSd84C+/w6E7KceCTwhEBG
         DMLxo6p3upAgq3btstD8SUZfDQypTTqA2JjOm/dbtwqTeWvJkJPI/5RiO6DMh7EhFImN
         cqM46aKbyCYnaGx0RX3lIaSognEZkwZ+15E5fDWU/2p9wP+ZTLkAXbHSMvrX8lscBbq+
         //h0PQuybrORv3zCLQ48eqLcTQO7n8EW7BXnEoOcUNay1NpF0sAkwi5bf1I9fmltNYK1
         t/GmQjm4oZM4MHB1RkNXfpcgOwHN/BLhFPI32MDk6Vtln8npZF4aq2QB0ZqT2BcTJPNL
         a0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEwZSmSPM9tJPXbfj/hisKYRPYb4G1wKBGhUAXFVXQE=;
        b=TEFhcUSWGu4ys6+jgIF1SLuKtZ4navr/XjilKRCJQS0shY5fMKEKACc27Q/1Z/wqjK
         duA3HcXIL9rlbhhRB+WJYNSTgdvRlfJ+qRel9YjRSndRRSKthDSkSMa1FevAiicAtQcz
         YdvORBRQ6IzODFgJAvnUKDzE5K3G1FgGpqg0nTXWUcCzMEIQyooSQeW2Hacl4HQJv28D
         EIkuAsVy793mpyBeDV8mYLlfecf0iLwv2BSIRS7xCXpPKD1jrCwDQS9bNgzHxiQdg+MN
         w8WF8pxZm4sjqHG2iJu+Nz32eGv2rBd8ZrTh3Y+DdMynZPfnmfksrv1SgjKF57vgkFhM
         NEAQ==
X-Gm-Message-State: AOAM533bV8zGzsDH9m2gshi+kEPimwB6KYmYhsq2MJSPO4FaHb8VSCaO
        SIBLTnyz5DOJ2jXXa90i9kA=
X-Google-Smtp-Source: ABdhPJzsznNUs52Ek6gTw2Dn9tG7jAPka/nCKtVSJh1zGME/XM/9xnhHT59acXC+Hho9CxqNHMkHDg==
X-Received: by 2002:a62:8c86:: with SMTP id m128mr6545841pfd.111.1599761146894;
        Thu, 10 Sep 2020 11:05:46 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id f4sm5799390pfj.147.2020.09.10.11.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:05:46 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [RESEND PATCH v3 2/3] dt-bindings: iio: gyro: adxrs290: Add interrupts support
Date:   Thu, 10 Sep 2020 23:34:49 +0530
Message-Id: <20200910180450.29696-3-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910180450.29696-1-nish.malpani25@gmail.com>
References: <20200910180450.29696-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Include 'interrupts' property and provide a suitable example for using
a GPIO interrupt line.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v3:
  - remove gpio.h header since unused

Changes in v2:

  - remove 'interrupts' property from the required properties list
  - rewrite commit message
---
 .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
index 61adb2c2454b..662ec59ca0af 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
@@ -28,6 +28,9 @@ properties:
 
   spi-cpha: true
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -39,6 +42,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -48,6 +52,8 @@ examples:
                    spi-max-frequency = <5000000>;
                    spi-cpol;
                    spi-cpha;
+                   interrupt-parent = <&gpio>;
+                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...
-- 
2.20.1

