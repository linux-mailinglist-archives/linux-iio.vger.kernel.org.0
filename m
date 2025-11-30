Return-Path: <linux-iio+bounces-26569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE998C951A9
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D705C34327D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07C2836B1;
	Sun, 30 Nov 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6EqpFZH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31F28312D
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764517070; cv=none; b=DOJnf2VVzQxeHm6qoakTmEoGteLL+bP2zPnxAQWDVAnvoGgAoZ4PfNcapfEgcHZcP+H9d4DcD4cCmKM7p84hQ0XVR6VX+y80KB1dngRoVZYYYRWoDwMubentimNgGVPaVdCKKc/IyKf7IYHb65WfsoYwRDZM4is2FyiGUY5Locs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764517070; c=relaxed/simple;
	bh=AX1CU1q+bUAGz1ETtyCefywPLZYHzcKUg8LhXgYui1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nwawk7arKlrhkr6+IVSR1dsijXbU+Nke+P3FGCxRZOBDoplaL7+M9TrLIMOVV4QkJ69RcwMvPtGvYYn1Jv/THeLs70SLU3qr0ERgluNwtr58JD6sVS1JELWlreGbWeKpRxpeJm5Bii96I/9G3rCnpKtPKjZ90ZA23Rdfdu08C3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6EqpFZH; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34374febdefso3590653a91.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764517068; x=1765121868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1Yi/l4JWa+A3tuznHjjnHeDVucB9XhUBFEkwMdmi14=;
        b=R6EqpFZHTv/EXyYbIVKvrmyFyPBqWz6gF0w9m5W087HuA+L7AsxK7AKRyyVqEE/O3c
         9BTApSBarQ75/WNdGmNrORNdggN5XtcpASwDXnHdFj6tw2Y7eUA8p3tBdOuxIWbDcrbL
         0340QEOY/IaGM5iVZcyPwEL2HKBTpF5S22eoYc7Q6HBjcGqEDPx00j5FIpJWDBx14mOt
         T4I0b4+z5k2EUNBEpjegLUJay8WIG1MIBCpDIHky7YRmfdk9lEYWjDsY5W3sROllAeCt
         1uerw/56QePngOcRWQvbJS0XwgcP34qmtP6wsG51elh4Oi6JJJyFjNlLGkHbxGACHvgo
         M5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764517068; x=1765121868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1Yi/l4JWa+A3tuznHjjnHeDVucB9XhUBFEkwMdmi14=;
        b=jeYh/zVbkbcULjZ3xr5EdE+j8eGcyY/NXj7i/lqVL8jqcJdfMsicGRKi1e41sjaG4L
         qWW7DQfV1jiOIos4DyLDtxRR3X5E5WV6mFrClEN5jmiEoDS0PNO+llkovZmgp0LEKVcZ
         GfqIzBoJwrvsM2Cr820qVmy8ikWMZ7XgWWKZwtesmOPGqkUKH6mJ/Jj8EB6NvmW8+56T
         ugeVEgOo6t/CXR+SK4IuOKhMd5CaXCrfqE5gGvYyNGur9eYHboLW17sGx0G2kiWRJ1+o
         NOmdGPo1kbbPNnSHUrFX6Z5GrAhN9JjNNt6xdTd+bmFq4WeFh4vD/qSRifY39kVQh9sj
         girA==
X-Forwarded-Encrypted: i=1; AJvYcCX5JzwW7iLlYYa8NsGWg0hTrXVgH5VGcZwCsJd4JMbuhx/u5GimF6hobJSdxtnNTFvUhzYWmoTLGvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpzJSwt0UxfCnwjWCiXfpfnar4PJgvzNhZpTy/OUvLpQ0gViwy
	BZxkHv4vpkasiGfszAyNH2UBj7fVsI82tvYP8Fz6Cnon1JQTkVP2JlE6
X-Gm-Gg: ASbGncscTBfc0tdihOaxOOJblj8H3+EBWC+JBEGfjRE44mXgziwSsWBnDRowT7KQaSE
	fNkeCmoYcyJ+4lXjtZwswekhFLFuBrRjq9PsKvny6xdBj1KYJJ7RRoHZqaMSGPbqdFS5GK9bTTr
	RKLDbPlHjFCbC9A3JwJoyg++th82lg/h+vIb2CXEIfh0DYob9HibR03lWApmtOPrLDKSzvs9JWr
	9/sSECGADw1dL6AenB2SzdhC/cI+/EPsjtuHc7mR01I/e9Q/2PQ+8Eb8RpgYPQF+8YJpIPmIrkP
	SOXlyi+aYGlThhGpbmhdatPgIJlL2uC0PDgzw9PflY+8PIb8ezdc2YSdCFVcXEqA6+np4jFkX94
	079h9dqa3JpuTyBawDd/GrqaLfJwtqQeMchzRo/vHA4flbL/mwlp0MANG7bG1e8gHal24khlVeN
	MJmuy6wF7VbO/C7Q==
X-Google-Smtp-Source: AGHT+IGI2aWKgKbrFOAmCrFAEqHIE/QQlzwFebvNvp3ijs1nc2xFa49i272QNSLnWhDDmYJZdeEQsg==
X-Received: by 2002:a17:90b:3c48:b0:340:48f2:5e2d with SMTP id 98e67ed59e1d1-34733e7194bmr34028299a91.9.1764517067912;
        Sun, 30 Nov 2025 07:37:47 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm6903483a91.1.2025.11.30.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:37:47 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v2 2/4] iio: proximity: rfd77402: Add Device Tree support
Date: Sun, 30 Nov 2025 21:07:10 +0530
Message-ID: <20251130153712.6792-3-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130153712.6792-1-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables seamless integration of the RFD77402 ToF sensor
on platforms that use Device Tree for hardware description.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Changelog:
Changes since v1:
- Add period at the end of commit message.

Link to v1:https://lore.kernel.org/all/20251126031440.30065-3-raskar.shree97@gmail.com/
---
 drivers/iio/proximity/rfd77402.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index aff60a3c1a6f..3262af6f6882 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -313,10 +313,17 @@ static const struct i2c_device_id rfd77402_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rfd77402_id);
 
+static const struct of_device_id rfd77402_of_match[] = {
+	{ .compatible = "rfdigital,rfd77402" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rfd77402_of_match);
+
 static struct i2c_driver rfd77402_driver = {
 	.driver = {
 		.name   = RFD77402_DRV_NAME,
 		.pm     = pm_sleep_ptr(&rfd77402_pm_ops),
+		.of_match_table = rfd77402_of_match,
 	},
 	.probe = rfd77402_probe,
 	.id_table = rfd77402_id,
-- 
2.43.0


