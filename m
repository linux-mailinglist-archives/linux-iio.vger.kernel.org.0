Return-Path: <linux-iio+bounces-18531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955AEA97693
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B5C3BAAF7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B2298CD4;
	Tue, 22 Apr 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XDkhXdI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A951F09A1
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352762; cv=none; b=uiUJf0xPkaZ5Qx/7DhYkOkB1jVHLz3ocr8Q1LwupD2Dh+44MfKd9VgKc2dtHDNMvLPd4gJxqpJ6kXPUnV0PkKkJRzXoQBh+ylRYSkpNonWVpDcNxSkbhlovl49+DXod56tPmCidURGRv6yzj4bwj0zDxa0joaz2V+BFIVjvN8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352762; c=relaxed/simple;
	bh=Rz6kR9Nnog2Dl+IpQRCHKfLS4Sb3C6gyABe09uNcvrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Od4xMNU8djhEsFZ1GFQAsdU6UJuyYoREDP5HxwsQ/jR1vv9piUP5ESIZducjPy2UPcpJQ5JJ1eccZrhQKBjpciYKIz/YG0LBOPVQrK1RaCK8p9v9gJVRkK1aOxCDo1pw36PjeF/PAOCPVaFdnnUwTCrbuCUiB3bz6XejGL4FaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XDkhXdI0; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-605fc797a2cso2534571eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745352758; x=1745957558; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur+YYyDzv8PMEb5GegaWF1VkXF70WyZq1UmQDyR3DPQ=;
        b=XDkhXdI09uwq8Szyg40GRnVspwH4nnZ0v0nmc/sk3ZhGRx7ukKgw61FsRdDhkviVcb
         aMCLgU0fDn1Dn/3EM185NKmy74NmrZr8tHYLN6rQU9gyZBRVWFaqiiEspapve64nHAPe
         styLhUh8wPR46s6WV+qjV1gdF5rCZkkS6QTnMr6rf6TQrweSsz3FyiLiICs3e8qkqjmi
         wZPYXBeHM4kIVGQZhTI9MPobStO+yKV3JZbHFq6CrnZFR9nZvCzzmbyBxgph7E5H6SP5
         v+BWFNoiR82ub1kRhhf6eizsJSuWk61dbV1ewvVClP9pntrntdP18YCgZEuUXBnH9/PG
         MFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352758; x=1745957558;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ur+YYyDzv8PMEb5GegaWF1VkXF70WyZq1UmQDyR3DPQ=;
        b=OB35s82LtwB8IKhprXuLTA+9FZWHpMXTnAdBt5HRhcDCXQHfHA69a7BwQji386tFq2
         r0BIdGabVkZIGhST9ZyUTJUeCy4CzZmnKpqz+71YU1dX+h6a716p7BZhd49uvXlC+BB7
         e02L89HUA5ZsXzPZ88jMl84u6diavt8Cn0yehH307EGPm3i/SVkKp8w0CrgkfC7pl30R
         Mkojy/wYJrRd268xWC5oc2ECiS94jzbhFbmAmqgPlK/76uFHwSqMWgGNGMNRzvfV7TWS
         fOYB4fFXrKhvdjQWggoPaLIR55nCQrbLiO9C0+P6UJ9tycen9rIpLEdPC5+4af1KLlkg
         TW3A==
X-Forwarded-Encrypted: i=1; AJvYcCXS/HD2lJOI6xtbyC1+KLvv6XgpAGNWAWDx6oamKTHaUK1lQujVOoAUMKIoimOCwBmKyUmWkjx6JD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDRqqRyrglaBoasDJ5sTsnvNGIJ3ca5YTHua9aSm1Lpbw2RNu
	8j3mTmuMCUqpbQsDa5bAvNiLuPpelv2/JEacJeEvLeerP0rJz/5AXtKtidwAAUU=
X-Gm-Gg: ASbGncvMJWtDJHJX5wH9CWFB8/BQHS4IV+IhoPRLWRnazH/OCZngCxncIoeZW1AqNt9
	EAVn0Y7jGsbISjcVysIDveTHbKcniDca/dSuO3V9SMBY5hSzMBrogrxOkWeLjz1abyUKPZf24Ga
	VXRSZ24TUaiKnLK5X/Myv+4KdoAGKR9heddLHgNPWf+Pk0QGItyqk+y7SRB9Q/2iMsYWuOcwOsp
	gutxhiNtWTypZkSHJOGBWdS5Mtoyv5t9FXP/A0AfWEeIoE6Aqer1kGAmKWU9X4nAjJXrAY1GW0s
	QIjOXpTulh3A+fE3uTzqSUCy/2Iq/n4gXNuKi1ukTTXcy7PoXKbT8x6sow==
X-Google-Smtp-Source: AGHT+IEdn21GBcQ67ZHTcgGKUqqECreerd2BpPdOoMxx5qbB0ls4vYksbilrdjkfFK3CXLjo6hN30A==
X-Received: by 2002:a05:6820:2296:b0:603:f1b5:ca02 with SMTP id 006d021491bc7-606005c9a13mr10542921eaf.6.1745352758385;
        Tue, 22 Apr 2025 13:12:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5fcd49sm2304822eaf.24.2025.04.22.13.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 13:12:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 15:12:27 -0500
