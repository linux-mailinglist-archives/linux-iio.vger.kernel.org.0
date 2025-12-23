Return-Path: <linux-iio+bounces-27326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F31CD7EC7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 03:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D72830351D8
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 02:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A654287265;
	Tue, 23 Dec 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="yGgzIu4R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5512BE7BA
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458534; cv=none; b=Xp1QoLtnvQJ/G4bCv8PoLoaZzaUxBbOFX8wx7N95WLj54ytt0j52wxNl3/03afMX0g+wGf7fnVcVhifiWbmFmGJANUOWRpy0vOHPXQea6Skho5CV+/hw1fa2xVJpW/N4WqwUamg+QxjxKSiHlwTCn8zhUPbPxVpL0JDwmnlQGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458534; c=relaxed/simple;
	bh=ku3ZBVETifjeQ0o3DDEB1EmddF0OrNMWr7Ng1VwkBe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVTnxvUX8a7VKWXkToNTLwtUDtvFmxz3XpO2gtKAePRSYD3qUz84qj4psrRzjekX3qVsmB4uxzoVYjXzv0qJiJEdXAsFPTlL6gl1dfubhL42DVfdA7RP0DYd3wjs/9VmH8fy0tr6DRCa/GXoDzJlOFWKjbX5zXENNKoJ+x4W/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=yGgzIu4R; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8be92e393f8so452605585a.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1766458531; x=1767063331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZosNXC7a/oy6bIWG7fweMBXN4zVwQCtuYGLBNLI7q8=;
        b=yGgzIu4ROT9alF55yJUoDGOaeH+5t05REtxg7gXRyLErH5cqYO+vk8li4M0vbBrDk/
         pCZJhIOsIMAB6QVOpIvmsAytFstttq00H1lKqH7tWpAbAOgNX+xI5BqDrXf0InTv0XpW
         HxN+W6Nyf4n3NXzs4vCRYsQBm+5Bu2MId4n6CgkjaoExbjwa+k7CZna3O5+qsGxMYNJh
         /yUbu+L2NFeJz6RtEBfDfIkXhpJw7AIKnBvwoMWgZyzK9JSEi8RjSgTGSkeDSEeYTdeK
         eaVHxIrxKDXP1iZO/MLhYMEcxTz8MD2lh3Yv6EPyKDYf3UgaTGxRpRuhtHHcbyw6xo+2
         CntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766458531; x=1767063331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZosNXC7a/oy6bIWG7fweMBXN4zVwQCtuYGLBNLI7q8=;
        b=ANpdJiOjcVPH39RTRXsaHfoy7CVQtpw0HkvmjbxmT/uuppsabyuKMfZ4xX0mr3PpQv
         BvP1BzGMo35fPzZPVbUfdl6HR97Xp51vL+XOcisJIqUNyEDGBQsU9zKJNR5Hqgpdd7ij
         RPxvoYWc7pLY5ERP3XrmZpMssj3JLVQ+gzRKgnMC3cSKuu0FOsht+27fAeMVlo80Gyjm
         C1AZoMU4CzNIvY2bKT5nDfprpmjOWNiaugvZl6omsr2b8aLUZqeh8jJkZNFvd//bmmlr
         +tz/lEl5LLKq/jvcEfYliAS7thEmq0SkqGW72py3KoWxYu/OkksKZqTkFoMf+X/OM2dt
         Tq6g==
X-Forwarded-Encrypted: i=1; AJvYcCXvLdOmj3kZ4clez6rL9neeZ5s/fhLWoCkqvEYVRu52okV5R8ODLivbdu64oIIFf9hyXUrpntt/eNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBra76HiAHSx/gIXws8Wi3i3FPlUIFB7d1MlDLe2aUkW32Hg2
	MIxtk/VQ9igxuV+j7tGiswzgvaumTFzgG9CX74ymcjg/atfu2ued8BrScxbdtOQbMfBOUCMPiiu
	5XBs=
X-Gm-Gg: AY/fxX5rLe8g2+Zek1a1rTJPAGxtTObb4jMzQXVkBkyXh84ZDMApl3zIMf56DsRkKUA
	rbCyKrrIr+cOY+pLK2LfXhQ6hSIl4fVYlwkw6G9UKRUr8EdBxP6t564DKv1bXTDRZziIE47WJro
	FJk27nfyFVERYgUKwn8SPh/ATEn4Is7z+qm1kyCL11sWl5lGe+06zGGQlJrdgs7o8dh4qTEvzgP
	nmGlB+PYYbdzlzm0yX+YXvNTkaAdo4BI0I9HHNogYGwEaTdSl5g6zQLxX/fOlZImEL8MmmiB5jl
	1JNt3KOUV9sJsuySx4TuBGVe8eCGv/nrln6kieyiIH2TC7i6EGb01uk0g//mnB3J8OvXTsMS38S
	ROSZzKkvzgEzZ+vUFIcrWwT7SWPEAJ+/b8flWfUtQdEWU7IgyWq4sYLa4ART61kcfcCUP47g/18
	RcbcTzQ9O7v03uxw1kKOC168BVX5fep812O8jd8X2PuScqMW0LPiMR4289nUsRqkBifQ==
X-Google-Smtp-Source: AGHT+IFIjN3KCfF6HxWnQFgXimOgjIxHu+87lh3Uzmv992YLlYYkIgYyg7HuuB+Jt0EGAMWtlnPKOw==
X-Received: by 2002:a05:620a:2685:b0:8a2:bff5:40e3 with SMTP id af79cd13be357-8c0906f7484mr2008264085a.38.1766458530683;
        Mon, 22 Dec 2025 18:55:30 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f8572sm952775585a.25.2025.12.22.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 18:55:30 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for LSM6DS3TR-C
Date: Mon, 22 Dec 2025 21:53:50 -0500
Message-ID: <20251223025351.3099978-3-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223025351.3099978-2-samuel@dionne-riel.com>
References: <20251223025351.3099978-2-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same device (LSM6DS3TR-C), different integration with the firmware.

The integration differs in that the firmware provides the SLA0 and SLG0
mounting matrices. They are assumed to be Accelerometer and Gyroscope.

Observations were made against the Windows driver, version
`12/06/2023,1.0.4.3`. This driver supports both identifiers, but expose
the device in different ways.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 7c933218036b8..86a9ed648aa24 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -144,6 +144,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
 	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
+	{ "SMOCF05", ST_LSM6DS3TRC_ID, },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.51.0


