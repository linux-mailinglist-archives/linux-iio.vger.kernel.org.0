Return-Path: <linux-iio+bounces-14324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B24A0C330
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5711668C4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83C1FBE8A;
	Mon, 13 Jan 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b2oDsTk8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9A1D54D6
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802075; cv=none; b=KSvEY+P+zdQAY5c66F5q7ivHr0kt49UMcXLTOKco2fJIl+yYzKYiFvtiB7JgbWig9q2uJvITzstPzQP5t+7djM1WkVlUwSEDVwsHRtmV5NJXY22fVXRBF4jIJNoIq31cEVey/5Vdmrv1iZPUoI6FFzJMVHIanND08OXx+fxkVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802075; c=relaxed/simple;
	bh=Gg4MTSZsXCXpTWLBqlmFgtQ8htFpcVR3Ibtr5Iaq6IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcRlpq1RNbEHdX7BrqLXV27rg6+dil09h8f02VXnmgrUj6zO3kRnDVzaTD+dfZrE+anA7rJeaq6pooikk5mVrGoDrSxYboBb4ILlAyQ7dCOqX3yX8IUropv4rxwRTf+XM3iBsPE1XDFMwHQGuQ+X9Qr7EMvsMwT6ajVPa+DZyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b2oDsTk8; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba7784112so2595028b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802070; x=1737406870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzYxK8BKL/wBMs44aeLHnT88q98vlVk28vK9rh0LY2Y=;
        b=b2oDsTk8g/83GsKcvj8XJbvgI88xSBEtv+oKY9Yqgzis3RVue6yBxQ1f5747f1Jgg0
         D/XgyOOc+M/NEHpkswHIiZwVkeU1+7QDYTkvBBuRQNUg0h0YA/ZMDyQs972w5e6K6dix
         8gA6jbSgb7zNGw0+i3UUquSnKkbkPPloSMhG2YkEmPrtBqt3mUhhVfLelUPvjYD906eH
         5li3bOm+vLOxf7UskQQHfFpPhBECgPLXCYsNyTt/CmxgRLobwqTMZRlQIKg6wSXuVyPP
         c6sXLLb1reu972f7DMrNZmpRa6W3Hkg3ZzVM1qKnCdn1fH1EfAjElwXGpZBjw7KeAbaM
         Y/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802070; x=1737406870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzYxK8BKL/wBMs44aeLHnT88q98vlVk28vK9rh0LY2Y=;
        b=haPaiejO3QaEcdvPFWnR2krP63LRgT0LRfE3/WAd2sEZsoraHGUvrTakCzNDZN82IO
         vfai1RhcsZS86SuHovl9tj7KOYkIF/M8NqwUun5pTBBwsZ04Fa6gm8sO3bbDvc4UmuRq
         Gb4zWVvEa+RK3hOEYitK8RIc3QYWErCruuvahVWW/qPJx497fzaG5DmazIigXGDoejrp
         W8s2F7kRY2STKbhVYHtR0i4n720pKGIDLFD31padbBJCEfCEyK/PgyB84fpLOmPnagY0
         u9YiVokHDXSiV90qlLU4NIIrQSZJyqkxRufVggE35tXCERv6oWtkFXpgwcyVB/RS3dSh
         e6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUX04c6FbZ7Cu+V2FXNgbPIfflU9Fu63zbbsvNv5AJMT12Uw5RAUS9qRM1+hgTNHzRTGtefSmBgtvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+F+PWbxT01ewhPA7++3SDa0iLVirWgc/4VlOwMvtPy9+tR5X5
	MoBpesWu1AeyKEuvW1+GIhJDyCqG8fj5QlljcVbAmgVVCyetx2VZRXqSXHTFLuA=
X-Gm-Gg: ASbGncuIJp4mIinrM0cC2MUGBfvB8mKzQkljN8Sr6dMzhZY7cSV4WxO8lsF9xRm1YBv
	S89h/plMHOJn8rZ2bt+fjxQw6KAERwh9uJ67yoe00UaNMc4SUzDwHYLUVokVXQ2mRFHWLHkvsRU
	MmDIXhUK8h5C6Laoo0oorDwClFTr9YfqHetakOOtPPk6dnCZL8WVkACnQuGFSho/113KirpfCEB
	ZZN6T2Gpy8wzMJqLLwwbje7P5DHYDD6A6zLudD9d6D3v4CbV7hDqj0ohk3hXd/zDPo7YzjTkhU/
	3pFR5/kbhejv
X-Google-Smtp-Source: AGHT+IGvFsQcaP9wq5TSyvXGk7vYBXE2cHURb+mgG5k4Pb53RwdMtYnivth1bDD/afoslIIdyLI3TQ==
X-Received: by 2002:a05:6808:2e94:b0:3ea:431c:4f70 with SMTP id 5614622812f47-3ef2e97db27mr14757799b6e.0.1736802070491;
        Mon, 13 Jan 2025 13:01:10 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:21 -0600
Subject: [PATCH v7 16/17] iio: dac: ad5791: sort include directives
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-16-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Sort includes alphabetically before we add more in a later patch.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes: new patch in v6
---
 drivers/iio/dac/ad5791.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 57374f78f6b885e1d4f2fb452ac0563b85fc222e..24462cb020e19e8e2c6faa13109ac047cf423c37 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -6,21 +6,21 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
-#include <linux/device.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/regulator/consumer.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
 
+#include <linux/iio/dac/ad5791.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/dac/ad5791.h>
 
 #define AD5791_DAC_MASK			GENMASK(19, 0)
 

-- 
2.43.0


