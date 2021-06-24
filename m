Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1A3B2A3B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhFXIVz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhFXIVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 04:21:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A02C061760
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 01:19:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot9so7165430ejb.8
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNUWuqrxVQTnwiFC8WouZpCK7dDNHne0/fZ7ZJMqRNQ=;
        b=F1daisEjVlUxd1cUecOhmbxPuXNwmb5mz8qkw6FK+mOifcEWoXDMo2q2Dj6hRkWhqB
         HR9Q/rz1q53kgfTZn5/X6PZ7+0PpTH3YfrH+0EewnrqMW8Hs+PkXAccXNSycoKhCSEkW
         xE56jYx20Ou4V+LWVOKDA1zpu+kcbqxlT1YO8TdcxCXEBwpNB9+jkxpmENHXg3z+eV5o
         lku/1hyhrW36UjPHgqBh4Wb8TiOJCOu5uevsvugZvoCPy7vM0nUDGSs1LLATmadiSW20
         AsI6mQaiP25o7bIE+inNCpwoydFV8ZtuzADe4NRThBQWwDiLHlSXWPdrIdgPLEjrmwy3
         lIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNUWuqrxVQTnwiFC8WouZpCK7dDNHne0/fZ7ZJMqRNQ=;
        b=kbr/hLoMjn/tVhpeW57xbZQbQaDJAQ0q6AzuzesIbFbtlQOknsDMbzF+rfcHUy9cbB
         q2Gf/HzSkRReC2V8eaFfgobj3JzoMPNFnGvMXbwLbovSETagu3yFDArvcf6Wh37WT1Nw
         a4C7ugdYi9Y46xL3661UJo6TnjK49+LrGJlB7GcVZYF92ks/DZUelA2bVdvfxg0Si+fV
         xrMkQOL78GCWalUFsdiQl2dx3vH70OfNHCPR/iohcAPBK5p2BrldQDUbmhhJppcNN0tn
         dKk75A7IloiJjL7BAfCaEL7eESwjt1BcmGXQEMh2jdiGNvLoQErcP2O4Y6A8KxJQ1BcL
         gHyg==
X-Gm-Message-State: AOAM530QeG+/UYnjH449CCsBFnzO427Je0oW1IBunzvSjY/DtBaWGh/v
        nLd4ZCPljRGSqJFg/JnjuCNZwWSTgcBi/2cz
X-Google-Smtp-Source: ABdhPJwJKq4o32mL1BlBWOyiUQjfUFhivfrsbCK6PIDU1fNJPj1aT9XVsopVj4NxX83HFkQQXMhTvg==
X-Received: by 2002:a17:906:9419:: with SMTP id q25mr4115347ejx.341.1624522773141;
        Thu, 24 Jun 2021 01:19:33 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id o4sm1374641edc.94.2021.06.24.01.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:19:32 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, pmeerw@pmeerw.net,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/2] iio: temperature: tmp006: make sure the chip is powered up in probe
Date:   Thu, 24 Jun 2021 11:19:24 +0300
Message-Id: <20210624081924.15897-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624081924.15897-1-aardelean@deviqon.com>
References: <20210624081924.15897-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the device is probed, there's no guarantee that the device is not in
power-down mode. This can happen if the driver is unregistered and
re-probed.

To make sure this doesn't happen, the value of the TMP006_CONFIG register
(which is read in the probe function and stored in the device's private
data) is being checked to see if the MOD bits have the correct value.

This is a fix for a somewhat-rare corner case. As it stands, this doesn't
look like a high priority to go into the Fixes route.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/temperature/tmp006.c | 33 +++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index db1ac6029c27..e4943a0bc9aa 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -193,15 +193,23 @@ static bool tmp006_check_identification(struct i2c_client *client)
 	return mid == TMP006_MANUFACTURER_MAGIC && did == TMP006_DEVICE_MAGIC;
 }
 
-static int tmp006_powerdown(struct tmp006_data *data)
+static int tmp006_power(struct device *dev, bool up)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct tmp006_data *data = iio_priv(indio_dev);
+
+	if (up)
+		data->config |= TMP006_CONFIG_MOD_MASK;
+	else
+		data->config &= ~TMP006_CONFIG_MOD_MASK;
+
 	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
-		data->config & ~TMP006_CONFIG_MOD_MASK);
+		data->config);
 }
 
-static void tmp006_powerdown_cleanup(void *data)
+static void tmp006_powerdown_cleanup(void *dev)
 {
-	tmp006_powerdown(data);
+	tmp006_power(dev, false);
 }
 
 static int tmp006_probe(struct i2c_client *client,
@@ -239,7 +247,14 @@ static int tmp006_probe(struct i2c_client *client,
 		return ret;
 	data->config = ret;
 
-	ret = devm_add_action(&client->dev, tmp006_powerdown_cleanup, data);
+	if ((ret & TMP006_CONFIG_MOD_MASK) != TMP006_CONFIG_MOD_MASK) {
+		ret = tmp006_power(&client->dev, true);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = devm_add_action_or_reset(&client->dev, tmp006_powerdown_cleanup,
+				       &client->dev);
 	if (ret < 0)
 		return ret;
 
@@ -249,16 +264,12 @@ static int tmp006_probe(struct i2c_client *client,
 #ifdef CONFIG_PM_SLEEP
 static int tmp006_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	return tmp006_powerdown(iio_priv(indio_dev));
+	return tmp006_power(dev, false);
 }
 
 static int tmp006_resume(struct device *dev)
 {
-	struct tmp006_data *data = iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev)));
-	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
-		data->config | TMP006_CONFIG_MOD_MASK);
+	return tmp006_power(dev, true);
 }
 #endif
 
-- 
2.31.1

