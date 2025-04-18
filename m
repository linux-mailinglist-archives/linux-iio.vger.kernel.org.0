Return-Path: <linux-iio+bounces-18286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC8A93CA6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A993E447A25
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4221D3D1;
	Fri, 18 Apr 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wqoPHnvg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F807215795
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745000189; cv=none; b=Gm7YyDs+ThMpF7v0E5QjFxTE/UJw4Nx2WrQkH16XyU7TEcLNw9/bgB1WBG9T/PeUgtPiuFo9eSxl+QSGPCTPg3De928CwNnmbWVc7O+GTxJvigko63nN5dTQyvuQSJKYVDlXCAsypsiqKc41zmwQWIyQdPCMZ+6jz/RQGi3WK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745000189; c=relaxed/simple;
	bh=Hrwf1aoUO2fKyKpeHM/6WfWnH0OQTd0CdQrP2NqF3dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ngpCNBR9218MQkvUlWRy6Sx9Unc/ub958eYE5RPbzU5dOpw/6WLKgKFTrLqRKukCLIFWJJiB+rvf3ejw9L8PKESTp8CxB2xfhBtlM70bge6aHyPXj4+HB3yskMoH2zxAgJZDiqqp7g9BHqycd4CaIXn1WnaHhBzB08paiELCHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wqoPHnvg; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60406de9cbfso728616eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745000185; x=1745604985; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQglEEV086U9T/4BDha3drx4fl6TCsy6FTdFNCiQyhY=;
        b=wqoPHnvgrgXKV8XiHE/XIY69OiEqMXeUDDDrPw+YYbleKXiiJrSXLYUSEZRB6SYLDo
         xOeSRXp1WYMuGucppLYRwohdGLOtQ0l+S8CC7zARGq/SvVyMqRNThcIsGWUPgr9ykb4l
         LL45uAp11CLzT7k+BVGH6JLQAE8Qg8MsyFbHgrTLGiyrqeV4cL5eqrrJt6M+SSrqeyKP
         2KHJVIqwt4aFoKyUky3J1oBfdYuS/3NhcftTYiK/CHmqkD00FbMZtH4Mq48rkFXcLrK6
         /2jRcQcpQh7D7fB/y7pb8Svaanx+Gj8t46Nn0J8izZBtNmISTLu1C6dH9H5AVa7w71bw
         lXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745000185; x=1745604985;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQglEEV086U9T/4BDha3drx4fl6TCsy6FTdFNCiQyhY=;
        b=vTXNvTi4CLEqGyLeiubkEiHX7MhRWYvsC/Cb2LeLvgE2wvCx0DRwcQOHREo3X61WjG
         QdJD2Hj0PmMRMEjLs59PRzBWVUdCApNlzx1dO+Jla+CJA0YX/ywxHbAFb9d/j52RGOgp
         Iyr5bSjK8JiDc9YB9AOcBCI2iGX7mimOuOx4f5XDa2zoTvah95r4Pmw7/acDstNHKjjn
         sXsSa2xOgY8SDIJMwAQVkQdzFkz5HtJOqNf8LxUItvC9A2ou9gFIYGeip3+C5kzbP89L
         IDcqtNY3RN91U5lvYwUnvMMKtQekEOlLWnrh5N/HwoilMzXNoSb1tGkbCRX/VBs1xBUq
         4khw==
X-Forwarded-Encrypted: i=1; AJvYcCU2kdSlGOfpyjR3Wv8yR7f48yI+tfgKKc0YECoF53wxS5WWwGdDiiAC+Wi8vhLdi+Vtci1py6TxbCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwrBTGY7KJJGl9gbVu77TwyXXJQGyYZebI3O9cq3G/faBgKrb
	Fz6w7DCb+dMhJGF1eo7M/UoxavYaLGJ8i4SNcPLKZcxz0uPxxgEn7oSeYj+hmm4=
X-Gm-Gg: ASbGnctlxXu83oXpQjAO/Zk4mSrb6437uQbvDx4thc68bCwzxcjAHn5pibKZtwR6Bw2
	Mr86e7Ff90V4inRLW9zEWO7uK9FNA0hg6dUaY4fFg6yI8nv65mmQsTu/M0s7M41aRRndQGdE7zX
	axSfXKLUPhurq0kigTn8Tkw6jhIxkFA41ZdEYEzoKaDLY66uzLncBxwnypcw6EWOIjFMlc9kscQ
	7nNdD6/ex5ODnfFAQH+X87/Z2UX/DnNp5wMEM52ggAPDAjuHrV/ONofK9S8PnsRDh3BC/43pLAw
	GsQrwjARuSzw4VoLU6zxscuMOvVHJ3yp22kqNFNZntjBYdk=
