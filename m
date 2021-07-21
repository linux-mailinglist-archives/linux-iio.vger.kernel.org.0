Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFC3D0DCD
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhGUKxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbhGUKNV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6451C061793;
        Wed, 21 Jul 2021 03:53:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l6so1081238wmq.0;
        Wed, 21 Jul 2021 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJLPqjjadNqhWPoGAN+pkYM5Do/hyvJF240tN9r8QeY=;
        b=BBHF9cWJXUV0DxxVI5a6ZoitdphhzhjsBHqsoeK/iOSSpkbhNpWDC2G21o6D+ivFh6
         Q88ZuIK3Oc3iqF2I4HnZ8/aOKY28bSFOTQK79Qhw9J6YwRPkyjwI+ts1K6sC0FTaZFpn
         20MYCNk8R689/agbnGHFQSDUVTn5ue0L5FvJXjx0BOMFbO3oxAMHemuddEtzJVjdYD51
         hxyQY4ZMwr+qw4Py+d5ESsNeR2HdeFotrEYcsUG4f9bM8YH6ZXXeat2eqMU47NaSEMdJ
         32r3Jo9amfPs/+nN4yrPlzPAb+Hu9Y6XWmRRbSS78LTJXEvc4qdHhR0Aytp1wWSyQyRC
         bvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJLPqjjadNqhWPoGAN+pkYM5Do/hyvJF240tN9r8QeY=;
        b=b3mWjAnobzDueA9pO9HN4MPwRCO9Ez93C9zUyr7vI7W5arfb3axk1waBkqOsW9qBBo
         Hv4CIpUZocfqIvXRtLuUEKiP1t+imvsEOiuM2FCap66HqhrerEB3++zNrUuZI1nHPFho
         UMgoMwGaY/l16bx5juRNvrBYtFQmwtjE8cq7UKnvaQ315C0CwZQh6ScAawWzDjIs8wYO
         ylMZuMB0ejvGVhRc4j68AnD84xA/LN5sAbfQN0PVqBXVemBSTQFk+OHJxvfgrW5lYn+I
         gu7HvI4M+zhQa2RAaWqSDscSxrDGo4GjiSoqYshUTKqn4auoUXulnQXqZmclA5jFK4ZY
         eKZg==
X-Gm-Message-State: AOAM532TTikwldgrf8k2E8OPaZofBXCDyeO5u4IRAnYaLQo97JzMq74n
        C0pQATwRkj7y2f1HdPFNixo=
X-Google-Smtp-Source: ABdhPJwllgUANedBfKfd5LvirYSQm3kDpMoeWT4BPjiHaqIL4/PLmQnOYTN3WG2XLrbM6SRZWkqnZg==
X-Received: by 2002:a1c:5458:: with SMTP id p24mr28502629wmi.131.1626864817224;
        Wed, 21 Jul 2021 03:53:37 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:37 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, citral23 <cbranchereau@gmail.com>
Subject: [PATCH 6/6] dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation
Date:   Wed, 21 Jul 2021 12:53:17 +0200
Message-Id: <20210721105317.36742-7-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721105317.36742-1-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: citral23 <cbranchereau@gmail.com>
---
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index 433a3fb55a2e..1b423adba61d 100644
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
@@ -43,6 +45,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  ingenic,use-internal-divider: 
+    description:
+      This property can be used to set VBAT_SEL in the JZ4760B CFG register
+      to sample the battery voltage from the internal divider. If absent, it
+      will sample the external divider.  
+
 required:
   - compatible
   - '#io-channel-cells'
@@ -53,6 +61,7 @@ required:
 
 additionalProperties: false
 
+
 examples:
   - |
     #include <dt-bindings/clock/jz4740-cgu.h>
-- 
2.30.2

