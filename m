Return-Path: <linux-iio+bounces-23915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10BDB51021
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1533485B3B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7230DEB7;
	Wed, 10 Sep 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="BQEky6+X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186F30E0D3;
	Wed, 10 Sep 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491091; cv=none; b=eGCex9hPa5t+t/qE9adF1QgnK6bV/maLyGqHsIaOvYB5Y7uwyVKii7CBt2EKN5/1znYe0vZG6iEK29w5v0B2imaMqwf0Ds/zCtsD8r3QoYdPU8ca7Ntg/YpBA6TXpPm1PaIfCQnWwNyTOiky8iYR3lIIOn1m+Wu9xFlWONpMLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491091; c=relaxed/simple;
	bh=ImPKxHSGq3ndlT8NZVGV3OeU/EuHHXeTYMbeg2lmxEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3aCQIRthldjtK1Daq0qmKPeP+hY5nZwd9tvPdZTgdL2tDicx0ou5vav0pzPEl6e/DbsILrBxmsZUxlKhW4Mr4BWLYS9VNCIZ6WrxK4WzOC0iDjtzGyF3cmTlF6n9JbJFSEOH4oi45uzyfUfwJMlDuE8mBLy6prCu3sdqhrUUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=BQEky6+X; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BAED8173BEB;
	Wed, 10 Sep 2025 10:58:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBzTdcdjY3tGfhA7VjWY8IHogkhlKoPPORRxkej+wVY=;
	b=BQEky6+XKCu3JNJJA+5NoA1uZq2chF4Kz7Z75QOqxAvhqVnmBfJdtb9C2pFkZoBs22Thrv
	nZcmxPCh9xkHiDzA+QtVoejkg24Y5bKZbRZdZbaX9iUeYw/w1vEIjvADHHONLf8ieg9VQ3
	Iz46OuVSn0GSnjHogqJfi3B6CyFbVoGz5gIJ29kDzd/fljQ1vnhVnOqa1fpm7cuEu0uuVQ
	/FZrAlXuajU97VhYrt08wErH3nGreOgN4nKz4eXnm7TDKHB69+mxL7BdggC+GxnHU74SnH
	lUgJE8xxUlNT7Pn7pGEQJshObh32gHvl7lLazcN1mQmEpH+zjPbkuXw7Sxvj/g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:08 +0300
Subject: [PATCH v2 03/14] dt-bindings: iio: accel: bosch,bma220 change irq
 type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-bma220_improvements-v2-3-e23f4f2b9745@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=ImPKxHSGq3ndlT8NZVGV3OeU/EuHHXeTYMbeg2lmxEs=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+HLsmxcre7S7FS4ta7jdKfMJCqcmQPuaLM8
 F2zYHSot7eJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MDgVD/9jN/CltAl1qukk4AdiY7k8FJl9p3/LSTnQXdPFH5HT+4Fsj4l5gk9tbCfNtbiN7lF3sPF
 VL+L5eU9ERB7r+RlXl3ZKcoGhYtQhm9YBbfasLMrQITgajH6Isnxl3+GPp9e+dWwdeLKbk1gdec
 JQV9X9k5RwFfbMnsCJb5eoXOkr8Ri3YE0YBD5488aPMc/3KfbbVc0sT8+1lcXLrKxhQG/CYjQdL
 Qszw50jy4UeJUVOQdo2J7GqVwy/agJE3NLhQ6dvvx6D/nZseyrW7SyfjKRV84iujRWmm9mX+e78
 U+jQNuRaUD7QDjlqYjHJUWNm2vpx1tIRe2YI7NPLoQdDATXdk5kjNK6mOQ8zZzJLPl93JEBZfam
 S0zGnVcANRHOnJQioVLJh2sbKKtYKzBaSL5g/R/JKbgNqCttRWJSeYj1s8LGvBOjNNI86i5IsHo
 zoWokls4s8wjvaAPnq5BpRkLksYQ9aua1Ejd4QvbdXOjSDD0X7j8b4n4FA3ZxY7eFO/Dq4IEsL1
 L0kboEKp8aL02Ooh77fxG4alVloJgVkLh2GmBY3VJtulemivIHz8pHqUhCeVqUU+Y69gQ6071/J
 hlhy2ZuJ4RmO9XxRfZXofV2jcI9GXrS/7ZbnXx8rpcBv+Iw8iyyXg8+cuGPu8vOKJ7wkX6gW340
 5h1u9xQUsqEj0JQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Set the interrupt type to rising edge instead of high level.

Quoting from the datasheet:

 "If at least one of the configured conditions applies, an interrupt
 (logic ‘1’) is issued through the INT pin of the sensor."

The old code did not request an irq line via devm_request_threaded_irq()
so there is no backward compatibility that would be affected by this
change.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
ChangeLog:
- split out from a bigger patch file
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index 0e27ec74065acca611e63309d6ae889b8a3134ce..8c820c27f781e8001bc14b4ca6ab1f293bdb18ca 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -50,7 +50,7 @@ examples:
             spi-cpol;
             spi-cpha;
             interrupt-parent = <&gpio0>;
-            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...

-- 
2.49.1


