Return-Path: <linux-iio+bounces-4626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9E8B56BF
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 13:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5991F244BA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A104D110;
	Mon, 29 Apr 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YWJmo1O7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC1481A2
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390400; cv=none; b=l0dyi12vfhTugRWFLxlecSNxZFznB9A9Rs4QYvUsUaDKCRoQTN1Oc3tDgi9q3te8TiXIWgIs5kOMq1brWHnmNiWgTgyr1z6aQa021bOrXH7NuIRQwfgPKED+VwFB5Sp5kPNWeZG3cO5WfyeYQkDFU0h8OMAGbdkr4GyefWPpOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390400; c=relaxed/simple;
	bh=cy2D1HP63aslov77VCicNGX0z0ZLnIZFrx66F9b/xOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHSwZS5YLaTnCMaJQeub/bJjq19aYQTCjCJGvJaDoQG3d6/zt+RMtM3HltXakr21sTUoVRjt3cEZSag9dS2IpXJ9aUGQgax5p5CeEmpKRt2Co2iZBP825rFDFdGpvDJatfQvOORciI15LJU7yFdvi7UsJzzIFReAGbsDoRzhz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YWJmo1O7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=4U8CmUX52QVRFRqLXIis6AKCy/puBxC4uuyzZRCInlU=; b=YWJmo1
	O7xl4olZbGoV0XZRVVyoTBkU9TYJ/bMKtmXad+r+g4nK5Dacm/o6oqpTx+Nf2i1V
	//aM+hSv5+U8AhSmpeDykvycCkEYeo0KGk+ZaWYq5YR0F7LtBNJDcBJPwk/gEI7d
	2LDrtJsJbVjs/QJ0fTcHbZjzbHNRuqUIJvXzWLKjCxnfhegx85w0cFrguCVpZ5MF
	lfKWuDaNX8RqjqfVi8cZAx6AAPQxYA6uEhn2vPAuto1a3WXjH7TzaRbtBIvSfEUa
	HDvRI5fILcSFo3L+nC/ibfSaiQuRSaFqH/3pK6VhOur84FKUk8oVYiHNIPeBaYyq
	MKbqp5QHcTDT1upA==
Received: (qmail 2281070 invoked from network); 29 Apr 2024 13:33:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:17 +0200
X-UD-Smtp-Session: l3s3148p1@2+uYnjoX0Q9tKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] iio: adc: fsl-imx25-gcq: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:06 +0200
Message-ID: <20240429113313.68359-4-wsa+renesas@sang-engineering.com>
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
 drivers/iio/adc/fsl-imx25-gcq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 68c813de0605..dabc5303d644 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -107,7 +107,7 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 				  struct mx25_gcq_priv *priv,
 				  int *val)
 {
-	long timeout;
+	long time_left;
 	u32 data;
 
 	/* Setup the configuration we want to use */
@@ -120,12 +120,12 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
 			   MX25_ADCQ_CR_FQS);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 		&priv->completed, MX25_GCQ_TIMEOUT);
-	if (timeout < 0) {
+	if (time_left < 0) {
 		dev_err(dev, "ADC wait for measurement failed\n");
-		return timeout;
-	} else if (timeout == 0) {
+		return time_left;
+	} else if (time_left == 0) {
 		dev_err(dev, "ADC timed out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.43.0


