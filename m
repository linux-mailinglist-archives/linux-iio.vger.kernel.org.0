Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0360D1AF77F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSGGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 02:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGGC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 02:06:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37049C061A0C
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:06:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g10so4776881lfj.13
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VX6tMFQF79i/ftypgBXXLpWGwJKO5n2LFJJUQCNDLbI=;
        b=VYZRXgtt76KAzkGTlkhcYV7C3oZ54V2PNDiye5y4PpD7RY/ZDHqj3Sl6JjfiwKt3K0
         aIfHvPz9odBQXH4HcxGad6bp0w4xeCrvoc4CqtBN3G+gcLRAj+Fjvda6OfkjVcs40IQ8
         4quT6a+ZnD73s8JhwZAnBlQHZwpQqt/mvnqxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX6tMFQF79i/ftypgBXXLpWGwJKO5n2LFJJUQCNDLbI=;
        b=Zt0o9XL9X6Im76mt12iFGR6F1mA4nlB/bAJU3Rf8OWCd6CyiOex8O4BeaJb5xtGg0M
         OB638mipqwaA99hUzmvymApXoLdGT+FfYvdQYg7Obkm4buRWk87jswlfRooZiN2x9tk8
         kumcNzFGvwC8TJiEHNNXu2fa25JMjUzPYylMTTSJcGoX6qRr2xICOoXAtq1M7IG335sC
         Gvg5JctrHWkHkcrbvHkv4B4TSIYyd7ybvEmGMu3Vkq9nyTavVupGZsjFPKvoIOSvZUHf
         8Yy6D8tOHgl2DrEH6ifF8l/Za2r17onanGUpjDNoQhxGSVkiyZVV4MDnSmZNXp9Z6P8H
         uABw==
X-Gm-Message-State: AGi0PuYA5DSwoPSU/ENiLgGhFkqgaNTimrZ3J6ue3FVEdakccV2hcPXk
        cUCLz7imK4KmG9nIU+0B2AMynQ==
X-Google-Smtp-Source: APiQypKamEmLuz1pWmrPKe03nYQbtpKARp5yKm25A3SvjGluCLrG+6Atb/fzGnCrfQBg0xpMFgTChw==
X-Received: by 2002:a19:6448:: with SMTP id b8mr3378653lfj.18.1587276359665;
        Sat, 18 Apr 2020 23:05:59 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id o22sm3695002ljj.100.2020.04.18.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 23:05:59 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
Date:   Sun, 19 Apr 2020 09:05:54 +0300
Message-Id: <20200419060555.14433-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419060555.14433-1-matt.ranostay@konsulko.com>
References: <20200419060555.14433-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
index edcd2904d50e..0e510a52920d 100644
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -17,6 +17,7 @@ description: |
     http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
+    http://www.atlas-scientific.com/_files/_datasheets/_oem/RTD_oem_datasheet.pdf
 
 properties:
   compatible:
@@ -25,6 +26,7 @@ properties:
       - atlas,ec-sm
       - atlas,orp-sm
       - atlas,ph-sm
+      - atlas,rtd-sm
 
   reg:
      maxItems: 1
-- 
2.20.1

