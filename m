Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB0382030
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhEPR1f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEPR1f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53EA461177;
        Sun, 16 May 2021 17:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185980;
        bh=MkBShWInBBKLb1CiyuTUAIh7WKX0gA0vh4BO9OKZ9gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JkY2EbZAdC7BJ9UlXvKMDTFdWgbIAy4T9hJeEaHcqGpzUt3Pahp/o3WKdazlr+2cj
         NKbMypoW+IsEnzRn1rBSQyJzZjmukeL4ujgyVTdcGjdg0WhekM3i+orv5EN329Dd6Q
         RmmOrEbJGDz8M06fB/XDzisQod6Cb5sKhbPcs6fjRy22ICfzz7fIDigeVu2+GnbrSC
         Tt6wBTLY1aHARmTxh14O6HsoAqXtlRi638+JeuZuuTm82MP6IYi7l2On6YTDdbHi8a
         nygxxQ8Be8EPpuZ2RwDIqsAV4OaBYvxwqejWvGZlCzSN1uahN9Ue5KvvVXmLN2uaH5
         chuVnzYqlX3Ug==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 2/8] iio: adc: max11100: Use devm_ functions for rest of probe()
Date:   Sun, 16 May 2021 18:25:14 +0100
Message-Id: <20210516172520.1398835-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

By using devm_add_action_or_reset() to manage the regulator disable,
it becomes simple to use managed functions for all of remove.
This simplifies error handling and allows us to drop the remove()
function entirely.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/iio/adc/max11100.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 69d607fa17aa..9951f6a6a4b9 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -102,6 +102,11 @@ static const struct iio_info max11100_info = {
 	.read_raw = max11100_read_raw,
 };
 
+static void max11100_regulator_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int max11100_probe(struct spi_device *spi)
 {
 	int ret;
@@ -131,27 +136,12 @@ static int max11100_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, max11100_regulator_disable,
+				state->vref_reg);
 	if (ret)
-		goto disable_regulator;
-
-	return 0;
-
-disable_regulator:
-	regulator_disable(state->vref_reg);
-
-	return ret;
-}
-
-static int max11100_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct max11100_state *state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(state->vref_reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id max11100_ids[] = {
@@ -166,7 +156,6 @@ static struct spi_driver max11100_driver = {
 		.of_match_table = max11100_ids,
 	},
 	.probe		= max11100_probe,
-	.remove		= max11100_remove,
 };
 
 module_spi_driver(max11100_driver);
-- 
2.31.1

