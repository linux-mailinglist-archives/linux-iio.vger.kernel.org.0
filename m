Return-Path: <linux-iio+bounces-2569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF9B855657
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 23:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2877A1C21D1D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC56250F6;
	Wed, 14 Feb 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcPPMzV3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D9182DF
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951092; cv=none; b=kzOS+VvhSa/mKa5FG3xNqkclD7xcss5gNnxeFGhxShfUCtGnUPTXAM8zatLaG2OKFbY1zn8/Or7nVtdFERit2zuFQDPFsHTwegIPMeS6/fXoAcpCMXeHRQ4eh8B8TdCFM4GOSrWh2+xiI84QJCUM3XC7Jv0DWgaGGCvmj/OM/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951092; c=relaxed/simple;
	bh=U8F/cEGScujGdUgbhcbv45B0Y+jPI2cQQuNu1XlOB1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYYM4uUzgRdL8z1IPLE52CXFqL6lQNcbdpvTkDBVzo+1z9HmuvZVYf5eaBiE5BJ3Ri1pjfqdknXGAVbw75wF4cGwf922kBZMk9fh6+At/WsLEZAZC1MfsjhBcfDZ1AUZLpVwiPSNT4j6HJ4WIXifCFHobuL7MSrROBNvL+QFy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcPPMzV3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so316355b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 14:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951090; x=1708555890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNNBbNsdpzwbWpXydt84SSkuS3RMC8N/4yGVrfR4cTc=;
        b=dcPPMzV3VOjf5j/eLKBPhC4qR6caYbTaiN25K4+qwxSPj6+Ln+yG6Sawf+rEdYuoZ4
         PfWvD87EQD/ra5Ep4nM5dI4qjEvOoE06/bjQnRxo9nf/HI/Ai3vwgW+pEkBsfe9fhwnn
         KRchfP7tXljcydUOzfIEn/0jb5qlMo5IoRGg18Sie3RNDGl0v1fxH+HPQ+3HAbmVXCdf
         6v/Oo53QYkZZoqmZdEn8MvlNFNzUlX6Yan/VWG409vyE2XRY+ci9T0IMwOYfCKgNV1iJ
         OBqerkLsBr/mu0eWy+syzuVjvUhnK81G+SQ+y4hkZD2ypnwUr7kzkfo5kU9rwbCLH5dt
         JGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951090; x=1708555890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNNBbNsdpzwbWpXydt84SSkuS3RMC8N/4yGVrfR4cTc=;
        b=F0vfeBsIJsRjrqX11QiJzxTfIZQnND9LwrWAvys3NsYOkh+X16WF7gaMXe3j/gntrF
         T7EuBoLx+wT1Wo2loUK7qYNl0YfwLb9Mz1fUSpeVo4UiXH8DoaQZjG+7uXJbfnLXz3ZH
         AzKtzHJchmPB+V8TmXbV9hW2UdbhXTgB+loafqyzEtTze1xwL9wAKv2ypHBm5Sr45+C5
         Dz3LldeaQAQsgZ9ZxW3D/c6SKqtMT0Afg3BFquFwfUp2i4hDEh+oIzK2avZTGaPXTTKe
         nkzGkGCwfRbAVJmFJXo3Sayf75t0Lzt4/d9xe0Oul+w2+p1ZnkxbF0Z7rMORpStK3e2s
         zTxQ==
X-Gm-Message-State: AOJu0YxfG5zXPdd21FVquu37SuUQKI4mCY4HNqPLgN1Nh4KOqT2OZviz
	Pyhs0BIffJFpymHk9MswRqFpSNQntLZCB4S2ToqTj59FT+woko9Y
X-Google-Smtp-Source: AGHT+IE/Ui91fxXV9EsTZgBrmI8xrtCX4M7MhAKpd3/SNYJ90GzjbqpWAmcGuoknz+1mFsJTsQjv/w==
X-Received: by 2002:aa7:8ecd:0:b0:6e0:9ec6:71e9 with SMTP id b13-20020aa78ecd000000b006e09ec671e9mr233213pfr.13.1707951089982;
        Wed, 14 Feb 2024 14:51:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3iM8ykLg0KQQdy0HnSaO8TvEpeDbjDGbI6YbLHBVrOY/CUWiUS9tcXcpcmHIuaKAM2HiD8c0SmneM3mxZ47I+DYZhyZQ52180FfF9zV4v0udzvcbud5Jwpl4F1sEGGiWd+LRteUf8Qhj6DtyMDItljU9uIJT+F+gG/nkLe9OllVivkPUO4cyEVFB5Hl+GpntQWDnhZ1kDAL15ONsBvb9Qyt7JOBVKXq5GFHWP4XPfXdDh7CmclDinnq6eF/+BGRt8CQ4YhnbsnvlvpGlq1gh8nLWEJr0polBx7ZJZvJat4+Ah8eBoIJaMop3dG7RPdgnpObgWWOK9qHOTKx/ePsICYC4=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm10188742pfv.176.2024.02.14.14.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:51:29 -0800 (PST)
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
Subject: [PATCH v3 1/2] iio: accel: bmc150: Duplicate ACPI entries
Date: Wed, 14 Feb 2024 14:51:28 -0800
Message-ID: <20240214225128.24850-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <12397335.O9o76ZdvQC@nobara-ally-pc>
References: <12397335.O9o76ZdvQC@nobara-ally-pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jlobue10 <jlobue10@gmail.com>

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


