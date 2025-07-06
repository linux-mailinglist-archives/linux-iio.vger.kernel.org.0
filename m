Return-Path: <linux-iio+bounces-21414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B74AFA763
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B677AD61E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3F1FF1C4;
	Sun,  6 Jul 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GN2QpUd+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D591DE2C9
	for <linux-iio@vger.kernel.org>; Sun,  6 Jul 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751828006; cv=none; b=GkEB8g+IcJdD3PQC/1edF7aCC1Pla0Rbiyj39V2MzcI3wrm5ItVTslx4Tf7a6fLTXTMNqMDiLn8d1cj5Uga0c+iyeUdXyxjX+5mnQ4N60IA3iZNAs+YdO2TZGQCnuMXAJsYEwo8eucGafydsJ3IMVYpWBZ6bOC+0TmXy1+oPKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751828006; c=relaxed/simple;
	bh=RhkFy6ZKHzNXonCQXjQIYuppZ4UiYZk7SXxTyyjmqKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E75Yj+lLIyJkv4CtUv7ngCvHQRf9/SfKExa//mYrHSArmN2e/6LIAVVgNXXXgYZlxqxLHR3iFKRd4mrR7MOEJP14f02d0hwzYsen3uTDQ++RiyMTsq6WCNhkbXIxnz4WI4D0UXqyp4hMqkMzfN5EyHf2vuHyRQc7Bt8ST0Dv7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GN2QpUd+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73b5350980cso2079388a34.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Jul 2025 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751828003; x=1752432803; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoEeqQqxPj+MY3KyZB24QezFKhBGxLbrFZBnD7WBTKs=;
        b=GN2QpUd+sprNV3QczNLFJD7Pex5Vy59K3pwjeehkAa+PZJD9hNNAo8dFUK22YSbH31
         cnNCXThT8iGoBw7/XOyOQD11OBMOVV1DlyX9SGfJMCLuubmoz26lrYBjC2O45HIDImIO
         VZPiTOfqaJBXqV6hO9KMThw7oNcIooMeksMKmBrM0BUkdjqQp+h91RV3k3sNIW7h6Z+9
         ZRe42xl2wRvIuaGEVy4TazCidcGFvNFyCYe95fGIgmYg1QxNwLZ80FK5rocCh99Fo38q
         jIJVWmyl0rKJRBi4Hd4qgbalQgRkkg6wwBxEXFpd3LmdsJ9HCWmC/0iJL0J2h10ihM1g
         JWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751828003; x=1752432803;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoEeqQqxPj+MY3KyZB24QezFKhBGxLbrFZBnD7WBTKs=;
        b=FMV8F4yRzA6UOTmcQwBT1FQd0vZkRV9r49tuIdFyjVO87P1Ok+49+ROdmHlZMZRhd0
         z5KIrm3WwS4VEnPCfmL/ma1xf1k50NxqzErjSqXd7lIeEUo1h8nwtRf0LqcHxIVJavr8
         iIjq2pmXdSOhj6WXP5/ITADUrhXM0uyrlA/DcP4jGOchYY/5WAcV4mDod9kpk2pNeKup
         MVXDpnP65OmV9n5QjgxP/hDXTIdPqyslTgpWOc1NLlehxhFwmmGEvP5Zy5QBGO8vodwR
         wWTi6U3JrEtsjeiEJ9+MQ/b559za1dJVrcIr9J7uggtwEABrQmk7in6VHsKo8o2/unDw
         Xeag==
X-Forwarded-Encrypted: i=1; AJvYcCUeh2vzPJ4Soajcuu53PXHnxE38RDuIPahgYSp7kfHODcdOw4RU3pHNnqaQOdVCR5GLy04YM5XbsgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNra8cgfOuC8pBZ16Ym88Q5shgACVs5Ye2V4v4BzwdZoLk2B+0
	aR5KxRy1BegYhvXWTu5Eip4+KTQlJ7JNGzG0z/6n3TSIKY96lMlMBFQW8B9FbjUD5/u52GjGYEG
	uVGx6GJc=
X-Gm-Gg: ASbGnctDsSx1S0fK7+/OjkJZpmhHhVzDgsNv4/JZyG/h2iu00bvjPHF0dpMpy2B0rNa
	BPPjBv+IAAqgdVnTggm6JYmlT7DnVdBTAIrvXACVpZIpHUIYvqFw8oZyDS5eFxfE+K/Kt7J15Lv
	MbhQnjWYmBC6C4SOZ5DNwMbm+Ow12NyKurSpoSVbliUFqaAck9TEOatVx69HSSut4v3XRdeo+06
	SJ/53emMkko9Wru6l8Ovl7Y4+93pfVpTRj6KyLJJ0bjAj0D/2keFLlltksjxqQYIUQ+pmynsGKZ
	Vp/+wj05bbdopXRdYiK95lOnRqSHlONOy42HSmUFIWK+Ru4mgTXJnelvVKhyrrOerNM=
X-Google-Smtp-Source: AGHT+IGNMnosMnLuDCwDiCVfDEkplAOFMESlGJyWQYWCAalTZLO4rr9zBl60hy+WzspO4fZitnm1MA==
X-Received: by 2002:a05:6830:1d4a:b0:735:a61d:5764 with SMTP id 46e09a7af769-73ca057243amr6025969a34.9.1751828002769;
        Sun, 06 Jul 2025 11:53:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:29a:290f:4321:4624])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cb3e44ea4sm797587a34.31.2025.07.06.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 11:53:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 06 Jul 2025 13:53:08 -0500
