Return-Path: <linux-iio+bounces-3067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6345862CC8
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 21:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A031C2182A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413519BCA;
	Sun, 25 Feb 2024 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5vSG4qX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F301B948
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892220; cv=none; b=K3QauGxdwr7ukTZrSHiQV5z/yZWc5Ovvvo298zE/6Apm3NpRx+xYVZ+yDIYpZFJkIzM/l9Dv86WaEVm0tH2f7q6yd+rg8/5IP3sL/VKQ4cfmd5Z1KBxuhggbQKaI0hlWoTaKWE33WYPXXiWE1yrgmURlHs9CMY8XSW2SaKKLek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892220; c=relaxed/simple;
	bh=VxLZ7RsZpLYYQuSI66FP3nhHczQ7j/5oRGLYsnKLyxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HCDxdeZBuwuBuUpGDsvYpFZtzkuDNiltLvdtNVF+OfIGmZxUjqjvZCDsXhtNB2PsD7UXVPPu6bQk6UvEzeIOmzR7Y3efGY8FEw3DCb7w5aOLsU2IJDNSaKc0eSt3W8NnGfVoyzENXkLPbS3FEtbR91LExpx4NdLhHBp92DVzElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f5vSG4qX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26fa294e56so420625266b.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 12:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708892217; x=1709497017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0BL3CAb54Q9PTk8ioTJQE7FsRhBBa8lLja7tu/HP78=;
        b=f5vSG4qXd9pUCvhlxp9v/GNYyIsxtY0mIpf+5wDoVjNO0xmTJL8Ll71Xur6TdQsWOa
         w3/KV52CoI9ubi2RVgOI2fgfRuhm3VJo3tJc1lbmkymcqpWzMPTVOYyYtXWeL4n+G2/S
         eGeaLoZdF7Z6xoHbfUVbe8HdwEE3Iz18vE0gIWuanYnVDgzIqTuIKkgT8EQYTkYFjuKy
         Y/PyH69ZQJix5qFnMZYmuNN0mZteKNVOsDIVZzBlpkHlKJrsbVzrTVjbB5vuyP0LNJ5q
         726cAKZNiZve9zoNktBU7BwX/jIqJc8dTbJ7Resu/8dc/iStWP8dNaNjmbSvS7DFOUMH
         bKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708892217; x=1709497017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0BL3CAb54Q9PTk8ioTJQE7FsRhBBa8lLja7tu/HP78=;
        b=R4D1kmY1bUf4wkyCkowqGS3JjNEr7vCmSU23e7hwUhjfCCxzph8SNbvCzmZ0Ob0/Rq
         ZQuvh7Lm/FnSHWzYSNFZQdwzjXlzdJcHu9tM/FIFe30oqbk5QBw7aFIRqb3YjjF5AVgG
         3oYZRhhOUPQA+LAV9NG3lE0hQ1KlNETaK5YulBtCJRE682T61HCxD/4MYELUT2OSXG4l
         KfuQrrIp3Bv+HVtq4KLMvGpyq0aPAuEuGw5DxgCc3SfMgbc1+WUX52auSSuOqPx1Zj5j
         JrqdLYsk8SEs3gXKVbDmsmTiAxx9lsfOMPUp03tkgNW4LcSGfLq7eARfp8g1aUEtoPSf
         ZA5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZkkZTI+3z5VAykv2JX2S/8zmmvjokHjP/btbFM+a28SXhDcOuqzs3Ss9qbBZzvfisBlEzA48NVuB0mnkyICehiggb2qgq4N2V
X-Gm-Message-State: AOJu0Yzof4yxcUBrhBK+Fa+RsZz6GGGa8fkFlpid9KBVkFkQHWNI6DuC
	RJ8YvZPtOXyl0OvOIl64/3CmAzL8TWfh4y9/Xtre2NkDfhEF0VYGpjuNYh2VMB8=
X-Google-Smtp-Source: AGHT+IHwvup2ahGbonMPPRSZ4YpMn5V9B0o/2DNB+FUiQxsAjMoxZAEys1BsJfv7CQ90Ezd9DISwOg==
X-Received: by 2002:a17:906:f804:b0:a3f:c0bd:b7bd with SMTP id kh4-20020a170906f80400b00a3fc0bdb7bdmr3933047ejb.43.1708892217056;
        Sun, 25 Feb 2024 12:16:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ck13-20020a170906c44d00b00a3d7bcfb9a1sm1741045ejb.128.2024.02.25.12.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:16:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] iio: dac: ad5755: make use of of_device_id table
Date: Sun, 25 Feb 2024 21:16:53 +0100
Message-Id: <20240225201654.49450-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Populate the of_device_id table with match data, reference it in the
spi_driver struct and use spi_get_device_match_data() to perform the
type matching to fix warning:

  ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]

This is also preferred way of matching device variants, then relying on
fallback via spi_device_id.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rework according to comments.

An old v1:
https://lore.kernel.org/all/20230810111933.205619-1-krzysztof.kozlowski@linaro.org/
---
 drivers/iio/dac/ad5755.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 404865e35460..877c1125d892 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -809,7 +809,7 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 
 static int ad5755_probe(struct spi_device *spi)
 {
-	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
+	enum ad5755_type type = (kernel_ulong_t)spi_get_device_match_data(spi);
 	const struct ad5755_platform_data *pdata;
 	struct iio_dev *indio_dev;
 	struct ad5755_state *st;
@@ -864,11 +864,11 @@ static const struct spi_device_id ad5755_id[] = {
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
 static const struct of_device_id ad5755_of_match[] = {
-	{ .compatible = "adi,ad5755" },
-	{ .compatible = "adi,ad5755-1" },
-	{ .compatible = "adi,ad5757" },
-	{ .compatible = "adi,ad5735" },
-	{ .compatible = "adi,ad5737" },
+	{ .compatible = "adi,ad5755", (void *)ID_AD5755 },
+	{ .compatible = "adi,ad5755-1", (void *)ID_AD5755 },
+	{ .compatible = "adi,ad5757", (void *)ID_AD5757 },
+	{ .compatible = "adi,ad5735", (void *)ID_AD5735 },
+	{ .compatible = "adi,ad5737", (void *)ID_AD5737 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5755_of_match);
@@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
 static struct spi_driver ad5755_driver = {
 	.driver = {
 		.name = "ad5755",
+		.of_match_table = ad5755_of_match,
 	},
 	.probe = ad5755_probe,
 	.id_table = ad5755_id,
-- 
2.34.1


