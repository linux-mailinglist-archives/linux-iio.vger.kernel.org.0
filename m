Return-Path: <linux-iio+bounces-2573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E48556C4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 00:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94A328B233
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F331272C4;
	Wed, 14 Feb 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4aRkfvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6132E629
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951611; cv=none; b=W24KyHHOWFXwii+5J5/hbqWU+Oj6EQ4yuNoie4uI0qRuKxQy6o93wiErpuqkavpT0g4xdeVAimVtSkdzJKmv70Cu/7ZmKMtByjDmi6Ik+Igf34tHUOnTHVYDnVk8JFJ0Gw0Q0RiKC9OLQgh689QLJ3AsMsnN1OGut9VbW3i6SPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951611; c=relaxed/simple;
	bh=6ReM03kV7SPo2S8I1gsXB/Vl3x5Mamr5dCDs+Jrk3Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8gDijuu4RrDICFrhyhdr+FJ/c1+3Y1NiyTiOP9YtkXSbOF64CrVDkgV11WBIsJED2L8fxndKMl03jC7pWJ6lsy6nmeGEZu+neJE/a05FWZWfZRJvViEYYWmm2uucPd4dNfFklI4DY+IK5GSUV2+1p9LEUNO15/rmohTVjz5qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4aRkfvz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso264727a12.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951609; x=1708556409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ql+bMzk9UKDsdADQw3Zw2Q3nyHq+/pJr6sAV6qveYE=;
        b=d4aRkfvzGDHr92MywITSiJrIVwLp3LnIESqpubx99tUJNYTVSgh8gGZEqa+I8lrGDe
         +8osTZnSDVKchqZKF6vOJQ00t9xYom+aGH8vMx9cusuoJBp+jWgdQnR1JwWuOK3ytnTo
         5tl9BBUPzmwrd9O9oTUf9xSjVYS3I6Ph5FIC/T3cBuH96epp7PEqMrgkH+XJcdljggfO
         IAAQv9hExehaG+eopdm2xabq7G4Kov6BKGOLhhJccJiM/UKBlm1s2YH5I+NDyA6m4dVp
         xNtmbYEaaN7IAAEP/CEEgGfdgF8kKdqZDLL0Uto3hcVAcyrOhhx3NL6tzyfYXAm1L/23
         Ngxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951609; x=1708556409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ql+bMzk9UKDsdADQw3Zw2Q3nyHq+/pJr6sAV6qveYE=;
        b=aKLoqPA4dGWFCKvjR2O7HWJfL/6xppMEe0K95NUPYFTlRATW5v+mhqausI7NTO/qo+
         kktbBfEl6BKHIVPd+zMEQnK0thwEcB9Z6DHG2bhq480M5/14jCQoJ2LzvNQ54MSuquB7
         qMiBogpZjtinxgVWqTXikGtacpkyG7zePFz17WUFFMt+WtuqNY+vVniIvJAMwYmUKVL6
         /aZD1y7N56QolX6OxBbOqBJ/j1JY6hhOst1DYXJkAgd9ufxA+LIhV8gpy3aWjde506/9
         DPWNdjG0S9RRuGJjDlHy0aCBxHoowPW4KPR/a9dVIbQonx/MqAPThxFUjrnDeNgS5IiM
         9lqA==
X-Gm-Message-State: AOJu0YwVSK+ViCc931hVy2P8reweEbRaBbkuukszSPUB1es4U+F2BbIC
	FpuQuc62UHuKcYOwFwGGT1jVhOdDY7e8Sm6LNHGiKbuTH1Q8kvJ5
X-Google-Smtp-Source: AGHT+IGi/2hqozoCEAhwATKgfa0vg2fnfB+xvSmW19RTSx/h6JfQdR+rzGmsREURrnaXYLPGZyfN9Q==
X-Received: by 2002:a05:6a20:ce48:b0:1a0:726a:6e44 with SMTP id id8-20020a056a20ce4800b001a0726a6e44mr286831pzb.3.1707951608303;
        Wed, 14 Feb 2024 15:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3S/4g+2Q1nK1F0zHhIgohLFsD1oSkfuF7weBj6U9TnmjX8sI/OtOY+/GHOngPlBGHE/iq4kjLFWJAdxbIMIr7bjO7P0dbj3oQV+YQ1RhACh1mL6NzI3gPfzGI7Gkr/aKbTjKSGRmP9mQxx4ONkTNBEa+MWUeQKYzem5UOFc+kYcV3wycZ9GtKwnIYZXAzlzvCHQ6U/6+SNZo4+eKfWw2WAlArbfh8TfYpnvW0OChzQFrD2pY9D+iwh/eKNlwIisfRj/4UcjHci4e9RQCPfDmAIXJNUC0ZNR/bnMzdHv6BNKOlm3PetO5jIsvwst2CqHOiOQcfhcDGQNCbVZ6cCwm0oR0=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b006e0515dc44dsm10105984pff.178.2024.02.14.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:00:08 -0800 (PST)
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
Subject: [PATCH v4 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Wed, 14 Feb 2024 15:00:06 -0800
Message-ID: <20240214230006.25744-1-jlobue10@gmail.com>
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

This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
driver with an ACPI match of "BOSC0200", and a comment about duplicate
ACPI identifiers between devices using the bmc150 and bmi323 chips.

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


