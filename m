Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C590C468673
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377242AbhLDRL2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355675AbhLDRL2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF275C061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A76160ED3
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEEEC341C0;
        Sat,  4 Dec 2021 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637681;
        bh=XUbXJguzKyjW8aQppDzpiVEJUn/7N2GODJVJ2g9Mbno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGuDF+Yf8tVcT7ZT5uYr0RxsYdCkbRfAG0xB3Qt+o+LZ/HsKzxKl1Auo2p3nLl0GY
         PUlxrAlSERFPleFWM3MTiF3MTke0f8UwcfigbcBrCaKQa16K26WWPjWbZ8EWbbYQYr
         KQsb98mRBGz+wmkEbvYAiCUlmPCtU1Hss3Y4UHFtG+44l6vNRJF6/E8ezIgN7mYefd
         wQU1iCWXLLnOMrbVcxNbBqfCIfil65ZI6m0Xg4ROjEglr52RO5sAIf75Fu3fVSHDFG
         nhgLsPIb6lpIZ+CP58xyJcr2xfCcZynFBRwQT/XuoDtct4+HFJKsw2GvOvoII6ZLfy
         AxYcrFPaIaArw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 12/12] iio:adc/dac:Kconfig: Update to drop OF dependencies.
Date:   Sat,  4 Dec 2021 17:12:37 +0000
Message-Id: <20211204171237.2769210-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
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

