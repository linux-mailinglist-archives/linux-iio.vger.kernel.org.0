Return-Path: <linux-iio+bounces-20622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94181AD9BB5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB8B3BBA88
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349762BD5A8;
	Sat, 14 Jun 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SNrJi/Wn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE62BCF47
	for <linux-iio@vger.kernel.org>; Sat, 14 Jun 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749892526; cv=none; b=Mo02OB5FHt78pq3i5Y+EqP2TdlO78yT+GRg4uW+ENnzDjorsVefLXHFTeQPtOKiBVfx88ITI88VQT/u5xpwdJ8hRZMRpbQ9YBTkCCc32Q0pJcNeBjGJ2v2pwryeyE9uWUAU8nvwTx47lpDKUe3uXuitp2u7Vayiun5s1cdVib8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749892526; c=relaxed/simple;
	bh=jPCY05kPPAmWwowBzuxbBJeUM9t50mKfzkwLsJbwfJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBtFxdmY4cGhjOqOjblINJyaXQwtxe8/c5OCr3YznRMJLyszEz1oP7Zn17qLMZi6V5w/qkOvrqicL7lA2av7nefyWAuVMvDMu0LTB1XJeY8SiIYx+LpoyI309KUQviDgHxQQ5nDcX/MpX4um713QEBHs64UvJ933/WoiZzrYemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SNrJi/Wn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7489dfb7248so301558b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Jun 2025 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749892524; x=1750497324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYRTvvdIGzq7CdBFFP9ONngkQPMZn1HDEsVvSCMMDNY=;
        b=SNrJi/WnQg7K1Djx6EcEsT2Wl1cz6k4Ov6aWUPlMF99DmSvOhXtyKcaKypV6tRGQEB
         6r4/bSRDxjczmu0ueQNWMf7zAV9nRCFyeJcPo/e7aD19ZUskl5o01FYlM19OesgEQAi8
         jjAGbgUB/zj6NloiMUy4aobtD1VDieu/WW5OTn1nsvazSfWYGXEevC/QRhoE2WMU+j9e
         d9kw8kts9G3wuPr4WoBsy3HCSrs81G0ebQfb1vcGnxBwyFhhpmOf8l0CghyhDfqeQ9/p
         IxNHMsLSrlLsOI0Y0DCp7kdigJQ/kgn3HzxQObV1dETdAeSc05AyFgVmXCnL6jBxTwPO
         JpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749892524; x=1750497324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYRTvvdIGzq7CdBFFP9ONngkQPMZn1HDEsVvSCMMDNY=;
        b=iakaZUP6v06yZ9BHFSL9Ly8PadZUsXXSCIQWVgNGdPJPx5LbPxj2j78Ce/5w2BQSIJ
         XJyx2+00vTbidpsvwewY4J8+WSZBljhzcO3NPYPhm1Daf5sWpHMfBDjM7v44+BEXMmfl
         Jeq5WIAuhchvfMvoQcju40unYODuPAy42P7pKLnQ9tK+puLchNK1FN4YkwlEuZs4Pff2
         5K7blfMFubKfnKdT1LappOVpUC5u9ICUM4b5BxyQvXAqSuXzOGsLwzQKnerg86dTb7HW
         tVWuvwXTjNK02KeMjnsvcYd7M+J2bnyGWO2uM0mXPyz1y5Yjeyl9ap0cOGACeYSreUnK
         OUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfln12idpdeKqUR22IVIB2rv6/c2yIuLCOOABZy0IltI4ZXK9RY1IHM8UVrROsyDXSlebgT94vCSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOIdPL+I6Qw4ZuiCMUm1juuydAbJ89wd7zIMUqkpcdJCE+63m
	A7NPmTlOqaIDxUpfJWGNIsvUwhWzVvYwnAclaR5XHZAtWw/FahP3mo5ixYxMDuoKQtHWzkwg7QR
	4obls
X-Gm-Gg: ASbGncsYDNFeC4vDGI3hhOni5ax3/KL7cIPuqpAgRsxqpZv7bFR18tvvssjvMGNzxpA
	gpPnKLUkcqOTYO3CdxXKwIG62nrH2cWXDc/vGJ8zM/qiaNlvHrSLigsH108u+AR9nXGB1HTLegq
	o4xtXanYwjdnW+1f8t4zRlb4J2iKAb1wyUKZon+3LGHtfPD/uZO5jHkr1Pi1ZoWBnG+ajb6srpQ
	x75rfWTRNhtotvSZb2liVYgeGCOQUFyWUPu5WUZztdNDNjkB7cHdHIIMTAyGUYGKM6A0sK191w4
	bfj4tsxXgs5xQCZ8vnbFa1nsr1Cg4pn3VQ32jaW7CUKkAvsXCzXbXp6b+6qPzfssDLgLy3RozWR
	FroiY4QYLknzUlldtqUHVt+0l
X-Google-Smtp-Source: AGHT+IGLACzGINeLzDAekt4Nq+kEFciWTt+wr5CrDD1kNgZwXpFw4VeI59kMC+hduQurLjcXbkumOw==
X-Received: by 2002:a05:6a00:230d:b0:746:298e:4ed0 with SMTP id d2e1a72fcca58-7489cf99f60mr3017945b3a.13.1749892523829;
        Sat, 14 Jun 2025 02:15:23 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm2969630b3a.20.2025.06.14.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 02:15:23 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: maintainer for TI's ADCs' driver ti-adc128s052
Date: Sat, 14 Jun 2025 02:15:04 -0700
Message-Id: <20250614091504.575685-6-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614091504.575685-1-sbellary@baylibre.com>
References: <20250614091504.575685-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add undersigned as a maintainer for the ti-adc128s052.c which supports a
few TI's ADCs.

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..bf1c7fdcd2f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24719,6 +24719,7 @@ F:	drivers/gpio/gpio-thunderx.c
 
 TI ADC12xs and ROHM BD79104 ADC driver
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
+M:	Sukrut Bellary <sbellary@baylibre.com>
 S:	Maintained
 F:	drivers/iio/adc/ti-adc128s052.c
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


