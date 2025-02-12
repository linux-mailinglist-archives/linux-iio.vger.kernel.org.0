Return-Path: <linux-iio+bounces-15411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE08A31F61
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5F9168AA8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588E1FF1C5;
	Wed, 12 Feb 2025 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6t6K2FM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252031FCCEC;
	Wed, 12 Feb 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342862; cv=none; b=DyfApgHLtmffZ+JAHNI9Vpg2+VRFwzNeZtaOcz8Jm0CwOfkXI3UiESbxKZnmLm8gYIW3Tnbrssc0Nn04z4dVY3ZZnfutK+ldQWCKPMfvLC+6CW39khQ1raeaKFzj2ruHMe0ca7YbiTZDHo2vg8onRjCEBafY+DXLMmJQi3lWrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342862; c=relaxed/simple;
	bh=VNEtPE//Y6ApZRqAlJlvQD/C3ULc3yjTy7pgU2PxF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbNxI1aX2nQHGm+klJ/MWX9Q5U0FE4tfyJXL517JXaiNby9aZw7yJgymfmCxoze01/LkVEyIWFlwT41BaT5Q6D6Ec0zqMWYU0XB9BpJHZguWJyJIv89McXjxMrZR7oMye8HQkNJVU1nNKBrbwU5f8TK1y2xrvCYwj0FQxkgY8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6t6K2FM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5450abbdce0so3138329e87.3;
        Tue, 11 Feb 2025 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739342859; x=1739947659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZz4D2aU+XXjDEm9LXRnDorXwSfp8zcN3/oLLPufqII=;
        b=Y6t6K2FMm/K2X40HoFQ7/e5rmzXsbjdIOWDCxdIRc76924OevGWqv20EtvwjYbofO5
         3yHelHiST0DIpOtTh0gk8PsZmgbj0DlOI9Kmx7V/mIfpEsyYtZ360iovyIwW+3aDTgwL
         v20ZbLfVws2WNngBJwRqSEox17i6kDqRtsyUE7EqHpLYngQ8/1LEnTUIqiOIBb8bVpfp
         3WYdx8JP4NMdV9KauBpWt3mwq7YlNIa+QzjEnHLFvMEmB0OykMf2eHXBwO72hqjwyTiE
         14D5Fo6plde6Y0RF4FpWTqgtawE/GNNabYXdFasPbdhuf3Jsuu4XTwDg8JCAupbJcV5a
         5E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342859; x=1739947659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZz4D2aU+XXjDEm9LXRnDorXwSfp8zcN3/oLLPufqII=;
        b=sxjH1lK3r/sAC1qwbcUpMXW4w/Wix/nH29CVqcBJdL8GVZ+2IA80RH/itcvTEsD/Ix
         7U2wwuKN26X0OUwUPS5/G54JJCnnlNEeUtVD7DwZmuDOqxbOCXj7cu6JoPcsR5XJLNWC
         BuBngnhE6HTYJe73LdNDeOmwOHHfBpzBmT+kQuDv953ZaxEULbrB4sjDSW2wNpqacJ8T
         aa6OM2h08OznbrCAuMtSEjd9yRh4n9RYPCr3jBb83w8NLmoKilrWgNeoH6V06pNyF94y
         kp+IxD8EvKYfBlLs6g2VTyi89FLdWTQOvQk4fdbBAvXeXMuc9KR/O3ItDhmRgTI+wjCn
         Xb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCURbzrVAGT5jHFwoVcwfuaLCREmKuMYreh1VCOLxiddLMhxeAoDbOJDABAcGW+lN9/d0SgJpr3QSWYez0A=@vger.kernel.org, AJvYcCVTjdstefCTtsPwFpBZLEm8UGp5Hr1rgP2tsEMPRTLekzyQgVW8GLQmFGCATJe3KhefC0B9k8SBwGo3rspY@vger.kernel.org, AJvYcCVkTF318dZfwhBLf3nf3m20ZyrZPqYWwqS2OwYwV0lI11O/qWv5Vy7Hu6bYnykhL+Xi5nENyQBlQSnW@vger.kernel.org
X-Gm-Message-State: AOJu0YxTn7c/CxpkPfzZKllBLVGWiQSBhWtDBlFczeIFG9DhMq2xyZiS
	9X42SBreKyv9WRx7dxKl9ZnpB1DHEMuv1eujnTWmyYEfDuxZekVV
X-Gm-Gg: ASbGnctElHhsgeDoET4ONmMAgg+WL4jjyf5YU9s5A+7XXAWLfrB4m5qzForlNVR9L6n
	VEJBTW8OZD1zg5tpRc375390VgVZVZ91D6QU+rO6NPlQceW7DYNdmofIH1ONw+wx4gkgeFrtLYw
	aEzRM9WKK7Vkdq4+9ENUzScAWnY7g4gFeQdFm79QlqAyWKimonYE1ePBSqs2Dz0v2eaG/387TJ4
	/8Rxm0RsbvvRNflYAt63KU947UjeTcOyQfWup0hhjjuFOCs9V7bMCDlartXeiF++kPiC3A8Xl8S
	9qXtWvA=
X-Google-Smtp-Source: AGHT+IGdun2u8roJofjFUyx9Xc7MVpMOWtcswrCnii/u8a+9juoQYmHBcq33axe8EWS7cu0siD6yng==
X-Received: by 2002:a05:6512:39c8:b0:545:f9c:a81f with SMTP id 2adb3069b0e04-5451826ea22mr533195e87.6.1739342858847;
        Tue, 11 Feb 2025 22:47:38 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e09e9dbsm748600e87.120.2025.02.11.22.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:47:38 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a support
Date: Wed, 12 Feb 2025 08:46:55 +0200
Message-ID: <20250212064657.5683-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212064657.5683-1-clamor95@gmail.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is an ambient light sensor quite closely related to
exising AL3010 and can re-use exising schema for AL3010.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
index a3a979553e32..6db4dfd5aa6c 100644
--- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
+++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
@@ -4,14 +4,16 @@
 $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Dyna-Image AL3010 sensor
+title: Dyna-Image AL3000a/AL3010 sensor
 
 maintainers:
   - David Heidelberg <david@ixit.cz>
 
 properties:
   compatible:
-    const: dynaimage,al3010
+    enum:
+      - dynaimage,al3010
+      - dynaimage,al3000a
 
   reg:
     maxItems: 1
-- 
2.43.0


