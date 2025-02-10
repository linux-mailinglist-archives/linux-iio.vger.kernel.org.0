Return-Path: <linux-iio+bounces-15278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98DA2F2DB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7711166513
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5F2566EE;
	Mon, 10 Feb 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tik90vAc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002A2566C5
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203984; cv=none; b=q9Pu8ns1JyIGXhb5IUIi8JvVw5MpV1Tpm1i+Uo27NgARk/1IrlLJuC8+uat+aC8Nz9IQ5xVu/V+kLAtH714TC9zOUicwatB+Lpf2NeaoobSFMi49vHXr61L2UQOnXPepaSxdvHvS7CEdmS9l5atv0IcmXut22+F69JpgQMeero8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203984; c=relaxed/simple;
	bh=oXABJ0HRSJUsqBxjQdzjmuSA2Zskw28HlIrTxxdX42Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppFjjEUZtbVeEVxgBvuUHWiLnErNM6eV4s6RSovVjEezOMfDqSp+c+7gpfX6oQ5f2aEZz4vTGF2D+mLXj1z+wzFaUOdhe/wzhUklUWUzkfDsBUqqUozuRbTRvU5GHj7g3MLQT2g5P/W5gPI8TZceUPcC4mfz7VWIYGAp7vAAQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tik90vAc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso45439155e9.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203980; x=1739808780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyom0qjvxfr0PUA0BRn3wccZvWvBCP/teSac2W2vzoA=;
        b=tik90vAcy+RxqL5CV/R71IdcYZdoghkq6KHkA0ol1xpFDU+yc5Xms/E1J30sGUPQX6
         S5UPbiNNjY/idtUNiokvcy7qCBSeNCUDVbaQby2S1cbgsNQhSMPUL3Q60Lkd9U8X2KNm
         N9HAsPgClRGZ4c3O9ekS4A0u1Bco651eTuEpK+58cj0k6fHUuXsYzAkWSWTD1pEbrBq6
         iocfkHFktzlvkebERSz1Kd62GVM9XmPlzkEnFx4YDfzakwFta9BIPDqYOARQ4ogBqeYq
         j+0Ae/N8zJK2QbNxWudiITcvLEdbFdv6zNFdmTUIW/yK3Hgfi4RfD83O7noQ+iVR2W08
         8ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203980; x=1739808780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyom0qjvxfr0PUA0BRn3wccZvWvBCP/teSac2W2vzoA=;
        b=w0hBMZnvazBkHXTB1/yLKRkhdD/fooBSh3mmD6HRVEEjVUEroGR4rZ6OZVgsUT3icK
         4LYOU31u6i7h/PuEgGMn14vzWI7ll2B6Ka2dOiDjNMtamxZwesZR+wm+TtErBieg6lpy
         0GlGENHoyP95jZvJp7JO19nxHFnglqXzB+IfJFNFqkLA9ZL0146pud5sRt+NIJTxBGvr
         iEwNLznecBWhts2JuhXifDFI2LuE69wuSC6kEHjcTOc/yeK1KE1fP4pj+in/YWc6cKVB
         4yyrM0Sr6x2PcPc57dFqOKW6cJI/ZQfcZQYZyLdiSDQujmwLNRKl5CAOSh/I7p/Ni3iK
         h8cw==
X-Forwarded-Encrypted: i=1; AJvYcCU/1UsJ/0UibZ9phBOjG7C7+TqNiOZPxlxvIR6jWcVE8HXoHCmot4AuLiI1lv9e7M2Sus6uTphSwNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUwXbsN2vb0LVfEKbniml/2zpEssMZwrDAKMjoy7F+z+uGLfE
	kMUXWIxA0E/VfaMrwVjWWYW/YDPsIuxxll4d37V3AJlgQX8ipqSdum0PdIaghTY=
