Return-Path: <linux-iio+bounces-16635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB8A58728
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B9188C0AE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A61E5200;
	Sun,  9 Mar 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSUrxD1C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0641F874A
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544520; cv=none; b=Ax4TVssi0QFm+OBUo9sIhIRl+FHVfpy320Wz8+xday9NHXRAXBMZf7P4BWuaBw7vHGHN8daXhav6c2MuU0XM6mrqL3l3rQ4OOPi3fd1fcw4kHCa9ow7DX25vQeeTT/IBLUYBxV2rP3MqQfINuiAThW+fz3o19ShDJ6SKm4BwQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544520; c=relaxed/simple;
	bh=s9RGDagUAx3xy/1YR+KvHllOXrhbieAq95J0SYU6xWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzlZlWL0eNkDYKQ/wFf/0+TfVRfY7T7JuZLwpC8x1WbtsKYdp4hT2V4H/QPiJM9fSaXBZJ0XIzsuNXAePEeqUeXr2K3Fwj0OGC3BZLPFQU9YQe1WeRzLw2ExVUNaB3vog3Q9fix2a/8vKDVG9bl7SqX31yCsUzxR1512OiiFnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSUrxD1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124B2C4CEE3;
	Sun,  9 Mar 2025 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544520;
	bh=s9RGDagUAx3xy/1YR+KvHllOXrhbieAq95J0SYU6xWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSUrxD1CcMtU2AnjcywCnTQiTaRIO+RjHuytTiXScjujl10SN3l44iB06nqYdWZoN
	 8b0hmouJgioKNgXHJy57YXAS/YDe+1Z8XGhL2F+g66YRunESs/5rBj3ECAk/o0I9GX
	 QUEkyYSDvfWZn7rV/Jh7WC6NB0baMxHRPC3HjJm6kXyyILpbD4pguW3uAUqv+7YaXt
	 1Kz7D8Yc7xCLkUi4HVSR6Hc4BgOZCaOwadgDpPLCH4kCcvdNaqPcIZXa14NdM0jtCU
	 1QMxYY32TpviA2P9Wz+T5vnE6XoyA+S16mcZpLyRiF2S3lf98mqTxBk42fgGQyWZ4F
	 EISp+sGewEyuA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/16] iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
Date: Sun,  9 Mar 2025 18:20:53 +0000
Message-ID: <20250309182100.1351128-10-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The trick of using __aligned(IIO_DMA_MINALIGN) ensures that there is
no overlap between buffers used for DMA and those used for driver
state storage that are before the marking. It doesn't ensure
anything above state variables found after the marking. Hence
move this particular bit of state earlier in the structure.

Fixes: 10897f34309b ("iio: temp: maxim_thermocouple: Fix alignment for DMA safety")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index a13efde76397..db2149d5f78c 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -120,9 +120,9 @@ static const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
 struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
+	char tc_type;
 
 	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
-	char tc_type;
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
-- 
2.48.1


