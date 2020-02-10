Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D0C156D21
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 01:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBJALR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Feb 2020 19:11:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBJALR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Feb 2020 19:11:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so2892028lfp.8
        for <linux-iio@vger.kernel.org>; Sun, 09 Feb 2020 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ii4wIS6vHPPoGZVYhklzWw2qKWXLEXB4s7/of/M2k0Q=;
        b=FqH/2QFB8nqT8ybi1MK/4BQ1TGfvMAsFxNYd3xgLx65vO+VWSHCO9FSQQKRdA15cZm
         XWfHT+hQWD80n16glXusG0l4o1f/kcm4BQVyoX+4wqlhIvgP0a8I3cGtZ7G4zuxIad9N
         UFh2/bfp9X7E7oPGVF5iDTEXvTb7h0ejcEy1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ii4wIS6vHPPoGZVYhklzWw2qKWXLEXB4s7/of/M2k0Q=;
        b=CgwGz8k5Cbv0fYh2alb9dH5uJvP8P6AZtDYlyVq3snkhN52vem6Lq7QlJmM0bxxSMj
         LboXmHefclbkZnr6IKb3ICBeaXSWAViI31eZO+Og4/V5woo7DA5pGozvCBi/sCTl7CJt
         hYRbzDDDvMf38TsrSN9ej0VzHx8cx7T3Nta03g6QRTCYzgJOZCY1Fg+zQxn5/FP2CqgM
         GS/fDqEBBGtH/yEElTYspF1ouJMmsV6HGtMJiPDAouXiglGZeunJ6o38SlHYEjGVxEf9
         GVp6o9yYEhPKWTUs6GTzNcETUyiPizBt6aWvQ07ibov0TeO2z13abRZc1AhNcHC0FHJD
         354g==
X-Gm-Message-State: APjAAAWyx4+9b7cp5jhDk7IN2bci26JxEZOetAbCvpOU6QlkB2fN0SAL
        lN/tWnBREnjYY4l2PcLxVh/QpYKoixCfZ9oy
X-Google-Smtp-Source: APXvYqzmrRb9d4StcvL30m0+nxDNa8olxrF4z3szD5oYduhKiE47EE1OSNZ+MaDKjGBehtM/3n7h9A==
X-Received: by 2002:a19:7015:: with SMTP id h21mr4643880lfc.68.1581293473474;
        Sun, 09 Feb 2020 16:11:13 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-135.vpn.ipredator.se. [46.246.49.135])
        by smtp.gmail.com with ESMTPSA id f5sm4424962lfh.32.2020.02.09.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:11:12 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v6 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Sun,  9 Feb 2020 16:10:56 -0800
Message-Id: <20200210001058.7515-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210001058.7515-1-matt.ranostay@konsulko.com>
References: <20200210001058.7515-1-matt.ranostay@konsulko.com>
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
 drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 2f0a6fed2589..9a1ab9f8fcc5 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
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
@@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
 
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
 	}
 
 	ret = atlas_set_powermode(data, 1);
-- 
2.20.1

