Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762B83E338B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 07:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhHGFKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 01:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhHGFKW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 01:10:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA0C0613CF;
        Fri,  6 Aug 2021 22:10:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso21124540pjo.1;
        Fri, 06 Aug 2021 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kghyyJxSpclsPJ1K6EIJRBwrjxsocrELM9KMy58Xt2s=;
        b=QibVC/zWldqXsbN+DIYBTo1GiheTX+w9U5DvmSRpXTKxFLcuz41xUa0dVLZ1aYi3fX
         rS1avKXBOqCVwJyir8k1aYichno6/ACYFkyg9XU4zBo21aCHTLyMHsuIMId0ViBFZ0m+
         NvHIqMFY6kFDCLAT+8KnLwgRwKO+1vA2eGlvXLulGOK9VNGurZtvS8Yxnd1K/oGGPhA2
         ylw+wp9tsj3hpLLQzccSu3oOhfzcHuo3DDqFH+9T2gJmb7CN5fHbOO8/1g2Rj5xiip/8
         x0Khd77ZV7N4c6S1lVjFqFD3yJ2A/DPm574kPrd7ztDQD7oMIE1s1FLBoGE7sT+ndAan
         858A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kghyyJxSpclsPJ1K6EIJRBwrjxsocrELM9KMy58Xt2s=;
        b=jyjZCGDcNRlzbek22gqnFCUfitPHzHDOtuRwkP9A/Q4UXuNVg9MSWp7Uffa5clx0vS
         2KxTnSvQ3mAPxrzaoyUhpCbgOYvwoA7ILayJvBwfd3eSETy+hhq+XaixfymQAPAH2snN
         D3JVcyk7ARjqweCtdnfShmo2zQGVOjcKfObDG5RCVJAyuJQdCGo0KNErCxNUjCvWQYvQ
         RnGkWMFKPWZq9LhnNTRYoBu5DpWpWtOaQPr16gdqkw0d02bf87zl8i1bLWNpYgMnHHPX
         BsfztxK186EAKByMEmIG1NYAzRNsgIIjmIXpKjgUqZuGtwO+zk93P7JE2NlzgfHBGqsT
         deTg==
X-Gm-Message-State: AOAM532fgblcirIvfnd1csT2DkKDRFyevz3WtTBL1n9O7F0hwylHRpx5
        hmPC7YOyx1SGjnMHcTICkno=
X-Google-Smtp-Source: ABdhPJzwMwc+9s9qzMTOEkWkrfU5Rf9CL0SV4sCJZXEqStnfplJupRVgETCb1WiWcWL86NKEqAkBCg==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr4311452pjg.153.1628313004001;
        Fri, 06 Aug 2021 22:10:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:92:61e9:aa2d:89ae:905d:dacf])
        by smtp.googlemail.com with ESMTPSA id l14sm14433011pjz.19.2021.08.06.22.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 22:10:03 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
Date:   Sat,  7 Aug 2021 10:38:54 +0530
Message-Id: <20210807050900.10075-2-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807050900.10075-1-dmugil2000@gmail.com>
References: <20210807050900.10075-1-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add AD5110, a Nonvolatile Digital Potentiometer into
trivial-devices.yaml.

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8341e9d23c1e..55c8a6ce5057 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -33,6 +33,8 @@ properties:
           - ad,ad7414
             # ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
+            # AD5110 - Nonvolatile Digital Potentiometer
+          - adi,ad5110
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
           - adi,adp5585
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
-- 
2.25.1

