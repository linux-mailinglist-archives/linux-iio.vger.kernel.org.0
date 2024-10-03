Return-Path: <linux-iio+bounces-10027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98598EE67
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1250A1C21117
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FBE16F265;
	Thu,  3 Oct 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ap9xvR4+"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A615573B;
	Thu,  3 Oct 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956011; cv=none; b=Q/zY9oOxy+1xN5uhv8dnG8DfyHdEwif720WlEcszQ/jVN+7ID9bZbZhGQShUfBQFpVgQJIrsFMvtwqeShGz2KJt9QdSadwoNTI3AGV6WN9wNXUZIV9FByqx3CZq2fvHNCKVFiVCS29/Y+T6zdH563NkxoMR1qwsotT9r46tjsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956011; c=relaxed/simple;
	bh=7GhuE30cA1jnzqBKR2T3/t4sGXf69ji3SvSDZRPJ4zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qynndglaohPO6phCflsqfCYMm5dryjwN+UGt+MEz1OwLKPIZ2v9hPO31W5AwSnkrczI7ahxGmq2eHPJvebf4GhskcyvVOzNfQjxfp/0UmtWD2ecqerTUg0KeU1zHOPysXNkcIoL48RMDsYfYUwlAPRuWtko/+gcxO4ns+ozu+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ap9xvR4+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A39E1C000B;
	Thu,  3 Oct 2024 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727956007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/FviqtWurVfEYS8t+3LSa3BpkRr5YVuFEV/OTJuwPk=;
	b=ap9xvR4+QcB7spRwIMW2drKroCelhM3w0307X+tZw0xVXsrybF5XuMklnPEmm7grwKoLOJ
	WI0WGpjM0JsWRJO+BNHCaZq0ilhsIZkvN3TTrXRVnsg8KzZDwCAZKacuoQEOTXhkPJ6vWD
	h1MwNjHv05rQtloYyTqB+NjoqQtexHoXcDac8m7l57Fz/2FjYQ0oE19yswKUU7+H83TgFi
	9e75Sdj2Y2THCkAGXXDwk8UdRbYeZnznTPpVEe05moexyGJE/QoCQQcuLyK9s6sDRvMUMF
	Ql1eMG/0HQDOA/WDzt40i82olDmUmDXbMmsK1T1x/G5BbTeMqlSd/AIMkD4A0A==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add an entry for GE HealthCare
Date: Thu,  3 Oct 2024 13:46:38 +0200
Message-ID: <20241003114641.672086-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003114641.672086-1-herve.codina@bootlin.com>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Add the "gehc" entry for GE HealthCare.
https://www.gehealthcare.com

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe..15877574a417 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -561,6 +561,8 @@ patternProperties:
     description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
   "^GEFanuc,.*":
     description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+  "^gehc,.*":
+    description: GE HealthCare
   "^gemei,.*":
     description: Gemei Digital Technology Co., Ltd.
   "^gemtek,.*":
-- 
2.46.1


