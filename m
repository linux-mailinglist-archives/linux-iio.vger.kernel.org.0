Return-Path: <linux-iio+bounces-5730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0348FAD06
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07107283577
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2928D1420D7;
	Tue,  4 Jun 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnM54gIr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDE137C2D;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488156; cv=none; b=XhHwFKNUi98rGIN8J38jwTlIZm/eKQdd3U27+BRdUCDVwsv7XTMmTkT/eqKhjnTN/Jj4dZxToDNsA0C/bdHs1xlcgP8psK6XZDR6YEZP8qttF2CyBt0eTOAdOPlPxidY3bzQqjR7m+3RRx9zp5Mc6OTYLjy/AVhnUaYglLDk/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488156; c=relaxed/simple;
	bh=yc2Veju7chaWEi/l1gmL+RUvP0s9O/V1PE7dSAHTZhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFxS1vuIRgqVSfBc53ocANkhb5KAAFhHGVEAR8VOCGAC1s6xWBtoAmriM+S9j6p+5lUrEHz7vkeEXdcFlhEjJqK7gRk4sh8NUu4QCCAfiY0siLauQB0JnkUGa4nRk8bJ0rNISplREfxOvp2kabjHcdf+8fmb9aruE2AcynnYlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnM54gIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E7B1C4AF08;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488156;
	bh=yc2Veju7chaWEi/l1gmL+RUvP0s9O/V1PE7dSAHTZhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mnM54gIrdQ7WDoPg5oNdi7zWpZOO4rqBf41ggI9UBFawohhZoGrGqdqZFPDpbJmvi
	 aXIf86WSiF0oCWzm/5h5k8urlh4dcBOofmU71J7jFASKaUbLB50j+25fnIsfEuFiIE
	 2Qz0GNr30wtTbpWze/EV0mOjd5GizD2dTWp+E2L0QETsWJEiAi8uXz0NvAoAvofaiV
	 HagfwdumrXji0pNe4RtZ0IlisE5qZGjpDoK1quVYSohCTZvhB34q6gvKcy6G3Vxsx5
	 6bgLT+e+I5RbbXJ4SqxiYkistKmr6/grIgZa1EaPwxTyqNBJF4k1BIzRmziTG8z8Qf
	 rqGft0JBSpZ7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1B0C25B7E;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
From: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Date: Tue, 04 Jun 2024 10:01:49 +0200
Subject: [PATCH v4 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-veml6040-v4-2-5a4d59597874@sentec.com>
References: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
In-Reply-To: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Arthur Becker <arthur.becker@sentec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717488152; l=1386;
 i=arthur.becker@sentec.com; s=20240521; h=from:subject:message-id;
 bh=9rThcOFRJ7S93FIcWQdT1WZcQC1aM2qApoy4vlBF7hQ=;
 b=PKV/u4sIgobPlvHwj85thig13uPd1GBIwDqppFBW6emJDJc/6HgwmfVpHTjRCSIN70jmssdFs
 7kIUXj6e76ZC6AoGcZwQnzr7TZKHt99qjBf/7cr0h3VFSVrPiuGxdPA
X-Developer-Key: i=arthur.becker@sentec.com; a=ed25519;
 pk=1GLsDBF6GZKt9oNFsvdnAB6sHyKKrSISlwM3AyWbx/k=
X-Endpoint-Received: by B4 Relay for arthur.becker@sentec.com/20240521 with
 auth_id=163
X-Original-From: Arthur Becker <arthur.becker@sentec.com>
Reply-To: arthur.becker@sentec.com

From: Arthur Becker <arthur.becker@sentec.com>

Device tree bindings for the vishay VEML6040 RGBW light sensor iio
driver

Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
---
V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent
along with v2 of the driver but not in a set)
V3 -> V4: Combined dt-binding with veml6075 as they are basically the
same
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index 91c318746bf3..ecf2339e02f6 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -4,14 +4,19 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6075.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Vishay VEML6075 UVA and UVB sensor
+title: Vishay VEML6075 UVA/B and VEML6040 RGBW sensors
 
 maintainers:
   - Javier Carrasco <javier.carrasco.cruz@gmail.com>
 
+description:
+  VEML6040 datasheet at https://www.vishay.com/docs/84276/veml6040.pdf
+
 properties:
   compatible:
-    const: vishay,veml6075
+    enum:
+      - vishay,veml6040
+      - vishay,veml6075
 
   reg:
     maxItems: 1

-- 
2.34.1



