Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7766140F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 08:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAHHsB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 02:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHHsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 02:48:01 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E7E23
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 23:47:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jl4so6232622plb.8
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 23:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLIuSrH7T7GNTZZeCz121fx1nKLe2TVzPHSMX86JIjM=;
        b=lg9HrZgOtyuix6GXSvWITrX65mxIaFHQcqBAgwKueRWFCKunkGLmbmbzmSb95BBH7n
         CzW1VdRZ5TYMjrJQSWxrQ0xowbEw5HFBbqfnaQ9Urg7b9Zi4P/eSvOd4G6BIMs4/hdmv
         qRPdnMQveLNk97F/T3ULNCB6zjsS6BqpmGDCHsHKN1Lpv4HzofLjG1+uzKOCxicj9YzY
         oOY9tjINhpIFNErEjeg5BH3oj3SNM5teE4ho5RUFYzCUQWpNZv0vzBGlLkBLc2e1eZfx
         U0Nz4vtGXQtYEYDT/VJP1eSv4kDlG8Jmb5HJ5ejPJVPLrij8rg0QLzhPhQNj+b9pp7cL
         jg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLIuSrH7T7GNTZZeCz121fx1nKLe2TVzPHSMX86JIjM=;
        b=VOMhN/Hg+RCq3wWbE9LadqXCB+jsAOOcO7ZX865bjKzqcXF75B6QWY9HRvoejjmeZ5
         ce9XSZpi/IWXWbSdd61PPV23YXknwXqrz5QSfaA7q4QDGvJ48MnbS1OR/BBymF0G94HW
         NsfzI/0p7JZaXJLZ5ThOJkqdt+C77bKhZDCYGiyUgOewrfwiib6jwJ1OwtMeoZZlktAD
         NJe+fWnl5PuKE2YXwXqQP2VdqftCaBqGniNJOAM5ZFgyHtoxBDKbFxrEL7uuh4aMGdQk
         emWTZSOdKSR5TCDuIUro/yoANksIIo+aMKqSrieT/NzFf88qtTHN53HVYGMbVqFXTzXa
         Pb8A==
X-Gm-Message-State: AFqh2kqHj9l/8SHLPDvdD9n8/D8VIeLBAp4WB6FN+KBWQz2jf4UWVVXn
        7wHFjkbRVo0+f5QWMGkBHig=
X-Google-Smtp-Source: AMrXdXspqLkUPK8EJWTtEdyO3o0Unam+fCbASFF8id95tnqvxbTGqvoCb9kTiacYcJj9ZYEMOfs5Gw==
X-Received: by 2002:a05:6a20:a5a7:b0:b5:c352:1fc8 with SMTP id bc39-20020a056a20a5a700b000b5c3521fc8mr857291pzb.15.1673164078260;
        Sat, 07 Jan 2023 23:47:58 -0800 (PST)
Received: from morpheus.lan (106-69-189-37.dyn.iinet.net.au. [106.69.189.37])
        by smtp.googlemail.com with ESMTPSA id h5-20020a170902680500b00189348ab156sm3672212plk.283.2023.01.07.23.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 23:47:57 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 1/4] counter: Sort the Kconfig entries alphabetically
Date:   Sun,  8 Jan 2023 07:47:47 +0000
Message-Id: <20230108074750.443705-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sort the Kconfig menu alphabetically to make it easier
to read as the list grows larger.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/counter/Kconfig | 88 ++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d388bf26f4dc..508d857808e9 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -29,6 +29,26 @@ config 104_QUAD_8
 	  array module parameter. The interrupt line numbers for the devices may
 	  be configured via the irq array module parameter.
 
+config FTM_QUADDEC
+	tristate "Flex Timer Module Quadrature decoder driver"
+	depends on HAS_IOMEM && OF
+	help
+	  Select this option to enable the Flex Timer Quadrature decoder
+	  driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ftm-quaddec.
+
+config INTEL_QEP
+	tristate "Intel Quadrature Encoder Peripheral driver"
+	depends on PCI
+	help
+	  Select this option to enable the Intel Quadrature Encoder Peripheral
+	  driver.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-qep.
+
 config INTERRUPT_CNT
 	tristate "Interrupt counter driver"
 	depends on GPIOLIB
@@ -39,15 +59,16 @@ config INTERRUPT_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called interrupt-cnt.
 
-config STM32_TIMER_CNT
-	tristate "STM32 Timer encoder counter driver"
-	depends on MFD_STM32_TIMERS || COMPILE_TEST
+config MICROCHIP_TCB_CAPTURE
+	tristate "Microchip Timer Counter Capture driver"
+	depends on HAS_IOMEM && OF
+	select REGMAP_MMIO
 	help
-	  Select this option to enable STM32 Timer quadrature encoder
-	  and counter driver.
+	  Select this option to enable the Microchip Timer Counter Block
+	  capture driver.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called stm32-timer-cnt.
+	  module will be called microchip-tcb-capture.
 
 config STM32_LPTIMER_CNT
 	tristate "STM32 LP Timer encoder counter driver"
@@ -59,47 +80,15 @@ config STM32_LPTIMER_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32-lptimer-cnt.
 
-config TI_EQEP
-	tristate "TI eQEP counter driver"
-	depends on (SOC_AM33XX || COMPILE_TEST)
-	select REGMAP_MMIO
-	help
-	  Select this option to enable the Texas Instruments Enhanced Quadrature
-	  Encoder Pulse (eQEP) counter driver.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called ti-eqep.
-
-config FTM_QUADDEC
-	tristate "Flex Timer Module Quadrature decoder driver"
-	depends on HAS_IOMEM && OF
-	help
-	  Select this option to enable the Flex Timer Quadrature decoder
-	  driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ftm-quaddec.
-
-config MICROCHIP_TCB_CAPTURE
-	tristate "Microchip Timer Counter Capture driver"
-	depends on HAS_IOMEM && OF
-	select REGMAP_MMIO
+config STM32_TIMER_CNT
+	tristate "STM32 Timer encoder counter driver"
+	depends on MFD_STM32_TIMERS || COMPILE_TEST
 	help
-	  Select this option to enable the Microchip Timer Counter Block
-	  capture driver.
+	  Select this option to enable STM32 Timer quadrature encoder
+	  and counter driver.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called microchip-tcb-capture.
-
-config INTEL_QEP
-	tristate "Intel Quadrature Encoder Peripheral driver"
-	depends on PCI
-	help
-	  Select this option to enable the Intel Quadrature Encoder Peripheral
-	  driver.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-qep.
+	  module will be called stm32-timer-cnt.
 
 config TI_ECAP_CAPTURE
 	tristate "TI eCAP capture driver"
@@ -116,4 +105,15 @@ config TI_ECAP_CAPTURE
 	  To compile this driver as a module, choose M here: the module
 	  will be called ti-ecap-capture.
 
+config TI_EQEP
+	tristate "TI eQEP counter driver"
+	depends on (SOC_AM33XX || COMPILE_TEST)
+	select REGMAP_MMIO
+	help
+	  Select this option to enable the Texas Instruments Enhanced Quadrature
+	  Encoder Pulse (eQEP) counter driver.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ti-eqep.
+
 endif # COUNTER
-- 
2.39.0

