Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831CE5B5F5B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Sep 2022 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiILRc1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Sep 2022 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiILRcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2022 13:32:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203C23BD2
        for <linux-iio@vger.kernel.org>; Mon, 12 Sep 2022 10:32:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g2so3723585qkk.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Sep 2022 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wUfUODMZKfU/KRMGIPcJ/EprHfUIajE7CfzqJDq54Sc=;
        b=Jygg5xjgKZ4satdBYz9QswEVF4wOOXfrBrmX9tITPCD68+PNZqohDyy0n7TrNSD+xE
         iDoEObH5ijvyFZxt/7e3RDoYbZmCTzAVXJJxAo3GL3PK311zUMbFSpQGkO7Pi3WnnhVz
         0lar0zUEUaIKC5PXPBavY39f0QmO3TwthhVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wUfUODMZKfU/KRMGIPcJ/EprHfUIajE7CfzqJDq54Sc=;
        b=1rSXhvkZLmoO0crnyuI6Ct531MT6DGK9kQ5bmycFUpCjtgl2DIOgAC+DLM8zUK0nX/
         DG8YaVStpD1lvMDA/s5m5UusKFQ9GlFEtSXG+MG+BIyAYwKSsxCQ6KqDiNmQwXHChEmj
         u+H74XVerU61at8/j8YdkeoyrxpsTBP9hr/cJY9mDHUbjHeIr9SpGmiFN5Grihah4KCp
         KoYo9190EArIn9pKstcMlBORzEn7OdXWkp695C8ZD6+AYV14TZQrfz3ML8echZCkWWxV
         wcl1oM8gQiE4/RhQTOzhbVnQhpMa07hAgkV4wdo0Y2wqFhh8x1FDtJtz1Ze9PEJ1JLVu
         37HA==
X-Gm-Message-State: ACgBeo1SD4/z4gxatuD6GWciP4K51Q3URqXydFLatM9LuEOSWRixlhCK
        TKWomEhnYvjgYV021ABRK5gi8w==
X-Google-Smtp-Source: AA6agR514xTiZj839LW7iE31Mh7Sy1LuhS2wosEcaZ59xb4Smzbd8lfGrBN+/yE/C8CfV2FBUh2thQ==
X-Received: by 2002:a05:620a:2456:b0:6ce:3cfe:dd62 with SMTP id h22-20020a05620a245600b006ce3cfedd62mr3864659qkn.380.1663003943583;
        Mon, 12 Sep 2022 10:32:23 -0700 (PDT)
Received: from localhost.localdomain ([159.65.38.31])
        by smtp.gmail.com with ESMTPSA id h63-20020a376c42000000b006b8d1914504sm8289394qkc.22.2022.09.12.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:32:23 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     gupt21@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 3/5] iio: dac: fix future recursive dependencies
Date:   Mon, 12 Sep 2022 10:32:00 -0700
Message-Id: <20220912173202.16723-4-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220912173202.16723-1-matt.ranostay@konsulko.com>
References: <20220912173202.16723-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When using 'imply IIO' for other configurations which have 'select GPIOLIB'
the following recursive dependency detected happens for AD5592R and AD5593R.

Switch from 'select GPIOLIB' to 'depends on GPIOLIB' to avoid this per
recommendation in kconfig-language.rst

drivers/gpio/Kconfig:14:error: recursive dependency detected!
drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by AD5592R
drivers/iio/dac/Kconfig:93:     symbol AD5592R depends on IIO
drivers/iio/Kconfig:6:  symbol IIO is implied by HID_MCP2221
drivers/hid/Kconfig:1227:       symbol HID_MCP2221 depends on GPIOLIB

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/dac/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 80521bd28d0f..b93003e80b70 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -92,8 +92,7 @@ config AD5592R_BASE
 
 config AD5592R
 	tristate "Analog Devices AD5592R ADC/DAC driver"
-	depends on SPI_MASTER
-	select GPIOLIB
+	depends on SPI_MASTER && GPIOLIB
 	select AD5592R_BASE
 	help
 	  Say yes here to build support for Analog Devices AD5592R
@@ -104,8 +103,7 @@ config AD5592R
 
 config AD5593R
 	tristate "Analog Devices AD5593R ADC/DAC driver"
-	depends on I2C
-	select GPIOLIB
+	depends on I2C && GPIOLIB
 	select AD5592R_BASE
 	help
 	  Say yes here to build support for Analog Devices AD5593R
-- 
2.37.2

