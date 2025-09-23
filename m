Return-Path: <linux-iio+bounces-24367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE7B950B3
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 10:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B3116B9BB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FB31D754;
	Tue, 23 Sep 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG/j7+Aw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1231DD91
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616888; cv=none; b=tSK0I0T8zicP9TayhJa8w2IteBeHqANXxhNF0XKsPR9syp8com1ZrcdbY1zPqlwB3W4FNWNFr7IF/pOvLzwfrOXoJArxkxRb3GCZunxAjbuLJcZQ12/7CVm29ksqpAh03ZUg6qoojIW+3beEXcQsQkO3XOHYBdUc5NlG35gf7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616888; c=relaxed/simple;
	bh=BNMIT4pdXXYz9LbwWf6Ah+X35b12sDSEAEkiV/BrhMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESWSWyESG4oBtYK4bK3mG0GIvFJbApORlY2n1d8TriqGrjbvWqWlYp/GtZ3gYcKAMBdWZmt+He3u68HRRY156Rn/DhbicMvPe3UnDQwtVJmu5anjflP00wy5V/JmCi/B6I3NPsHybXPrMmjkEJ3BJo2r/YnvooGanSAW3E/wtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG/j7+Aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C609C116B1;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616888;
	bh=BNMIT4pdXXYz9LbwWf6Ah+X35b12sDSEAEkiV/BrhMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FG/j7+AwiRIzYjld/eXIeQ09EXxmIsHvwbyGppRW5Pq+jb3zJWPNm3kCxyoSJKU+r
	 7sGNoYODQYIqhTvcdBUM1JJPzzYZKYpIr90ktcKsUVEXZyIdKjC0AsuGjYmGuh5lE1
	 jkW0AcC9UjCLH9kPPaekkp+AEprdzk+A8F7ztQXy4oIZB4RIgOmlVFDVAG/yf7fkAC
	 IQ+Gn5/DyarSQT2VUHA+ODePnA+0VRu3CUq82XDiZ39chOUTnIVgbDR9Pv/Dqlj13p
	 NVEwkkrxKTml+1OWFC1ubGEGTMSze/dOOauKKd1L46li4CvrE7kRC6BVQxrbmwEMZR
	 KiCaYOSItknuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617AFCAC5B1;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Sep 2025 09:41:48 +0100
Subject: [PATCH 2/2] iio: dac: ltc2688: use the auto lock API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-dev-ltc2688-minor-v1-2-ef92c441dc42@analog.com>
References: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
In-Reply-To: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758616915; l=2667;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6yZ3xMxARLZBD4UHPpqf5e19eNf49oSofH3MuyGQxbU=;
 b=SScT76jCCJfUextKNuxpmW3OwlMcUylhHKjDk0DTIqmXlfZsdhec91xEB32ETQHOjt5oxxaf3
 CyKhVEdy0BUBpY7bV/A4hA1Qq3JKavzzHJqJ6lFixyWXm8g8N5JmYwz
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
 drivers/iio/dac/ltc2688.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 57028d422868ec48e6900ef1cc4be6dee9cd4547..628e96e20375c06bffe16878fc90cfdde99ae565 100644
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
@@ -236,15 +234,15 @@ static int ltc2688_dac_code_read(struct ltc2688_state *st, u32 chan, u32 input,
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
@@ -359,15 +357,13 @@ static ssize_t ltc2688_dither_toggle_set(struct iio_dev *indio_dev,
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
 
 	return ret ?: len;
 }

-- 
2.51.0



