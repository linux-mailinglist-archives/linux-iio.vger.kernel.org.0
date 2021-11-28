Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39198460960
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhK1T2T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbhK1T0Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:26:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B30C0613FA
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 11:22:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7438D61047
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985EFC53FC7;
        Sun, 28 Nov 2021 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127325;
        bh=XUbXJguzKyjW8aQppDzpiVEJUn/7N2GODJVJ2g9Mbno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmgouVMV3kM7UZH5tPVJ38op249XTO4NhVO1AHtgs7YRAueaCp/+osutLADUI8ez/
         /2DMaw8ghwLLhCRUeFGsorNz4zywwl0K+aMLd5AGH5KMQrmXijRWPsIjWyOq2X8GMr
         PwN1/0QQQv7hbcrHGFu5MjEjOXJsR8nx0l+VT4iveZnHBnZHf3AsFSwLQGG33H8I+U
         mV/vnQvVMBvdiT7QXU8cog0FSKbzWud7vf5Xv6TzypjA4ZVMw+4mnhg7YC34NuUgB6
         2g7YMARSrRJFvK742wpmTUv8BiU2WEsCCk94KmC4EtojQaGWuPaIn6MiMpjK1glpdC
         buQLnO+JhWNSQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/12] iio:adc/dac:Kconfig: Update to drop OF dependencies.
Date:   Sun, 28 Nov 2021 19:26:35 +0000
Message-Id: <20211128192635.2724359-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We could probably drop a lot more of these, but for now this removes
unnecessary restrictions on stand alone ADC devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 4 ++--
 drivers/iio/dac/Kconfig | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9b0b99bc826c..c7de4632f24a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1146,7 +1146,7 @@ config TI_ADS7950
 
 config TI_ADS8344
 	tristate "Texas Instruments ADS8344"
-	depends on SPI && OF
+	depends on SPI
 	help
 	  If you say yes here you get support for Texas Instruments ADS8344
 	  ADC chips
@@ -1156,7 +1156,7 @@ config TI_ADS8344
 
 config TI_ADS8688
 	tristate "Texas Instruments ADS8688"
-	depends on SPI && OF
+	depends on SPI
 	help
 	  If you say yes here you get support for Texas Instruments ADS8684 and
 	  and ADS8688 ADC chips
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 75e1f2b48638..ba6649a2d040 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -329,7 +329,6 @@ config MAX517
 config MAX5821
 	tristate "Maxim MAX5821 DAC driver"
 	depends on I2C
-	depends on OF
 	help
 	  Say yes here to build support for Maxim MAX5821
 	  10 bits DAC.
-- 
2.34.1

