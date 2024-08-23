Return-Path: <linux-iio+bounces-8724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7A95D52E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE07E282A5F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5EB19340A;
	Fri, 23 Aug 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO9ScDjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAA192D8B;
	Fri, 23 Aug 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437048; cv=none; b=fGRbaXuKxb2tqzFcd95zTvetjyjRiuS+PLSAVFN0JC29MZTQgG4BNIzeHC3nl8Vx8jtOhlhoJzyWJf+zTskHf4K7fEeD6Q7fi5sahWHZC6Uin8lei6TTD1rCuug2ccavIgDsWuzI4dqKHrwjDSeJcDsvkf+Hqdw4NH0vY6xCTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437048; c=relaxed/simple;
	bh=3wtsOGntTA2EIT7umcv//Zg6qc+Tm+J0IMAe4ZJ/BnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZbJU61w9nakFbvtr7VVNTcoBswnLgUR+ZkigurXm6Kf4TMRayoQC1V7iRZLi1PZf92Mrip8FY7GduMm5t6CIWfAsKeAppoke+WMelo9VZpQZ9XWOXtY3lH/i3ibP8qrJdsQYR9mQHBiK92ac9Mh/9CLgj9jv7/VZB9QCyQOqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO9ScDjK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718acbc87fso1145500f8f.3;
        Fri, 23 Aug 2024 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437044; x=1725041844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZT399FYQw+nUYF3pf7lvE7xdWfuUjkXJO7D1WP/rJA=;
        b=nO9ScDjK378DVpjgt5OJRowrmMhLf+Zqpx/dl6IJh7HF27VYLsoSYhq6I2RbD3PaG+
         bHFtn6w2H5uwsay5954K+v7Q/C9PdcnWkk+h9eK2ggApLAoMNzR5e24X9XZYQ7e0p1aJ
         TV+ooQ6cgW/tj7g6nB/I1Q95TapfpFQnSy0FxioxPqpkiJKcDefDwdv7O/gM6nP8B4Sl
         799CXYlN3gIK5le/5mOhizBBfvdQz2A6lMziUJhEB5ZynBuyZl6HAzC+zURD9EPgu/LZ
         c7G7/IF1tPUJG/k7DwTG40L0cEqwyS/6fT7orr7ZmBEtcaiZDzwkhgIO8czZ9HN/QGhU
         0T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437044; x=1725041844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZT399FYQw+nUYF3pf7lvE7xdWfuUjkXJO7D1WP/rJA=;
        b=JYny8at14FDpyvEEj6/gUzD9+ZpyYNqWvcdqqw+aiuDvcO01U1cByQRP+PS1bT/Q7A
         RLDM/88EmyJ+D1zoqWNIropWmxMbBYyF46TEOdjBHLAhRQ2ZI1wn3gUpeCGRVJjT6v9L
         MkdAaNMNF08lMlnckZSd0/e35595KERLClijv1Qus51ppobbwX+nfMMsL/zlm7wOna8/
         tJVgtDl4KDcLyXJUVSW7oAbxU/zedDfsxdTCBkMQPKSrATUW6BpfoZzz9jXPiOu5L2Th
         aPcnzeAEFjaWJjqr5BrN+qDaBWnKdy8sWnkSTZH36sEP8PGb1Ciu0nr5luKeNhmdfcc+
         sSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUf1fK8b5EuU++pDXXPd/Rofz/mB6c2tkqN0h4YRTM8uh79nbCo8r/4WEn5PhITN4i7bZgO7gxvcGXe@vger.kernel.org, AJvYcCWTVe20tfmpq7z+h10a7+LIPOPrd9JyQymBAEB64AoS0leKxQaDABvbxZzlXxITsdj2LpiRQTuLJ0iw+SOF@vger.kernel.org, AJvYcCWYDCzy92BHY+lv5N2QmaW7F6bqIJGG4UINHghky+6F+KdMLvw/AjaECsNXDfr+S/eq2R8AFIPezsSH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2z5dCzKZwvtrwmPOqyESuvP+aGxyYsjPmk6eulxMqqSHBl5W
	w7lovTHo2HrDd1UPU8sCPDVnj+M3xg8BVFNZU7AtrXjsc9meGn8H
X-Google-Smtp-Source: AGHT+IHKPYmZ4nWzYw9K36dKDTEu0K35LSFp3iEJbuELTA8swnxWqRay+4Z/gPDRDbBb3omyFFwEqw==
X-Received: by 2002:adf:e0c6:0:b0:368:6f64:3072 with SMTP id ffacd0b85a97d-37311841974mr2027756f8f.7.1724437044128;
        Fri, 23 Aug 2024 11:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:23 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Fri, 23 Aug 2024 20:17:12 +0200
Message-Id: <20240823181714.64545-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823181714.64545-1-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..eb1e1ab3dd18 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -48,9 +48,14 @@ properties:
 
   interrupts:
     description:
-      interrupt mapping for IRQ (BMP085 only)
+      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
     maxItems: 1
 
+  drive-open-drain:
+    description:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+
 required:
   - compatible
   - vddd-supply
-- 
2.25.1


