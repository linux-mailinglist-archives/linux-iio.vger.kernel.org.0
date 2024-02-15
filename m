Return-Path: <linux-iio+bounces-2590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999D856C65
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD864B25662
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3561384BE;
	Thu, 15 Feb 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLMpze1L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97781386C2
	for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021470; cv=none; b=N6pkorldnF/1VOAObe8HE2iJeedo2v5JzkDLfpxBmnEzVRMWB3oQ5M8fLLlApUF1sWAYZUeF/MNUnucFf2gNRY0uqmeFuwxoCjxDWkM2eyS1U77iPDfbxN5wqxl/AiTHRPIyBa6BCFtLfcTzkpEcH1UQanSWYLMEC3gRKlitgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021470; c=relaxed/simple;
	bh=p73M/rAGulVwL+o2lMvd/JAtZJDsylg9a6qh29KK04I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJCS8dXV6SLNlLsJxarMYWFxc1t/UaFJbFXo3enJEVdF+9DDfMmNNT4mXsoyPZd1uJNnnVBpWW4ELSQhNpgoTVrgReaH4xzt1XOao/3RDXA3FYAHsZa2c2yETCJqY5j9ijFU/I+DlKmTCPaRrN664TZ+gbg0xhkiAasP8KUvke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLMpze1L; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e104a8e3f7so1002027b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708021468; x=1708626268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRfJXFg01a5FHH7xHJtlNAKbWEsjLQIsFqNu1Iu0wPo=;
        b=eLMpze1LLdSPe8qU9H8oUaU80uTWQ8J578lRgOX7ZlvNxZvy+Y2Lovw4y/rP9Tz7zK
         GZMOZyeHZfo68rrYMTxdACGviqER+mxNTdiwDbeBgfUZyDulCTdH70CV89ql2Vi4POXc
         RWXUIQkus+EtluRwZTo9dOFENfjI9ccR09/thdnsa+aEGC2RMQSigonlpAnmoiPE1t2Y
         OGhy6F6rgKbLPfOrJNrmBkr82+P9JDEbi0PE2mVuwhhq6HBwHM7PkMUf9uMTlRlv5rIM
         ZneLCT5H9YvL4Gp4CU9Fn9FurwlWqLwA0qYPhqMBLS3zizy3/B1CtUurBZlFueJo643g
         J2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021468; x=1708626268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRfJXFg01a5FHH7xHJtlNAKbWEsjLQIsFqNu1Iu0wPo=;
        b=H6ycGuIuEMEHKjDPH+0nEkPVvI/k0DnA+hBUFZWk+TXIpHkXw7yRNNq5E6jhK3l7cG
         ggu7s3o7RDb+WTSdF17MdjwgDel3Gdul9554KdGxsK59msKuiHi9jZ2kt6BIlS/95kxQ
         sV8oCiZtyO2hsNaDRBMDdP112Fdkj+fMu6GieTApfCTlLxc2+wW88Cs0jy1BKz4agVlK
         ZgYy6aG1GkeiSagioSQIad/l3Bg1tw+EyhgLYxxhdzGxFjEhIhJ2SxOte/B+iYk0I08C
         VJlEAwglH+k3vKim4U+BND13h1Sl1SdjOnO6h1u6Sn0k43R2SLClrLK95Tgf59HndWDM
         js3g==
X-Gm-Message-State: AOJu0YxY2dXbVzlY3JYcnzYkqz8+yDU3CIydye2pAui9wmkoLVSoIRZq
	5JNu4/aJGW9cuxvcKAoKIL6xTOovXVIHYT7ozu0Pu2S2aZjLHy2X
X-Google-Smtp-Source: AGHT+IFac5UWuFm86HHwYmIfT2R5qGYdGeamMSjyQRpaiK+VUAu6JcP3YSqx9/qYIvR9VlQGTgjJmA==
X-Received: by 2002:a05:6a20:e68e:b0:1a0:7c0b:6426 with SMTP id mz14-20020a056a20e68e00b001a07c0b6426mr2341165pzb.14.1708021467965;
        Thu, 15 Feb 2024 10:24:27 -0800 (PST)
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b005dca1412f37sm1539189pgq.51.2024.02.15.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:24:26 -0800 (PST)
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
Subject: [PATCH v5 1/2] iio: accel: bmc150: Duplicate ACPI entries
Date: Thu, 15 Feb 2024 10:24:25 -0800
Message-ID: <20240215182425.57334-1-jlobue10@gmail.com>
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

This patch adds a description of the duplicate ACPI identifier issue
between devices using bmc150 and bmi323.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index ee1ba134ad42..353271e23235 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -224,6 +224,19 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMA250E"},
 	{"BMC150A"},
 	{"BMI055A"},
+	/*
+ 	 * The "BOSC0200" identifier used here is not unique to devices using
+ 	 * bmc150. The same "BOSC0200" identifier is found in the ACPI tables of
+ 	 * the ASUS ROG ALLY and Ayaneo AIR Plus which both use a Bosch BMI323
+ 	 * chip. This creates a conflict with duplicate ACPI identifiers which
+ 	 * multiple drivers want to use. Fortunately, when the bmc150 driver
+ 	 * starts to load on the ASUS ROG ALLY, the chip ID check portion fails
+ 	 * (correctly) because the chip IDs received (via i2c) are unique between
+ 	 * bmc150 and bmi323 and a dmesg output similar to this:
+ 	 * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
+ 	 * This allows the bmi323 driver to take over for ASUS ROG ALLY, and
+ 	 * other devices using the bmi323 chip.
+ 	 */
 	{"BOSC0200"},
 	{"BSBA0150"},
 	{"DUAL250E"},
-- 
2.43.0


