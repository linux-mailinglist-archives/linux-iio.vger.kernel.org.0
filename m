Return-Path: <linux-iio+bounces-17689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27AA7CF1A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C25188D60A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D71714C6;
	Sun,  6 Apr 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRA2UYb+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01748153BE8
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960021; cv=none; b=N0ZZdzVv4bcmj3T5FC1+UhyCQd9WAJweeCzv3eyFpoVM84DFRgxraOUL1JuSTzEmWzoC2fnjoHzhSyBMQIUJ58B6lnRdlifPWQcw1JHXo5fkkL0mqx7xLmZwAZo0l6PJfTjCWSOOLEdmWVOGeBht45hPqcPA9ywu+an31OGyMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960021; c=relaxed/simple;
	bh=dYNeYVx++I7OnDVoGxb6Nq5EygJVEHBwjgYtImHxCYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMAOnkeSGJRPFfvd2c1bPA9xSHtMkgtmvrayG4x+7X5o6eCgqdoeB6/Vc70xxm5iP4eLdoq5gZ1kYpcI82KX0A0jqmNDIUh79xMp4KEAOowDoKUrT03I8/wPdxYol6a8FAiE/wTmeBs1+UhTnqvQ0AmmBz5vwYDAwnOE1bJeOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRA2UYb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18139C4CEEA;
	Sun,  6 Apr 2025 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960020;
	bh=dYNeYVx++I7OnDVoGxb6Nq5EygJVEHBwjgYtImHxCYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRA2UYb+mmE5RByeqQLKJ01lCbOvrNCIjDeHfw+DgFEFE1+X6DxrnZNnQnBtPbggB
	 BokAc6d6e6QcUkk2x/cxI9shonrJfNvSHAU6A7YXfUC62zXb7xzWKjmV7p4oDIl88v
	 eMOpW/jDCbFWezQ4fcYXWtwuH4xvsMiK4ShBYyXNvFZUvae0ldEJtzF7ulfoOSjgOW
	 4CvNgeecTTiXYBtGZl6bFcLLCG6lcIS9tcyU9JG7wMwjXZqKs47UcBruJXzdkPK8dG
	 bo76hPLzokCHphOYTbAKCsbAxw/zqJB/KZd8/I1FX8tpQq955Y+L+3fbgBOBPJrZwj
	 4dYPJfA6D3pmQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/20] iio: adc: ad7266: Fix potential timestamp alignment issue.
Date: Sun,  6 Apr 2025 18:19:42 +0100
Message-ID: <20250406172001.2167607-2-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On architectures where an s64 is only aligned to 32 bits insufficient
padding would be left between the earlier elements and the timestamp.
Use aligned_s64 to enforce the correct placement and ensure the
storage is large enough.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") # aligned_s64 is much newer.
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 18559757f908..7fef2727f89e 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
-- 
2.49.0