Subject: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACr4B2gC/x2NywqDMBBFf0Vm3QGdRoL9ldKFTaZ6wZqQ2AeI/
 96hi7M4cLh3p6oFWunS7FT0jYq0mnSnhsI8rpMyojlJK33rRBhIPMZg+M6f+YEvh/TMWJQ/2Ob
 02njKSAvu7GP0otK7YXBkg7mo5f+z6+04fuGVjBR8AAAA
X-Change-ID: 20250422-iio-adc-ad7173-fix-compile-without-gpiolib-7dd72e254994
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Guillaume Ranquet <granquet@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3711; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Rz6kR9Nnog2Dl+IpQRCHKfLS4Sb3C6gyABe09uNcvrg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoB/gsKmJ9TWYcTk4Yq7Lu7XbPbZYEWJzXA58Y2
 LYxaBw3sgmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAf4LAAKCRDCzCAB/wGP
 wC8sCAChhldrSxne6/z/X9ZA+v8PBy2fxb/YSxo9xfQ1BhOxKg3yRgBqKi8CHSvcgnnEfXgtYLh
 ebrIvFEcVrhLg0xCkwZCsEhRCxpyX+UGIIKqu28X1Bzdy8ItyCE/MtqF3B6ijcUXXGvwVPCSlbj
 zQstIZGxgwOn6f5ukCVstD1fK5OxgCyY2ZP5QAot8sx4nn+VDcfJrenUKMJuWpCafG6bUAU7l66
 FpiuNZa7Wm6j+glRd+M8vF9zAJ2YBOK8DY7XRLuy85unLsQYFcJlS/9yTjpmiZMigaJIEnIGgOn
 RVtWIBh5XbvOS9p0gthQBYI9RjoX+MYiO3FSZsbiQqVpcjJT
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
selecting GPIOLIB to be always enabled and remove the #if.

Commit 031bdc8aee01 ("iio: adc: ad7173: add calibration support") placed
unrelated code in the middle of the #if IS_ENABLED(CONFIG_GPIOLIB) block
which caused the reported compile error.

However, later commit 7530ed2aaa3f ("iio: adc: ad7173: add openwire
detection support for single conversions") makes use of the gpio regmap
even when we aren't providing gpio controller support. So it makes more
sense to always enable GPIOLIB rather than trying to make it optional.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504220824.HVrTVov1-lkp@intel.com/
Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Not related to the fix, but I also question the use of the regmap here.
This is one of the ad_sigma_delta drivers that does funny things with
the SPI bus, like keeping it locked during the entire time a buffer is
enabled. So, if someone tried to use a GPIO during a buffered read, the
GPIO call could block (waiting for the SPI bus mutex) until the buffer
is disabled, which could be an indefinitely long time. And to make it
even worse, this is not an interruptible wait, so the GPIO consumer
would effectively be deadlocked.
---
 drivers/iio/adc/Kconfig  |  5 +++--
 drivers/iio/adc/ad7173.c | 15 +--------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ad06cf5567851ee71f1211ec69d59fd5c1857ee5..4591c886ffea5519b374a28c7a0698eb19169c9f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -137,8 +137,9 @@ config AD7173
 	tristate "Analog Devices AD7173 driver"
 	depends on SPI_MASTER
 	select AD_SIGMA_DELTA
-	select GPIO_REGMAP if GPIOLIB
-	select REGMAP_SPI if GPIOLIB
+	select GPIOLIB
+	select GPIO_REGMAP
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices AD7173 and similar ADC
 	  Currently supported models:
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 69de5886474ce2f700bf277ce707b15637113564..b3e6bd2a55d717d5384616d9a8a160c57a8f1948 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -230,10 +230,8 @@ struct ad7173_state {
 	unsigned long long *config_cnts;
 	struct clk *ext_clk;
 	struct clk_hw int_clk_hw;
-#if IS_ENABLED(CONFIG_GPIOLIB)
 	struct regmap *reg_gpiocon_regmap;
 	struct gpio_regmap *gpio_regmap;
-#endif
 };
 
 static unsigned int ad4115_sinc5_data_rates[] = {
@@ -288,8 +286,6 @@ static const char *const ad7173_clk_sel[] = {
 	"ext-clk", "xtal"
 };
 
-#if IS_ENABLED(CONFIG_GPIOLIB)
-
 static const struct regmap_range ad7173_range_gpio[] = {
 	regmap_reg_range(AD7173_REG_GPIO, AD7173_REG_GPIO),
 };
@@ -543,12 +539,6 @@ static int ad7173_gpio_init(struct ad7173_state *st)
 
 	return 0;
 }
-#else
-static int ad7173_gpio_init(struct ad7173_state *st)
-{
-	return 0;
-}
-#endif /* CONFIG_GPIOLIB */
 
 static struct ad7173_state *ad_sigma_delta_to_ad7173(struct ad_sigma_delta *sd)
 {
@@ -1797,10 +1787,7 @@ static int ad7173_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_GPIOLIB))
-		return ad7173_gpio_init(st);
-
-	return 0;
+	return ad7173_gpio_init(st);
 }
 
 static const struct of_device_id ad7173_of_match[] = {

---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250422-iio-adc-ad7173-fix-compile-without-gpiolib-7dd72e254994

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


