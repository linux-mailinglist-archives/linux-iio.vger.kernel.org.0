Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1842C66A2D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGLJlh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 05:41:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGLJlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 05:41:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so9230455wru.10
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2019 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=XTv+fxtBppMxkNUV39HwSKjm+deYXMOAp6Ae0Cxil9saa5GRQbgNN2qbAu8xmovzhX
         Rizm8MeFlAfIZQDiK2g63C2f3c9YL2Y589epi9ViyKSFWM/9Swhk9LjLmF8BJzQLK5el
         bpOrLB/yViwvEwiROw1QWsjAijEiIKYpCCwPBWviZElDCA0LyvPfXuKDbWDkVHGx5Nl5
         aJQjmT0cJ8zJGAyym5GDlImqqUu0CaB9uGG0fdQAP8JxWbdc5ww23koVWt+TLzMuKiyU
         o3yOBRYh3+2ErTbTK/K9+uFFnKPdeFVf8tTxwXpOrqi34Riypne26yTXkeBM66HbHnaf
         XDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=NDlYyXTfI3sFrzeklcVJkG0szlXN4wpSzIjD4KnKctPvYqlkmyK9t8uUAAmnCpKLPe
         4K4WCUXFM5kYix0r9oddgC7d1DLFxDkRiiWpBLqI+HJrT1ZWJpB7wdw8rXBxZbz/9q3/
         l+qQ+oYN2EjVbbfkbhEzjt+sGZL13OYP1sKO2vRiyTsdW7DZe2LKXqJZKCsMzxAkMQ5X
         ylF5Vc0f2MlbWFaDsKX+rZ137GqiT3udspQvAHEoVUoPmsF/olfIm7zxm9C9Z9GFn1jH
         THmizx17kg3LgUh4FQuqJENXH797y0ov0FCKBuJWbPbpAoK0Ly8flsa/P6GtZKVwyDuY
         3AVQ==
X-Gm-Message-State: APjAAAWJVBzZfa77HS+X+M86JnygGu+WH2RY5SxI6DWrhj1i8DQQ1X8V
        B0GlFq/D3s88VbzByCg1zQKdAw==
X-Google-Smtp-Source: APXvYqyrQ+MUolkbRBUnnn+5K9p7+mItRVyATvV7pPrRV17zZ3oBg9tIPdRguwVSaC+rpzEMJP9FTw==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr10072939wrr.147.1562924481709;
        Fri, 12 Jul 2019 02:41:21 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id p18sm7310891wrm.16.2019.07.12.02.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:21 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 1/3] dt-bindings: Add pixart vendor
Date:   Fri, 12 Jul 2019 11:40:48 +0200
Message-Id: <20190712094050.17432-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712094050.17432-1-amergnat@baylibre.com>
References: <20190712094050.17432-1-amergnat@baylibre.com>
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

