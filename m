Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7C3D0730
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhGUC2q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhGUC0d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22749C061768;
        Tue, 20 Jul 2021 20:07:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bm6so889258qkb.1;
        Tue, 20 Jul 2021 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RO8WlOdaYdCVzds6lcbAmbmkaYOfrcMWqvsyZPbXX9A=;
        b=FwMuZGrUXefxl9YCPS70WjvXbNa4PJvH6na09u+nuND9ZahCFmiv7/UR86hpVaDHnM
         pT8BYGWthlIJEtZ994oFDqcfv+TF2Nn/P+CgKzFkjlNylXn0FjolCm9LaS6I+4KCnJa+
         mgq1b9nXW93c4tdK1JWVScMLtPs5EQxPLkvIEBnChbJi7kwyk+b8EMLBBX8VrhPK9a2p
         j5SaaJtsd40bDPgzWqE9N0i8LTfGkgCfNSJ4UwobAOTGoHEuWuZynn7qixU/9PkClLZE
         3F11TXBSZtqZuCY7CdIdMqDhRVgRMk1qx73XKoFdR5iughPg2kh7mA2KTXTGjIG5RWdH
         E2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RO8WlOdaYdCVzds6lcbAmbmkaYOfrcMWqvsyZPbXX9A=;
        b=N29BdkytLqWatvkk7UP4x4b3sGmNZ01dnJJ7lvopz3+YutghB5vsDWYUCkEJYUe4oC
         n0MFBuiA0i+HFWrvAN5LMXhoVpl/u2MuLvoH1dR/9RbCQRZV5Lmf8q7XSy4E0TGvXgqW
         1Jf5SDGCKgvX2NMTO5ZzM+BpFdHPNqbAsG/94eXlOTmvfsMXp42AFOJD1hM7EgDbgvw5
         5h+lO7fLzStKD4Fj+vph0Fa4HBTvR87HX5+bSaR/EyW5Aaig4J+hVdE5JvRw4bFaUmj3
         rx4PcwcsQoL9X2RYRJQpGx6KEhUD2Zxo+tQgigYmxXZE1bYcswvRT1VubxaAQL2nDIgM
         99GQ==
X-Gm-Message-State: AOAM531kxFDshBKlZfsQ0WpXMiFSzpjosRGywaFt64rrXL05nZkW75hr
        QsxTbXs/GTwauvuqXVqo9eU=
X-Google-Smtp-Source: ABdhPJyiTvWiy2m4uJfdqSjcCJFvbbDhsq6qd4UrxUKrlhuk3MNqiyYQ+JSXqNaFIk0IyRtFr5PLeA==
X-Received: by 2002:a37:8581:: with SMTP id h123mr32637571qkd.316.1626836830362;
        Tue, 20 Jul 2021 20:07:10 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:10 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 11/13] iio: afe: rescale: add temperature transducers
Date:   Tue, 20 Jul 2021 23:06:11 -0400
Message-Id: <20210721030613.3105327-12-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch add support for temperature
to voltage (like the LTC2997) and temperature to current (like the
AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 6a1ecaad2da4..3abeaded6169 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -392,11 +392,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_transducer_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	s32 offset = 0;
+	s32 sense = 1;
+	s32 alpha;
+	s64 tmp;
+	int ret;
+
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
+		return ret;
+	}
+
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha * sense;
+
+	tmp = (s64)offset * (s64)alpha * (s64)sense;
+	rescale->offset = div_s64(tmp, (s32)1000000);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 	TEMP_SENSE_RTD,
+	TEMP_TRANSDUCER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -416,6 +443,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -427,6 +458,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.30.1.489.g328c10930387

