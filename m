Return-Path: <linux-iio+bounces-20530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681AAD6B42
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0F3AD379
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465671DE4CD;
	Thu, 12 Jun 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4ZzDTOM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158C522F;
	Thu, 12 Jun 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717993; cv=none; b=n3xBE30ttBkMGOZf/f/4oc2ztackzzot1Y2423oXL43+BHY+JaDgaKXVFr3twKlCYmKEABjGiQMlnifunwwF7CdZxfXEOLbsemdQ0/iY9uHRyIyiz4wYF0isLNHFxMs8VtSvw8LrnYZC7qaHEq0lzcNp8FYSbgevMZGogs8SGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717993; c=relaxed/simple;
	bh=q0g9wx98hCczaJZlZXB6wU/lJ/vXX/yhrFUxNtdecsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPetdIKGTPlUlgUiw1ILXC6sd9fkli5mTSH9ZPVj6nubVqY/JQK3r6cQlCBHzudKmOW9vpa9wULGYkXt6t5g9FDqD9RqAnpoAyRTF6+EsJfCjeV4GBv6pNStbsPCDFm43h9Gb4IVerR1A+kAwRU56VwJCb0TaSwGedujzk5yGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4ZzDTOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBD7C4CEEA;
	Thu, 12 Jun 2025 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749717992;
	bh=q0g9wx98hCczaJZlZXB6wU/lJ/vXX/yhrFUxNtdecsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4ZzDTOMm61NFYpYB6+z5Vmibr2Z49kYL5cd8k0KqQ9JDUgYQJ7u65OkKMa2YJmj+
	 RPyeZZITd3zBmzM5lCW6MPM37/+Co2LHZu8ZOQBDsKWZJ1cBGWvTODCTID8f47ClCI
	 uDn52wkmG3saFUpQHqqZoL1gnPRS9cHERulCDL2l6XXQc7Vt4xMtXV2/t8+xRM0GjJ
	 am1cgbSW5d+ZyONNkmDqrQZ1FYgqFX4ykE/wyyINs5Xarw1eo/6l2TWTOqWHn4yEn8
	 y75TsIAs7+Gw80rAirMqqOLOFsVWk9x9QaHjJK2Q9BuOVeQBBlABD6+MMKic2QppPR
	 W7v8KBZH8S7WA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jic23@kernel.org
Cc: tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] iio: adc: stm32-adc: Use dev_fwnode()
Date: Thu, 12 Jun 2025 10:46:27 +0200
Message-ID: <20250612084627.217341-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <0ec0fd5e-8fbe-43c4-8aad-f36d2872f280@baylibre.com>
References: <0ec0fd5e-8fbe-43c4-8aad-f36d2872f280@baylibre.com>
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
[v2]
* fix subject
* wrap to 80 chars

Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/iio/adc/stm32-adc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index bd3458965bff..dea166c53369 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -407,7 +407,6 @@ static const struct irq_domain_ops stm32_adc_domain_ops = {
 static int stm32_adc_irq_probe(struct platform_device *pdev,
 			       struct stm32_adc_priv *priv)
 {
-	struct device_node *np = pdev->dev.of_node;
 	unsigned int i;
 
 	/*
@@ -421,7 +420,7 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 			return priv->irq[i];
 	}
 
-	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
+	priv->domain = irq_domain_create_simple(dev_fwnode(&pdev->dev),
 						STM32_ADC_MAX_ADCS, 0,
 						&stm32_adc_domain_ops,
 						priv);
-- 
2.49.0


