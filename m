Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8607AA0B1
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjIUUrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjIUUq7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:46:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D420057B0A
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:27:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9338e4695so20607591fa.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317275; x=1695922075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZybWEnlutF3BnUcq+xH7uoi35RICanW/277eMaA8Sc=;
        b=z4UObxiJhlLbYiUUrbxfXUQG0LeHK7WW/VL6d/4i7+tzfNzTL2WsrHjqIKYe+fn//i
         GQzKc0Xuje21djsIBDxtgKnacuKm3rvtnF44et7TUs1X4x29QCx4ajMWU1uCsYHlop/G
         LhyPSKX5Pe7eXf1mPOEEx/nvfKeRk9LwE72KEPPpBGvDufPqtwwitEOyhWTFIFeDBaWb
         8xW+kbK3kTUmWeACnR30a3WDxm92Jr2YN3m8bves1WtQoYbBBuK8ZDTvKv7I6TFCZXgG
         C8XtibY8muC3zfKNd5nIt4LK0qIy3x8xIMicegVCjJ9vZBD3T2oL/mn8lljsVDD49D3K
         atZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317275; x=1695922075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZybWEnlutF3BnUcq+xH7uoi35RICanW/277eMaA8Sc=;
        b=sELymDzlPBAtpkGjAYdXIy0JGr2NqFSHrveT8ZXu/2BEFEP3Ay0O6jMleQTubz2qeD
         MtJGd3HMFtbqXCyKmG5VLCyPR26ioH+RCL+v5DmyO2BcX1KO9TnW/MrI7uq2LKSoIT44
         y1g4BADLkYoHlm0a5F8snl7G9JKWBhS0UmtMjYH7DJvaw5IGkeapit115MmIFTDlBKkx
         d0A6azToLErbvjK1aZMxvv/d15VoH5y+xver0giqos57Ji4UoKTftegQ6jTu2w2wbjr+
         bLNLOrx6LUNuUQkHBrYG3ej/6j0xGW/Gah0OYOJq77+ZoK6qXe1KViQ6JYV6LDoUw758
         wFSQ==
X-Gm-Message-State: AOJu0YxU9fjOZyZCn/jIztc+0a47UK/KLt8Kwwnpt0YJxnWaaB5Cwz09
        fRQ1aXjO6D9UcViZgdwhb12pYtAignVup9y//qyc75mB
X-Google-Smtp-Source: AGHT+IHJfqFR4DsaCVjmdv+KrypDdY1GIjA81595SeWzOf30lcIqONwMBeav7UdV/0Pikd2g4z/zFw==
X-Received: by 2002:a05:600c:2312:b0:3fe:d71a:d84e with SMTP id 18-20020a05600c231200b003fed71ad84emr5046284wmo.1.1695307464020;
        Thu, 21 Sep 2023 07:44:24 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:23 -0700 (PDT)
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
Subject: [PATCH v2 13/19] staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
Date:   Thu, 21 Sep 2023 09:43:54 -0500
Message-Id: <20230921144400.62380-14-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

