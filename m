Return-Path: <linux-iio+bounces-10030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC0298EE6F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F7B1F244AC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1C17BB01;
	Thu,  3 Oct 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dnCF9Ntr"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0516DEA7;
	Thu,  3 Oct 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956013; cv=none; b=J8StE1ve1BmWdXFq34p9WdrbEyRI12ak0j+IkRyhkFfCCngwNyehzOqDQfBIcPTyuSKxcmw6LQxEpeN0yc5SXhHpPApVwqetTOlC+KG13Oqiqc0vz3gS6D9iHlPkhGva0bPvL2fXyDP8L5fQ41+5ai+ckQYfzF1kMyMjc3NanVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956013; c=relaxed/simple;
	bh=xVMeWYU/7u8N+JkMqNpLyTIeMLPk0k5JmmbHLxsRXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhiYcXhk3YYMdZdCX0zvogS4LWwvgpsumNu09XQgpL5btSEslp92JtRxkpcq5G+CcqXl8aNW13arLtX58cqxJey9/SqDV+YiCxNwVqj4dBYJJb9udBrT2Fhdn9K1fwqs5m6eONk4yfyP0299ra22DWyLwBjvKfZ5WSl20lsiCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dnCF9Ntr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 21A54C000D;
	Thu,  3 Oct 2024 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727956009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCdCLmjll011m/jFo7l9/0Pw1jKpvpgArMBOE04lTx4=;
	b=dnCF9Ntrtl8ssIlvAcW1C2xEvv3ESq+Pif0PH2feKFPwNunkLtj6EAxHQrq6mAEaXvyDHQ
	fsHOzEnIHc4FeFmcXBJs6YxzmjZcJ3ibrsnaNAsCXLx2OY+4PepBpXosdodCeK2J/1+wt5
	mavImEDi0fx9BW8/PIiN+nCJkcovofPheJ+WzhdpC9/jkly4zPnSzGNKxLmnk02rw4jHGC
	snQD/bua1NJttufZqLpWsuLlg39OTuNtskuR8pTN57pYgIVD9xLSTfiPXXWJ0xlDH9M72F
	v+ax0hzQld/pMMnxi9Kwv99jYS7VPQ4PDcD4MxXf9Fmp55BNRru8j4QDMxl6Sw==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/4] MAINTAINERS: add the GE HealthCare PMC ADC driver entry
Date: Thu,  3 Oct 2024 13:46:41 +0200
Message-ID: <20241003114641.672086-5-herve.codina@bootlin.com>
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


