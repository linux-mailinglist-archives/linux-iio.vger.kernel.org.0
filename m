Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3441927C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhI0Kuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 06:50:35 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:57594 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhI0Kuf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 06:50:35 -0400
Received: from [217.146.132.69] (helo=yoda.kc.loc)
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1mUoBl-0005MA-Sa; Mon, 27 Sep 2021 12:48:50 +0200
From:   Florian Boor <florian.boor@kernelconcepts.de>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Florian Boor <florian.boor@kernelconcepts.de>
Subject: [PATCH v4 1/2] iio: adc: ad799x: Implement selecting external reference voltage input on AD7991, AD7995 and AD7999.
Date:   Mon, 27 Sep 2021 12:48:40 +0200
Message-Id: <20210927104841.2256295-1-florian.boor@kernelconcepts.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of the AD7991_REF_SEL bit and support using the external
reference voltage if 'vref-supply' is present. Use VCC voltage supply
as reference if no extra reference is supplied.

Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
---

Changes in v4:
- Check devm_regulator_get_optional() return value and
  handle values other from -ENODEV separately.
- Update documentation description

Changes in v3:
- Do not create dummy reference regulator, check for vref presence where needed.
- Use VCC as reference if no extra reference voltage is provided
- Add interrupt information to documentation

Changes in v2:
- Check if a provided external vref regulator is provided.
- Drop unused setting
- Add ad79xx documentation (second patch)

 drivers/iio/adc/ad799x.c | 68 ++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 18bf8386d50a..b67b3076d76e 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -299,7 +299,11 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(st->vref);
+		if (st->vref)
+			ret = regulator_get_voltage(st->vref);
+		else
+			ret = regulator_get_voltage(st->reg);
+		
 		if (ret < 0)
 			return ret;
 		*val = ret / 1000;
@@ -770,6 +774,7 @@ static int ad799x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	int ret;
+	int extra_config = 0;
 	struct ad799x_state *st;
 	struct iio_dev *indio_dev;
 	const struct ad799x_chip_info *chip_info =
@@ -797,14 +802,36 @@ static int ad799x_probe(struct i2c_client *client,
 	ret = regulator_enable(st->reg);
 	if (ret)
 		return ret;
-	st->vref = devm_regulator_get(&client->dev, "vref");
+		
+	/* check if an external reference is supplied */
+	st->vref = devm_regulator_get_optional(&client->dev, "vref");
+
 	if (IS_ERR(st->vref)) {
-		ret = PTR_ERR(st->vref);
-		goto error_disable_reg;
+		if (PTR_ERR(st->vref) == -ENODEV) {
+			st->vref = NULL;
+			dev_info(&client->dev, "Using VCC reference voltage\n");
+		} else {
+			ret = PTR_ERR(st->vref);
+			goto error_disable_reg;
+		}
+	}
+		
+	if (st->vref) {
+		/* 
+		 * Use external reference voltage if supported by hardware.
+		 * This is optional if voltage / regulator present, use VCC otherwise.
+		 */
+		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
+			dev_info(&client->dev, "Using external reference voltage\n");
+			extra_config |= AD7991_REF_SEL;
+			ret = regulator_enable(st->vref);
+			if (ret)
+				goto error_disable_reg;
+		} else {
+			st->vref = NULL;
+			dev_warn(&client->dev, "Supplied reference not supported\n");
+		}
 	}
-	ret = regulator_enable(st->vref);
-	if (ret)
-		goto error_disable_reg;
 
 	st->client = client;
 
@@ -815,7 +842,7 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
-	ret = ad799x_update_config(st, st->chip_config->default_config);
+	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
 		goto error_disable_vref;
 
@@ -845,7 +872,8 @@ static int ad799x_probe(struct i2c_client *client,
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_vref:
-	regulator_disable(st->vref);
+	if (st->vref) 
+		regulator_disable(st->vref);
 error_disable_reg:
 	regulator_disable(st->reg);
 
@@ -860,7 +888,8 @@ static int ad799x_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(st->vref);
+	if (st->vref) 
+		regulator_disable(st->vref);
 	regulator_disable(st->reg);
 	kfree(st->rx_buf);
 
@@ -872,7 +901,8 @@ static int __maybe_unused ad799x_suspend(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	regulator_disable(st->vref);
+	if (st->vref) 
+		regulator_disable(st->vref);
 	regulator_disable(st->reg);
 
 	return 0;
@@ -889,17 +919,21 @@ static int __maybe_unused ad799x_resume(struct device *dev)
 		dev_err(dev, "Unable to enable vcc regulator\n");
 		return ret;
 	}
-	ret = regulator_enable(st->vref);
-	if (ret) {
-		regulator_disable(st->reg);
-		dev_err(dev, "Unable to enable vref regulator\n");
-		return ret;
+
+	if (st->vref) {
+		ret = regulator_enable(st->vref);
+		if (ret) {
+			regulator_disable(st->reg);
+			dev_err(dev, "Unable to enable vref regulator\n");
+			return ret;
+		}
 	}
 
 	/* resync config */
 	ret = ad799x_update_config(st, st->config);
 	if (ret) {
-		regulator_disable(st->vref);
+		if (st->vref) 
+			regulator_disable(st->vref);
 		regulator_disable(st->reg);
 		return ret;
 	}
-- 
2.30.2

