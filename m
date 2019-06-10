Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3313B950
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbfFJQYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 12:24:15 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:5850 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbfFJQYP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 12:24:15 -0400
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x5AGNmjj009558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jun 2019 10:23:48 -0600 (CST)
Received: from SED.RFC1918.192.168.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x5AGNlvZ060907
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jun 2019 10:23:47 -0600
From:   Robert Hancock <hancock@sedsystems.ca>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, ardeleanalex@gmail.com, michal.simek@xilinx.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, lars@metafoo.de,
        Robert Hancock <hancock@sedsystems.ca>
Subject: [PATCH] iio: adc: xilinx: support all platforms
Date:   Mon, 10 Jun 2019 10:23:44 -0600
Message-Id: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
X-Mailer: git-send-email 1.8.3.1
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the XADC logic can be used with standalone Xilinx FPGAs, this
driver can potentially be used with many different platforms, not just
the Zynq and MicroBlaze platforms this driver was allowed to be built
for. There should be no platform-specific code in this driver, so just
delete the platform dependency.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
---

This is an updated version of an earlier patch "iio: adc: xilinx: support all
ARM platforms", but this one just deletes the platform restriction entirely
as it seems unnecessary.

 drivers/iio/adc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f96a770..7e32862 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1085,7 +1085,6 @@ config VIPERBOARD_ADC
 
 config XILINX_XADC
 	tristate "Xilinx XADC driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
 	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
1.8.3.1

