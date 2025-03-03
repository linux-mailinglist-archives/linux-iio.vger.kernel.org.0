Return-Path: <linux-iio+bounces-16305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2326A4CDFA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 23:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD531894B4C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126923A58E;
	Mon,  3 Mar 2025 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWc/aW3I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7423957C;
	Mon,  3 Mar 2025 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040076; cv=none; b=F3cfHOuKMZOUOnHlN7PJC/qIS0p6hfV3ZwQ0canShdjspXIfFmoOmpUVIgt9Wj3qTmBKYeIfS34jtGKrRqMXPji8srbslRhJnGJ4BX9/uiIwgrCDCYkKCbYGJb/qIw+wk5AqQMSFD7ffYMUGIF7IaA8gC/L/gJ52SgB2fBOnbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040076; c=relaxed/simple;
	bh=C7JgVY4X8BAYahEsXuFW/tC9wcpQdzL2xqnGC2xijmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cx1pXiEQgNGKytsTbmWZQVKm/Ojc3eYSbsX/3wc7X3FFkJPRlW/ZIxvM1RvxU4GuwNCrx5238PU4klNSw41zR/c+eb+rPIPodHO0GE1yAOWaWLYOKrkujnlAj5aHqGyXwXLrJA4AiHrrCoVY5d+Fpid7dCRxSqhyP/Wx4QH+MAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWc/aW3I; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22113560c57so94731205ad.2;
        Mon, 03 Mar 2025 14:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741040074; x=1741644874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AyT0D8McesYB9J+ldJKr6+O6ThsCItnUco/gp+p2zbg=;
        b=FWc/aW3ITEOttgTHpZhZg7E+4DdZcv4gwAqvpEQiDMV1xCMCPzle0gScUZOteHJ5ob
         JXaZaq7rVGAYwvh9X/lbC26CT0hJzAhYOA0sU8faGktj8VJT7S+hN9i66GSVaLSK6Bmc
         zpNRjWFtxYo8o/DbGRIW3pIJBkr4E5iXci+aJS66iTWzoGVB9a/QTa1JU3q/E7RJLMKy
         ztGWqDf38lhN9gJMCY4P+w9lu470TIYo5VB3ZdsvpVqqhshY3jBN/FL+fiyYGDKEsInx
         UH4VHwgllj/xxxWWPUFZzfkot2tY8LUTh/XcgaEE/KNmDhZCvWG1QF8o/d36Fl/wcuA2
         e2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040074; x=1741644874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyT0D8McesYB9J+ldJKr6+O6ThsCItnUco/gp+p2zbg=;
        b=nbXBNB7JF406/WanvpTsndqmIh2i8Gfif8+Be8m7ZF1e+HGSrICQyRYHiZG6fDX9SL
         mh5crAYF+psrLA/oYa0uIQHbQ/1QoVmhgI91+4OYOazASUREjKtgnZZFI+5dKU5K6fUu
         ohNPtgKB+IwK/vtTr++LLwr3xWb824zqUX3W9PdrpBZxhLpJd0YrjwBvT7kvF7MUJ3f/
         E1zE+fS8L7wMADAPP55Esvp0DZ6KcKKz1hQpvRp9LccSuyNdzefu/augbXh1mwtCL7/z
         jRIJlKQWx9puYnSr/cxIpH2lSBOcvN/6wSCHTnzAuvR4AMd5qxsT/VsffqKRUADEQol1
         3NVA==
X-Forwarded-Encrypted: i=1; AJvYcCV467BliW932+fDy/Z3lxPcTURB0nTObSUWVHbOemaac0fa55n6saNyP0EoAyGFUtybyL4hvwE4JvIfIo/8@vger.kernel.org, AJvYcCX8Ej0eEkq1INFU3JLbbd/jt6Ts4fk25e/a5GsSIenmy//Nq6v160+HSjJ8sObQsY30AMuz6F0qTGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiKA1NcGzm5TqMj58MlPQNrJYXe2BoqgQEIhMBZIXE+8RGcWD
	xUphSTidZQazkq2EfHhVXYMCylOx7o7JlZhm2P6iXbbRNFO7N+4/
X-Gm-Gg: ASbGncviUUXIGFK4qMlaZ2mlZEbSVd+fZkWU6n58HvxaBhJnlDz1TrTfI4VJ7v56J6q
	iopwz1CEKIcu07o3xfP9IxDidEb+U0wdHNQ1HTS6GstBcBUcHJSWZ42rxST1OP+8TpGCVCia6ul
	Ahdob2HWql/h5mDcqiosSbs1Z8guJy5qtdFzT9+jFsj0zKIdXNMSuUz6pXjxcTnCxZ8ra4+WCt/
	Nx817FPgGut85Y75dityDgBeqPcgYqjyFn+KGwrRiQnrdJiYLoi7FDwtxjUD+tFELtIlYglBE61
	TnNjeasirvl4qZCZ1gYzB9BBE4ueE43VzFfv25sxpgoohtEsTrUrAf5kJAKaqajLT4cI
X-Google-Smtp-Source: AGHT+IHb3NjYrVANg26ZagShVdoKGIRlJuVLDWR+37VklX20Zc1R1eNF5zWcvKSl/YyGlsGRFAmRGg==
X-Received: by 2002:a05:6a00:ad0:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-734ac36d76dmr24341437b3a.11.1741040074184;
        Mon, 03 Mar 2025 14:14:34 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7365e74d7a3sm1918182b3a.126.2025.03.03.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:14:33 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] staging: iio: ad9832: Use devm_regulator_get_enable()
Date: Tue,  4 Mar 2025 03:44:27 +0530
Message-Id: <20250303221427.30964-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable() to reduce boiler plate
code.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 37 +++-----------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..a26d7caac131 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -74,8 +74,6 @@
 /**
  * struct ad9832_state - driver instance specific data
  * @spi:		spi_device
- * @avdd:		supply regulator for the analog section
- * @dvdd:		supply regulator for the digital section
  * @mclk:		external master clock
  * @ctrl_fp:		cached frequency/phase control word
  * @ctrl_ss:		cached sync/selsrc control word
@@ -94,8 +92,6 @@
 
 struct ad9832_state {
 	struct spi_device		*spi;
-	struct regulator		*avdd;
-	struct regulator		*dvdd;
 	struct clk			*mclk;
 	unsigned short			ctrl_fp;
 	unsigned short			ctrl_ss;
@@ -297,11 +293,6 @@ static const struct iio_info ad9832_info = {
 	.attrs = &ad9832_attribute_group,
 };
 
-static void ad9832_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -320,33 +311,13 @@ static int ad9832_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
+	ret = devm_regulator_get_enable(&spi->dev, "avdd");
 	if (ret)
-		return ret;
-
-	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd))
-		return PTR_ERR(st->dvdd);
+			return dev_err_probe(&spi->dev, ret, "failed to get AVDD voltage\n");
 
-	ret = regulator_enable(st->dvdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
+	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return ret;
+			return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-- 
2.34.1


