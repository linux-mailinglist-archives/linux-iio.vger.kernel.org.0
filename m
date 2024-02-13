Return-Path: <linux-iio+bounces-2500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCCA852788
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC26D1F22B55
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 02:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B817FE;
	Tue, 13 Feb 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Js3MrV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDBA3D
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792001; cv=none; b=BhhK80J8eFBgsnGILyc/zl44BYWk8NaR3sXU7ZOMW5VUEJZalvZtT0NqcRYaUFNdsw4ZcRIan9NnFRYgmvqzz5EXWnIRwJNyP9KqZqS069jp0V/HyH+ZKa02OnAZrpk0MgieHqPNDHJKCH32VkuJz+idlzusndOqzcjAsM5ZmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792001; c=relaxed/simple;
	bh=1/9mRKN7nDEMpzhkcA1onT2tTdeNZD3mQQVYJ0iDzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWduu8x/aQ1lBhl+dNxGaL7+Rv3Ryjj+3WKGdqRhsUVrZJ5EEWsXUi1cawiCSfg2cF0rVx1leVr6vuwvchb6LCmZZnn6aJv4sS5/AjkQ43T0LxUKgPQhYHaHXfpsc0qbKABMEb3engTefr1za88cBXgM8cZMWNtvruxw1Tn+clA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3Js3MrV; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3641d386931so275215ab.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 18:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707791998; x=1708396798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdgoKcLg131t3cj4XDK7Dn3MDQTo2bt5SmERvnOHQ7g=;
        b=h3Js3MrVQz9m1gv5HAsO+5PgTytUiKtbj6A9Ry5MdPqF7NDXbc7WtGEsRwNCyGdPE8
         4ERpLAI51sDfBhV+Q8KYFFZqmvB9mj+9XaJxbx8j6OA+Hd//AK6gsIfd7oHMS4qnqExv
         NXCdHbYU2cmzj8PmjczBbxrJXyGkza5dAbdy75RDyEwU7xh1tqs++iEifkxuFSaUck8j
         5oTq79kw/QYehhBCi+rSBsgzA2xfXViUq1qd3zlXoKBtBf1akYctLxlRTuDqBnMI5CAT
         68wdmHpZHnoLn6Io8koYLEPBzYM7CYOs4VBYooLVankpaM7Jc11Mp0tQovJ7L1mELCdo
         kxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707791998; x=1708396798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdgoKcLg131t3cj4XDK7Dn3MDQTo2bt5SmERvnOHQ7g=;
        b=jsY7m6a+pLYB8obbdWzXguMNL6vCS5Z+2kLanInPmfFrJt+cnWOdO+CVqM1a/jESq/
         xBBKrFw1YpLnQdObzuNlPB2Cv+muwvpW+LeDUtvTzc18hIoQJcvarkboSvr621zxMctm
         cvJqMHW7KBSOvUarVrgaOT+R3UBxpL+TOT/Zl8xU25SlO+w9NzBkTImUIB6fVfExB1/c
         3e1INE22bChrFc6uuZ9znEZZf0qCj0aoNbKN7E5K1LEzG4TgkOSwiMFj8JhoXvLFULVm
         lzJ92z+sUK3tCIxz9jIsI5FtXXQ+oaK9jn0DTfGpVncmgLuzyQkiab1AerLd20wCE78+
         VscQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/6cEbkl0dvgG251tIaXk5PEpoN6b9GT1W8KR+B+PeWxfQW5ZguiFybWp8ogkXllZ0bldGouqyDo5VkwjOwFXCVs01HKWQWfzr
X-Gm-Message-State: AOJu0YxMkFVa7CPkRLRhsL3Y22r31jxzQuuUxnLn12rWhiA1C/rMvaPu
	NvixCV4WOzbW9+4xcRd5iTjMB91qeb1gyxNDnEv/gVhAIfcTi45R
X-Google-Smtp-Source: AGHT+IG3jXJ1kN2JOGkZ1HAPWK5nOHZy487fp91rfEUTGu5zSxdPzPnYg7Zqlk4qyfQoaNQPtYKRlw==
X-Received: by 2002:a05:6e02:f51:b0:363:c305:1032 with SMTP id y17-20020a056e020f5100b00363c3051032mr9627128ilj.19.1707791998237;
        Mon, 12 Feb 2024 18:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp4a0lVD25Kthps3C07PD+MxC8RdNF3+rGFtvB3IjXDiXbGnBrlubPUyY2p9NaDJIj7aaE4k8CLD48jbYmz/ZeeoaQpHwKmF6aJ6U2WsTrhMRFJz05QnLtrc3mXYrsHzmlBCqa/eQdBFoDhM/8APs61+VkSTwJIrUyz7XxnAF8g+AeMkhYls4uy0/s87FRaM+AREjcNAEh0V/LYqnk/dN7wpA2nczTw2doOcHG0EYrWZxjZPiQzKGvH54qYsSX5c1odwnRspOs+1piKllecKGmgcUja70M1P3D5e19SM5GcQZNS86+5I6E94Sus7a9atE+HF8MfEN6mnUoLQ1Az5M=
Received: from nobara-ALLY-pc.. (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id t32-20020a632260000000b005cfc1015befsm1137411pgm.89.2024.02.12.18.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 18:39:57 -0800 (PST)
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
Subject: [PATCH v1] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Mon, 12 Feb 2024 18:39:56 -0800
Message-ID: <20240213023956.46646-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
References: <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
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
 drivers/iio/imu/bmi323/bmi323_i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 20a8001b9956..fd1c109bf75c 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -93,6 +93,12 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
 	return bmi323_core_probe(dev);
 }
 
+static const struct acpi_device_id bmi323_acpi_match[] = {
+	{ "BOSC0200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
+
 static const struct i2c_device_id bmi323_i2c_ids[] = {
 	{ "bmi323" },
 	{ }
@@ -109,6 +115,7 @@ static struct i2c_driver bmi323_i2c_driver = {
 	.driver = {
 		.name = "bmi323",
 		.of_match_table = bmi323_of_i2c_match,
+		.acpi_match_table = bmi323_acpi_match,
 	},
 	.probe = bmi323_i2c_probe,
 	.id_table = bmi323_i2c_ids,
-- 
2.43.0


