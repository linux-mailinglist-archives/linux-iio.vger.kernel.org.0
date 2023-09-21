Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3E7A9E30
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjIUT6l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjIUT6Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:58:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7C2D231
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:26:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so1531227a12.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317202; x=1695922002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZybWEnlutF3BnUcq+xH7uoi35RICanW/277eMaA8Sc=;
        b=hExfSzeGdtxiUjEsl0W+5T27uSaea2hs6eqJVUoK8qa+gEEtH8airvhOZaI9m+o63H
         OXK8euyoF006N0sIhpn3Dnxf316GO4S72bxRUv+ZKdGwgQegmLb3fRrbMjco4x6SmiwT
         TUdW8Ng/DEJEI119GtLvpbHVjzeMIhLq/Bm+t0iQxmEpiCwy9KCa4Pknc1V85q0b4rcN
         h0TAA/7nWNhIIcasVVJC1Pb9wCiKA90YW0U4D9OOTUcIujbuUCV0UkMIhNnPpq1eT/4P
         ZiUV2RgKsYKNktKevsb9KCZ5UnRrtJ4t3hECNPm+7Ov7vizniCr/ZBfh7GHO85C/38EI
         s08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317202; x=1695922002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZybWEnlutF3BnUcq+xH7uoi35RICanW/277eMaA8Sc=;
        b=M+WP5W/DdM7vezTw+McCy3F9YGzSy/SEtu53nNOw/JWtrAtzFiL6SYUP6/VFGT/KDf
         A3u3abF26XyGkZAmx5eJbA9PxlNVWOwVMx6iLMOVXPRJ5X3C0tp5EZ9VEKYEAog9GzcI
         xSTciyCL7OualalUNBqap2hcxHILmISzdO3XVsbw7HgvHSPL0ACKFXxuf62gZ/GS22BR
         FUf48QkAW+MTdqBrfb6gKM0hKPPgkVSTv5FhJDRcDobHqW0tsJoFyqBNCS8RiykeodPK
         kHkqbTYOx57Mk4IOfwaKf9qAyeH7fQhrnIDTJZpLpYy84+bhXp5GlYTe/sJNw0ZO9eQ5
         OSfQ==
X-Gm-Message-State: AOJu0Yyiy8HLxDWFpeLQfpnjcuzGp31JEG0cryOtwk5Mw6Gbs9m2sPfH
        TUOdNZI+ZxpK3L/r2nkxBEDLGNRkX25m/q5CR5keqsid
X-Google-Smtp-Source: AGHT+IEc+ToK/YlPl4OhhuhcmW2i+TTG/k1yEvY4gVlKSX7pGRedYf1SANoITpOQbOK/u1re+CP3BA==
X-Received: by 2002:adf:f68c:0:b0:320:b1b:86a9 with SMTP id v12-20020adff68c000000b003200b1b86a9mr5129294wrp.24.1695306163828;
        Thu, 21 Sep 2023 07:22:43 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:43 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 13/19] staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
Date:   Thu, 21 Sep 2023 09:19:41 -0500
Message-Id: <20230921141947.57784-16-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD2S1210 resolver has a hysteresis feature that can be used to
prevent flicker in the LSB of the position register. This can be either
enabled or disabled. Disabling hysteresis is useful for increasing
precision by oversampling.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 88 ++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 7a1069d948eb..fe413759deb9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -80,7 +80,6 @@ struct ad2s1210_state {
 	/** The external oscillator frequency in Hz. */
 	unsigned long fclkin;
 	unsigned int fexcit;
-	bool hysteresis;
 	u8 resolution;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
@@ -456,6 +455,27 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			mutex_lock(&st->lock);
+			ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
+					       AD2S1210_ENABLE_HYSTERESIS);
+			if (ret < 0)
+				goto error_info_hysteresis;
+
+			*val = !!ret;
+			ret = IIO_VAL_INT;
+
+error_info_hysteresis:
+			mutex_unlock(&st->lock);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -464,6 +484,64 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad2s1210_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type,
+			       int *length, long mask)
+{
+	static const int available[] = { 0, 1 };
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			*vals = available;
+			*type = IIO_VAL_INT;
+			*length = ARRAY_SIZE(available);
+			ret = IIO_AVAIL_LIST;
+			break;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int ad2s1210_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			mutex_lock(&st->lock);
+			ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+						 AD2S1210_ENABLE_HYSTERESIS,
+						 val ? AD2S1210_ENABLE_HYSTERESIS
+						     : 0);
+			mutex_unlock(&st->lock);
+			break;
+
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
@@ -499,7 +577,10 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE),
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.info_mask_separate_available =
+					BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
@@ -573,6 +654,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
+	.read_avail = ad2s1210_read_avail,
+	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
@@ -689,7 +772,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->hysteresis = true;
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
-- 
2.34.1

