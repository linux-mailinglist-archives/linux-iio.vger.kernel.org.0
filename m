Return-Path: <linux-iio+bounces-2572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163158556C3
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 00:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E74282566
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5013DBA7;
	Wed, 14 Feb 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS3JqDOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E1145320
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951601; cv=none; b=Dfh8Bp00Gb7NfkKdTVSpIAaVjqla9cGkJz/b9vVBD3agkRbAMblJlVFVAB6x2mZTyj5XH2b5N2lOUAZWEQni7eoNpDttTCrnsPlm0HNj72Hjy5ObymPKrJ+YXI2ywI23WHc30Gyg6TkUWb86G+FbYMXmrpf1YuwoyGEO0YAeDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951601; c=relaxed/simple;
	bh=VUUL9In/CI4csuFEb9kVTLWOzrr9nvutskddPYtM4f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYcRrSf35r7nTOFKhAXYvxi3vjlFNHzYali2wI+97dIj8NuQBQsGaiy71drbH1Vur1nDIamvbD6wLIvXU5h/0Vh5qXKgFqnl97XhSynDNFJvIPTnDX4K3tG3px0fK1FXZg7BD7qE57xodB/SLmiG9OZ6g6u2q0rZv7255AS/dyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS3JqDOp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d934c8f8f7so2239975ad.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951599; x=1708556399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ94JKcj/fG3uAGk4k/IvOkASyPkXZOEw6gl1KTiQg8=;
        b=dS3JqDOpD3XnfcSR5UrjojpdvzM44CkEPKM8bil638wr4kTZmo3jHprLDMRwflCPSO
         ZmcbTKsnrBhzbolswJ33nV1qBxGz3jKRrZQdh/vUhc2bRmeDK98b8nGEbczuApQ0A9xX
         1BZIBsgyCNX1k+k1Gzo877a4jhVFr1PeH7jOkAARehbgTadXLWTcj28f7iiLrpbsiK1D
         /daWB3FH59wi1Bg/2zm1JtkYOAwPlyFMfRrAOyhnwJ62ElvMO+cgp8iSHLSwVeGADqIB
         B6p2dIozaNTolbw22ytiBZNRNgpTVRhlTBhmGpw0B1QX8TiRq1otUhlm2CM/vYDwj1RH
         0SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951599; x=1708556399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ94JKcj/fG3uAGk4k/IvOkASyPkXZOEw6gl1KTiQg8=;
        b=QPSSlauosbSaP/px6dRSBzC0w4iDfwRN6Qy/AkrhlGSE3LU5l+aWZqbrfFtB7H/Wyq
         7iJyJoLlewvj0gYldXWuNWso1xQjxXRP9lCi+DgyuCCtO4fMIhpltMJj6vfh4MZMBd22
         flgk4Hw/aoWF3pmTbtS5IVyoaghLyp1Ruk4RaTWpiurhZp7bJopbCD9PdMRdzFPiqQTH
         KXKnBH+3U7JsUvZX7xqzHRmKXCsOOtljy6kf3qrgyMs1UnargZmoUg9tkHRKa3rGDd8I
         wVmf3uReM40U8rGspFLUR89ek9gfS0datYfUtB/KgNZydaQs+XVP3Vc1q+/Ot2eWGCGS
         Cx+Q==
X-Gm-Message-State: AOJu0Yw5ITWC4WRn5N2ses29WVvykIfEnFHPvGFXrYK5ui+0nig7SFRV
	8gdkniuBrCz1gBpDcIrJ2PySo5y/eCAtibfkee6uZr9iQAhwYqIG
X-Google-Smtp-Source: AGHT+IGAh1ihS0CNbGu/QY1Evvm3HZF1fKRY+M1FaqI3Z/UhOOtW+bse752fnpMr/4wzCOk4IqShtw==
X-Received: by 2002:a17:902:c3d1:b0:1db:71b1:7529 with SMTP id j17-20020a170902c3d100b001db71b17529mr59501plj.26.1707951598524;
        Wed, 14 Feb 2024 14:59:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZe8foO1+E2q0CoOEFZ3aVMHTYPsgSLGcOiZR2huXzRGMiDv8fqqd6HA2q4eyKveH7QKN8lkBKrcVvq44goC1YvTimimMrt+yE77I5ShUs8aRecIqo7NgIFx8Dlu0o6vhgsOLTe5EbfodYKUfhaKUc8SGlULwlu9mE1I/+e81ielUXQyf/S3N0J4zgrOFj4ZdmFAHxIwOKYKUMvfTQYg/+9ogLG37AApXa9ZbDCeQxWeaM3I7OsjgFXMM8oCvJdDSweE6BEnaDIRXe8fPhRHlWqiuGcJ1rthrb2I7QZJl9qjLcAeczTcDf6ZbG3WDM3AZx44830yIT2prwsQajJ2rRd6U=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902c70100b001db3a0c52basm3288512plp.92.2024.02.14.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:59:58 -0800 (PST)
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
Subject: [PATCH v4 1/2] iio: accel: bmc150: Duplicate ACPI entries
Date: Wed, 14 Feb 2024 14:59:56 -0800
Message-ID: <20240214225956.25731-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4563303.LvFx2qVVIh@nobara-ally-pc>
References: <4563303.LvFx2qVVIh@nobara-ally-pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a description of the duplicate ACPI identifier issue
between devices using bmc150 and bmi323.

With the remarks below,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index ee1ba134ad42..df7d48a35e41 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -15,6 +15,19 @@
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
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
 	{"DUAL250E"},
 	{ }
-- 
2.43.0


