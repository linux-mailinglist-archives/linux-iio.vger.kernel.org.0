Return-Path: <linux-iio+bounces-25874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A139C31DD3
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A43421C59
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2680303C9C;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToYtb7O5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76731277011;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=IOArwhbgNlRWe3kdcTU0lrjNVaNwIVhZJMwcSxMpo9AbH3EFYQqxlwBHpRA6qUGQBIyLyW0vxP5ktoQQ+6a6IHxWudtO/wXSTW5y11mjnrcsU1s04hFVepWDCz6o39uV5CY8TnIBcITuO9dCUjcbrsxfuWOmoCMgGrT0kelMD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=kgkQ5ZLEY+CnmbfHIWE+KeYZQnP3lZR3rOo4iJQzQDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bs1lgvbmA1F/oJ/9kUZaytTkbyCaEXL8cZLbLhGly4dF4Ez78yJlgdTj3Usxje7zdj90eSy9JjVpxPN+NSujMN1qNCoGL7ORKo/hdJECkJzQavkoid7hYqHMRrw2SO7YR2zKpF02Bk54CTUPyLg6qn12Qmqf9yRwcsr8AVYCz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToYtb7O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 038C3C16AAE;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=kgkQ5ZLEY+CnmbfHIWE+KeYZQnP3lZR3rOo4iJQzQDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ToYtb7O5WGWAnh7ipgoGTBTUZx4KOmtAsIr5B6dPrasmvM9oh5DgPN3uuG6cNcfAM
	 dUUkwh4B9e+mlvxwRaPqQsTmcxWcgitQu3o74+Zbn6oCgwCaShKL5fj3ON+pLdjqvF
	 l6TGVeeYT1I4BUgxtOx06npYwqsuoFzctKrfjlhs0tYC4GvwMjQL862hDvWxDDpszU
	 Dzg1pTQvDd5Nt/CiOeHYTZm61lft/GD2eWugyZ+qbz7L5Y2pdV41mtc4lbtMurez4J
	 1rGAXUuy5jLi+f1avGzD14oQsjdf7idY3hcks3A262q5/6sNeotx1BVjO32qz/AsHV
	 4MqY1DX4sCJlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC4ECCFA0D;
	Tue,  4 Nov 2025 15:34:33 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:07 +0000
Subject: [PATCH v4 02/12] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-2-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=1997;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=46famHhMqK6pdPFGxx4pY0sifQUpnrHIY3AH+TPxpr8=;
 b=ALDlYE1NquYKGgazTyb0hXprmbuPRP7TCR9ISRMcP4MU62GqaEyD04k3URvM0kGcyzmUfKnxS
 wBxSGEmTqAtCaiKcRBC8prYyY1Rxn0rqG+WxHhvrLBZPJ2g7pnUXgPB
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



