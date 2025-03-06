Return-Path: <linux-iio+bounces-16441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC932A53ED0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020E63A537D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4463D;
	Thu,  6 Mar 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVyW+McL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF117578;
	Thu,  6 Mar 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219507; cv=none; b=bfGaQC7nHre+Q7o06DaBZwVp5wt3GHB78zqgx5NQQso+1Ca3SdJfqdfv2F/fyoWYmX57KXPD+FAmiG8+168XFlAU1vP74zEz/Cw5TGDUXCT7b+GEbNFHQm1AIbC1k0v7YbY78vGu15lZxvviYgLv4dy2/6A0F90UVxPrT1uKLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219507; c=relaxed/simple;
	bh=gwRerhKsJhNh4ZpQR4SajjAscqi9DkY5YwLDwNvtn9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EhEr9RgZoORGU0hsbzZVZVlGiJKY5g6fgFBQTXJVe1Kg2AMoPijVF91hU2tkRNHt5GFzwwuGiQ9jPiYPZy/Ks+eVn7l6x7hkiyEOjRkRJ6JYI1Nftn8/xqUL80aAwF1Y9c8QA7onZKNMVZKoUKuh+GelI6XZY9XfbPTP9lgUuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVyW+McL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22349dc31bcso467725ad.3;
        Wed, 05 Mar 2025 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741219505; x=1741824305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6f/NDGo0Vf2cKafvbyrDyAvIQAgQfr1nIMxIAZAPi4=;
        b=KVyW+McLR8vR3WPGra2Jyq40pZ7l4rWQEL39+QY29HrL8PcRK/LPN4hxXesgCGdf+J
         Erd01akLLAb3uDO+KFTy8Co6D84hesh2e++WMyZpt3QkC50p8Jk4zmydIHORF0cfgg+l
         6nqCXuZ8WKeBtbEq0iM9m3wrMdWKSDGZFrdJdVGizHC39wGIRivG5TGGf5D5Kk5HbJto
         e2S9kZRQx3sWObv2F/qrVE90xFDDu3fapvrStBqX1yORCcsPXTTr0fiWUdwJW4bizHBd
         QR9YeuZ0uCcRaxjvKHL9x3RvZ6jURXAOwlAxen2/KVO09bIMHvm1PoCFGtb+bWNEfiJW
         RqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219505; x=1741824305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6f/NDGo0Vf2cKafvbyrDyAvIQAgQfr1nIMxIAZAPi4=;
        b=UvCNNoKoXUZPjq/p66/j5AEFBZURDZ6l4sdP1QsmuKIimo40txJqAhceByhIS4sw/L
         eIZFdsfakUP6phiA4yUaqfT+mpUEgf/ckJfoPZsyYDmBKvmp2rMRygtPuFrMlrXeLxVA
         lzxqLSKa0p16QDGid+0p/BvjnvjSnWNSm5D/6lqy6SZb5H+zIQ4wm5xJnho/2Ydx95ID
         4o9nDu7vcsq5e8srPCxVSpAOERF4OU6gYYawOyBrtkPmIij9k1F+MD81ibVfgzxnvpDZ
         KSSnIDv3+3PABMztvyEd4xwYOcl0wymQ86o4BWv0+MN1t4nRnQy3U2Jom+9mGqS5ACNy
         ZC7w==
X-Forwarded-Encrypted: i=1; AJvYcCUBTvyMDsMtozL95iziCh1FKzQvrvrMAZolAhKjqZiqnkvvsGSGOdl7yVpKCVl2+TkeA41i26wrv7I=@vger.kernel.org, AJvYcCWdgH0ijVaegoJRWqws5FCtPSrmq94f77DzCAjXaafDwdVe8pDhd+lG57oGTQy+GMUC7gSC5lL9EqaEFlyL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZVRCZTMZlysw7sk2VN4Ks/iSQQRbQMXuKyEmFawXsHoBYak5
	ZDSKKJI+QJ1kI8T+CMhN5GShTMIGRuyDoKqPM6SnCVrCRSgwCrIM
X-Gm-Gg: ASbGncsuPllepMyP5GG4CLKjzp81nflSIqgmes4SPe+1YeGPf60M2NtHCGZPo1htDvX
	zgMGJxsbeB7vGG8BHyboj6zbjwHMKgGG71W29C230u3qngTlKQI3HUSfUvFsXbBlgGxu4n6wbMN
	bNPIrGSvpaC8tK0hQjHuHykfvbEYpAO/J7rAJWiyiTdKTv1rdrTzLbZ17xLZQECsKbxLl0jnfuR
	Z0GGN/IRk1Y0TDFvtiwRkAM0Vm8g9xENXT6S2DE8ClSoOoqyLELJOvhMyRPrombKQHOePpw85iQ
	4DiRI5dLu3nHkS0X7taLbkZLElyF44rNW/xMpggtxEbxDYHG1QjGAl7guQAHuGyPyrA=
X-Google-Smtp-Source: AGHT+IE46kf0YUY8UFiD6hZaGT679Z/DNfrodG1uHsXyVqNtQrbPapBDoHF0DTFrnDnBcXneh5xRUg==
X-Received: by 2002:a17:903:1984:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-223f1cf33ebmr75271685ad.42.1741219505410;
        Wed, 05 Mar 2025 16:05:05 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91b95sm18915ad.188.2025.03.05.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:05:05 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v2] staging: iio: ad9834: Use devm_regulator_get_enable()
Date: Thu,  6 Mar 2025 05:34:59 +0530
Message-Id: <20250306000459.1554007-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regulators are only enabled at probe(),
hence replace the boilerplate code by making use of
devm_regulator_get_enable() helper.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
V1 -> V2: Update commit description and return the correct error content

 drivers/staging/iio/frequency/ad9834.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 6e99e008c5f4..50413da2aa65 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -387,33 +387,15 @@ static const struct iio_info ad9833_info = {
 	.attrs = &ad9833_attribute_group,
 };
 
-static void ad9834_disable_reg(void *data)
-{
-	struct regulator *reg = data;
-
-	regulator_disable(reg);
-}
-
 static int ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret;
 
-	reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
-
-	ret = regulator_enable(reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_reg, reg);
+	ret = devm_regulator_get_enable(&spi->dev, "avdd");
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to enable specified AVDD supply\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev) {
-- 
2.34.1


