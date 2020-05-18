Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0501D7A05
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgERNf6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERNf5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:35:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BB6C061A0C;
        Mon, 18 May 2020 06:35:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m185so5555614wme.3;
        Mon, 18 May 2020 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PioGi4Hba7haqtg57rWfjXP/P5pE/B0GcbWPRGco23Y=;
        b=S+Ml6WrRLqg6BM1/mDF4puVQrVbH8Y5rpjUv8HITzdMUF+KqbmNzkWGIupu3FTkGxx
         p16PZGgVD333x/6pIqSt9Ia7pq7U2VazHhU+yDww+QzGzCdXIbaaLh6S1oKbTZTebc8J
         C5MpWIh2Zlw8IxEBHf6JjftTM9jejh7mVlu5ALTi6oXKlycAapdEyd7NSRpyG/iBWpqk
         /DBlX8hFhOdFY4j7tKagGkDJH1sbUdKNOtCe3Z5OpGaOXQF4J+fns71mNwnm0aEIIgBR
         HkfJDvkOtM5KEt4PKl+WSUgAap28oyH2K0ebqQ4xu0zzL6p6HoV76MFxa/8wPm3uSK80
         KrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PioGi4Hba7haqtg57rWfjXP/P5pE/B0GcbWPRGco23Y=;
        b=rHZJKgfNXd9NN9Hiwp7/QSsLeMRIB4fsPtlvJaQxUZkorlJkhxoGviaiJQooiQ3HWL
         qw+lsebOQpJE0w4ktqyoYDpad8ggv9FGEpo9cxseTxnBNfXheL9W87tr2MzQrGeNDb/q
         55qje/qsh5wkuknjT/WVQHUp5gV94XLVQMZxbtth9r/Y/Mcs7ZDfuYxWXmzlx9yWNW6r
         FNQCLgmS8BSRxN0lXbKslP4PmYUcZm5ViXJ03da5Fp+x9FqB1GcK72MEArrGRTzsime6
         TtkLY5K2kFRJsqbxAU9vBrr+cOa0QvAjkSFhmc1nzdbIJTn8s4nha14h/YRzzomgcpYx
         EdeQ==
X-Gm-Message-State: AOAM532LrqzBihrZprZmuf7wTWMCvexl5OlcHTBNJQFjA6DXDLwmuu38
        rts6Nt65W3BX7fFjMdZTPCa0aBdyRvs=
X-Google-Smtp-Source: ABdhPJyd4EZlt8dwOJxsGSLXim8mpRadmCh2WrANQCKWgJg9pdQrrPR+PaKf8P2kfm0qQcCLTO7mnw==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr18829700wmd.109.1589808955111;
        Mon, 18 May 2020 06:35:55 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id l19sm17086772wmj.14.2020.05.18.06.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:54 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/4] dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
Date:   Mon, 18 May 2020 15:33:46 +0200
Message-Id: <20200518133358.18978-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
References: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add vdd-supply and vddio-supply support.
Add mount-matrix support.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/imu/bmi160.yaml   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
index 6b464ce5ed0b..5b13af7a209f 100644
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
@@ -46,6 +46,21 @@ properties:
       set if the specified interrupt pin should be configured as
       open drain. If not set, defaults to push-pull.
 
+  vdd-supply:
+    maxItems: 1
+    description: |
+      an optional regulator that needs to be on to provide VDD power to
+      the sensor.
+
+  vddio-supply:
+    maxItems: 1
+    description: |
+      an optional regulator that needs to be on to provide the VDD IO power to
+      the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix
+
 required:
   - compatible
   - reg
@@ -61,9 +76,15 @@ examples:
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
+                };
         };
   - |
     // Example for SPI
-- 
2.17.1

