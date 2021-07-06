Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159673BDB23
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhGFQMq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQMk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:40 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FAC0613DF;
        Tue,  6 Jul 2021 09:09:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id cz7so6424066qvb.9;
        Tue, 06 Jul 2021 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wipmj4NMKfO6AmP+1P+Wf97ug+vf/cTSosjchY+j6OM=;
        b=kbkGsX17sjb1B8l4s71vL28BTZeO+YymNE8l0AQssr1InTeOVFdhq/YN9EUaSuHT2g
         G82SzadaloqHFE6DgzoYws68/8hXa4C67EFPGs9aS90PRMr2hLDHMfOgtUcZFCdznDMV
         svB06sWUAultpwCww9fUxt/pOEbwhY5WlgEeqHFAqhFVZf8hOpyIexdcYMYBLUBnCWS2
         fz7rnLLRo+ZB2BBDKUOBrVIIaOVDaCMB+J+SZeh47ro6Hiss/+U8Y+J8G/7ty0Bejbcg
         GGvID2OaR6RculYK5gghKpW/YXjg72AiVTssW+7/G42P/rgkC8lQ8SaYtKYWjFWLlQ7l
         GyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wipmj4NMKfO6AmP+1P+Wf97ug+vf/cTSosjchY+j6OM=;
        b=SOIgqtvkQETm6RHr3w9IB1ux5NSKiUAeqo3Q31JaHNYsuj/K24kEntjnMpCyNp2rI5
         8lY28aNa5cr33KQ1W8bRn/cTV1Y1PwKYp9QBAuV7mRtKq3zrU/f4eTL94acm8Dwr8Kv4
         dvmgcsWI1KGCnsmC6dzY1Kl5ZyJqAUpW0jz148tij56HlI15LADBMucUSTVcGqEYv5XN
         WOnQ4hE7t9Rp0lyXUxka/Gs1fYahqZZr3tDRGdoYNdKMxP5EmZrWsc0tRi6PIFHr9uVQ
         e4bbbAvef9iqwaRHfui2z9+KBIpEdXHckIv15XQAPFI1JNmEmMZ2qI9xt1S+HuY4Cogc
         6BkA==
X-Gm-Message-State: AOAM532qWdPDHOQQqad13Y7oHs8R9EclRj3J6zinVqXvCpZPqKmGB9JI
        7JCqxequiy0v0XBEs825NypDQoYQ0uf6+Q==
X-Google-Smtp-Source: ABdhPJyr+5PaSXkfSZxJIvhzbpYbWkmx9VldlhPRgNs+WS/I7u4/zDZzGxeTshyN/uyDYg9DMQauiA==
X-Received: by 2002:a0c:e087:: with SMTP id l7mr18874392qvk.22.1625587795907;
        Tue, 06 Jul 2021 09:09:55 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:55 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 07/10] iio: afe: rescale: add RTD temperature sensor support
Date:   Tue,  6 Jul 2021 12:09:39 -0400
Message-Id: <20210706160942.3181474-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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
index 7b241e0d8638..835aa92a1db2 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -346,10 +346,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
@@ -365,6 +407,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -374,6 +420,8 @@ static const struct of_device_id rescale_match[] = {
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