Subject: [PATCH v3] iio: adc: ad7173: fix num_slots
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-iio-adc-ad7173-fix-num_slots-on-most-chips-v3-1-d1f5453198a7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABPGamgC/52NQQ6CMBBFr2K6dkynLSCuvIcxppQqkwAlLTYSw
 t0trIw7XcziTX7em1mwnmxgp93MvI0UyPUJ5H7HTKP7hwWqEzPBRcYLLoHIga5NugILCXd6Qf/
 sbqF1YwDXQ+fCCKahIUBVHoXguRa8QpaEg7dpvsUu18QNhdH5aWtHXL9/ZSICghS5yWpEaTE7V
 3pqqfL2YFzH1lIUn3b1k10kuy5UqTDnJSr5ZV+W5Q2hvQ0gRQEAAA==
X-Change-ID: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6262; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=RhkFy6ZKHzNXonCQXjQIYuppZ4UiYZk7SXxTyyjmqKM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoasYXa/D73dyaUyLh+FS5zmtbpm4dkH9FC7cNd
 3Ok6U1kM5aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGrGFwAKCRDCzCAB/wGP
 wHbxCAChdsoXyQbyf5hh1ryEabtsK4dQYCz9XQz6rcmI7uucpnWH6r4V4WyWtw/FwWj1YhYM5mn
 4S2dmo4nRGycTR0wbBxOFa7a8vj14qBEjjJnnFUShkPJbZlIEY+G3mvnp91ErjARqO1Q4i813UW
 uEOUoZmjAq+0+E/kQrKvJvaNu4ZtRKOGvEGQNE7C2bAuWVcQohos4y9+0hJT2rSNwQqaMhRog1S
 DyQovjpTg7ZjDcBRjRRuqP/Rcw1THZREpoRcn7saY6uervx002ntiWrgi9fFL/lqbdoJX9U9RiW
 cxXcyyoKWc/MhI0R6Yhaqbzbft5lieobS0/aa2Bv8JL9rBky
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the num_slots value for most chips in the ad7173 driver. The correct
value is the number of CHANNELx registers on the chip.

In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
to be static const data instead of being dynamically populated during
driver probe. However, there was an existing bug in commit 76a1e6a42802
("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
set to the number of CONFIGx registers instead of the number of
CHANNELx registers. This bug was partially propagated to the refactored
code in that the 16-channel chips were only given 8 slots instead of
16 although we did managed to fix the 8-channel chips and one of the
4-channel chips in that commit. However, we botched two of the 4-channel
chips and ended up incorrectly giving them 8 slots during the
refactoring.

This patch fixes that mistake on the 4-channel chips and also
corrects the 16-channel chips to have 16 slots.

Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Here is the patch that actually compiles on the fixes-togreg branch.
---
Changes in v3:
- Drop supports_spi_offload field.
- Link to v2: https://lore.kernel.org/r/20250704-iio-adc-ad7173-fix-num_slots-on-most-chips-v2-1-a74941609143@baylibre.com

Changes in v2:
- Improve commit message.
- Link to v1: https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com
---
 drivers/iio/adc/ad7173.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 1966a9bc331401af118334a7be4c1a5b8d381473..c41bc5b9ac597f57eea6a097cc3a118de7b42210 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -772,10 +772,26 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.num_slots = 8,
 };
 
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
+	.set_channel = ad7173_set_channel,
+	.append_status = ad7173_append_status,
+	.disable_all = ad7173_disable_all,
+	.disable_one = ad7173_disable_one,
+	.set_mode = ad7173_set_mode,
+	.has_registers = true,
+	.has_named_irqs = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
+	.num_slots = 16,
+};
+
 static const struct ad7173_device_info ad4111_device_info = {
 	.name = "ad4111",
 	.id = AD4111_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -797,7 +813,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 static const struct ad7173_device_info ad4112_device_info = {
 	.name = "ad4112",
 	.id = AD4112_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -818,7 +834,7 @@ static const struct ad7173_device_info ad4112_device_info = {
 static const struct ad7173_device_info ad4113_device_info = {
 	.name = "ad4113",
 	.id = AD4113_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -837,7 +853,7 @@ static const struct ad7173_device_info ad4113_device_info = {
 static const struct ad7173_device_info ad4114_device_info = {
 	.name = "ad4114",
 	.id = AD4114_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 16,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -856,7 +872,7 @@ static const struct ad7173_device_info ad4114_device_info = {
 static const struct ad7173_device_info ad4115_device_info = {
 	.name = "ad4115",
 	.id = AD4115_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 16,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -875,7 +891,7 @@ static const struct ad7173_device_info ad4115_device_info = {
 static const struct ad7173_device_info ad4116_device_info = {
 	.name = "ad4116",
 	.id = AD4116_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 11,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -894,7 +910,7 @@ static const struct ad7173_device_info ad4116_device_info = {
 static const struct ad7173_device_info ad7172_2_device_info = {
 	.name = "ad7172-2",
 	.id = AD7172_2_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
 	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
@@ -927,7 +943,7 @@ static const struct ad7173_device_info ad7172_4_device_info = {
 static const struct ad7173_device_info ad7173_8_device_info = {
 	.name = "ad7173-8",
 	.id = AD7173_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -944,7 +960,7 @@ static const struct ad7173_device_info ad7173_8_device_info = {
 static const struct ad7173_device_info ad7175_2_device_info = {
 	.name = "ad7175-2",
 	.id = AD7175_2_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
 	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
@@ -961,7 +977,7 @@ static const struct ad7173_device_info ad7175_2_device_info = {
 static const struct ad7173_device_info ad7175_8_device_info = {
 	.name = "ad7175-8",
 	.id = AD7175_8_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,

---
base-commit: 731bfc181896a4dfd20a8c219bef1c205dd1d708
change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


