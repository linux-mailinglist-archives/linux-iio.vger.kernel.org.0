Return-Path: <linux-iio+bounces-21323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8EEAF8333
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 00:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E5E3AD6BA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB128EA4D;
	Thu,  3 Jul 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDx2PVcN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43745239E76
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581004; cv=none; b=QV8+3A5TGsB7kznXxrPlltwD5MMq0DTQbQfcc+K4BoBV5gZVjoR2b/QCZhmF+fo+28D7+3iMHzc1BvCkr6Mv4dzD8HNbBpo56RUtnFhAHkBZsFkChz6daR2EBH1aMt54cbjsMxO/JMZdYMwrBv4sq3WcVxAHVWG2oAfF3ict9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581004; c=relaxed/simple;
	bh=W9770yHaKoXHLazWvcBuBx5fM0NUwCvVQ5t3NR2GDns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rp6t+hVpO4HnJJrNXpBeukw1VRG1Y3+4i5mNEad5gG6Z3GEx+d2VPNq0pG4QNRWVB4Ob5h4Z3LQ0bVQE3nv1+uIDZa59qqPAu6WIy8g6pIyDdMeWN0uYFYdb9TZ9E+gZ0EVTKQzB88zHmwdMKHc+Jt12DwyIfHfRkVRVCbY2l2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDx2PVcN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40b54ee16ddso272969b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Jul 2025 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751580999; x=1752185799; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0XGqiwxYMZ9HV5LhVnxrJ5VDoHUa4qHhDisClq7EcQ=;
        b=RDx2PVcNFewU3zBffLKc+Ewf5K80G3T8gNmvS2NxyqwTzrWoMK2/0CzW7qbo8kagVu
         rfpi6OayylOvtQsc+29Hj6EiVgpZC+icWnhq8eqxgMaoZPPzwf2QdQfh/q2pk1KhCLCo
         i4Ihc1hrNwcBAKkXM9ynXidxZfFKSjrrCDVrkCZiGJ4olrhmqQDPLcQE5UaNS59WxDFf
         sazvixFt+SmePm5733cz4HOPAF3R8PB+UqPqPMR6Vc11aYd2cvMdjtoYlTvdxA/CE2EH
         5vR7lMg5Wu9EUs0ooxyrk4NeEkSlpRFczLevNCk1/Xc4tbFD2EG6f/DKk6L6kIzYOU+U
         2x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751580999; x=1752185799;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0XGqiwxYMZ9HV5LhVnxrJ5VDoHUa4qHhDisClq7EcQ=;
        b=RmtuUopxC7UFuHFP3SDOSzRf4Vq9+GWsH4P6D8B6y2gAZlwmhl5JsydMZqFR/1tntd
         6m/XT6/JXCtnYopuSJfAL7UtiLIkXF/MrTHBZqjCB+jI6KNYeWk60t1AdEebb+lDaJXZ
         C5tdEA1zo9zM/f6LYZlEgGAo719bWhz2HVpkChvW19rK5QhJXefeLC8KcJzA8b354qSR
         Djs0DlUKHST6sBSrXuGqQ6jN41dt6cnyISVjrOlJDC33AsaFe7Sk6fqdDX8+xnnKYzyL
         Jhzj69u79aJUXoqgGFY6Xme9rUsVNv8IimBU/8xZ2ze7FEMBiT4OgYgCduva4SESaql+
         4hGA==
X-Forwarded-Encrypted: i=1; AJvYcCWEcjM0PnS+zq9zadMlvchwzQi/7atn2jUPouXX3ORfcq0I7hwO4RYb/TUeLNMYZQglBEoo0O0g+3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YykH1kHl8K72kqRw1JpXL0uHgMVw461ov1qNC/U5k+VprIjLjSv
	z4PXJKyQ9vh5hNzmxteafBvM0bELdU+WHrTVGPvt536+DNxz3J583io79y5391xflrU=
X-Gm-Gg: ASbGncvYcMSWbkZsodfmlg9AB0Sx/V6vE3dQqYqh3LWCyWWOCmHLHG/aK5hOh7OiY3Y
	4cGn0/Z0kaRAvzTHY3Mplk8ReD7PtqYiEEBgvWQ9Te7EEE0ZaBrvQP/B3U/2pAa56t0+oTSllHt
	t6JQvmF+NZIKv2FO7PNS0jEzlqILn7f0hlb/lm80F/DYEDD9695Moi2oQ4p+XEkGhicAmQ7Klne
	+M7EjIFZj9Ay3CcXAsuJjlMX2VRWImUut40lqDxjc9goYAAROv8eGwAt9jZ2qbU3gfyib8UnZqn
	Rfe27IXCeSYaTG3B4ldWZEfdzBCS6WUIyPQnrpO8igief/q6o1IRVbZks70gWfephbfM
