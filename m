Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29928562B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgJGBRz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgJGBRp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:17:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E07C061755
        for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2020 18:17:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so317346pgf.12
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2020 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0grO1/LPC39zD9/uMmlQwrmk7dyJY/6UPRijWFp5DU=;
        b=DwAXRI8VrMz5z37j30Xsto7xic7Bh+bbl0UOI//b5d+NFKMXiVyQGZlAZ4yL5WS/1s
         13AVVhf6vI0jtlrrvP/HS16s3vKmauOfL366oReuvTdguygMM2duFUiwPX7dcGNTCsCb
         2ksJfXtVV9+0cCEFcitGsp9nWna9a2VyySn9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0grO1/LPC39zD9/uMmlQwrmk7dyJY/6UPRijWFp5DU=;
        b=RLfDM+t8y0NuPDi8fWjJZ6llB6lg0y5hFw2cjUjqAQ7Y552ko15CUs3G40Ln1ZCIwR
         kRXwafchXDc47Jvzxw7sr8HG5F2M2yOg1s90i6qieM+PMS+6thiF37lL9SbUeEOdpxXK
         hnmISUfabw67tJX97xWOItAHMnbOuyfI+5C0AAX9VQLuF/nfRlPJRHfub6WQ6Yqk+aXy
         0d+qMLSZyQ7xVSOOhHgSSEA0KHyuMXadeubqANq74677synkKNo9r61KFUmXXguWRlFb
         utXfAEpx2jp85jQJygrKN/0Aq0iB1xuaOc18+Lf9snig7oTkbaTr+8hk2ckiPOX90iAo
         ZuUQ==
X-Gm-Message-State: AOAM5305a8iacsJMHffYD4AZEwC7ZWifzwmDVNtfdXQ8ONdMj8At7d4H
        DfzkbN1GjhzOl2TheujLqKRtzw==
X-Google-Smtp-Source: ABdhPJzvP6pmCV0CHzjkMIN3vZmFolozsxfx8647zKjG5uTT3wwlPNTf9ElCwr8w8UDAR+GXZDJMBw==
X-Received: by 2002:a63:4a43:: with SMTP id j3mr867356pgl.42.1602033465479;
        Tue, 06 Oct 2020 18:17:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:44 -0700 (PDT)
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
Subject: [PATCH v3 6/6] iio: sx9310: Set various settings from DT
Date:   Tue,  6 Oct 2020 18:17:35 -0700
Message-Id: <20201007011735.1346994-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201007011735.1346994-1-swboyd@chromium.org>
References: <20201007011735.1346994-1-swboyd@chromium.org>
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
 drivers/iio/proximity/sx9310.c | 125 ++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 3f909177eca9..23aa235ac2b6 100644
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
@@ -1193,9 +1212,113 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
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
+		pos = min(max(ilog2(pos), 3), 10) - 3;
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
@@ -1213,7 +1336,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = &sx9310_default_regs[i];
+		initval = sx9310_get_default_reg(data, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
Sent by a computer, using git, on the internet

