Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48B35222C3
	for <lists+linux-iio@lfdr.de>; Tue, 10 May 2022 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348256AbiEJRfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 May 2022 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348286AbiEJRfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2022 13:35:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D74BB99
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2022 10:31:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a76so13702254qkg.12
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2022 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9mQuOu+XRqgTZ4Bko2jc/5sm39T7MgSYxzJZaxMktN4=;
        b=ouHq2900hAOqDb+MXC1Fi7kl65Nx7yzrT9leVeMpabMrEqIQJWRkXdzGPa9MrhzZgp
         MTLF3CPiLjipxh/vVbeL5xkVPQCT1qZRGYAFiarTN5o5K7c8eAaXOsyGUQeKel5mBG7e
         c82JVNYGzSLTDvLW7PUMqOpg75RvXzORYlLztyEqY1yOmqhVts0Bu49tRizRmCYj2dEb
         cvXGCtBTqLVqVsfJQWuMpbdk+mIAMXnaO8xGo5WXvHqXToSAYgnWB0i2Ry8fTuMSgJDD
         WjqURJvLHoasbzFwlwXHeVbCW6ziiR+UCdVNmPnHjtBdhCWZ2eHx/vGVFPaw59YQwX/G
         XJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9mQuOu+XRqgTZ4Bko2jc/5sm39T7MgSYxzJZaxMktN4=;
        b=yw5RbDFrNAtIJZRXza79VKvHzoD6N9fEmE6y+xX+LsqS8/M44rIZkqxHOLAeFm6liz
         AMyBX1p8D7cchF0ZqtfcEXbPmb8b0fTsSNBndmcRuif4Puj37Eyc/xUVmqGe5VupyM0k
         3esEibaKVLvLOr+lcty20TZJ3Dcqo0yp+iLHWwVCrmp0lOuD3Z9ZPZgjgDHZsRJXDUcS
         FK0ePQ1uVl5VwRi0UwkkNj1cGu0mHambslghiD05rVN7dHH0ALl+J259nhzY/zd4GMRT
         Rd0G40vcjq6saV5XS3cnRzZP03BjIq1fshXaYUrd4pKcWR3aZtjvAX5O6TAX5YMiFAzH
         ClwQ==
X-Gm-Message-State: AOAM530vYt7OiKL3raM1dWgUyVj3pwCc/Cr4CPnB5HPheX8nHfmr3NoL
        C6dUuvLeB78X350XX1l8B7YZ+MUUyNk2ag==
X-Google-Smtp-Source: ABdhPJzMHkLzUtYji99bKeJH7gAfpbWZHkXB9Hva/GQb4rz2ewUZZpaYjPU3mC+JFj3OZ+aSg7rn+A==
X-Received: by 2002:a37:55c2:0:b0:479:8293:d7d0 with SMTP id j185-20020a3755c2000000b004798293d7d0mr16425698qkb.182.1652203885821;
        Tue, 10 May 2022 10:31:25 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:25 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] iio: dac: cio-dac: Utilize iomap interface
Date:   Tue, 10 May 2022 13:31:00 -0400
Message-Id: <c973ce9a326131552caf762381edf8e90be43cc5.1652201921.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1652201921.git.william.gray@linaro.org>
References: <cover.1652201921.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver doesn't need to access I/O ports directly via inb()/outb()
and friends. This patch abstracts such access by calling ioport_map()
to enable the use of more typical ioread8()/iowrite8() I/O memory
accessor calls.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/dac/cio-dac.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 95813569f394..8080984dcb03 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
  */
 struct cio_dac_iio {
 	int chan_out_states[CIO_DAC_NUM_CHAN];
-	unsigned int base;
+	void __iomem *base;
 };
 
 static int cio_dac_read_raw(struct iio_dev *indio_dev,
@@ -71,7 +71,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	priv->chan_out_states[chan->channel] = val;
-	outw(val, priv->base + chan_addr_offset);
+	iowrite16(val, priv->base + chan_addr_offset);
 
 	return 0;
 }
@@ -105,18 +105,20 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	priv = iio_priv(indio_dev);
+	priv->base = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
+	if (!priv->base)
+		return -ENOMEM;
+
 	indio_dev->info = &cio_dac_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = cio_dac_channels;
 	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
 	indio_dev->name = dev_name(dev);
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
-
 	/* initialize DAC outputs to 0V */
 	for (i = 0; i < 32; i += 2)
-		outw(0, base[id] + i);
+		iowrite16(0, priv->base + i);
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.35.3

