Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53379418A08
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhIZPvR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhIZPvR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 11:51:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4B1C061570
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 08:49:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dj4so58360354edb.5
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7Hf5GrZ92QHrs2oP0z+Ce2L1Cm+CIcH6pC/yH99vLU=;
        b=FWXoCoOhp/3CuRldq4F414is8Y2msOk2LuLifdsXvalRtmaQCh8bPPw337IJQSMagc
         I3qtDs5DkKbZZH1ZL1I1GcydZF/k9ZTYQ3rkKuEsujze+bTCdH2ZPMVf/jM+sMauMtwo
         zHJ3XW7Y+YjnIKnRb4djMPdvsKe0TqR83PB+wkcerjqkYY4GtakYcWbxlsFhuQw3sp8R
         avcGBdl16HQj2LC4qCo7ZLOXeHFJsk+UhJ1QNYbqSctUg4A65hCMRXt4Qy3drW1pEQS6
         NoYA5XA5lSFxcoTuBbpmrxFX7K6EmtJLP2HuhxffuPQZx21uEpm6mFiW+KAMX//M8H1I
         QsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7Hf5GrZ92QHrs2oP0z+Ce2L1Cm+CIcH6pC/yH99vLU=;
        b=vRrvO2SZLfaRFQ/49mL7w+FrOxsID2DVgJ2hhumy4a974/rXPsLPqQkgMopfWOmaMR
         Xmh99UTLjQDws9JHg7YZzkThT+vIlvMH6YLh0tfoZEt788F9P06BUYweY6y/8GNcBx5z
         KldZACVI9aO5b11qmF3KF071Ful6fiy2RH+swZXGDuwUNsXpuoyiG64yXcekN5RdDDUb
         w5THB345Bk6lXK+S7CRfbJ3/hlbFIHr+2Frc8x885iQK+srCc2VKfocY9BCrjtBUfUac
         uUCz2Z9w/jzfdgRIHAKHFGvrkdSn9Bd0AWXqKOEdxt4mqpbkMbPI3HxC490A5ufUwGto
         V/vg==
X-Gm-Message-State: AOAM533UbJtrtlR44L1SQYdRmtbc0bN9V+DLHq4XNWrmDzts+5XQDCHq
        y1DGx4DMlwtKia5/LWJbo+D7xlzDPKTMJA==
X-Google-Smtp-Source: ABdhPJxhfVZuR/Wf+Z2VoRsg3mKqQSsvt54xqMrp2NQBOznREqf623VssiMPNdQnwQmcNKnYFwsYbQ==
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr4823102eja.334.1632671379046;
        Sun, 26 Sep 2021 08:49:39 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id l8sm7395782ejn.103.2021.09.26.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 08:49:38 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: nau7802: convert probe to full device-managed
Date:   Sun, 26 Sep 2021 18:49:32 +0300
Message-Id: <20210926154932.3287590-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a trivial conversion to device-managed functions.
The mutex_destroy() calls are redundant, as the data will be free'd anyway.

And the IRQ and IIO register functions both have device-managed
equivalents.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/nau7802.c | 50 +++++++--------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index bb70b51d25b1..976c235f3079 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -428,8 +428,6 @@ static int nau7802_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
-	i2c_set_clientdata(client, indio_dev);
-
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &nau7802_info;
@@ -495,13 +493,13 @@ static int nau7802_probe(struct i2c_client *client,
 	 * will enable them back when we will need them..
 	 */
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq,
-				NULL,
-				nau7802_eoc_trigger,
-				IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
-				IRQF_NO_AUTOEN,
-				client->dev.driver->name,
-				indio_dev);
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						nau7802_eoc_trigger,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
+						IRQF_NO_AUTOEN,
+						client->dev.driver->name,
+						indio_dev);
 		if (ret) {
 			/*
 			 * What may happen here is that our IRQ controller is
@@ -526,7 +524,7 @@ static int nau7802_probe(struct i2c_client *client,
 		ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_CTRL2,
 					  NAU7802_CTRL2_CRS(st->sample_rate));
 		if (ret)
-			goto error_free_irq;
+			return ret;
 	}
 
 	/* Setup the ADC channels available on the board */
@@ -536,36 +534,7 @@ static int nau7802_probe(struct i2c_client *client,
 	mutex_init(&st->lock);
 	mutex_init(&st->data_lock);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "Couldn't register the device.\n");
-		goto error_device_register;
-	}
-
-	return 0;
-
-error_device_register:
-	mutex_destroy(&st->lock);
-	mutex_destroy(&st->data_lock);
-error_free_irq:
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-
-	return ret;
-}
-
-static int nau7802_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct nau7802_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	mutex_destroy(&st->lock);
-	mutex_destroy(&st->data_lock);
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id nau7802_i2c_id[] = {
@@ -582,7 +551,6 @@ MODULE_DEVICE_TABLE(of, nau7802_dt_ids);
 
 static struct i2c_driver nau7802_driver = {
 	.probe = nau7802_probe,
-	.remove = nau7802_remove,
 	.id_table = nau7802_i2c_id,
 	.driver = {
 		   .name = "nau7802",
-- 
2.31.1

