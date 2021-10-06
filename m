Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34274242D5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Oct 2021 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhJFQkt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Oct 2021 12:40:49 -0400
Received: from box.trvn.ru ([194.87.146.52]:36313 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhJFQkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Oct 2021 12:40:49 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Oct 2021 12:40:48 EDT
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8F488428D6;
        Wed,  6 Oct 2021 21:31:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1633537877; bh=RKX+UxOJaofOnl3psZgoVRHnWMDW48UJ8sAbexJ0pD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX0JPIMOsJgD/Dv2gqdB1D9egd7Qoip59izkv7zt2lM8Ha/ZMHDWLH0IayCGOwkSp
         v+aB7YnbqkK+k2Q2RqNYhigJZt6UVvlQJUaNG2mam5ezI2DpRiLhXXrCTMs/XQ/tHl
         gJkAH6Pbe7lxNxDER6bdFcMN77vv06nciqyuHPCs01cukFuvNMrOxGRhAyYcP9P080
         3ebGG4jkz0z99k/aKmLlm0n8N+Wa9aJ8y+GhmBz9wOb/FpwG8oh92faFJ3JqqgncUe
         kihNnpJfpSqs3fubDziuzuBV1nUOt4xUv3DGwx2QwuQag2daw8/MOj0u2gNhQ8gsR8
         vU/uHwMbESonA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, stephan@gerhold.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 4/4] iio: light: ltr501: Add of_device_id table
Date:   Wed,  6 Oct 2021 21:30:58 +0500
Message-Id: <20211006163058.145842-4-nikita@trvn.ru>
In-Reply-To: <20211006163058.145842-1-nikita@trvn.ru>
References: <20211006163058.145842-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add of_device_id table so the driver can be used on DT platforms without
relying on i2c_device_id fallback. (So DT schema validation is possible)

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/iio/light/ltr501.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 57851c8ef1c6..7e51aaac0bf8 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1609,9 +1609,18 @@ static const struct i2c_device_id ltr501_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
 
+static const struct of_device_id ltr501_of_match[] = {
+	{ .compatible = "liteon,ltr501", },
+	{ .compatible = "liteon,ltr559", },
+	{ .compatible = "liteon,ltr301", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltr501_of_match);
+
 static struct i2c_driver ltr501_driver = {
 	.driver = {
 		.name   = LTR501_DRV_NAME,
+		.of_match_table = ltr501_of_match,
 		.pm	= &ltr501_pm_ops,
 		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 	},
-- 
2.30.2

