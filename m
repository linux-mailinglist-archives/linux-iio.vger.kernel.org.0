Return-Path: <linux-iio+bounces-648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164B805AB2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A77D1F218DF
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3C692A7;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJluzrx3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01869295
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8800C433CB;
	Tue,  5 Dec 2023 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796006;
	bh=DaHrib+sTZO8JDKwkqWnkVTCyGR/kWgXeCaVSnxuHwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JJluzrx356IN4ryQMt3P/32hsop/PY12c5QwMK1+bUAJz5W/0gkV2JRnVNm8RKCOE
	 vZeKu71lGBiuwRv3aysW1tciC8i7OvOmNlqhtAbXucBu60INCb9uWwbxYHgbVVAJ+3
	 k+gAUA+sy/4YM5JipLiZxqvHkQBycKKvrUZ7C4AtRrGOKsW8r8O6h9HVZK4962PZU7
	 qL7nwKYfMb5mokPiex0tM82rK194+B8i/uvZRykrqK8fzIXtGFRNMH/NipaLiEZMll
	 d4wxYag1AuYb6weXnnJ5oPBNYajaIjhBzZxSdyzpleEIvV2jbbETAytj+AtwR3ae58
	 ZSU/cfyVlO/gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA7C07E97;
	Tue,  5 Dec 2023 17:06:45 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 05 Dec 2023 18:06:43 +0100
Subject: [PATCH 3/8] iio: adc: ad9467: add mutex to struct ad9467_state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-iio-backend-prep-v1-3-7c9bc18d612b@analog.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701796004; l=1696;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=p8tduALMO1r7IbePJPY0Lc0yef4vRn/57H1G59OPIGE=;
 b=B0qup201Yzg8CckSdwz51Krqv80mIBFSdso8cdYL+njub3wLOeyaCY6flSfz1AOM/lx5yLif5
 YrKHM6SllqpD2AVXJkPh6YwjuqY/TkT1gMK4imfO7osUMaFtD6Tobdm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
are done which means we need to properly protect the whole operation so
we are sure we will be in a sane state if two concurrent calls occur.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 0f2dce730a0a..badbef2ce9f8 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -4,8 +4,9 @@
  *
  * Copyright 2012-2020 Analog Devices Inc.
  */
-
+#include <linux/cleanup.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -121,6 +122,8 @@ struct ad9467_state {
 	unsigned int			output_mode;
 
 	struct gpio_desc		*pwrdown_gpio;
+	/* ensure consistent state obtained on multiple related accesses */
+	struct mutex			lock;
 };
 
 static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
@@ -161,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	int ret;
 
 	if (readval == NULL) {
+		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(spi, reg, writeval);
 		if (ret)
 			return ret;
@@ -310,6 +314,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
+		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
 				       info->scale_table[i][1]);
 		if (ret < 0)

-- 
2.43.0


