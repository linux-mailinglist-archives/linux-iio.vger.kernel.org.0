Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985EF468C36
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhLERAR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbhLERAR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5913C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1B3FB80EC5
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44ADC00446;
        Sun,  5 Dec 2021 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723407;
        bh=A58OpQQQTOAgyuxUZXSjhFgts8pYVp0LoBt+rrUXSuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J89Hf0b09/37DHXhfR+se4KYaOagSPI9P6Gk+QaRpqLnpl2mM2usWdN+j7lV+1dox
         vMo6/UKWIiPampIjaakv5ANwa6l/faXtfxIN3pdHOIe0rR6wIMlZejmLEvbweVVf8L
         m9MvGOxFrlz3xc9k60LSiDkVvA8h/eGT4CfVTid6Bw3K2YvylkOiKNqYNBgAw+XlOj
         jzvouBWFX45ve3LI5+q6IQuURh7GRNsFP/Mm9oymediI44mUF/EUy0AXfFR9153piD
         iM9FZhJE13PLXbIfaK9HCktPFHAWUa38QevinItP79Zd7kkMsX7VRbG0ZwzJLjmQtU
         9aubNROOOBeMg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Chris Coffey <cmc@babblebit.net>
Subject: [PATCH v3 05/12] iio:pot:mcp41010: Switch to generic firmware properties.
Date:   Sun,  5 Dec 2021 17:01:33 +0000
Message-Id: <20211205170140.2783914-6-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In this case it was only of_device_get_match_data() + header update.
This enables use of other firmware types with no other changes, such
as ACPI via the PRP0001 route.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Coffey <cmc@babblebit.net>
---
 drivers/iio/potentiometer/mcp41010.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp41010.c b/drivers/iio/potentiometer/mcp41010.c
index 79ccac6d4be0..30a4594d4e11 100644
--- a/drivers/iio/potentiometer/mcp41010.c
+++ b/drivers/iio/potentiometer/mcp41010.c
@@ -21,9 +21,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 #define MCP41010_MAX_WIPERS	2
@@ -146,7 +146,7 @@ static int mcp41010_probe(struct spi_device *spi)
 	data = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 	data->spi = spi;
-	data->cfg = of_device_get_match_data(&spi->dev);
+	data->cfg = device_get_match_data(&spi->dev);
 	if (!data->cfg)
 		data->cfg = &mcp41010_cfg[spi_get_device_id(spi)->driver_data];
 
-- 
2.34.1

