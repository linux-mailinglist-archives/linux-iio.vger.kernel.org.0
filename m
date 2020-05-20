Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA11DBE48
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgETTsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 15:48:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E72C061A0E;
        Wed, 20 May 2020 12:48:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so4854810qke.8;
        Wed, 20 May 2020 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBlg7ucOOHLspx7oP054kBqMdtZCA7r02bQtA6lAAEk=;
        b=OQeCTQ5X4XkJWA5Xbvz0WRI+uxOq3cR2EAeUrhsFpc2X95vwZMc3gZOOpxH9TQa43v
         7/4xeNlB5i/64R8tv1RJZitclWixf7zhYwTq7oFjTI+WEUzycLcrENKtv3vW5JT4gV4E
         yOWT+nEkTTTNaOBS3gTOklkRcALQc2yc7QHbkqLpA4WsObiZn3SW+2RQ+4QnW34qiUuI
         YIbfzP8Fgs7addRpnO5M484UFA/KuRzSGI7tGg1D/Dxv5u3tNPvQ9Ik28j+E/j3TMYSj
         XQbKc3emuEON0Ny3kkTaBpALPDoVqYgYNuPOBdWNuo/rymXHBwiKnzY/W0NVeIahZ1HE
         8flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBlg7ucOOHLspx7oP054kBqMdtZCA7r02bQtA6lAAEk=;
        b=iLuYJVvNM/Nzq7Z/gxi8FWVy2NZCiA7L80SsQPOEaF+u1rlwuwpqI+LrJ8V4LFgwZU
         RPrUekEho2SNYBk9dR68hfTRIdrY0I3mnPJTZHqtU9D6iuRpSzYe/gM7XdI5orcg7Tbw
         jiCX96FZhOwpi9aUz0/Pxe1RhVbg/Ov1UowgSB2+RhF465ioJWh2A14eTQ9yxorno5X5
         00RZPbNIN3plLoW0etIZ8XijFNGWD6lwVIkUFdh72ZtfaTHqp/CfpRYG6dULADaPtc+S
         2Uj/26n2EGjW7qcMK4NdY5/ayOh/tNc7oV+V3zN2CyS/bEuvhR3guHd6j9n8MRgH23MU
         1SZA==
X-Gm-Message-State: AOAM531Nis/KYCt6O1bfswQoavNlnhjj1XFEhTYpVlpIPjmErdz8EJKV
        TEPkDWjhwwGogQwz12JQ5ViDg2dujJI11g==
X-Google-Smtp-Source: ABdhPJwprs1voZB1XSGzTEyzd8jWNVf+fz+saZc7lAubDV4VQPF8QW+Gs5MIFMaXaUPrZ1e+FfLBsA==
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr6252443qks.91.1590004080231;
        Wed, 20 May 2020 12:48:00 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m33sm3158419qte.17.2020.05.20.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:47:59 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/5] dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
Date:   Wed, 20 May 2020 21:46:41 +0200
Message-Id: <20200520194656.16218-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add vdd-supply and vddio-supply support.
Add mount-matrix support.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../bindings/iio/imu/bosch,bmi160.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
index 46cb4fde1165..1a1b1a14aa2e 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -40,6 +40,17 @@ properties:
       set if the specified interrupt pin should be configured as
       open drain. If not set, defaults to push-pull.
 
+  vdd-supply:
+    maxItems: 1
+    description: provide VDD power to the sensor.
+
+  vddio-supply:
+    maxItems: 1
+    description: provide VDD IO power to the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix
+
 required:
   - compatible
   - reg
@@ -54,9 +65,14 @@ examples:
         bmi160@68 {
                 compatible = "bosch,bmi160";
                 reg = <0x68>;
+                vdd-supply = <&pm8916_l17>;
+                vddio-supply = <&pm8916_l6>;
                 interrupt-parent = <&gpio4>;
                 interrupts = <12 1>;
                 interrupt-names = "INT1";
+                mount-matrix = "0", "1", "0",
+                               "-1", "0", "0",
+                               "0", "0", "1";
         };
     };
   - |
-- 
2.17.1

