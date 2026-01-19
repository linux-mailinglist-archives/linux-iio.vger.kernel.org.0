Return-Path: <linux-iio+bounces-28018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D41D3B9D3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2F530837EB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811392DF6F6;
	Mon, 19 Jan 2026 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV5dhI+g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E852E8B9F
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857726; cv=none; b=pAS4AUBUVxzVVjx9bJQw3Zlc47RZHSN/Wi6e3ydko20Pffw/ReDqENkTRCCuPwJt5EgaeTgssP1gbNKwDB3ukWwUzJLA6BfKahCwgsutnovAZfowxXrjRyKaFEJP2rSeLRYKmDuQ0OEcjiVSBzUsKSOPrF/jqzC5CXYqWJxli28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857726; c=relaxed/simple;
	bh=4lpDDwrcGvIkbEHaxw2T/PUYhL6QNu4em7Ce1o1c/OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0DsgqBBQXiBZc4+WirbNd6mod+rlAZDQJuUQ63Vb+STX8iKgRvmsnLdXLY9IpmGWHu4r8eXbHAia+KWUgBek6XQ5ulsvYId8VhhECKkxgoLlzrfQjCushpFQEI/Kr0CDyQ0OKTRZ9B6ueQDd9lccAbJeLEV0kuyT37FOAoUirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV5dhI+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22F1C19424;
	Mon, 19 Jan 2026 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857725;
	bh=4lpDDwrcGvIkbEHaxw2T/PUYhL6QNu4em7Ce1o1c/OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HV5dhI+gIqfgtYf776ZVDKtm1eVBxcr1Cq3Kb4VUt6pvJcxYDSD/+ZWAKYfVvjKol
	 JRYm5+EdxV6bbMpYesCUkbcctO3bAyt4RtBUmnCGZ2UwGh+2841V/pdqQch/tyjW0P
	 bzzwFHLR791YGNQEg+BneMNLtrfLQFGsLdWfXZf4/y10+GXcS/dExSuMC8gUUa6wat
	 qMjP8Ua5GsSCPH/rqE/l9DKvopi7FFxnK7G+zMF8BB0I1K9UIsKjUSvFufzuIVsCN1
	 5cNZBxD6VakWrqEdmqOV2GnQok3NgEiGJ8/BnKN+F91Hm0NzVJL/oGKld9WzUlLtwl
	 6h3eezlEqbDfQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/11] iio: adc: ad7124: Replace device.h with more specific includes
Date: Mon, 19 Jan 2026 21:21:08 +0000
Message-ID: <20260119212110.726941-10-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119212110.726941-1-jic23@kernel.org>
References: <20260119212110.726941-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Separate patch to make this change more obvious.
This driver makes no direct use of anything in device.h but
uses both include/linux/device/devres.h and include/linux/dev_printk.h
as well as needing a forwards def for struct device.
So replace device.h with those headers and the struct device forwards
definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>
---
I'm still tweaking my iwyu config, so currently it doesn't suggest this
one automatically. I'm interested to hear opinions on whether it is a
good way to go or not!
---
 drivers/iio/adc/ad7124.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5d3be891fa7e..84da872fab6f 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -14,7 +14,8 @@
 #include <linux/container_of.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
@@ -36,6 +37,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
+struct device;
+
 /* AD7124 registers */
 #define AD7124_COMMS			0x00
 #define AD7124_STATUS			0x00
-- 
2.52.0


