Return-Path: <linux-iio+bounces-6719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42409133FB
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF4028138D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30416E884;
	Sat, 22 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aRLwOow+"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D27155305;
	Sat, 22 Jun 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719059823; cv=none; b=TkReyJAJHAVfw4IMvFjU8YG/rmivnKvD4MtibmsIxTJpBWJ1uB+gWFUkxbFMXytnVhutE5ZNfOjZEikWkrqUq+uzqGSGVyoS8HuZYddG+60Bem8YIpsVL/cNBqCTJneeAUHOEY4fSILQMLf4sauAET6tg3aGrnzmL4bPw5QZLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719059823; c=relaxed/simple;
	bh=mjI1IpIB03V6+dpHJaTjeA3Yprjb/QAF8z+E4rr/Hj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhp2E3WgLkcFPTRPeG9t4ADEZ+6K3dRo/MW99R3JCiaiPPErh/Gz7KFjPjH2nvgmr85XuxBd+Gp43IgS6MnidNLok0gxP82X5MRYMESbDvnxbUgRUBkkEYVyQv5WAJVX+Z/0w1rMVy7r8/+4LQT5zte9elQnTlEVpEYV0WBkZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aRLwOow+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719059817; bh=mjI1IpIB03V6+dpHJaTjeA3Yprjb/QAF8z+E4rr/Hj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRLwOow+d0dbu4u26YmZ+8yvcOF172jnKXl9Jt3drT5GuUltXkR4q0ywIuR0JIzpy
	 4wXnmJQKylxkHPeKCxW/sM7LpSELxHGaldmKCEED3VE7UH0oDLuKzHGmO2z5r17nvU
	 DKaCwx0B9raMb8cJlgFMBWJscEd5N6dICq+VAFY65BVKUhEugXHtLcN46Sc3/YWebP
	 7ycdbd5k48V1czKyQXWjdzjYw4NjszN7DetyVfnkFa81QyFKI5FNoEG1isbqbefSwU
	 BT9B0D/5dcjIKc+3tKSGsbamHLR+rpdmre/ZSKvwC+fdqyLYGp9klm6Ukf/S73rAbT
	 yyE5+cc56cwsQ==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	denis.ciocca@st.com
Cc: devicetree@vger.kernel.org,
	linus.walleij@linaro.org,
	robh+dt@kernel.org,
	kauschluss@disroot.org
Subject: [PATCH v5 2/2] dt-bindings: iio: st-sensors: add LIS2DS12 accelerometer
Date: Sat, 22 Jun 2024 18:03:46 +0530
Message-ID: <20240622123520.39253-2-kauschluss@disroot.org>
In-Reply-To: <20240622123520.39253-1-kauschluss@disroot.org>
References: <20240622123520.39253-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiable by
its WhoAmI value 0x43.

Its register interface is not compatible with existing parts. For example:

- The full-scale values are present in register 0x20, in bits 2 and 3
  (mask 0x0c). Most other supported sensors have the register address set
  to 0x21, 0x23, 0x24, or 0x25. There is one sensor setting though
  (bearing WhoAmI 0x3b) which has it's address set to 0x20, but the mask is
  set to 0x20, not 0x0c.

- The full-scale values 2G, 4G, 8G, and 16G correspond to the register
  values 0x00, 0x02, 0x03, 0x01 respectively. None of the sensor settings
  have the value 0x01 associated with 16G.

Add the compatible string without any fallback.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index fff7e3d83a02..71c1ee33a393 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -26,6 +26,7 @@ properties:
           - st,lis2dw12
           - st,lis2hh12
           - st,lis2dh12-accel
+          - st,lis2ds12
           - st,lis302dl
           - st,lis331dl-accel
           - st,lis331dlh-accel
-- 
2.45.1


