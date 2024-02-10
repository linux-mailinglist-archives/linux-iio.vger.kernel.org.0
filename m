Return-Path: <linux-iio+bounces-2383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5085065A
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59C71C21B67
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C15FBB8;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdS/uucS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AF5B1EB;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598641; cv=none; b=jBzcW499zMn4mGJJs6T+SVzdd3uP1CVl+PA7bw/y5reXRalv/lvCYG2l70lqCUPu7iTigF4DE8B1+xn9BaNARIEqC4LkfAitm0gPxfUB7m3hmEVHB2NiHxN4+EuEKXOb3Wmq6XnfYZ1WXiHzm7Nx5VSE+4h5+C9FveW/nBRuCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598641; c=relaxed/simple;
	bh=cRBsVA/gjcOt9pjoEuJIhQ39NaZaSPebkpAvtLwDKu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WasqIbP8M5/q5/4GQqEahgYtuP1jCz/7U8P7B5Gei91Flm1PrXHxt8sVlHHdYzgCXq21yI1ZTXzN6Dmex7t0Zc9Z4MtNIYsyuex8et+G5CKezRh3P+3Z525qmWQ0umJoJ1p+eExwWWL2jZ2rGiuUXgnJSRcAfiQMlTYapxsRWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdS/uucS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15A3FC433C7;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707598641;
	bh=cRBsVA/gjcOt9pjoEuJIhQ39NaZaSPebkpAvtLwDKu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sdS/uucS+T0udXJpwZgmbFMqsKj7BTmq5kNEou5RhoFhzt/mme16mbo4Uh3wqa9H3
	 Nn65SeNCMdYVqP8WIrMuX91278rBa8vZ5yE+kg1Cfn256agHpqLqJvkMk9yosBADpy
	 MMsuO6NkYBRiveKigWZSFnTzfD87sSJza3rJvj8uWuuhE5iY802jEm2RgKpqvvgmdN
	 /bIMczbwGWz+zlHOTZScwEzDBMltpe5dfiCUXtP/6STlSz6gcEXAcUahqfqFFAeGwI
	 mNqVpJj8u5vyIMdXogy5h1kHODKI75daWI1zV9aqrvCqPe00UxMQ9Gwv11AbVq0QBt
	 oN72LY6/q8Vnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC17FC4829C;
	Sat, 10 Feb 2024 20:57:20 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 10 Feb 2024 21:57:13 +0100
Subject: [PATCH v11 1/7] dt-bindings: adc: ad9467: add new io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-iio-backend-v11-1-f5242a5fb42a@analog.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
In-Reply-To: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707598639; l=1193;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u0BDfBpNIPqTnjAdSKSUmF2FUWY8hltyVdK2adeadi0=;
 b=w+QqB8ABd8r/spid6E+PVmFIISvYZ4rYPJRZJoUxrT2apWLdU/uZqsr3AMpkPKhrtop0m62P8
 itFRUX5WmGlDxLzMKZaLycBtwSNDBrd9BDLGxBr9hm+5lBOhSW4oh9e
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

The ad9467 will make use of the new IIO backend framework which is a
provider - consumer interface where IIO backends provide services to
consumers. As such, and being this device a consumer,  add the new
generic io-backend property to the bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 7aa748d6b7a0..eecd5fbab695 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -44,6 +44,9 @@ properties:
       Pin that controls the powerdown mode of the device.
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
+
   reset-gpios:
     description:
       Reset pin for the device.
@@ -68,6 +71,7 @@ examples:
             reg = <0>;
             clocks = <&adc_clk>;
             clock-names = "adc-clk";
+            io-backends = <&iio_backend>;
         };
     };
 ...

-- 
2.43.0


