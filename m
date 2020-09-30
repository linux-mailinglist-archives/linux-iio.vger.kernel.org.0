Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DEF27E31D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgI3H5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgI3H5p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:57:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFFAC0613D9
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d23so532175pll.7
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aT8prnv5d5Tz6tkq47WAtD2njLvNDdu7SxPY6pWts4A=;
        b=mL3JweQhGGoca5BQBegEv/hTE/61wlUb+4eXMjERTDye/9Yd4VCIl/nZBJnQMKO+dy
         9dc0Tg1Arf/1yBJ4gErzRQEm7AsxaxIGJXvQJpwZgQNbzyRJb0VTnLwod0u8uYpUDXVM
         fVOMLA4c4gXRmnWDnaRQRExzeiCkYcriOpqz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aT8prnv5d5Tz6tkq47WAtD2njLvNDdu7SxPY6pWts4A=;
        b=pqaTQxKLW+6gGiI8+NdF4oJSIm5yQ1uLmn/YsQmPoljNmGS36pLPDZa/WQ7prGnhDB
         rCNpQNj7TjwRCN31MgfheJyTPZxuitaKh2nih6dQHVZlGbEUcRETlRO9w/lJ4dKsfJv1
         T3jlj3SiuS0BvIy7OjQVSVzCyb7WYA9LWWcvEIs58357iLptAcFVJT2EbSjfErXqHN4h
         EbD1KYgbA8Dc0CM1NIzxPRX3w4IINRUl3HFBdpc7E1g1OL+0Iju9i/DrxPumT7gogWzk
         WHz616IzEqTr+megWI5vI88jabpHYLcxReCqpDzspNBrCA4DSi73J+bOmHca40bHh37T
         udNw==
X-Gm-Message-State: AOAM532SMzYFG/nFC7UZ83gt9+fOST9Ufea92TfgO4FCm+pHExxvpiyE
        PiSrBLoiBqcIUeksAvqt6QzEhw==
X-Google-Smtp-Source: ABdhPJz9DnGqc5lHroc1ERxfOKlJNZ06rBkBKiWUfVpl9bTaG+MMf4V2wiyhS3Qa9589NqbVO2apEA==
X-Received: by 2002:a17:90a:f686:: with SMTP id cl6mr1406719pjb.43.1601452656319;
        Wed, 30 Sep 2020 00:57:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l21sm1272131pjq.54.2020.09.30.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:57:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 6/6] iio: sx9310: Set various settings from DT
Date:   Wed, 30 Sep 2020 00:57:28 -0700
Message-Id: <20200930075728.2410327-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930075728.2410327-1-swboyd@chromium.org>
References: <20200930075728.2410327-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These properties need to be set during driver probe. Parse any DT
properties and replace the default register settings with the ones
parsed from DT.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 141 ++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 3f909177eca9..1e9a4a8bc717 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -49,23 +49,42 @@
 #define   SX9310_REG_PROX_CTRL0_SCANPERIOD_15MS		0x01
 #define SX9310_REG_PROX_CTRL1				0x11
 #define SX9310_REG_PROX_CTRL2				0x12
+#define   SX9310_REG_PROX_CTRL2_COMBMODE_MASK		GENMASK(7, 6)
+#define   SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3 (0x03 << 6)
 #define   SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2	(0x02 << 6)
+#define   SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1	(0x01 << 6)
+#define   SX9310_REG_PROX_CTRL2_COMBMODE_CS3		(0x00 << 6)
+#define   SX9310_REG_PROX_CTRL2_SHIELDEN_MASK		GENMASK(3, 2)
 #define   SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC	(0x01 << 2)
+#define   SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND		(0x02 << 2)
 #define SX9310_REG_PROX_CTRL3				0x13
 #define   SX9310_REG_PROX_CTRL3_GAIN0_MASK		GENMASK(3, 2)
 #define   SX9310_REG_PROX_CTRL3_GAIN0_X8		(0x03 << 2)
 #define   SX9310_REG_PROX_CTRL3_GAIN12_MASK		GENMASK(1, 0)
 #define   SX9310_REG_PROX_CTRL3_GAIN12_X4		0x02
 #define SX9310_REG_PROX_CTRL4				0x14
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_MASK		GENMASK(2, 0)
 #define   SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST	0x07
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_VERY_FINE	0x06
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_FINE		0x05
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_MEDIUM	0x04
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_MEDIUM_COARSE 0x03
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_COARSE	0x02
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_VERY_COARSE	0x01
+#define   SX9310_REG_PROX_CTRL4_RESOLUTION_COARSEST	0x00
 #define SX9310_REG_PROX_CTRL5				0x15
 #define   SX9310_REG_PROX_CTRL5_RANGE_SMALL		(0x03 << 6)
+#define   SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK	GENMASK(3, 2)
 #define   SX9310_REG_PROX_CTRL5_STARTUPSENS_CS1		(0x01 << 2)
