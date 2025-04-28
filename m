Return-Path: <linux-iio+bounces-18755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC28A9E89C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBB1897225
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3001DE4E5;
	Mon, 28 Apr 2025 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM6pBg3p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73C1DC98C;
	Mon, 28 Apr 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823285; cv=none; b=amPCYvmk7pkQxnth4RWaCvyyw62SYC0tJY5zvz7V8NXQ2wv2IwOLSxhVa8JWQPuzeEaCPPDMoeU2Mtk9zg3RhyppoaNQ+/hoJv/tep5cdub9rMlXLiWEoq/Kc98yL5Xt7K16ORdQWQdbxLInwKwiDwZJ1DpUAYo0CuKH+4W2zlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823285; c=relaxed/simple;
	bh=u2Q7slitq+/N2Lvmg494PEDFHCL/9E1dcqL+EcBsqT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQnTlpELluDsJfTbVvq16YaahJrlrDKSyghsWm+wmVbUNsgjOyisAeqTHm8h4dHuRBG40IwlzXeIv1zU1ljI1GvyfjXs840tk6R28lA4g3/Rys91aRW+11u2vm6yyNNnbnIhQQuKsVPmdxyrztoNxb1qjevxZSgPxXb5Gs5jwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM6pBg3p; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso43925891fa.3;
        Sun, 27 Apr 2025 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823281; x=1746428081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgqpIKZdigmmEv2sXkTySvXZs+Z5CJRaLrF79iotyYE=;
        b=cM6pBg3pyz2fkwW1B9qNBo36hd/c8tfseF9e9MNgMpcAcI/7zf67C7y1e3+99FSa8f
         qb8KwwbotxJbZ1TQ/Bniok9uFMf6meei3APQ2CHF1tfaCxwbtoBP+R33s4zd33wU47GL
         05F8uO2xqUXgGV9mt+OgIxR6zBRhZbMrD/+ai0A75gh9Yh3NpNsKucSeL7POikoSeCPj
         fKA5AdEeUupuDqCF2Urk/xV1cy/RYDlLTC/ho31OVsUa1XoZHsmB3cdIN1eNC3+KKW9q
         HPBNakyf3bb41BjX4M/8IokcSeV+lz4af6mWeAydh9cmX7tAdWTsrdpTLG9Rtgi37jNc
         At4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823281; x=1746428081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgqpIKZdigmmEv2sXkTySvXZs+Z5CJRaLrF79iotyYE=;
        b=p+Tjdd2wKTGVCNfQ4aMzvrgNjPVcJ35rTGarXhxLV6qkVhCIZNFZm+/DLKT19aV28o
         O6YJpmmS779IEz7itNaELZ009dpfls9P7tpv29rFKKb6gf31DyYd06zdJwtYuxVu2EiK
         5Wh9gaa4W5Gq/tS6grHo8ggPRvRB7r6pVGmQOCo6VyYNzmPwXTgj3xaDrs6SJN6M5WnW
         9jewr20HgbJzWUZnNzn7R9K4MUGteKyajZn+Ifmf/cPb3VREZW7y3UVGdnGRpamjA8Bx
         hjIdtS42irRmj3heYMElQixyVsASDpgrPaNFV1hfob9bM8IWZvv1fz+VGjdOsA3AmM60
         bvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1xI+9ud0uUxP4IFFgRHP3dw1Lh0h1Pdv5LXylq2K719ZbjTe/oP6rZ7/7q+fXq9vqXRcrnIytQf+Y@vger.kernel.org, AJvYcCUrFDESPTcbyr28rfiEYwJ/MX385LdUn8D4C2DOz3VBOo4doWWDxyajti2yUWFAfkWKgHztdFw4f9lLmo/0@vger.kernel.org, AJvYcCWmrvwJKRG3X3yXKO0yUXEZq/sL+oh/KfHlRGUbv1gtLSKZh421oHrUYZWTQNVj/g84GlprxX4IBV9K@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPJjoUt5TT4dAkECwYwIKkFZ0XCtzi7gR/VLsq72/6gw0RoJJ
	5+xfqe7PNO11pTXdo+AZbXf+xkDt7R9XD/hIgN4kDGVXTdSf5a5Q
