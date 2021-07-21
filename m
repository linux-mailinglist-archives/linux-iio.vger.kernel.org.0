Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9238D3D072E
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhGUC2n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhGUC0c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47676C061767;
        Tue, 20 Jul 2021 20:07:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id f3so305453qvm.2;
        Tue, 20 Jul 2021 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/AVhj16iNURSZKn9I66HSovjlv+JCMA7WuCaKBrMzQo=;
        b=XvTAw5ovqxPJHuW5WxMc8fBTLguBwnYcYyB+yMDcx6htF3XAPE13YP0S2oRwSg+fV9
         9EY5UBS2cPPT3tdIFtAkrqZDHYQ764ihap5pWR0FGc0UWdr04zWLR2xfjRu18Rxq86uC
         t/2E4MhI6qhlwNzYu7nGs1rF1YuDcMiytTvs+cZYC+QhP3iP7jkNRDYejTmAX8Vc+B6d
         ega2cmmVz/kYGw/caneQQQ1R38jc5AzkXYllWTUGSg1ZR/pofsh88dFNd6hjzfYgn6oY
         2iQrknq3brHM1h2boFhy9flNAX2FQgtirzHrg/7q5PKQZKs2DuGUD8CYU/VzN1z3S+Fo
         E/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AVhj16iNURSZKn9I66HSovjlv+JCMA7WuCaKBrMzQo=;
        b=HRPgL74eeinutKTF7AqP6UUGw1DXgjbjABZcrxTP8i0U5Y9m3svkE/faGByTfBbBuy
         7JBA5MHOV8PmU1xeGynIafVBF5wZCAdCNUvmvT/RI5MHvREP8Hvg2SfjbCmkR1kYk0wb
         RbOZbAu+Dcv9Id10lhwHZVOBstt9JF3Bs3Y9dkeeCmyexZTKtG1M3XOpVxl0oo3xoEWD
         mSvr11bFGQMDW5oOnE6ol8SAmicr0FEMAB5CmSQukcxmwA24pCdrcjprkkka9ReCv64Q
         PEOoCbh1CI+nNqQwxIeVJ0T42yZHe4fV57XW8mP5Laiai7LXtECciLJ3YqY3tXxbg7b/
         a64g==
X-Gm-Message-State: AOAM533W6hlkWagdgOv3lxa1fPo5/LDTeMDcaIizKKWH4bx/yhr2Lwpj
        sf6wZKM8x5I/CiZjH456Iyw=
X-Google-Smtp-Source: ABdhPJyGDTvcAx/C80x4YYcfqVaS8jpHUQmDuqFLg0jgdDFj2bzpO/3zdMRaYmLli4mEW/e8x1jwCw==
X-Received: by 2002:a05:6214:aa5:: with SMTP id ew5mr29083131qvb.18.1626836829482;
        Tue, 20 Jul 2021 20:07:09 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:09 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 10/13] iio: afe: rescale: add RTD temperature sensor support
Date:   Tue, 20 Jul 2021 23:06:10 -0400
Message-Id: <20210721030613.3105327-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An RTD (Resistance Temperature Detector) is a kind of temperature
sensor used to get a linear voltage to temperature reading within a
give range (usually 0 to 100 degrees Celsius). Common types of RTDs
include PT100, PT500, and PT1000.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 47cd4a6d9aca..6a1ecaad2da4 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -351,10 +351,52 @@ static int rescale_voltage_divider_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_sense_rtd_props(struct device *dev,
+					struct rescale *rescale)
+{
+	u32 factor;
+	u32 alpha;
+	u32 iexc;
+	u32 tmp;
+	int ret;
+	u32 r0;
+
+	ret = device_property_read_u32(dev, "excitation-current-microamp",
+				       &iexc);
+	if (ret) {
+		dev_err(dev, "failed to read excitation-current-microamp: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "r-naught-ohms", &r0);
+	if (ret) {
+		dev_err(dev, "failed to read r-naught-ohms: %d\n", ret);
+		return ret;
+	}
+
+	tmp = r0 * iexc * alpha / 1000000;
+	factor = gcd(tmp, 1000000);
+	rescale->numerator = 1000000 / factor;
+	rescale->denominator = tmp / factor;
+
+	rescale->offset = -1 * ((r0 * iexc) / 1000);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
+	TEMP_SENSE_RTD,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -370,6 +412,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -379,6 +425,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-rtd",
+	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.30.1.489.g328c10930387