+#define   SX9310_REG_PROX_CTRL5_RAWFILT_MASK		GENMASK(1, 0)
+#define   SX9310_REG_PROX_CTRL5_RAWFILT_SHIFT		0
 #define   SX9310_REG_PROX_CTRL5_RAWFILT_1P25		0x02
 #define SX9310_REG_PROX_CTRL6				0x16
 #define   SX9310_REG_PROX_CTRL6_AVGTHRESH_DEFAULT	0x20
 #define SX9310_REG_PROX_CTRL7				0x17
 #define   SX9310_REG_PROX_CTRL7_AVGNEGFILT_2		(0x01 << 3)
+#define   SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK		GENMASK(2, 0)
+#define   SX9310_REG_PROX_CTRL7_AVGPOSFILT_SHIFT	0
 #define   SX9310_REG_PROX_CTRL7_AVGPOSFILT_512		0x05
 #define SX9310_REG_PROX_CTRL8				0x18
 #define   SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK		GENMASK(7, 3)
@@ -1193,9 +1212,129 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const struct sx9310_reg_default *
+sx9310_get_default_reg(struct sx9310_data *data, int i,
+		       struct sx9310_reg_default *reg_def)
+{
+	int ret;
+	const struct device_node *np = data->client->dev.of_node;
+	u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
+	unsigned long comb_mask = 0;
+	const char *res;
+	u32 start = 0, raw = 0, pos = 0;
+
+	memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
+	if (!np)
+		return reg_def;
+
+	switch (reg_def->reg) {
+	case SX9310_REG_PROX_CTRL2:
+		if (of_property_read_bool(np, "semtech,cs0-ground")) {
+			reg_def->def &= ~SX9310_REG_PROX_CTRL2_SHIELDEN_MASK;
+			reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
+		}
+
+		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
+		of_property_read_u32_array(np, "semtech,combined-sensors",
+					   combined, ARRAY_SIZE(combined));
+		for (i = 0; i < ARRAY_SIZE(combined); i++) {
+			if (combined[i] <= SX9310_NUM_CHANNELS)
+				comb_mask |= BIT(combined[i]);
+		}
+
+		comb_mask &= 0xf;
+		if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
+			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
+		else if (comb_mask == (BIT(1) | BIT(2)))
+			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2;
+		else if (comb_mask == (BIT(0) | BIT(1)))
+			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1;
+		else if (comb_mask == BIT(3))
+			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS3;
+
+		break;
+	case SX9310_REG_PROX_CTRL4:
+		ret = of_property_read_string(np, "semtech,resolution", &res);
+		if (ret)
+			break;
+
+		reg_def->def &= ~SX9310_REG_PROX_CTRL4_RESOLUTION_MASK;
+		if (!strcmp(res, "coarsest"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_COARSEST;
+		else if (!strcmp(res, "very-coarse"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_VERY_COARSE;
+		else if (!strcmp(res, "coarse"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_COARSE;
+		else if (!strcmp(res, "medium-coarse"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_MEDIUM_COARSE;
+		else if (!strcmp(res, "medium"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_MEDIUM;
+		else if (!strcmp(res, "fine"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_FINE;
+		else if (!strcmp(res, "very-fine"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_VERY_FINE;
+		else if (!strcmp(res, "finest"))
+			reg_def->def |= SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST;
+
+		break;
+	case SX9310_REG_PROX_CTRL5:
+		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		if (ret) {
+			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
+					  reg_def->def);
+		}
+
+		reg_def->def &= ~SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK;
+		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
+					   start);
+
+		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		if (ret) {
+			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
+					reg_def->def);
+		} else {
+			raw = ilog2(raw);
+		}
+
+		reg_def->def &= ~SX9310_REG_PROX_CTRL5_RAWFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
+					   raw);
+		break;
+	case SX9310_REG_PROX_CTRL7:
+		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		if (ret)
+			break;
+
+		if (pos > 1024)
+			pos = 0x7;
+		else if (pos == 1024)
+			pos = 0x6;
+		else if (pos == 512)
+			pos = 0x5;
+		else if (pos == 256)
+			pos = 0x4;
+		else if (pos == 128)
+			pos = 0x3;
+		else if (pos == 64)
+			pos = 0x2;
+		else if (pos == 16)
+			pos = 0x1;
+		else
+			pos = 0x0;
+
+		reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
+					   pos);
+		break;
+	}
+
+	return reg_def;
+}
+
 static int sx9310_init_device(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx9310_reg_default tmp;
 	const struct sx9310_reg_default *initval;
 	int ret;
 	unsigned int i, val;
@@ -1213,7 +1352,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = &sx9310_default_regs[i];
+		initval = sx9310_get_default_reg(data, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
Sent by a computer, using git, on the internet

