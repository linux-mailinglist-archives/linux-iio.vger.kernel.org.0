Return-Path: <linux-iio+bounces-23913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64955B5101B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B42485992
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CE30E84F;
	Wed, 10 Sep 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="2gP24Erf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F630DEDA;
	Wed, 10 Sep 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491090; cv=none; b=EY+5pGJ7OfwuqAf7JHA2OOAES/+u40txYvwJoFGSWaRI4xayZqmpkQfXWB7Fx227ezIKXom+/D9aD1LBZj4DxXDhPhIkqqhuqKf83ascAE/hal8Zu+8aK+qN14KMNE0r31xMYLfzqQAfiazF5BGIW8snBMylM0ZaSFGhqVu5iUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491090; c=relaxed/simple;
	bh=FYjJXoY4AMEgCSnS6fQ11Ukudf0Rfc/lTb5wo6hKrGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPQ7k1pfbhQtFhxoXEq0fRGoqYGBvqfUxSZTpFK0NBxHck1aONIv87azeub2IVfUAevYoDAFuobVKg2QK1Q5uw5hMnFFV5qAJU8dH/7s3/aD+o30ByCfJ7Bcv2r1oKGce4Ue6ToWSvO6OJRNNUo0I9IuAeR3mlnEvUHa/EhmOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=2gP24Erf; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 798C4173BE9;
	Wed, 10 Sep 2025 10:58:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46ncP2nkNBhkYAOSJYYaT4iHbNJbhU8MBU+tgId1tWI=;
	b=2gP24Erfr5K+XN7KIIZ9TZ0m7yN0ib8Y/CU+Vjvkd2VX1pMCEk5JQyC7CCWl1CEjgPJVOm
	mJzylljPl8lncrUoVz3OXI4H2Hj4mOX1Nb8T9RgdWFnyjkX6AKn7eqX5y6u5fMNMAUQXID
	0Y/NCEsHuEU3WlAlaYA6qvwoalP6qX1/b+9y0KdMXIpATCNY2vvgW9eZvehwGALcnUyInY
	lkA7G1a7khJ7GnYTcumbHSM3qYov6eajndebOdiJxkLHiktO/cw9j8GREjqQwqzorMEAf0
	Mszhhlpof9gCN7RKilOhjLmUoY0Peeefu9p69PrAGh7q+CUyepTDxnE5h9FLMg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:06 +0300
Subject: [PATCH v2 01/14] dt-bindings: iio: accel: bosch,bma220 cleanup
 typo
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-1-e23f4f2b9745@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=982;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=FYjJXoY4AMEgCSnS6fQ11Ukudf0Rfc/lTb5wo6hKrGE=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+GnZU4LqeRqSIBI7Q5ji6/hWa8yC6fvDw6R
 pmq2Q3fntOJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhgAKCRDPJpmZhE5/
 MMJwEAC1Jv8xnuvgIZSMi7oBLXe1UAkGuheSLxGi8Dgu7llFI3NUyaMxkKSLaTAZKyLtsl9FSPF
 nMNA/bu0o0kiGLwQN+DNt5ZdE7hablKDFxTZrudTqXHsDjTWwkuPP3+wJkIwKaNJVjX3QJ8RFbn
 Qyd3koSu+ApFlK4G8nvxc0XgrQejLDgN6NLhfX9GavWmKLvxXSL2lN2PS7an6KO7FgKLF6/YBAa
 5/WW9QJSAbrK7k1YvgiNHVgEESWnd9McG8gfZX0sJsqyUlSJNVCBZHboqUNgXtOb2J1ljX9nEJu
 HI9j+Uf31bBFTZ4mPugAQibKQi910ltiTe4D7uquj1c+w3gE9RgPzTz2Y4x49GdvfuWBfNbG6+U
 JAhwDPIFYlxmSDE3KjuFAyxqYBFLJgVq2o1csSTcG1g0pwu7IVrXTXY0++nb9VAgYp0l4dPL/s3
 JYY3Y2je3qLYhKNXWqY0905tIYa5tHCdgIIvk0MZRbbePVLyvoAMGa6VjO1KmKRgjSVHY/JF1vm
 c0doCSg4nQB6PSedEtb0aqioc2wwN3vcMoaDRhTKkR4Bwcf/uA6e7+Jov6s3sIfmvNk5xnYwZBb
 12jJpCPXC3Ur5g7bjT9ksCQ49Vq5McLEhNFt7m7mlwUWo8I5rdI5y8l48Dua/swLUi3Tgg+XBqs
 C8/33yXZiE6SD1Q==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Cleanup typo present in the title.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
ChangeLog:
- split out from a bigger patch file
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index ec643de031a34190af1bc2bffee7412ee2d3b902..da047258aca3d84e8b2cbe92a9c98309236fe7ae 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/accel/bosch,bma220.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bosch BMA220 Trixial Acceleration Sensor
+title: Bosch BMA220 Triaxial Acceleration Sensor
 
 maintainers:
   - Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
2.49.1


