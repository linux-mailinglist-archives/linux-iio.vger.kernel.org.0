Return-Path: <linux-iio+bounces-24065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF51B561D9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE77189FE5D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3E12F291B;
	Sat, 13 Sep 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Y629B77i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D82F1FDD;
	Sat, 13 Sep 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778014; cv=none; b=PUQPo80r4FSzhvK/TSod79Tx7MQZgEgLK+w1NUYzhgumxrQvGn3DTB84SwNUEggZJ05smjMfdHJa3mgDT1juQOhDeflMRt3CpJ5WPQx413NfOMnLsOdPv3C+YJFIS8FoBwliE/f92yqeICVp37tX4dmnBXC64/hB5/15A+EiLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778014; c=relaxed/simple;
	bh=UhXB8Jz4OnNtNjZZn8F2Vqb9CSRohbbH+vylsGTw560=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbwyZm7UI4BOAEusRMJNyhUsN2uya+OF/9A2d4e46NoYLidUAKREIA68GNeNSr7UiZa3c8PrRxT/9YE2liLzyDRqiXgLesNVxo+ZJNsHc9Bv/8d8XiJjaH1/fS4cS9t4w1cPcjQxrINaLysIdeE85IbWdc/0HrnJCVF6PebBcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Y629B77i; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 961E0173BEA;
	Sat, 13 Sep 2025 18:40:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpR2X75UpYNw0eK3Bd2fyFVQ9sIJPVgjllZR+VdDbDk=;
	b=Y629B77iLrznPVZG1DKoraI6QFp0N9oNlk3mtUBPdhyI6hdNPsqyPsw/KgUe6bD7UtVEbj
	1gcJ9vWunx0NZXaRMoi07emLu19F+aG3HOsQYQ4JyLcC3GJzCVH5MBAYwfN4zUlTAPhpHb
	glQvL91/SqT3Wz7mp/sZF7WwW3MSXuJexqKUPxjAUr94jWGLuTFIHwklxkVHjOnbfIyi6U
	ebPerUhNUiFDgDrPvXmJ8fqZLudbuAboGMF/Q1CotyV7SOWvuSSaWtiaOrs8b1d8HKh8IN
	dD0EMRj/t1J2qY6+q+qxT+funOIXBXXyReTqp8pIbS8GB5Yq4Y5FvkWFRIbvmQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:23 +0300
Subject: [PATCH v3 02/18] dt-bindings: iio: accel: bosch,bma220 setup SPI
 clock mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-2-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=UhXB8Jz4OnNtNjZZn8F2Vqb9CSRohbbH+vylsGTw560=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBRwP1WJJq3J/J4s+IC43JTo3qi4uppdCMcg
 U9ThR9wHquJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MOvCD/9nZrxZE7ITilVyEE4x4YbjfnSZF9N6kC6hz2UoANATSdjNRtUsDMCQZSXzxMsNz/ddwPP
 WU6dcgIEVaa4WnJM93JgkMuPE9hKKl3QeLMuC+UmrmeuFsuIU4z0IKBZvexOMx/3K7ngu251kTK
 MKXl686NpFIz9c4mb/SOATc0Nt7H44LRjmzD+m7PbaRHDCvTlsBxEulushET8V5ItrozFDpOsU6
 lf8vMeLX+Bqq3THePhfMTJwaE992/gviG+yMYR8iOxkgBGrbIZQCTwLOT1aYPZ0stElkSKD5K4f
 /gUExlpYehCPrnd9TfwI6aXRW5bP3/5Ho6TCkho8Fy8ufN0R/APTm9rozhO+SdDQWeIggoU1aHs
 BNg/dzftSDuClwAqFt0MUOL8woa+zRFG0tCOlA7pK6gOFgXVBXKbR7CKxTDAaUbnWM4Kj7uZt9I
 3V2/WxZGTorlDRcfCuxFXN6BSmuQyFZHBL6sQKeeeMd8gLfDnIVIMkNRfsUFxjG2boYaffNAfd3
 UyCNjyWFQwuf3HdAFp6/AxtXJXKgWNpGgJp2T+Zdr7kZTX+0DOrU+CzXmSpIxxocwN9+8t+A9Rf
 vyyKnZO+v4QMsh18pknzfh3lr578PKGKyDh7uskEDNMtHlH/uwMpgIwlwy9FsGRBoGjN+EeGRpZ
 TVJpaYS14SoiNGA==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Assert CPOL for a high-idle clock signal and CPHA for sampling on the
trailing (rising) edge.

Quoting from the datasheet:

 "During the transitions on CSB, SCK must be high. SDI and SDO are driven
 at the falling edge of SCK and should be captured at the rising edge of
 SCK."

The sensor does not function with the default SPI clock mode.

Fixes: 7dbd479425d2 ("dt-bindings:iio:accel:bosch,bma220 device tree binding documentation")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
split out from a bigger patch file
v2->v3
add fixes tab, just in case (Jonathan)
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


