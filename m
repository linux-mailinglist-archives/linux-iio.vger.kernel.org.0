Return-Path: <linux-iio+bounces-9952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD298B609
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 09:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04679281969
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 07:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2B1BE854;
	Tue,  1 Oct 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VF1/RNVw"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C71BDABD;
	Tue,  1 Oct 2024 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768791; cv=none; b=dPMeIZWM/6kNXFnS6uZwMQkbrKQ9H7OYDlGhydLUy0Pbt8HMtAr9Nx79kWSB7INS14tM6/MHUnbEomKkHWNvyfpmrRDzRj3SM6pB6gQ/xZOc+rpPYebRiMuKhEf7C1s2nr2AjAS4itcthBdHqumArM1kQ4vl6GOK7OWXEX6pnBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768791; c=relaxed/simple;
	bh=xVMeWYU/7u8N+JkMqNpLyTIeMLPk0k5JmmbHLxsRXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJrdMkvduQhTPFWl1ywGxPTpfUxyWsASCkLKB265/tLDcRsw76a4x39hsYEpPhCQbywX83P4I+3poqv2MSfIfDZC60eVwq7MxQgkIbxQFoTtLECy5AklKvPJltXDnz3VBZ/fBdSWadIA5wkK21AK01Sh8boK/afl7Q0NUVXiK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VF1/RNVw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 69C7D6000F;
	Tue,  1 Oct 2024 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727768788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCdCLmjll011m/jFo7l9/0Pw1jKpvpgArMBOE04lTx4=;
	b=VF1/RNVwhbNNghPpciSujFLfwsVRiCl8T2zeq6Rn3DVYjOeRcMTJQA3GC61yLlitSTImC4
	h5GW4rO/FrqPa/Cv45RB1zGoYSFrdhqp+AHciN4Rkx3dRTFMIxzXpi+nwyUpKu+k96fA3V
	x0PwXx1oCXua7Y83x50gMD9kSZjUNNUtDavwJ7RDJNhJcZihBNuEgHfBfpwNEjqBf5I+10
	zYqdnkmYY4HkL6P8JtHJEiUSW8VyBN3V+tGzSEpDOlJIhCYWbahtQ6n3/y9qc/v5caNem7
	ivTfNOcbRhblRzeWdeAw88Mx3fb0gKtOfgWIk7Jpk6VbLu/BsQK1CTvb2xb28A==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 4/4] MAINTAINERS: add the GE HealthCare PMC ADC driver entry
Date: Tue,  1 Oct 2024 09:46:18 +0200
Message-ID: <20241001074618.350785-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001074618.350785-1-herve.codina@bootlin.com>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

After contributing the driver, add myself as the maintainer for the
GE HealthCare PCM ADC IIO driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd288a97c770..6cccbe4e3d72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9459,6 +9459,14 @@ M:	Kieran Bingham <kbingham@kernel.org>
 S:	Supported
 F:	scripts/gdb/
 
+GE HEALTHCARE PMC ADC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
+F:	drivers/iio/adc/gehc-pmc-adc.c
+F:	include/dt-bindings/iio/adc/gehc,pmc-adc.h
+
 GEMINI CRYPTO DRIVER
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.46.1


