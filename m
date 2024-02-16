Return-Path: <linux-iio+bounces-2676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDCA858504
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239471C2157A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC331350C2;
	Fri, 16 Feb 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0HA+2WG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68461131722
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107778; cv=none; b=qS8Rr9xko0fe/Hk2JC2wQJHkLe1b71Vs/fCgdSPnsh47ZausDciYahAQyiBIi5MywcORkD2dKGDSh6LLxAFgUcaW/5193PsjGJnpmYj1ujVO0QIRhGgkDF3BiYT3iTFlEiJGYJSMYJursXwK7rxLUMeoIs4pbY5JUfzCjzq8DyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107778; c=relaxed/simple;
	bh=J6DpSKyhyAb1oanNc8XQkgXDE9CDbuitZYQSkenFlb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnTq6j+e5pkiDimEVRNKnseotjth15OyW+0uEjRXEy/h9hhCiTUtO2r0KUVhzGsVcuDaKeCzAl78YJWe3lwtPI+qAsJWKTx8J2JRloCjO0YtvFWcRe/01bEolulI/b/piHzG/kZytjralf7qX8xu3WMBKcHLkcjCsBCvInhnVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0HA+2WG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e10303de41so1009198b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708107776; x=1708712576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N4RIaXqYbfABYgbeygXnFczx1DtYUS9r6KVRfmYiMA=;
        b=j0HA+2WG7sgKMbzIPRSnA5NtKgRB085UL7McfGQOtbjAn3kmBQFnMJqG+kPzuUitfE
         FuykEMdN5t1hDnP9HuPfHwG5Qh6wPVch7t7KrS4UqW2OJB9CEYmzZtu5d27n1sugsS12
         EC9QTKuNwn8ZT3ZLLiETWbnG9ZtIE4d8YGCFB2Mx2gwlqh0jLosa+RxoPwbSgkuoz62a
         qEGpcIdWl17PlsOM1XCHqxPYo6W3CR491DLU7fgX5NUXbyJntj2ohtuoksKzoQIjPnwC
         msKLkPcAAr/a/Rz+pxhMTcSOCFzWBHBvePkmAiV13FUAAlp875ziHKo1LI8yy9VHezmX
         YG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107776; x=1708712576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N4RIaXqYbfABYgbeygXnFczx1DtYUS9r6KVRfmYiMA=;
        b=HTPRHwm3yJ8MuRvzZGZOSqQ/uQiMSOuc4WtTHlvpVp2zCnODciCBZBhZe1QdQO7Wim
         hshvpbo3JfOpwU96qJg/HPMfF7SCz1WeNysyGJ8Q/xJe7G2ysZQ6J0UMUtz6jpIP8E37
         mgX4BA/uf5YYAA1hnZVzPbUsspuDeHINgzudGw6RsmlClTSbea7Jw2cwY6Hn+8y96HBw
         VdF4lEyH3AFrJp+Cl1D450wRpXNY/tMkKyHbXR3TJDfnAqyLuG76+N6oZ68uOleDVfP0
         Zuqvpfh69QSQCuitZRb3VKKdzB+hzHl1UVqumgtZPuZwpxa9qUuDbolC2aQMlNDuIxiW
         zHFg==
X-Gm-Message-State: AOJu0Yznz4UvuXZnffI9WauVxLRa+OfatZGEAQjbb/WOI3jS/J0SNB2H
	FcN05AQqg3r8EBP6NltzU86t7QRod5/1qX7kCpp1VAcHxhVQcKiC
X-Google-Smtp-Source: AGHT+IF8hMd81BgRNnZkSZjz2OGVk1TqzCc4LvdYD48RO3S+Rw/PbrqSAj09CPx1KzrZKm1CtAI6ug==
X-Received: by 2002:a05:6a21:9216:b0:19e:a3d4:24be with SMTP id tl22-20020a056a21921600b0019ea3d424bemr6894320pzb.49.1708107775552;
        Fri, 16 Feb 2024 10:22:55 -0800 (PST)
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79903000000b006d99f930607sm256474pff.140.2024.02.16.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:22:55 -0800 (PST)
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
	jlobue10 <jlobue10@gmail.com>
Subject: [PATCH v6 1/2] iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver
Date: Fri, 16 Feb 2024 10:22:53 -0800
Message-ID: <20240216182253.27069-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
References: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jlobue10 <jlobue10@gmail.com>

Adds a description of the duplicate ACPI identifier issue
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


