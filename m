Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD61D915E
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgESHwB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHv7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 03:51:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E547C061A0C;
        Tue, 19 May 2020 00:51:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so2007860wmf.1;
        Tue, 19 May 2020 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PioGi4Hba7haqtg57rWfjXP/P5pE/B0GcbWPRGco23Y=;
        b=no/jebZAVylj/0ygMm+1Pw8/fW3BIzgnqv80UN/+fhFsIG7OF7iMmpq4qg8UhGyVCD
         0eZNeeRrfsMNwvztPGs/fTp6WhLUVTtgNRQgEYMWXi0AxQyVQTWV+RT5QXMYEGNgYoqI
         tzqEqfXDe1rapnkemHJ8bjzJW1C2TRGEEVdczbWKbLxZVBqWqyWUwLnlBAiaIDtKyzsB
         NSrLC+z3r78PFMAi9/NA5LB/lZM4AyMtUlVKOZkl8lmdBjEBbmcEzEA7EMN5WPyf9K+8
         Z5sg4kec0uNZamitnjdj8M7G1Tz9bG7A1BBH/CE4/lM/S89rkq5QEX2jM5kuHyrQsIju
         UegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PioGi4Hba7haqtg57rWfjXP/P5pE/B0GcbWPRGco23Y=;
        b=Woov5chXqsOzLcBmxqDILrhstPS3wSH2YXp0RG0hRAu9l0YwmYbQbKrkvbH9obeGUm
         Jg5XPRbjy0e9CR/+UiqM1I4TKK9HG7wxwAi3qTFFI5d8PlBcUSid1XkZrhtYAIgJ7iV2
         98U5I6/cDLgR6yZvjon/vt6nS9qGjooiR4b0RLwVimazUN7ouuPa/52fm1gBOZ9ANTcp
         tuzNvVhemPR2UIWXlxXLWWS3+EkNm4oB3Tnu+Nlbbl1KWICD7L/Wlgnlli+egUfbq2ch
         bD+pN9Tr4xIQ+x4cvG3tn13bQL9+vHYNIDMfR14Mdj49CNBsZMirqYuyVkskkaKyYyU6
         5Qaw==
X-Gm-Message-State: AOAM532+GDRTg8jTWoluaOnNw6hAe96Gu5/bw9SOhExFLR0rRLjTS5K3
        AbEKFDCwMmKJrLyKYEwGVYUUSaFcyS0=
X-Google-Smtp-Source: ABdhPJzu5XcgOCcXEn2F/H45Ds7AkoAlpYhNJt7hsh6w13fOqzbbOSR0RRPezBF8FVLlQ3QMnsLOog==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr3816014wme.120.1589874717602;
        Tue, 19 May 2020 00:51:57 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w18sm20019697wro.33.2020.05.19.00.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:51:56 -0700 (PDT)
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
Subject: [PATCH v2 2/4] dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
Date:   Tue, 19 May 2020 09:50:58 +0200
Message-Id: <20200519075111.6356-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
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

