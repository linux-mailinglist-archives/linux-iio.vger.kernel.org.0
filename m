Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213861551C5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 06:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgBGFTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 00:19:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42712 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGFTT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 00:19:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so661689lfl.9
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 21:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ii4wIS6vHPPoGZVYhklzWw2qKWXLEXB4s7/of/M2k0Q=;
        b=TNBgClU/pqC4gO7XJFO5mndYKnDbNrDjWoMVHIM09Aq87HFynT46ofTsLPB/AL5fXC
         USxeJgzXLPPa3ykhpbSNtoFl3BWtIeSd/Ba4h34UtWlxS9VBWJFNUuRd2h/nUeafxo5o
         9UWKYAZIfVW8C0t9HO66JBrqwlUeykwX5hS+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ii4wIS6vHPPoGZVYhklzWw2qKWXLEXB4s7/of/M2k0Q=;
        b=gqFMhM0A0d3+gSB3FCEuq5u+rzi3i/ztGHdD5KZyNs2tUXt90vXNcNh1b+1if+EXut
         D4H1iWOanMhgCS76NvK776k6NRa0+s4zSPD3wr75rtwpxmMCn9bHEKkUge19LqEHyd0X
         EU4tI9ABlz5C/PUVLYdZXPZ0rhjC+LxahH9V2pXNubScNAKOBNt5adkDCx4g+2Cu1L0j
         mOpjdKw5td/0PAwT+bNsSsDLbhcXh4HwbCXBsk5mncbHSoU0KFYFLpEejyKVORfOa5GY
         VOC3Q59eOIkWgX2PVyQj4aPN7NsM1MtfKaYluZqUHe3saPsL6Y96O0xtORVXGzQmpQHO
         Ivaw==
X-Gm-Message-State: APjAAAW7I47TGrcXyzuup7cBvw3fllOIZtrlfTGUbYiXK2Q8YKd5QJ00
        8q4SviRJqyxeaboI3A2u/k2sornpZxVUqRW4
X-Google-Smtp-Source: APXvYqy05vfWwAOjlOHbt19NJ0elVAt3Qyd0HHY9hxZVjcvWOu+0N+6XRguP6cNAX9I2aBKo+N0mIQ==
X-Received: by 2002:ac2:5626:: with SMTP id b6mr3601792lff.134.1581052756973;
        Thu, 06 Feb 2020 21:19:16 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-167.vpn.ipredator.se. [46.246.49.167])
        by smtp.gmail.com with ESMTPSA id y11sm622069lfc.27.2020.02.06.21.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:19:16 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v5 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Thu,  6 Feb 2020 21:18:11 -0800
Message-Id: <20200207051813.9708-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207051813.9708-1-matt.ranostay@konsulko.com>
References: <20200207051813.9708-1-matt.ranostay@konsulko.com>
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

