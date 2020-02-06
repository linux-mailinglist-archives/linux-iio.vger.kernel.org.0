Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE3153EAE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 07:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBFGYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 01:24:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35862 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgBFGYN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 01:24:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so2538115pfv.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 22:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNSyMZF9468DIDJcjhlMXesbT1C4yGPmOXHzox1YDqw=;
        b=ry0YiSgg3AUYCpxB9KezLDUQp9Nw7If3Cd2u3RMiGy4F4oW4nSfydbrNzG7Gjqq7iJ
         cJVvxq/Tq4ZIQAqjED5ceY3KCfy/y7sLKkncS41MYh3znfzDOoLlflZuCeFJ/8xbG/rQ
         K12pZb4+0m7XEraQvv4k+gAnmvQFPpUBMsDfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNSyMZF9468DIDJcjhlMXesbT1C4yGPmOXHzox1YDqw=;
        b=G3Gnsxy6Xr3TGdWcHbo0ZTzzVlHVczSQrIDAuvBXcPOaAnRJ9Th3bdEyJuV3nCTJCu
         nCpHM1vzztPw5IvrVAKf9DkHiM0bUML/VFzqLLvC2ozix5nCuIyDONfWtmBskNmW47Bv
         db+XsLM9c5mz4IydDmnEt7uPmGWIbpm6MU9uG61/lapPN04PUO2LT3D/E5X52cQXu6Ec
         bykX23mlQLg0ZwP21WFrci0LXB36dbSy52ZJpq/j9aQIcQ1Q/9UTvF8yJckY9WC3lQsA
         BCjYhMKo/io10UybbxGLDor4KM5L/PFtKCTzCfEH7sW4haj9edVvtGqQ6U+oFlbqR17N
         1rDA==
X-Gm-Message-State: APjAAAW8ZopORGnq2cTFG+Wt/xLSwrakgDNwdlLi0OWwUyal0IKwlaB3
        0T+zdbEftVt7Omn4Rmz7dm1Tyxh00DmiaeAi
X-Google-Smtp-Source: APXvYqwBRoKfdtuwWgJFoijSYU5IGUEva0hU4LwGujQDubaUkAPoHBTs6i2m5/u+9CcmHErnvh9YZQ==
X-Received: by 2002:a63:220b:: with SMTP id i11mr1899661pgi.50.1580970252633;
        Wed, 05 Feb 2020 22:24:12 -0800 (PST)
Received: from virtualbox.hsd1.wa.comcast.net (c-67-171-239-254.hsd1.wa.comcast.net. [67.171.239.254])
        by smtp.gmail.com with ESMTPSA id z127sm1771323pgb.64.2020.02.05.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 22:24:12 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Wed,  5 Feb 2020 22:13:30 -0800
Message-Id: <20200206061332.20427-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206061332.20427-1-matt.ranostay@konsulko.com>
References: <20200206061332.20427-1-matt.ranostay@konsulko.com>
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

