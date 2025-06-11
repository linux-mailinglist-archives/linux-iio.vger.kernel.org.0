Return-Path: <linux-iio+bounces-20416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8CAD527C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE04189E9B4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38827BF85;
	Wed, 11 Jun 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYa7JADi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9727B4E8;
	Wed, 11 Jun 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638653; cv=none; b=LK4b8JKCVpjui+WpkGF4ZqYtH18EM8eZ8aj+InT9brokZ4+mTajx6CDyYm0AFvEMHmRZm7b/PMjc04HvQfnSJ5kZmRxfpMs2b/BmXCILGnblsBizgakmuwAdGIlCBYkgkGVbNipAjt9B5lVNbm+l6OvxtnOMWL9ekqCwnaRqRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638653; c=relaxed/simple;
	bh=XY1bFw2WKrjGrjUMr6K7T7hPamKz4LzK9z8ZINQUPZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwDy5AqAnS1mVq6rFmdF569hACJ3w0ZJz/g+jVQXFxdXLNFpOTMedPhiEswrbD7x2A9az0Wact2JgsPDzelfK0D6IzF1diWHWCvlk4GX4kur5OqRVSjqXuThpLj/Fhk3bllG6uvkpNqbpE2kKNsq993iyYkoJuZGx9CW3hVkbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYa7JADi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E828CC4CEF1;
	Wed, 11 Jun 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638652;
	bh=XY1bFw2WKrjGrjUMr6K7T7hPamKz4LzK9z8ZINQUPZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYa7JADiz4vkuaVd9vaqDCAVjdCcDvLZc9z811fTBpqSRN9W4IorsCBqtY95TTXrA
	 t6e5T/AAoGoIjasNBY+R6YtdQGNIOFqzemBuzp8FxLGYcsnlU0qo1iUp5KuyWWlILl
	 0C3kpXeBUP1d7hrW8olblffTXajjEBvINLpAs5Y6N1FC7dNPmy4xJA0PFPUHwjpUxW
	 4QfTSK4r8/kCqB7LGQyCNugNqAhetxWdxOoXiQJsh8KJQZ7gEX3t4N42Kypvndi8MO
	 VsJ4FbtBLIxmzpCu4EmOEJsj4oaZhjW/BJso/ykP+zBMlbewthc3wVTmEd3rdXG67X
	 Ircrxk63TlvYA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: Use dev_fwnode()
Date: Wed, 11 Jun 2025 12:43:37 +0200
Message-ID: <20250611104348.192092-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611104348.192092-1-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org

---
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/iio/adc/stm32-adc-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index bd3458965bff..58b5838227aa 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -407,7 +407,6 @@ static const struct irq_domain_ops stm32_adc_domain_ops = {
 static int stm32_adc_irq_probe(struct platform_device *pdev,
 			       struct stm32_adc_priv *priv)
 {
-	struct device_node *np = pdev->dev.of_node;
 	unsigned int i;
 
 	/*
@@ -421,10 +420,8 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 			return priv->irq[i];
 	}
 
-	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
-						STM32_ADC_MAX_ADCS, 0,
-						&stm32_adc_domain_ops,
-						priv);
+	priv->domain = irq_domain_create_simple(dev_fwnode(&pdev->dev), STM32_ADC_MAX_ADCS, 0,
+						&stm32_adc_domain_ops, priv);
 	if (!priv->domain) {
 		dev_err(&pdev->dev, "Failed to add irq domain\n");
 		return -ENOMEM;
-- 
2.49.0


