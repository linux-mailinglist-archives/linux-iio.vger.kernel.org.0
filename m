Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED7196171
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgC0WpE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:45:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45434 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgC0WpE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:45:04 -0400
Received: by mail-io1-f67.google.com with SMTP id a24so10928117iol.12;
        Fri, 27 Mar 2020 15:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4k13uf5713DqF6VnWYY7OaKrDxuIhG+KLjykTCZmLE=;
        b=Gv/I3R7+nOm+zatwFGKaLrr2HO4RHpM6Wiywg6KtnKTZacBCH/iLnHXPrVtmtU7U5R
         fRMHJNwxU/jxQEYWXRPYwDdfk4SmpRIY4RrNXxfIxEv59Y/sAGxWJg5OGo3vl5gX722n
         R6cKMvdscNifJPGOiQgDSfKP8U7oX6QB8PdhQeU/Fn80Pzcp2GAjphFe+aAjnnLsDss2
         NYxpyvMbfS9mBpU3R1WEjTB07ymrXS+dfVUAq2x1W5cHXUfypR34+iORfI2A5XsfJEib
         5Y1bNS9hclBlv/aSkn6OXx65/TU1lD0QaO5zPmUSpQqNiA9j9Ck3d1s6jvST9Tk1Fb8T
         ePjQ==
X-Gm-Message-State: ANhLgQ0NxNnuVl10UUWDG/OARaPvajEC8t/cZx1nbKfHmV7Dy5sCBO07
        bDnIU5eTGVq5cgF1ygBwKmyLhpc=
X-Google-Smtp-Source: ADFU+vsAE04nea1pFbNgX10KkqsBq3CtTvHBC//maalfcP/HRR+gaN6juo2FWt0zeUBHYvmVpvNbkQ==
X-Received: by 2002:a6b:ed17:: with SMTP id n23mr871676iog.165.1585349103124;
        Fri, 27 Mar 2020 15:45:03 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id u125sm1838651ioe.24.2020.03.27.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 15:45:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: Fix adi,ltc2983 uint64-matrix schema constraints
Date:   Fri, 27 Mar 2020 16:45:01 -0600
Message-Id: <20200327224501.18590-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

'minItems' and 'maxItems' apply at the same level as 'items' schemas as
the keywords apply to arrays. What's currently defined is a 3
dimensional matrix with the outer size being undefined. To fix this,
minItems/maxItems needs to be moved up a level.

With this fixed, the example fails validation. For matrix types, the dts
syntax must use brackets (<>) matching the schema definition. In this
case, the inner array size is 2 elements, so let's add the correct
bracketing.

Fixes: 3986a14870cb ("dt-bindings: iio: Add ltc2983 documentation")
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
I'll take this via the DT tree as I have another change this will 
conflict.

Rob

 .../bindings/iio/temperature/adi,ltc2983.yaml | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index acc030c1b20e..8fb46de6641d 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -123,12 +123,11 @@ patternProperties:
           sign.
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
         items:
-          minItems: 3
-          maxItems: 64
-          items:
-            minItems: 2
-            maxItems: 2
+          minItems: 2
+          maxItems: 2
 
   "^diode@":
     type: object
@@ -328,12 +327,11 @@ patternProperties:
           78 and 79.
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
         items:
-          minItems: 3
-          maxItems: 64
-          items:
-            minItems: 2
-            maxItems: 2
+          minItems: 2
+          maxItems: 2
 
       adi,custom-steinhart:
         description:
@@ -465,16 +463,16 @@ examples:
                         adi,sensor-type = <9>; //custom thermocouple
                         adi,single-ended;
                         adi,custom-thermocouple = /bits/ 64
-                                 <(-50220000) 0
-                                  (-30200000) 99100000
-                                  (-5300000) 135400000
-                                  0 273150000
-                                  40200000 361200000
-                                  55300000 522100000
-                                  88300000 720300000
-                                  132200000 811200000
-                                  188700000 922500000
-                                  460400000 1000000000>; //10 pairs
+                                 <(-50220000) 0>,
+                                 <(-30200000) 99100000>,
+                                 <(-5300000) 135400000>,
+                                 <0 273150000>,
+                                 <40200000 361200000>,
+                                 <55300000 522100000>,
+                                 <88300000 720300000>,
+                                 <132200000 811200000>,
+                                 <188700000 922500000>,
+                                 <460400000 1000000000>; //10 pairs
                };
 
         };
-- 
2.20.1

