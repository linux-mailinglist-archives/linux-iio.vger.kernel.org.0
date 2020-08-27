Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF128254FE5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0URT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0URT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 16:17:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC4920786;
        Thu, 27 Aug 2020 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598559438;
        bh=cS4GUYfA2mpjTZHcDswZTQuydTNPBBrsH0/C6vnhDiA=;
        h=From:To:Cc:Subject:Date:From;
        b=bvHdmXIDoLQzRF7VhCRHEwX12kAlsbwwYUsk+qtkeLjd4ADGeeZBBlDCm+gZnUwl9
         WshnPewgQLn3EUQTVwOvl6Bbc6isRy3REDu4E+T5vkiXcSpJLUMhAX2txXOwJhQIa7
         28kl0M04Plw+YaeWLCKf7e9S+LHW5pnQkngsERnc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
Date:   Thu, 27 Aug 2020 22:17:07 +0200
Message-Id: <20200827201707.27075-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Emails to Beniamin Bia bounce with no such address so remove him from
maintainers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8107b3d5d6df..523ac1602b62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -967,9 +967,8 @@ F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 F:	drivers/iio/dac/ad5758.c
 
 ANALOG DEVICES INC AD7091R5 DRIVER
-M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-iio@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
 F:	drivers/iio/adc/ad7091r5.c
@@ -1000,7 +999,6 @@ F:	drivers/iio/adc/ad7292.c
 
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -1068,7 +1066,6 @@ F:	drivers/iio/imu/adis16475.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 
 ANALOG DEVICES INC ADM1177 DRIVER
-M:	Beniamin Bia <beniamin.bia@analog.com>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
@@ -1136,7 +1133,6 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
 ANALOG DEVICES INC HMC425A DRIVER
-M:	Beniamin Bia <beniamin.bia@analog.com>
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
@@ -16537,7 +16533,6 @@ F:	drivers/staging/rtl8712/
 
 STAGING - SEPS525 LCD CONTROLLER DRIVERS
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-fbdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
-- 
2.17.1