X-Google-Smtp-Source: AGHT+IGe/oEO2FDNEKJyCLo/N4egBJ8nsACv4TcQtDgohfoTf4RgTfAbniyGVr1QXaHxO1TEdosMtA==
X-Received: by 2002:a05:6820:2288:b0:603:f973:1b1 with SMTP id 006d021491bc7-606003e8080mr2035983eaf.0.1745000185505;
        Fri, 18 Apr 2025 11:16:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5f7a1dsm436659eaf.20.2025.04.18.11.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:16:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 13:16:13 -0500
Subject: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOyWAmgC/x2NwQqDMBBEf0X23AUTI9T+SulhYzbtQBsl0VIR/
 71BmMubBzM7Fc3QQrdmp6xfFEypgrk0NL4kPZURKpNtbd86c2VgYvnMb0RoLixBXDVccHYbB1m
 E/RqjZkaqwcJDp96bzjk79FSX56wRv/P1/jiOP0wZRluFAAAA
X-Change-ID: 20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-93ebb1344295
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Hrwf1aoUO2fKyKpeHM/6WfWnH0OQTd0CdQrP2NqF3dA=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDKYpr1PVGb7ZHrjghtDqMjJf+ne12wTNuhe/vtX762Iw
 RMpS3/mTkZjFgZGLgZZMUWWNxI35yXxNV+bcyNjBswgViaQKQxcnAIwkcBaDobW22+9P20tOHRp
 N2vLXJ290cvuZsZarfYqmtESv2haYrNolaSmvz9HMMc7YRPV4ltJ5+5rvercp37udSt3QrHOnIN
 qmn4ftIU4+K4sck8yueE8i3/fI8+CMO5rm+39Ivc5FBbbCyQ9EHBrsE35xxzJlFv2O+e98i+uqr
 8bUtmsI/gss9iW+oqYRcwKlfE8Irbkh0as4zP7QwxyL+XdhfQ/xl+4IrXLvtyybetMqb4rKWU7F
 xjfe9DU1byybxlzjPeCyiKZ3NdMWRdiHm381SPvtc4750LdIf/IsOX8fC/M7gRot2z428ok4LTE
 S9D2c/ime2trazPyw6MWCsj0TXyedTs5WUrpzF+LAAsA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use DMA-safe memory instead of stack-allocated memory for the call to
regmap_bulk_read() in the ada4250_init() function as this could be used
directly by a SPI controller.

Also remove unnecessary use of get_unaligned_le16() and explicitly
include linux/types.h e.g. for __le16 while we are fixing this up.

Fixes: 28b4c30bfa5f ("iio: amplifiers: ada4250: add support for ADA4250")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/ada4250.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 74f8429d652b17b4d1f38366e23ce6a2b3e9b218..f81438460aa51ce30f8f605c60ee5be5c8c251d3 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -13,8 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
-
-#include <linux/unaligned.h>
+#include <linux/types.h>
 
 /* ADA4250 Register Map */
 #define ADA4250_REG_GAIN_MUX        0x00
@@ -63,6 +62,7 @@ struct ada4250_state {
 	u8			gain;
 	int			offset_uv;
 	bool			refbuf_en;
+	__le16			reg_val_16 __aligned(IIO_DMA_MINALIGN);
 };
 
 /* ADA4250 Current Bias Source Settings: Disabled, Bandgap Reference, AVDD */
@@ -301,7 +301,6 @@ static int ada4250_init(struct ada4250_state *st)
 {
 	int ret;
 	u16 chip_id;
-	u8 data[2] __aligned(8) = {};
 	struct spi_device *spi = st->spi;
 
 	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-enable");
@@ -326,11 +325,12 @@ static int ada4250_init(struct ada4250_state *st)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data, 2);
+	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, &st->reg_val_16,
+			       sizeof(st->reg_val_16));
 	if (ret)
 		return ret;
 
-	chip_id = get_unaligned_le16(data);
+	chip_id = le16_to_cpu(st->reg_val_16);
 
 	if (chip_id != ADA4250_CHIP_ID) {
 		dev_err(&spi->dev, "Invalid chip ID.\n");

---
base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
change-id: 20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-93ebb1344295

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


