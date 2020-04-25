Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3C1B842E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgDYHZb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 03:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbgDYHZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 03:25:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534EEC09B04B
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 00:25:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w145so9614524lff.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VX6tMFQF79i/ftypgBXXLpWGwJKO5n2LFJJUQCNDLbI=;
        b=Uo90dT5qPFrkcewUW3XrA/N8YnnL403bBnWwdV7jRRtGXXyZahUOZOdo2ZzQynkY6X
         uY+kcqOW0yAFC1dWc0cYDq/Fw/+ivtTzfTs/wZnho+A3QAU1+f+aO5ZdgLrvNWYZG/Of
         4fSNYgJJgUTIviXFwB6FETyky1jYRWVYIpuHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX6tMFQF79i/ftypgBXXLpWGwJKO5n2LFJJUQCNDLbI=;
        b=KkJ7Qo4heObYb2+e5lzFM6tvzq63yRVnWXlHrgh222QlM+woJb+aFmpvrRrhuGYzoi
         a9mhcLYt+tre4emucbGrADCTqHauKuRGQtwqrqXwODmwvyM4s3EvphiDpBiQJ5sfjRif
         QbxrI3V6ZfCkczrUlopR1orzNywX/njbMA+KxY7d+9CaYDj2SVQ8+Me2/i3O2c40LEdx
         VORUUpsrkGb3ArIeOGK3Zq31JZ6Gg8u+V36da/1Sld8G5Ap+LIT+E/vKJXquAy1HTQHa
         A1VxqzVyQzCNCcj3q7zKfXZHQqwfGKkH4E0JWjIVC7PvXJ/JB3yRHQnApM8HnUrUZmjB
         YpVQ==
X-Gm-Message-State: AGi0PuY6zeE9Z+dLexVS7NBJllZA9STvLkp5EKDgOXugylBdXNIA993s
        LieZ0Ngkv9OYSHLCRt4HyE42ji4qJ4ntWg==
X-Google-Smtp-Source: APiQypJuEBS7Xvm9F8pFZcCse1J92wNQtBwuXXu188KX3znHaJRiJE2W0LQD7dNqwL+USSVDVZiDLQ==
X-Received: by 2002:a19:c78d:: with SMTP id x135mr8655245lff.151.1587799528695;
        Sat, 25 Apr 2020 00:25:28 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id t8sm6382662lfe.31.2020.04.25.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 00:25:28 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
Date:   Sat, 25 Apr 2020 10:25:19 +0300
Message-Id: <20200425072520.27776-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425072520.27776-1-matt.ranostay@konsulko.com>
References: <20200425072520.27776-1-matt.ranostay@konsulko.com>
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

