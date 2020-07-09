Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57D3219B53
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGIIm7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 04:42:59 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:1587 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgGIIm6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 04:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594284178; x=1625820178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=naiMyOesp8RxIMv5uWwrT0H5EbS2YkDtqjFU8DFRK30=;
  b=dLgi7J4TcUechEjK8VFTJoB3RD/ETITMryZVgGIQZJN1KyDAkCgVB9/T
   kTjmJPg4lquiVkaqSTc8iveC6ZxUqxalAPEnuhDyykwAsWtpeMQBrHYsq
   Mlmvwa2TrESxY1stf8wBjCltFdwVdCKQudOv6tP/P3rAtTip26+ijYAPc
   WYb74jV2k+TRhFOB0M+Q1GX2FDXJyYcoNUm3MFbQBYovB4ZyNzqlxfbV9
   lVMdK06ZCM2k04WRzZx/G0gPXavOEyRdJxNUg8nvUA2P5XWBCxdruauDq
   tjoO+kxw7ANb89PfUU/T4VIeITdF/tM0szhY1HiuAglCvIP45KZ5AdS4A
   g==;
IronPort-SDR: EjDE+njmwjGUn65WqqmWn/MUVsjvX/rLhiu/iqjMLdjuj+N/ywO8Xsnqg6FriavKX6B7Eyw6TN
 TUHekSDKXLc8aPQ4osEdWoKSBefCmD944vSpM67Gu9LJBwYXLLSaK/gE6upoDORyDVqd1uJpso
 sqU60yIz72XBQ62ZWrRU1qK0Iy3WlyWwpMZYG1Im0WULbZFd1BmXsFK7lU0E28CcgWQh6gpsMX
 Cv5hX+Ga2ohxve9seLpmQhryxq/I8LmLt8+JcqwotqKMH4DjrOInOBtMZN+m7otqfw7encsvt8
 K9U=
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="83127385"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 01:42:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 01:42:30 -0700
Received: from ibiza.mchp-main.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 01:42:55 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <eugen.hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH] MAINTAINERS: adc: at91-sama5d2_adc: remove myself as co-maintainer
Date:   Thu, 9 Jul 2020 10:33:16 +0200
Message-ID: <20200709083316.7290-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Eugen is, now, more active and up to date on this topic than I. So I let
him the full maintainance of this driver.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c87b94e6b2f6..0134ac72c42c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11361,7 +11361,6 @@ F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 F:	drivers/pwm/pwm-atmel.c
 
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-- 
2.24.0

