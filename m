Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9883B3280FB
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhCAOef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:34:35 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27387 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhCAOed (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614609273; x=1646145273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e+pcNoW+z4Tfpn0FXC+20pV0rQdJccK4sUrqY/d4K/Y=;
  b=YzzRtILYgglLEOUrSoWka57d31SmNbq6EeiMDHzWaLL1l/xKoToy/zMt
   GiW+x8JU3WKSkwYY1zlFUqlTLs1TgHeKw1+fLgeZSywWM5WhiXtewjXBV
   1HvWUpUcVrYaAQSvcEAIypQmHu51TNeLpQyDOCdRYF6U60dWndi31gH/W
   JJSk8+N0RWtNw0R/bPb8nnROMDMAOoQeN9xtTTuyBmnjHINhogTj2aW4T
   BkcmB4I5qEIcrbBuMdsI/vmBhV9ZeDj7opf+jvGxxzF2z6QUQJP3sFQRO
   DZgswPAASd8NarfQR8PHVWqsXqlh7KKR2D7B9nmMyXDhBw8K+t+zZBSou
   g==;
IronPort-SDR: FcZ626acPNEDzkH85sYJs/0tRpPUIkCYUV6IreHpxxbz6VZdKZ/omvjKj/eJteEi9DP5gtoRbv
 +wtCY6YEXRvSrWY9odHQ3jNg/VmLwEIjtZfgsWcRu9z4t2uID24f+XdISvwGIdI7yTt0JmSTUd
 k0XcN9JYMxiGSue7Gb9/x65lO/Bq7XKhtgSf9+eetGxPDVDbbMOrND1qtmUqfjesfahZLqjNyI
 9MlHgHReVTpXMpC3d47VKKIY7I1Y95nk+yGYqQGEoSA60W5v3+2WZnF2oZqymKXv4N0o61KvZg
 Cso=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="105498487"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 07:33:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 07:33:17 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 07:33:14 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 1/4] dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
Date:   Mon, 1 Mar 2021 16:32:53 +0200
Message-ID: <20210301143256.16502-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301143256.16502-1-eugen.hristev@microchip.com>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add compatible for microchip,sama7g5-adc device.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
index 79c13b408eda..efed361215b4 100644
--- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - atmel,sama5d2-adc
       - microchip,sam9x60-adc
+      - microchip,sama7g5-adc
 
   reg:
     maxItems: 1
-- 
2.25.1

