Return-Path: <linux-iio+bounces-895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997381158D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5F028283E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCF30D07;
	Wed, 13 Dec 2023 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDuRjb32"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE222FC46;
	Wed, 13 Dec 2023 15:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57753C433A9;
	Wed, 13 Dec 2023 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702479787;
	bh=LtZevuD9HlaZHWthi9dYUVW+AhV+2MD7SehZfZbe6Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vDuRjb32rVlG+PESKX5/E32SsJW30yAEKl8FHnmXXcEnsmuf8fnxIo42KqIDW6mrS
	 hBlgxZwl692WPBBJfYodGoilgXjEAcdZxmSHBzAgPtk9ODJB80DmwK1PD6WuQgwnM1
	 Zi6Ux1BOzWgoSaxGFm5P9edwZa8yqFj5tNCxpJKNig0z9rnJeOJ3GmgTPSbESAw68K
	 oo6O/a29SrxzOiS2wVLgS5vIi7Bpn5rlnYxUMlmGhljsSV3Ufwla++UprbQmsfdvBj
	 rEQk3IV2jyauih5oCOiCS7OOQZ4nC7We2SfmIwrWZgkC0o4JKe2SjHU8/B4vRaR5p3
	 UvmsShkkUMukA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ABCC4167D;
	Wed, 13 Dec 2023 15:03:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 13 Dec 2023 16:02:32 +0100
Subject: [PATCH v3 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
In-Reply-To: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702479785; l=1274;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=VgLwQbZqXp2b3r8rCQLCxjYuGEkN0w8TgD+TUyg/P+U=;
 b=RNEWJwrW39KG1P87W8rnKQQ8e2Lkd8TlA03zxcoQ0QbLcm+dFsEp7QUSCjggP5dF6AKs6wru6
 7WfnleJV3PJD0xq5tzRac5ebkAlf7fXFTpZPm/33v/2vSbneQVITc2F
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

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 7aa748d6b7a0..74e6827cbd47 100644
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
@@ -54,6 +57,7 @@ required:
   - reg
   - clocks
   - clock-names
+  - io-backends
 
 additionalProperties: false
 
@@ -68,6 +72,7 @@ examples:
             reg = <0>;
             clocks = <&adc_clk>;
             clock-names = "adc-clk";
+            io-backends = <&iio_backend>;
         };
     };
 ...

-- 
2.43.0


