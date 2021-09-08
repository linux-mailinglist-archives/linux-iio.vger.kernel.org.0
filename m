Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4496403C72
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbhIHP0y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 11:26:54 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:40656 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhIHP0y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Sep 2021 11:26:54 -0400
Received: from [217.146.132.69] (helo=yoda.kc.loc)
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1mNzSH-0000tc-TD; Wed, 08 Sep 2021 17:25:42 +0200
From:   Florian Boor <florian.boor@kernelconcepts.de>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com,
        Florian Boor <florian.boor@kernelconcepts.de>
Subject: [PATCH v2 1/2] iio: adc: ad799x: Implement selecting external reference voltage input on AD7991, AD7995 and AD7999.
Date:   Wed,  8 Sep 2021 17:25:24 +0200
Message-Id: <20210908152525.2946785-1-florian.boor@kernelconcepts.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of the AD7991_REF_SEL bit and support using the external
reference voltage if 'vref-supply' is present.

Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
---

Changes in v2:
- Check if a provided external vref regulator is provided.
- Drop unused setting
- Add ad79xx documentation (second patch)

 drivers/iio/adc/ad799x.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 18bf8386d50a..2ff926a4e9b3 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -770,6 +770,8 @@ static int ad799x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	int ret;
+	int extra_config = 0;
+	bool vref_external = true;
 	struct ad799x_state *st;
 	struct iio_dev *indio_dev;
 	const struct ad799x_chip_info *chip_info =
@@ -797,7 +799,15 @@ static int ad799x_probe(struct i2c_client *client,
 	ret = regulator_enable(st->reg);
 	if (ret)
 		return ret;
-	st->vref = devm_regulator_get(&client->dev, "vref");
+		
+	/* check if an external reference is supplied */
+	st->vref = devm_regulator_get_optional(&client->dev, "vref");
+
+	if (PTR_ERR(st->vref) == -ENODEV) {
+		vref_external = false;
+		/* get dummy */
+		st->vref = devm_regulator_get(&client->dev, "vref");
+	}
 	if (IS_ERR(st->vref)) {
 		ret = PTR_ERR(st->vref);
 		goto error_disable_reg;
@@ -806,6 +816,13 @@ static int ad799x_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
+	/* use external reference voltage, optional if regulator present */
+	if (vref_external && 
+	   ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999))) {
+		dev_info(&client->dev, "Using external reference voltage\n");
+		extra_config |= AD7991_REF_SEL;
+	}
+
 	st->client = client;
 
 	indio_dev->name = id->name;
@@ -815,7 +832,7 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
-	ret = ad799x_update_config(st, st->chip_config->default_config);
+	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
 		goto error_disable_vref;
 
-- 
2.30.2

