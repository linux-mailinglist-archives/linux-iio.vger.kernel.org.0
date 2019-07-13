Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD536792C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2019 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfGMIFV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Jul 2019 04:05:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35509 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMIFH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jul 2019 04:05:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so12117387wrm.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Jul 2019 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=VyOLpZSo1+lXygJnf7L4tUyVOCvRuvglGR+cOpoMEp+aWlzqFfR0oFDg6Ca9Xyo+AZ
         iwt8F+9XEFXRioksk0AOG7h1zmgXCRhkJiX/BdVnMGLlAjcR543kaqU3aBJe+GqiWhAb
         5J4/EtZ2uHB8VZPW9j1oQxHR3U46wSFjAxyHVNTq6YKwWj6GLnjBYXujHfKfMX4jWc5N
         a4mhxWB7PFeXv5NRvj48T/1pFPXVtO+mcD79EjRloDw2TXUKKHVY3yeKHIy/LvqyDI/5
         dLdyCv8oT4tomgqaSPriTKiHwUQ40mRrqSeTg6psi4ejBHHQhN3M+jHRgGH/f5FPCUeu
         X6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=FWxfy92lbd+2mTr3XnYLlO3BCQ6iKigBl9DswlsW9l4q/6TfQSWNCfnRbWJXya4gqV
         S/IdBQALRHXv5sCHsliL+oLP2Tq6nBktcnc2jV+AchsjD3f+jh/Wevc2rEC7cRDkAmq4
         DP+m/CgaMZFtoQVCUwVMb8y7FhnttY99oACunfIaeZEJCFvSpNO5c31VOw29KOrvSeOs
         mIk4UYijtfgBHF7mtIs7tfmG1ahv4Yj7eAsDXOccTdmt39eZR9EWuR9h4dwXHv4DSh1s
         SFRY091m830wGZlQOOfN6qK8YUZR1hVhiuEZn7+34/33eiYORf1wTCh/xjX9d9FBCQFR
         eZsA==
X-Gm-Message-State: APjAAAUBkbaFRO7acxz45smoyWYx/KK07B+vB2Zjo+eISiCzV4pkscwp
        J9g4s/SXeoyZx0wXPDVzQK19Og==
X-Google-Smtp-Source: APXvYqzwLKvM1hEt5S+/RZGioP8rLTZCageVp8c98fn1RIYt39e9v/S7ytPFoajyUtUAlye133fipg==
X-Received: by 2002:adf:de08:: with SMTP id b8mr16247723wrm.282.1563005105302;
        Sat, 13 Jul 2019 01:05:05 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id o26sm9621634wro.53.2019.07.13.01.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 01:05:04 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 1/3] dt-bindings: Add pixart vendor
Date:   Sat, 13 Jul 2019 10:04:53 +0200
Message-Id: <20190713080455.17513-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190713080455.17513-1-amergnat@baylibre.com>
References: <20190713080455.17513-1-amergnat@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
capacitive touch controllers and related imaging application development.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 18b79c4cf7d5..120529f40c7c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -705,6 +705,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.17.1