X-Google-Smtp-Source: AGHT+IG6piuIY6GUlPMt05LreSwBeiK1YnTwnheqRB/4wz1nz1l+W45k2G2E8x//P0SfvTRyDrl6yw==
X-Received: by 2002:a05:6808:164b:b0:401:ea99:537 with SMTP id 5614622812f47-40d04194286mr409714b6e.16.1751580999263;
        Thu, 03 Jul 2025 15:16:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4f2b:5167:10f4:c985])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02aed5cfsm98021b6e.48.2025.07.03.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:16:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Jul 2025 17:16:31 -0500
Subject: [PATCH] iio: adc: ad7173: fix num_slots on most chips
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD4BZ2gC/x2N0QrCMAxFf2Xk2UCb4ar+igzpuugCrh3NFGHs3
 w17OA8HDvduoFyFFW7NBpW/olKyiT81kKaYX4wymgM5OrvgWhQpGMdkBB9afMoP82d+6LusiiX
 jXHTFNMmiOFwvRK6L5AYPNrhUtvw4u/f7/gdG8sgZfAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5327; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=W9770yHaKoXHLazWvcBuBx5fM0NUwCvVQ5t3NR2GDns=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZwE/+foM7GgIfN3ZPQBRFO7wsgm3Q8Ezoc8Ki
 KCkY+lB7FCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGcBPwAKCRDCzCAB/wGP
 wBy9B/9la9cK+jDz0Kmb1pp6qXNa/GUrvv9OjnIQjsWK/9tYSxTOR9V88pEtRexuYRcKYzID1b2
 Q7fB50mXnU9OG3qkPki2W7dML8Ow1KX2/+R0AaD0e3S5/dJG8JN2MNewtSCfCV9vSmuGWla4DyW
 d2LN5G3UFS1PlwsEj2/Wfccilo++OEV6YGTztjjsZPZzulNRXEVP84LsI6Tmhj71Q/SVmmBBcCk
 dhVQDD1ILlhf11SxTLsVMh0S231XBUvlRa16AyJUg2TM5X9kUmgEat9DCtfOejD8oAlyKvSMBFH
 QgV3ZN+vBXfZMFzbhweL6JPcDkG8eSfn6fthdfrt2OIWr1TO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the num_slots value for most chips in the ad7173 driver. The number
of slots corresponds to the number of CHANNEL registers on each chip.

Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
FYI, the bug actually existed before the commit I used for Fixes:, but
that commit did major refactoring involving multiple drivers that would
be too complicated to try to backport to older kernels.

I will try to send a separate fix to stable@ to fix the bug in it's
original form on older kernels as that is just a one-liner.
---
 drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
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
+	.supports_spi_offload = true,
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
@@ -796,7 +813,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 static const struct ad7173_device_info ad4112_device_info = {
 	.name = "ad4112",
 	.id = AD4112_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -817,7 +834,7 @@ static const struct ad7173_device_info ad4112_device_info = {
 static const struct ad7173_device_info ad4113_device_info = {
 	.name = "ad4113",
 	.id = AD4113_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -836,7 +853,7 @@ static const struct ad7173_device_info ad4113_device_info = {
 static const struct ad7173_device_info ad4114_device_info = {
 	.name = "ad4114",
 	.id = AD4114_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 16,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -855,7 +872,7 @@ static const struct ad7173_device_info ad4114_device_info = {
 static const struct ad7173_device_info ad4115_device_info = {
 	.name = "ad4115",
 	.id = AD4115_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 16,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -874,7 +891,7 @@ static const struct ad7173_device_info ad4115_device_info = {
 static const struct ad7173_device_info ad4116_device_info = {
 	.name = "ad4116",
 	.id = AD4116_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 11,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -893,7 +910,7 @@ static const struct ad7173_device_info ad4116_device_info = {
 static const struct ad7173_device_info ad7172_2_device_info = {
 	.name = "ad7172-2",
 	.id = AD7172_2_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
 	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
@@ -926,7 +943,7 @@ static const struct ad7173_device_info ad7172_4_device_info = {
 static const struct ad7173_device_info ad7173_8_device_info = {
 	.name = "ad7173-8",
 	.id = AD7173_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -943,7 +960,7 @@ static const struct ad7173_device_info ad7173_8_device_info = {
 static const struct ad7173_device_info ad7175_2_device_info = {
 	.name = "ad7175-2",
 	.id = AD7175_2_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
 	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
@@ -960,7 +977,7 @@ static const struct ad7173_device_info ad7175_2_device_info = {
 static const struct ad7173_device_info ad7175_8_device_info = {
 	.name = "ad7175-8",
 	.id = AD7175_8_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,

---
base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


