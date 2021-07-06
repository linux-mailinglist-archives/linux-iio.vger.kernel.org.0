Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5103BDB1E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhGFQMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhGFQMl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:41 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C60C0613E1;
        Tue,  6 Jul 2021 09:09:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x6so10016464qvx.4;
        Tue, 06 Jul 2021 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNCGJC0jt5VCZTThQIL7fs/2x3eNy+R8Wjb7LB5/Aps=;
        b=a7j+a2+Bo3+6clB3fqYzpOe80sW3taFjN5PfYUn/kmZ75T7n61yluJyG2SlprLCb/P
         3ExAZH1M2cfyDr/nO7wfklHEewi0uVFICMte2tqGmHZXV3+daV+xNkoIVHo+cmV748Fw
         gjnwYtSA59l/OjcOeWpQylzS+sCNHJC1Yh+jItbKgscxm13TuRT9ag40q/0gsOx4hTYR
         qTYYp+3lilKQkT/qwoRn2wta3b2mOSlBaTh0db/MRuEYP9MvgNiCpRLqQ4na6u3g00yL
         9tJW0EAeQsL5mVl0OShCp84roJpO5FKBssMl42gQtK5ab32YhY88FziS+ShRHG7eY6PO
         sqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNCGJC0jt5VCZTThQIL7fs/2x3eNy+R8Wjb7LB5/Aps=;
        b=dvxC4JoyfPkGiQCt1lm/SDtVPLaf+yEhGddXUPxqMV55aN8agtPBuQTveUx/xJLbuy
         lEw2Zk92MPQtgMopSqOJnAS5N07+dhZ0IUXpn279iT0bg4iMGtKQvnErMj73/toaACL5
         XpoA23dJTzLKm+VrpWIc1JGOnsaKuR1QRr5Ki8WbiwmPK8riPJP+bOCoQsOexSjjWuRs
         q4yLsUyKpCJZIdzeUFM0jBeyBq9lRwyX8a1cd06XQ0waMPnuWuIEAse91LuoSbMUL5IP
         ySMvR6q1rV7FYKZpIY0OkOdls+nGtmlxKykQPHu2Jle1f2g+0rnppduXZGoz6MYzNFRY
         bhjQ==
X-Gm-Message-State: AOAM5327KIf5EEmJXWRgMz+5CR0M2D8EHCpeXPfT/ubuo5dWDBrsHF3C
        vrDfx/Zp+AgSWpLN0Vg46yc=
X-Google-Smtp-Source: ABdhPJwpOgP3amf0UZd1xfOHJtNXu+ExRxu8cIyg1NayWQpvcGL/2/Bp304+LvaVDb2JxRk6M50u2A==
X-Received: by 2002:ad4:538c:: with SMTP id i12mr19172186qvv.51.1625587796834;
        Tue, 06 Jul 2021 09:09:56 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:56 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 08/10] iio: afe: rescale: add temperature transducers
Date:   Tue,  6 Jul 2021 12:09:40 -0400
Message-Id: <20210706160942.3181474-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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
index 835aa92a1db2..8420bd01f378 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -387,11 +387,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
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
@@ -411,6 +438,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -422,6 +453,8 @@ static const struct of_device_id rescale_match[] = {
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

