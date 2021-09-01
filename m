Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A8D3FDA65
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbhIAMcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55493 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbhIAMba (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499433; x=1662035433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8w0t57RJ9zod2R1KAmUAMzSbs6tnMsal9eBuwBBrAQY=;
  b=RT/p9HTJqAvcpREm80pSYFb8MBGWwT/dPW1Ke/Tp5AKdBd/Viwj8zV5S
   fqsMwF7ixWAj5qk9Ft/e6cvNSoXeoWjyJ6h6SITXFSFVsz+LOOQvtWmVw
   pU97ww7tz18jRSUmtBNEFnI+z7QFKsli26NhOUjymzOZCUleW5Njzo8IN
   fuv/0FCmlh/NnkgDVYozkfqybBOkRGITy3oZ5454huhuW0iB/90ExNdWp
   O6rLwpQaqKvfY0LgHJ+Pff+yEgEc8HmB3OSDjvTSnGXfTpmTX6mcZ/vgW
   uRoZHDHr/ayr2GHyJB0GNohVizMH441L+yUpxOTVODn0p1s4H/JnwsOXZ
   Q==;
IronPort-SDR: CQvGiX9JeozmbXPUQv3AIxtSNTeSI5dMHynVwK7b+RdaeT08BPaLXSS4RMA9+gI/hdcQZl+PM6
 hEa4yxiNLLPted1+/638/eYrDSqHtVzrClZc5vR42wofkaErR2nGGiqaXu9Uw2w4Gah2M7KLLb
 0A2P0mZ3HpcSqQeb+z+Yc26UVVAMldbtG1h2jzsl3jWFv0e8CiPrnZYrEU+eSwN0KMEr4x4vfN
 gE4ZIacDszIc8UPzKUQFCduLuryvxXliQ8Tm19Omhm96vT1ZF9ARX1+q1dF838q53+lCbK5vMq
 0nsySnN6b/avlfnjc3dUX88m
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="134969777"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:32 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:30 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 03/10] iio: adc: at91-sama5d2_adc: remove unused definition
Date:   Wed, 1 Sep 2021 15:30:06 +0300
Message-ID: <20210901123013.329792-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove unused register definition

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 1f4d461c2c18..9d71dcffcf93 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -143,8 +143,6 @@
 #define AT91_SAMA5D2_COR	0x4c
 #define AT91_SAMA5D2_COR_DIFF_OFFSET	16
 
-/* Channel Data Register 0 */
-#define AT91_SAMA5D2_CDR0	0x50
 /* Analog Control Register */
 #define AT91_SAMA5D2_ACR	0x94
 /* Analog Control Register - Pen detect sensitivity mask */
-- 
2.25.1

