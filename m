Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886A224115
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGQQ5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgGQQ4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1BC0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so18247231wmf.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plt40HpdQkbHvQwXOxo5if7eJzPHGlolB+ggPBJMqPY=;
        b=J3pv3dEpGgwSpIhA8EtE+KYVOjgrt0YdOk9dunGzbdUkQbLEYxYoGZMXA/1+5Dsf6J
         LAnr+hUnpEB7AeU8OqxnfF26WEuXm4lWDRmDeoL36lGILsADFMR1IdvzckJY3SYYlldF
         mibf5B2agpVngiFAxjk+7s7m4/KAg4HlPudlDNLfPq99WLoEt87yffqOweAlSfAS4Lur
         2FXPzVUcW/EXE7IGVR8sfgl4V7kWJPQDfJfT/YdlIKr2Hc744g9gwCSIJhZqkogyavXZ
         E2HzHQB5DFaRVAv3VkczC5FPPAZ0IFvDeBTdDxXn+EMXhCNSx8CwhmhfIpZvHttn0fuI
         m+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plt40HpdQkbHvQwXOxo5if7eJzPHGlolB+ggPBJMqPY=;
        b=feE00SJy78s6CXl9hUMcvrfjDX0D99j1aCzI8rx6bG6gAlN0nz141N3YnAXB8+7JeS
         iRSGvSJKu1CIDA1Tzdgb0T1rRPG04pdkVeAfHEDxjavUtjgAQXxPPNWqnZDOi3vH73o4
         lWhV2F0oZmdQT8HDhxZ5tV3WUZa9Mm0xNVnEN4m9xDvGMG83sf2A61ZDyD9NfHjp4yXa
         qPUAg5zMRbfz2hp4qBcrzSLSL0nkU6ixqxWuzFNhS9RPfw1t3olKWbXMEzkW6VfyRsPb
         9b8Q6fXGDK16HKnW80tqIRmm45YIfXLQ71dCEx9C4lRFjcwChX81Dq6UtZ2U9L8E5NhQ
         XTSw==
X-Gm-Message-State: AOAM532KgT4Rg8FxrUurx4zvpLC3O7uw8EigidNu1l+9XzngWeYUyvsA
        ENlandVsaT/VJG8Qo2fIoWAM0A==
X-Google-Smtp-Source: ABdhPJyP6B7HseRg5kS7ZkPAzot7yMGjQw7JXKLcdP34P/c6n3iGcQGWvUN176x3H3wgk3Zx9jh1xQ==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr9735654wmd.157.1595004974509;
        Fri, 17 Jul 2020 09:56:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 14/30] iio: adc: at91-sama5d2_adc: Struct kerneldoc titles need to start with 'struct '
Date:   Fri, 17 Jul 2020 17:55:22 +0100
Message-Id: <20200717165538.3275050-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/at91-sama5d2_adc.c:360: warning: cannot understand function prototype: 'struct at91_adc_dma '
 drivers/iio/adc/at91-sama5d2_adc.c:379: warning: cannot understand function prototype: 'struct at91_adc_touch '

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 9abbbdcc74200..c7fe749419b28 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -347,7 +347,7 @@ struct at91_adc_trigger {
 };
 
 /**
- * at91_adc_dma - at91-sama5d2 dma information struct
+ * struct at91_adc_dma - at91-sama5d2 dma information struct
  * @dma_chan:		the dma channel acquired
  * @rx_buf:		dma coherent allocated area
  * @rx_dma_buf:		dma handler for the buffer
@@ -369,7 +369,7 @@ struct at91_adc_dma {
 };
 
 /**
- * at91_adc_touch - at91-sama5d2 touchscreen information struct
+ * struct at91_adc_touch - at91-sama5d2 touchscreen information struct
  * @sample_period_val:		the value for periodic trigger interval
  * @touching:			is the pen touching the screen or not
  * @x_pos:			temporary placeholder for pressure computation
-- 
2.25.1

