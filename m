Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98713C963E
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhGODPj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhGODPi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C6C061767;
        Wed, 14 Jul 2021 20:12:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x24so3510293qts.11;
        Wed, 14 Jul 2021 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iG9doMSkOjGbuRC6SLDooD1hmJaLMt+b8S+uRbwt3Gs=;
        b=pLISMormbjm2qrxlnj+b6/aOoaQsHPIRQ94TSugwqMuhT11+1SJXlbnPzv7WC/vAQA
         K90IBO6+hBJuy2TVxq16p9lYBpyVX7lEQrTiwYOuLpa0Vmh3TrBA6KSDnwADq+cPtSFv
         SIPjpiuOG13TgDAi/9CXV/sL0DC+V+FH+dVx6cfpsjK1cLxOYp/PXaMsuVoeeNlTAo4K
         /LMKRfc7auXtDoXyV3RGBxkW99eLBhyL/C7cWn4oLonU4ON3rENly7Vyp/DZnTJYi3p3
         qBWmf//pSTETXekyln8t0ArqREmkV7T1wB2bcG6DF+gGDod+yGeDxdO+5xF9OaULL8m3
         82kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iG9doMSkOjGbuRC6SLDooD1hmJaLMt+b8S+uRbwt3Gs=;
        b=JdfkhNbsqD2fjWDUx0aUN6+HBEvAU94L3aSB3OPWimrNH8UhZBritH4Cc3qAAi+Wzp
         zYw0Zb2Wgq4UH1co7KQR4gv7rlF2gWez4Ub1VIHFCOgyjlIyixjYsV1681uPAvIKOn5P
         sDIfGqlJvMakj7rR69ekSJkUUV4+6iO0p5yo0zuVcOZ2CjxQ3WMuOjfC6k1N/R+/1tKD
         g5qbq78YULIrM1sIgaqxVDKEgJJ/aidfozbjnrN2CNzwk8YApJOq+YtmGgF1aVKSNQcL
         SKwGdD6quy39gZnXbxIpSWuZMf8SDxfWVo0wrequ7/KyDhsU+9/PR8PKZrf+xW7qiYrE
         4IyQ==
X-Gm-Message-State: AOAM532t1RrmhR8iQ0UK+JkDP4qx2kEndTJhnLHOAnUKnPu24m4W7j4y
        7w2euEbXrssAeT/xPpxv1xg=
X-Google-Smtp-Source: ABdhPJwon8CRGlIixWaw59adLEzkn7nOwC2lXLvSvQ3CsmICZFdFnnQyfEn+W0j9K3sZX839jzfQyA==
X-Received: by 2002:ac8:dc9:: with SMTP id t9mr1572776qti.293.1626318764633;
        Wed, 14 Jul 2021 20:12:44 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:44 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 08/10] iio: afe: rescale: add temperature transducers
Date:   Wed, 14 Jul 2021 23:12:13 -0400
Message-Id: <20210715031215.1534938-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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
index 055f6b7c9869..4b3b5e9bbe40 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -397,11 +397,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
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
@@ -421,6 +448,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -432,6 +463,8 @@ static const struct of_device_id rescale_match[] = {
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

