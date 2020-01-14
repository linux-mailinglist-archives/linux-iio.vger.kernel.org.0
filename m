Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC595139F7A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 03:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgANCX4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 21:23:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgANCX4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 21:23:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so8499682lfp.8
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 18:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNSyMZF9468DIDJcjhlMXesbT1C4yGPmOXHzox1YDqw=;
        b=mDy+EZ6X5GgilJ9ne51v8HMqJsX5282eBEYmoKxUiatJeNZOf7eEnKdxCBa81I3RDP
         KUjiusCvUD+Fslh74IXzwHPXX0VPvtPs5jptWAUisfxesxOvprxo4tpCo1DU4X1x2omb
         HimwcXe1DM+v8ul5cO5BW1Yq/3POxrPYQWO/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNSyMZF9468DIDJcjhlMXesbT1C4yGPmOXHzox1YDqw=;
        b=EYMk2pR4cF6fc4ogrgf/VtkCianeQkRlIMwqcPvmQdIXGKC9PtJhK/ZEdEeye97svw
         uWYvDriIG7wrT+wHZtD0cBf7ZtnhpIIq1pemeINcJmF5+CgJBD4t9AXuRPIPES7+lqHY
         wYACP4WkpqVOpvKUT3/DZi1FPBQdXlHzX+9OBgFDPRQoOy7vP3igg+gb4jWoUeqO9Yh5
         haWO1sCMZvMLhGw9kmgzPE2t2Hgl/B/79kK51aA7Hpo3NbgjVFj7lBClPZpMyOFyKpEV
         aZtO5mL47aMVZ5l029v6Rt2fuAUyMXxW/BNCrkgmmOctW5tLg/3fvy4dmyxl1WC5HSTu
         G9Ug==
X-Gm-Message-State: APjAAAXIvH5KQ1nvqh5s0BdTT/GcmXaL+tWGqZ6o27otYE6M+LNaBkXz
        fMdmmEIq5tovS2Y147N4AfmlC/+zNt+dkg==
X-Google-Smtp-Source: APXvYqyENUZJ+5q7004mp0P/6TVE3O0zjTt1Io9N3/+x6sbrFC0G/mchWxfXbdz0mLcs3XjXzQe7qg==
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr250965lfl.125.1578968634312;
        Mon, 13 Jan 2020 18:23:54 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id r26sm6388648lfm.82.2020.01.13.18.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 18:23:53 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Tue, 14 Jan 2020 04:23:46 +0200
Message-Id: <20200114022348.8676-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114022348.8676-1-matt.ranostay@konsulko.com>
References: <20200114022348.8676-1-matt.ranostay@konsulko.com>
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

