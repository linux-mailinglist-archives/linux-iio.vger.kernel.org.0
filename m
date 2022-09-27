Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36605EB7EF
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 04:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiI0C5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 22:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiI0C4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 22:56:02 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225A5D0D4
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j10so5310691qtv.4
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F3pNm/W20l8PIjrNMCG3DOuHAeukeerlsNhlNvML72U=;
        b=CiZ//Cu5xLWspJ2bFEXuqKVIB8JUaQWbggVtFioxRfQh2n3jBDstrbCV8J9oCYcj3z
         6N0RsQ9Xrb2iVkhAg57BnmDIQsOsJsN8SGZdV2qOhXBWDbzHY9QLrdpac11OqsI01L16
         BJc6gvtafdRx8K05SH1EXRcwdtMFEzi1VHHJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F3pNm/W20l8PIjrNMCG3DOuHAeukeerlsNhlNvML72U=;
        b=CtD9+mETbdFRS84996fN3cYy/2czycUtkvHpGicdOnUP2AlYq7FC5OqhQlHoq+lxBX
         2cmulbwgrh+m5pu30op8NHZ+nce+QuE2zwlgPk8mlnkqHWg+iJpoc9VCQ+Rqi+dJLnUh
         /1dFB/EeC5lM5AQTygrTLTPy1W9+BxOlE2034UJlmgt35ROweRYH6XZ+sBOgIDriYDlA
         EO5k2c1mdLU++ZXsRsn66c7ndfHHqDs9J4YWGdFOjkwaWzsm6TzFBcFsSzesJZfRLtjO
         R4UBXJHkATpz2F4BOYM7k5CCQLv1cCg9Yopg4IdPVdsgICt/m9B50CNfTju4wFsDAWoU
         WChg==
X-Gm-Message-State: ACrzQf3Dt0GG2ZXfOCuWMuRxdPyLNHg4c6/IsAore7QY6X2+BGx2VMGC
        Rgr34CxeP245BVVW9Q8podfFdA==
X-Google-Smtp-Source: AMsMyM60D8LyEwc7BF2TtRbUsvPreL3iK2mFzmlHJHf8/oK7qhwx79o8gDPnWnBsMZBpYy46T4+1Pw==
X-Received: by 2002:ac8:5f08:0:b0:35c:cbe5:4b83 with SMTP id x8-20020ac85f08000000b0035ccbe54b83mr20731629qta.218.1664247078800;
        Mon, 26 Sep 2022 19:51:18 -0700 (PDT)
Received: from roguebox.lan ([164.92.70.235])
        by smtp.gmail.com with ESMTPSA id y5-20020a37f605000000b006bb0f9b89cfsm199620qkj.87.2022.09.26.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:51:18 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org, gupt21@gmail.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v5 1/5] i2c: muxes: ltc4306: fix future recursive dependencies
Date:   Mon, 26 Sep 2022 19:50:46 -0700
Message-Id: <20220927025050.13316-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927025050.13316-1-matt.ranostay@konsulko.com>
References: <20220927025050.13316-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When using 'imply IIO' for other configurations which have 'select GPIOLIB'
the following recursive dependency is detected for I2C_MUX_LTC4306

Switch from 'select GPIOLIB' to 'depends on GPIOLIB' to avoid this per
recommendation in kconfig-language.rst

drivers/gpio/Kconfig:14:error: recursive dependency detected!
drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by I2C_MUX_LTC4306
drivers/i2c/muxes/Kconfig:47:   symbol I2C_MUX_LTC4306 depends on I2C_MUX
drivers/i2c/Kconfig:62: symbol I2C_MUX is selected by MPU3050_I2C
drivers/iio/gyro/Kconfig:127:   symbol MPU3050_I2C depends on IIO
drivers/iio/Kconfig:6:  symbol IIO is implied by HID_MCP2221
drivers/hid/Kconfig:1227:       symbol HID_MCP2221 depends on GPIOLIB

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/i2c/muxes/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 1708b1a82da2..8642ea8e0a3d 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -46,7 +46,7 @@ config I2C_MUX_GPMUX
 
 config I2C_MUX_LTC4306
 	tristate "LTC LTC4306/5 I2C multiplexer"
-	select GPIOLIB
+	depends on GPIOLIB
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Analog Devices
-- 
2.37.2

