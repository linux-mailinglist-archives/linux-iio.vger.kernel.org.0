Return-Path: <linux-iio+bounces-13313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF619EAE9E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7147E188A065
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B122E9FF;
	Tue, 10 Dec 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2pJDdQ8e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFE1DC9AE
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827616; cv=none; b=ElFv8E1+CUz3cY4d87oXUbpdtB7bEBwVKvMv9DUPOsXsCWFkpwZFe9SsGUxd6m5TkRgyUA+L+4QbvQphP+AW8InsmZgL3lxnQGNBteoXDQIkbvaitS7vAVo5w3sgu6e6Of05K/7F2Uf9h/S+2yFFe6UEyZBsBIneR6Z945Y4Oks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827616; c=relaxed/simple;
	bh=0DaB6GUhAdZIbGZ7qGgEv5Jwt3U+pqBjdF0vztCbme8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAP7uM7X8jADhligynIjyTLH7PWngJrjH+Rlhfw0CqpVMvpxIPedME3eTBizF2oo/d0XR7j27qa37Q27yIuZIYv5TIdBSUo7T4DED3TYqC+hxMZlEdDISFTL7ixnpp44pHfVdfMDOkJA8TivQVONlH2RJLgarKEDK6mHxFIflaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2pJDdQ8e; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-432d86a3085so35679115e9.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827612; x=1734432412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk9n1VymhG4ZV35K+M94OsGqPvBpEPYOxdxmDZ1OOhg=;
        b=2pJDdQ8eIOTDmxXZ+mhaWVPYjuxVUZgYdHQiYJ5CYFsW45ud6hQ+bdUHNq6I01LyBn
         4skFKJx74QqPk/olI+GlglaO+uqxucpSnicAT8TRWlYt2NTRSPXGAX3y/hgxKuMtl1jn
         l7wdh/dfvZD7563ttR2uQc79YsI6PEjbGUp1dpBxOzUr/TwMi5hayFmEcA8ltPSY9apR
         Gxaum+0woegNmYjqFB3w0Hc4S+Wcp3SHPVb+bCio2bK7c0IDBIBvUgM3dgW8gOF9S/mT
         Z/DHBoaZa25Tn2+mtC3F2y64NMoMZ0fRwz9VYS9f/eK5mLAi8wAkA/CIaWeTDwi5gkNa
         lY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827612; x=1734432412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk9n1VymhG4ZV35K+M94OsGqPvBpEPYOxdxmDZ1OOhg=;
        b=XSv1/V2s1ZIsypLATtaUZwuYZBC85mwHdFLWc1PKPAwgN/DB/j4qHa7/fKyGVt8vdz
         S+JlomdpD4Z0DbPJ2EYX5fvJ+hLHJeRLaaxOibzIJ2XcRSMHhEywOrNrv5iqXTqbe8lc
         hIJRDxUrt9iRHPmebkxaH/9iF/FDcKRV4RxeffNMrzW5KbvHPbt6CEV9Qe8oAcnq7mTV
         BpKuj6J77o1UzoX1Yy6JpHJkOuRRgpakRUW9NTvB9U7ESsGERgV7VXaA37CELV+aZcRR
         Vq0hjS/WdYjaiuCnpenZ0M2i5vHNZ6NdqoiZn6mfbKP3v/M/bIgWNfigALPSI7R+q0fC
         60oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTua59ArW4j2pEsDwacQCNVm+p9h/9Ce8+L9m9nbA7JKAouQ/Ue+mVGdk8FwKwzY20WZAg2xeFLJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDh0zjF1V1vzp1SOWQJ+FjPdoqIA/bhsq5omoZMAP6fZZCsP9
	nmaGCU0lNId4rAVqgB8xiuBatBx5a7JQEvSRbByxji1bBtl8/WlyQeBzkJMpvF0=
X-Gm-Gg: ASbGnct5NqPDGGPLDeH1vL/tWHC9qKtBl1jP6rBKi3G6+KTRwNvH/GdQ8zfLyZEoDM8
	ZiYZpX95sDCdq8sbnkazeY3SIYCP28YUgq3nlrTva6n0/rjeuoX0OqD9dHw/IDUZL85KstcxHGH
	07tatz7rQ9oWc5DvLaPYfUwmImaS8+qM/lj9JX1WBBrV/iWWBZ9j6pbHOP0j5HJZwpJ07E2G6Fo
	RT6Ujd8a0jbtwPpbuLh3u+uV0Qvkte1dnxdTbZ8IPizzPhVnt2wvCcF6TKL41ekwQNovdKw8dnH
	ZQ==
X-Google-Smtp-Source: AGHT+IFRt/sdCCdt7tSEIFGCdb9yGqIAORx1RhwLt3cYiSuMkmIfx3a6UZbP57Cj+XHv11sGUmRDiQ==
X-Received: by 2002:a5d:584f:0:b0:385:f1df:24ea with SMTP id ffacd0b85a97d-386453f69d9mr2896671f8f.40.1733827611877;
        Tue, 10 Dec 2024 02:46:51 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:51 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:49 +0000
Subject: [PATCH v2 9/9] iio: adc: ad7606: Add support for writing registers
 when using backend
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-9-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=3756;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=0DaB6GUhAdZIbGZ7qGgEv5Jwt3U+pqBjdF0vztCbme8=;
 b=gEIvVwbhrXDeyaZABlBonAmGn84SE5hpsvXKnT+vORvDnqx0Z6zNTjnCRiYqsAota1JS8e1Bi
 q+HCIlVvtLMAW5JB1GpDt6qaVTT8+Tmrc9HLf0S4wuIiw06n/Qrp+ff
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Adds the logic for effectively enabling the software mode for the
iio-backend, i.e enabling the software mode channel configuration and
implementing the register writing functions.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.h     | 15 ++++++++++++
 drivers/iio/adc/ad7606_par.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index ada8065fba4e..9da39c2d5d53 100644
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
index 64733b607aa8..c159cd4f7802 100644
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


