Return-Path: <linux-iio+bounces-4629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200398B56C5
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B951C20F96
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478452F7E;
	Mon, 29 Apr 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZYN+XvwW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABB50A7A
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390404; cv=none; b=h7Kk8kcdXwD5Sq2xeCxzeCrDjoRnU7m8J+FlbFOsKuR/YXhXZfZKW+QzvVt3zNMG5qroHkTiGqr920CueANmbww3U07SUnHBJfbf5WXcJhwQYvmOfqpKbISMebouyfXduXfr723CJvxxU1bZIGvwPisxOcKfck/BrRtArSW1q84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390404; c=relaxed/simple;
	bh=TXBJ8kRFQEVxHoBSaGXMRzgHJL9lguRH+McDdALDhbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI4hpCnL82j89mW2NG9Pu1/PYkyrUfJ84iper0iM2tqgZIBGw3uqJef2KYEcWZV6JO+i6hQrN4H6dVFG6AdoRznxxWW+mUUXGGCprCKqJVW+6C7r/F7d1kJpKtUUHmf6QoLq6suEh9a1Pq1iaV/+TAkL6WSWI2cgjemVH1xXOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZYN+XvwW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=bO1DtnMljUne5cLDZB1KSz1EuNPq+xZvMkPybT2DdrE=; b=ZYN+Xv
	wWeFNBOF4Y8yRRdjLfpuYYiOie4X6UwOAzSuoFW71Fm6/CrsOObdfXp3ZzJ6SeNL
	PFO348ThErNZ/rU+bjEP2bEMd78KMiWNLiwJE4S5jFIe+M0tGYpQr43qG2B83WIo
	98aPenf+xGgbq413oFMgJ/3dQsU9DDWdKDaTcq4L6xRR4z6kjV7NBJa8R0dnNgyo
	CeKLaJXT3Hae7NfDW+lO1wHhYrEaDQmPXTlj9jo7e97NqNUXlpYHXe7eYSNpIfFl
	IBjFj4e4NBgZuraYXNpnOUvZiHJFookG0aIjHvU0hdHF/yNBIhxQ0q29KhzT7rCy
	9skzpGb4Q0ZH7hHw==
Received: (qmail 2281181 invoked from network); 29 Apr 2024 13:33:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:20 +0200
X-UD-Smtp-Session: l3s3148p1@JvPGnjoXHnRtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] iio: adc: stm32-dfsdm-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:09 +0200
Message-ID: <20240429113313.68359-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
References: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_interruptible_timeout() causing patterns like:

	timeout = wait_for_completion_interruptible_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index ca08ae3108b2..9a47d2c87f05 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1116,7 +1116,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan, int *res)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	long timeout;
+	long time_left;
 	int ret;
 
 	reinit_completion(&adc->completion);
@@ -1141,17 +1141,17 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 		goto stop_dfsdm;
 	}
 
-	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
-							    DFSDM_TIMEOUT);
+	time_left = wait_for_completion_interruptible_timeout(&adc->completion,
+							      DFSDM_TIMEOUT);
 
 	/* Mask IRQ for regular conversion achievement*/
 	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 			   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
 
-	if (timeout == 0)
+	if (time_left == 0)
 		ret = -ETIMEDOUT;
-	else if (timeout < 0)
-		ret = timeout;
+	else if (time_left < 0)
+		ret = time_left;
 	else
 		ret = IIO_VAL_INT;
 
-- 
2.43.0


