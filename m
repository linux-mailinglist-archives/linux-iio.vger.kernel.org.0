Return-Path: <linux-iio+bounces-10660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1449A0C80
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854A81F22075
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF28020C003;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wkn6DzCG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDB14F114
	for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088522; cv=none; b=iq+S0Vhh9CaCGGay1rN6zYZaTs6aQSRUtOyuwqV8olQY8A5VOMPuMqYiT2FbwqJc8qlV180RgZywn5NbNNTH/WcadQzzjS9XMkcw8QDqe9miqxJJdBGhzv7BxRclxQ6o7c8qQNfhMcQL5F2705CCIrpWbEdipUgrXrU0zjywTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088522; c=relaxed/simple;
	bh=tWjFtBmSuKELYDNq4TRiHv0QfjxoJ45jsJ+2VcncvXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJLOSz5oySG0DJTDNApXM7Uaq/GgjrUA5NyPyP+oZq/ptfP9AbdLkC2PnqxPFnRyel9MslJ+sfQfwWK+DVlnjGQRxL8jgGBBzQGsw3uYzw+1E69JwheLKg/CG8G5EVyYb5fT8GEcxnKv+Z94aBlDlneg2PgiPVrX2ClxRZnxP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wkn6DzCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47BEBC4CECF;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088522;
	bh=tWjFtBmSuKELYDNq4TRiHv0QfjxoJ45jsJ+2VcncvXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wkn6DzCGi9jxOr5FeI7gRxxRm3i4C3x9MekX+nVX0yI+ieJXUOd3NtAD9c+24haig
	 AorjG3HWwriPu8Yy7J3orZvhLFgv9OKD2egWHF1dSR3/5Kjj/yz2VTfwJi5HLnLScv
	 7+1z0oUS+73aP1khUxB65pizPqgST3G5gZO9iEM56DJbtX/dqn2Xoh9FLKEjNVKfr2
	 KmMbsy36gzwcpPUAKOOsq7fePK+JvQ3wiFzBPtyco4n94pB//ycMgRD+gBwnaOyYgr
	 8i14xV7dqaFBp11n9e0Pmw9RECQlKK8pK2Av2uXHT43P6COyOfAhID7W+FCTKtXrYt
	 Ggf10bIryl7Qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37193D206B5;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 16 Oct 2024 16:21:59 +0200
Subject: [PATCH 1/3] iio: addac: ad74413r: drop reset_gpio from struct
 ad74413r_state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-dev-ad74413r-minor-improv-v1-1-13c9c769237d@analog.com>
References: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
In-Reply-To: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
To: linux-iio@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729088521; l=2264;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pAXfyFHbRW/SCpMOSEqzhiSiKYRJaTQDO64j4kkjfgA=;
 b=ahi318fIe2pK7kqF1zYIn/ZQPsES8alHToNgzcJw+RVj9yTqqp3uOyL3VpwjvOr1pzrt+N934
 mTnvHsXScTKAers5jFF4OmMHFJ0rSn6QHpMY2Dd3qCyTBulhtXs94Jy
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

We just need the reset gpio during probe so there's no need to keep it
in our state struct. Hence, move devm_gpiod_get_optional() into
ad74413r_reset() and use a local struct gpio_desc.

While at it, request the gpio in the asserted state (GPIOD_OUT_HIGH) so
that we already perform the reset while requesting the gpio saving us a
call to gpiod_set_value_cansleep().

Also, explicitly include <gpio/consumer.h> for
devm_gpiod_get_optional().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/addac/ad74413r.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index e50c896a07668..550e2460e29ca 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -9,6 +9,7 @@
 #include <linux/crc8.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -72,7 +73,6 @@ struct ad74413r_state {
 	struct regmap			*regmap;
 	struct device			*dev;
 	struct iio_trigger		*trig;
-	struct gpio_desc		*reset_gpio;
 
 	size_t			adc_active_channels;
 	struct spi_message	adc_samples_msg;
@@ -407,12 +407,16 @@ static int ad74413r_gpio_set_comp_config(struct gpio_chip *chip,
 
 static int ad74413r_reset(struct ad74413r_state *st)
 {
+	struct gpio_desc *reset_gpio;
 	int ret;
 
-	if (st->reset_gpio) {
-		gpiod_set_value_cansleep(st->reset_gpio, 1);
+	reset_gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	if (reset_gpio) {
 		fsleep(50);
-		gpiod_set_value_cansleep(st->reset_gpio, 0);
+		gpiod_set_value_cansleep(reset_gpio, 0);
 		return 0;
 	}
 
@@ -1378,10 +1382,6 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
-	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(st->reset_gpio))
-		return PTR_ERR(st->reset_gpio);
-
 	st->refin_reg = devm_regulator_get(st->dev, "refin");
 	if (IS_ERR(st->refin_reg))
 		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),

-- 
2.46.1



