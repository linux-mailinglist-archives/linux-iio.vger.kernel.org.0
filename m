Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065C2C7485
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgK1Vta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732958AbgK1TEr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:04:47 -0500
Received: from localhost.localdomain (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE55246C5;
        Sat, 28 Nov 2020 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606580742;
        bh=0GDVpEMQIXzGb1fn+CwDaBS9YHK7cVYXGJZu8f49WHo=;
        h=From:To:Cc:Subject:Date:From;
        b=prOJcy2xWDkFPXopRVWX67QeuhpT8eneXjTwKyYRGIs4fMU+ECc+9pAdPWqVLO7nV
         OmFHSWaGBOrl+dFa9hCrTF5x8/5xGJPNPV+TjWjJtRF+4D4wDABmUzbOZmqEL1DIlP
         MOULK/H033aBLtgF1oqCx3hxv0GTPJgPPKEQ3qiI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio:health:afe4403: Fix naming of tx supply to match dt-bindings
Date:   Sat, 28 Nov 2020 16:23:33 +0000
Message-Id: <20201128162334.382837-1-jic23@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These have always been different and the name tx_sup-supply that
would work for the driver is rather nonsensical so let us go with
what was described in the dt-binding doc.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: eec96d1e2d318 ("iio: health: Add driver for the TI AFE4403 heart monitor")
---
 drivers/iio/health/afe4403.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 38734e4ce360..94bbfc065bed 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -486,7 +486,7 @@ static int afe4403_probe(struct spi_device *spi)
 		}
 	}
 
-	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
+	afe->regulator = devm_regulator_get(afe->dev, "tx");
 	if (IS_ERR(afe->regulator)) {
 		dev_err(afe->dev, "Unable to get regulator\n");
 		return PTR_ERR(afe->regulator);
-- 
2.29.2

