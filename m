Return-Path: <linux-iio+bounces-2532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A306F853EE5
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 23:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507D428CC48
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D476216F;
	Tue, 13 Feb 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0LhgxAE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B863103
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863954; cv=none; b=dqCu/BULTDkuP2b2WT29zoiHtkXsMRECzGC1Bb7tuGBA+I25mlhxflqAiUXJErTPBjCSS23WJAovflhyuNddo0/LHFaeKRW7fgYVc0PCr687kewcfypBatWq8UB82tn9B0gLAPWidmzg84+QV84v8jvQZEB5l0QwpJRNGzzPg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863954; c=relaxed/simple;
	bh=LebxrJekshlMEY6NJcOMmUOgeW/2SA+yS+xd2vqm1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnF7jnRpxnyOmYxIkm0/omkTUqWPKULy1kaTlRbDB1g0S0mur6NMjAkWm3Qv25LmEYxq/CPZ5yv0kastrxQd1Oh8zY/spX8NBTu7u8U7RDQCoOKWN53ji+w1HGVgpgfGrCWgoldzfK1rQOrA5DStEA9VJHRBSLVp+TXrbIXH7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0LhgxAE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-296db7e258dso164500a91.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707863952; x=1708468752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhBzhYoVBDe5LE1qL7GDpC5VBCSK0vmouV5CeZA8sk0=;
        b=O0LhgxAEj/KbsHB80m3JDeFB0NDPictnW7HL3b1GbWvfRjO8gOhz+07Jhgs1sz736n
         JLtXllj0kAWXmqGCoroau0j0KTdNEnA38QE8WeiULMlT41534LANbNiKYscvAS2tifx+
         SoWIjDJ3JvAsOqW9oW8NJjgF/ig198ZLIRbG8QQgB2p1GnSw350JeJVo8isvBFZFCAZa
         WGVW0Q9se7ugROsL2JwfSNvm/FxhAlhoQkRkUyg/ArZEKy11knS3P7+810JkK0kN8/f+
         ZJwB8RYCvPkPiORZIjrS+Roz6kjEUd1Hv+iAHEx3TrOGeu9OLzsvPgIaIXVu3p8hBvqp
         hiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863952; x=1708468752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhBzhYoVBDe5LE1qL7GDpC5VBCSK0vmouV5CeZA8sk0=;
        b=AMmlMbxu727SQoNT9h2+5tUpqk49ONrYBFv0eljdH7dZAYWBeV4Vy2o65+KT9MAnvB
         VIpoe/S9rqwD/Ju9W60idRKaPul26cSvlAhEvGlDLBS+aTdbWsvnpVCMbg4l/iuQHiJr
         R3UIoyhijjO9tY+o43XD3d8iMa+1g1GYT6+kubYW88g5w0yM4glr4wDwxotFfj56/EB+
         7IE8sQnSHuiBIem6i7gvsMyxLHEjxpSNwOJdfkUiWFaA/vwsmvlRYZeILAzY1cg2jrvs
         eNvSzari9+CMeN+ocOqRZFbwrM14vZWP2ECVvYiz06pusmEk0rJ04eUlSelBv6ZhaDq6
         6Xjg==
X-Forwarded-Encrypted: i=1; AJvYcCV9x31zi+0SxvoYe6+Vl3Y5gYNRqDXLgoqAEFeAJ0ZZluhkqchTks/KdFnpk6rGJncAgdvQ6PyHGNKcEUtPS+6SHhCfeg03Mkph
X-Gm-Message-State: AOJu0YwjcKqLvKFaMoFPGhHaDq03hjGR/Si06yo276yCnvD/kpYOQ1nH
	o771PXYmQucOjPDLbAdX+1fUGu15Ow0uTOQ8q1bi0jSxXJeE/NuJ
X-Google-Smtp-Source: AGHT+IHYkVzx5L2ZDclufirqLHJyPLmSjIKe38pVM1eACkc+Cnt9WO9ol6qobWDSFzDBibzbCka8hg==
X-Received: by 2002:a17:90a:9f88:b0:298:ae3d:eb8c with SMTP id o8-20020a17090a9f8800b00298ae3deb8cmr257557pjp.22.1707863952469;
        Tue, 13 Feb 2024 14:39:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMfc/I3Ow8Y5gb2KE9vVdE7o0R40OMu7dbVC/hk5eFxQDy/AggesfMpRp9GIhFFalfQFkds3QyynwJRbEnDjn6jmLB4UMT8N2QG0t6yV0Cu90qtPAHyQNgaHQR3t0JBUaRXAk2lxf70lkE8UKn+gO4n5DsgQUgjk2XvKONhTRL36ErmlVBJV6P/gK6eK7URB5wYGxFduYTAY5mUfbMifbRxdEQjmj1NaHxSbpafrPzqXmycHMdv0LBZ3HR344P26MfhwpEcGIcrpCmKY4igoRwtBcrDrqrrfw1g1oQFripXQf4g56MrnoYROpm3IWJsHKd2nwPkuOlsn5PFMp8GzU=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id d59-20020a17090a6f4100b0029711b8ac89sm38956pjk.32.2024.02.13.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:39:12 -0800 (PST)
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
Subject: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Tue, 13 Feb 2024 14:39:10 -0800
Message-ID: <20240213223910.27127-1-jlobue10@gmail.com>
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

This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
driver with an ACPI match of "BOSC0200".

Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---

Formatting fixes, removed duplicate header, and removed ACPI_PTR
from previous submission.

Added an explanation of the duplicate ACPI identifier issue between
devices using bmc150 and bmi323.

 drivers/iio/imu/bmi323/bmi323_i2c.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 20a8001b9956..22826a2efc6f 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -93,6 +93,25 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
 	return bmi323_core_probe(dev);
 }
 
+/*
+ * The "BOSC0200" ACPI identifier used here in the bmi323 driver is not
+ * unique to bmi323 devices. The same "BOSC0200" identifier is found in
+ * devices using the bmc150 chip. This creates a conflict with duplicate
+ * ACPI identifiers which multiple drivers want to use. If a non-bmi323
+ * device starts to load with this "BOSC0200" ACPI match here, then the
+ * chip id check portion should fail and the driver should relinquish the
+ * device. If and when a different driver (such as bmc150) starts to load
+ * with the "BOSC0200" ACPI match, a short reset should ensure that the
+ * device is not in a bad state during that driver initialization. This
+ * device reset does occur in both the bmi323 and bmc150 init sequences.
+ */
+
+static const struct acpi_device_id bmi323_acpi_match[] = {
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


