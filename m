Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2D600168
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJPQe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJPQez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8AE14D05
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CBE60C09
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B40EC433D7;
        Sun, 16 Oct 2022 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938091;
        bh=HUDrCW7jIhXFbVqZxlXHpRiMWGS9+NR8nrbePvEgxC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O40LomfMN4rxRRtu60aeOVNTlHK9yK+aLL8efggYuGXqgiQ55tUP60CPec7uUfWWj
         mmCUUMGRGdi2MZBL4+eQyN2xJtBy3biEFZKpr1Se5jRZepB3eeiONikRVhH+Qv3X8r
         UNV+su98avZKRRvqfMyPRVyw4gxNQnqJLLZfXTSpn9ghFaXauqdigc06STfKbQkQy0
         3oEyRCIdYdJS8hAliiuaxhGAveyrS+mNNbIWkJP3F1ObaktZ2G1i5Cq575pzN+5pCs
         iPalUgX+BC3cxLfx268FYEBfu6PVhVgZSbuy40KFSYvor8jKQWyGhANHg+O2jehcwy
         22UpCZgwTJQfw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/14] iio: pressure: ms5611: Switch to fully devm_ managed registration.
Date:   Sun, 16 Oct 2022 17:34:09 +0100
Message-Id: <20221016163409.320197-15-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016163409.320197-1-jic23@kernel.org>
References: <20221016163409.320197-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

All the remaining calls in probe() have devm_ equivalents so
switching to those allows the remove() callbacks to be deleted.
No functional change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611.h      |  1 -
 drivers/iio/pressure/ms5611_core.c | 17 +++--------------
 drivers/iio/pressure/ms5611_i2c.c  |  6 ------
 drivers/iio/pressure/ms5611_spi.c  |  6 ------
 4 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index 816e83befd23..f7066315fde3 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -58,6 +58,5 @@ struct ms5611_state {
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 		 const char *name, int type);
-void ms5611_remove(struct iio_dev *indio_dev);
 
 #endif /* _MS5611_H */
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index b95ee6034548..75a98470dcea 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -431,34 +431,23 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					 ms5611_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+		return ret;
 	}
 
 	return 0;
-
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
 }
 EXPORT_SYMBOL_NS(ms5611_probe, IIO_MS5611);
 
-void ms5611_remove(struct iio_dev *indio_dev)
-{
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-EXPORT_SYMBOL_NS(ms5611_remove, IIO_MS5611);
-
 MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("MS5611 core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index b681a4183909..2bab509a8c1d 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -105,11 +105,6 @@ static int ms5611_i2c_probe(struct i2c_client *client,
 	return ms5611_probe(indio_dev, &client->dev, id->name, id->driver_data);
 }
 
-static void ms5611_i2c_remove(struct i2c_client *client)
-{
-	ms5611_remove(i2c_get_clientdata(client));
-}
-
 static const struct of_device_id ms5611_i2c_matches[] = {
 	{ .compatible = "meas,ms5611" },
 	{ .compatible = "meas,ms5607" },
@@ -131,7 +126,6 @@ static struct i2c_driver ms5611_driver = {
 	},
 	.id_table = ms5611_id,
 	.probe = ms5611_i2c_probe,
-	.remove = ms5611_i2c_remove,
 };
 module_i2c_driver(ms5611_driver);
 
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 432e912096f4..f0f5b46d8f9c 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -107,11 +107,6 @@ static int ms5611_spi_probe(struct spi_device *spi)
 			    spi_get_device_id(spi)->driver_data);
 }
 
-static void ms5611_spi_remove(struct spi_device *spi)
-{
-	ms5611_remove(spi_get_drvdata(spi));
-}
-
 static const struct of_device_id ms5611_spi_matches[] = {
 	{ .compatible = "meas,ms5611" },
 	{ .compatible = "meas,ms5607" },
@@ -133,7 +128,6 @@ static struct spi_driver ms5611_driver = {
 	},
 	.id_table = ms5611_id,
 	.probe = ms5611_spi_probe,
-	.remove = ms5611_spi_remove,
 };
 module_spi_driver(ms5611_driver);
 
-- 
2.37.2

