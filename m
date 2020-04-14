Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3B1A89EB
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504189AbgDNSmW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504184AbgDNSmR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:42:17 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C7B2208FE;
        Tue, 14 Apr 2020 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889737;
        bh=lfSCUvZbahM1QeSSb7gds/7IyrvOA74gzlG0YM7J3PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq9hj8bzUBKBAXYzKGghDESvE+FHwmEbLm3Uo1eZ7vJlewn1ZeIz02zPskSlR1lAH
         Lv+7741CN1QAw45svmDXbfSzkRXBriwJ4b65yLNqtrViWmn9dgo43DcDx7bn16yRJj
         ERq1lG1O7baibJqrwl5OwpcTR39ZM9U/6Tzb5lgg=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 3/3] dt-bindings: serial: Add binding for software flow control in STM32 UART
Date:   Wed, 15 Apr 2020 00:11:47 +0530
Message-Id: <20200414184147.4857-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414184147.4857-1-mani@kernel.org>
References: <20200414184147.4857-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add devicetree binding for software flow control in STM32 UART
controller. While at it, let's also fix one schema error reported by
`make dtbs_check`.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 238c44192d31..ea5797a1b403 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -38,13 +38,26 @@ properties:
     description: enable hardware flow control
     $ref: /schemas/types.yaml#/definitions/flag
 
+  st,sw-flow-ctrl:
+    description: enable software flow control
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  rts-gpios:
+    description: RTS pin used if st,sw-flow-ctrl is true
+    maxItems: 1
+
+  cts-gpios:
+    description: CTS pin used if st,sw-flow-ctrl is true
+    maxItems: 1
+
   dmas:
     minItems: 1
     maxItems: 2
 
   dma-names:
     items:
-      enum: [ rx, tx ]
+      - const: rx
+      - const: tx
     minItems: 1
     maxItems: 2
 
-- 
2.17.1

