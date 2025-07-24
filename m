Return-Path: <linux-iio+bounces-22006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D461B11479
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 01:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF8BAC27B6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 23:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09832243956;
	Thu, 24 Jul 2025 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TZSTRtdQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040792417FB
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399564; cv=none; b=ggOhIEWXZ1OADNlJHxZug5Nz+OJ6NBtwuRma8k2W5wD/5EMXvZX+1K7rCuCdwFXcNj7s+4Mpt42LaRsPSsSMGPj5bCUutuPbwp3GxSki0E/18ngtRYym+jWvCXVHQnMbL9kW7lB9ovPj6SPRfaE9RJ7F0hvmGc++60c4q3I1m/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399564; c=relaxed/simple;
	bh=fmzrk3rncQ2eQJPl7/ykSHqygcx2eIUuyWJF71tkk88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CwGiyhBMw3txoyqSyld/rhYUS3uonA8ee0U5/otYQ8X5RS9plc7R/oEkWIkjYMCOZQVCNM8k3XeTkVA5jBL04etbOQTFv5Q0dAOax+pSNc7Ss4YHgODQYM48AeVDDZNiPi/CeW13OxuFTNEE/oK0ze25AEf0Mg27V9zm3gEMNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TZSTRtdQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e57751cd9so412210a34.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753399562; x=1754004362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlq3slX2bsUlFc85XSNMVLB7rlXT9FRFe+4IGTFjGSM=;
        b=TZSTRtdQKFHFSJoUdjKep2Xy1DFakfvjK0C8VCYAeJUqCLJLHX0023CnANwrRx/4BQ
         wDTAqzUGAKBRGropeOFzCoPgu/wpwX2Pk6V2aiYM01VIiB3kREMvufdfFHp5PN7Lx2v1
         ICjtWiN1AJLAM2qNbD+0HKW+aAllgTDuS4mT7RJHSwHPb8LYLh4xW3H0Ebs1KTRq3He5
         Yq493ZmY3NO8c3E8SpfdLv/4icPtohqyBOoMXhFpZSXflmulTL7tZvFRTeHkDf3gCw0W
         1Hizejj6shyG8hjknzFQiSM0RCatmm54K6T+4eY8zmXaHi9F1jkBkURuuggW4UgModX8
         c4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753399562; x=1754004362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlq3slX2bsUlFc85XSNMVLB7rlXT9FRFe+4IGTFjGSM=;
        b=Qzv66PG/dRvaOU2IPpp+AFYxJOnAg7BKIwM9lzymYFRCTITCbGZ6FtMiE8W1jdq+Su
         dsh5RrhdzXVO4OqvCdtuK1rYJI9oUJOm9VYObUSjc8R8Cj5nT1qzZ+2K+wgnxJ4pU2Tw
         ZFtS8S5DYt12xaoius0ifqEiYn3UOJkwdIuz9Jk2CWZidLnonuvidrctHuOAbh+s/E/I
         WmgZTafnTXfPqgcY8gqLSe4z4UXqmx+zwwwlG1h5hijBkDLyXbmD3PV0BZZ9Kxr9Nnby
         Ai38mW6wUNL3EXYNA6rIzdkEvcMEUf2TMaWyi2THpz4WPJdQ4wEaKnyGVfc4tkj3NmQ/
         7h6Q==
X-Gm-Message-State: AOJu0YwHfOZl3JuHTy26JCViC8PxE9hLgIuObFWBoYWE9o3MuGCsxTNn
	u4RkOeHYhKamgSOX05GQmW6tilvzZ/T82wP0tUwCRIChvhIrUH1QavnnQinc3DJzqeI=
X-Gm-Gg: ASbGncs8UmbGose3ol5CpicQ/ZDssqHTn+OOygtMrz88Y5aGuZltS+9/3bexlynoDio
	ln6Z+3SX8JAOl1t6TuaF50dDDPGrwQPoDRyW/lD1ZborQhCE2yuJq4BedK4g5HbE6QacQ83/X/a
	naxT9rmhtBZlK564KkETsLSTZMlStkAEMQ918JnHc/wTROuTDvQ590HA2+Qi8ti3Bz836OCIC+q
	x18ygWTvxXMUX1l0vAIzU5kyboSOIDETD2f4HG4GSbC8K2vwUQYTnCa+DlwGX7aTKFHmrcR59lR
	zUYomO9FDKij5WRcuxb0uvYNzNvegEMTwkHJ8FC3eFdFO7MjaLGFyJditEPIVi720AFnJcAEqqY
	2o2/m1nVFNAuCM+TxbImg4Rma5w==
