Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839D8366D2
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2019 23:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFEVaW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 17:30:22 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:20456 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfFEVaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 17:30:22 -0400
X-Greylist: delayed 1324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 17:30:22 EDT
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x55L7rkn027599
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jun 2019 15:07:54 -0600 (CST)
Received: from SED.RFC1918.192.168.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x55L7r2Z061039
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Jun 2019 15:07:53 -0600
From:   Robert Hancock <hancock@sedsystems.ca>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com,
        Robert Hancock <hancock@sedsystems.ca>
Subject: [PATCH] iio: adc: xilinx: support all ARM platforms
Date:   Wed,  5 Jun 2019 15:07:38 -0600
Message-Id: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
X-Mailer: git-send-email 1.8.3.1
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the XADC logic can be used with standalone Xilinx FPGAs, this driver
can potentially be used with various ARM platforms, not just Zynq.
Change the Zynq dependency to ARM in the list of supported platforms
in the Kconfig dependencies for this driver.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f96a770..93863bb 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1085,7 +1085,7 @@ config VIPERBOARD_ADC
 
 config XILINX_XADC
 	tristate "Xilinx XADC driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on ARM || MICROBLAZE || COMPILE_TEST
 	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
1.8.3.1

