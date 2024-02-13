Return-Path: <linux-iio+bounces-2531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89439853EDC
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 23:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A200B224C7
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834E62170;
	Tue, 13 Feb 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN3M2L5T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B612E59
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863890; cv=none; b=SSBNsPUgx5YHT1Oq+Og6Ut0VEqGsXmbQr78N6zJDCdohtV2uzZzQWkrx8YPvVRoT4tNjS/R5FIt+tvxz8kfw/No3g/420Kj2UZgGAVHBY2FPmibjLzDUAcqx/Iotzs1xZluG8gOwrRzVh0nfXJEcqYVvjKoPfcqg2mFbY74Wdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863890; c=relaxed/simple;
	bh=Dsiuz5icodVl6xKY5gwPVQp8iKnoKnQZ4xWfO6wTemE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7bGyDZzxuwGIEG8WNH2W2TWp7mFVHFppJtdLkXzbjqsp77je9aa4F/bEcKFcfncl0GnN+ykJUhxM8N530u2ZqgoQmTIxVlQUcq7eWfTpKtE+GzYjVRQS1C2Cs+0Jb3Vh+pps0lDbbLvCU53+CzLI2UNt2B0Lur2LN4+73qnUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN3M2L5T; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0f4e3bc59so1155160b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 14:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707863888; x=1708468688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Tb8hbgzc7+sgIfE3A2skDmmlCQ1F78dniPsQdC5hKg=;
        b=HN3M2L5T0+2ifjeemCQJzZujWAHjgJ15hoL9q/Uc6fjlj60fbfGlB3pOZsKxtbz7/m
         tP7yMou4E7VlsybNuBv0U8iYx0bjcfzckRvLXl+lAhX8isFk364gz2zCUbNtKd63MDF9
         elIViIeFiosUjm9XPBoRGnNVDdgXM9ZmUFFEEzXClueNP08GArCm5Of1DV2BoRmFGZUe
         bI0zbdiq1sx+GbL68946IjrRzHj+vO8Ugt4pWNjwFq2dJYGpgwhbjhemCSkRxwB2eBVa
         LErnYUo0TG8WngG/XADYqle2PlhvoP2J8PJunO+ujhMm1VgyUwoeGzBOD9RV6rpvNgQ+
         neCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863888; x=1708468688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Tb8hbgzc7+sgIfE3A2skDmmlCQ1F78dniPsQdC5hKg=;
        b=WIzGK+M3vc6zjibS9zQCuK1IfjNIyXUEMrVJOJgAQFEXjBO5djRh39lO8Blokd8+p7
         aLMfJI21b7WlARVjBfPVzi53/HtLJMqQGOIzsKop+fSEsGSPe6fEWYRKTc8DpFI/uX9Q
         i7Wqog0jsh1xfyIQGxnzPgjn+XQ5q9wKr3RxRXDiE5Mles72AZCWt/7I1nw/aEYOThrn
         1CHhZCJcFM2o1wus4KoFtvAYBFDJ0KvSK/RJ9FugSuZ6lEcfNbRh8n92BNeLQGlMmehr
         ZweWBTHJa6Y8RzAqT+GTuA0ftPlsZADny03k1ZIJHWyh+Eg6A7I/W+oJybSjt9Im083w
         8+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXVFQrMfH34NhM+7LTam8peYGgglYAO/JWKZo8hTBjYRQ7GmbWrxUrX4BQdZKWuDKb8pbPcmTPwx/2UOoUBXepq8OCZntKk+/A1
X-Gm-Message-State: AOJu0YzB5gvVR/UzXGUuC53iyJOlhq49cb/LdbtO8Xfl8FHAjgvLcFAl
	H/cA2zNU8U0bB94kIRFEKPZiAEPnn6U1LFeb0QZzEzNOxLQ2H0mM
X-Google-Smtp-Source: AGHT+IEDDhIyg85FINtXSHwTpA/FXm3Q2V91554k5tHKw13lzFnWqn2p8HDL+BIA8zPl+VT1PVCLNA==
X-Received: by 2002:a05:6a20:958f:b0:19e:b196:ddb7 with SMTP id iu15-20020a056a20958f00b0019eb196ddb7mr1035947pzb.15.1707863887972;
        Tue, 13 Feb 2024 14:38:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOjOSEzuhZ2qAyMvoceyUdzGX38rTpEEhq/hudx8L2PrlRf+urgVZTtYnj8ylPMzaJeXxNshiEoJ+LFMx7vmpp+tRM1dpc6Al80n7cT4kruX/Y0bVlK7q01Qv+Y5In4ll+5GOUyGhHy//c92/TBD0D2RAnoyZlz2yIKmfgSU5ht4jAoDRoRl55K7/8HAJM6afsqedCSHxNHQq8PdwO9CZgEqR2e7EpEL20xusuneTHRWOUp3TbjPMxe5J2HuDM6m/aURaWz4/Tq5R9j4YEZsr+MBRgm+252i7H+I91PFFJR5YXO1du18MMyRqsETZZyBEPXrcm8ChM1iWg7+duF8c=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b006dde0724247sm8157447pfn.149.2024.02.13.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:38:07 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: andy.shevchenko@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jic23@kernel.org,
	jagathjog1996@gmail.com,
	luke@ljones.dev,
	benato.denis96@gmail.com,
	linux-iio@vger.kernel.org,
	lkml@antheas.dev,
	derekjohn.clark@gmail.com,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v2 1/2] iio: accel: bmc150: Duplicate ACPI entries
Date: Tue, 13 Feb 2024 14:38:06 -0800
Message-ID: <20240213223806.27056-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a description of the duplicate ACPI identifier issue
between devices using bmc150 and bmi323.

Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---

Comment describing the duplicate ACPI identifier issue has been added
before the "BOSC0200" entry here.

 drivers/iio/accel/bmc150-accel-i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index ee1ba134ad42..c831642a0e3d 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -13,6 +13,18 @@
 
 #include "bmc150-accel.h"
 
+/*
+ * The "BOSC0200" ACPI identifier used here in the bmc150 driver is not
+ * unique to devices using bmc150. The same "BOSC0200" identifier is found
+ * in the ACPI tables of the ASUS ROG ALLY and Ayaneo AIR Plus which both
+ * use a Bosch BMI323 chip. This creates a conflict with duplicate ACPI
+ * identifiers which multiple drivers want to use. Fortunately, when the
+ * bmc150 driver starts to load on the ASUS ROG ALLY, the chip id check
+ * portion fails (correctly) and a dmesg output similar to this:
+ * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
+ * This allows the bmi323 driver to take over for ASUS ROG ALLY.
+ */
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
 	{"BOSC0200"},
-- 
2.43.0


