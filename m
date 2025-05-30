Return-Path: <linux-iio+bounces-20039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515BAC9188
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BAE3A79CF
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F923231853;
	Fri, 30 May 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aU7zOldD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC623184B
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615377; cv=none; b=lLrY/mbUpHBqqWkAMuU/d+sqSEKumCciDgMvZ+neew5gSNRgBt6NWV05n23kmkeMD+nhD2sXD8PvaeaKdUWTe4bvu4E1SuKeyd/E1mha+WIiy1JyCsPCnx7K33EIGyDVj1qUhgnAFhdWU4t6JWcu9SrcLZkZMPvo69/osfMUwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615377; c=relaxed/simple;
	bh=EuVopUch3RvcMm8wwL4YgvpMZfFl3NzeePoEsn6JRZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+BsSdHA1omBhvXpXK5OFEs1UeyLuqhg9IoQu8wflGhUzVwM7GZ+wKgz5ueHVuoOqyzvhl2YQ7zdvgyvphjmOlZap1R6wRuCCDkHjeNCWBapzSwCYnPAvifNHgChU0V102Tm7vfDYoJ8xRPaIcEXzZL8J1rZFmB/9YB1quGpRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aU7zOldD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso14210405e9.1
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748615373; x=1749220173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmgqoKB1/8SUojJrwigc9jIEEcoeGxp7/cQDPaSjq8M=;
        b=aU7zOldD9ZxXSlViNY7vsDy7CzfmZxKhgqXfAzwNq22kK+UkjjTY2CEXGUshqUIg+H
         FD82YXoqFDb02wcGZ5jSXo0ENnlXDYCg9B2LYdZDHWgoVgEpITQTK1AguwZxMK+Kw0Pc
         gDfQ7GQCmlRAuRZeK+51HRFtkYYEGhbKJ5DiakQWbsmvL1xzvYaxA8WGTlnzRXPXBLah
         Y80aPpgDn0ClPxrfQKh+ygtCOELs6+9+gA+Odlgf7xuNzlTW7aCm1wHZBkEhcqKUkZVp
         ooqSNNjJbQBoNNXW/IKKOvlzzD7ImaQrWqZ1T0t0n5y2w6Q4RUZbiZJwSWo1n1QnHaJu
         hRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748615373; x=1749220173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmgqoKB1/8SUojJrwigc9jIEEcoeGxp7/cQDPaSjq8M=;
        b=b0Vt0kXhjV+O7E/i9qqjIGteXaGt+uMGvVzkb8GkCIvJnhl2IjXWI4HFErct9dpRsd
         zrhzX1UUuAIhCB/euI8r8Q79br3BE0Dy2pwyQx02n00FEBW9gaIdhsgWO0wrbnx4EMy6
         DyMa5IWom7UPkG/fwUcxJgvOtL3ifvl+XQ3OCMvINkqJI8t8qfmlMgqWrs11aS69zZaQ
         LWZro8q3KNmXNqfSAkLevbWhzum6ygoDKkbe+D4PQZOThkPH3flhB4Z+EGxgxeULeSv+
         Ut2icTmrMxwb3UhMplUkO8ftWhnoRVr4nkAZHZu/kRK0mqLz6cMIqF5CBgaOqOlX3lXn
         6QSQ==
X-Gm-Message-State: AOJu0Yxb275/JVXX7085JzxfboFPVT2vrF9fXts8Wav2fMUmB0U/PCax
	ge+O64SS3N6TG5VZJJA3HsCmPoPRUgMdNtlOR+dhNVEg9o853I1B5DTMWvgYdTHBRlA=
X-Gm-Gg: ASbGnctvbt4pNnJQZW6sA637M+LRIbDQbr1uOKlQQSQK6fatvNqGACq8Gm5iMRel59a
	AojF7mpobMArg3HNrHruh6HeDihTaTbgOUN4GppsZUyzZYwFf/ZwSmOx5jQepfNGMc8Nih636My
	DDqxaFYHPj5C1GBx0xrWZ8IueTX07v2gySjeF+Q6CWkuruwF+l5prxnjSAMYn5WXU9Ih6A26JO5
	lmhwEECWm/ssfKJ9A0vWLJAoZaUQqffGGwhYmbNmTWfRcrUtHibwKDJKnHS02BDlU/iEBiF9TkU
	hkTGQZnJxFSJVpEBdPqTHIKAv5c7qJgrw4KS8TU0i4YBrY+MRnTRBqQCquZ0fS0Bmfd9ufFU4Nc
	922yEQ8/lv00rtcmpkQZwuLLrj6Ga7AaVxBHQQ27MXQ==
X-Google-Smtp-Source: AGHT+IF82ytKbgIHFm5Bt+8HmPnB/Ki48PsCv2MzqdtONrfDtpN+r1/QBbMV71yK7tUzIx2WC/FR2g==
X-Received: by 2002:a05:600c:4f50:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-450d886f6b1mr21172615e9.20.1748615372671;
        Fri, 30 May 2025 07:29:32 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a0421sm4979870f8f.97.2025.05.30.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:29:32 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 30 May 2025 16:27:56 +0200
Subject: [PATCH v2 1/2] iio: adc: ad7606: enable Vdrive power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-wip-bl-ad7606-reference-voltages-v2-1-d5e1ad7e6f14@baylibre.com>
References: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
In-Reply-To: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=WbJxk5bQxvmJFaViamimQiGxr43ZTZXKFb47GKJ4NwQ=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwPFDQqLeY+/o1OWv2E1+T377JtNht5PvgtMWevNXF+
 sxb1Hu4OkpZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExE1ozhnyL/Cx3Pwn1R8tvq
 Az5LzDvM+zeoTKE34vT8Y+cSXuieeMDwm4XvUtixux0Pl8zds11iq//BdQ/4S2V9pIv9GHvdQlT
 b2AE=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Enable Vdrive power supply. The "vdrive-supply" property is mandatory,
already declared in fdt dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 185243dee86ed2e9ebc43b578003d0c010e97a9f..3bbe9c05b5edbc11e8016c995c6ab64104836e7b 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1330,6 +1330,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable specified AVcc supply\n");
 
+	ret = devm_regulator_get_enable(dev, "vdrive");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable Vdrive supply\n");
+
 	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {

-- 
2.49.0


