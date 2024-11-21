Return-Path: <linux-iio+bounces-12462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F89D4AB4
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 11:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2644F281766
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D831D7E4C;
	Thu, 21 Nov 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DykALw7/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2F1D4324
	for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184318; cv=none; b=qmxFTJhxwGf8s9Tlg5G7gTDOhQBXgIolQUZW7Dwh28+oZFdPDWgXktL45Etv1O0QCS1eYmCopYMBMftVXHlhM74gDnksMuD7YIIrHDyxDSLsFo73tUapmGZ7rtHh7oihbv1gW5VLtkn4nuRTvIAzDs/aDB5Hsz3PB0QZHBgfzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184318; c=relaxed/simple;
	bh=tdpf/A32vha/ko+aQ4RiDlCU44C08sRlPZcE4GA5DLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqOAAXJDCEqVbJ5hhcIEWmXhhPW5FpZ4xfdRxR8bDiLHgM/A6SRJDSwR6iFxYFq2bF+Od+rkZ1mszc16OvtrzXKOrHDFTAldkLFUiuj4kHryV1M93elicHM8sluysMT70l5wpsyg5wxLye8oReTh/COBm8FfANd9BWXKoAmdQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DykALw7/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539ee1acb86so722123e87.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 02:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184314; x=1732789114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRi3cIGaDlxTwStqxhJi+pjnXvvxLtR6kDzgcy0nvWU=;
        b=DykALw7/frZ4guuLjcJy3QLI27TsYnjlBF+Rp26TY0HOr++EB8A492iHO1HMMlSuvT
         ECioZDo0EtB47ArSfNy3Zx5MshJwOPADKbwjk2cbjbAp/desRpNEeZJPBcWMPkonU1T8
         CbhWyz8VXpbY/rv71T/7rulwOffJfYoj0lG+84JavTWxa5c4ayfPkBYUD2mO82WKryWz
         KW8wNahBNtUVMRkSLoAtMjOlOKPfqrU27gkSAXTy6igFG+vo+XTHISimcw4SefuRc7M4
         oJYG+mPGTna0hDTAS6vVWp+F/4Dc/M/VbVbNroocfbl2A4mezBpT8cmOJHcGIPk3PzsP
         zf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184314; x=1732789114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRi3cIGaDlxTwStqxhJi+pjnXvvxLtR6kDzgcy0nvWU=;
        b=SAU38oSg/acQmKrykp9oZ//g8GPe9Zfusqa2mF8wCLZ7ALkLbHp4GzOMbtSwc8QuCw
         3bBk1YueYPhJqiJh4iA8CrhEORGNwJsqvChlCccGDaHj400ub2qsfdnYCu5oipOgKliZ
         vfwoYUUUjSwQ+tbKWHacOPa2ROOw3ufvJIeLyPnnvkNwoWuhrdUPtkpA5M0efAwItGL6
         pofSH0aYCHU7lvsIYd60BAPcFqWs3FS1yljrteXj67m95qNb9iYOK7PwgxMfqLvZYRo4
         d3UR/qNPQ3a9d8e+eiMFDg2hnKaSOdhRQJPcMtJsvECYsETJp/w2ixaP2VoYFlABNOZh
         +Vxw==
X-Forwarded-Encrypted: i=1; AJvYcCWlUvymAf5zg6BZfjs5xXnMnjrU8Swg3PqCgoM4B9vR2QmJ965MVNiKgpABFrk9XjdWKywy+qwYZCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+NHuKYB+UVFQqipA8Ph4T51qxgDG6hoyWZBJ2DdulhPrBane
	7f9idB8XK0Zt7eKDBMtH/YByegTniwuS6rQKoBq2MkmM0P+K89QFBjEWs7Wc0Y4=
X-Google-Smtp-Source: AGHT+IFd0X5sd0gLrWTrdWHzSVGz3bjzzQ0tWK2LA5BLwCGIn3GL8B7rGGMHcyvlWsAO9re9qR5F2w==
X-Received: by 2002:a05:6512:53c:b0:53d:a309:7fa3 with SMTP id 2adb3069b0e04-53dc1368c75mr2424566e87.41.1732184313217;
        Thu, 21 Nov 2024 02:18:33 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:32 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 21 Nov 2024 10:18:31 +0000
