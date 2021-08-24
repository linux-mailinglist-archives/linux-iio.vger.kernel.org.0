Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886463F5D6E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhHXL4X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:56:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16307 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbhHXL4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806138; x=1661342138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8w0t57RJ9zod2R1KAmUAMzSbs6tnMsal9eBuwBBrAQY=;
  b=Htb6eExq38qffOMCwp4J10lYs/5G2uK7lXNMkeIBZyWQLUBX03vjU5t3
   bhccMRNEqHoofKjx3Uy1B3Hknnd9MlBHN2LxZ3bd6qj9Q3U2GFSUH9y3z
   u2P3ZA6KeU7oq1pBmXy1+1guxDMgm0dVa8ratyTzLNY+EB0AXtOhzE1A3
   I1xXb3zyOF2AXY/AgQZYavW0TEwCMH9Wuorbybo75BZ297gMHe2fe57BD
   CpJAEhGdg7050pT9aI1VXUdYrr3JK3orUEtu8Qa3hQgwcM0Arbr2W3xED
   7BONpR6zNehZMTlfpKMIg6Onro+RUOeO0UATVX7cKl+hT7lkCdpI4JzQJ
   g==;
IronPort-SDR: tlqeZOWFwKn6Y2j6ILBDQ+zCs22hmbcVwDwFACmySY1mdE9BFoEzyOxPRsZKRU742nES3/ahzd
 SR8/jstP/y6aLXr+VROmgkxIiqtamQbL4iLdVYBeJjRbDkW4egD+3LS64iSXL8VOEO0522zOaJ
 96I43h0fPhHTf6TMpLymWyrer9exev8+LAAo1/JRSSKn7tlGFKjLLS5EoEDqTZMSCyh77Xv7Kn
 urB+pA1RFX9y98tl4xxle1J1nZ6l3tSciMKjv7hALTPWGTUXMYC8QXe47089FFBAH6Rob02+7l
 EuoZsHUM4AdabaWYMNsB+bCb
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="133945935"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:55:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:55:37 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:55:30 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 03/10] iio: adc: at91-sama5d2_adc: remove unused definition
Date:   Tue, 24 Aug 2021 14:54:34 +0300
Message-ID: <20210824115441.681253-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
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

