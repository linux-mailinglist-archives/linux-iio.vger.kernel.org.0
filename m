Return-Path: <linux-iio+bounces-27491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41519CF6CEA
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 06:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0AE0301A732
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 05:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476D248F64;
	Tue,  6 Jan 2026 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPnIuCyD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A291E5B88
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767678325; cv=none; b=VReJR7JdRMPasszVzEcZFmP/tG81INz0Fb4xYYRQBRXdhWOeqxKvgTLR3W5SAOYIiq5v6xW8KM4TdL36GlrfbBQEZN0gZ0u4zXCDcUGNfbTehboJXaIoD3crKivLJ345G8N9CyNwkEy3dt+yZ8gmyEph1AUaA1nHYuLIhgo450U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767678325; c=relaxed/simple;
	bh=/SYccTC3igvd2gmgSeQ2U2RaSyPjN7ENLlBvFQ16Rlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9Aq1J4CuupsIDeS/19qk46bdL4SzK+ozuS6ZL879dh9ChlRzjF4ap/7FctFbZdletZtthbLsGq5PFiincm5+5UVP7GETPArwRQWvGSatgEz+xhm6K8KOU2W911fjkNb/JWQtgtgYgn2debc1pMazmYgAYBYv8mApO3BZaesmC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPnIuCyD; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c2dc870e194so457193a12.2
        for <linux-iio@vger.kernel.org>; Mon, 05 Jan 2026 21:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767678324; x=1768283124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4FNQCGxQx8iOKij8d4YGaJkQe2u5Bu+8scxY9YuuaQ=;
        b=nPnIuCyDmmuY2LBHP5mMDPcbSuPCwQMtg0kjTMIRH0km+/aHcsgsFno0QUBfsvexnd
         ogh9N5VpcsW1QXWkFWj6uBo3bCI5reBAFoaQe4VBsEcJJsVKKLUdyWHNPbYMj87upgaU
         ZXSMUBKEJjrlgU5DuF5CNRbo5543FZHFpMSW0AdSzoRDqdzhcAi1c8/l+hCYmz91gWCm
         DwwRysBpahm4aTfrKFj7L5OX56agqmZqx98WBtKzqraNtGfTI/AXnrRa10z94ooab2bJ
         jYs7cxUz+7LQYFD0OwZC9bfTyzy6x7hQo6ZcjTTC8USFWi27w8dSgUwakWv8Ihsc2TPU
         b7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767678324; x=1768283124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4FNQCGxQx8iOKij8d4YGaJkQe2u5Bu+8scxY9YuuaQ=;
        b=YgEIqSwhQALKwkDoiQpQdmzjnsJUQXxOjhdpzE1+rFMzUxnayWxXaRI+5LnkbVaPcR
         ehs3z8ccDO2nIS0C130ZJxPhvZSB8Aww+Y1oKdtphdgOkvJLMkPi4CTkAe1T4ZFoQ9bm
         7Ys5zhHMUfUno9WFd9zGthSkWHPNin0wyLvT+tiMn8V7qyCdWn2H5DpC2hMqDCFHe4wS
         64Mx565MNx+AUvebPDQ/WekvA+WmPH2eSpJpK5BqgBE7XGvSXCyJJP7psxgZxnEBRlcH
         KPLpUQP4HM/hlrjG2btbwro2ZXye8aNs6XWVMSnuYvf2e1v186nHHwkQZFp0FP1U/URZ
         FxwA==
X-Forwarded-Encrypted: i=1; AJvYcCXLqWW8QR8vG4igU0S4oxIX28kIp7XIaY3Jtgi6aYUKpRAMy5xdyv4q2Vz+pvTiO4/LGQdI2Zlu3Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6g/gwpoucXCA+MTSxablJeosjixQTOXlWl9tWnloqndMawso
	BoYTPCZcXLM7wdSwxt1NlN67/LrtRIlYB6q5wYWSoeKhEmGRhem69yAu
X-Gm-Gg: AY/fxX5rwMmey9hu6ee6uz/6F35RYf2WskCYl5nAMo0k0CoAidrWLgUjx15oNQohPkg
	aP5qz6r69ZWItOy2ZZ+tNev9qZowt8uBSe8t2AD8yGda2syV+pDCvvleUKDrJRNqSpruqIhJsF9
	7UB/E3ILHpr4MB97+Fwv4j/kq6ow7ziMNPRSWtIOWZGlChzu/O1chqGCkc1wJV5xCT6/2BsklyD
	bfjz+zH9YTuQR52/b+Eg5O+VYjNTpc5PK4Qs+pn3cX1VmjmVxKuxNG6dJpgx7MEpFAfvFaGz5rP
	tLKUi7okxNCQ4ZhiKBzBbCxJJzq4ulWI1HqsFdXf8770sZhOmXNIcqnU46Bk40uID9oa+YmdLbn
	DA7Z55Itodoz4NBmbM7te4cjsUdsHXIRSEsWmf3g7j/rWrMsoo0dx9apmgv93RBC3YR5HLeFW+E
	rTqoUsODDTyS4YUcahqSizG9PZ9dp+N1XYIhThfhpJo5Ef+atS82lwpn3r/+H6jTU=
X-Google-Smtp-Source: AGHT+IGtbGQnHPVMy7yv8FIzmXgtNyoU2JtGqSy/ckCA0YX5D21h89Cmom/fmR2hFZZF5RRFL7RB/Q==
X-Received: by 2002:a05:7301:1807:b0:2b0:5a77:5753 with SMTP id 5a478bee46e88-2b16f8eccb5mr1490668eec.21.1767678323618;
        Mon, 05 Jan 2026 21:45:23 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17052dbc7sm1805817eec.0.2026.01.05.21.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 21:45:23 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: [PATCH] iio: bmi270_i2c: Add MODULE_DEVICE_TABLE for BMI260/270
Date: Tue,  6 Jan 2026 05:45:19 +0000
Message-ID: <20260106054519.566796-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently BMI260 & BMI270 devices do not automatically load this
driver. To fix this, add missing MODULE_DEVICE_TABLE for the i2c,
acpi, and of device tables so the driver will load when the hardware
is detected.

Tested on my OneXPlayer F1 Pro.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index b909a421ad01..b92da4e0776f 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -37,6 +37,7 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
 
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
@@ -45,12 +46,14 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
 	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);
 
 static const struct of_device_id bmi270_of_match[] = {
 	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, bmi270_of_match);
 
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
-- 
2.51.2


