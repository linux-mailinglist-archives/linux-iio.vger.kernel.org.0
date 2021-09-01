Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D303FDA5F
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbhIAMcF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27508 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbhIAMbZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499428; x=1662035428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8q1BEpaua/HH2cC3dulzG6TmzCuYyUWyJH4PW2xp7A=;
  b=ANoGlB02VuK9vc5Z8GxT8mxssLHDSTD0zX9qjgi63l6e4+QAbhcI1A1X
   b9dPHSTGesk44NU6OnrB9xRlp2OLY+03NI41L0TTzN43VCdmZPKnqxXoo
   VbxBLbVLHobPnHGq3D5/ZJ1VlA6upmjs4F7d3Pdy2LYFgDdoGQzwR02bG
   se1CbPaFQf3QdMCbHgUfjS8iM0xT5tTOJ7z1fPmy+SxaAgGCVYie/JaMk
   HWHb7y++BVEnDoNaUcNB+e+onfpHbvoFXc6D3JbcUgH+DqrPHCB1pRzIC
   dbEpcv/wXv04mFOSu2OiwJWjqk3Jw9/TuVGNIMguQrgwWNY6YngK4ngCd
   Q==;
IronPort-SDR: OQBabRmA9RyquKBzdfsrVjxzFAB9kgyMtkTcjeIrIRIy5IUZgPKwNdM3NTCl8ZPnI5Y/4n26x8
 uRt/3oyRzToO8PtrAcF1eGQ6oYC59cBm2rZklX0KlczlzuarXkhIZ3L/nlxt+GnmzVaR07y/yb
 7qXYfMPI84pJUBDwM1dDOCKf+PHWeVltrriGXo5b+CO3tqpYHencz0C3H5nG18ZUgK0polH8TL
 ++NsNZD6On+6d06TkiKnloo5R/53EDlit3Clup/YqGQeX5Ud0eDXh1BeC/Y232cwp48UcGPJ8o
 3d5NNGs+gW80bqr+e51tiEnt
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="130318327"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:27 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:24 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 01/10] dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
Date:   Wed, 1 Sep 2021 15:30:04 +0300
Message-ID: <20210901123013.329792-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add compatible for microchip,sama7g5-adc device.

Acked-by: Rob Herring <robh@kernel.org>
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

