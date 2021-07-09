Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCB3C2725
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhGIQB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhGIQB4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 12:01:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F7C0613E7;
        Fri,  9 Jul 2021 08:59:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q190so9781215qkd.2;
        Fri, 09 Jul 2021 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14uw+zqS97Gsy9Jw8EWJMOHgB1wSw1hOg4uDSLTFU5c=;
        b=dG76a9yH3Y1e18auAKPw1MrupE1KRYUQmlAFH7bwmoXRsHzuKUWXtHFwMrnzxnnBkE
         1MUDWfQPlrNp1RJ3tH3cQJfYuRW9SAZbiwOXM/MD4jvizDLL77+mbEEKyBtJoLkK92nv
         vHzD/QEl05O9Y+8EoFUXtgSWgRu78/QRJm2Y+LCeF3K4yshJs0+RPoRhc9imDFsc+HUW
         Gpf06FMJ09/PAKQEUaDZcJK8YIF8iKxuTrdOBaR7xGLOhXmg74M/SWeCT01n3xLolg3u
         YfhO1xvWFirUEs5XLyAYruv8+nRdBkCcBcKyHCcsgshdTWb5a6TXuKV1voTOdzWHKiE8
         /lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14uw+zqS97Gsy9Jw8EWJMOHgB1wSw1hOg4uDSLTFU5c=;
        b=GT8zFW1u/lQDJVBAPRq5n1vIZZB7Z16i9guydqd0Y239p5XBOePgLxtWrvmO5k87Q4
         iJP4pjXvxQRB36QWgzs4PB1ZiIyjc/PsT48kq1oqo7ejM/pDJtPo0Vm6791lYxZ/59N2
         VhtVeAYOLrrcoEaTNSEzl8iy3l9tX9VbB+BaVXDb6NOj2WgxFrdbMx361ZVdurzpOZzf
         qLoqd6Kwne07Hlvd0vBSgKjw00soZir2Et5/yJINWIcu/M+dASyA01JKLTgnWrjF7Acv
         mKgE10wROOJ4ZksQ5RyYxA3ISvYtkM5XzG/gteS0TlsgLcycp0wAJKRdu6Ljyyoc8xD5
         eKOQ==
X-Gm-Message-State: AOAM531fumE4ynUyRFRMl6uv0zn5jsF8GE9iqSJVrsN0NZ/xyxZxSsn9
        GCgxdumBaZgYJsTjHU9SVY0=
X-Google-Smtp-Source: ABdhPJw96U/oIuYyId/vjzXqqOD0KQWypdgvfJ37hY8C6oDIXfjseLPL45PBtUX4OmZcZdDRB2YOXw==
X-Received: by 2002:a37:9306:: with SMTP id v6mr38918800qkd.476.1625846351589;
        Fri, 09 Jul 2021 08:59:11 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm2606071qkm.66.2021.07.09.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:59:11 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 4/4] dt-bindings: iio: adc: ad7949: add adi,reference-source
Date:   Fri,  9 Jul 2021 11:58:56 -0400
Message-Id: <20210709155856.1732245-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210709155856.1732245-1-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add bindings documentation for the adi,reference-source property.
This property is required to properly configure the ADC sample request
based on which reference source should be used for the calculation.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../bindings/iio/adc/adi,ad7949.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
index 9b56bd4d5510..eae3121cad01 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -35,6 +35,27 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  adi,reference-select:
+    description: |
+      Select the reference voltage source to use when converting samples.
+      Acceptable values are:
+      - 0: Internal reference and temperature sensor enabled.
+           Vref=2.5V, buffered output
+      - 1: Internal reference and temperature sensor enabled.
+           Vref=4.096V, buffered output
+      - 2: Use external reference, temperature sensor enabled.
+           Internal buffer disabled
+      - 3: Use external reference, internal buffer and temperature sensor
+           enabled.
+      - 6: Use external reference, internal buffer and temperature sensor
+           disabled.
+      - 7: Use external reference, internal buffer enabled.
+           Internal reference and temperature sensor disabled.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 6, 7]
+    default: 7
+
 required:
   - compatible
   - reg
-- 
2.30.1.489.g328c10930387

