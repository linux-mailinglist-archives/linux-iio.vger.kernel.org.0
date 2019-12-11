Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A462B11BF58
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 22:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLKVi1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 16:38:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34719 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 16:38:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so20278lfc.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2019 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+GJDsZn7GdT3QKoU6jRs2z6sFLUbUBmp9X/WhTZ+V4=;
        b=oPSrqKo+2GSBGR1G17CVAerVDDjTXe/ye/8of8naHxHWP5Qty/ljb7JQ27PYvmcwBo
         8fwqPuA/Suk5DsJmk4z8tFuKq9lY11nttXCfN1VUYX5PagHUv8a1x8W3DZocqnuOZ63p
         iM73ksgLrXAiMJv26w8z/C2F75wtu63eVRNXXOrp2AC2U2HQrqGkiYlY1xXIJUN/70LA
         JGSa7dfXLHJwTQuiWKlWpFVgzfyRbywSFA3cHK5VOei/X/VoFKTG6MlLM//25EB6ktkt
         wS92HTOkr3rkYnzd/m6zWg1fqUlliw9ga39x1D1pnj4IxQ2lW3++lawJuLk3JXv6X248
         Fhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+GJDsZn7GdT3QKoU6jRs2z6sFLUbUBmp9X/WhTZ+V4=;
        b=DM1sp9zwWHDXhEn+DIG9BAj8A0ctbgedSIb7zn+7iDCidzKxpMKV3UwBOwxK+VLeZj
         3LaNcimEpde97nVZq6FU4PpAX/Dt6FrnSiaZ5zcFFiC3uHs8fZ33ImoLbfQuT6CsP4MQ
         KDbhHR/JX8dyA0v5G/775P61x/2J/kpgme9d9EZXQz80fRjTp8/FebH65AGe/uPmueEM
         lv4rZaLsouhbWhwCmsz0WTiVd2L8asgAInMbkmevV9Sxv4K4YVK+ri1KWxIlQYLot/3Q
         5jZYFfBdJKSbXkFxybZALHviAoXLVPWwUn5PHZTtVwRP1vJGnjd5GbOa5fosFsm3jBLO
         MmZQ==
X-Gm-Message-State: APjAAAVht/xX29Zbc0rCoRVsoXf2z+DuRYZq5GBXdY53zTI8L7xupj5J
        ZCoDYi0XX40OSauPMFljyBjgqg==
X-Google-Smtp-Source: APXvYqy2AlkFND/4qNpWLvpqxMn1gFEW39r/0U4HO4wgQuS2f5wWr7AaBnzoo64lh9O59owU/C5EjA==
X-Received: by 2002:a05:6512:41b:: with SMTP id u27mr3751238lfk.164.1576100305008;
        Wed, 11 Dec 2019 13:38:25 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id e8sm2074199ljb.45.2019.12.11.13.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:38:23 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 1/4] iio: accel: bma180: Add dev helper variable
Date:   Wed, 11 Dec 2019 22:38:16 +0100
Message-Id: <20191211213819.14024-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Having a shorthand "dev" instead of &client->dev everywhere
makes the code easier to read (more compact).

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bma180.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 1574e4604a4f..518efbe4eaf6 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -712,12 +712,13 @@ static const struct iio_trigger_ops bma180_trigger_ops = {
 static int bma180_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct bma180_data *data;
 	struct iio_dev *indio_dev;
 	enum chip_ids chip;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -725,12 +726,12 @@ static int bma180_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	if (client->dev.of_node)
-		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
+		chip = (enum chip_ids)of_device_get_match_data(dev);
 	else
 		chip = id->driver_data;
 	data->part_info = &bma180_part_info[chip];
 
-	ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
+	ret = iio_read_mount_matrix(dev, "mount-matrix",
 				&data->orientation);
 	if (ret)
 		return ret;
@@ -740,7 +741,7 @@ static int bma180_probe(struct i2c_client *client,
 		goto err_chip_disable;
 
 	mutex_init(&data->mutex);
-	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->channels = data->part_info->channels;
 	indio_dev->num_channels = data->part_info->num_channels;
 	indio_dev->name = id->name;
@@ -755,15 +756,15 @@ static int bma180_probe(struct i2c_client *client,
 			goto err_chip_disable;
 		}
 
-		ret = devm_request_irq(&client->dev, client->irq,
+		ret = devm_request_irq(dev, client->irq,
 			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
 			"bma180_event", data->trig);
 		if (ret) {
-			dev_err(&client->dev, "unable to request IRQ\n");
+			dev_err(dev, "unable to request IRQ\n");
 			goto err_trigger_free;
 		}
 
-		data->trig->dev.parent = &client->dev;
+		data->trig->dev.parent = dev;
 		data->trig->ops = &bma180_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 		indio_dev->trig = iio_trigger_get(data->trig);
@@ -776,13 +777,13 @@ static int bma180_probe(struct i2c_client *client,
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 			bma180_trigger_handler, NULL);
 	if (ret < 0) {
-		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
+		dev_err(dev, "unable to setup iio triggered buffer\n");
 		goto err_trigger_unregister;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
+		dev_err(dev, "unable to register iio device\n");
 		goto err_buffer_cleanup;
 	}
 
-- 
2.21.0

