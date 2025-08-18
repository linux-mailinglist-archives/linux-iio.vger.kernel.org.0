Return-Path: <linux-iio+bounces-22913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CDB29DD0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 11:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CA718A7751
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E630E0DD;
	Mon, 18 Aug 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwem7bhe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0530E0C6;
	Mon, 18 Aug 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509274; cv=none; b=myDWBxjnvevx9mfwkhNUxmlxmx1bX9P48iB3A7pxpMi+PPB+Z6thtMrVZkos/2/VXKkWH0HgBEgekBOic3H9C0hXQTJ2hNk9sncHv5Wd9bg0My1a+B0eSHxrJFuC5NMYqidWhHVHlr1xkgcJAf65TPKBRC2Lg13UX7FL3VVqeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509274; c=relaxed/simple;
	bh=q56W13AzKwbzEaeRaqr+B/VLzp9SOOb/l9+s+3Cmh7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gef1ztlr8g6syg8h6VycueSFNnsvZqpG099iuT9Erq2iPUdMzzzJXK5bmp0LttpK5TZshfJDEBRGOkG9cK8rkwiFSZSgk736JA8XqMP87UmW4Em/z7bFrk4xQMCi1NjTAh4cAYLuvP6DEf7Ft2QkoxDQCLoGpZ1+dEE175gL5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hwem7bhe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3bea24519c0so397052f8f.1;
        Mon, 18 Aug 2025 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509271; x=1756114071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S09Gsmq9Jw/lkHidEm9OsH6PCjryp6nuR1hhv0ESMqc=;
        b=Hwem7bheSVpm/WYEjzls7v8G5PqY3SUCdgjCzpddDwxwiFKCAhz9r1pYcz0KUARDMJ
         +RK/QXHHFHdmFcYH5wmGyURSw33axaV30AqpRJzVeMMQ+enJDXp1hIxCYYUijBQwQ7Lo
         EXNxzahTUge0AilpMjnR9ftwaPSFTWPdboMtoYrp1dBoxXQKOtpHJvh4vqGr5DZdI237
         ITlEdNuSbH0DMhuuXdScncALSq0/ag4R329pyiGZ3aQ+gSBIiwmSORLj3DSuoTm+FY2+
         bEWFsJOPuLWs7lczXULolR369dRkfZF6Q71/IKAo9kxhaMmjBEy5yfEXvFZhsCf3cP7z
         Eoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509271; x=1756114071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S09Gsmq9Jw/lkHidEm9OsH6PCjryp6nuR1hhv0ESMqc=;
        b=dTdqwgiWh6NBcsuzM6XnGSWqqpy1qv9b+TajoBzgpOnghBpMBAVAPUnUN0FwPayes2
         WcJLgEEkntyk+qemqP2/Q4TBi2zdy8a+ny65AoGtd/tFuEqccafsDpe2Yi1Ty8YUaSBS
         RPII0ar7MJyn2Uszz1ZpNDVQJ+tCUOjv8y0bT6g580AZ68c/ueX9I1HO/7gckfZFJNYE
         6YZJOpht5MxMj/pObWDR9ukpc/LzFL0IWo74UdhA5xUc2bKB63crvyZ2WFGeHD4DS4Zs
         qAJwPbRVsv4xDpCtOt0ZiyyT/RwtTN5y9m6Xs+X079uH4IzdzugLZJjDwyNSzB9Mat8A
         KIXA==
X-Forwarded-Encrypted: i=1; AJvYcCXjLpUe4upIwzTPSl/JuLuiJXx9so0acx/B8nZO7q8yDDeoYf71iB8jktN0+L98X8JKPFuz21WVIOGv4Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqGq0bB6VUWbS2ZtVARb9BahzVqHZmEhE/kRb6n9OPDn21mOL
	bloDZlp0RankAhu0DgMdepBJuB3rzSPaLNu8FjXRm/7BMnh/OrElaRkthfVH0A==
X-Gm-Gg: ASbGncst8bUXAINJrGSH9Uyl2ON4zYjkG8w/+hSCVb4lqMWrssKBfQ4k2RAHI1gfWG2
	yx9BlWbpfFh22/nzwS18EzRP2yZ58uGEUjIFAwe5xiM8vu9cRj6cGmDPeWy6yyy/4/zeie1oXsH
	iX3ilH3leiqTqSkAUa6gRAtXvpspHI3w9Jkv7+O1r6JcdzTgsuJ8VNjfyMxgul3XCWeDD8ne+XL
	KyNAWBKRT2cU2iufBpSKdALdRRxNfyDg8BTK0R1AqNAfAwEX2sw/hbYdhqfaau7cw6ULFxo1Q7a
	DZ5lDEvQSfZ1077NvmkqnwnQowqFaPTMmaHJXMO11q6hoppsjBn/mWDGfwvN3YO+Q3GjMBLwN8p
	z4iiFaU8mfqoqu9LS31Ctn2HDIHb81KoPJjY=
X-Google-Smtp-Source: AGHT+IH9Au51WU7Y/5/gek/B2EngbAb/RFQJMWEQgSfqcK9Ee2+OR/As0c46J2k2Eg/Mx05RHHMW9Q==
X-Received: by 2002:a05:6000:2b0f:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3bd13d66ca9mr3794596f8f.0.1755509270328;
        Mon, 18 Aug 2025 02:27:50 -0700 (PDT)
Received: from localhost.localdomain ([165.51.41.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be10esm173793365e9.3.2025.08.18.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:27:49 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v4 1/3] iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
Date: Mon, 18 Aug 2025 10:27:30 +0100
Message-ID: <20250818092740.545379-2-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818092740.545379-1-salah.triki@gmail.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
Check its return value using `IS_ERR()` and propagate the error if
necessary.

Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optional")
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..6cdc8ed53520 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3213,11 +3213,12 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0


