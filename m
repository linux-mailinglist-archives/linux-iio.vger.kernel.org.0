Return-Path: <linux-iio+bounces-4628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C58B56C3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB6E1C21008
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59569524B1;
	Mon, 29 Apr 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="F+YIfNBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F24DA12
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390403; cv=none; b=HNOcjvAqZ6im+2xrpxUt772w6vOyLlVOocq+kKbcNOqzcACbqNRSLZKJ5Q78SnypWX7KArCX6IXd4XqZQ0yuK3EEPUh9/0XCfZx47ZZowG1xdChiyzB3ycOuTsUGzVztC8Jj1ZZHucxmU6xv7a9YkNAdVyl5IkzkaQKS2bMvTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390403; c=relaxed/simple;
	bh=YI13TytLVIliMo2K45hbcn0KvPRg7d0WFvP/hHQC7GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIfNoDOd0rCXMehzx8xFajJtI4fsNd1rofQFp6AQODSIIF3HsJaHT5GRsp92957rD8LnSukX62wHmZhg3z3U2ijbgeVAo4q1dY0uFXNyXEdhcoQYaAj7ZXAPutmDWXi/irIKwjc7XhS7vU+ZuNMTIOnzYWWoLsV5MxQLqQo1uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=F+YIfNBe; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=pTKgsnnnR48vpHuUZSyQHs6dIzn04ZSLBe3TZUJ9DSQ=; b=F+YIfN
	Bef5N4igD5o5TLEi7in+MbPhNF4xKt/4L64LuUaivoLegMLsYx21WYKMJpVQXS8N
	xztANF5xlZYEGF6INXjo6SVzlo3gMugtaLATPejPkpSmVSoiv4EkXSkLlIm+7fLF
	1LdKYizTB17AxiZCPlg/HoQeHNFjHum05AyhfdRyoVgZ8qet5sSEAjRj/6lnstwD
	xXAUXhdY1mFrBhm1ver1Vge5hEi+k/7p75uzpVlFNAccMS+G5/Z8qZ72p6NYhXvZ
	5YGUpS5aJgGkF1Df5NWC0slsoWWrNPZPRPKR5YfhOHMU0GAy0JPkLOHEmB9cBkg9
	P8+GchupFvv2TaCg==
Received: (qmail 2281145 invoked from network); 29 Apr 2024 13:33:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:19 +0200
X-UD-Smtp-Session: l3s3148p1@Z+u2njoXhihtKPB4
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
Subject: [PATCH 5/8] iio: adc: stm32-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:08 +0200
Message-ID: <20240429113313.68359-6-wsa+renesas@sang-engineering.com>
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
 drivers/iio/adc/stm32-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b5d3c9cea5c4..7cad0ce1d9b9 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1408,7 +1408,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
-	long timeout;
+	long time_left;
 	u32 val;
 	int ret;
 
@@ -1440,12 +1440,12 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	adc->cfg->start_conv(indio_dev, false);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 					&adc->completion, STM32_ADC_TIMEOUT);
-	if (timeout == 0) {
+	if (time_left == 0) {
 		ret = -ETIMEDOUT;
-	} else if (timeout < 0) {
-		ret = timeout;
+	} else if (time_left < 0) {
+		ret = time_left;
 	} else {
 		*res = adc->buffer[0];
 		ret = IIO_VAL_INT;
-- 
2.43.0


