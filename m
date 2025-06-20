Return-Path: <linux-iio+bounces-20802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F14AE25A8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E1D4A6BC3
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD224EA81;
	Fri, 20 Jun 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NmpSGt9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B824248F4A
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458093; cv=none; b=NgPBlqyySN5bprMugBWztdTqVZkU/k4cfIatUvFFbQUBRUeRcyfxXaTc670hY8NjY/lPwi1bB9LnUWbM8abMKQ5haRdBo3yaXrqx5HWInc8akdeKKqyJg4UoK2BI1ke/DtNUIUAohtSjUl3qbbVvT+zfI2LFRRbwyhEOMzEGyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458093; c=relaxed/simple;
	bh=UX7Qk+7NOxJbsbC9UcQ9KMGOYrU47zh3dgyBfOfkmSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orO/bCOJGF61qhq3Ob0fi7pGAAEcznm+/H6+daah3VjMLunKviCCIWMuzutWkjVRZwzLhtRJ81Ckb5q10jF9D41WWF9vmg40fiFgLOaXbbKBAkcjVmUg2LHAFFEvrlnbIRZX1pC1HoLHc4Bkts4ADU0Vx2dVv4pHkevKWX23Gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NmpSGt9h; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60d666804ebso1254443eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458090; x=1751062890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCcWLS8dPTQ4a25bImW7jFTx7RMnzyCqIg4blrEu6+I=;
        b=NmpSGt9h7smTo/xPE9h8pDWrX0W0m4OhCHajt3hY8M/O2K9OuEOjsXnAJM5G5zeWWJ
         CK2NMSqbGioc9yI+T7+ZLvfc7yB17Ow+JcvuLHjjCQVJwDgiiYIKVWq95LC5VUNdvAqO
         FS7VLuNxEkuQnWSWgkpVsEH4KIBIOfsaqKzxAhsbbq+dZPdUVNOuMAeSbJf+NZ5kPKZc
         6I1ag5PiwabA+9JnwUK/eNfl4w4tm1QFrKWrZi9RWZ0Xe+275MsYHnnG1/RldsVcg4Wg
         XeSxLwsdkPxW943/4eV0dRznevFd8VvkIa3nLea+2jDLZQgvryPl3SX8Cx1SEzQIptQi
         fTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458090; x=1751062890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCcWLS8dPTQ4a25bImW7jFTx7RMnzyCqIg4blrEu6+I=;
        b=SydASptBUKeMkF4ZOQ99GP12BJjHrm3cB6naWsB60NH+sSenbvhrKBEns/Mcrf3LOQ
         yENE5qtmjEju0OM9WMS35e+M+WL8YG5p+fGDfFISenqtEsGAYHj/ebHg8g+zXUVxcF55
         1S035AaqWx/Z0S05uM1k2KsVCThs5RjG2jivGdBpkGR4OKJMqReTTRnCppmKLTSmi6Nx
         HpX7sZCUPib3PoS1gxzIG/V/zMmZPcrHnYamDAiQeoJ50qXKVuIjDxFC0n+sl8pjtKy1
         Ax52H3Y3nwAfI2gfkF+ozKAXu6+1+hg8FFCoF5VIja2PbHYlA9vEWYrNdywUMTGTP7Ae
         t9oA==
X-Gm-Message-State: AOJu0YwpoT16RB/un4qHR1dTxE2LW8lqi9RRXbSkhxzaMyJpps/o/enF
	nNPdh02KFcOxpmYsD0/hRaudH7Va5I+pZpooramoGjtvZ9WaMKT04xtm/fjuRgAjZVE=
