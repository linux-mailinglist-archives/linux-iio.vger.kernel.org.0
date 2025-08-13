Return-Path: <linux-iio+bounces-22684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D686DB2504C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1931BC74ED
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3B28C84A;
	Wed, 13 Aug 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgXR3qs7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319D289357;
	Wed, 13 Aug 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104090; cv=none; b=Hm7KSOyWqPcQAa/pJJUfphLhnls8/o4LjCUUUVRibEazHkJC5Dr8RTZi/W1mOUIxCvwHGc9KJv0idCr0AovwZ/7odbJO4o7aQSK10TkbOkNv6ZRypabCq9emMsS+FJNNdAIwjoDsGugrfdacZUHuUPQ6C4z9sT6wMjpZuFe5ghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104090; c=relaxed/simple;
	bh=7dL620a4ki2oCdeq6jvorfDoA7+7B+wm9Jmm2GXEtLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GADzqwydPFspFXGALIAmzUnZkq+Am5zGWSc7qC1y9nhbLvNBDjBgFOM3yPiFDS19n4fh0vbiDA1bJCNx7W/XAQDHrRQqLS25w9m0B2m/hrhQUoYyTqR+ko79EUUBOoDz5kmXR8bQiYizcvRPlonVeUjFlcDrTeeen2D57Ayycc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgXR3qs7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb732eee6so12116366b.0;
        Wed, 13 Aug 2025 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104087; x=1755708887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEhRKi0HmzptgOPz8lO5moCSp0j9P7xyPzVGCUEQhMI=;
        b=IgXR3qs7IXByeUWH++eMGOoqTf5zs4xGYi2rtjV+aLjd9saM1oYpNCNDRD/wrXCi+0
         AJx8lXIVnhFJ2rsOqylexU2cTOAqbiSXgNMUWhCEhKuUwV/j5Cyajrvung1MxAKfHIDa
         gJITtoSaolGFRR1197QqbsyCyrztXlHrUHiuXttYeAD13o606nVcmim2IvKokqsCchBf
         8i0Kzj5G5p52UO00yrdpzXXH/8QUhjPzARoSEpZFsNNh4JlaF6gesNY+jpZH6WKR/+Qm
         pq6SzsZE02PhBX+7XCFimANVPrrRivxr/kst3rQvfSip56x4pKOJeQgdGaVD9VojMpuK
         6HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104087; x=1755708887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEhRKi0HmzptgOPz8lO5moCSp0j9P7xyPzVGCUEQhMI=;
        b=peeQ4zc+3Kpgm/tpUXNHgyqVPCLCRpVDjAG9u0Jk62e2x3IkZdLJDesKKBMeRwX37b
         d1rD1BTPfimZ2f/qTD2psx3l71d9ikLw8AoyUQYFEOFvTPrTQeVEZ2oU9ktK0VA4+lFj
         CriJDoy+JVMjxWco/RcHMoUhypCTxqkt0LZ74BBsukqtVMJKi0NOD8MEro+/1oXDWXRG
         hpDSv46d3xwysZZWEuG+VqxcvviP6m+xXwlCeRad6crJ99VfkKEyZ/9fGhMZOSWGFUsG
         PoTlxG6PF9J+7hcSRa4k9taQlMSEJmLnF6DN2v38qWVlzvH9+T2SQj/8XcqpJWf2QEe0
         fMbw==
X-Forwarded-Encrypted: i=1; AJvYcCUDx3a2IWODA0kg1SonWfKvtHDIGBVClFTY+NmIIYSLlq5z5TiLPFnPTyzH4Mt39el9SMSBV+zS2Og4G9Ho@vger.kernel.org, AJvYcCUt0HlB/598nXQB1QhoGr8eeX0R8y8E8KgcOz/kkjO34vQlBe8/Nlx8HErrLlVVkSHfecKreSqg4BvQ@vger.kernel.org, AJvYcCVjsUh+EV/avXjub8pfB9XoCCM3ZnjaZ2ZLU3Gpcrdx4BzkI8ANiKrYKHSZChloCH0a0+Zm20n5h7nZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxFbTx0m5kQzkq4M4U0z7sRVGOpMCxpEOjfw3cY5SmqWvh+oC
	qJJ2FSGlzHRLkXcoBAQ47OmCzaBVvOD8vR4JLiUHa5dRdfjmQq/vCi5/
X-Gm-Gg: ASbGncs7lDiHAGiwEAdcdrnTSXWRpLXJmXVb9Bju0C8Z0g209u0NqkooDKWeze+7ZCu
	8F56QEkm+w4umjDY12VDZksOgsT9wjB6YiB6bkL/NeAyV556dGQndeplte2smRiBLGStIySCXV6
	W49QUKdvHuZi+e6soHoTqU4s2rKH1fs+sk3rlfEP6Iy4+3MmBbh/PlkT8PMXjsSrKG37ntxK8aR
	Trs7bXrsWROId5VkiZHIkeGKR3fLQ8aJ/b5RFy7OPH4DQNf63GZ9H35HD27vi2MIPsQhh9bCgxB
	ObRrsQb2KViYXj4HAk3iCzTASdm/Tp0885GJdSLlOW5n7u66c2yHZYUTtvOufPAVqDU88Tp1YG5
	aHbCc1gQL0aqiXlLg8+D8w47ddKNc
X-Google-Smtp-Source: AGHT+IGbIy0t+cv87axBnTczH6JnGFlpDASg3yYTJxc3Lt9IBLpKfzxeToWCTP8/ZKwMMg9JatNFVQ==
X-Received: by 2002:a17:907:a4a:b0:ae9:a1f1:2b7d with SMTP id a640c23a62f3a-afca4d458c8mr433120166b.17.1755104086624;
        Wed, 13 Aug 2025 09:54:46 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2428573766b.82.2025.08.13.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:54:46 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Wed, 13 Aug 2025 18:54:30 +0200
Subject: [PATCH v2 2/4] iio: adc: ltc2497: add support for LTC2495
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ltc2495-v2-2-bbaf20f6ba07@gmail.com>
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755104084; l=1588;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=7dL620a4ki2oCdeq6jvorfDoA7+7B+wm9Jmm2GXEtLw=;
 b=A64wy1iR6PNTT8FN+0ia2z3zO+jISd6O+CMWuYM132PamqnlF2Otm0Ee/ynrVSpT7NLg9GkEd
 r4xqLqzIwMGBfWNSFhjODQiSh1e8Cf4yI9j5PwYq8BJElvm2+DUiqis
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Update the LTC2497 driver to also support the LTC2495.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index eb9d521e86e54def0493ea0e81f63b37900c56a5..8f4665547b5b0d32084599f8557c40102c37a4ce 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -19,6 +19,7 @@
 #include "ltc2497.h"
 
 enum ltc2497_chip_type {
+	TYPE_LTC2495,
 	TYPE_LTC2497,
 	TYPE_LTC2499,
 };
@@ -131,6 +132,10 @@ static void ltc2497_remove(struct i2c_client *client)
 }
 
 static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2495] = {
+		.resolution = 16,
+		.name = "ltc2495",
+	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
@@ -142,6 +147,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
+	{ "ltc2495", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2495] },
 	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
@@ -149,6 +155,7 @@ static const struct i2c_device_id ltc2497_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2495", .data = &ltc2497_info[TYPE_LTC2495] },
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{ }

-- 
2.43.0


