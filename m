Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C091CCFC6
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 04:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgEKCcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 22:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729388AbgEKCcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2020 22:32:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA7C05BD09
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 19:32:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h26so6146896lfg.6
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WH8zS66RY8W04XUM1pecSUY+m/Om2TcnzwoU0cWSKDI=;
        b=OawOFF1cZc5W2QBJ1SGSBnyOrjUqtgUoa/fqRc5YZ8z7ELz218a22XGfEFXyg651Zc
         FYVUDc7KZ/MNWLjiWVAOLlFbTZ4xoAD0ykGBYb3WJVz7Z1PhpcNzg4iYxQ9/Z5lSSd7W
         i8S4cQYMvqCn+tZYTzL0wfK0nuw7na/FzCjZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WH8zS66RY8W04XUM1pecSUY+m/Om2TcnzwoU0cWSKDI=;
        b=ABDbZgxUP6hCDhhMwlG7ztrDFNhdUZM8sgQ/pSHNVq+NXfN7FWMok2fVmNOQyOuiP2
         9qa0u0BNiYKDz8mcNW+FMvrIbWQQACapdV0OuAfRM9lQXcbkkzy3swkUOC0mAR5m/aiQ
         2zWThGrzOQwMAPAq9Exvs9TbzS19rD80wIlQhbDgn4BCTf6a3hLMJWsuKHTskXGW2zRv
         k6mhLLl+Ojel9LqeNkiruZlDak16qz6LTgDgOMP51ABSW8Ga4TXQV0FznURNZg4XvRSr
         uLqoz2XhQn/IxHE6J9iDNhpDmf/FJPEAFJCQaNoHy+fIXm9zlcmyI4ob0pOmOAtYx99K
         Ifdw==
X-Gm-Message-State: AOAM533oVzFjjhnRjfwvYATbmjLfMucOsHfUz7NL51Ti04g4wyZsIKLz
        /WJ+DyVo35w3YCEav/RZQxR/7c52HYQ=
X-Google-Smtp-Source: ABdhPJzqN6hRh60E1JzXVqh1Wwmr9ySPA7ByBUOuH8GB6uNjukh36OhtZqubPRAUQwzR9RNiVdnsvg==
X-Received: by 2002:a19:2258:: with SMTP id i85mr9363084lfi.86.1589164340592;
        Sun, 10 May 2020 19:32:20 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id p6sm8624051lfc.15.2020.05.10.19.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 19:32:20 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: chemical: add CO2 EZO module documentation
Date:   Mon, 11 May 2020 05:32:13 +0300
Message-Id: <20200511023214.14704-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511023214.14704-1-matt.ranostay@konsulko.com>
References: <20200511023214.14704-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../devicetree/bindings/iio/chemical/atlas,sensor.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
index edcd2904d50e..0d109e1b34ee 100644
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -4,19 +4,20 @@
 $id: http://devicetree.org/schemas/iio/chemical/atlas,sensor.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Atlas Scientific OEM sensors
+title: Atlas Scientific OEM + EZO sensors
 
 maintainers:
   - Matt Ranostay <matt.ranostay@konsulko.com>
 
 description: |
-  Atlas Scientific OEM sensors connected via I2C
+  Atlas Scientific OEM + EZO sensors connected via I2C
 
   Datasheets:
     http://www.atlas-scientific.com/_files/_datasheets/_oem/DO_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
+    http://www.atlas-scientific.com/_files/_datasheets/_probe/EZO_CO2_Datasheet.pdf
 
 properties:
   compatible:
@@ -25,6 +26,7 @@ properties:
       - atlas,ec-sm
       - atlas,orp-sm
       - atlas,ph-sm
+      - atlas,co2-ezo
 
   reg:
      maxItems: 1
-- 
2.20.1

