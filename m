Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907CB595238
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 07:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiHPFxJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 01:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHPFwj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 01:52:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05B26AD4
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 15:56:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a15so6586165qko.4
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ac3JvCwAmKuPc3kldTLNS+yBvHZ3Bhe8L1hxK+NbPB0=;
        b=EOCISOZ/yFup2jyMuBNguNp9UguY0b5klvmRasgAPspUx0XeDol7zNXd2FHAp/a2E9
         E+E/1Yv7HCBsSCbL6kxzhSE8j0/UJoNQ29K/dNK+sRWUUsHSw6uPsIH5nl8JMlandbYg
         XeHm5bjDHpCfH9Vdqsey5mNysJaDKWffheKd9zOcowlh10rX05VuDIiitCb5Yf2CA9uf
         ErfrCjAm6fVzqMbulXFlb0GpQYs8OrZcwNQizGwtOvUYY3PhXvFRhuS3i5Sjls7xJJrg
         DwZDoBrwrC95sjNOqyMFtMXqehVTBExgtV2lWy074ZKe7Ko3n13dZIqKpOND6TRtgSdT
         dVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ac3JvCwAmKuPc3kldTLNS+yBvHZ3Bhe8L1hxK+NbPB0=;
        b=3ob5jpK8DtJM7sTz2vjD+0ET9RIwULDKSbQUKNiB2YX9DctaYnMwmXbMPX+JoXLNNJ
         hzr/cFRLilffYy+sMUtUXQ4Rb2LYHqNJof89Fi2qR3fK3nHXFnuGdJDmjLCE16UlBBei
         JoVie6RmxpsH+wnpa0RjJg3K/gWDIG6bSGSmWjRPr2Opbit6yi6pS4uJBId+ugAUBiJ2
         OkGAQaAJszDHtj2zPWpoAGfNNkK5GER1Q7Pt4Z8gOGWIH/SgGvLKPr1kd6lJk5P6W3bY
         FiAvXQVchUlYoJyTdmj3FHMmyf4eowV1PVnDKRde5BXqJRm+TBSL/a9HlUN3OabUsFEs
         a/cA==
X-Gm-Message-State: ACgBeo0HZSczsTkZER+SyMazJ6xmCP8Bq43aFImlj3o2sBhx6J6kkFDy
        fLJnMC5VCOWERVZZicaXGV4h3A==
X-Google-Smtp-Source: AA6agR4OgMytBVHSK2x+UfrqWfy6TQ0pQFCJYAId3wdKwXnNjgcxkBn0lXdyDAanMZ2UFmVoEsND9Q==
X-Received: by 2002:a05:620a:8014:b0:6b9:2866:c7f0 with SMTP id ee20-20020a05620a801400b006b92866c7f0mr12971491qkb.23.1660604193224;
        Mon, 15 Aug 2022 15:56:33 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a244b00b006b633dc839esm10497057qkn.66.2022.08.15.15.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:56:32 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frede@cmslaser.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] iio: stx104: Move to addac subdirectory
Date:   Mon, 15 Aug 2022 18:29:21 -0400
Message-Id: <20220815222921.138945-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The stx104 driver supports both ADC and DAC functionality.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS                         |  2 +-
 drivers/iio/adc/Kconfig             | 16 ----------------
 drivers/iio/adc/Makefile            |  1 -
 drivers/iio/addac/Kconfig           | 16 ++++++++++++++++
 drivers/iio/addac/Makefile          |  1 +
 drivers/iio/{adc => addac}/stx104.c |  0
 6 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/iio/{adc => addac}/stx104.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8b6544ba27c..f4ef070f474a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1382,7 +1382,7 @@ APEX EMBEDDED SYSTEMS STX104 IIO DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	drivers/iio/adc/stx104.c
+F:	drivers/iio/addac/stx104.c
 
 APM DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5a3e8d9ae26c..e3c2881ed23a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1037,22 +1037,6 @@ config STMPE_ADC
 	  Say yes here to build support for ST Microelectronics STMPE
 	  built-in ADC block (stmpe811).
 
-config STX104
-	tristate "Apex Embedded Systems STX104 driver"
-	depends on PC104 && X86
-	select ISA_BUS_API
-	select GPIOLIB
-	help
-	  Say yes here to build support for the Apex Embedded Systems STX104
-	  integrated analog PC/104 card.
-
-	  This driver supports the 16 channels of single-ended (8 channels of
-	  differential) analog inputs, 2 channels of analog output, 4 digital
-	  inputs, and 4 digital outputs provided by the STX104.
-
-	  The base port addresses for the devices may be configured via the base
-	  array module parameter.
-
 config SUN4I_GPADC
 	tristate "Support for the Allwinner SoCs GPADC"
 	depends on IIO
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index c1a861a978ad..ab084094263b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -89,7 +89,6 @@ obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
-obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 138492362f20..fcf6d2269bfc 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -17,4 +17,20 @@ config AD74413R
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad74413r.
 
+config STX104
+	tristate "Apex Embedded Systems STX104 driver"
+	depends on PC104 && X86
+	select ISA_BUS_API
+	select GPIOLIB
+	help
+	  Say yes here to build support for the Apex Embedded Systems STX104
+	  integrated analog PC/104 card.
+
+	  This driver supports the 16 channels of single-ended (8 channels of
+	  differential) analog inputs, 2 channels of analog output, 4 digital
+	  inputs, and 4 digital outputs provided by the STX104.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
 endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
index cfd4bbe64ad3..17de20ef0d8e 100644
--- a/drivers/iio/addac/Makefile
+++ b/drivers/iio/addac/Makefile
@@ -5,3 +5,4 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD74413R) += ad74413r.o
+obj-$(CONFIG_STX104) += stx104.o
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/addac/stx104.c
similarity index 100%
rename from drivers/iio/adc/stx104.c
rename to drivers/iio/addac/stx104.c

base-commit: b82217e73b5aa6db8453ad91b929ca2366e47184
-- 
2.37.2

