Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08733A766
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhCNSRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233389AbhCNSRe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 309C364EC6;
        Sun, 14 Mar 2021 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745853;
        bh=RGIaw3TXN/jNvvb2wJvRV1c6Q1goNDD036QmSMsTVnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikXa+YfKCRTUL/eCuJCz8USD6EsdWTT62QQJ8rlq0HvXjOBHWbLMXBGq5gYCx+fTe
         4ovRsQvkPiRREYKhcu92hNhGLOBA/R36bMQcJD7o5iHUVvgd+QjQ8vByskwUVeO3bV
         Uhh+RoSM39oXMHn7coMflCIopRkOxMIpP5NnnOxg0JIONzhT15KQMzYcVWjBP3nPCP
         BXf6tVB4sa3SBKYyTuQm+yk7kQfFnTyXHGc2CZ4jfrCNWiIhItTmHQq7e+7V9UYvKX
         Kun9b9XNPXCmmfdvcPiwWHQZYDVA846Bt9GjHZamu5QD+ao09tduyRzRrG32aGMo+1
         3mlbByo/UEiKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 05/24] staging:iio:cdc:ad7150: Drop platform data support
Date:   Sun, 14 Mar 2021 18:14:52 +0000
Message-Id: <20210314181511.531414-6-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There are no mainline board files using this driver so lets drop
the platform_data support in favour of devicetree and similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-6-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 0dce1b8ce76d..7ad9105e6b46 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -570,20 +570,6 @@ static int ad7150_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	if (client->dev.platform_data) {
-		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
-						client->dev.platform_data,
-						NULL,
-						&ad7150_event_handler,
-						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						"ad7150_irq2",
-						indio_dev);
-		if (ret)
-			return ret;
-	}
-
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret)
 		return ret;
-- 
2.30.2

