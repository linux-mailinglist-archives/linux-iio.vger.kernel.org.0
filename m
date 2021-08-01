Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3593DCD63
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhHATkd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhHATka (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333CEC06175F;
        Sun,  1 Aug 2021 12:40:22 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id cg4so2893886qvb.5;
        Sun, 01 Aug 2021 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JW0rtRe7VfEERJdhqxGKq5/nOxmZDzKEBQ4TjMWfoV4=;
        b=e4vK7gm5neVP1Yud4uDkOZwkAWT1hqIck7JLX9LoQB7marbuFzxCN3XkD5Vm0hWGEs
         obxB7YQgVHZ2CZ7V3UmdVxCy1iZvupUTBPae4n2+i2z9GpiZWtYSmZZ3rB6DNX6STYLF
         ZT+1Gsw79az1SQaOCxN9EHto58Y7BbAYr9ddeN0zUakKJ5M1Ls9R8ixupN5Z++flABtG
         Pf6NVOlSI8mU96fYCAll710QlX7BMi8e5WoLn7cZioXB7L6DQ31kkgGN63TOesMCtekV
         7SBUXXE9S4iYUuAxQMqm/5SrVRu4tiD0hnuGHp721oA4KYKHSV44/xRQ6mzkIZL1uWUG
         I6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JW0rtRe7VfEERJdhqxGKq5/nOxmZDzKEBQ4TjMWfoV4=;
        b=TrJnZP6FXfXWHsnIt8B9XOX/Ut6zaduxVr6zh+XpiA9shbm5I0i+1rALV+pFew4WP7
         Ty9V9Om6hqUcrtMqMRtQ4MreMCp3kbdrM92L3TmmPGei8IfbeNrvcnfInwvumWF6bcdF
         Fqn0yGJb6HLM7n03rgq8eTkGvwS95ltWPz+7XhH1xI+9opqRol8ojVqbVGQquVPQzFG1
         GALZLGfDIj6yzaHBUtv7fBkUGR9YeKGguQVQSTb73rJP4n2sisw8QeHJmi0pP5Q+3Zea
         Bu6I3RKbT7OEoeVZ5+zTPy48sJMqf7rlIjS2iFnizvahErmRc1GWi7itRwn2+nf1bL9P
         4KIQ==
X-Gm-Message-State: AOAM5308Gp0J/fH6ZkpRJWiZrl3YjYkO3PXKr58/xF+0Hv45OGcMN+he
        Xr8feaphchl6xch7E8MKsEc=
X-Google-Smtp-Source: ABdhPJxqyODdZ/5VFdRJ6S7oYqaJMWg4dbsT7hsUfmfQ8zdIevSB1SqOC6sDWA57FHPWUH2poA+CNw==
X-Received: by 2002:a0c:c490:: with SMTP id u16mr12815117qvi.26.1627846821406;
        Sun, 01 Aug 2021 12:40:21 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:21 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 11/13] iio: afe: rescale: add temperature transducers
Date:   Sun,  1 Aug 2021 15:39:58 -0400
Message-Id: <20210801194000.3646303-12-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
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
index 9683380aee5e..dc638402782d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -421,11 +421,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
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
@@ -445,6 +472,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -456,6 +487,8 @@ static const struct of_device_id rescale_match[] = {
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

