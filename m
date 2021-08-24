Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC73F5D86
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhHXL5a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:57:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21049 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXL5a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806206; x=1661342206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/J86ztntE9f8t4J4JjnAYoZe2v27xm84SOkdfCjpCQ=;
  b=OGE3fmqrIrR1lB76xjKa0JNIraUrGK1tmGN/RIj+n0epU7thG+33Eugv
   DBh2ET2KiHHFNDWWw8nmusZAOycwedI+l09Sx+x0r/nUoCMAtwJBMEzVa
   WCs/5n8MRnzOT1b5C8XgG9oWTaVzCLFCUfc+K+FJnSITYG8CL7GKAy+4Z
   9DMwPHk8AIa7doq8jNj4bO/BIjcGiTmulQexp1e0SI8Q0Um9fn31ntILq
   WYWZMjFqoZz+o62OyCeWFl+a1rvMJQ+pzvGFBGZfD0JrB77ouMKdZglVl
   o0Vl8RZjunRAr75bUoiH5qq5nX+4xPHKnSGjXfQuUbNxuzAz/Hcswrm2D
   A==;
IronPort-SDR: eWgGFF5wy7xlPQqZjV/6CWNqR8W+t7RixZxZUOS34GB0Vscy5ThHPkS7ForTFGxcKBwrho3oIK
 cDp5WzVg+jr9ThpuPKuqTrySt5gqLnKVwwoDalPqM99r6O8EHk5NEDEoKGmNIAM/FLCKzJXVYz
 zKHhd9riQMOkZrlbOjK9Jvy+2c3ZbuLMMjIWq+v1Ekj2EVb0iFlbOHsm7MapFqio0G82Z9hqz/
 waSEVioQyc7HVuaI3/1tB9Re5BR1IuPN7nxQpyJDXqifN/bPdqK5E9SoOzozx5Hp3IHJ+7c6N2
 0uqxiQhLEuREPaTqJ8xU+Ums
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="133408273"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:56:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:56:45 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:56:33 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 08/10] iio: adc: at91-sama5d2_adc: update copyright and authors information
Date:   Tue, 24 Aug 2021 14:54:39 +0300
Message-ID: <20210824115441.681253-9-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
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
index f3f5230eac54..d2bce04a5caf 100644
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
@@ -2188,6 +2190,7 @@ static struct platform_driver at91_adc_driver = {
 };
 module_platform_driver(at91_adc_driver)
 
-MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
+MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@microchip.com>");
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com");
 MODULE_DESCRIPTION("Atmel AT91 SAMA5D2 ADC");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

