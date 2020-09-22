Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E189273C4C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgIVHqv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 03:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbgIVHqu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 03:46:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A00A239D2;
        Tue, 22 Sep 2020 07:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600760809;
        bh=7FsxDUipcA2Jo8GB9HeMAPNBlonAHyKGXwKspgtl7Ok=;
        h=Subject:To:From:Date:From;
        b=xh8/3gvwCS5GbM32xrTvDT7StvbQSgXJYiNIhO+VfyyNNPr/SNyTnxgJS2zQZUsdc
         kMboeBlVjGMgQxGOhsl0e9u0WwYs7tkt5AyRBqywRmkx2WdpSMFk/A6kV/sbFwxDWi
         YOz5QfRIErju4jA35gwGpXZftxb9OFxYw9gRSqvA=
Subject: patch "MAINTAINERS: Consolidate Analog Devices IIO entries and remove" added to staging-testing
To:     krzk@kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com, andy.shevchenko@gmail.com,
        jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 22 Sep 2020 09:46:44 +0200
Message-ID: <160076080473141@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    MAINTAINERS: Consolidate Analog Devices IIO entries and remove

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the staging-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 50dd953ea094a4c2f2e45beb80a2a772ba16d64e Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 3 Sep 2020 20:19:25 +0200
Subject: MAINTAINERS: Consolidate Analog Devices IIO entries and remove
 Beniamin Bia

Emails to Beniamin Bia bounce with no such address so remove him from
maintainers.  After this removal, many entries for Analog Devices Inc
IIO drivers look exactly the same so consolidate them.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Link: https://lore.kernel.org/r/20200903181926.5606-1-krzk@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 55 +++--------------------------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e9d0ccd66a1..0e4fe7d2cec7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -950,38 +950,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
-ANALOG DEVICES INC AD5686 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-L:	linux-pm@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	drivers/iio/dac/ad5686*
-F:	drivers/iio/dac/ad5696*
-
-ANALOG DEVICES INC AD5758 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
-F:	drivers/iio/dac/ad5758.c
-
-ANALOG DEVICES INC AD7091R5 DRIVER
-M:	Beniamin Bia <beniamin.bia@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
-F:	drivers/iio/adc/ad7091r5.c
-
-ANALOG DEVICES INC AD7124 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
-F:	drivers/iio/adc/ad7124.c
-
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -998,15 +966,6 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 F:	drivers/iio/adc/ad7292.c
 
-ANALOG DEVICES INC AD7606 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Beniamin Bia <beniamin.bia@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
-F:	drivers/iio/adc/ad7606.c
-
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1068,7 +1027,6 @@ F:	drivers/iio/imu/adis16475.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 
 ANALOG DEVICES INC ADM1177 DRIVER
-M:	Beniamin Bia <beniamin.bia@analog.com>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
@@ -1142,15 +1100,6 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
-ANALOG DEVICES INC HMC425A DRIVER
-M:	Beniamin Bia <beniamin.bia@analog.com>
-M:	Michael Hennerich <michael.hennerich@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
-F:	drivers/iio/amplifiers/hmc425a.c
-
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
@@ -1159,8 +1108,11 @@ W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
+F:	Documentation/devicetree/bindings/iio/*/adi,*
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
+F:	drivers/iio/amplifiers/hmc425a.c
 F:	drivers/staging/iio/*/ad*
 X:	drivers/iio/*/adjd*
 
@@ -16483,7 +16435,6 @@ F:	drivers/staging/rtl8712/
 
 STAGING - SEPS525 LCD CONTROLLER DRIVERS
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-fbdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
-- 
2.28.0


