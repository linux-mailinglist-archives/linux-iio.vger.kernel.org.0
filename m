Return-Path: <linux-iio+bounces-21210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2CDAF05C0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11C517CF51
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A03074A0;
	Tue,  1 Jul 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TmnjcLOa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E3306DAC
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405979; cv=none; b=LS4OQfo8J2kRUhe/46ikJWce82Dtip0K7Xj2eui79pKEBIsXMhZ9l9OsO0y0sV66YX+Rj1kp6yHLiZBe4i6cwPc1aFahz2C+pVDmd3R80sIaDU1vjzHYEX8Ym3wShLG/Zc3jY1cxBG5G928R5ev2gd+dZGpVTcNZD65PlON14X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405979; c=relaxed/simple;
	bh=1pUnPmEW6s+eLqvk9BXOOUemrGb7ur2APhmFlPgVmmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUzGA2fuxUVgNPxFy/317o7wIegrBK3dI8d/JWdqH/cf8LmwbkUkCZfrU7ucbiDnqbUI14AA7rd+dHWQ3uM5rOnxvcaUF2dyBH/oxhknCPAvRIyoXvgHcHltonleS/Sgr4znGCIhXJ/eM7lCJO3HnedVH+lVirfIs7IwUMGxxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TmnjcLOa; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-401c43671ecso3040605b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405976; x=1752010776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHniCqYc2VQTDAA4fWnYCZus3iLgaAx0sPomUMoMA1o=;
        b=TmnjcLOasPj1oxlNTgIQxVUokAmC9eGtpCqII6AfYBiK2YbXsOH968W6Dh5m15XXfq
         Cvhd3SIX+aeDgZZZ8Lscz/ox3p+z18pjuLLNDNeF0cvWz7O+9fuA21p4PLAJjyXxqWmN
         JIYHdZJj2CenzHeDyK9l99yeMD0EeVAjaY0wkY1UD3jLCMmMfcvZjzLDGzA8kOoUy9jZ
         yVQwwjC+pjNTyA9kK40kcZ9ly9duT+JwWNv6Y+FWy7eABfu/EeTMWUWjX2GkSwpCCX7Q
         NDfZeGp+72GxSU3D58ugqyepJcxUBlo5GSTVFfv+G8wq2dlK/2Z2O1cvMrvuJU+K5dxX
         wN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405976; x=1752010776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHniCqYc2VQTDAA4fWnYCZus3iLgaAx0sPomUMoMA1o=;
        b=rzkNNl8XOrvarhvJJQ+0YTJChlkoGlrdf9Vzy3FeMWCiRlH/OnOyvYj4zteL1o6zty
         SkmPqAPQj1UvQ9xJ4DaW6L2Ck0t31dN9em57AVB1vB7atXD6eeXCmpUEz7Hd78sEmOIR
         VHCYnbdt37DX59Fwy9WNxmShDmdxDiCNqrsc+6ZDnVHA9n4fM1QX277EUwxaMnHKeqRD
         WQ1uVSr5AVBoHqr/9ajlIS8O53LGuLqZZ/D6mRyV8fBcfZV8ghxboIWbFa+f+QCzLHQT
         HYXqY4SAhnZmWz8yFT3OGq0gRNTOnTKoafDuuPtCDTC7dyv2gDPcKx8L4noMzK9q9shW
         h0Dw==
X-Gm-Message-State: AOJu0YyKq+6P0ki0t4u6BjasYXO0VCtEqDnwd6JUq0FpY0O+fdJKRMKg
	wUPU6BkttXmYG4xvvLWFatC3vfC5N2HVyROxPxrlfE6Xjxr5MxTj2dLEgNGziYi9eyM=
X-Gm-Gg: ASbGncttYz+WzwZkSXtZrWJJUV0ULZzuUCayB9C9bLCZdPZ5CLGidtmeP04TMh2BX5i
	IAZs+kEY5so4QNe+Lb14xvMGeBJxCdK4h3vAsxJpOdcjnZKIufY8sxOnLT6X89flm9k6um9XFTl
	aJd0IVV88cSidVXygUJj2gPSOCOfIiziRvBz0/p0KaxVSLb75rs14NWpLa6fULelSALEbQpEjhv
	dxUm64+VP/Aq9ubm40uvYfQZ12q4PPFOdGajpSE5pcV/bPrctgXcu8yJFXYqfe65Ph2qeZeiren
	DEkEmPvAnd2mFXYu/jYj84nbHa/JYdno/j7NK2F3FMffhha7i2p5pK97jNmFsjjIKOgO
X-Google-Smtp-Source: AGHT+IG0bhBx3lA01RN18NYfLT0rpHpS0ckfjNDTHVbR/kan8VENJvcoqo8/X2nSGkB61dwgGiAHgA==
X-Received: by 2002:a05:6808:4fc7:b0:40b:1826:34c1 with SMTP id 5614622812f47-40b8999b39fmr191361b6e.6.1751405976599;
        Tue, 01 Jul 2025 14:39:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:54 -0500
Subject: [PATCH v3 06/12] iio: adc: ad_sigma_delta: audit included headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-6-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1pUnPmEW6s+eLqvk9BXOOUemrGb7ur2APhmFlPgVmmE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVh1rpys8PmWV9xj3NC/o49aXlvbxJ3xeDIQ
 1gRRA/KMOiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVYQAKCRDCzCAB/wGP
 wLkqB/4oOW2IyFjdlSpnzdKReg/rrMYr109m+uGSKjMXb/6sTXnma00V8PIOaRfWER327KKpQBt
 GuxYElkSh+MVDeQaLlyIoHMXrN45mT6xMTrDtDklY8zEL78amVIp5mw7QmjOJo8pyvbM/TKYOu4
 4+BQwyA3KjzPwolaM7y1TQgDreZZ+G0kOHej5SWm5YwPZgE3JYn69k7FFV2pCjqHd0vbrK84Nsd
 1WNCaJlJL9oXbEPnvQQbP/W+qhS/SHuP5I/r2wvYS/DPdVzhClBDZHdpPY/h6sI/BBohZUtguMx
 31E0mY/KhKjV3d7hJxauINaCfoDSXp1KtDjZ2kh8ad6zSVT3
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop linux/iio/sysfs.h since it is unused and replace linux/kernel.h
with more explicit headers. There are a couple of other headers added
weren't covered by kernel.h, like linux/gpio/consumer.h that are added
since the module makes use of those APIs as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index f91f7ae6dfca05cf3ae632a5f19990f3d153b706..b5c66a6cc47ec8e36c458fae87309fd30109c0ec 100644
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


