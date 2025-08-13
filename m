Return-Path: <linux-iio+bounces-22677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F05B24F8E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9695A4EFD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48128689A;
	Wed, 13 Aug 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XwKHkSIO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E133288C34
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101787; cv=none; b=fJsODCbljnqXlPx9A2Y0kK5aPdgFm9bjcqFwZ4fUmdTpnlhdC+FXLOYGh4JHxJ5XUxWwHtSishoUTxdi3sSwS0NViX9FoQdFAtsEF0boGvU5ygivfiFQllFFvsxDwpE8IkWyjV/ZM3qoOuYHcI0EjGHRL9K68wlRgLjiFS+d8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101787; c=relaxed/simple;
	bh=ApN79Dtt5jypekO/KhlE1DLYefDIQhV0vkpnkiN4Xko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac/nsBJfLoi3zVi7yY13e610IGk3gf0O/YOPvh8z+LLl5uRLdA+5yltSV/AUJvfj8iyBpFgKN/00NfVakK3K7EokUGJvWJ15F6FXvRCWp9F+7YP4V77EmIzSbWOaKZuEoYQNMBTdDstjjhTtDajSlucPOL/4/pRlkPgcsAi+n74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XwKHkSIO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=TCFyd8etVT9azwaPs92BWUORGBNE2YBN4q+4LkBM8Do=; b=XwKHkS
	IO0ibfv7Y+8QCxivRG8baE2TiRouuIuPToduD3zcmvsySw8T41QCLriBJ5xAHpMG
	2NMSncLeg0c3DaqmJx7VfNnU3PEJjiGIML+8F5PKnljjUo3nBxbg9iSeJPNey2o7
	e2f4JG9LIUzVlOUOIWACzKhktltgXkd4sd+ip+J97lUE0omIyKSYDzbMWYZS0ZqK
	+5uO6nDnsW/AnNoRIYz0VNVPf0vT9r0jzIzeqfG7nivoIdgH95O913q/ph99qcU6
	YfWjbrglkO/K6k3nSoaNbRwEfALrgWZrmKlmNWFQ0iJRfvZFD0j8wic82EJ1U13Y
	BYgbKGILeqMmwlIQ==
Received: (qmail 694745 invoked from network); 13 Aug 2025 18:16:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:06 +0200
X-UD-Smtp-Session: l3s3148p1@pgdOeUE8MJVtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 05/21] iio: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:51 +0200
Message-ID: <20250813161517.4746-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/iio/adc/sun4i-gpadc-iio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 6b8d6bee1873..e4bc2e199a07 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -154,7 +154,6 @@ static const struct regmap_config sun4i_gpadc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
-- 
2.47.2


