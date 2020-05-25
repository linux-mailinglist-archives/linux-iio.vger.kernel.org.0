Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612371E12F3
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391240AbgEYQrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbgEYQrz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 12:47:55 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4007C061A0E;
        Mon, 25 May 2020 09:47:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v4so14159797qte.3;
        Mon, 25 May 2020 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePbeLY04LKtJmRX1nqSPn8wvAeyibEffZJ0RrRlFqv0=;
        b=JLM4w3nepYPrG7RmTb9xQnZgReWbnmg17HkPWokWHv2HzX48rCeI/3gppXQdbPCg+e
         aPkf3B5ijeYBYA1bhcb+ijlyCGD+Tj+gzNRVeXhv23EFZtmHAyOBMCVVYa9ZXVOQ3KaJ
         tW4zLkp4nvxJE6MgxDUlUZzBhxi3kMv3R2yjZaB3Muw99X91JhXWGNnJ9kQ3yHHzlbC2
         nHWhp/JALH0EKVV80UUsScnj2xPthJ2PQSn4K49awE5WvlPRfFUEBxgakpUDP0jonIr6
         cUOxSJQILs3pKs5I9cm0g4GNRboscZnV8BUnrJi6hUh50mW25cbvjNQKmWbyZhPpDdch
         fHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePbeLY04LKtJmRX1nqSPn8wvAeyibEffZJ0RrRlFqv0=;
        b=LempSlRFfPF8qn52/KvxSyeJ+Dj5k/ZabwE4ZyodFQw/cS9vHk51sPrXMCWyTdCOy0
         0/vuSJyD9mH+GJNf6speQ931DMZ4xVafcE1YwXvJu8EoRsRG+f4Uhtr/JBm9f+RcIPUf
         nnXoS91GeyxfUQEp7jWtFZrSPxipOj+YlUKYCNqEI9oWOz0JTTzaewh5IHcCsZIVIxyp
         7SxPPlXSJPtYFM3Bqj7ZSt4EoKG8yVYkWLpuDELKx9ewosDK2ZD2IT9HNcT0cxsvN9rb
         oagJMGr42abFKceEDQn24d2JUrYNDja8SBg33kap0oh8ENa1K59STO5PrU8X7j2phMkv
         mdnQ==
X-Gm-Message-State: AOAM531GrTN2Ff95zqXVrHu4NO3w0R3SEQ1dCe1Il52xYlHw3N38kOU4
        WOn8YDSwSL9shdf0Yr5e15ADtoedpoo=
X-Google-Smtp-Source: ABdhPJx09RC61pGsRIeRpggIaHved1iMZKkjfuZPq9KlRW73cstyRwnAk0AG5hvR7WIUCBV6n2t9gg==
X-Received: by 2002:ac8:23d7:: with SMTP id r23mr29469263qtr.111.1590425273694;
        Mon, 25 May 2020 09:47:53 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id g5sm15559618qti.87.2020.05.25.09.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:47:53 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
Date:   Mon, 25 May 2020 18:46:01 +0200
Message-Id: <20200525164615.14962-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
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
index 0d0ef84e22b9..cfe40dbcd723 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -37,6 +37,17 @@ properties:
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
@@ -52,9 +63,14 @@ examples:
         bmi160@68 {
                 compatible = "bosch,bmi160";
                 reg = <0x68>;
+                vdd-supply = <&pm8916_l17>;
+                vddio-supply = <&pm8916_l6>;
                 interrupt-parent = <&gpio4>;
                 interrupts = <12 IRQ_TYPE_EDGE_RISING>;
                 interrupt-names = "INT1";
+                mount-matrix = "0", "1", "0",
+                               "-1", "0", "0",
+                               "0", "0", "1";
         };
     };
   - |
-- 
2.17.1

