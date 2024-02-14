Return-Path: <linux-iio+bounces-2570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5EE855658
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B235F1C21D1D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F12562F;
	Wed, 14 Feb 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e782+vpg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319F182DF
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951107; cv=none; b=ofyAAdXYr1+ow6Za35Uwq/UJBduRQsyBKwyTzJd+CuRqlSM/i319aZbYmbMZalFvxIW/zttmH4PJrGm9dfFQNJQIcOAthZBCAdi0O2Wc+6hINQPYvXTMWvHNWcc6j5i8A8PymUg/JhaBJ1+7uF+aecnptp5JLRwF3bLtj8j4tho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951107; c=relaxed/simple;
	bh=IS3+qlxe4uPc2lqIXTZy/usQ2+IBHgxYfJ+fyzH9UvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ5kqZoDSslrBlg+S4nNl/78nBnogkd8PC0iUckwSHl80a5GBzZv+fCU7CUMa++75mCuMhr0Lsjne4i+tSB40iBl0g79tDaoA8VCXG6FgUoQ8fZCKn2OC1pbdTjPCZGvB3r8KVPN4jHGmxqFTcd6+5DtIm9KKMdq4wru1TY2Uig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e782+vpg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de3141f041so274530b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951105; x=1708555905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEMAaM83LUC0sjGc8EGMOJzmcRT1v8y51nxxG0jahfI=;
        b=e782+vpgEpnGhZlNuF4bwyBwR7TCRKlWo8Rp0LKPS1rh3QZaoshS9jQbUKxdfC9C7Y
         vjDR+mpd3ErQYkXx+y5fl7MTPqek97rwmX8byjWm4gJmnB6wN0xgHaUfPm5qNz92Df4r
         d44u4bOn6h2Pkeseh/qfiu7gtMj6RYV6fUZjyTmierUZ5C5VnQ52Gb1ptnmxLpcj0bT2
         nGv1ew0xqVPjJb4RqIcHTt1k9SJHz/BV2TMy8mkBs9f02gm+PrXvMdUE1kEFSzEW8Pq+
         XOgn5/QQSrpS/MDVvFr7XUssDOd3q+fqL0psSh28eTI9NQsxkT3KuhT17e6Oc15ZtwG+
         XxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951105; x=1708555905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEMAaM83LUC0sjGc8EGMOJzmcRT1v8y51nxxG0jahfI=;
        b=p5Ddu/oEVJAhTz3pc207BDcZkcoDoHpeExwng2btCRMN8B56FcL5VBKMRWg3/ZUmWt
         IhLl2LorBSulz5/9BCqyQbzqXE3AnnjVIWEUfP3ffd7IKXEXm+/0decXx2amr/PPDwhd
         DrxKwtPSfwzI50+Pyzbw4I+7ErePI3YEp7xBE9LNS2gVjlSjS38ZcYpGIw8wMqlG0N+D
         uD/qIyrKbMbTHwNXp3g07XAVJDABZ1kmq9imGdEWf2BQpFBu+HGigmY+7QJBkd//xCM1
         onTweYtTzHUJLjiUdeWB2xKF1xQsujyY2cC/tI/zxmThgItNqecBB+zWpZynWUiExDLH
         kN6A==
X-Gm-Message-State: AOJu0YwFSHy/wqRfmqQ/OUImtnTdW8RUw8DKG6fN5UlbdAz0HecgxuN6
	LOpKpcaldKHnwzyCfEl1L+haumGG4/SJmekZOkvJffPkyTTySP8J
X-Google-Smtp-Source: AGHT+IH+n0Yew77ZKwsu0vYmaLmr+HaHVGM/T95QhCxAvoO614dU8v9Cki2xCeNSFPl1SQtoX3/PEA==
X-Received: by 2002:a05:6a20:d04b:b0:19e:a527:96be with SMTP id hv11-20020a056a20d04b00b0019ea52796bemr205399pzb.43.1707951105332;
        Wed, 14 Feb 2024 14:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9+fI5SDIvmxKycJrSh0opwnoxKKIQ9hTCiWqak9aAwtG/fSsolgPirqQBUupqWPaICSKrjGZhQ1qNC2FzUk4I3E8myAiCcR/l4VpIfyOwLSIbnGG4rqawgDFcd3pSuQCrAcS0YyHicGDvR8cwvx24EXRUpYF3K83HLCkOyIalER5ccjhO5u2+6JvISH1ishpSSNIEyVZcLlYdMBWln/UNYARYhc6rTmCapcpAuak6DloxdRMERV08bKuOvvsvOCv3ojYN851qr5nbaHU48VSLSaTXTvGzijacNGAzB7HhY5ODdTbV6FGzQ9Oq0W0t24+HuvaiBnk3JmOtloJCGip6Nxo=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006e0416c42c3sm9746813pfv.198.2024.02.14.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:51:45 -0800 (PST)
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
Subject: [PATCH v3 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Wed, 14 Feb 2024 14:51:43 -0800
Message-ID: <20240214225143.24897-1-jlobue10@gmail.com>
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


