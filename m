Return-Path: <linux-iio+bounces-706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE108087FE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B511F2258E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62C39AFA;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpx07e/K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF41DFF2
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DBECC433CB;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=1nlZgmjY0e7F8kwU7VdUdJbEgpNbByiVB5PBoLe9JQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kpx07e/K7r8Hr8h8G5aK7RVP77/pJ3yFq+i+N/DrukLN11K0LmzX9UuM8lT+8qcjj
	 d37TnctJ8NNYJxH+CKZtnWX5p2uOkQqOTAPpfCRWBmGxPVHuczi6VgaZRdknMeqKQC
	 Dorby9p7TgNe9jPXNlR6Pw6a5Aa+hKIxao4ACTZBBhx2oYt0RPGATDGns7qZ7hvH6H
	 fPOImWdf5gIbff9AVsffHc8/e/+hLh/hHYWDJH9dgfYc+BJ/8/vbuLYkJUuuutMYP/
	 kyz+u0WsJ29QBaqP4PbRHhO+3RrXgXB+bLtynvUurkgrhas5FAEzd9S+16sqqRMeaG
	 n+gSqBSQrZVXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37699C46CA0;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 07 Dec 2023 13:39:26 +0100
Subject: [PATCH v2 3/8] iio: adc: ad9467: add mutex to struct ad9467_state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-iio-backend-prep-v2-3-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=1696;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LC5zHdfPHlS7n6KkhXG6jik7f2Wlr704ZcM0hmOoo7c=;
 b=oN+i0GCLFhpnqgEG9hXciaw/SXJ0Qv8vLECl0+LR8z2nNH352K97FOYvDLKBIrjGlyJoD+tHW
 USe3nPWQs3pCKh44rRYvZyvL9eBFE8vjyKJ/WDr3+yL1nHRvI8suLZQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
are done which means we need to properly protect the whole operation so
we are sure we will be in a sane state if two concurrent calls occur.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index d3c98c4eccd3..104c6d394a3e 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -4,8 +4,9 @@
  *
  * Copyright 2012-2020 Analog Devices Inc.
  */
-
+#include <linux/cleanup.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -121,6 +122,8 @@ struct ad9467_state {
 	unsigned int			output_mode;
 
 	struct gpio_desc		*pwrdown_gpio;
+	/* ensure consistent state obtained on multiple related accesses */
+	struct mutex			lock;
 };
 
 static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
@@ -161,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	int ret;
 
 	if (readval == NULL) {
+		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(spi, reg, writeval);
 		if (ret)
 			return ret;
@@ -310,6 +314,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
+		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
 				       info->scale_table[i][1]);
 		if (ret < 0)

-- 
2.43.0


