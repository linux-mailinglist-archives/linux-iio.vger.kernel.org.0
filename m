Return-Path: <linux-iio+bounces-25098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC90BDF0DA
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465443B4C19
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A52C237E;
	Wed, 15 Oct 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LRnFLNeq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029729BD81;
	Wed, 15 Oct 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538612; cv=none; b=jit0PV93QIdnsoKZcJA355PI8nEkrm411JlzZdeAB4ljDHa55v9Crs3USgA44+BMPcDl+i0qtgYKiFWebeO1NmoYVEssFiyIWAGk3au0478Tn0F/GzyIwHJepCN2AWpyqOAQJmfXKOEtlHp9R7wH7u2lJIefOx8WYI6obHew9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538612; c=relaxed/simple;
	bh=mX6DRCpwZu0oJ3WXBuBCHDc7vccUf0lA0M42o6jyDC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWQlYyQJKSxyW9yY6MeTkvb6w026FbUTfUjRKAuTgPaHnwVGteuZdnyzdXKMwVJG1qBxxXWRqAvopui4Eu1temfUsrKT7YCEBFVqojisiTzWrfEK3gWVJ30CgR1Tb6WyXDh3fYtx1+25w2vOcqr1WIcPGSpWphwQBAo2il98eJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LRnFLNeq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 62DA5C09FB6;
	Wed, 15 Oct 2025 14:29:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83374606F9;
	Wed, 15 Oct 2025 14:30:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA6D0102F22DD;
	Wed, 15 Oct 2025 16:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760538607; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/PMFWi9CEOOJIMVm87BvUcgLHk/cuD8EQlZaMOLBNAg=;
	b=LRnFLNeqaCNc8NTfpMXiOmKh9UGqtz8JLDp0WBOk/+o707hqz8UhjfoE5F1NHCrBFrnCEQ
	TU8Yw+ANgUTTzffZMzrWLcxbfLppRuh30QY48kPrk1DL4S8Uifh3DawGIqRHO+PODniJd2
	XoenisfdFXued0/1hKmnQ7n4NMep7sEw2SoXVF5KN7gWvG430/XiIlA6OEvsWjsYfe0a+5
	tfpB2W2yfHGFytPCYbLPo5qqdz9TILrYwHsF/cVUpR2cF/l5YMdnpl9zPatbFqVXeDPiXL
	AZrhL8bvyqGvLMUrMleNZW8EXjrgMOryJlXnw1dblQPj+1DTOQFrbxgf9HCtDA==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 4/4] MAINTAINERS: Add the Renesas RZ/N1 ADC driver entry
Date: Wed, 15 Oct 2025 16:28:16 +0200
Message-ID: <20251015142816.1274605-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015142816.1274605-1-herve.codina@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

After contributing the driver, add myself as the maintainer for the
Renesas RZ/N1 ADC driver.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..40af68e4c9e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21874,6 +21874,14 @@ F:	include/dt-bindings/net/pcs-rzn1-miic.h
 F:	include/linux/pcs-rzn1-miic.h
 F:	net/dsa/tag_rzn1_a5psw.c
 
+RENESAS RZ/N1 ADC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
+F:	drivers/iio/adc/rzn1-adc.c
+
 RENESAS RZ/N1 DWMAC GLUE LAYER
 M:	Romain Gantois <romain.gantois@bootlin.com>
 S:	Maintained
-- 
2.51.0


