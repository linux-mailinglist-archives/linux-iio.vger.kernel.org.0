Return-Path: <linux-iio+bounces-10305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAD9937AE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AD71C23568
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209111DE8A0;
	Mon,  7 Oct 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO2BsKNH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC71DE3B8;
	Mon,  7 Oct 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330614; cv=none; b=PPIZg7Hcpg3vKx0IXO0wdPX3gBVhcdPUp7G0mCo2OSX6KdsGiPZ2sQs87c0ThQW45k91UTp/n3xxujM+92w/BozbUXmbpOXuinASL/HaUF/wf/NWGq56QohxFp1YEvy9vBreRLjEeyg8DORs56AqNGPfUj3HOkghhA+GrF+0YrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330614; c=relaxed/simple;
	bh=7uC/oD/EC1yLWS+RCZzt3d9PsCUcWXEwxeyQTHW1eqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=feODwzdgZspxPpkkTdVkopJagJ2KWTdyXt8aaM5Po++0cZ/ZcpUFgmRvDDLm0tgjgPsCz8bQnWPyYRalLC6VXMzd5RUG1lw0uRSGztQtLKidngLzy+dVmiILac5aKP4QIuq+M/mW3fW6vo0H0IZ8tyo0Shse8GIFcm6uFXdj+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO2BsKNH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so49011455e9.3;
        Mon, 07 Oct 2024 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728330610; x=1728935410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uievK+pt+AYAjztyMLN5d3R8p/Zue4ihwk/QuKxSgQ8=;
        b=BO2BsKNHHGmAexSbB3uc9y5LzhBzbbxPfXDweNIRtsFkEdVyAGf0p3bXXNLsp8yOdD
         bZoEsbqimlUtRXENVXAH+VWxgaOZBjh7ZdfwQv35aVVs24c9GRkk8Xnr8+Pi493lbuIg
         eMvmd7vc3tRRYLCT4gw1b7EABsD/NqptzmXUBurHhUHiDtTU0m1yfkLaBPUzTvhCmrRP
         fU4bR5DmTiP43EhisZEfuNjpe2wS0QQ3aycs2IT0TrMJBUNo4NYmE7ExG0SX8ThguRxp
         yeemTA2ki/pX4M63pCriWK94HXhrKx11+ERcFTZOqWGhGFuQ1G3uPOVsXstfb5/2vHdf
         vOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330610; x=1728935410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uievK+pt+AYAjztyMLN5d3R8p/Zue4ihwk/QuKxSgQ8=;
        b=GMAb9yizlWaG+kXqwKN6cpnDcMhIMtUBV4JCgRv4p/rwhTjZ2XQtQS3LC+yqyur4jR
         gY4IzsSzIm0VPeeRT9Lwo6xOHu7U+8mRKUpybZjUbqG/veXwiVnk62wj5lpsQOrMhaf9
         Imw0ejClm1YWeBFx3yVmXG6zi2D74wDJr10k55AZ7oGwqJb7/e4On4A7pGXH0b28QVqi
         oClYQy3kMTa+fYdr4pdoocxCRquaEpX2L8AcgATpzqlFwCQfwM7GBha2icdmpnFx3SUu
         PQ1AXZWowD2oDgc9W4xeLvIl4ZNDrS3232Y7aJnjIfV4onYWYxKXvnsf3WXvhSueXZjs
         adBg==
X-Forwarded-Encrypted: i=1; AJvYcCUpS8V+xwCixhi4vPI2i4jL6e10KFrabRvywkk/Ip+1X/n3Cy6imgiiNA8Gvs5fZTFzdxScL674vxW9i0pA@vger.kernel.org, AJvYcCVL9/j33COV3/zQYAQNBdnCgMxVJmPzkhDXL5S4ZB/FZNUVa54891R6UdiI4jkFJzLVoRSPJ9t2DZUa@vger.kernel.org, AJvYcCXi9DrkPpqklfodEaBN4x11a9jaa9B2aSovCzedo221hfBoMVDiD3nUqkNkmqw4pk8BKBCxzNik41OH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdy34PQfntZpkdcrIl9iF8AtziEGoZvotzkjBZOMwyUWkt30wT
	0ZnbA6Y88LVjAEipfAp9eMxfaAgSUvjIpC2KyYWvqWXfiuneIh6a
X-Google-Smtp-Source: AGHT+IGr6AYYUcbqeGRNkgSvINIB3ve4a0v4dJkw7TVZoS9rdzu+ns+6sGkZ+NFq+mSf94LTZW/cYg==
X-Received: by 2002:a5d:4e4b:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37d0e6d862amr7319693f8f.2.1728330605405;
        Mon, 07 Oct 2024 12:50:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b658:eac0:bb05:9042])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed922esm84939655e9.39.2024.10.07.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:50:05 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 2/4] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Mon,  7 Oct 2024 21:49:43 +0200
Message-Id: <20241007194945.66192-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007194945.66192-1-vassilisamir@gmail.com>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..cb201cecfa1a 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -47,15 +47,33 @@ properties:
     maxItems: 1
 
   interrupts:
-    description:
-      interrupt mapping for IRQ (BMP085 only)
     maxItems: 1
 
+  drive-open-drain:
+    description:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+    type: boolean
+
 required:
   - compatible
   - vddd-supply
   - vdda-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - bosch,bmp085
+                - bosch,bmp380
+                - bosch,bmp580
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


