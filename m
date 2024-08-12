Return-Path: <linux-iio+bounces-8412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F074A94E84A
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD881C2158A
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CD167DA4;
	Mon, 12 Aug 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6DjBsdo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D314D28F;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450397; cv=none; b=nBuoxU2+nF0TT2ZF0m21GJMZOCmdlLxDvIhbhU6LQ8k2YE1zYjnVrOc5OqfXGGWrcW3Z+MNG4HCo2YsQfRIJ5NSl/77D7/7WTReYG25F8Jw6W0hcO73Ur2pEUoAGbNxsnIJfwL1Z1XzvNNQ9RxyvYG9Xa5M5M8xO7Jy/hS0Clv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450397; c=relaxed/simple;
	bh=o3GBS28qbFn0jxy8QFQgIR++m2QUQw+RTCHfzVUfmQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrO7CiHjGlmD6vaXgx6dmJOXfjZE0uM/7S0aiJvlmvVThQafxNgBYY+dSff9jNqVm3KpSwExAgjqfm/lMGjXGsnbOdnz+2j17NhYAqWJucBmBWKaTb216aWy18kg3wAwnKXCdglxdcsjwcFNYMHCv1/OI94x+FcPC33y9KI3YEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6DjBsdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AAE2C4AF0C;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723450396;
	bh=o3GBS28qbFn0jxy8QFQgIR++m2QUQw+RTCHfzVUfmQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u6DjBsdozu5GZJ9Z7mlnIBNWEf26HvDNjDHxEdEDNz1y+WN6KOxw6wwS99J2FEYsH
	 8CvwxyZgX3NSyzVv+XJFwVWu/9Z0Q/n67SIV3ww1CIBzYmB4f2rwIGcEZKm2So0aWx
	 9wZHSi7XF1qJJMQ67YXsR3Ybc1T5D/chtyjqiTFQWqLbzqBDxjgIQL3AlbYMa9RaBP
	 Zbx/4QJYpTxGsXUqCV6KpihtI7Nz2ZQ+5LrS9+swX6q58Kr5hCA71LMP9dmeLEbkZp
	 kcWxXeCYWhs92AuNy6N9brlUZtxa14Duqk+6P8yciOhUJtr/d7BZHD6lU02+Z/Eg9a
	 srsMVTDrjwKFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED3C3DA7F;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 12 Aug 2024 11:13:14 +0300
Subject: [PATCH v3 1/3] dt-bindings: adc: ad7173: add support for ad4113
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240812-ad4113-v3-1-046e785dd253@analog.com>
References: <20240812-ad4113-v3-0-046e785dd253@analog.com>
In-Reply-To: <20240812-ad4113-v3-0-046e785dd253@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723450395; l=1781;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=oQd2U0oExOZPemV00b0JuLI68Pnb/GaMf7q4j3I0hzg=;
 b=fWQ8J1Ygl+Dpee0s/U+i68ylgSVleM95MbbAXIrvPqaloafhxDK6j9RKpsbtP+WyaAQ7xRIGK
 5hktkofSd2BAkI8pQFprm17LIIabzJu1L02zXdu7u9lK35/LBE6akXw
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

This commit adds bindings support for AD4113.

The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

Added ad4113 to the compatible list and the "avdd2-supply: false"
restriction.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 17c5d39cc2c1..ad15cf9bc2ff 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -28,6 +28,7 @@ description: |
   Datasheets for supported chips:
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
+    <AD4113: not released yet>
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
@@ -44,6 +45,7 @@ properties:
     enum:
       - adi,ad4111
       - adi,ad4112
+      - adi,ad4113
       - adi,ad4114
       - adi,ad4115
       - adi,ad4116
@@ -331,6 +333,7 @@ allOf:
             enum:
               - adi,ad4111
               - adi,ad4112
+              - adi,ad4113
               - adi,ad4114
               - adi,ad4115
               - adi,ad4116

-- 
2.43.0



