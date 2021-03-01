Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46A328105
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhCAOfJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:35:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27387 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhCAOe4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614609295; x=1646145295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T01QHroDTifBHT+o9L4TIOWzR2MlBG4uk73Ik065wXw=;
  b=nFiPiQKXSh9e8BUeUFNn4DhagFQ1MvdhIWQDQNun6v2B5s0uBTEvJ8Y8
   fOvjMwu7X03VFtuHJq8M6XCUDCLeC34A91C1k/jo1BtrL0KrFRp+1PYR8
   eXe36jENRV/Bz1ECQbd6qk4c2YD9bzBBKKmiFufncbDlABydraocxVz/X
   hRpYSilTDq2QRicTEwXbxy+fH5mhBPTQJlvxlVDW7sJz9HqjJGKRueBbJ
   IeOCWvG5TXSNX5AmC+YZXcSwg8fbTYDAp9mh62zS6ukq9ceE9LMW/SkGM
   bi/rNXjCOInmufIJF3bJ16xqdnmt8AgyKpLwH/060MgozPv3kHdTvrJgZ
   A==;
IronPort-SDR: WZvgDQSGg/XPaRab0clYrqs7Gzqn6692lfLxYvcfpuMNPfpIf+PHIWHfD/tw+QHqyJV3nqKH5G
 2B0ZAba39Ut4ybUhldAJogEe9HW4a39GZs3Uw52bfHRJWJjJypmGxWnVRMpVAnkafhvU7yqr3r
 DyLfAAenJ6LcMGWGA7nsiLj83QK5mnCH2ywJVcAuIBhWQ0tWV/WNPv8+aLU19+KADjXDT/8/Rf
 f/piZ5MBsLUWau5BGzCn5QUHpeUYDsMPxE6ugki1T9dhSYIteUUMiERkXyG+Z/V7SKmuHRq/1M
 ig4=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="105498529"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 07:33:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 07:33:24 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 07:33:22 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 3/4] iio: adc: at91-sama5d2: remove unused definition
Date:   Mon, 1 Mar 2021 16:32:55 +0200
Message-ID: <20210301143256.16502-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301143256.16502-1-eugen.hristev@microchip.com>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
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
index 63325f037f09..066d0ad644ca 100644
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

