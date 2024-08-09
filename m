Return-Path: <linux-iio+bounces-8348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2B94CEB6
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70511F21CCA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD481922FA;
	Fri,  9 Aug 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXVIzM30"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D21922DE;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199609; cv=none; b=RKiYJIPo6nUlryCwtdFVndH6ycFWdO3bMwV2DuU4DF4d085cWMFMKjj4c4w90Snva6Srzj2o5FPWf5F6iL79V2B4T0yKgQf1t6TdcVZ/WnUANFYlSH7od8g5wcBtdOyYe5OTJzKchjIdysqJTnlDdJ+ahqbNxdEoerzhBaqHcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199609; c=relaxed/simple;
	bh=lqMg10y3O9SDqaddwUKXnUAXvhykoa90oS9MBZi3CXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jfz8KUwFhsb9Abavz/NEo1T7P4Y6qbDEpRpsx7IWDkEq65Xc1NFLjXDUla+AM82w5z79LrRipIGNfP51g5fdbqLj5cpK/F5v2+Sv2f15LzfJTFcLMFYQb8ULwFAj2RWVET40O+DiHu5vphSGx+NiM5SResXfPrqkHmRIDbQON34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXVIzM30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4CDBC32786;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199608;
	bh=lqMg10y3O9SDqaddwUKXnUAXvhykoa90oS9MBZi3CXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nXVIzM30FIpiZpPPvpsNUhuGp70b3eWRu98wlWs5m7jPzzCtluTH2hhvcEb0KwktN
	 OEXEwAxrKda8v/VpBT3Y0TsstmM+27hDRXl4vyu8ebu1l/P86dwAlTlGLYTaGG/IRl
	 zafCDuTRIGP8USc8FCim1MPw0XxiN0c/ghLqdoQU7R9d9CRFYm5GjKsIal28z0QVOs
	 wkcQLDR1JmkEOdqLW984pSMZ2V2qivRFMvYvVWdx3qDkfiVa0W7xEKtrKr17TIToMh
	 oxL8GD4uLDeUzcyvZnIO3ko+rHV7qalnF/M/NMQnmUpzNLu6REjrjz/KpoSkUO6T4h
	 lIxvziFkC3d3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F3C531DA;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 09 Aug 2024 13:33:24 +0300
Subject: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for ad4113
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-ad4113-v2-1-2a70c101a1f4@analog.com>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
In-Reply-To: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723199607; l=1728;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=58eDH7pibCEzmuIPyXvksyLIJ8t1xe4uNHVYeY1xQaM=;
 b=wREnjO6U0jdH6CQWmOFUXSOOFClg70AS/OBAiAJFVOX8Zilnop3z3Pm8nUFjt+sFbDohv/wlR
 z7yayJcy0pWAEVNg1syRl++0YllObPQB72emCn5gn1r6kyAGMGp2HD+
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



