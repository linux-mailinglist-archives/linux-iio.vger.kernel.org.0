Return-Path: <linux-iio+bounces-17087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16511A6882E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8B217F6AB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A712580CE;
	Wed, 19 Mar 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCh5sO7v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F8257ADE;
	Wed, 19 Mar 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376702; cv=none; b=fIB+w3mZdZZ/KOQ1oTKlJKqxZGcRqPXiuFUJdzdvZzAJyz8ZqLIHOcngUvQTVxWlUva9Kmbvn8AiUEPmh2yxgqMIUEtUMLDjsL+EKFO+8zXjvtdRQqucrJqKMWVbTPRpYbYKbwGe/FWyaeJdQFYztP36YtfLRI4JTD14hjjtjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376702; c=relaxed/simple;
	bh=rb7GIhlA1eO8yU50mfZKS4I1xA6+NXBC7UurAj5NVMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzM1MJoi+9c4WEK9oUR7fhylg0HkiFUhbS0rUIGD9hsSssZt1HHVaMuVdBW6iN4Zd+YpKdOUVvGXRSG6Bz1CzAZaszFCWSw3X76MtZps/pJMEJW1SlF9HLZDyWutykEaIy2E65bQ6xbmu7pCpYsrAzUKWgA0JW7wlmDEsIXsEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCh5sO7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2135DC4CEEA;
	Wed, 19 Mar 2025 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376702;
	bh=rb7GIhlA1eO8yU50mfZKS4I1xA6+NXBC7UurAj5NVMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCh5sO7vhI0LokNMNujDluAbLXvdli0nGqzU+orQePlnzlAhgsmkLpI+J1zzT/nJd
	 OtvGdH4r++LrYjLtUMBr4/iT3G63iMctm7JHCmda36CcjqwZ8nRfmKi55hid1+RG34
	 +M28pJSKlbT8G+yRR77D5g7NOPQPPjXq1FhpG0PXTje31TdMNDc6BndsWWq6xciXFY
	 pQRRldSwpQD6Ti1Z+4H9VCyAFXU63DU+nC4TLNcJONsY7iKv7fkz+Uac3CjI3PSFzL
	 AmPwGlvqjluegdMQJ0zjiW9LnPTl5nCiboneCArkkXH2jrN5YRIhg4pH+3t2cr4hxI
	 yA72YpWfYSNuA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 20/57] irqdomain: iio: Switch to irq_domain_create_simple()
Date: Wed, 19 Mar 2025 10:29:13 +0100
Message-ID: <20250319092951.37667-21-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/stm32-adc-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 0914148d1a22..bd3458965bff 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -421,9 +421,10 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 			return priv->irq[i];
 	}
 
-	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
-					     &stm32_adc_domain_ops,
-					     priv);
+	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						STM32_ADC_MAX_ADCS, 0,
+						&stm32_adc_domain_ops,
+						priv);
 	if (!priv->domain) {
 		dev_err(&pdev->dev, "Failed to add irq domain\n");
 		return -ENOMEM;
-- 
2.49.0


