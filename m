Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E576A45AE00
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhKWVKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239859AbhKWVKU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C45460FE7;
        Tue, 23 Nov 2021 21:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701632;
        bh=sKWuV7l7ZDhygRgQvyQCxcVkH5PmDnsa9hQNtgcUDNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbIwBnOlbeMYWmgABeCwHd+nq6bF749OKJD7jo/3viedll0H2aFVDdOmT1ddqIOlu
         TQAP+AmK6kiCCGxx6sBoztOdF6PKmOhbQSXCX3FwVCy6/1ZMprNc9o51xStGsqpyUP
         DADfQjUuh1mApjovWmEq08pjfqQSLkRhqtVEELqKCX1lWEPo7WuwW9ZJ56X7RtHlZI
         I7RYEVtrOzfqEbHPLV8Wyar/cv3M7OEAdl5WQ/99huQkfJq/tKNalbK9KQDnE6k+M2
         6fG8rm9kRadzPvLbl8C4vcYEJTl1xh9KO82QDlRZGhnvQfEvC+mSEQjLVkmlH0Myy+
         GjYLWg1uFt6dw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 41/49] iio:pressure:bmp280: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:11 +0000
Message-Id: <20211123211019.2271440-42-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280-core.c | 6 ++----
 drivers/iio/pressure/bmp280-i2c.c  | 2 +-
 drivers/iio/pressure/bmp280-spi.c  | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6b7da40f99c8..0653e1ea88da 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1138,8 +1138,7 @@ int bmp280_common_probe(struct device *dev,
 }
 EXPORT_SYMBOL(bmp280_common_probe);
 
-#ifdef CONFIG_PM
-static int bmp280_runtime_suspend(struct device *dev)
+static __maybe_unused int bmp280_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
@@ -1147,7 +1146,7 @@ static int bmp280_runtime_suspend(struct device *dev)
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
-static int bmp280_runtime_resume(struct device *dev)
+static __maybe_unused int bmp280_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
@@ -1159,7 +1158,6 @@ static int bmp280_runtime_resume(struct device *dev)
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 	return data->chip_info->chip_config(data);
 }
-#endif /* CONFIG_PM */
 
 const struct dev_pm_ops bmp280_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 8b03ea15c0d0..35045bd92846 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -58,7 +58,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 	.driver = {
 		.name	= "bmp280",
 		.of_match_table = bmp280_of_i2c_match,
-		.pm = &bmp280_dev_pm_ops,
+		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
 	.probe		= bmp280_i2c_probe,
 	.id_table	= bmp280_i2c_id,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 625b86878ad8..41f6cc56d229 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -109,7 +109,7 @@ static struct spi_driver bmp280_spi_driver = {
 	.driver = {
 		.name = "bmp280",
 		.of_match_table = bmp280_of_spi_match,
-		.pm = &bmp280_dev_pm_ops,
+		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
 	.id_table = bmp280_spi_id,
 	.probe = bmp280_spi_probe,
-- 
2.34.0