X-Gm-Gg: ASbGncuw294l2Ec8C+Z9mpafIzg7nMd7cfLXnRDrBxl+JcL8AOwSzsSsdksrhatieqA
	T1bDeCZ/7npqaHmd08bOxlFYYLUg+lPldBbbqNArVUvb1/u6/6rymZluGVvLwtwiKjUzkkzf5+K
	neZWPvJYRmHjxB0rUVCcpgQkSt76WnW0hwFLWTr70qZGlP7OkNSEu2v5owajEvaavpb+EG0QDI4
	moqM5hZVfLFKl/uXxVVMrL79gGm0K0T2cjUR8bx6+xkPjgMcds8FLyGnMjMnpMBlhLPv5kqYN2t
	ZRK5aF0EsBJWV3p9vMa0FIUpfHvVlQTVWfV8w1lqzWjlmttD8rxBwzFU3m8P0m1ok3pB
X-Google-Smtp-Source: AGHT+IF2GLud5cD+DfB5URuM0aIY3NYHneGgtodyB2cz+tQIr1/WtBZ+tEE+jOQd4TTZZXS289sX4g==
X-Received: by 2002:a05:687c:2053:b0:2eb:a2ec:dc02 with SMTP id 586e51a60fabf-2ef2a952c4cmr1558341fac.11.1750458089654;
        Fri, 20 Jun 2025 15:21:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:10 -0500
Subject: [PATCH 4/9] iio: adc: ad_sigma_delta: refactor setting read
 address
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-4-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UX7Qk+7NOxJbsbC9UcQ9KMGOYrU47zh3dgyBfOfkmSc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd63BLhmn+HB7QmyWk8EbmeurR9QlJsuMl3Uw
 JK5ZEn9KrCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXetwAKCRDCzCAB/wGP
 wNzyCACV9VMkV37f/qNR4IYrQCDTE4Gyr8RWjjT9Mt4L6/uR58OZzQeRn0xosTA5hf+6dMpIn4G
 quzIsNpX6yWjuiSQ6BOp8oNfohOWnp+phkS2M/ADbBQ8Njme63/AsYWaPJ3vWD7FNlCVavB857O
 ed+kaYrFagaItZiaShcMkKZC/DgYP4N/tI7ivJ5YAMw4XRgbb2Vo6hMGlprukpF1MsmQHzGZ4rL
 P9iHZYWfsgNN9cL0D9w0YRzwZRxNUg4fShiWkLFRMzkN9WHpJSNe66941B/TJQYxjIn4mYQJE33
 STaX+GdnH/Orr4GEnmPjQ1Hl7VvFcQ0f9/gcHpmLS2zhrdm/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor code to set the read address in a separate function.

This code is already duplicated twice and we will need to use it a third
time in a later commit.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fa792c800c80f960aca75b28a60cb2588e69fe7d..883cc02d4099908644af523bcf66c0178fbd0e55 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -100,6 +100,14 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_write_reg, "IIO_AD_SIGMA_DELTA");
 
+static void ad_sd_set_read_reg_addr(struct ad_sigma_delta *sigma_delta, u8 reg,
+				    u8 *data)
+{
+	data[0] = reg << sigma_delta->info->addr_shift;
+	data[0] |= sigma_delta->info->read_mask;
+	data[0] |= sigma_delta->comm;
+}
+
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 			      unsigned int reg, unsigned int size, u8 *val)
 {
@@ -120,9 +128,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 	spi_message_init(&m);
 
 	if (sigma_delta->info->has_registers) {
-		data[0] = reg << sigma_delta->info->addr_shift;
-		data[0] |= sigma_delta->info->read_mask;
-		data[0] |= sigma_delta->comm;
+		ad_sd_set_read_reg_addr(sigma_delta, reg, data);
 		spi_message_add_tail(&t[0], &m);
 	}
 	spi_message_add_tail(&t[1], &m);
@@ -281,9 +287,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	if (sigma_delta->info->has_registers) {
 		unsigned int data_reg = sigma_delta->info->data_reg ?: AD_SD_REG_DATA;
 
-		data[0] = data_reg << sigma_delta->info->addr_shift;
-		data[0] |= sigma_delta->info->read_mask;
-		data[0] |= sigma_delta->comm;
+		ad_sd_set_read_reg_addr(sigma_delta, data_reg, data);
 		t[0].tx_buf = data;
 		spi_message_add_tail(&t[0], &m);
 	}

-- 
2.43.0


