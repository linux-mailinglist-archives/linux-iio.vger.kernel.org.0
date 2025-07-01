Return-Path: <linux-iio+bounces-21205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA8AF05AD
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F473448383
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9B302CA7;
	Tue,  1 Jul 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jz0LiL07"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAD2FE370
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405974; cv=none; b=AwXFbE/MySmudSsILvCuXLgyrWKzKhKZlAaLT9tosQzS0S5SEnQo8rqbz+0HwjqW1NRHNMNebda0qv8uFhccp8rlp/QKlCHw1355yLknucSbJtZ9c5GzM0QAwS+10Q9h++RbyokWBlgLPfHT9551xgMvJzA6bbPiSdnriqDdmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405974; c=relaxed/simple;
	bh=1qU2uE7FMPflcU+JZ/SdmPS+Hm6dJMEmmE25dOPvZxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwLhmtquOtQtoodi0KNDnnBsc+9fjwVicMtwjaSwaQ6A+4IISA3KImbnh8S+PNmf0llFzzCOipTLNBQqqistt3x7qnARuFQin+h355ChOFI8xQylZre5WbvLNlfEOeFq4SVWYZwq7BDlc9thelRSpirjOwTV2bX0UsSwJfov6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jz0LiL07; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-407a6c6a6d4so2022941b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405972; x=1752010772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w9rUjmeh/tPGSpT8Xheslz7aDCsq9V40QAkh/yUzZo=;
        b=Jz0LiL07Iv/DuE4ipjOIC8ZQz2FZpc7wXLwTw7L+JwrX3Nzj8kl+xlUyk5bOdiA6Fc
         RB+ShDt121kcxfw41Y6GOiBfc1TtADI2DJNdd0wlF7gwYSOEftGBjzj/7xjRNpIvRKEA
         zHr0mqMiGo7n0o5Y3Hi0PiLj9MGijbU63EguxsamByykZuk0V2aLYJU0SmpGA2qkvGK1
         zYGjv7OvqLAGLdys5kYWhosI/jSVDEItQiwEeZammmqO6X0SAQn8K1TNysYoMkU60hge
         GmFTGfFmHXMZe/LXCdJPjxw0UPtbS5gj5Z5DtWfxZ2/cj3vfyvFV33c399XhqYMtzoDj
         3/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405972; x=1752010772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w9rUjmeh/tPGSpT8Xheslz7aDCsq9V40QAkh/yUzZo=;
        b=pNQBvatl3zxoDfti04yjTLGVJcA7Gyrfhw0vR2bnTqfbcghV967C3zbxtZ3RKoV6d8
         DOG1Kx1flSmRGRmq8s4E1nCWIyZwRhrwS0FhDAXbiFqXDAVAtOXnQ2zzRVsAodqIfOfL
         ej4gJleuuJPZeCVQM+UFriGsyQ9QXO8H+qM/Ugqfjb2CaeSPX4meiy7OV4gRqu/EL4Bo
         i/mbPOC354ZT5fOreNwMzkf/VlkxB3euXMLwdc8iB43BxtE9lI3p6haBSX8xcUk3aqwt
         PSflFI6UuG8kushJVnRggJuTjFgcANO4MNv4WjpVXSTCtnvZG82nIY3mq2iPYr4Hb19C
         Eaag==
X-Gm-Message-State: AOJu0Yx8Mrkg3a4H9eIiAfLkvQ2/Rg2oj3yVC2CLVZ7xcjxL7euyH13d
	ai7QoEGFAhKaqJYeq83fNxCP3WubbRJVicr4bHkR0X45/z9hv0ylnWz9G94wgIml5os=
X-Gm-Gg: ASbGncvKt9KBHjS6ueyVC6LGXLbu9JHP9dS1ipCLkeUpX+fYOssskSaPDbPH9VTnhhN
	c69JsKsqGINIYWhKl1oSYuRCF9eNl/AZQCWxGnIwytmXizXpOXgFbvbs5GTd0gJ6K/R2btWXEyU
	bKLpZXHhPxR8imCJzjZJQjXDmH2N5lQQV1cK12knjFS1O4uemDuQGwISTcVI3QuoTHZFX69uDi0
	syqnJ4QE5RxCXJhEmanJvSvcujrThMdkRFEBJXoBMwqiF3RMc22pJ8su5hMx6ra8iqBWaht9mbn
	bTDeeZlbM//l9Pe4GPb2zF4FvpW3uHwwBrC11rn2iLFTIT2quY4OZLrf7dPzzK+CPh5l
X-Google-Smtp-Source: AGHT+IEVj+OQx1ExM6bdvzBEpZB3mbKahHnEvuYiD60xCtIPqVZTq6a66aw113ivnak/wvuX0kwIig==
X-Received: by 2002:a05:6808:130f:b0:401:e933:5dd9 with SMTP id 5614622812f47-40b88818292mr219493b6e.20.1751405972280;
        Tue, 01 Jul 2025 14:39:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:50 -0500
Subject: [PATCH v3 02/12] iio: adc: ad_sigma_delta: sort includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-2-42abb83e3dac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1qU2uE7FMPflcU+JZ/SdmPS+Hm6dJMEmmE25dOPvZxs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVC+1/TsWxjv/MzSa6lzkWpzn21t4FgGShZ9
 ysIlXNGMfyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVQgAKCRDCzCAB/wGP
 wD9PB/9nTBwTyiDomYAZvoIEQmN1g1VBPdOOGeN9ul8WNmQrd1yFi8z32Q6Oj9AkVyyp+dF/KaH
 3gVlsJof5RxnEUgtgKX4o+ikufQdLfYBJbkaz2Pv5QTWj12+/4TwiHpZr6GLJ4I7v6Nf3jnckWg
 hlKPthQm7S/Ehe9IL7PBNU8c6LIOwO1KhIaH7wQEtwNCVSHUBK3eQ8rtYbu1pANxD0yrFmvHzZV
 GdkuBqVlce7vJMNJhC3bR27n65Kh+U3Pe/I3RccsK3oU/ahh88PAAMFijIgX6vpQAcjaxRWYrUV
 PGCCD8F2afbIdrf6V1n1ndfER60gVI/pZPvEA5axfL0zMGew
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Sort includes in alphabetical order and fix grouping before we add more.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 6b3ef7ef403e00804abeb81025ed293b188e492b..5cdd73160c6d6d4d9308eaa3a5aec14529475676 100644
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


