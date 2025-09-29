Return-Path: <linux-iio+bounces-24557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90948BA998F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C60D3AC4CD
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E573093B5;
	Mon, 29 Sep 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATAvBb7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604392AD16
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156480; cv=none; b=jUjL42mXR+RB2+dodTXCMP8s5UPn0sEhhSo3LzBPBrgbnNNt2ybWhDJbjeLSnUtmndCfiVGMUs+Zmzuu1h2Gc/ibQrbxsTbXFnqUnDWSMXo6VZfkIry4+ggLTvo82I+5cpf5YesXJz684C7mgNq/HIISU6jEshK56qodAjmm+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156480; c=relaxed/simple;
	bh=1vXn1dEvBjJn2JjAGCl3H1teAGq8WEgk9d0TbeZ20uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ucw0hKaIzjFSkFnc37Y0WDDntQJH0KY4TSLLFkSPM9C7CaAquimYdWw7ZSLhynKr9bQRhWpCW0wPaKBsBlw1SPUPiUwBW0qO7TzJe1JdZCWxgRDIS8EvqHUpqJAbOagl1QSHqWNtZBn/LDe1U9qma+m7lRpjDnyXoaom6NzlWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATAvBb7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D64AAC4CEF4;
	Mon, 29 Sep 2025 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156479;
	bh=1vXn1dEvBjJn2JjAGCl3H1teAGq8WEgk9d0TbeZ20uI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ATAvBb7aF+1fBvvs96btgZQl/CtVIVpXvwnwub9jJ4ZjaZ6mbz5v0y4QsFlPMv2ib
	 UPTdlVS7N8AWdUVZd3EnrpSrJ6IYACqUo5d5oWhrmCg/A3bnICoOFrfpM/zzAhY3nB
	 jCTU8vyPCnOQ/dxktDFXiyD/Rge3fEoMg6eIasYSqYQPUxZUUXWNbzr6fkISCAB6zM
	 mG12JfhWfyHsi1b1noxFij9E66ajG3w+QX+U9u+Qk1mFFZVfVXmzuIvNKgkT/uTjHo
	 TzTsh2XYnPP6ytlfE5ZhAhZMX6WGf8BUUexgzoUdN5is/DJ2rkajFw3AvzZKQIIgK3
	 0i4AY0kUuvBHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8871CAC5B9;
	Mon, 29 Sep 2025 14:34:39 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 29 Sep 2025 14:35:32 +0100
Subject: [PATCH v2] iio: dac: ltc2688: use the auto lock API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250929-dev-ltc2688-minor-v2-1-47f9508ca4cc@analog.com>
X-B4-Tracking: v=1; b=H4sIACOL2mgC/x3MTQqAIBBA4avErBuQCUW7SrToZ6qBstCQQLp70
 vJbvJchchCO0FYZAieJcvoCqiuYtsGvjDIXAynSylGDMyfc74mMtXiIPwOqwVh22ozKWSjdFXi
 R5392/ft+t+3r9WMAAAA=
X-Change-ID: 20250923-dev-ltc2688-minor-0a68e956b098
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759152933; l=3254;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+06WQn+0U+kCXC/irDjEh0uloonpQaNhwKn4KabVt4E=;
 b=j/eTxj2w7RDiFG9F6OjxD7eMgsunK6sn8eZ0oUNpEA4ujNUluTAJNnKSLe2xzRZ85nFKcZEr8
 Pfym8c0eSkPDTEtLqlA0Jqx/ZUkxedf0qbbQw6QRsdUgOPGU85u+WHT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make use of the cleanup API so that we can simplify some code paths.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Here it goes v2 with the remaining patch.

Link to v1:
 - https://lore.kernel.org/linux-iio/20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com/T/#mccd0040948b14f05ad7411e170701129fd2bea90

Changes in v2:
 * Simplify to 'return 0' and 'return len' as suggested.
---
 drivers/iio/dac/ltc2688.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 7a2ee26a7d68730fe90d9cc91ea764f05eb61791..ca0ec131abad0203823db2589bccd407fba3c83a 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -6,6 +6,7 @@
  */
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -208,12 +209,12 @@ static int ltc2688_dac_code_write(struct ltc2688_state *st, u32 chan, u32 input,
 		code = FIELD_PREP(LTC2688_DITHER_RAW_MASK, code);
 	}
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	/* select the correct input register to read from */
 	ret = regmap_update_bits(st->regmap, LTC2688_CMD_A_B_SELECT, BIT(chan),
 				 input << chan);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/*
 	 * If in dither/toggle mode the dac should be updated by an
@@ -224,10 +225,7 @@ static int ltc2688_dac_code_write(struct ltc2688_state *st, u32 chan, u32 input,
 	else
 		reg = LTC2688_CMD_CH_CODE(chan);
 
-	ret = regmap_write(st->regmap, reg, code);
-out_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return regmap_write(st->regmap, reg, code);
 }
 
 static int ltc2688_dac_code_read(struct ltc2688_state *st, u32 chan, u32 input,
@@ -236,20 +234,20 @@ static int ltc2688_dac_code_read(struct ltc2688_state *st, u32 chan, u32 input,
 	struct ltc2688_chan *c = &st->channels[chan];
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_update_bits(st->regmap, LTC2688_CMD_A_B_SELECT, BIT(chan),
 				 input << chan);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = regmap_read(st->regmap, LTC2688_CMD_CH_CODE(chan), code);
-out_unlock:
-	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
 
 	if (!c->toggle_chan && input == LTC2688_INPUT_B)
 		*code = FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);
 
-	return ret;
+	return 0;
 }
 
 static const int ltc2688_raw_range[] = {0, 1, U16_MAX};
@@ -359,17 +357,15 @@ static ssize_t ltc2688_dither_toggle_set(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_update_bits(st->regmap, LTC2688_CMD_TOGGLE_DITHER_EN,
 				 BIT(chan->channel), en << chan->channel);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	c->mode = en ? LTC2688_MODE_DITHER_TOGGLE : LTC2688_MODE_DEFAULT;
-out_unlock:
-	mutex_unlock(&st->lock);
 
-	return ret ?: len;
+	return len;
 }
 
 static ssize_t ltc2688_reg_bool_get(struct iio_dev *indio_dev,

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250923-dev-ltc2688-minor-0a68e956b098
--

Thanks!
- Nuno Sá



