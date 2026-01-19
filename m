Return-Path: <linux-iio+bounces-27966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6ED3AC8B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B9293035404
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F9376BF8;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIe3xOwj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C537BE62;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=ANwhNrdeM48PjfYOgCTyIwj+n8+alJ/rgY9I2bWghjkzU8KvOUyq7b8kYg88fq8fm1mf5Qh/NUvufiRGJlbvqDHknabmQ6ZD5ybqgJVyUMtW/sTVJVuOhqz4/rxeRhS8OzyP1Ey3UjfM8eCJaKFUDyaqofw4UTXLFHhr1qVcZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=y1m1SiLaohoC5eNbpZldUkqlDCAqPqNXgONSe2+u36Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFT9zcxwA45oAAAqEght2twNzjCR7J2dkOLeMIlFMREt5a0RKgnXRBCCluW263Cyuzfwxba7Pi6jelMtzjTWr4Qox4gsQ40LkWZT014uybk2AdrHX+STw7UTvdQFOUABGuJic8R8ZxF7wtytr95YAmA2c61eNQOm7Ey4KoMbmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIe3xOwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3949AC2BC87;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=y1m1SiLaohoC5eNbpZldUkqlDCAqPqNXgONSe2+u36Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WIe3xOwjeU0V/1UChjxVWu1BT3a69bVar6MVjawm9GJjUT1vkpNgK3aWVSVLBBlar
	 jO4QQJzrgDVXjwPM3M4uyMXTR7AeeCH8B+JXfzZ2AzUeQvoQpiyI7jmp/0NWlhC4B0
	 Hcubw76y6+u/W8lyLkPfXgDlhjj7GDrzhPPhWeBZCBN6UDPcrupm6G7KqBI2qaA3Sm
	 /aoho/1/Pmm3XjfM3WW4l8Q0w5lSUNxuIADJ1PbEh3kq4qOW9EiWxeApMlZBYEpJcc
	 2zSnjmjb2pOt8EFhR8+nJ9XqAGn9IKiOmgZrD4FYl8Q44bLSzT/wpNJwwVMm75mjME
	 6dY7XIEHsIdAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB0DD29C30;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:36:59 +0000
Subject: [PATCH 5/7] iio: amplifiers: ad8366: use cleanup.h mutex guard
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-5-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
In-Reply-To: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=1898;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=YAYuOUTweoFKOoWx+os6umUAifv0dwftAt5d8TlJqJM=;
 b=XO9ZOAiOXRraSPnBYDMJ92vscFlv6RXnUB1srGcO5GKbPh/9atl/9cKD5LVevvB4MJtc5/IhN
 zfcLQaRgzWQB153uBkHdfmqCo/RgQq41EGJrnzH+zdwQcjWIwq29kC5
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Changes related to mutex handling:
- use guard() from cleanup for mutex locking
- replace mutex_init() for devm_mutex_init()

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 160a8ab0c2ee..26856cb4216e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -17,6 +17,7 @@
  * Copyright 2012-2026 Analog Devices Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -164,7 +165,8 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	int code, gain = 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch (m) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		code = st->ch[chan->channel];
@@ -210,7 +212,6 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&st->lock);
 
 	return ret;
 };
@@ -267,7 +268,8 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		st->ch[chan->channel] = code;
@@ -276,7 +278,6 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -336,10 +337,13 @@ static int ad8366_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	mutex_init(&st->lock);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
+
 	switch (st->type) {
 	case ID_AD8366:
 		indio_dev->channels = ad8366_channels;

-- 
2.43.0



