Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25EB3FDA7C
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbhIAMcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9830 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244909AbhIAMbn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499446; x=1662035446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ygpEBisnr7jtqxtLkTuFOdwEqg//DVF5DOSwpSIa80E=;
  b=ad3Bliluvj44h1VdhNQrPsDLdohyb90AiMNPLAlySjJhmnEdI9HC7Lyh
   e3gWlBv+UUVKPgjeXzHDVsnyEuaGCUTAwjBdNJhI0/nL+ey8BeFprM5AG
   mmyNKF65F/UDLSm4qkGwF7WqNMuKk+cT9j+grEX9lZ1g6l/X7z7cHMyot
   qzkVM1iuSZS+gQFPcuDhUl0B5AsFmeGmsDXKlnLc8tZsequpdSEmNkYDS
   mHPgV+jwddlfkIxbK79Oab1n/zM4VQ0Pz9B/Kr0cdprffVuBUhk6AVHFB
   M0JP0MLcPhEWCpLFnav6htXuyxysCnRqZrhIUl4kyIDWr4JMgtqY8uT00
   Q==;
IronPort-SDR: jM7m808igBDFP9TJjjxUJhfJRH81oUCHINuOKmlKjyzqvfc4GEYaGL81SakFfOlXATCEjeN85C
 GA1Axyrg+9YzaW4xi0fl71LW342hMEMDAWqa2ONhSit4ShFoOB+6UI29P+WxSmsRBLTX5Zo3zC
 5LgsnV4LmWizFk+eemmMEcZjsdlZXfJReF4rbCHGgIvB4cxfzv1kwvXW5yQwgMib/aQZ8Ahgrc
 BbKepe23GTDnORW0CWP3/iLSpSM1VUNN5mwL5lZjl3Ow+ELySRA6t8B59hUIR/BjzAdyOy9XS7
 LOWUNjfK8R5hnti5AMOHZxDu
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="127848042"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:46 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:43 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 08/10] iio: adc: at91-sama5d2_adc: update copyright and authors information
Date:   Wed, 1 Sep 2021 15:30:11 +0300
Message-ID: <20210901123013.329792-9-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update copyright and authors information (corrected e-mail address), and
add myself as one of the authors.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 8a95310e8f64..2fc0c5d05d54 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -4,6 +4,8 @@
  *
  * Copyright (C) 2015 Atmel,
  *               2015 Ludovic Desroches <ludovic.desroches@atmel.com>
+ *		 2021 Microchip Technology, Inc. and its subsidiaries
+ *		 2021 Eugen Hristev <eugen.hristev@microchip.com>
  */
 
 #include <linux/bitops.h>
@@ -2194,6 +2196,7 @@ static struct platform_driver at91_adc_driver = {
 };
 module_platform_driver(at91_adc_driver)
 
-MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
+MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@microchip.com>");
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com");
 MODULE_DESCRIPTION("Atmel AT91 SAMA5D2 ADC");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

