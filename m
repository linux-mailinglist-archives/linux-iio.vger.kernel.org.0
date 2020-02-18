Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D131C161F9D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 04:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgBRDmy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 22:42:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRDmy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Feb 2020 22:42:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so22133576wru.7
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2020 19:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAyMMJJFqtuiatOJlm6veeC6oPjCFs/ISVKyLad61wc=;
        b=K+z31VhpA0QTsUc1K0nGHfQ9frgbQ8Rmew8lclFozJc2qzAlcEBDuRG81lnzwaIiOb
         ZrfJ89vtx/BBIS+KmMbaqEk/QroyPH95D9RQlJffhXPiiA/zDYma58USNfybBiDO/tzi
         N5ji2KtVV1oHFakw/u2m+7YMbxkg+pDGwUFtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAyMMJJFqtuiatOJlm6veeC6oPjCFs/ISVKyLad61wc=;
        b=l8WUdfnjYtX1dLtm8rShRHrTFJt6FlB7M63bxT51xLy6Wyn7Ue9XZxwPHU8h/6ZmLO
         VVFUYqMkeqV3/aPrUd81c5KWJ7wXmRt1UjV1modZ2NUBUx3a/A03/cXES3IuTTSuCPMz
         Hg0AkkhlN7NJQF7hJSZuOJB9GkA3LqPBUmFVIGBBizVuvBubfahrfHUbb/3/tfKZkicy
         8FlGqB2rYozntifrH8uLE6qda5oX1ib7T+LWyYDSvokmbmQ1MzRaemai0V+vcrHJiCdS
         +Fkn7FiWoMwM1qRUi5qhP2yBZoXl00gHg2V52Qrdt6NuOVpJliFdTE9uVFO2NxxRbqZo
         uADQ==
X-Gm-Message-State: APjAAAW1lr6t1oCNdK6kqPnVni+MsucMrjZd6ZUjtstmVz349j0hD+fF
        gy2PDgPQtHt/oFh0kpXwJgRe28wIDJCwfeVV
X-Google-Smtp-Source: APXvYqyYNny/5OOKGi+IjKcMWkjetX6STt68EDMnpSFAk0bOeD5A5G+XusxHNYlLA0oF3AjqXJEuAA==
X-Received: by 2002:adf:e8c9:: with SMTP id k9mr26209989wrn.168.1581997370959;
        Mon, 17 Feb 2020 19:42:50 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-213.vpn.ipredator.se. [46.246.49.213])
        by smtp.gmail.com with ESMTPSA id s22sm1816901wmh.4.2020.02.17.19.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:42:50 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v7 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Mon, 17 Feb 2020 19:42:37 -0800
Message-Id: <20200218034239.135619-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218034239.135619-1-matt.ranostay@konsulko.com>
References: <20200218034239.135619-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sensors don't actually need a interrupt line to give valid readings,
and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
the required check for interrupt, and continue along in the probe
function.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 33 ++++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 2f0a6fed2589..d95818b74770 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -76,6 +76,7 @@ struct atlas_data {
 	struct atlas_device *chip;
 	struct regmap *regmap;
 	struct irq_work work;
+	unsigned int interrupt_enabled;
 
 	__be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
 };
@@ -304,6 +305,9 @@ static int atlas_set_powermode(struct atlas_data *data, int on)
 
 static int atlas_set_interrupt(struct atlas_data *data, bool state)
 {
+	if (!data->interrupt_enabled)
+		return 0;
+
 	return regmap_update_bits(data->regmap, ATLAS_REG_INT_CONTROL,
 				  ATLAS_REG_INT_CONTROL_EN,
 				  state ? ATLAS_REG_INT_CONTROL_EN : 0);
@@ -572,11 +576,6 @@ static int atlas_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	if (client->irq <= 0) {
-		dev_err(&client->dev, "no valid irq defined\n");
-		return -EINVAL;
-	}
-
 	ret = chip->calibration(data);
 	if (ret)
 		return ret;
@@ -596,16 +595,20 @@ static int atlas_probe(struct i2c_client *client,
 
 	init_irq_work(&data->work, atlas_work_handler);
 
-	/* interrupt pin toggles on new conversion */
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, atlas_interrupt_handler,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					"atlas_irq",
-					indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
-		goto unregister_buffer;
+	if (client->irq > 0) {
+		/* interrupt pin toggles on new conversion */
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+				NULL, atlas_interrupt_handler,
+				IRQF_TRIGGER_RISING |
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				"atlas_irq",
+				indio_dev);
+
+		if (ret)
+			dev_warn(&client->dev,
+				"request irq (%d) failed\n", client->irq);
+		else
+			data->interrupt_enabled = 1;
 	}
 
 	ret = atlas_set_powermode(data, 1);
-- 
2.25.0