X-Gm-Gg: ASbGnctY0UcrVqJHrczj3UGwWcE5htnNBEg60Xjnf11ktTkFMsmq6x7BZTSNfniPqTV
	EDABjJNBgfTeQcuH7SLvRv9D1K293Wt2nKVS3oGcJ8A87vk72Lx1uE72xzj30SpPPTZ3JAtzdoH
	57Z1BvLo69JP/BT10iuEJjBZR5j+oKguDdH2RyGl83aGQnbgHN49V1wC7JBN2yoGcKFHqBwv1as
	WpI06hCTLR4+7CBoAWHP9Gimp2sLMAL5JE27KkFp3GaRiJbGqwUKcGMmLsyBE62Ze3Qx4HCSRSv
	USloj76cvaRY3/dk814WioHRbAsIeqRyVz5WI/JNf1C2DBHoYxMMzqqZxe8kYJA=
X-Google-Smtp-Source: AGHT+IFHtByCSdx1O2bm7wTfO3oeSSWSD9kC3YKcmPVh+qEYF/LbA5lZmoVVo4nuzwDXSawJXU4XQw==
X-Received: by 2002:a05:600c:3c84:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-43924991e0cmr117634675e9.14.1739203979907;
        Mon, 10 Feb 2025 08:12:59 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:59 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:59 +0100
Subject: [PATCH v4 9/9] iio: adc: ad7606: add support for writing registers
 when using backend
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-9-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Guillaume Stols <gstols@baylibre.com>

Add the logic for effectively enabling the software mode for the
iio-backend, i.e. enabling the software mode channel configuration and
implementing the register writing functions.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.h     | 15 +++++++++++++
 drivers/iio/adc/ad7606_par.c | 52 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index a35b526f3915..71a30525eaab 100644
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
index 64733b607aa8..335fb481bfde 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -19,6 +19,7 @@
 #include <linux/iio/iio.h>
 
 #include "ad7606.h"
+#include "ad7606_bus_iface.h"
 
 static const struct iio_chan_spec ad7606b_bi_channels[] = {
 	AD7606_BI_CHANNEL(0),
@@ -31,7 +32,19 @@ static const struct iio_chan_spec ad7606b_bi_channels[] = {
 	AD7606_BI_CHANNEL(7),
 };
 
-static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
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
+static int ad7606_par_bus_update_scan_mode(struct iio_dev *indio_dev,
+					   const unsigned long *scan_mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int c, ret;
@@ -48,7 +61,8 @@ static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned
 	return 0;
 }
 
-static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
+static int ad7606_par_bus_setup_iio_backend(struct device *dev,
+					    struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int ret, c;
@@ -86,9 +100,39 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
 	return 0;
 }
 
+static int ad7606_par_bus_reg_read(struct ad7606_state *st, unsigned int addr)
+{
+	struct ad7606_platform_data *pdata = st->dev->platform_data;
+	int val, ret;
+
+	ret = pdata->bus_reg_read(st->back, addr, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
+static int ad7606_par_bus_reg_write(struct ad7606_state *st, unsigned int addr,
+				    unsigned int val)
+{
+	struct ad7606_platform_data *pdata = st->dev->platform_data;
+
+	return pdata->bus_reg_write(st->back, addr, val);
+}
+
+static int ad7606_par_bus_sw_mode_config(struct iio_dev *indio_dev)
+{
+	indio_dev->channels = ad7606b_bi_sw_channels;
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_bi_bops = {
-	.iio_backend_config = ad7606_bi_setup_iio_backend,
-	.update_scan_mode = ad7606_bi_update_scan_mode,
+	.iio_backend_config = ad7606_par_bus_setup_iio_backend,
+	.update_scan_mode = ad7606_par_bus_update_scan_mode,
+	.reg_read = ad7606_par_bus_reg_read,
+	.reg_write = ad7606_par_bus_reg_write,
+	.sw_mode_config = ad7606_par_bus_sw_mode_config,
 };
 
 static int ad7606_par16_read_block(struct device *dev,

-- 
2.47.0


