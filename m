Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64732240E8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGQQ4Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGQQ4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F4C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so7563527wmc.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyqL66bhaPo6pUJYftE+BouP+W8ifTKxcOtS6pP8tIA=;
        b=bgDHQZAm1Y7zGqco6LHcPFImygLo/eaYHhgO4zR4uqMXJXBH/9/wUXvkgURQEgEcPf
         vRFq3fHY/XmeaUh/vIQRfq1bADE7GHYiWQH+exNS6KTPZddIkQaaSOTeEE1bi7W2D1mY
         VxSPWjFBYAHsExqDJeVWJD9VpQGNiY/CcKTKKEjWbytzE9T9GORFrOXAmRDKAUscog6q
         vSo5MTT6YhP/nJK4HnudqudhwFB9qB4kRLz1I2/7IrgKaw858ntypQ4Hps0xQ8t6V+Ef
         ySaRfcZdo60TpEiSnm9Cf26IdXLDFZ1NvK3lpAsBAF9Jmw26IZJc/czIvlbIyh/c7XP1
         xz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyqL66bhaPo6pUJYftE+BouP+W8ifTKxcOtS6pP8tIA=;
        b=lVT7ChefAerqi9Z3uyYl35oRe9X8i3cnGq56uaYFL2CSyR0AX9+fw6cunkxnzR01XZ
         UdLcseCbLDQ0pVDS7QMYSePA2cQ4m3n9SFvyMjQvjbBZp7niWZoRswpPA8bVruKGeJZ3
         kRmQstt3wN+iQ0MZyHm4cIaizzcH+bAxYrxeCOpb3iEhM+EEHWCBxxmcvSGg1YuoBTpP
         lRGf7iWO/BdCkDDsD4/TOxJEurMLI6KvgSSlqdhxOOdwdioB0htmlsPpVwhDUrHLpwYI
         9bfdhAUX7gxRPEGyPlmng9QIc2dI2XE+I/desbxmaY/xlVnJLK0oLSywSwz6JwUfHiWy
         3KpA==
X-Gm-Message-State: AOAM531uiwDp8xvErsODJ06lovO3NH6o+Y4ppBm5Ar+wBO2MNkt5ls3n
        s398OsgLzV/rm20Oa0JIExgGkA==
X-Google-Smtp-Source: ABdhPJzkOkfui+os8Qw2Xmd5y3cEYFZKIpsg38EFiEnyePI47o5q7jh1WVLfiLgGxOTQOSGbdLUnzQ==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr9952906wma.24.1595004973487;
        Fri, 17 Jul 2020 09:56:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 13/30] iio: adc: at91_adc: Fix 'bad line' warning
Date:   Fri, 17 Jul 2020 17:55:21 +0100
Message-Id: <20200717165538.3275050-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All lines should start with ' *'.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/at91_adc.c:160: warning: bad line:                         (Interruptions registers mostly)

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0368b6dc6d60a..c5ea75cd88fa8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -157,7 +157,7 @@
  * struct at91_adc_reg_desc - Various informations relative to registers
  * @channel_base:	Base offset for the channel data registers
  * @drdy_mask:		Mask of the DRDY field in the relevant registers
-			(Interruptions registers mostly)
+ *			(Interruptions registers mostly)
  * @status_register:	Offset of the Interrupt Status Register
  * @trigger_register:	Offset of the Trigger setup register
  * @mr_prescal_mask:	Mask of the PRESCAL field in the adc MR register
-- 
2.25.1

