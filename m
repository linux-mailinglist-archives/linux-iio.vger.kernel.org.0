Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522EF30CE43
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhBBVzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 16:55:49 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38386 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBBVzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 16:55:47 -0500
Received: by mail-ot1-f53.google.com with SMTP id t25so11301000otc.5;
        Tue, 02 Feb 2021 13:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4HUucybA4QgzC5/hQDmSLfk+25J4e0ac8M/zN4EUHzk=;
        b=hL7e1bX4UAcD6CpfQNBeSNJa5Hjs8MdEnKhzCivKoSd6diufDcePpDe4D9wd6DzFnY
         N6c2wSWtBmfcvMqXl4btKJsusOEPl49IKi6THFfzmTnHUP/9oUQDmbcIqj43/w3ZpN22
         4dOXVjVXdq4TLhbl16qRLPnXNTGNzuPt9ANn8/HijGielvuZhPjXmbD0aIHmI79eYajh
         0LesQeJLKhPJgWXUVn+qd7Ax4qYgBW13hSOT8a5PfisneDTfEmpcIM8mJKvQaKVa8+m+
         8wnOdIjyBwlGkqxaFxVZXahMSaUN1KlR6Q2AkWkdcGPt0bLW2jnLKSjYYJNcgSy6wDw7
         V3AQ==
X-Gm-Message-State: AOAM532/eGcvbcoA+yiT6qL4hgWRxPt+zqat0nrpjxvRQEoe3CRsPTO3
        pOCssh4CUy48nvbxH2xu3Jlzm+BINw==
X-Google-Smtp-Source: ABdhPJxeNHgTDt4Xzc3tlv8hFa6zMHkBlTbBBvjyFGbC9FmxtJ3JsBwEuzWcZxEux+aDJfmcRl5r8Q==
X-Received: by 2002:a05:6830:18c4:: with SMTP id v4mr16462695ote.358.1612302905513;
        Tue, 02 Feb 2021 13:55:05 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s33sm17621ooi.39.2021.02.02.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:55:04 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: dac: Fix AD5686 references
Date:   Tue,  2 Feb 2021 15:55:03 -0600
Message-Id: <20210202215503.114113-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The example and filename use 'adi,ad5686', but the schema doesn't
document it. The AD5686 is also a SPI interface variant while all the
documented variants have an I2C interface. So let's update all the
references to AD5686 to AD5696.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Michael Auchter <michael.auchter@ni.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Rename instead of adding AD5686

 .../iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml}       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml} (77%)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
similarity index 77%
rename from Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
rename to Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index 8065228e5df8..56b0cda0f30a 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -1,16 +1,16 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5696.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD5686 and similar multi-channel DACs
+title: Analog Devices AD5696 and similar multi-channel DACs
 
 maintainers:
   - Michael Auchter <michael.auchter@ni.com>
 
 description: |
-  Binding for Analog Devices AD5686 and similar multi-channel DACs
+  Binding for Analog Devices AD5696 and similar multi-channel DACs
 
 properties:
   compatible:
@@ -48,8 +48,8 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-      ad5686: dac@0 {
-        compatible = "adi,ad5686";
+      ad5696: dac@0 {
+        compatible = "adi,ad5696";
         reg = <0>;
         vcc-supply = <&dac_vref>;
       };
-- 
2.27.0

