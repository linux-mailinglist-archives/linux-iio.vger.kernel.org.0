Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD65EB7F1
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 04:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiI0C5g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 22:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiI0C4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 22:56:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187761D77
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:22 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ml1so5509007qvb.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fjKONfzvcToa9xf9WhGIF//2C04Wz2LbGFmYzFaCWaU=;
        b=CiSyL6z+RZVWIzvY/ORpUNqpSkwc5IPLOV1dufLUixrZPX7+PbcYiRajuaQEz2R/cj
         lwg8wVZyfz4a3LLzLPTaS3UNOwfM1seVXVGmibCrXtUY2B1eX7xgEjBPpFbqhbker0eZ
         vtInG6pQu0HM7ZOnjUeWhv68JfdgeXzNYjiCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fjKONfzvcToa9xf9WhGIF//2C04Wz2LbGFmYzFaCWaU=;
        b=NYX4OzzdfBeJtvNq7BEDlfrQm7/iD0dVzoLVcPAjWt0fXEccemvC4YIQVWTInI4bgJ
         dxakbtQ5fe5ld39k+xOsHNs0skakfHjrYFxwLSqeDKEdKTZbcDwDlvKi5iLivtPq9q2f
         bmVXz8eEtZORT1ES+HEmk9UldoS1pE3q5l2vwdtSl1tTpOWZ/9JU9wya/2NYIRtUCGW+
         VKYqsfyEbyFtiurMWkv3S1Y17DcQNs+qYrpPBISzun8ZBSzxtwSyagL1BJ+QMooBaBxL
         VvL9bb5439ImjUb48fCKPPxSsEkq2JOwjpGSeaGPiHxinslBp4JVI9OK0Ls/9zdX13Vo
         iQdg==
X-Gm-Message-State: ACrzQf0RluUuGxg6xj53+UDABfmRMUAe88WVf0CJjzapU6fVk7lM3URz
        Q+coaYwQUym2HCowBK6b16Hjjw==
X-Google-Smtp-Source: AMsMyM72trpFIIWMM6yZqeQ1QFTb3xFCWBDapjcF0kwjXqlIJHMlYir+1g3Ne0O+Le9/E4U75mAQ4A==
X-Received: by 2002:a05:6214:f6d:b0:4ac:a1ca:9de4 with SMTP id iy13-20020a0562140f6d00b004aca1ca9de4mr19621704qvb.62.1664247081189;
        Mon, 26 Sep 2022 19:51:21 -0700 (PDT)
Received: from roguebox.lan ([164.92.70.235])
        by smtp.gmail.com with ESMTPSA id y5-20020a37f605000000b006bb0f9b89cfsm199620qkj.87.2022.09.26.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:51:20 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org, gupt21@gmail.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v5 2/5] iio: adc: stx104: fix future recursive dependencies
Date:   Mon, 26 Sep 2022 19:50:47 -0700
Message-Id: <20220927025050.13316-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927025050.13316-1-matt.ranostay@konsulko.com>
References: <20220927025050.13316-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When using 'imply IIO' for other configurations which have 'select GPIOLIB'
the following recursive dependency is detected for STX1040

Switch from 'select GPIOLIB' to 'depends on GPIOLIB' to avoid this per
recommendation in kconfig-language.rst

drivers/gpio/Kconfig:14:error: recursive dependency detected!
drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by STX104
drivers/iio/adc/Kconfig:20:   symbol STX104 depends on IIO
drivers/iio/Kconfig:6:  symbol IIO is implied by HID_MCP2221
drivers/hid/Kconfig:1227:       symbol HID_MCP2221 depends on GPIOLIB

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/adc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930891e0..929dd9493479 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1024,9 +1024,8 @@ config STMPE_ADC
 
 config STX104
 	tristate "Apex Embedded Systems STX104 driver"
-	depends on PC104 && X86
+	depends on PC104 && X86 && GPIOLIB
 	select ISA_BUS_API
-	select GPIOLIB
 	help
 	  Say yes here to build support for the Apex Embedded Systems STX104
 	  integrated analog PC/104 card.
-- 
2.37.2

