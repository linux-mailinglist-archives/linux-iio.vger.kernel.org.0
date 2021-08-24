Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA63F5D68
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhHXL4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:56:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:56638 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbhHXL4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806119; x=1661342119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8q1BEpaua/HH2cC3dulzG6TmzCuYyUWyJH4PW2xp7A=;
  b=Ho89bXodJ2lqkVUu7uYOMHH/kCK1nhHbSPgwR1VqAS0U+Oc8zLCIeoMv
   d/uMFiI6YSoGLJoNe+9z6VSSBhINKZs6YLrf4y6NRWmGwmU16beXr49z2
   qwJqaNCPxlb6DCn61V7CnQh0GgVxhSq7ikG40eQBpmoQfzfiKULWDKlTs
   s2B4CWQ6bgEtiEmbmTVoj/b+Ejk7o9+iFAAlphf3y0io7lwj+mp44jNTx
   aHJDjguZSFg4F/1PDotXwC5JMgeYMNlMmoNv0GP50ezE97oWgNhkd0rr6
   XK3f/No/SW5/nIFCth01D/BWkEIBPEgXeN2E/TLugA1jPfeR1JJ/wTiBl
   A==;
IronPort-SDR: OmKEG/WDt14J1VGgWUxL5RmPINOSRb7RCB/Vh26kOpTHO5PMCyUFp6sTlhF8f5iOUqFjKtLk6t
 q8qg/+0h1T2yOYW/PNTjdgiQvnOfbgQVigoas8eDQmM5HUOhYsrD3ch/Or8AQi/hkw1jvTNFTo
 cQ18eUEQFuieJWxRdHvra/tKFjXlNN/gkTxi3clmUWmjdu6hn+FtZBIehEKj18HQT15OInp7GA
 8sw7uowJqgEvMvcmw+XaEki7FC/ReYLv4cFBjh4fz7fizcdm/dG7+f4Gkm4NXtsRTs+sshfCx9
 9ytaQ6467QRzExd2DSRdufMV
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="133945921"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:55:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:55:18 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:55:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 01/10] dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
Date:   Tue, 24 Aug 2021 14:54:32 +0300
Message-ID: <20210824115441.681253-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
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

