Return-Path: <linux-iio+bounces-20486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC7AD6164
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AE3164F3C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A54243379;
	Wed, 11 Jun 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VkziFPU+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606023ABBE
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677628; cv=none; b=VEL6baGhkf0P55IrrjVBldpT87w4sLrhM5LRIgp8yMTfZaTAyoLleCRFKrgVy0PtK7teB9uAqU+LhiQpGmVZ3016LKUqRMVfJgv+ZP8/mVyaeltjKVtWiYr4NH1q2GXQIMiRcXalRzektSOpG3ZDwqVmVykN7UriW1i59utsbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677628; c=relaxed/simple;
	bh=FLT2npDkqChFx9TKV+HNT+kp0SfQR8B+ElSxgugH4FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ek9025nxilJ1kWaTRGkq3kL2PTLcZlbF76gmxsEtYFFCVEMNBrmNu6N8nFEoIXZdv4H7OwoczKMbd3MF7gPt8Dwj/D138Xz9tSWNRBLtC4wmpjjt31wsnNOCQNgfIvSOPw4l0SLysq3HKd5s/hmhZdz0EW1lgcxjCbDpF/gH7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VkziFPU+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-408d14c7ebeso176960b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749677626; x=1750282426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFN97YuN8D7QHIfcx7PEu7cdojzHqHSy2OCjFX9bZVM=;
        b=VkziFPU+Y/KKJcmwivPIUP2CdVqzbNVaFGJMN3r11GsKULoZho3msT7+e6YSWqkRIC
         GUdO5WIW7daL6EyCT6OHC2LBSrasNEVinabfRJbM1WEWus9WuqwaMcKxV7aYlOCBcH1z
         2BIb7zQbFbocQwUHLfpzUWCPNQxxMmZFjvkyO96ovq1lMD/UYtcQEO6DmvtSr9oeJmK8
         +nK0+f/8SkG+R7emiGOPd6laR/zNZx1b/CN5eSyptVEgrpvlPEB81hOiHOtt5Prfvrgl
         sG1/xkgg6zJr2XAEA3rRcclOE225rmn8sG1sAGX2egBJHGIKshoLTDxfTn3OHYnRP3Em
         V0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677626; x=1750282426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFN97YuN8D7QHIfcx7PEu7cdojzHqHSy2OCjFX9bZVM=;
        b=IIc4h+L5QqLHn27q2mQNVmHJ5p2X1rSQ3+N8SbKvSTA/0dynGSPZe8NcHpNDNEmwfK
         oZWo0c7UWxjW05zyoofX5Rc/KgxDeqLM/UijXZAwBOIKRTT2N/sXRJlo6mGLo9RvsxZq
         gpGXzJRcMpywTmh7HvoNzFVgSpptVS6aekUQzC7f2humlfW8NhGusfGJg4e58hIifgwP
         CtOm1kF5ASmhYNZ9h+ogQFgCyV4FtlNpompHqPrq8pQzvbeHC4U3DxygTnnRnoRXljYd
         WPxYGji1ktmq9e/P04ICZvCtQ+LdAp/V5OAFrha5uMWYH4bo2rPMfKIIGergjziuJC8y
         f4sw==
X-Gm-Message-State: AOJu0YwDKAIsgmWbUtgZYJztLxTz08/bkBQMBUdgEB2APMMtKj+X+OZ7
	fdS89IKefDztyfa8WsYSWz83tfnNdXi4kHL8L7iZJ5mmCwf2RbWRW209V4pnbCaDypw=