Subject: [PATCH 9/9] iio: adc: ad7606: Add support for writing registers
 when using backend
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-9-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=4035;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=tdpf/A32vha/ko+aQ4RiDlCU44C08sRlPZcE4GA5DLw=;
 b=IG8R0F6BS7ExulQfzVIBxrGS6fS4qof4AM1NKLiCQyCH0n6OvosUfzcczsrHesp1cJt3Lyfo+
 apRxWf5SaiKAiTV14WHE7FXNgmJPpz53QR3HGCdb4Gc/yULdOclYON/
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Adds the logic for effectively enabling the software mode for the
iio-backend, i.e enabling the software mode channel configuration and
implementing the register writing functions.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.h     | 15 ++++++++++++
 drivers/iio/adc/ad7606_par.c | 58 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 74896d9f1929..a54dc110839f 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -96,6 +96,21 @@
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
 		0, 0, 16)
 
+#define AD7606_BI_SW_CHANNEL(num)			\
+	AD760X_CHANNEL(num,				\
+		/* mask separate */			\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask type */				\
+		0,					\
+		/* mask all */				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		/* mask separate available */		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask all available */		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		16)
+
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index a25182a3daa7..0c1177f436f3 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -13,12 +13,14 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/types.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 
 #include "ad7606.h"
+#include "ad7606_bi.h"
 
 static const struct iio_chan_spec ad7606b_bi_channels[] = {
 	AD7606_BI_CHANNEL(0),
@@ -31,6 +33,17 @@ static const struct iio_chan_spec ad7606b_bi_channels[] = {
 	AD7606_BI_CHANNEL(7),
 };
 
+static const struct iio_chan_spec ad7606b_bi_sw_channels[] = {
+	AD7606_BI_SW_CHANNEL(0),
+	AD7606_BI_SW_CHANNEL(1),
+	AD7606_BI_SW_CHANNEL(2),
+	AD7606_BI_SW_CHANNEL(3),
+	AD7606_BI_SW_CHANNEL(4),
+	AD7606_BI_SW_CHANNEL(5),
+	AD7606_BI_SW_CHANNEL(6),
+	AD7606_BI_SW_CHANNEL(7),
+};
+
 static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -70,7 +83,7 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
 	if (ret)
 		return ret;
 
-	ret = devm_iio_backend_enable(dev, st->back);
+	ret = devm_iio_backend_enable(st->dev, st->back);
 	if (ret)
 		return ret;
 
@@ -86,9 +99,52 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
 	return 0;
 }
 
+static int ad7606_bi_reg_read(struct iio_dev *indio_dev, unsigned int addr)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int val, ret;
+	struct ad7606_platform_data *pdata =  st->dev->platform_data;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		ret = pdata->bus_reg_read(st->back,
+					addr,
+					&val);
+	}
+	if (ret < 0)
+		return ret;
+
+	return val;
+}
+
+static int ad7606_bi_reg_write(struct iio_dev *indio_dev,
+			       unsigned int addr,
+			       unsigned int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_platform_data *pdata =  st->dev->platform_data;
+	int ret;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+	ret = pdata->bus_reg_write(st->back,
+					addr,
+					val);
+	}
+	return ret;
+}
+
+static int ad7606_bi_sw_mode_config(struct iio_dev *indio_dev)
+{
+	indio_dev->channels = ad7606b_bi_sw_channels;
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_bi_bops = {
 	.iio_backend_config = ad7606_bi_setup_iio_backend,
 	.update_scan_mode = ad7606_bi_update_scan_mode,
+	.reg_read = ad7606_bi_reg_read,
+	.reg_write = ad7606_bi_reg_write,
+	.sw_mode_config = ad7606_bi_sw_mode_config,
 };
 
 static int ad7606_par16_read_block(struct device *dev,

-- 
2.34.1


