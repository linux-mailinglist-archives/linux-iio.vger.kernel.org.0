Return-Path: <linux-iio+bounces-7514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64BF92F0DF
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8237A282ECF
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0691A00D1;
	Thu, 11 Jul 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT6lmSZD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5919F49E;
	Thu, 11 Jul 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732584; cv=none; b=i/QtOpoWBylMrQjAztAgePMaJWp91QisTvB/FxMGZ1jL4IL/QjMW7agOJ+KJd6tKpNgw8hx6fcoa2Xb4/Xl5u1qj/WguSuxqITLmyQ3t91J1PivrkuSH15yQufhverqxO7LJyHd2XZ9A5CSB/j2yhC0JnF4Hz0pp9aHQvyVLZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732584; c=relaxed/simple;
	bh=Ryx9odQE94LbQFlGjL9tBqUwo5hOa1lfTe7ez58Wmd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYR+HKw6k+Dy4qu4LFJzSzPz7Xk82o5fUVv5zsikP9LKAokoFtSW5gpOTY3/1wm3xilBRfpkDHmOzxHMgNYwUFdaKZjyZGnfF2pMv/Jo6Ua7Bk/O9KL8l/psDNyMBOUraGNr+MS9RjKSOschM3G7x29KJcIjY3bqib422LVbrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT6lmSZD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eea8ea8c06so17733461fa.2;
        Thu, 11 Jul 2024 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732581; x=1721337381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mhnPhXWMiIZAO7ocU9BDacUYcJJKaQsmKDtkiOOP4g=;
        b=NT6lmSZDCYWSPrKs+Z7qMSHOUxiosYq8XKqGQDygzifcGwrOfLE/GPoVL0dPlZsJtz
         UIvw4jNIBrnTLjLT+nEPaycJpEAM3E/RNA5u4xQ0cObW6B9MeNneDtEHA9Dcl9nYGiIN
         uob8uj/EENyJTyf5uEPhjs7MN6hdbf6gLVDnkWQbQujlGOFiD+mSl4Z+34hjc6AjK7eA
         Xf1ZjqZUGmVsYHbj72Y3XmvBudgizi6tMee6s02TnpSXTZuSYztNEKmrgLcdNf//cdGu
         xkDrY4bXnuk80NZHl0jC9L1VLWF3a6IyEzlvCThSPweE/OvvV9LqbxR1mppK+T7zuqXo
         c+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732581; x=1721337381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mhnPhXWMiIZAO7ocU9BDacUYcJJKaQsmKDtkiOOP4g=;
        b=Z+XIclVFStSLuRXwRWIkDaqvQ6tS1lOTonMk5e/zFSzNwhoDTzcQ/D6CbC/seBDsA5
         ZeWw0yutljXRw7946UexVnGNAgmbv51oiZGld8DuZdTaHEeLOqOX+brIdthtK5eG0HTo
         PAYeBgTir0oTeobto3KdQ0GTO24MY1jNL+KyBUK2QVqrCKCRlB108gEidTzCZxTwTaEG
         zLqbyvK+OpFU900yGU7n+TPsUhz71km7QQGXBzSyU/EnQbBllOpa8KPhqKbLIvUM7d3+
         PBVE5KyvB3CbhxXWA+t8ojDQcFX0lQM404aaOUyMLS7YiSRIxNmaj/AWiBBiQb7WTJch
         CrgA==
X-Forwarded-Encrypted: i=1; AJvYcCVSG6KtaXYouStmxUFePBalBcXk6X/JeHV0aY5Er6QtFRYeJ2r/0CLheGDgUdjdNGwLRigaKbKKLMghkDqDZyXvQnQgKX3psWhOH9tU2n/oMEg0FFqZP7/OOETV7P9AbaBU8vZLf81pCP6M4RVnkDPYqPM9soF3W2BoTED/OauxlOIbEQ==
X-Gm-Message-State: AOJu0YxNmzOHWnRE2Dr/UhNNsDhO5KWejAF9Xw5tsiKuFOdyHontJcBn
	YsymP69AXiEAI/Na/FzrDI+rmGJqs3ISWySoAQ5JLhxUeB8sB6eC
X-Google-Smtp-Source: AGHT+IFzXoWK10tJ6U3HY93qesHOTUCHNRZAYl10K7Vyd2rqgae59p4P8wMEhhtTEb0wHTiFKN6O/Q==
X-Received: by 2002:a2e:bc13:0:b0:2ec:440c:4e1c with SMTP id 38308e7fff4ca-2eeb30ba2bdmr71918451fa.11.1720732580492;
        Thu, 11 Jul 2024 14:16:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] iio: pressure: bmp280: Sort headers alphabetically
Date: Thu, 11 Jul 2024 23:15:51 +0200
Message-Id: <20240711211558.106327-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-i2c.c | 2 +-
 drivers/iio/pressure/bmp280-spi.c | 4 ++--
 drivers/iio/pressure/bmp280.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 34e3bc758493..5c3a63b4327c 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 
 #include "bmp280.h"
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index f855f56a1b06..d18549d9bb64 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -5,10 +5,10 @@
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
 #include <linux/bits.h>
-#include <linux/module.h>
-#include <linux/spi/spi.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 
 #include "bmp280.h"
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4b0ebce001df..ccacc67c1473 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/bitops.h>
 #include <linux/device.h>
-#include <linux/iio/iio.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/iio.h>
 
 /* BMP580 specific registers */
 #define BMP580_REG_CMD			0x7E
-- 
2.25.1


