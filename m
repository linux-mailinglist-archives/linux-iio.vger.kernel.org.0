Return-Path: <linux-iio+bounces-23914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B10B5101D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC711C80572
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2730EF70;
	Wed, 10 Sep 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ayX8FD0O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530DC30E0D4;
	Wed, 10 Sep 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491090; cv=none; b=bgwx4LT1V2fr7qYnDm35zQNmuInwBeOuDkI7Oz5uNdDdcM7hJoQXP3C9IvongXYp6IFs8etk2+Lj+YF5qjbyMeIH7fqR0fwdSWskO9LVPiy2AgKcw4kM1Nreg5nsvw8oWR+WFzzK/BxOCRn1VjWh6wPTUPuZzm3WB2RVdF+g5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491090; c=relaxed/simple;
	bh=oCx9mTmOajNf9Uc7YbPFgPQg58rFpIdkoxLqdZ+Ke64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/P1loEfxvDvyKxXN/D+3bZAF0BgSGczesMdUlzpxbWhkMV9lTyju8wGH2gUvxPu6iKjQ2kUlX/aLIbRguWohCCb/r/ylQlXzjKSG6sqyqMSE7SY3ui6dd01r1Xxs4I7pgjBWwahyK5SDeuKHa99YAqRGRiNxeLkRhhkb7UCWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ayX8FD0O; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 45120173BEA;
	Wed, 10 Sep 2025 10:58:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQe1hYAKwZYOw+7T33ujn3KSyjTVRK+2iVCjlDK8A4w=;
	b=ayX8FD0O123NwoJ6DR2WlWmAkh1rCYB3EoW1ZTt2uWczVexOna/h7vBN6kSjplqDnNiyCj
	Kd0wGEAB9tF6lqjHwOUimTRGk/mex99PcsN+yzjliB4e/CqlXJ4o2mVwKwzS3w097TJVqp
	VXOjdYVZxFytftDvXpmgHgX4WNkNk/7m/BL6fs92NsqDP5XVzlsHf6tEFGVbEBADNApCiB
	Q6Or+bJS+w2BymJ4i8qZn1Ot6irZrdbnJoU9BANlCOi+dUP3CTL9LNY3ucYdZ24Z9Tzegl
	Y0RSNP5datIsXs3bIMHralh//xwCDJR90UuEIpcgSwGou76mHKocXGW0/XL+xA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:07 +0300
Subject: [PATCH v2 02/14] dt-bindings: iio: accel: bosch,bma220 setup SPI
 clock mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-2-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=oCx9mTmOajNf9Uc7YbPFgPQg58rFpIdkoxLqdZ+Ke64=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+GkIjb/tYXN7fDw2KLwEn5zICcmxF9VI61k
 ZFSkj4L9sOJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhgAKCRDPJpmZhE5/
 MK91EACz0hESbkZwW4xHeOPqHsuOKTc5FNclEelG4QyDSbm8Fr3tE1L5WnZpizGL4sVbCJTHOVN
 upkP8skpL04juf0VbVRy+eTKVOlEAwnHASkXAsS4keX95Blfpzblji8ScT01FP1xE2VWOABrMZO
 CIHl+PD1McdV1xCbdnXlTTpWunImPZUZx/leoHl1KmeMsvqEe3Xli9y66WN0GyInrkCFAp4jKtl
 GTHMp57Qw/z1Jg+j54cfFlZPvkcqj8FiIWoPwSi9XS6MpW1tJcn/7x0pOINkhQ/+XsKCuyGxvh1
 axbj60nkP94YYAc2g3zVrAJDTOG13XboL6VAwNchN4cguUpIgH3zFAcYxOBW0TtbDv3/AKbWCqY
 0B9WQiCvsDkbF4ibDPhgVL8uq3pBmFgqVkct4wvOwhJ9uH1QpIWMF/54dJvXKQ8K7A1cOBZn040
 2qOSiB3RzqoXkPDVNCXzam2K8JGFEO+/qLdtOL9RLuLunxlKUd3YcJx6UrzLJWIWPiUW5G0Y+Zz
 656L6T8oiEFBhu5tJ0U8seGt6U49zDDX20rUrH3ViPJxC9CjJ0mOmQbs819YBmsvwxiE7DI5e3c
 gPvk0pg6oVkbUYm1suRP1iK///gle5cJuxA+10ZcYvbxwjIxMIXIwa3oI+vqONvUkxqfVfL/uJI
 zBwhI1Y5gQKvHuQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Assert CPOL for a high-idle clock signal and CPHA for sampling on the
trailing (rising) edge.

Quoting from the datasheet:

 "During the transitions on CSB, SCK must be high. SDI and SDO are driven
 at the falling edge of SCK and should be captured at the rising edge of
 SCK."

The sensor does not function with the default SPI clock mode.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
ChangeLog:
- split out from a bigger patch file
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index da047258aca3d84e8b2cbe92a9c98309236fe7ae..0e27ec74065acca611e63309d6ae889b8a3134ce 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -20,6 +20,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  spi-cpha: true
+  spi-cpol: true
+
   vdda-supply: true
   vddd-supply: true
   vddio-supply: true
@@ -44,6 +47,8 @@ examples:
             compatible = "bosch,bma220";
             reg = <0>;
             spi-max-frequency = <2500000>;
+            spi-cpol;
+            spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
         };

-- 
2.49.1