X-Gm-Gg: ASbGncs6EiWbe31eqyM9ZED0u9gqpvxgCfrf+EuVSJ+anpTIQ3HV6JzZB/AxbSrL6/f
	U8kaL1VvDJg9lyzaQC215opB4jMGSTc5at57WuNusPniUZsmVMEETdsBt13azP3Od4TEMFY/bFd
	v5mZyWJQgRzOpD7e+PkdEe2o1YMaWG/m5+SDHTzIEK68FAqOipuFoonL4zO5GaLAioMBVw4rvfg
	woDa3FTkKrNTxDkdMIKjVJraDMfhguJFwj1UCveR6dyinWe6lSBpxvgOF6H92T8DB8f8uOdDEjB
	6OVTRfIcUpZwou52mP1uxvM1pJ8FYcefwar90Gu4J/EFHcJYifvxtFJ3UquSWJ8ZVYd8pOXamcI
	BZsE=
X-Google-Smtp-Source: AGHT+IH5i4RvUZM0nPCi7tcfmNvCllRadqHx7du0uAq49bqRQdlg2xae0GaZM3j6FWwZkWAz37bFBQ==
X-Received: by 2002:a05:6808:1806:b0:408:ed52:c62f with SMTP id 5614622812f47-40a5d0553a5mr3358437b6e.2.1749677626307;
        Wed, 11 Jun 2025 14:33:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fb0bdsm2262b6e.23.2025.06.11.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:33:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 16:33:01 -0500
Subject: [PATCH v3 1/5] iio: amplifiers: ada4250: used dev local variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-1-bf85ddea79f2@baylibre.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
In-Reply-To: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=FLT2npDkqChFx9TKV+HNT+kp0SfQR8B+ElSxgugH4FU=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDI8v4nJy6e4KN3q+uPGPL2VJ/3txzP/j3Wo6vYVTmedH
 FX1Ou5lJ6MxCwMjF4OsmCLLG4mb85L4mq/NuZExA2YQKxPIFAYuTgGYyAQ+9n+am9+av+ffISBq
 pLB42hT7yta9Duxhr/TKJvzVVnsYtTFOqXuBfo7BGQ+5VPkp1U7zPhtxK1h7PpyRl1bgxr2ko0x
 /3tqClNtcF9I9t8wU8N2RYZL9NFbpnXjjY8b6vjsCj+Uj+M0yNt69167HyL4iMLVo/x01wZS3BU
 5LToQpJS/JEdt/milY79EjzbLV1ytUt3sUm/285cJZXlbAPouxXS5sm5xrkvfG6B0l9pqHTx7hF
 RHlmhSkdNxs+/XX2ktmfGwLbtln8GW/wI0Jy8Trj0Tv0XJaEcnjUnBScp1yQFHxiYsLLl5oZzd9
 cnTXjMOdRRb5FufqrI4JqF/Wry/f0yK1iGlNai/jjDudAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace local spi variable with dev in ada4250_init() since spi is not
used directly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/ada4250.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index f81438460aa51ce30f8f605c60ee5be5c8c251d3..397c1e1545cfccad9b0ff58b133796d415130064 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -299,24 +299,24 @@ static void ada4250_reg_disable(void *data)
 
 static int ada4250_init(struct ada4250_state *st)
 {
+	struct device *dev = &st->spi->dev;
 	int ret;
 	u16 chip_id;
-	struct spi_device *spi = st->spi;
 
-	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-enable");
+	st->refbuf_en = device_property_read_bool(dev, "adi,refbuf-enable");
 
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	st->reg = devm_regulator_get(dev, "avdd");
 	if (IS_ERR(st->reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
+		return dev_err_probe(dev, PTR_ERR(st->reg),
 				     "failed to get the AVDD voltage\n");
 
 	ret = regulator_enable(st->reg);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
+		dev_err(dev, "Failed to enable specified AVDD supply\n");
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, ada4250_reg_disable, st->reg);
+	ret = devm_add_action_or_reset(dev, ada4250_reg_disable, st->reg);
 	if (ret)
 		return ret;
 
@@ -333,7 +333,7 @@ static int ada4250_init(struct ada4250_state *st)
 	chip_id = le16_to_cpu(st->reg_val_16);
 
 	if (chip_id != ADA4250_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid chip ID.\n");
+		dev_err(dev, "Invalid chip ID.\n");
 		return -EINVAL;
 	}
 

-- 
2.43.0


