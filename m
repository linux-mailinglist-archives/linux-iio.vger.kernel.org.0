Return-Path: <linux-iio+bounces-7899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896C93CB1A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E431F23ED0
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76B14EC71;
	Thu, 25 Jul 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgHOnoyl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25230145345;
	Thu, 25 Jul 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949055; cv=none; b=f++GxWeHRXGZ6zl+MCUbpOYWQPkoWtgaQmLnJj8NMCVxMT1rnL8KGne1mUL1wE4CIy/6V+l44AjuZa0HBwKuG6gZcfM7vbvtbDeaw4Th219Kslir4NOvBRuUujmVgil66NsFm6fpREPy4Kx6OK8Js5pqRjqo1p1T5s7O2cplf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949055; c=relaxed/simple;
	bh=GBHEIWop7OwEU3QgEFVWoe+iCDOsJ6xrle7YPeiWK4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6RBG7LaI82km2+qqcTy5MgNgPTmoknLH2GOsjKpW1s6cqutCOLCEdFJ6pj+JvotsP5SkllO/rU1B6pihjNLud3V9RsIGBhI+aNVG9WK3vDy1CxIo0UvVWsBfJtytnVaiWRsgaqnmtuNi/+3oDR0Hvl/R+wGM5hCPlaS57mNdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgHOnoyl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so135609366b.0;
        Thu, 25 Jul 2024 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949052; x=1722553852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBjwuvUrhORpfV0arBz8Ep9Xun7kUC/zPhKS7vTgw1Q=;
        b=XgHOnoyldH6xX1ZNFuvHPtw/lYZvdn+CqR3jQ3Es9Ynvwl4HEL1Vtf40UMQBbHFPFZ
         935/Kge+7dpVjWSf2f5ktc3UetneK6XhYm3w1Y2UaTdPdESIcByjrGJrgoWeZNN5znMj
         KZ0jfvg55M5j3XXWyitYVDZ5BT03Cgfur9aPuxUZD7jRH88l3+MUu4XNMd7uDVLEIv1v
         VdFyP4vro6CeiGAn0sprcutnzyMh9xh5EJjlm3FBfScp1dA+cxBlqjKs6GuC3T3F4HCH
         REthoOl+cLMw+XT6lIF8gkLSpcy4pnrxAi08yzfiknYx7vqeOj8q+oQHANYAf3/ZGRWH
         ltXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949052; x=1722553852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBjwuvUrhORpfV0arBz8Ep9Xun7kUC/zPhKS7vTgw1Q=;
        b=CBrohrAq6YdyCrLV3GW8JValzv0sBt10QSMQUdEPFl3lIPLYC7ASOGlnudx4OpL9te
         AomYjId/jdYmY5QIGC0X/zORs+w8Ohd451K2Nw2VJInJ6z8CVx3JSJQHoAoE76Ll88+9
         3CgwgBkaf7AfDyglrWSRzSdPPuU6qN8hfj9BpKt54KXfxXGbtGgwpPR8t0SStY4z9p2B
         Hpzvtw3FIuLqqiLQHb3C84Jvu4XcxIeCiDoSYhuY8xEuHd446X1Cz+KoGrE/pb1Tagyg
         aVQlPbkxYAP6oyHCxPEuAqtmv5nAFKYEayAQxMU85mzY8n4eYaJ3uelmJQkk3zMuDuYJ
         etDg==
X-Forwarded-Encrypted: i=1; AJvYcCUVLaMGFe8QgmNBhF//NNArQjIOsbexEFdrJe8xqXm0kt2Jq/PCbD+10Un7jboG5gvLU2TxQJvD4ZNnIHMNOnS5M06biVnBuuMJjV53BDSK9Sosqe3+ywpz/2uOPivVWhkQrEh68cXP6qp3vjbnLyE2N6t6RzelKKyJ0DY+HMOXx5z2rg==
X-Gm-Message-State: AOJu0YyUCqb4lknrFE0wbr6QF2aNvuRxmgs0lvMgF+4w16TFBvmcQEzs
	41VEh4tWDdJ7drkaZ+LXwqUiu+tTbEcNaVoVLXfS3C2jZoE1lDjG
X-Google-Smtp-Source: AGHT+IFoAk3e4khU5If6ITX83DY2rktvfftgilPgiGaGNenB3sxva1pqqoS+W1ugmNSu8h8Qwn5+/Q==
X-Received: by 2002:a17:907:96a0:b0:a77:d52c:c42d with SMTP id a640c23a62f3a-a7acb395be2mr264259066b.13.1721949052465;
        Thu, 25 Jul 2024 16:10:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:52 -0700 (PDT)
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
Subject: [PATCH v2 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Fri, 26 Jul 2024 01:10:37 +0200
Message-Id: <20240725231039.614536-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
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
index 6fda887ee9d4..072313201edb 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -48,9 +48,14 @@ properties:
 
   interrupts:
     description:
-      interrupt mapping for IRQ (BMP085 only)
+      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
     maxItems: 1
 
+  drive-open-drain:
+    desription:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+
 required:
   - compatible
   - vddd-supply
-- 
2.25.1


