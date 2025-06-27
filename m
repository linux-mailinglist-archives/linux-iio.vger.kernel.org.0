Return-Path: <linux-iio+bounces-21020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4998FAEC32B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25267A9C59
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65279295DAF;
	Fri, 27 Jun 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wz5gaFzr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8B293C52
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067693; cv=none; b=DEDWfd5C+GS8h320cU1W4RY6E+tt3DQjx2srVuexmq8pxZ/XaE124Z5CTFZn96XSHVXsyMFIo/QKOBmszfjWsODrnJfHJUaiImlgH0MWXrFyiWrO+Z82eHM3HNWfjiB3v9c2nWjyjP8d4LLDj8DMRok4U7RN3yXcScecNQUcgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067693; c=relaxed/simple;
	bh=wBi/QqyMs0CYDBT2Ceeh0ISr577CfmlDC9vzlDRIqM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdEmM0bZGPrYC/CMlG2XbowwJpi5xex7AkR5AqcTQbHKkuZno80I+ze6cEXr6OUkCEMg9Hv8rFUw/rUvecZY9tQ+wYmns12cf4nYTvWOD+LghWJULj+oxcJHVYoi1nw6azyw4MDvCOMvz6Tgv2xe1Kh/xFvt6xrk/WHhFRAyt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wz5gaFzr; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4080548891fso1091697b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067690; x=1751672490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vErCRSuXhbdQ1kcyByBRR4fh3OBWPU8jxNZF+LkhLs=;
        b=wz5gaFzrkFrHaWI6nZqaAqWQwuaU9sykao1zez4RvBCcTfQ/KI7ygO2yMfCAa3KcMj
         QK/rwB+F9rLTn4Hh9aQjSZh+V62WY+WKWprRc/E9QMmM6mfjoXEvDf9qAT0+9EUDJxg3
         IBIwKEeYVx6PfcMwGeG+b+e8gdiJWGMZf3EZCeucNJTCOXNu+pHZX26aZHzj5TgcbPGq
         2rQhhoHKDUxQE4EWDKPMj1vjSBFmA6jYlUShBP5GlnwnWjpxedZ4QS2dAGBSv7jE/xAq
         xFpnulxidyq0pio8bte0Tp7w/mo9fVUfPzd1KNXCXageWQHi1OQEJzBg8PEldjwTijeH
         y/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067690; x=1751672490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vErCRSuXhbdQ1kcyByBRR4fh3OBWPU8jxNZF+LkhLs=;
        b=fvMKvR4oefvWR7cj49qxPBpr0lbaZfbAGH4GqubrYTZ7GWxM1ZXiVmMufIXconztYi
         Hj61dk1DHGPFj1ZJQNQsw23cefD4oaE+OVKIj+tzd68bOIBcRDJnp+9R1BSxbXlSht6a
         2Rn6zMSpVljHhWt5t9On6fzfzjnu8Xua9FHED/wQK+xNVFGXyVwLy3C7cEk1IFeEisRQ
         V1wBteSSxYDY9iY5gtQgZfa4kGqXYdzqQ8CCxIBM0iDH9zL/5Oyxpr9LYUKC9PkbehTi
         RiG4nnDBW0CVYzFgiMnEVN9INZlNw+Y2BX8zfYiDjySRi+XS5HJZy2aMy8DMQ3+sSMoi
         Vi8Q==
X-Gm-Message-State: AOJu0YzXELfJ4dFuFlBt4VH3AhlpN28LuZej4kf5BsoJILglVS45gmKe
	FbbfmL22kFyck4mvkfxoL4K87uP3EH3axpHdchYmF6h9VBIyqOl3NdUfgbY3p2q6rjQ=
X-Gm-Gg: ASbGncsCjkUNFMq7/FwoWFlK9k3DXgErGWa0GKmOluCEqBT6DZV4/hlhqQrfo6plVx7
	WQ+u59GQJf9JjK5tJM3tLDdeezW3bQyqzcqnfgW8ax/H+ASNDAnEncXdwoaeFIiy4QUrjk2fwiV
	MyLPPGw8xpgw/3UCDtiEI7mdyN4li7zNsF8xqXjI37WCONk+rAZLQvncgDp7lTnGBdQZHf/8KR7
	PqCsuDfo+Rdo4E/myP2ZwUGa87PPe/a0rEtlxXgR2mWXz7mrfob06ZXGvgmvXL6r12lJ4O76tH9
	OCiuTzZNKj6/O4ew5bvt453RBrqga3rdWKWZZ6Gw8H0DtgdHHR0OIgaUOqkDzzwmEeM=
X-Google-Smtp-Source: AGHT+IFP9naojZ+NRB7AxFiV/l2DwqN9TfuynscWjl0LKqiWBjBgsV9XOiR7x1yRckf+/CTMdocvxw==
X-Received: by 2002:a05:6808:189c:b0:40a:59fd:1368 with SMTP id 5614622812f47-40b33c17ab6mr3708002b6e.4.1751067690336;
        Fri, 27 Jun 2025 16:41:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:40:01 -0500
Subject: [PATCH v2 05/11] iio: adc: ad_sigma_delta: audit included headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-5-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wBi/QqyMs0CYDBT2Ceeh0ISr577CfmlDC9vzlDRIqM0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvzpuqDc6liBnGS1z33ybsINng2VDpNM8SjR
 2PPINIGI0mJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r8wAKCRDCzCAB/wGP
 wFniB/91uR9lleFm1wlpfFwFOAmwGSOeXfNuLCSvAM0kYY0hkxgTBIbWPlZgCzslRUx0zSfHZfy
 V1FJtnyoFoMlTX7tW5aTby8S0xPCspsQr74ubd1JIYEZSxSCgsCN//vsBiuW3TNXBe1x76Yz0yb
 Dc6CZtFaBxmxjiarBHzlYXuJJv/c/obqq+GMD0VSXsqAdRiDsQ76hmWYwni4KFkDpmOjLKGL0eV
 CqBokn/nWb7s21kykjI2r3BdDym5c3OA9F1yGspp3JzdktWHikSJ9IH8b859wStxVqhXapK7vVH
 VW2cQDnCYe0VXjAxQKShMhZcsMcYDcpOJkioN4i5sv8XctQ6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop linux/iio/sysfs.h since it is unused and replace linux/kernel.h
with more explicit headers. There are a couple of other headers added
weren't covered by kernel.h, like linux/gpio/consumer.h that are added
since the module makes used of those APIs as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 64ed8aeb71f7c6ca19fff0438fa5ccce0c1d8f8f..ab34ff5e09146535fd6edbd288888c3afb0188a7 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -7,21 +7,28 @@
  */
 
 #include <linux/align.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
+#include <linux/find.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/adc/ad_sigma_delta.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>

-- 
2.43.0


