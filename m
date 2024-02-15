Return-Path: <linux-iio+bounces-2591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496A856C63
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 19:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EDD28451A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E89132C37;
	Thu, 15 Feb 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmvZsB+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D3137C2E
	for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021485; cv=none; b=JxW6ZpYxqDevJHQYmK++t4/RaJxFrPu3cvjpEHnu4xLpmlFT1JRT7nMkC0JI0LHD0og8Gz4cUrY6XPyGxHeqDuXS84gQjvwpQEdTrQisiJ/T+pA2pxhQOmeJNpTpXa0Nfzenl22S1HUSRiCW2v0mfTrs/qlwlRBKSaCYh0ZsVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021485; c=relaxed/simple;
	bh=eQ9kHGUPUGfIhEIq+gIIOnTzO8ZyUBpNDNe69oKb744=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9NmobOuXLt2DU7KGa2K3BATM1APauQA7ORl1LDMYuSNxS6zPACz/l+8lYaSOkyXiz/m60wIL+8EQ/0oBwtH3dp50hUk7VHcVwuZKimZEooIylMrFlu0XC+jsKQD1SrhvPsowMKuew0W4sEfX9z46sVc7UBLq9gKdejWSWXVGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmvZsB+v; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da202aa138so918276b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708021483; x=1708626283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI+zfBfbUuHZFjTneM3oBuHFagOxjaKZJ3kSffZ8Pow=;
        b=UmvZsB+vSM5/qjzUVkuiOCHziUBbaBlrEiGvpHi7/aPbZAbcKqFpKoT8sksRv/hViJ
         vmTTrQV4K+wubprrrJr22Il2ZDJW56d7sz8fzj8aivUF3bmWRoN/5Gao2TZFFtdDSShD
         OgzVquJmvwI8uxJXU9qfpb9/oUH/zGnCw1F+TTYfj0nx2yMqvo/T+ZXoc6dXSQeYBICX
         kWsU/gQi+VZBIa0113fMiA7Q6qJvvi5g4bK3m70zAgnM0GDoxxf1nR312Y4E4ipVzI0e
         h2NnPkDHTQ6eCriSIdCuqnUeO8iYHSvOLFGX3g9vpwf3BOlDH2gCoCK+8B7TBeq/bwrk
         LP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021483; x=1708626283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI+zfBfbUuHZFjTneM3oBuHFagOxjaKZJ3kSffZ8Pow=;
        b=H+yLVUbx3DJ5MnZd7+7wXUVC7IcEC30YNfZSnrsjXNXbVv4VvSLZ5iO/Ygj1WTe5Vv
         Lsxd+OZPDArRjH/ACzLlPT2DKvPgbpid+Gh5PPVQjLQPzrU9bytFtvm30qs/gw4g+6gE
         SIfU95OWQw7hwreBNz1Ft7IoJ2ORNaN+JcLDjVeDQf8jveqO8DJIXcu2GzMp7Ueffepj
         LEa0Zx+mrp6hBAsb8lcW8owEOs09m9Ts0CFUIkk5iEwy1CdnHgC7KGSQqd209tddJq1w
         RjbKIAcDFMRGgrPPyyabcR6+VmwwfSod/gMr5AVlpQxTXqGBsyyHTPvUMBlJedOPI+Ie
         JLvg==
X-Gm-Message-State: AOJu0YxIAFYK0guH+zlpgtZlmr68qxBMXE5MvGy/gpwdAV5tRlLspDip
	lxnTUzquWEIX8XGYlrAOt8cSeCx/QyQJyx+KF0wtQJxsOMk5CjMH
X-Google-Smtp-Source: AGHT+IF4VSjrl00VDmYTkZSa4QI3bElXldlUOm7smSEWaJcEFwR+va/ydtxe9Zyozj3xRci0CeScdw==
X-Received: by 2002:a05:6a00:26d4:b0:6e0:f47b:a5e1 with SMTP id p20-20020a056a0026d400b006e0f47ba5e1mr2590949pfw.20.1708021483408;
        Thu, 15 Feb 2024 10:24:43 -0800 (PST)
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b006d9a6039745sm1643916pfi.40.2024.02.15.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:24:43 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	andy.shevchenko@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jagathjog1996@gmail.com,
	luke@ljones.dev,
	benato.denis96@gmail.com,
	lkml@antheas.dev,
	derekjohn.clark@gmail.com,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v5 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Thu, 15 Feb 2024 10:24:41 -0800
Message-ID: <20240215182441.57391-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
driver with an ACPI match of "BOSC0200", and a comment about duplicate
ACPI identifiers between devices using the bmc150 and bmi323 chips.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_i2c.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 20a8001b9956..f7550503e47e 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -93,6 +93,25 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
 	return bmi323_core_probe(dev);
 }
 
+static const struct acpi_device_id bmi323_acpi_match[] = {
+	/*
+ 	 * The "BOSC0200" identifier used here is not unique to bmi323 devices.
+ 	 * The same "BOSC0200" identifier is found in the ACPI tables of devices
+ 	 * using the bmc150 chip. This creates a conflict with duplicate ACPI
+ 	 * identifiers which multiple drivers want to use. If a non-bmi323 device
+ 	 * starts to load with this "BOSC0200" ACPI match here, then the chip
+ 	 * ID check portion should fail because the chip IDs received (via i2c) are
+ 	 * unique between bmc150 and bmi323 and the driver should relinquish the
+ 	 * device. If and when a different driver (such as bmc150) starts to load
+ 	 * with the "BOSC0200" ACPI match, a short reset should ensure that the
+ 	 * device is not in a bad state during that driver initialization. This
+ 	 * device reset does occur in both the bmi323 and bmc150 init sequences.
+ 	 */
+	{ "BOSC0200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
+
 static const struct i2c_device_id bmi323_i2c_ids[] = {
 	{ "bmi323" },
 	{ }
@@ -109,6 +128,7 @@ static struct i2c_driver bmi323_i2c_driver = {
 	.driver = {
 		.name = "bmi323",
 		.of_match_table = bmi323_of_i2c_match,
+		.acpi_match_table = bmi323_acpi_match,
 	},
 	.probe = bmi323_i2c_probe,
 	.id_table = bmi323_i2c_ids,
-- 
2.43.0


