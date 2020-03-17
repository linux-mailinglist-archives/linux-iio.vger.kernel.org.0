Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0E18878C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQOdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 10:33:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCQOdx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 10:33:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so22276413wme.1;
        Tue, 17 Mar 2020 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZ8Gm8Lwi8byvGS1SsuSP8qCStoOok0sm61es2Y5ir4=;
        b=hSk7/+xsXC/WfuENBr96PLYaxU0PpHPsN5sAhzFiP9H6KnFTxGMMZN3C0Pubg+5Jke
         xAwv1ZtO1smLsXcMUPATjf3gJSeVd4RqEVhpgHMWRJuGlW6LqmqChyvWkxRCbOnwRwsG
         Mg3n6+HIUBsIQij3ZAFqArBG+FA5oP4NTepoflFByKl8so39Ks3W6eeJOnTHw3vYiFW3
         6LImETVVJjHX245SVb1xwyk9j62CEJ77dWRMj36TENKSbRhe7ht8L+1ygxtcTGTpDW8F
         U2GcE4sI4o5x7q+sqV0dbzvlOqYmc7+ieF0W5n9HYdTJ7uBIFRGB2n3DemxLio86reig
         iH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZ8Gm8Lwi8byvGS1SsuSP8qCStoOok0sm61es2Y5ir4=;
        b=Dd9/HRIdnlchUfYCDqYBSJmMiBqow3trRTMovP7zkRBWyaNFl0w8X7apDvpIghvMG7
         Kgbk1V9AaqWXpdWUOaN1jhsNfKiCqcpd0htAXk5qzCnEv9kVBWtjPEdN7KJzNJLNAE/l
         O8szHQrlkUtXjepSw1e5RGy+vOxeVpGmbxcU1h8pD3Hpwi6ClvwvAYzMUacnW+2lzr7w
         1hGroLlSAj7uaVUkgl+oJfWXBJLtBI+vHVZ5bIQ5dvKnHHw7trTJrAahFD6V2nR15mGG
         PeWHsa5S7IAWP/5yZbx1caydZuPFNU7f7sLYlLVe4ps8rGxDhlF/CMIWSkV5yq8TjVXo
         QVGg==
X-Gm-Message-State: ANhLgQ1DsPIeNVeR6w9pl5/Abem8Y0uvVVWqlEsyN4JJpYQxARWA5mrf
        5us4+FIY+yfkqmRPZCyQWkpIu/US
X-Google-Smtp-Source: ADFU+vshVDPkf7SmSY3NZWRuIGe4XEiEAmaSVFIKHvwfsIohNCyLaQZ0vMEbVAooJUSHvhQKM7yh0g==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr5758986wmb.126.1584455630733;
        Tue, 17 Mar 2020 07:33:50 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id t81sm3937420wmb.15.2020.03.17.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 07:33:50 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] MAINTAINERS: remove Stefan Popa's email
Date:   Tue, 17 Mar 2020 16:33:36 +0200
Message-Id: <20200317143336.6098-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The email is no longer active. This change removes Stefan's email from the
MAINTAINERS list and replaces it with Michael Hennerich's.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 MAINTAINERS | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fa40c3eb72a..72e8960c4f4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -552,7 +552,7 @@ F:	drivers/input/misc/adxl34x.c
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
@@ -900,7 +900,7 @@ F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
 ANALOG DEVICES INC AD5686 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -908,7 +908,7 @@ F:	drivers/iio/dac/ad5686*
 F:	drivers/iio/dac/ad5696*
 
 ANALOG DEVICES INC AD5758 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -924,7 +924,7 @@ F:	drivers/iio/adc/ad7091r5.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
 
 ANALOG DEVICES INC AD7124 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -948,7 +948,7 @@ F:	drivers/iio/adc/ad7292.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 
 ANALOG DEVICES INC AD7606 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -957,7 +957,7 @@ F:	drivers/iio/adc/ad7606.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 
 ANALOG DEVICES INC AD7768-1 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -1018,7 +1018,7 @@ F:	drivers/hwmon/adm1177.c
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 
 ANALOG DEVICES INC ADP5061 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -1078,7 +1078,6 @@ F:	drivers/dma/dma-axi-dmac.c
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-- 
2.20.1

