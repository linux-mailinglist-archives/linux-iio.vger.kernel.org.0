Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811F236D3DC
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbhD1IXN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 04:23:13 -0400
Received: from first.geanix.com ([116.203.34.67]:54930 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237049AbhD1IXN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 04:23:13 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 65CE946624B;
        Wed, 28 Apr 2021 08:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619598146; bh=hOssXQoLqitONDdAWpjsYfSVVVTOP07FajOYAZWHqFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fsWcUK+m4N4DZ4m/XI9yVqs92xfHiiWNlSgDezEFZeNu5MHWpDg3LRCQCTLwxS7A9
         HG65NA9YE+iS3JbLSXeAsTvSqrEnMH8+tvyay+yJ9yUHcC+LMsfaHrwRo6Xnz8hDnK
         tktBzeTJu0Nw37N83RehoQP7ZYzmOk7r++83FdNxEUheBBTYKOr7jHoYUXGRg+x7sq
         CPHWq/zM59dzVeeCqmXG/zMG/2DwjLIACMUmRYfArOvZxqlnT1G550Jnz3qHiQgLDh
         gmt2kMk50pU4YL0eWbnH3GHLA08d70pNGg1XRvoHpak50B5/xyIrz910lolVgJr2qT
         YBjQ4s8emvAJw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [RFC PATCH 4/4] iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads
Date:   Wed, 28 Apr 2021 10:22:03 +0200
Message-Id: <20210428082203.3587022-4-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210428082203.3587022-1-sean@geanix.com>
References: <20210428082203.3587022-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When flushing the hw fifo there is a bug in the I2C that prevents burst
reads of more than one sample pair.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
This series depends on "iio: accel: add support for
FXLS8962AF/FXLS8964AF accelerometers"

 drivers/iio/accel/fxls8962af-core.c | 27 +++++++++++++++++++++++----
 drivers/iio/accel/fxls8962af-i2c.c  |  2 +-
 drivers/iio/accel/fxls8962af-spi.c  |  2 +-
 drivers/iio/accel/fxls8962af.h      |  2 +-
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 2bd5c6d76b63..fad9e756d313 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -149,6 +149,7 @@ struct fxls8962af_data {
 		__le16 channels[3];
 		s64 ts __aligned(8);
 	} scan;
+	bool i2c_device;
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
 };
@@ -684,11 +685,27 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int sample_length = 3 * 2;
-	int ret;
+	int ret, i;
 	int total_length = samples * sample_length;
 
-	ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
-			      total_length);
+	if (data->i2c_device) {
+		/* Due to errata bug:
+		 * E3: FIFO burst read operation error using I2C interface
+		 * We have to avoid burst reads on I2C..
+		 */
+		for (i = 0; i < samples; i++) {
+			ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
+					      &buffer[i * sample_length],
+					      sample_length);
+			if (ret < 0)
+				goto out;
+		}
+	} else {
+		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
+				      total_length);
+	}
+
+ out:
 	if (ret < 0)
 		dev_err(dev, "Error transferring data from fifo: %d\n", ret);
 
@@ -899,7 +916,8 @@ static int fxls8962af_irq_setup(struct iio_dev *indio_dev, int irq)
 	return ret;
 }
 
-int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
+int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq,
+			  bool i2c_device)
 {
 	struct fxls8962af_data *data;
 	struct iio_dev *indio_dev;
@@ -913,6 +931,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->i2c_device = i2c_device;
 
 	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
 	if (ret)
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index cba12160a714..03bd7ef285d0 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -24,7 +24,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return fxls8962af_core_probe(&client->dev, regmap, client->irq);
+	return fxls8962af_core_probe(&client->dev, regmap, client->irq, true);
 }
 
 static const struct i2c_device_id fxls8962af_id[] = {
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
index cb971b76d135..77186220f6dc 100644
--- a/drivers/iio/accel/fxls8962af-spi.c
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -24,7 +24,7 @@ static int fxls8962af_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return fxls8962af_core_probe(&spi->dev, regmap, spi->irq);
+	return fxls8962af_core_probe(&spi->dev, regmap, spi->irq, false);
 }
 
 static const struct of_device_id fxls8962af_spi_of_match[] = {
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index b67572c3ef06..e428163926b7 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -13,7 +13,7 @@ enum {
 	fxls8964af,
 };
 
-int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
+int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq, bool i2c_device);
 int fxls8962af_core_remove(struct device *dev);
 
 extern const struct dev_pm_ops fxls8962af_pm_ops;
-- 
2.31.0

