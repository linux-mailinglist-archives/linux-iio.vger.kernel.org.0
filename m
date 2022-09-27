Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0D5EB7F7
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 04:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiI0C5j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 22:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiI0C4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 22:56:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC9374CE1
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:25 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g12so5328242qts.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Vh4rdFc767lJKefOOjqse4JvtQ6pHDKw9Ksf9KEoCe8=;
        b=JIfkxgHmjDQK6XSML8XAScC4bY1vjPXKRxOGDkA2hFc1P1H+a6pINq0EfU1ue0WImJ
         UIX/GzhFzs1fhUGk7SWHjevN5+2MBrNstZMV5tXU9sUPH3XIls+vab4gk/3EYmnQIJHM
         L/UzDNYehbOw87q5oOw4XktGXs3gbpaIZERLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Vh4rdFc767lJKefOOjqse4JvtQ6pHDKw9Ksf9KEoCe8=;
        b=J3cQY14tqV29qbtmTYAU3vtVZByLWm3zkMFju21XICEXfZl0sAIGEN2Uc6rYbmM6CC
         UkuQqFNeN222/R8mszmSHTbj2TS+gstazh0avYxp9GjTNvna2MCBzDgWnRykXVeDhTJd
         PcqPy+4tthJVp0Gcky+gkxalS+Z4/6WYPz1IrRk8HOV6tZrDv8aIpxUHXml7Xti0yJc7
         rOgAynVbzFUcn/oDqcaoQIUJ3P/i+z8SCfLrjnSU/R/9+uM6hIduJRk/rZgDTED5gLD+
         yCrdUkL6Y5a2fPybZ7TXGYELNe3V4dHwZgtdKn6LMvfmStOynD07O0o+5ddXjDsIYVrh
         GKtQ==
X-Gm-Message-State: ACrzQf0mfXZU9Sgz6Yrh5yEd7D1UPM4Xzq08SH4KScNI7cucQtxGp+gL
        NlHNIV03ihb100YoL0+1VPBKEjOkpWu6pB+T
X-Google-Smtp-Source: AMsMyM7nB4J0F/dZdMpx0HjSKJ+CMikkeV5pfKaPVLJeZTNwtv2Qc7tEvK7/6L3ynkA6gIRUVOhfXg==
X-Received: by 2002:a05:622a:1053:b0:35c:bab4:bd80 with SMTP id f19-20020a05622a105300b0035cbab4bd80mr20660628qte.189.1664247085607;
        Mon, 26 Sep 2022 19:51:25 -0700 (PDT)
Received: from roguebox.lan ([164.92.70.235])
        by smtp.gmail.com with ESMTPSA id y5-20020a37f605000000b006bb0f9b89cfsm199620qkj.87.2022.09.26.19.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:51:25 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org, gupt21@gmail.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v5 4/5] HID: mcp2221: switch i2c registration to devm functions
Date:   Mon, 26 Sep 2022 19:50:49 -0700
Message-Id: <20220927025050.13316-5-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927025050.13316-1-matt.ranostay@konsulko.com>
References: <20220927025050.13316-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Switch from i2c_add_adapter() to resource managed devm_i2c_add_adapter()
for matching rest of driver initialization, and more concise code.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/hid/hid-mcp2221.c | 51 ++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index de52e9f7bb8c..3365e21547c6 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -824,6 +824,21 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+/* Device resource managed function for HID unregistration */
+static void mcp2221_hid_unregister(void *ptr)
+{
+	struct hid_device *hdev = ptr;
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+/* This is needed to be sure hid_hw_stop() isn't called twice by the subsystem */
+static void mcp2221_remove(struct hid_device *hdev)
+{
+	return;
+}
+
 static int mcp2221_probe(struct hid_device *hdev,
 					const struct hid_device_id *id)
 {
@@ -849,7 +864,8 @@ static int mcp2221_probe(struct hid_device *hdev,
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "can't open device\n");
-		goto err_hstop;
+		hid_hw_stop(hdev);
+		return ret;
 	}
 
 	mutex_init(&mcp->lock);
@@ -857,6 +873,10 @@ static int mcp2221_probe(struct hid_device *hdev,
 	hid_set_drvdata(hdev, mcp);
 	mcp->hdev = hdev;
 
+	ret = devm_add_action_or_reset(&hdev->dev, mcp2221_hid_unregister, hdev);
+	if (ret)
+		return ret;
+
 	/* Set I2C bus clock diviser */
 	if (i2c_clk_freq > 400)
 		i2c_clk_freq = 400;
@@ -873,19 +893,17 @@ static int mcp2221_probe(struct hid_device *hdev,
 			"MCP2221 usb-i2c bridge on hidraw%d",
 			((struct hidraw *)hdev->hidraw)->minor);
 
-	ret = i2c_add_adapter(&mcp->adapter);
+	ret = devm_i2c_add_adapter(&hdev->dev, &mcp->adapter);
 	if (ret) {
 		hid_err(hdev, "can't add usb-i2c adapter: %d\n", ret);
-		goto err_i2c;
+		return ret;
 	}
 	i2c_set_adapdata(&mcp->adapter, mcp);
 
 	/* Setup GPIO chip */
 	mcp->gc = devm_kzalloc(&hdev->dev, sizeof(*mcp->gc), GFP_KERNEL);
-	if (!mcp->gc) {
-		ret = -ENOMEM;
-		goto err_gc;
-	}
+	if (!mcp->gc)
+		return -ENOMEM;
 
 	mcp->gc->label = "mcp2221_gpio";
 	mcp->gc->direction_input = mcp_gpio_direction_input;
@@ -900,26 +918,9 @@ static int mcp2221_probe(struct hid_device *hdev,
 
 	ret = devm_gpiochip_add_data(&hdev->dev, mcp->gc, mcp);
 	if (ret)
-		goto err_gc;
+		return ret;
 
 	return 0;
-
-err_gc:
-	i2c_del_adapter(&mcp->adapter);
-err_i2c:
-	hid_hw_close(mcp->hdev);
-err_hstop:
-	hid_hw_stop(mcp->hdev);
-	return ret;
-}
-
-static void mcp2221_remove(struct hid_device *hdev)
-{
-	struct mcp2221 *mcp = hid_get_drvdata(hdev);
-
-	i2c_del_adapter(&mcp->adapter);
-	hid_hw_close(mcp->hdev);
-	hid_hw_stop(mcp->hdev);
 }
 
 static const struct hid_device_id mcp2221_devices[] = {
-- 
2.37.2

