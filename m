Return-Path: <linux-iio+bounces-5682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92E8D8433
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 15:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3504D1F22206
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDD12EBCE;
	Mon,  3 Jun 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkl8LqJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347312DDAE;
	Mon,  3 Jun 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422066; cv=none; b=VCjlDR0Q51ig4Bfy8pieOyhHeE+kzcSw1ThH4r6JzujZbH9mNp2EgK51vSyVa+8qo6LKh+N+yHi1AiSHP9mRVia3axsR7qGzXlKyupdYPXN7zqIOeZl/YYaFRshqstxIKzJxFOzzqkF7LDrUOgZ3cGIQtl7ZilkwR+0mygmfeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422066; c=relaxed/simple;
	bh=r5pwoduVxbJX4Ywc5rdi0LpioEmEMdP+bmmKp5Fr1CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkvbieZgYRRUMM0Z2eb78pE08b07KR74GgfxgOxm8VeiTvxQCBKV1Rl29xCI4C210YgPT4CZA8vuKRtVGFG4n3u6cji0RfNQJCwOORH5s6cWKTqw45fMeJhfpgpap5apo/xFjI49kAT7IXRTHka3K5giMtkZpwaLYl1NycCfcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkl8LqJi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dca73095aso3629300f8f.0;
        Mon, 03 Jun 2024 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717422063; x=1718026863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nksobxv4wDiGzDjs9z1NAwTrGKR9f/JDq3ZaL9PNEKw=;
        b=hkl8LqJiH/FDXe4qunKwzwYjR6O7lNxLeyHqhSSqDML/2yEUR++luiYsz1X9TCQM56
         jtZi2Ov5XKN3FTlImGIl/HV6lBWf8JPtW8dNRY7q8OLOwhlIIE1CYYlg7SM3IhatGfsE
         382fvr4gZ/vu1SU3Vm3/dqb5jvt2/oDDM0CwgzsAjOIeSEY0IYbh00MNAoO54eaAFEQD
         U6jWIb+mjy5rd8wH3g2Vp+AsoyU3kD/YZg0vdq9KhvMLV2en41NKPGra2SnzH7sSz4h4
         KjcKhQv5U4Q2gFSRv6/EZg6pNFjva+9LD0lvfVjCOWJeixXq1hcsjcCSNh3bf40jVBDQ
         i6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422063; x=1718026863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nksobxv4wDiGzDjs9z1NAwTrGKR9f/JDq3ZaL9PNEKw=;
        b=WsCtgDyZMPCigN7sbi5k64k6I96BPzula1Ljsv+gRLl2evgUEmR2aSvKMwCeDfpxeh
         SNSQ0JRTf0B4LJTnAP7pTT8IxMLZQa5MuMH3IW2LC/hyGUknmN0i9T8mRdr6ZdC2fgl0
         ac5mqprUO4GflRNCgueQCrg97hxq47/Zlso6mhXEJ4i2C1lEJJ4mMwfKMS2uEYpzjnUm
         xJzxtLOtZo4a2Qsp/wTlMPKTAkKK5fikVQcJvUYJi+iLVzxXABBNOFB9CqXoaCEgElwe
         4z76NwgVpZnK+1C4mVqw2hn/EyOu3/2fUIeyWb90X3w9H6BHFuHjhzPFAZkLIrkK7y+v
         CI0w==
X-Forwarded-Encrypted: i=1; AJvYcCXMT8x3nG4ijTMbn0Dy/FQ71YlYkLy7nOfgXvpMpZcOpYNcmIkG4xgqvzi7I5xd1boSc+8Y2EK1A52f6u8P1RSBABvLQUMLBKmibENSM9okZZIbAGgxWaChyW9M8t1nmWmuHW3Ew6yaB5os1Qu3DVpfgC/31EjT45OI9yI1tyIdpDGcWg==
X-Gm-Message-State: AOJu0YymySMyS1+hT/0pnNCH4E4cKaeg01/gHL5vdvW/Na68mYv5b7rC
	fYdup0yUXs6iSS0CBAnucsBiTaio9LEPuGT8dPJcY2hGfruS52dU
X-Google-Smtp-Source: AGHT+IF0VMa8sCOW1Xdd+cQOW+CCAJRSpmGwhO221NJKn9VSaj/y8ESRMClIsFwMsvbT8BXo2TGKlg==
X-Received: by 2002:adf:ef0c:0:b0:357:8fe9:4d6c with SMTP id ffacd0b85a97d-35e0f30dfb1mr6555108f8f.49.1717422062952;
        Mon, 03 Jun 2024 06:41:02 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5e3d1902sm1868361f8f.32.2024.06.03.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:41:02 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: ivan.orlov0322@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
Date: Mon,  3 Jun 2024 14:40:15 +0100
Message-ID: <20240603134015.70388-3-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603134015.70388-1-muditsharma.info@gmail.com>
References: <20240603134015.70388-1-muditsharma.info@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for ROHM BH1745 colour sensor driver.

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..945873321fef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19407,6 +19407,13 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
 
+ROHM BH1745 COLOUR SENSOR
+M:	Mudit Sharma <muditsharma.info@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
+F:	drivers/iio/light/bh1745.c
+
 ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.43.0


