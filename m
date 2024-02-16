Return-Path: <linux-iio+bounces-2677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0E858505
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321031F2296C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A21350C8;
	Fri, 16 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjZQ8BJn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB45131722
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107793; cv=none; b=EyBK8Ieh0ZIy4TfeC/2bIN5L2A6LlbISQnGiU9yjVlnyG+sa0143gzg9i3ALO6XyEaveB8MkWio+qeDmsM7mocnIHkv9uaHutNVv6jLhbsGOm1CenHSg61groM/thGWyomKaqvll/DULdn63NbxBTwLdLB/hRbMBumq1BiEeJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107793; c=relaxed/simple;
	bh=qPD7R+rpHySs5juxUqYlTCF9XnSnSJFK6pmd0zIBTZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSDcNBaOme1DanCkI/iB1HYKMMKtZpt2OGOWe5Quk0GAQfzF9gh9PxUbAU9/W0uxOZcBMJ6cv4IgCebGFjS4pePGjOp1ra9CzXCWl1GHFPk5oq/ez+1qsIGQeRNn5XuUPj3e0Btq9v2fCnnZhVG40K3zuBq5NWWzl1i4sZij6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjZQ8BJn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e13b1ee5ffso678830b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708107790; x=1708712590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG4j7rR9Aizz5phV+GYL4uBdrfY2Aid8a2KPItf/7LI=;
        b=NjZQ8BJnC17FfWXPcYzD3dhafi/4L3wVye6TEKpu8IfhFOxcFAsi6cE1Loz3dVRT6Q
         dMe0Mzc0eH6StyHpR61gZrxxwF8kModdP+kE5JIC1rucwALV+NJFL3Ve87zf80wfUEBv
         Xtp805WsHgsjdH/TKz2d4BinBpJisdh/JquHXe1TASjFgVqatfF+2RSNjArsPTMnA+Pn
         m87mUdzkmeDVm/bbNi4fqfq5ST+wpIpAaDtSllYesAcxC6CgEMXL8Dqj9lQRq+DF36q/
         PdQMZwXhMcW5dkly6/FMhu5Q37I3NVrDUPkxSdsdYG54TuSEpPnqAESsvwBLQXN98Gvc
         AO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107790; x=1708712590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG4j7rR9Aizz5phV+GYL4uBdrfY2Aid8a2KPItf/7LI=;
        b=YFAd/UYppaK8YyjKMHMXHGy7ZJZe4W+s5LszPaFmVxPHu9+ZEeWR3m+4wRq49YKNZz
         GBmnun63QMncfvLH5iBZjHKe5Ewp0xHkM+9uB1tll/MylQ1kf8WPbcAbqKAJF9Aco21p
         GpkRZzMkWbpPnkSqL8ZxyFsDn5E/ygMb9RKQZHxgnIc8uzN8jZb/PcVJ99T9roReeF6H
         jKpkJ/CmXx+I+j91pvsylwDYRT9GeuYVdDwcH3OSLkp1Off4RMxKW97k91X7Rc2P20QI
         NegssFiZQIJZE90nIZCPoRuC+MrLHjzR7nbcaEp/VYvbBU9obal9HV+x1iol42dVnboX
         X2GQ==
X-Gm-Message-State: AOJu0YwiyvEDKJi26Cu6Rb7v5JcLtk9RtbXnvuOewRN2zxra4bRyT2NL
	LCI2v6aw5p/OxlbB+j7UU4/fb5kTjFJmpJmt6Jfw3fwW7J/1gxvz
X-Google-Smtp-Source: AGHT+IHVADb61GuhVKpV9XlUisIyP0o5zRcyF0s9LSn4G8pLjgmHnGNMMVVeEv4F6mLVymWHmdVFMw==
X-Received: by 2002:a05:6a00:1ca3:b0:6e0:f975:e920 with SMTP id y35-20020a056a001ca300b006e0f975e920mr6603774pfw.22.1708107790180;
        Fri, 16 Feb 2024 10:23:10 -0800 (PST)
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b006e091ae4036sm258549pfb.194.2024.02.16.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:23:09 -0800 (PST)
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
Subject: [PATCH v6 2/2] iio: imu: bmi323: Add ACPI Match Table
Date: Fri, 16 Feb 2024 10:23:08 -0800
Message-ID: <20240216182308.27125-1-jlobue10@gmail.com>
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

Adds the ACPI match table for ASUS ROG ALLY to load the bmi323
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


