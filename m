Return-Path: <linux-iio+bounces-13508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC99F254B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C34F163D73
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0B1B4138;
	Sun, 15 Dec 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W31qGfcH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D313C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287379; cv=none; b=o1Pp7Xk8mRvnO9F1U6OlezpAx3+GfFBqgu0oojTaXISpCeay+hXg+68+h5BJVcDDQTxTx3EmoY/cnmiSE3BlaQWYAgBBhSnq80q0/8YND+OSTzOgvK8jEK4sKmA6zZ4r2ZdAKuSYohMhMHfWw5d1rZbI1EgdwheQ9Vja+fvzLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287379; c=relaxed/simple;
	bh=G4nI2P24Y3fIooMWa4anK1EWslXELM4X1MLzm0Ajlz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFsDiJGmngJVnbIrCpXiShRBKDb0jqFEV10ZorFwd5dK6Ydln7l7MiVG1hNfg7IP7k5i2cquhRGw2pJ1eKRrwfV3H9JrQmUrvImeO9DpKlUc9CA2a9u4vQEJtkJEO9YrfeftLh+/LLFGBFY9NEjKBtxRj2FheaiCocDk7cfQrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W31qGfcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A72C4CED3;
	Sun, 15 Dec 2024 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287378;
	bh=G4nI2P24Y3fIooMWa4anK1EWslXELM4X1MLzm0Ajlz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W31qGfcH83QZP8xiZKwVPXN3qNTxBcAgTAcJWIe5FKlN8riQ5rmIIfgL7AT2wEdrQ
	 f/wGmAYyhdU258P3gSc84EW4LDA9DF5a3rjoE3sbY8XM5NdZFONRz1v48N6RJMnKgd
	 hij5dUKPxkgfsJm0G1lOCPNSgfx81OdHZOyA+ypO/bOHk2yo8aX2HcvA7bKiEWuCor
	 m7F9aaWuuCfIwVhd1NnTdbL2Y7cui9VbEGoyg/KEpd+cboRFGq3vK55he2dWl0+4hH
	 Mog6filLOfgowzzq6/OP/dBFQc7hzpEtSpRTPb/iEbGvIyMdthI4NxbDK/umGbvJy6
	 l0FJImx2Pol8g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/20] iio: temperature: tmp006: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:28:54 +0000
Message-ID: <20241215182912.481706-4-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use this new type to both slightly simplify the code and avoid
confusing static analysis tools. Mostly this series is about consistency
to avoid this code pattern getting copied into more drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/tmp006.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 0c844137d7aa..7beaabc9ecc7 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -248,7 +248,7 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 	struct tmp006_data *data = iio_priv(indio_dev);
 	struct {
 		s16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	s32 ret;
 
-- 
2.47.1


