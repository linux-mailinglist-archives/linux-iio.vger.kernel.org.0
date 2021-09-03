Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7C3FFB2E
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbhICHiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhICHiZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 03:38:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225FC061575
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 00:37:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so10288820ejv.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRGvZSsdRmFgCiMKoqUCm1KoczOaDBpTmvjrEAznFXk=;
        b=ZtgOuaGg9ld2PfKJa7EJwdFc7RVXoiDiH4rxAz6tIZ73a+uaFviS/V80qkBU5imk3q
         wfilCq4Oq9oFaDubG8CpWMdr8qqeFRJO0h4pjB/t569WKttrJLkfB3IUhYkR3Gi6PzfA
         oy9bkVNDrXB+M5Ckctjm/vwjMruXA7eiSVe6iscse9QUAizwboRHIACFoeG2x31vTbSi
         gj9Iuj+Hm0dHKk2P3bFNQJhDYhrHcOq/PlZeViaSP8FAqqx/JCOcjK3aqA6D7waaVQds
         uwVIKCVafTtFJGVYB/jmMrV42reAeYxRpen0BrcBnAdULJSAbR2sIzTr+8q1j0e/P0ap
         R9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRGvZSsdRmFgCiMKoqUCm1KoczOaDBpTmvjrEAznFXk=;
        b=uTF4Fki3HGcB/EO9akzDorYTu0pLYltayJNoJqkIBMfflM6nYbzx+aoPX5l96sPIsR
         qEzmWvTiUizGGvwny8xq8fTZ3d3uVrI7dIi2ENYXTvMaFb7H2uMyZD76rr7W/WaiXm95
         qPOBXHlB67obB5ZWWdt0+ONiquzKRPgw9YoJIagtbHGGl0U3Ujyx4HMYuO3Evl+S0D8K
         T5bXpiN8aZc4aTbH90eRLU7plzXH8RDc6TaX1X8zVyUx3t/ycpsEg8Uk+y328dY1UbGU
         s/wBPeZMXv/HvZR183M7g6OQYdqGfw72nKJWEkIrnLiWbqLKUvi9YSH6QjWzmCXROzvI
         w4yQ==
X-Gm-Message-State: AOAM5326djXZE8OzUAXgs9UGAqKSNpvlmPep36OMuSswdFMzz9zP5NIF
        Wwc17zvkQiYui24mN4KmU+cDqA==
X-Google-Smtp-Source: ABdhPJyotfem2L+UTIbP3rA/k0FEc8E9GhMu6BgmV48BRHsNgcPZN/WaC8+4YmMcuKABb5NZon7uMA==
X-Received: by 2002:a17:906:7fc4:: with SMTP id r4mr2660637ejs.75.1630654644357;
        Fri, 03 Sep 2021 00:37:24 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c19sm2211627ejs.116.2021.09.03.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:37:24 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: ti-ads8344: convert probe to device-managed
Date:   Fri,  3 Sep 2021 10:37:07 +0300
Message-Id: <20210903073707.46892-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the driver to register via devm_iio_device_register().
The regulator disable is moved on a devm_add_action_or_reset() hook.

And the spi_set_drvdata() isn't required anymore.
And finally, the ads8344_remove() can be removed as well.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ti-ads8344.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index a345a30d74fa..c96d2a9ba924 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -133,6 +133,11 @@ static const struct iio_info ads8344_info = {
 	.read_raw = ads8344_read_raw,
 };
 
+static void ads8344_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
 static int ads8344_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -161,26 +166,11 @@ static int ads8344_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
-
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		regulator_disable(adc->reg);
+	ret = devm_add_action_or_reset(&spi->dev, ads8344_reg_disable, adc->reg);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static int ads8344_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ads8344 *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(adc->reg);
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ads8344_of_match[] = {
@@ -195,7 +185,6 @@ static struct spi_driver ads8344_driver = {
 		.of_match_table = ads8344_of_match,
 	},
 	.probe = ads8344_probe,
-	.remove = ads8344_remove,
 };
 module_spi_driver(ads8344_driver);
 
-- 
2.31.1

