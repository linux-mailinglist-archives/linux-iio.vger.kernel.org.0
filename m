Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BF1527F9
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 10:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBEJE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 04:04:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39629 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEJE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 04:04:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id t23so914253lfk.6
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNSyMZF9468DIDJcjhlMXesbT1C4yGPmOXHzox1YDqw=;
        b=B/cpXZCBe9HlxQnnzYgd8GeOaLfs3NxID9W88MwWtFrhkF2CtEshaKTWZ0CBIVYc/M
         WhZriO0tTz8Sy3KBFYM0iBfb5dLIHK1u0AF7sdCAOxoR9pJ7JnYTNn8/041X4lRW2Lqn
         8vw4GRl3VRLfRao6Ad5M8Cn27XSwOgUqxBICA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNSyMZF9468DIDJcjhlMXesbT1C4yGPmOXHzox1YDqw=;
        b=qlpYCIOlHJP2TJ7AzVNJR3cRPTEWyD9hmnrD7zshZFv/3RgTCk/7zTADVbhaSkJvrx
         U/WrK939ZV0+8FS8Nx6sxrlEu9JywOCmZLJuL56tdyWlWLJ6CkwFW9vKEyXyjakB1Z+1
         W9DsE4H2zOLIXXSg2i9G1OpbhOWHn8KHGro1fRg/tRbu8Qh1+GnXZB9P8IycTtdtKnfL
         2uP0rBiNjfcjQN9Q7ScsmsOlqqKJ0XiCfamhFwGueIJF1aGMXIU9JlcJF/RY6lNDcbrn
         yP3J562lWPoe6iDzBd78v92JXehyEXtRBfKmu6bF10tZG7joceBSF69bk6kttpiHuS/G
         ZaIQ==
X-Gm-Message-State: APjAAAXf9z7fd2eO2iU216s+tCvUy53Jv8Pb7qqmjUWEBumvVkyPWOZy
        gUKVJjskSi0LMWkfsPfxnDibRAndGmQ=
X-Google-Smtp-Source: APXvYqxdusHIKhFdHcvbznpDiNRG8wor0AFmXoOiMBynJ7M2PzHjYImmhurjnW8ONyIGQf+8hmhGqQ==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr17215092lfi.71.1580893466920;
        Wed, 05 Feb 2020 01:04:26 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id k25sm12684009lji.42.2020.02.05.01.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:04:26 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Wed,  5 Feb 2020 11:04:19 +0200
Message-Id: <20200205090421.18339-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205090421.18339-1-matt.ranostay@konsulko.com>
References: <20200205090421.18339-1-matt.ranostay@konsulko.com>
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
index 2f0a6fed2589..2e34c82cb65d 100644
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
+	if (client->irq <= 0) {
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

