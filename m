Return-Path: <linux-iio+bounces-15147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E573AA2CDD2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89469167FED
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E21DFDB3;
	Fri,  7 Feb 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDYYMqJO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B31DF754
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958998; cv=none; b=XU1YLVRIj+kRnbLK5iL9pjupUoo+bgGYyOfZ83dRN1dz8b9c8RSnFza22foe6e50yDr+sBuQbZI2DwhYTthpm9pGT8e9DnyfS2oMTaVbvrwPKdZ/qxStk0C+I/+2955vscUMbjDVP4CXZVOf1szedE4CnYTQg6bJG97st1qscjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958998; c=relaxed/simple;
	bh=SMPmN8r0eR+8HY2Jj8x2xcYlPFmCLQlrLCIyeBHoKlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZ0elaKDOQIxYVeyfhf770yPFZrInnM10wKRFPRLw/p+SsenpJE4pQ35ho7OLL18HQ7cbr3w0RF34KxzsPhvUhvFqrYZEDzamLtYHaul7QA8lXgm/kGFddm8P7Lu/xJLObjerNcdPvbIZZjxdtGIwltPKUdamijnDvBRiYUhUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDYYMqJO; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f31b3db5ecso1160236eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958996; x=1739563796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhv4ANzzEFKwoR1NSwNAajicR1HfyMZAyaDEFtvhtoA=;
        b=LDYYMqJOG7yg/xQ2ScnUuEAtiJxxuA/BCwvVLZTh9szN1X+FEF13a++vkakF8Z1L1e
         hKdRoQKb7RX+GuP/u/kqGLz6kzrZh3kuxxKyReu9h3ItazMmdYlYVpOWUhuMVav4rMe2
         jqBKNj/Kgf7ch0gKKKWpQCvGBgSl8YORxjTSxbrd3XE3/5XPKfrKAP386xUyWg9mvzSc
         fTn8PNlaHmb15kZi2OE1ZWMTnQbVkxUOIWrIQbOt0AdM2PzMeSuIHkDbCVAitlOvK5YO
         YAkv+94v+Ip05KcXfTgeTsKpcr6vpboJk7UotgL04vQEercKlBwsj4WdX8aT/UwqN4r2
         W14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958996; x=1739563796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhv4ANzzEFKwoR1NSwNAajicR1HfyMZAyaDEFtvhtoA=;
        b=Z3mf0I1xnL7PZOZ6FtiGh7ET+d6SW9/Z0KIFJnCLziXDNLdJHyRsEbQq2k5H5ct8Hm
         zgInl3RF4JmIAMvszIMONZ9oW+x7ATQU42jvM6vfbaYIYO7QbxKPmEcMj1YSVBJGPrBR
         3xu6D3DiZkge+2mAtcRnMsMscYO6Q+8yOwjXnXWpMcRKa9H5uSaRoN0nSO9E+cC52vq0
         jNK0F3wxwLpemlx52ND5HAhHWQhSyJcjdysy/EM2mZFsXqfOa+sucARIOlcMcGlcYdVH
         eIVSA7ZF3uzrBqpd7cMo3urlgy94nr9ytirBA8wC3jYygEWR92JBoYa29yIF11VfbiGU
         /qTA==
X-Forwarded-Encrypted: i=1; AJvYcCUNXX+46X/EJBLgokjz+PhOdwl1n0kEPZOTqJMn5tlKEG0/PsFbo6cTuGK2JBeAIqswAyE0hlyQbjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WSPsDO5mndjho/7tkV7M4n4ZcG8nrG8++WsCxLa9ebGlLzCp
	c+YhGYnzr5ato4qNT4QNmQxN0RnVbQTzvgnHIOHx2D7Ut1SWYJLuL7ksB9vkxbY=
X-Gm-Gg: ASbGncsKyuIX1Dgl1itNXZMlInfsTRiukGfxdYrwWqIYfi3EgXNklbIfJg9EoCOnGTA
	RHeaBYpHPq4LHNlXk5Uc1akVbOSxp/vSt37Vw5y1pLXnaPhQkEE3MKCOvbpDRm6Z79eshnCkVkR
	PNJxozPjh978VIrK9FOHL1CNoX458rUK1jRMPJo+yLrHa00ZTVs1i836otY7m4We3jxVzRaklxH
	Lhq5GmpuieJh9cW6ux1Kx+dCa44s90KMq3D3L6Oq4/sDHRSPInHHBbh+crtWKEuW37rQ0ASXiPA
	7Psxd12FWGY9KFxWjOpoD3oladFUdhdD0hm8ciGjA7l++2k=
X-Google-Smtp-Source: AGHT+IEqV/I6/z7/jDgPXn8cMBQ3jLjBLYlnGZUzifVpoGCFn9izQNeuUTDoXrR00+qnRlk+dTe7Pw==
X-Received: by 2002:a05:6820:605:b0:5f9:4f8c:868e with SMTP id 006d021491bc7-5fc5e6001ffmr3171575eaf.2.1738958996002;
        Fri, 07 Feb 2025 12:09:56 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:54 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:13 -0600
Subject: [PATCH v8 16/17] iio: dac: ad5791: sort include directives
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-16-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
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
index 034228a7c059f136cdecfb4683228d0be4c37477..4f28f49071c244bfcd21c7553aa3e39e9751490a 100644
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


