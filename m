Return-Path: <linux-iio+bounces-20799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F656AE2594
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 00:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8596C17C315
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A861246BA5;
	Fri, 20 Jun 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fx60Fh0r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898E244698
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458085; cv=none; b=bLa21aCD0OksimmGXBrAp4o6HE/hmwYZXADtMBq3kl3Bgd5J+yCsWc5iJ1g21eS0ObeYfaf4hpZDKKuK3GYuUBr6nckoZlaFw6eXjJde2s8TacIdMRVMjAatdrH2nASvXb/Jbr9cCXXgGp0ityIr79rqm8qBz94cLEh86XQ09Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458085; c=relaxed/simple;
	bh=vcFh01t+JmSdJIe+pkepWbRzB5Tv6UVGsGvhuGY2/vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+LZpW4wrLv5PbWkOuAATfIQDf+GFdNOAUMHjSQOFpeTm83W/P5SGuxTGtEv87gizixioMootFN1do/dpriRFfcZCb4V5DfO+2MhT9qlcu9Xl0cNlBYjwSHMraoaYo0gIP2gAYuy/M0nGKydbBQfC34dMBz6pX9+CGn7YeNBi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fx60Fh0r; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ebb72384dbso537824fac.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458083; x=1751062883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwFoCP9sQfkuV+I5mDs2NyND2ADnvvFWBv7uoS+Gnc4=;
        b=fx60Fh0rl8a5lwYtq/4oFbPkiQBuNGW8hh8KmRdE0TYoYgWmCAEYEkD8y/p+mPi3wL
         JBaLw1BC20nwUKUkCnQRvgFqlgjp8yPghFGUqJs9ux7u/TJDXC748oh8GmT7qYFbi2QZ
         IyPqSNez0ddxPmZvA8J0R77sRs8RB9HDh6q9u6prOe3NvZNkyookztRK2S0w6tOcgyeE
         P34l3VCbvEiasrB0XnWu7Crk+cNO4dMOCRSj0KTB1kNhD3wXBJomv7h5q/fcAnQ61lHo
         ozZrahBpvYme6Ji6PtLcErkl5nRE4ZrCHPmFfLm3fmrz17u8b/7Xos2JA3Q+bfGCx5yA
         d+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458083; x=1751062883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwFoCP9sQfkuV+I5mDs2NyND2ADnvvFWBv7uoS+Gnc4=;
        b=Pg8qPgKgAcaZ9b/ipFEqmchNUT26Ct2TO73XPrUhtuG0QU6RQpFbuDA9Qj/w39YTB8
         DT6tjsH24ClSmfYodsrx7d6hbN94rPtA0AQEUp+kLs5+yodLvDdIk6UPBL7By2OhpACk
         A1F2VMntAYMNzsLfLPU0c8N+K18hY/q6PeVxB88mtleIBtJ1Ybvct+KMwy4gtqtPpO39
         sutHrnTLsogL/nhXoI3N88wEtYfcXnceJL+mg4h4w/omWZ4CIdMAXJSmZJgdMBgz1hwx
         NvZ/njcAoyfBqYe655J6nZwqogrwUzegak557wvzJn4ATc/qE+jEremFljOc3KzRd0PP
         gCJg==
X-Gm-Message-State: AOJu0YzYfn9jnlyxwGiqelcwt6uwXnp1DvAHWBduKiepC/lpcRYVrTkt
	+0hbAZHJzeR++fCfn4EDuf2QTPeh6VCQMyuTHAhVAZWSfgTn2UWf4JiGX6qSXSkr3RY=
X-Gm-Gg: ASbGnctxCTuXQbnl9JgZGNW+FzOpldg2FYaVf0ju+Ve3BWMEvmZOaYiNKcnWzGi+w7c
	Mby/lI6eRxbFaYHbogTi/h/JSLEjfoapl2D5+FhM0GJBMCCpcYJ7QCOOW9jhc3H2A0ylxIQmOI+
	4cL01t1B4hPzu7nfEQpfSgPFERjaw9v0AdV09uk4DMA6pAgXbCoq/R7CnU2LA5qjAzhfveQmYZG
	Q5LR9IvRQnUamOKKK5v03a5a0b+YE2CGKsIO6eXrIF4bzFsYGJFNZR6tMQrfRgrZtgjQUrEo6lX
	1w25UlZYWpFfSlnWzPrGJvy9MeJXV6htEYjjzv2bdhs/04i2rwPM257bvsF2nallGT9g
X-Google-Smtp-Source: AGHT+IE4/LcA0WYE5yJAI95TpeYpZDVIpC1YxrPmFCw3pSnW5EA4v4vkS4RidHD+h3dLK1w7YqZfGA==
X-Received: by 2002:a05:6871:4409:b0:2d5:2955:aa6a with SMTP id 586e51a60fabf-2eeda4e19f9mr2846359fac.7.1750458083288;
        Fri, 20 Jun 2025 15:21:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:07 -0500
Subject: [PATCH 1/9] iio: adc: ad_sigma_delta: sort includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-1-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=vcFh01t+JmSdJIe+pkepWbRzB5Tv6UVGsGvhuGY2/vU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd6iInU0MFGX6S6BJOE/3ef2lfn/fzwjEWMx+
 za/8sCxIgOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXeogAKCRDCzCAB/wGP
 wJT+B/91aR8po6rLRfhWcXtrVeiDAY24/tBykK824JFFxyJKGP373X3G2oaJCappPjHsF7Ci5IT
 uR5XOx1sWev4LHgCQCLJ3qv6tWNi5Pu03xM2MsJqrZxKPfZQSbD9QU9z1sIGtjHDkrRCpagCIxN
 h9TXdyhOabuMPtljX3UnPycuZnL/PZ7h3UK0Xr598zSDG7FT5Ps1oXdalwaTe61evBFWZossv4Z
 UCMYHBmnw8JdqEkEfuY/aE5K1MTYMwj11dKnDLwwSxCF7RScDWyNddLEJuNgC1F8SKHTmoPCUG3
 YQx4r8uxr1oFVcCZ1u/BPmk8sXVIVbVASpKn8r0fJhhceCne
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Sort includes in alphabetical order and fix grouping before we add more.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 4c5f8d29a559fea7226b84141bcb148fb801f62c..6cd3645eaaf38a23d5b6479ac598b6d276cfd81a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -7,24 +7,22 @@
  */
 
 #include <linux/align.h>
-#include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/err.h>
-#include <linux/module.h>
+#include <linux/unaligned.h>
 
+#include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/iio/adc/ad_sigma_delta.h>
-
-#include <linux/unaligned.h>
-
 
 #define AD_SD_COMM_CHAN_MASK	0x3
 

-- 
2.43.0


