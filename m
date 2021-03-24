Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A934807A
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCXS2e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhCXS2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 14:28:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F234C0613DE
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 11:28:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e7so28692701edu.10
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyLMXRzyKHAlRrBe/1Z1s41GJMv95BdW39ViogQEvKA=;
        b=Xzn9ElipPR5gW7jhTJ17RnslH0rsAe0v8ShnY9MYT3QTFuLChXnKGl2bFh1+iIDo56
         MVWv9vgpxQDeoA0LDoefsDGyjkBGpyXewlXKtM/vGWN3xYQ5EtQjO6UAin1eDS+OA9sL
         wwsyx3fqlmHQeHdaeLPElrx5PRNL5YZAI+mrQebrUkgVR3vBB5xxmSFrAfS89GMytz+Q
         XvP86Pvu/vnNo7Olb01mEr89ranbxzFAqgXOlIG+DN7zx0mdMc5gq5BLIPBPeuSTKyWF
         347GoGyFJcpdWOAgXnXQv4TygsNoOVJaOR5mvYYvpRPeynQDD70u3+OF22fo0B8rSJ0t
         GdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyLMXRzyKHAlRrBe/1Z1s41GJMv95BdW39ViogQEvKA=;
        b=GH3cL6Bx7zuuC9kpXCCaLx9myYlAuwNAFToAP1QhG//ipMi7mtSg4UBRcUAWdiP8Do
         m2X4543krJvfY5B38Bs9i3mq8KUClyWie2KaiQ4qLdYKVLSteVSGEtFKsNrUlG7/7bWJ
         qYiIAPLUrBU/SOodIo9+H/tZ05XL8eJf0eJx6DTD4vKVhlQTK3M2sG4iGylopQZvxcDm
         EX3mT1bfqTcRoeaKiYGy7F039t2uyEF8bwCP187a/inglN4rE21zr/JT42StMiwGFXbr
         ffTmkZc5Ey+k0+5N7z/UvRSFWhjQVqy7iKJtv7j/p6chsSGZy4n3KgoAnAKwQVitQvmB
         RIAA==
X-Gm-Message-State: AOAM533JV1xc2/ie3PG2QhVXGRd3UDMPbruM/HaOHWyFCjP7Riqezuk/
        mlz2j4wpmhz1M9wW5xGfp3+46DRrn7sySD5G
X-Google-Smtp-Source: ABdhPJzkHaW0PaibM6iQXvD3mxDgi89Ugij3uUU/ZS4rFFh4W+voPoBMEzvj722CYtR0bTmLorKa8w==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr4999991edu.57.1616610497853;
        Wed, 24 Mar 2021 11:28:17 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.90])
        by smtp.gmail.com with ESMTPSA id r4sm1288360ejd.125.2021.03.24.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:28:17 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iio: adc: Kconfig: make AD9467 depend on ADI_AXI_ADC symbol
Date:   Wed, 24 Mar 2021 20:27:46 +0200
Message-Id: <20210324182746.9337-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because a dependency on HAS_IOMEM and OF was added for the ADI AXI ADC
driver, this makes the AD9467 driver have some build/dependency issues
when OF is disabled (typically on ACPI archs like x86).

This is because the selection of the AD9467 enforces the ADI_AXI_ADC symbol
which is blocked by the OF (and potentially HAS_IOMEM) being disabled.

To fix this, we make the AD9467 driver depend on the ADI_AXI_ADC symbol.
The AD9467 driver cannot operate on it's own. It requires the ADI AXI ADC
driver to stream data (or some similar IIO interface).

So, the fix here is to make the AD9467 symbol depend on the ADI_AXI_ADC
symbol. At some point this could become it's own subgroup of high-speed
ADCs.

Fixes: be24c65e9fa24 ("iio: adc: adi-axi-adc: add proper Kconfig dependencies")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---

Apologies for this being too late.
I made the patch but forgot it in a local tree.

Related to discussion:
   https://lkml.org/lkml/2021/3/18/1007

 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e0667c4b3c08..dda0f1e37ec1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -249,7 +249,7 @@ config AD799X
 config AD9467
 	tristate "Analog Devices AD9467 High Speed ADC driver"
 	depends on SPI
-	select ADI_AXI_ADC
+	depends on ADI_AXI_ADC
 	help
 	  Say yes here to build support for Analog Devices:
 	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
-- 
2.30.2

