Return-Path: <linux-iio+bounces-25739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9AC2501D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7266C3511A7
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5933491DA;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy0iRq19"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CD33031D
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=tx+g4eQMf0EZnD7HXPaDwno5/7y0uheo3aVD5cC5DtrtMuHjll08epbHIdOLqkOVuauJ3EwV2Ym9IDd7oZfO4uIbu0GYkQc84nfq2NlfPirJWohPwhDOGg2FZqQg6FdN3HSwXoK2Stzbqp2kpheRRjLeLI9JBmIibXVp11XoVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=kgkQ5ZLEY+CnmbfHIWE+KeYZQnP3lZR3rOo4iJQzQDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ohc2AcM8KEzAIjB5is5G9OfoPyQTUoEpHmre50Y7l/hTf+GcNUhL8HyUgwoCNrXvvPm7hyxyA442SbUy/6sRA3Uk2DFS4IB6a7MjeU6lKTo9XN2xu6BbERMXs9oWcfd5uX7jAXX2IRD1YD3yEiV/wRoVMtK3PZ1gRKbRPkRG2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy0iRq19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7512C116D0;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913861;
	bh=kgkQ5ZLEY+CnmbfHIWE+KeYZQnP3lZR3rOo4iJQzQDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yy0iRq19eDk5NC+89Gui6R/33l40rjyzrHXSxgWZsdTld4cRUyhy7s88RmLD62hxR
	 WpNVB7xdAFxZRx5WtH57KiHiySAOQtbW9ZWQo4x/R5E5ZG1aqmD1whp6gEsZpniWMw
	 7MEs3nCRlyQRgWw1kLNAjFo8Hb6OY8IvZHwyxMcLv/skAaObA7vczwYfxtJyJnWcI+
	 nqaY+sP8j1vFXGE7PeRhBxPmi634S2kQRbxhuMQoE53U7SaiITw5OXe31jUqs2NNHn
	 +/KFfec7l9z3JqdIbXpEbJkKGphHy7Vf8yVu/+UXOpBt8BJB1RZF23GPs9qy6R4bWi
	 JTmuBh8PZlJhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7ACCF9FE;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:23 +0000
Subject: [PATCH v3 02/10] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=1997;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=46famHhMqK6pdPFGxx4pY0sifQUpnrHIY3AH+TPxpr8=;
 b=00Tar9g9oEW48q/R54iqV5VAMF+tEHPWspqQcR/wo5tKASkRMvrNZ6g/U9I82KC41dwBhTCL8
 UloJ6u81a4/BV3uCexiQ3h677eAS46Dhg6wcQrQ3dm93+ICgHJLffFT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure to use DMA safe buffer. While for i2c we could be fine without
them, we need it for spi anyways.

As we now have DMA safe buffers, use i2c_master_send_dmasafe().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index ad304b0fec08..de5e4e0e397e 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -47,6 +47,10 @@ struct ad5446_state {
 	unsigned			pwr_down_mode;
 	unsigned			pwr_down;
 	struct mutex			lock;
+	union {
+		__be16 d16;
+		u8 d24[3];
+	} __aligned(IIO_DMA_MINALIGN);
 };
 
 /**
@@ -265,19 +269,18 @@ static int ad5446_probe(struct device *dev, const char *name,
 static int ad5446_write(struct ad5446_state *st, unsigned val)
 {
 	struct spi_device *spi = to_spi_device(st->dev);
-	__be16 data = cpu_to_be16(val);
+	st->d16 = cpu_to_be16(val);
 
-	return spi_write(spi, &data, sizeof(data));
+	return spi_write(spi, &st->d16, sizeof(st->d16));
 }
 
 static int ad5660_write(struct ad5446_state *st, unsigned val)
 {
 	struct spi_device *spi = to_spi_device(st->dev);
-	uint8_t data[3];
 
-	put_unaligned_be24(val, &data[0]);
+	put_unaligned_be24(val, &st->d24[0]);
 
-	return spi_write(spi, data, sizeof(data));
+	return spi_write(spi, st->d24, sizeof(st->d24));
 }
 
 /*
@@ -489,13 +492,13 @@ static inline void ad5446_spi_unregister_driver(void) { }
 static int ad5622_write(struct ad5446_state *st, unsigned val)
 {
 	struct i2c_client *client = to_i2c_client(st->dev);
-	__be16 data = cpu_to_be16(val);
+	st->d16 = cpu_to_be16(val);
 	int ret;
 
-	ret = i2c_master_send(client, (char *)&data, sizeof(data));
+	ret = i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d16));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(data))
+	if (ret != sizeof(st->d16))
 		return -EIO;
 
 	return 0;

-- 
2.51.0



