Return-Path: <linux-iio+bounces-21016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17335AEC31E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073291C20BA5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE145292B42;
	Fri, 27 Jun 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t1ZEdIQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE329291C
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067689; cv=none; b=K5UYh7lqOU7c3VDwNWdj6y1JVMZq6fO7Z8tA3GmPmMQMZ4VjsvR1E5RKcAjLqGINGf2X7mw2PbfE9wWm3gYkyoWM4GIOupItoFDu0e1s8BS54sHKYhARi9rTSBdqY39CmC5MR7Gp7QU5veK3rmkq5B6Gh5BY6V6H/GS24xKVYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067689; c=relaxed/simple;
	bh=1qU2uE7FMPflcU+JZ/SdmPS+Hm6dJMEmmE25dOPvZxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBm96cn1aeH2hAtVd+TPAd/6VuN6ysXuA2aQYaV1JG6xhHGfkygZe9yJqO0YR8L1LVzo1A2vtbWboUUx0aoloBXUjSXMCoZ/SoswSjbBVHIuWDR1CB00B7OamaFOIue4YDUtuViuDFJIMpt8Mi6brEcLHL/S+pW8qbQAdL9MUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t1ZEdIQ+; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40b32b6af9eso948070b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067687; x=1751672487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w9rUjmeh/tPGSpT8Xheslz7aDCsq9V40QAkh/yUzZo=;
        b=t1ZEdIQ+t54YavobRCAu2uhy0BDkTib+dPQdBK9omNAKDXZLsZvip3f+I5qQAbMLan
         kV5xzEtFbP7fHixdMl4zqfcvLfkYY+CozGFh3UO/OdL2fkzbpNNanscfn3skgFuy3rAe
         l261tQ6XSThg8RfLu/f5bg0Xvicb+b0mHl8VDbQIB3qIj3clomfZn41w3N2jvFZ8LLzK
         avlqvs5Yy2e9ckei0pwTHHh3Skm7+pExLYbCued9nyiwnemFrIjGVwsSeoZ9UfVkYk0G
         SBtJxgU+OnBVq++bH1nm6ZmRt9wS6+ztGr5Agi0KGHIKCpAAZYc/30UzEeJnDiH697xx
         uk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067687; x=1751672487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w9rUjmeh/tPGSpT8Xheslz7aDCsq9V40QAkh/yUzZo=;
        b=dcr4cO/KIVR7g//CVB8eIGXw3WhWOBxqrRBuZxcKEzZEeAM3flGJlRmU28gQfqxWft
         BASqVEVxDH11z/L+qz3X2GqMVVoUS8wbMdMNynG35P2GgGZZ3xfohRKceRWluOMJspJ/
         oxeC4PGhmgvJT3bHif1M4HFRKlSPGQ6EOG+pCT2LOFoNf4qm802XZzUw7++N9u45Dm07
         5JBPXpBfDfABsIq2EM9UEcm5HrFVO0GtEc0gGdIg5mcxHoIa9dcC5rlvDPpnLFNr39NH
         kjigAT/LZFU5xcpbfv6y1k0IZmOirDrRZoKEINUKCeHpd/gCbCzvc98TmbVSF/NzpdTx
         W3uw==
X-Gm-Message-State: AOJu0YwzfPSRbfJtPOFZEi801b8OoU6pcvbtNQOUt/WI8GcmvPDvPb7+
	zHZzHsgZkVRLiimm121jLYolED/V+xsD8zJ86YxwICuXuhMPaB1AxIAhteqYZwbmR/c=
X-Gm-Gg: ASbGncsXof1Aym2h7tzOAlq18OYEHNUCyjkB5vVrp2koYE7YCZuLNoQ4QHGbBRAGkhX
	90xyYiUw+yqpEKXIAdwmR+1Zrc29gDTn4OFzA/WyePb+qClpQWj1Ht5Lhr3f7+EYYRytdoXAvaW
	177yCm+MN1bmjHEVQUoagfb8M50AQ4uMN9JPiSxTt/hA2RBllmePNrFUSwjlKgpGmCtA21kRBgF
	9MEpbK1PJB6GO37vOkF0085FiRKVoaEn46wKX88KtfLMVNnYZc5GjjqIIR/XTfs+SyGvZJX4AaT
	lG6/UTiqVFEVXGfNepOhQt0lSPJ2bTUVycL4ZGPG0cKFM0S/v+92c4Mzu4A4d8eeUjY=
X-Google-Smtp-Source: AGHT+IFGqNmdvk19sYRNlr0Ag8IWfIMzxDLAs504IdyiRFRTHd2gDhzVJn/8D/7lUVVE13p2ujp4PA==
X-Received: by 2002:a05:6808:80c9:b0:40a:5598:7b8e with SMTP id 5614622812f47-40b33e3417dmr3339629b6e.19.1751067686976;
        Fri, 27 Jun 2025 16:41:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:39:58 -0500
Subject: [PATCH v2 02/11] iio: adc: ad_sigma_delta: sort includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-2-f49c55599113@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1qU2uE7FMPflcU+JZ/SdmPS+Hm6dJMEmmE25dOPvZxs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvgj3j9+r5A347pKRh+QHGykgQWdk3LZ6qK+
 xxV64//aoiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r4AAKCRDCzCAB/wGP
 wLaAB/9d/08izETFTfMdJsftT+RbnfgPZDC3QMXAgiqIk21LWueOvfHOA2QRdmiUKkRmncf7tYI
 WN/cjFbuvmfrBptT4Gt/8e90cvoNMSz8J5K2CKTOLX4pKAHrKFIkJ+yAMw6vQPr9wi0hhCNaElG
 Kooh7Qy4e8swTxtknJasmSxulHifNRFTaPz03XM8X7aaDhJA+Y26EdOIg5RsLxcgefKOfIG2NGP
 tebm2xDQOcM8+ED8QtqBf/yhABEq4sgXZ9gJdA3prQUI0zwzxP679ihbcETw/MErnLkoVuh6Yxq
 GG+2EtFY+FQB4EKxrRDkX2KqMppHcg++RmXeWyu0yfirnO8J
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