X-Gm-Gg: ASbGncuVhMnVQNcLIQtjXcXyyFWOX4Gf/3UWH71IlwHZXf/6mh3bYmxsETmE952m3+7
	CB2LfS9L9dxTVsSV100iJd5zkGrptkpEuZ3VTjs6WQ7LrtEEMCnQiJ8Y7TVDNIAQ2xxyun6DZ1/
	sFmNt9ckiH8wFBj4q9H3xlHZqGN7S6d9kRj6k1AMIvbz2WGFB0IiKoqa3zjm5hSrb/gQAvsVUun
	C2Dx+S5E78W+iimeRkLYmoP7yYjyKOq4nZ4XbaXBuZx+i9l1mWUePkva14KJratyPNCvvD/DT04
	xXKbuSAJFFpdMTNkwbwyWpfGItDRi2FI2dMq8oF50wrkxzC/8TLST/feZXwW+5rmLlUxr80Fkt9
	77nkG16F1
X-Google-Smtp-Source: AGHT+IH+QuEx6mmrvX51OEDYksus65i+tkS/nwfzzAneQbU6Kv86KMA21Ps60h9lrOyYuIfRtpPN4g==
X-Received: by 2002:a05:651c:12c2:b0:30b:cceb:1e71 with SMTP id 38308e7fff4ca-319dc01f73bmr26345131fa.9.1745823280518;
        Sun, 27 Apr 2025 23:54:40 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659c4fsm20017871fa.21.2025.04.27.23.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 23:54:39 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 28 Apr 2025 08:54:13 +0200
Subject: [PATCH v2 3/3] iio: adc: mcp3911: add reset management
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-mcp3911-fixes-v2-3-406e39330c3d@gmail.com>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
In-Reply-To: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=u2Q7slitq+/N2Lvmg494PEDFHCL/9E1dcqL+EcBsqT8=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBoDyYmum5EcMkLk18UjuRwDQQJhuTXfITLzj9KM
 DQ24UaZWWyJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaA8mJgAKCRCIgE5vWV1S
 Mm0VEADak9LhtqOqiYhNz7+LKiDRXg6ezmtu0+7GxUC6L1Ijqj0OTWOYvq8m1KIeocUE0zAObWg
 u55hLohTELP5MykOvlTLq089FxrS1F4Z93zPfNzQkUFVdIS5dEFni50u0LCfjON5lH/9ohvJzIV
 GxXcCYjH8iXSVu8BzkEecEsxRCl/NBYkC2aBEYEKAor23/vPBewBOSiigGYvcO/NiA+N9qX0+q/
 425b+tGYn67DIH14rQOEBF7G6d4ENO4g0hHZMKrz3K5qCdKko12+XJ9GNOWJduCRIVa/Oyp5lCQ
 GRpEmYFaOjf1aIFqDeeCWljBJNka5I9s/eTl4CWUna8jsABJPwsPSaXO8Hvu7ib7BuyLqOUer0/
 sXJbdVpW0d09E+NGHjP0Ob4Jmt08BbMg43yiTQ3NgLJtZvDi4szl+BFRYPig+SVMRzsSXnjOg+g
 6BL41hxxyJlKv0w73APj1NooYVUrc6ekVVpgOYzVK6c7jQAjPWHXO0WK8Uss4SMId2YMzJ0NAN7
 xOCT2rV/T8qUKKXQMhuPBTFCm4QRHNMZwX9eBIL6o0pWVDFIpY0iEJTmo0W9cn0Vz43Os0h2qD2
 mLtnanGq9Ojg+2KilGb4gjAfYqkbbSE0pRP4rU3pyoyP9ShNQfCrRCzv3HjHxXGS2BTUjOxdKFQ
 vzg8Lf3fVc7l7jQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add support for optional HW reset.
If specified, a reset will be asserted during driver probe.

Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 60a19c35807ab783505e817898a2405bd8beae34..76b13a73543493c4c5d446dc47f8bf1f9d02af39 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -10,7 +10,9 @@
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -706,6 +708,7 @@ static const struct iio_trigger_ops mcp3911_trigger_ops = {
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct gpio_desc *gpio_reset;
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
 	bool external_vref;
@@ -750,6 +753,22 @@ static int mcp3911_probe(struct spi_device *spi)
 	}
 	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
 
+	gpio_reset = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(gpio_reset),
+				     "Cannot get reset GPIO\n");
+
+	if (gpio_reset) {
+		gpiod_set_value_cansleep(gpio_reset, 0);
+
+		/*
+		 * Settling time after Hard Reset Mode (determined experimentally):
+		 * 330 micro-seconds are too few; 470 micro-seconds are sufficient.
+		 * Just in case, we add some safety factor...
+		 */
+		fsleep(600);
+	}
+
 	ret = adc->chip->config(adc, external_vref);
 	if (ret)
 		return ret;

-- 
2.49.0


