Return-Path: <linux-iio+bounces-9949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE698B600
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 09:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C41F22680
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA21BE229;
	Tue,  1 Oct 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QErAavU4"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE6199381;
	Tue,  1 Oct 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768789; cv=none; b=Rm39ku6kcQPrXVHHu6i9fDZ3RabJsqJm/tG7EaYTC7tlwYGIwdoEDTwCyJ3YI7EqxNFqoRMuxvwtClhGQtFR5qeeiyFpxK56dRWMI1WdzdDscYrEWWZA3PfdsR6QlrBxWBwn1hiYXfJ4+puuzItt7kCXLfkhsggoiepRMWXsRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768789; c=relaxed/simple;
	bh=OQHLsDN1iw6jL4I/3xW88XIawD7ma443SidcHx9JSn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egeU5hwAbEvKEHm2BoV8IHpw9j2BSqZNvImtIoB9q4KdTRk4PnPpWjYr0BJEEQcnzOhLabOtcJHAAP4KSLB+owmQxcDlXCz+/1PO1jkMu9dxjGOVkHKGzA36tMTdSQMZmXGhVpK52GnP4+l8nOoKAkqD7IjnQd42HZfg4UNHrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QErAavU4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4803C60008;
	Tue,  1 Oct 2024 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727768785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UxIOcQhCUBoG0hpvQiqU0v+w9rUpYwGwhIgjgjzyrQ=;
	b=QErAavU4bGgmBwfm1GKDMc7bJLR5gvMo//6YyCiRFxrxpQdCIYojL8eZi5GxkInx+iE8ww
	chMEsAo1glMj64xW/4Mdc+cKNI9tm6IPX+6E532xdFrcDZ7xIH1shcDb7uYT/1onK4G4Hb
	WfRmb25kNBjBO/BtayPBVgm1NdkF/7YArlSLtQMwX0sluR4XCMV3IHfi8ThO3oSX+e+sfT
	JbQA7yirALFkzZSqU2rOouj06JyRmyP3t/avCcTMtdgsan98oY88uwjXpl5yJQVtixDa9N
	chBhVP9nPGvBp0H3q9RmsSIRkIcyyIbqGG9UojN6n7uymbm8mVW2wulmteWRsw==
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
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add an entry for GE HealthCare
Date: Tue,  1 Oct 2024 09:46:15 +0200
Message-ID: <20241001074618.350785-2-herve.codina@bootlin.com>
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

Add the "gehc" entry for GE HealthCare.
https://www.gehealthcare.com

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
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