X-Google-Smtp-Source: AGHT+IGXTeHfeTVdmPBOo1aDwZVmbv/cw0ywKYUGitHn1VBq90zI7BwPKf14+Skvya3y6GRy/CD8LA==
X-Received: by 2002:a05:6871:e2:b0:2d5:2955:aa6c with SMTP id 586e51a60fabf-306c72cce28mr5986875fac.31.1753399562041;
        Thu, 24 Jul 2025 16:26:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:337f:e3bf:e9d2:b3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e3971332sm689626fac.0.2025.07.24.16.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:26:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Jul 2025 18:25:24 -0500
Subject: [PATCH 3/4] iio: adc: ad7124: add external clock support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-iio-adc-ad7124-proper-clock-support-v1-3-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fmzrk3rncQ2eQJPl7/ykSHqygcx2eIUuyWJF71tkk88=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogsD5s1McE7kRUhIIogZWzaUMIjXrjyhzmcgAj
 +M7x5Yx7F6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaILA+QAKCRDCzCAB/wGP
 wPVkCACawH5RuJizqdWBRyp6wOto4jBK0NiQjllUY5OLK3zasHiNJXwem8MGPlOgbBwgpkC7vE+
 fQKJx3KYe66Y1dzsa40poFOtsAuKTMFt180/U5o+K5mFYrmIxy444hQKs2NRj0hg2EJSfVxBSr8
 kEskDVwdm6WDeYef+E6Fw2eePTtA7VTg1rdYs1yeDhGxl9GDPcHmEnYTynSr54Va7Qy5gSQiQXt
 +xbVWxpg3BeKIBwuPerIwB+sFSvoZpzJh4bJl702OgzM5mPVqbrXTHnhjwR6zFRkv3/rzbtJl/b
 vnbHxDtn05ZIgnL7ZlkKY5FsNfVtIuQgWDlJ8A+AVAmPnCTC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for an external clock source to the AD7124 ADC driver.

Previously, the driver only supported using the internal clock and had
bad devicetree bindings that used a fake clock to essentially select
the power mode. This is preserved for backwards compatibility.

If the clock is not named "mclk", then we know that the devicetree is
using the correct bindings and we can configure the chip to use an
external clock source rather than internal.

Also drop a redundant comment when configuring the register fields
instead of adding more.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index f587574e8a24040540a470e13fed412ec9c81971..b0b03f838eed730347a3afcd759be7c1a8ab201e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
@@ -44,6 +45,11 @@
 #define AD7124_STATUS_POR_FLAG			BIT(4)
 
 /* AD7124_ADC_CONTROL */
+#define AD7124_ADC_CONTROL_CLK_SEL		GENMASK(1, 0)
+#define AD7124_ADC_CONTROL_CLK_SEL_INT			0
+#define AD7124_ADC_CONTROL_CLK_SEL_INT_OUT		1
+#define AD7124_ADC_CONTROL_CLK_SEL_EXT			2
+#define AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4		3
 #define AD7124_ADC_CONTROL_MODE			GENMASK(5, 2)
 #define AD7124_ADC_CONTROL_MODE_CONTINUOUS		0
 #define AD7124_ADC_CONTROL_MODE_SINGLE			1
@@ -1112,7 +1118,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int power_mode;
+	unsigned int power_mode, clk_sel;
 	struct clk *mclk;
 	int i, ret;
 
@@ -1155,9 +1161,41 @@ static int ad7124_setup(struct ad7124_state *st)
 			if (ret)
 				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
 		}
+
+		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+	} else {
+		struct clk *clk;
+
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk), "Failed to get external clock\n");
+
+		if (clk) {
+			unsigned long clk_hz;
+
+			clk_hz = clk_get_rate(clk);
+			if (!clk_hz)
+				return dev_err_probe(dev, -EINVAL, "Failed to get external clock rate\n");
+
+			/*
+			 * The external clock may be 4x the nominal clock rate,
+			 * in which case the ADC needs to be configured to
+			 * divide it by 4. Using MEGA is a bit arbitrary, but
+			 * the expected clock rates are either 614.4 kHz or
+			 * 2.4576 MHz, so this should work.
+			 */
+			if (clk_hz > MEGA)
+				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4;
+			else
+				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT;
+		} else {
+			clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+		}
 	}
 
-	/* Set the power mode */
+	st->adc_control &= ~AD7124_ADC_CONTROL_CLK_SEL;
+	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_CLK_SEL, clk_sel);
+
 	st->adc_control &= ~AD7124_ADC_CONTROL_POWER_MODE;
 	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_POWER_MODE, power_mode);
 

-- 
2.43.0


