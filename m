Return-Path: <linux-iio+bounces-25624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6BC1BAAA
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAC46225C0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53134DB48;
	Wed, 29 Oct 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gzkw2kEE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810F34C147;
	Wed, 29 Oct 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749242; cv=none; b=Eqs0efLZfI38hXIAs002djOruJjlhY8uiLxerNbmpV4uZafu5XgV4ndoDwBmfMmn48Cef7ksvO572XvfDGUVY1ejPpBwJdRNXK3yIRXRq1JcMmg1jmwxBdON9W7ZE3wa7x0ZC5wI4s/Gyk51m7GWQMAgqiVycPqyth4Q5xhjOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749242; c=relaxed/simple;
	bh=3Aa+fgQhdXLmlBHwfKVF+zrnnydGtI+5KOVHCkraqPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBeS3mauFVp+t5/0VxQD7vpt8Uat7cDHz/KSJmTlhMqXmQDbmmcP7Ih6D5ZzzrTiAhah9JJKrwSxAHamWiFNQwGvlzAhXJdTABrXd8qWKzMepFKg8wLFSHtwlaydDDGIh/7O1Bw3g7mjSwsH3QC/CcHBUA2pAhIw+9LvWexT1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gzkw2kEE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DB1E64E413CF;
	Wed, 29 Oct 2025 14:47:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0E29606E8;
	Wed, 29 Oct 2025 14:47:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB3BD117F81D7;
	Wed, 29 Oct 2025 15:47:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761749237; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qkvhfd+aBeHI1uCgJoi4uMlo/YG8LyAVwUYzHTQgZ9w=;
	b=Gzkw2kEEQEj3X5XxSDtl4tVFNKLwoXeXxslib+9dhSlg5S1cr6GK+Cvpk0oM7cEtK5mm7h
	EIRxLC03Y6l5nNsDqJHyrB8L6FZFmXxsj1pDo32t+BbF7oWei9A85uvnSZwvrOvINzjY11
	leO2R2hK0z5q8xQW7AilzEf2+9H14fn+qAq6IvYUSaZBTxTberuvVlN/z72LymvgcRhR+o
	XM77xqsPwcqDj7xOGyZrzSA7W0oXuF2ST8r15/9pMnDb67DCFeU+i7tiaB2NuK9AGl+cIn
	S8TH9F2h1jEsj4a/XYSljuOzzZogWQJqds9Ztnv45GKk084Bg+GEhrnqUVRBMg==
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
Subject: [PATCH v2 4/4] MAINTAINERS: Add the Renesas RZ/N1 ADC driver entry
Date: Wed, 29 Oct 2025 15:46:44 +0100
Message-ID: <20251029144644.667561-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029144644.667561-1-herve.codina@bootlin.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
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
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b..a67babe1a5b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21900,6 +21900,13 @@ F:	include/dt-bindings/net/pcs-rzn1-miic.h
 F:	include/linux/pcs-rzn1-miic.h
 F:	net/dsa/tag_rzn1_a5psw.c
 
+RENESAS RZ/N1 ADC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
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


